Return-Path: <bpf+bounces-23188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B945E86E9C0
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE27BB24DCE
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4513B1AC;
	Fri,  1 Mar 2024 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtZIQiYs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111A5C9A
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321947; cv=none; b=KDIZkKodPGTp4LIumbaPtnCcxK1Q9IRgixd2epO1kFNgq373zvS195kb2xvF622nras/TsB/8x+FVBrj+tnG6eq2s2Ahy/avQmGUv94tMTFMGaPv6MffTCE522kOZVdvZW49GV4j8DKbtEjPXcgKdih2ERN+9u7cIweu3g+Kq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321947; c=relaxed/simple;
	bh=TA9INyPTp8hBtbhQya5OVll64VR+T+tTyWZ0doMvR7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q6WdYSsw7Rb2m7AcaJxAPCzCmli2J/yRJNPfJxwnmEMOLlV753QF6E0eDJlOEaz3z6YiYEq7BGkds5wnG7YTIDK6c83dQM8431tPydZ9PTb50EIUKBPILxfS8TKQBScMao9NS8TIRi1JcK574nKZibfJzHq+8hcreH8bTPemUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtZIQiYs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608ceccb5f4so17496677b3.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 11:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321945; x=1709926745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/Isnh1r+cpJlCdcmKCvYos6N2NVtAy82iBPOlWqgME=;
        b=NtZIQiYsMZEAJYWmEk+sVi+xN67syP2uluS2WR4AXRTSyElD9bAdalOBaXcQpe6bnx
         NBVtlnDceZqMMbUCMnTYD68s+obejPXVV2rL3+in0V3uvD+a24HJOzpSEKuvG/O6nEHf
         VD00zbTRsU53s+dRp3avn4WbM+bVb7qtguQ0lYPS+HFRpuOFH33Gh+ygeBCCg+YNZKHJ
         WpwNVqA83jaxdKCew/t/j55q0LFYBL1tjOvBr8LvA03700w3DaQH3GMIshIbE4NBPK2k
         ZUs2WHTl7s8GSrjYfXeRnu3N/dcSwikLiA7NKOMKlTHH3vxW4dwX8N+UJQpaeu+vs+4D
         BKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321945; x=1709926745;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/Isnh1r+cpJlCdcmKCvYos6N2NVtAy82iBPOlWqgME=;
        b=gwNe+x1RXgFmTvOHR3rEyCQc1ORCErMJ0UEgKJtEBoOtCTPODZJQVhxqU73lR/nQhb
         lYceq/MffbxVsG66BajSPD5Ner78u6SEFz0v9o0Pf2W8yUd1Y7qH/FgOxL/2HZlJxEku
         8WQXM3jrYE2J/Yyf5NmRhM9abGwnla6yCxyn3xoVuyKd3VEF4Bd4dE+UbuiXTrToN4f2
         p56PXx8sL9iMmLcPAZTANbfEMqqFGoNgiC+gUbetEidaQLuWeGddEquayYub6nv8dElP
         3k87Ys4zlksM/8DyEq8fkN++SgC66jOERXUYTWcTxCLP5gfqakOPE4uE9UmI3dtowV/F
         AWjw==
X-Forwarded-Encrypted: i=1; AJvYcCUqR2ZJEzTwbGZLJ2w8C4uqyaXGf/cixm8uyibl/0TraUWCC42fP6il0u3tmgPv+CX/FYuhPGUAhXVyeLs8LaeQD5lT
X-Gm-Message-State: AOJu0YzuW2u3RtNdzqOxQxK9bWJ2kO5aFURybqIVEZ6XVhZW8GIavU7m
	6RJDxZQQEz4Ynp7ZVKSOsNZ4kk/G7GvcGb55RqxfCCC4AecfjvseE/YBoZwc
X-Google-Smtp-Source: AGHT+IHDYuA2vchNEraZQXEDK7FmfGMBL4DuwOwrvQOeWOZ4lep0/9NRQRPqb0X7GbANTmHfqMQuSQ==
X-Received: by 2002:a0d:f483:0:b0:608:13ee:8f3f with SMTP id d125-20020a0df483000000b0060813ee8f3fmr2829181ywf.27.1709321945302;
        Fri, 01 Mar 2024 11:39:05 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:997:2bbc:b035:6e36? ([2600:1700:6cf8:1240:997:2bbc:b035:6e36])
        by smtp.gmail.com with ESMTPSA id r10-20020a0de80a000000b00608d62071f4sm1114238ywe.8.2024.03.01.11.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 11:39:04 -0800 (PST)
Message-ID: <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com>
Date: Fri, 1 Mar 2024 11:39:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, lsf-pc@lists.linux-foundation.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <ZeCXHKJ--iYYbmLj@krava>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZeCXHKJ--iYYbmLj@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 2/29/24 06:39, Jiri Olsa wrote:
> One of uprobe pain points is having slow execution that involves
> two traps in worst case scenario or single trap if the original
> instruction can be emulated. For return uprobes there's one extra
> trap on top of that.
> 
> My current idea on how to make this faster is to follow the optimized
> kprobes and replace the normal uprobe trap instruction with jump to
> user space trampoline that:
> 
>    - executes syscall to call uprobe consumers callbacks
>    - executes original instructions
>    - jumps back to continue with the original code
> 
> There are of course corner cases where above will have trouble or
> won't work completely, like:
> 
>    - executing original instructions in the trampoline is tricky wrt
>      rip relative addressing
> 
>    - some instructions we can't move to trampoline at all
> 
>    - the uprobe address is on page boundary so the jump instruction to
>      trampoline would span across 2 pages, hence the page replace won't
>      be atomic, which might cause issues
> 
>    - ... ? many others I'm sure
> 
> Still with all the limitations I think we could be able to speed up
> some amount of the uprobes, which seems worth doing.

Just a random idea related to this.
Could we also run jit code of bpf programs in the user space to collect
information instead of going back to the kernel every time?
These jit code should not be able to access helpers or kfuncs, but they
still can collect and aggregate data, store data in bpf maps, and change
behavior of user space programs.

> 
> I'd like to have the discussion on the topic and get some agreement
> or directions on how this should be done.
> 

