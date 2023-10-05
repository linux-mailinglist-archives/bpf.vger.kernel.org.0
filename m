Return-Path: <bpf+bounces-11447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741937BA1AB
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 01181281F92
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1572AB52;
	Thu,  5 Oct 2023 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUU3KsJC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1728DBE
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 14:55:26 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4FA545AB
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:55:14 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a52a27fe03so457972241.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696517714; x=1697122514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4sb1q74MArJrmg1EnidKYrw9CtEuXNYc17Dl5pGnnhs=;
        b=CUU3KsJC3WrgCxD+RmPXC8p8Mf0x5KNL4WnVcHAE0ucdUCgY+6bRZ5F2gJIoYvH6pm
         +qVoBHappagOJtszBX0y9/pvitpvnZoLbqYm3K8AOUFs9vmeUTMjBU/QCU+j80fN7Gza
         fnEREHx/zsW5lGbHTdhK61VchqKVVOVV6fByZrFZ9/z+sLyBYtbQUvgY2B7mZOurCxd1
         EnEOxFwETPUVd+E1+gsCLgqnLSKTsZ1IpXTlh4sfVUP2y2u22BDf5UWDlFkpHq2yyp5X
         lPZd9QYr6jclnidY8uNxtSPiFlO3p9LvbR+UAsnDeWv4yDiiIk4RZ+29klJEnBd5wLc+
         apIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517714; x=1697122514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sb1q74MArJrmg1EnidKYrw9CtEuXNYc17Dl5pGnnhs=;
        b=m72+XMYHHV46hhIPxUu4rEGGYT9b/Mj/jkoNic9QRbD5jRInctaqZizsXdeXU87GUA
         37TcCy2/Bf7JSP46pI4+XMH01jRR1LjCs/fFNUkbMMQ2/6OsYYsVT4F3Y+/k+D8L3/6z
         dQghBzJy7AqM26sKha0nj0NoajO/bS4cJEeKYEugek7Ku/nceS2jHDzkWMtrDpncbSPN
         ER9qj1rbTcCn/KfnMEob3S3f3rFs53wF50y4Q/DS0Gp/+6Ek0Z+z6opKzx0DRTEvz/LR
         IpoN5amliWjaRiJPAqS75cvPqkib/t9+rCGa63lqFepbTBxrQiG3T/Zgk1gGirTts6Gn
         lvxw==
X-Gm-Message-State: AOJu0Yz+mRuYdTVoOw9kFkX/rvf0UflBzlXHY4eabxChOq8Goo9rybVe
	UPdoexH0BzU9iEzo2rf+RsXgTW8Kf+YQJ0jGscEx7w==
X-Google-Smtp-Source: AGHT+IEO+WrPrzg8wdQMFzOvFJCD6a5uz7Ox65W+J3MpViKFb5GfWKQNzse/Kl9U7x+Y2TA3B2fv/zljaBJT0SI57W8=
X-Received: by 2002:a1f:a9d0:0:b0:49d:92e0:9cd1 with SMTP id
 s199-20020a1fa9d0000000b0049d92e09cd1mr5188264vke.11.1696517713597; Thu, 05
 Oct 2023 07:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004175229.211487444@linuxfoundation.org> <CA+G9fYuE9Pu3QCVDywA8Ss-41jVfiy2e2kpxjhpTe3CRgmZkBw@mail.gmail.com>
In-Reply-To: <CA+G9fYuE9Pu3QCVDywA8Ss-41jVfiy2e2kpxjhpTe3CRgmZkBw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Oct 2023 20:25:02 +0530
Message-ID: <CA+G9fYvHPnba-0=uGS70EjcPgHht13j3s-_fmd2=srL0xyPjNg@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	bpf <bpf@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 5 Oct 2023 at 11:05, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 4 Oct 2023 at 23:53, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.5.6 release.
> > There are 321 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The following kernel warning was noticed on qemu-armv7 while booting
> with kselftest merge configs enabled build on stable-rc 6.5.6-rc1.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> > Hou Tao <houtao1@huawei.com>
> >     bpf: Ensure unit_size is matched with slab cache object size
>
>
> bpf: Ensure unit_size is matched with slab cache object size
> [ Upstream commit c930472552022bd09aab3cd946ba3f243070d5c7 ]
>
> [    2.525383] ------------[ cut here ]------------
> [    2.525743] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:385
> bpf_mem_alloc_init+0x3b0/0x3b4
> [    2.527241] bpf_mem_cache[0]: unexpected object size 128, expect 96


Anders investigated this report and picked up the following patches to
solve the reported problem.

d52b59315bf5e bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
b1d53958b6931 bpf: Don't prefill for unused bpf_mem_cache
c930472552022 bpf: Ensure unit_size is matched with slab cache object size

- Naresh

