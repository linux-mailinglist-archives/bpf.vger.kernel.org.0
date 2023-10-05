Return-Path: <bpf+bounces-11421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCB7B9AEF
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 841BE1C2092E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 05:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E64A2D;
	Thu,  5 Oct 2023 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRKR344O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48A4A2A
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 05:35:18 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD165270
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 22:35:16 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b0e19acda7so230746241.0
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 22:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696484116; x=1697088916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/LQ+X+x8kIqTkVd50ogLWp0VaSEkcS2ypomcdLaAgP0=;
        b=HRKR344OmuVWhytU6DzNKf+MPwLpppjOMBdea3pGdCoarPxHlnNKLjBlDAd3pV0pYY
         drzHsdf8mP+SGH9Pu7J9JkLfja8LseMUe7Q0ILOxsNkEta7RceNPLVCyYt9/C1DQza4j
         S7gVMuQ+kT8yC7KnR//NZx+OvlyX0zLjjyhfv0wE/88/s9uLFyjZ+wp5/En0j4AXpFTj
         heizjGqyxt8MlRZZhIg9KSSDDNw10hCrJSqEVNFgU7iKPB5v7fczClm2t9hvMKE4oShm
         lqrmS/37NxLYNdo6Fv0Wx7nIvO/YjlUivsCa+BflON5jrJEPjwQ7pekMvo1uSfLyGGWK
         5sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696484116; x=1697088916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LQ+X+x8kIqTkVd50ogLWp0VaSEkcS2ypomcdLaAgP0=;
        b=r+PbJEbOViDwM98HnyWcuRS0TfQFoFkRDPfnPSNKQ10A6Ls8f0pDCM8DAfFrn4jGc1
         NmnwTjuvjJH/aqUtl2nqdaxQQOErNSGJYn703871ndf9KsuPG98PH42WBTQwUj2bzmsh
         +j4N9WC5BZyrYkkhVG326n0b9whsp1YZb+Ei4SG+XHxPD5n/CXjFLNUJBHxf12BoYbI8
         xaWmI2WwidZo+oRWfBZSk2zziY/d3BAo+8yZrlxxN0w+o5vupSy+Fq42yc8apo+vxtvs
         S58BgU3lDWtwDmtTY49D7/747/KZBjql6g1KVKN6qu5j0Xk7GedlQbOaB+9MLGMo3WJ6
         lZ/g==
X-Gm-Message-State: AOJu0YxM/2ocfG3wAMoix73pUBcAr4xBMNjNhVxRuZ1B2oaf8wxjBxg8
	37Kak6D8CgBK0PzWrtyVQ7Ko76+xqpHtthiczIUV8A==
X-Google-Smtp-Source: AGHT+IFyUEy98cMidc1tr4QnSypHpNlXUtm1aI5nwEWjnjVyHJ6lFX/6zV9UcK6yLBCnVPD0b2cF/SGIK7DsUIDhFMI=
X-Received: by 2002:a05:6102:282a:b0:452:d5f6:cf5d with SMTP id
 ba10-20020a056102282a00b00452d5f6cf5dmr3993630vsb.32.1696484115747; Wed, 04
 Oct 2023 22:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004175229.211487444@linuxfoundation.org>
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Oct 2023 11:05:04 +0530
Message-ID: <CA+G9fYuE9Pu3QCVDywA8Ss-41jVfiy2e2kpxjhpTe3CRgmZkBw@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 4 Oct 2023 at 23:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following kernel warning was noticed on qemu-armv7 while booting
with kselftest merge configs enabled build on stable-rc 6.5.6-rc1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> Hou Tao <houtao1@huawei.com>
>     bpf: Ensure unit_size is matched with slab cache object size


bpf: Ensure unit_size is matched with slab cache object size
[ Upstream commit c930472552022bd09aab3cd946ba3f243070d5c7 ]

[    2.525383] ------------[ cut here ]------------
[    2.525743] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:385
bpf_mem_alloc_init+0x3b0/0x3b4
[    2.527241] bpf_mem_cache[0]: unexpected object size 128, expect 96
[    2.527897] Modules linked in:
[    2.528721] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.6-rc1 #1
[    2.529525] Hardware name: Generic DT based system
[    2.531279]  unwind_backtrace from show_stack+0x10/0x14
[    2.531684]  show_stack from dump_stack_lvl+0x48/0x54
[    2.532220]  dump_stack_lvl from __warn+0xd4/0x200
[    2.532878]  __warn from warn_slowpath_fmt+0xb4/0x168
[    2.533516]  warn_slowpath_fmt from bpf_mem_alloc_init+0x3b0/0x3b4
[    2.534133]  bpf_mem_alloc_init from bpf_global_ma_init+0x18/0x30
[    2.534911]  bpf_global_ma_init from do_one_initcall+0x118/0x250
[    2.535594]  do_one_initcall from do_initcall_level+0xe8/0xf4
[    2.536016]  do_initcall_level from do_initcalls+0x50/0x80
[    2.536618]  do_initcalls from kernel_init_freeable+0x90/0xd8
[    2.537220]  kernel_init_freeable from kernel_init+0x14/0x1b4
[    2.537634]  kernel_init from ret_from_fork+0x14/0x28
[    2.538271] Exception stack(0xf0825fb0 to 0xf0825ff8)
[    2.539230] 5fa0:                                     00000000
00000000 00000000 00000000
[    2.539792] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    2.540497] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.541682] ---[ end trace 0000000000000000 ]---

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257234/suite/log-parser-boot/test/check-kernel-exception/log
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WJGm4kyWj47rr0KEArH4BwqPCs
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257234/suite/log-parser-boot/tests/

--
Linaro LKFT
https://lkft.linaro.org

