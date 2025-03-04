Return-Path: <bpf+bounces-53163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83EFA4D360
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1553AB76F
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81D1F4736;
	Tue,  4 Mar 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="16t7dWnd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4371F4264
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068259; cv=none; b=N3FVDTsGQF9LZ5P9OTIG3bBRvdaSuvG/7kXLk6c9DhvkS0m3F+7TIslXC/OX0djKcCiBGoCZdoFGi148nHD5X2kScQZR4KpIDyeNvxujn3/REDipcAJB280g1Wm71LV6rNsq/p6BX7tBNxC6brn4XG0Q2EJNAe59bbZOnyJYx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068259; c=relaxed/simple;
	bh=mhRvmZqgWdvLJYlas6Dyo9C2SYeBoyRC3wqmkHKeWgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1pEk1/L6ZchOfSjUk4W8z1ptk1YlKlwafTZHxcHBKUcL3FcCGR30isj98cclflnOqtI7xMLAal97ChilGwHKxooOYi4I4Ja/ZBG3ky4zWveUA3p+htQT8RKQhzEkfU0250lnDEG5KKdXYa88qPEoX2mm7EsBmo5cWY1zk7/qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=16t7dWnd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2237a32c03aso79105ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 22:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741068256; x=1741673056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAYlIekbsytWpG//ym3d1mjAZ0z0kh8QARPEq9BqGjs=;
        b=16t7dWndXix8Ut8iNXuQL+ZFrIZ146QfoGUNMkX2ENR77zH8g/8JFOumv07SKLBngc
         /lyI63nAgPqF6gm9gDl3WtbwR18kaZM1se5P5HLOFtrBAtcD521FCP9yavHW6aibSPhl
         eMy/FZmbWya3SapSgsj9OzlXOrg4UJQiRT+7B+1oWNT7osStqnu1d9eBEGiFKeqhD9MQ
         OuyaRHlaDGJPpEBTD5l1PIuGkQAzgc2GXgVp+px9hHbiQZoUu2Z2b3KJutfWHv6DpO0g
         yZDyBbVGsxw7W9GGyR2f1onF6W+Mr9DDeNkI/0+Z3Xi4umDG015wG/2D1msG7y9tCPdM
         aZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068256; x=1741673056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAYlIekbsytWpG//ym3d1mjAZ0z0kh8QARPEq9BqGjs=;
        b=fiM45hrMak14XXBSA/sRxSLtcS21QA0gGPzM5nYzgeBnZmEhugXiGFNDS4tgVb+ZWr
         7X8AlL4eWENwJsbf1wnKR7huOOOvLER9eKjiMcT1r9HZMUWDPI3HDd8BH6q7jNIvATpt
         mhcNsAHTKek5Ue+NbgC8rAevsQx5WxovUd2XDJe/sFcljkkCBlrh2MvKHbmH8wry6kfN
         PELCY5648PxVfECqZioH5+uy4IykSNupko75SxxbyzPkuAahaAzndWaUszrcYVmG80cq
         7f4bp+zoBgSnhzxjb6E3Mf7+ozbU6IfJAGENorWB9hEiUcprb7cS2DbCMbvLWMrySDax
         75xA==
X-Gm-Message-State: AOJu0Ywm8chwyLFmbDUdkszUMgbReWbYWojatjv8y2+u3TpwT+IEmXMD
	byWcoOWNmw5OvGQanM/5cah1VhwoSTCiaOzjvR10v7YV3evU16Wi3+ReJOj7Pw==
X-Gm-Gg: ASbGncuMeqy4cq5YABwUdc+wAhqttEoF+kS5Urh2vuCh9C6ulPVM/dFx1xRI1InAXPd
	NCx7XEfz9w7g6YH4lqe3G4D/7L82ah4lD3sNFz3KRSU/mmngqx07h7OcxDKuABgesmurT2sNsOR
	zd1bg6nbb7FHOujmztqVRtp5jpQRa66rIXKw0CDfCHvEHkhqzEkjUUheMxmowZghYfOVNXe1j1r
	Pp5u/pTSi1EiERAAhNhJG+tquhFhu1atR0Zmc4Owc1CMgLkEkRAc8UgBhRIz/nUe8Xc/PFG1/ze
	cEf3gPgMRrI6fgSNhWthnAU3HQQbcd8fTFaa6h3QutZZ9eLFrg26eUH6AH6YF/5QnE7lrDdd9CA
	RGzwga1k=
X-Google-Smtp-Source: AGHT+IHqKnibT1s5HFFAINhOUWrBIEJxBR8aCf+9habHUqIWadTtSdR+nmlVUa1RzzG2S+S6SNMC4A==
X-Received: by 2002:a17:903:2b10:b0:21d:dba1:dd72 with SMTP id d9443c01a7336-223db3fe05cmr1287665ad.15.1741068256111;
        Mon, 03 Mar 2025 22:04:16 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363a0f88bfsm5510505b3a.24.2025.03.03.22.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:04:15 -0800 (PST)
Date: Tue, 4 Mar 2025 06:04:10 +0000
From: Peilin Ye <yepeilin@google.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	ast@kernel.org, xukuohai@huaweicloud.com, eddyz87@gmail.com,
	void@manifault.com, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
	paulmck@kernel.org, puranjay@kernel.org, iii@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, catalin.marinas@arm.com,
	will@kernel.org, qmo@kernel.org, mykolal@fb.com, shuah@kernel.org,
	ihor.solodrai@linux.dev, longyingchi24s@ict.ac.cn,
	joshdon@google.com, brho@google.com, neelnatu@google.com,
	bsegall@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 0/6] Introduce load-acquire and store-release
 BPF instructions
Message-ID: <Z8aX2j2WYd4DlnCH@google.com>
References: <cover.1741049567.git.yepeilin@google.com>
 <174106503648.3866937.5658954004964289425.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174106503648.3866937.5658954004964289425.git-patchwork-notify@kernel.org>

On Tue, Mar 04, 2025 at 05:10:36AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)

Thanks again to everyone for reviewing this!

Cheers,
Peilin Ye


