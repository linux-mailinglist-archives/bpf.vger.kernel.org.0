Return-Path: <bpf+bounces-59711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F0ACEDAA
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42331189712E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358FA2165F3;
	Thu,  5 Jun 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cadho1/H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7D14E2E2;
	Thu,  5 Jun 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119419; cv=none; b=hVzhme5eOULuGGWReuvGy2QqVWhBRcCLv9TYNFe3U4wFvhfUoonRGOprRekYjVl4ifvnn9dS+I1mhHXDFSW0Y8PLWh/JIoFxml/HEdkci//aAku1Lldqta/6MZBA8qH1XiK3IFuS8zz6D7hcCBVRUnNLht/Po2vdkwALa8jDHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119419; c=relaxed/simple;
	bh=l1KUqcIKNRVgFpunWpT3RLNAu8swUIwpPosrl4iu6js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ2UX7voU90KINjIRmS1ai1U4HvMMuMpppZSQ6LWSz/L/248KvOUQGUqXYiTZ8ihv/ymYgBUKXVs+3OGOMVrQdsKV2FIZwCjOVf5bqMmr1cjk/r+A3aZgLvljFz8KlbueX1bYj7JpbT0uOWJfXEzUnviNsnKv8OG7T29OOYdmkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cadho1/H; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60462e180e2so1513956a12.2;
        Thu, 05 Jun 2025 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119416; x=1749724216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzF4qinSSH/TjUCc46lpQ/0o2Oxn7Rkbx0fYFgGSCCY=;
        b=cadho1/HMl0lKbF2MXWVwnQwyZajgjOjKW2N58j21Dw6eTF0uqt/Cj5nJqLBhrDBBO
         /ln+8Mn8IYz64UFmhOgREq1lcJ8TahzJ/9dNHnmZKXrSfIOzdpU3T7KGlJcQ1JoC9/Qa
         MkKe0bC/e2NtwOtkQR58qHZKhcsL5AaRpGhNXp3vQSx2ionXmgX1SeguA5MCc+U2SBV7
         npw/v5hhBLZuFAsk/vUAGV2Km7hmcRSwyQABnG8G54wVWXEhJX1fk2rXZznis7vJAS0n
         MSM8R02CK8P62WkfM0rSi/nN6YPwjpHOiO9ixGPsTKspK4CYW8nqgOIw23cbxkkrmJoD
         ftQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119416; x=1749724216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzF4qinSSH/TjUCc46lpQ/0o2Oxn7Rkbx0fYFgGSCCY=;
        b=NibFcraUztZ1TEYXJ7Y6fMMC1ZKSNHzoisCFaBgO2zwESJbC0bvU4dQm2um7Y92dCx
         JJUfknKbKUPHDKjaMH31k3IBdkAP/W3Cz4yEaxkI5JM1ohS24Q5M5ICGWfUh47V8qH5r
         DAE9PinuWSllxFpToo//s0TELWixDhNY/FL0DDtTecKPusg9u3DAQ7tQLc9pH1XG8xcR
         Jx/FKF7NPKH6rJJ8PI0kOc+UPMipsg9lo0i6F8KBtZm9RxT05O2QFG1YutFurQx0SR3T
         raOkvVld4LoubxkKiqUIA+q1SXIfwkthaFWFIyLkKGdp7Hc8AuY/p4UOZa1bfzsckVZ7
         iQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEmZFBYacdfpuvl+TaGPv77v/0BqMwDhOn9+xZPQuaLP+65IH6h7qkgl4gg6Yca2NYMDo4gx3TPfweQA==@vger.kernel.org, AJvYcCWvjEa/ERbxcKwIaN44ua6FGdb9bYdW0GDgiBptg5u31Ihgmr6oIhCtFxWz9KOZcO92yJiCu1DD@vger.kernel.org, AJvYcCXSv3+Fm8fzMOr6gYod7eDlsSkM/ZRBVpMXyulYvAdWTMc7VA3vsen6ieoXzsElyRD/9/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxNeVZ5JnFdRrXVcqNJjmazoHvguRH8h/O8KUvoSx92x/vRnj
	fhv6RWWgMMFRhmUPOZ7WnfjNYCgoQYSZt6XpknrQWsc7MwTgVuib5plq
X-Gm-Gg: ASbGncvlTEM0NVBDPsd+KNDJR/4a76goC93NgSMkBVje00z6+ZsItGpy389FI+6XFwa
	NlIz0fVIphgRdhsYWsCCS+m5kdaTBn7HsUMpuz2fJ9SgPuum9aVWM/r2h5KVqPbP7NpKvJNjnzx
	gPyWKogw3nGxUr5N7S/es2IvWv/EU5fJJyuEQ1BzGWd8UGb09lDszL/uDkyimkY4Z4DBbGqRqLW
	vRlv+ck4zXaeSA622yXQ2Ziqcru1beZJa0ZnHxAglZ0EzAvIIAdtU9XDta7XX2KC0s6E/HyNUri
	E/5KaxWWIY3+OdixxqRPsrKTR7XIUMLUdPBhxWt7X5kB4MpacqwC9193jMa8dwLR
X-Google-Smtp-Source: AGHT+IHWL1yknGnlKhpA9ge9CaoE72Wb5gazWjo8gOOfIKsK9ZOhRNRZ7RxfcVsnaXFOYbuQPfju8Q==
X-Received: by 2002:a17:907:3e05:b0:ad8:9988:44d2 with SMTP id a640c23a62f3a-addf8cdc1b4mr569126866b.20.1749119415941;
        Thu, 05 Jun 2025 03:30:15 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fec76sm1244820166b.20.2025.06.05.03.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:30:15 -0700 (PDT)
Message-ID: <22175e81-f708-47eb-99be-5593e931ef35@gmail.com>
Date: Thu, 5 Jun 2025 11:31:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 06/18] page_pool: rename page_pool_return_page() to
 page_pool_return_netmem()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-7-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-7-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


