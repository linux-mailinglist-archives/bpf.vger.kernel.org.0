Return-Path: <bpf+bounces-11820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4DA7C0284
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 19:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E7282119
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B962136B;
	Tue, 10 Oct 2023 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwWO9mZA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83614182B5
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:24:29 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB60CF
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 10:24:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so6675e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696958662; x=1697563462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB5kNO31ptUSKutse3tWEXjsvhyF99RBWYVjwQ8AbvA=;
        b=fwWO9mZACXUWMsPudmmRUitg6NtW4nwgl2/14aWMpNJL/wGIXc6xUY3iLwCYKZHi1m
         svIfxjpMbN/b2gKIfa1RzsAO0HCQZpn4W0sEixY3Y/kBhbWG27atXdkvDdMOeHddoDMJ
         ZOExHZiZyobwBrbA34W4L/M3qZyjABLOBxqtA6ieOl5UmEWDhUQUA2kFsafwVfXlNY3T
         7PFHii3IsZa9A4pQ4D9oEkfqIaA5gHT+x0dEtGaU11kqjPYV1ROdYGDTzaWB5XYIeIVj
         7pLj70EkkWGKROqNRlp29uL4Z5UNNFnn8y7xYuG9maHta+vR+/6f/kjPLLct8eYtdXxC
         F/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696958662; x=1697563462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB5kNO31ptUSKutse3tWEXjsvhyF99RBWYVjwQ8AbvA=;
        b=YS+cNkQ9P7Hc34ybFCDahwKCgBfS2q0bnMHJdIxyGnUM5VQnL12ImJiLkvUkjYxO7a
         /WVwyvwR6sLEDoWSCNHn1GeArikDfMMFc9rzfsk3m1gk2tgpLrTVHRavNTH4tvsTSMWW
         jftf7ydEbXV7gLXfI7uASLKp51ud0G0PNNHkd0akhTdE688sC6TWuDn7KPzllHirTTc4
         rLVCTs27y+gMB0Ay05plPgToWhElCftuilOqsGBo5pe7+cZp4MM2e35x03p199+GF3qi
         B3VD5JPzAW3V+BBUfI7rTJM+8DpzY4++qbIucRkidwnoa/3RKBVDZvi3fdXLyrrqef2c
         kLRw==
X-Gm-Message-State: AOJu0YxIfn8Wp9wUxGiluwSHkEDywEJVRq6LAYgTkA0b4PG1La3aKUTg
	wJ51pZdHL62gFl0L83LQFjmkwvBOmhy8P0dKCOEQow==
X-Google-Smtp-Source: AGHT+IHW65kerUr2q16h/XQsLBx5TUnAZCGf5RFeYJB83WXwTpqUq0HW6mE0I6kZv/CrMPkjVTR8X6392uJ6yuEKUpU=
X-Received: by 2002:a05:600c:3c8f:b0:405:35bf:7362 with SMTP id
 bg15-20020a05600c3c8f00b0040535bf7362mr11918wmb.0.1696958662190; Tue, 10 Oct
 2023 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009130122.946357448@linuxfoundation.org> <CA+G9fYvWCf4fYuQsVLu0NdN+=W73bW1hr1hiokajktNzPFyYtA@mail.gmail.com>
 <6447b32f-abb9-4459-aca5-3d510a66b685@kernel.org>
In-Reply-To: <6447b32f-abb9-4459-aca5-3d510a66b685@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Oct 2023 19:24:08 +0200
Message-ID: <CANn89iJ_KMA=dQWPhU8WQBc0_CvUztUBodAf-cW-2F=HMX3HJg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 6:51=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Naresh,
>
> On 09/10/2023 22:43, Naresh Kamboju wrote:
> > On Mon, 9 Oct 2023 at 18:46, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> This is the start of the stable review cycle for the 6.1.57 release.
> >> There are 162 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, pleas=
e
> >> let me know.
> >>
> >> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pat=
ch-6.1.57-rc1.gz
> >> or in the git tree and branch at:
> >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-sta=
ble-rc.git linux-6.1.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> >
> > The following kernel warnings were noticed several times on arm x15 dev=
ices
> > running stable-rc 6.1.57-rc1 while running  selftests: net: mptcp_conne=
ct.sh
> > and netfilter: nft_fib.sh.
> >
> > The possible unsafe locking scenario detected.
> >
> > FYI,
> > Stable-rc/ linux.6.1.y kernel running stable/ linux.6.5.y selftest in t=
his case.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > kselftest: Running tests in net/mptcp
>
> Thank you for having reported the issue and having added MPTCP ML in Cc!
>
> Just to avoid confusions: the "WARNING" you shared when running
> 'mptcp_connect.sh' selftest appeared before creating the first MPTCP
> connection. It looks like there is no reference to MPTCP in the
> calltraces. Also, because you have the same issue with nft_fib.sh, I
> would say that this issue is not linked to MPTCP but rather to a recent
> modification in the IPv6 stack.
>
> By chance, did you start a "git bisect" to identify the commit causing
> this issue?
>
>

I think stable teams missed to backport

commit c486640aa710ddd06c13a7f7162126e1552e8842
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Mar 13 20:17:32 2023 +0000

    ipv6: remove one read_lock()/read_unlock() pair in rt6_check_neigh()

    rt6_check_neigh() uses read_lock() to protect n->nud_state reading.

    This seems overkill and causes false sharing.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: David Ahern <dsahern@kernel.org>
    Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

