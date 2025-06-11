Return-Path: <bpf+bounces-60326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B36AD5899
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E7C7A377F
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CFA2BCF65;
	Wed, 11 Jun 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3ZTKswQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BD1E485;
	Wed, 11 Jun 2025 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651878; cv=none; b=FouxsjJVtaTsG4BSsav4XKLU6cFqKrA29ciidCFht7HlzWzz00V1GGKahHRtAk8Pl2MzF1xtJOQGJovxa5aur0WEHAEAQZZ0A1/magfrXqEINwGj4odfGecVsFK8WUTaByjDkGkfhPssZnXuQhGBbOXetajgRuaOS/ZzBPfDqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651878; c=relaxed/simple;
	bh=zhuxC+KhjOVBwtC+ZikFTxVlNB4jrxhuaXaa+Xblpxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwt9Djr4F3H3Xz74c3JUOEB1vP4DJ8wnUU3uQD1qYrcm8gdnDzINKGt/8f9VLWPDIWrCxhijtokhdA/XPk5JFtnYpIpv4BpiKU/4DpjEL4RTfXBMHLupYa04d7779ncjUNNK7hkE/Zgg1asvLNujHkQcxbg7bpIkrnuScBAXZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3ZTKswQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d3f72391so87617065e9.3;
        Wed, 11 Jun 2025 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749651874; x=1750256674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTXKRBFGUAka08dub7+UBA5yiZf9fur0UOXcxOoy2sc=;
        b=L3ZTKswQ5gCyfLURktJlabE68b4ktLtGrsOLVSGsn3ltwcsNMDcao4qi6ei7bDr/p6
         9znCZxe78JZ5f9tv6L3RxqgLIbxdw7J7aMAnKDyacNy1hT29AOsQJhMQeXz+eCdv86sG
         QLVcFa3TDmupxTiI2GiyyRmMKkUcjUQ3bSKHrzBUBdZDJmLT1qH89nSrP5LsWxkCHQA5
         mNTXRM0GBgZFjc9COUguqZYyb+jXXF4gOHHoXsfLdSWOZPMJq6yh/BK2iFUV+CMDSnuB
         0av/gY9jSovttr/wYx7TBH2SNWfBBxHyTDW5TcCu+JcaAurGNAwEKSd4jzz1PcyPYLWP
         /ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651874; x=1750256674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTXKRBFGUAka08dub7+UBA5yiZf9fur0UOXcxOoy2sc=;
        b=mQmERdfe5B6ayEEsrsJJ9L6gcZbZ0/yWAlRPd6Yc5pAS/d8mxTp63nxOD6/AAptykO
         ExWuK5iibIhct/ExlP7eCRphOAdluE6kfhSNxNDXJWPDHyGRfAObQczShzeBdAnDaJPY
         bktPKLLjMTSCyQVDFzI7DnxBItUQaJNjL/cet78yBBiQZk6N8OdF3PmmuyzLjLujPi8B
         8zF6bT4AL1I/HG2NNU+SRbS4ucQYOd48n7tIEVD4a4oe7C6EcGKs+sHk/aiJl4D+KRVE
         H8aSXIHZyck1D+aOw0wr87b8PHcjtC/DOrxf6LXlrrg9qRktozIYuzcEd2bJTSQFFoUc
         N0iw==
X-Forwarded-Encrypted: i=1; AJvYcCUo936QnRflxbbvBf9CVnUtLdaPR4ZjP5N024t//zzIEZ6GpVXHzYLSTvZOXtPLdIa4fm/hYQFn@vger.kernel.org, AJvYcCVCdrfvZlg4nAT8QDm1aXkKX4DpT83BU1z0GZd/0vWylBKO7kGMAhHjO7rodGv4CJ+OQxI=@vger.kernel.org, AJvYcCWcDGfEN7hPR9Hs+clf4Ei21i+wXrBWWcr9Bhs805ZBbP/byQKrxUBLaN1DxEuCFohLh6cqR1iGhgPdzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7doMNuV5IXs8LKxwBCr56+etY6m7A7EWbHLwfXJ2hmGgNLvOH
	YP06o6/PJvVUbzwB0ccMnA6oKf8M68gvGT3/XjTV2x08MrewiQabxgPV
X-Gm-Gg: ASbGnctOqWXtDcykqLE2p+YQzWeDZZzCwyFXfb/7W/GDhoFPswcnbUzfhxJJdGFKmin
	aTwRsDCCYaqywLyYYKJrckhfVopWyVEZ2uWk4my0Apza3KuouAWicIakwmFaBs51gDwWbFxDoah
	YlRQy5vUnYdZ4GE51HuVw4IriDirTWN9e6YVbt/lOovtaBz1IB5QkMfulG0LPPrEODb87xT38H6
	FSh5mpM7FDB7EdDT4LVaKmKlPCfuw8oFQcThcSZZVDXm692VA9FrCEY4RLqHdXQjzAnWePg+Q/p
	GxyIMJ4ZGVrnb0YVigyfw9TW8XoEKm1UcfEkWSK923mINOlR9Qi+o0bZaAovXpNBWWOfdik=
X-Google-Smtp-Source: AGHT+IHoeACtZ7Lq1d6rrqu6tvHRqZvx/wZr02IW/ChCWd4ssRnTymEzapp3q53gv8ZTjy+QowM5Nw==
X-Received: by 2002:a05:600c:3586:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-4532b8c5658mr22745e9.5.1749651873795;
        Wed, 11 Jun 2025 07:24:33 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.145.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323a8acasm15187999f8f.26.2025.06.11.07.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:24:33 -0700 (PDT)
Message-ID: <8c7c1039-5b9c-4060-8292-87047dfd9845@gmail.com>
Date: Wed, 11 Jun 2025 15:25:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] Split netmem from struct page
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
References: <20250609043225.77229-1-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 05:32, Byungchul Park wrote:
> Hi all,
> 
> In this version, I'm posting non-controversial patches first.  I will
> post the rest more carefully later.  In this version, no update has been
> applied except excluding some patches from the previous version.  See
> the changes below.

fwiw, I tried it with net_iov (zcrx), it didn't blow up during a
short test.

-- 
Pavel Begunkov


