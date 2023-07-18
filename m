Return-Path: <bpf+bounces-5174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F87581D5
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CF02811D2
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BD13ACC;
	Tue, 18 Jul 2023 16:14:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06E134D3
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:14:51 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41A18E
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 09:14:50 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-57688a146ecso60942387b3.2
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689696889; x=1692288889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIxbqWruk3tde8GVe4doC/LqINU6BWOqPPtRnKi722g=;
        b=WcRQ65n2jffvRfWCd/0smTGdkn4JwU1AcKC64qNQdLnF+Zl2LddiiFmy/exjJpDO2Q
         kYnOcXQ6NyJ0CamdYVCkvtRg5AdC0+AHUysEq4EqUaP6fvIeIGDWgA++zhM+A1TlH3Ww
         YZSugrPeUDvfPsEBOyxSbOoqoMz8vxjPGJYeBVSSQZZ1Pv57fAsOYMi2g7NLD1qfYcoI
         KunMLrJOhVQSatmpdU9b5b7PcE6Vv8isJ/ceXgrIR9SNbUHuMSVEGzYE9ir1wS2wscVm
         N0pvai/AjXhy70uf1ykJpI3E0j//MKVD5AJLcMS3iO1XJtPWOhc1z0qpHcSizch8FFz6
         g50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696889; x=1692288889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIxbqWruk3tde8GVe4doC/LqINU6BWOqPPtRnKi722g=;
        b=C/Z4+RTyXvm4q11aJiAUVCekTM+s98GBNESewVW7f9jLcio04aRkhJaQm6zd8WkOCS
         eOI+m5DiQN5SBzcykDO+qGlFYqhuvswEKUut7ULj/Fv58o0Gr/l83/MgYhF3gsx+c+/R
         KKBcXQxtwseYZflKvlVowOwRbp0DSFLoGXvUn2JUmxvVzZzZ0BnHkaXY5ihyNaf56Pur
         A51q92KzlfVzsrjXlz6vj04BdBW+39VL5EzQHK2Bj0P+0nkco1GGEnZvb0ISM4MHfcWQ
         h19gVT1GjgEqjoWYEBbUZIp3EO3T6r6FnRH5NW5Z19wUZDWsDayyi1xlSXWWZGBdqU7M
         6vtQ==
X-Gm-Message-State: ABy/qLZ8nvRslYBeUnDHBsFh9VL/2z3bLd/f8h2qDYeKIfNQjCvX4qE5
	xkOx+YFyA3spftQy37sPcWLSA8KY6gFNfQWwB5qO
X-Google-Smtp-Source: APBJJlFiIjBtpQQejWvrjQReyY+tBIxRJDFWVT5w7U/heJfhvIbpO+/96V065lnbgvZpVmD5IVL95oW37LKVsskcjTI=
X-Received: by 2002:a0d:d754:0:b0:582:98f9:a1e3 with SMTP id
 z81-20020a0dd754000000b0058298f9a1e3mr215180ywd.18.1689696889222; Tue, 18 Jul
 2023 09:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com>
In-Reply-To: <3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Jul 2023 12:14:38 -0400
Message-ID: <CAHC9VhS_LKdkEmm5_J5y34RpaRcTbg8==fpz8pMThDCjF6nYtQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v5] bpf: Force to MPTCP
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 11:21=E2=80=AFAM Geliang Tang <geliang.tang@suse.co=
m> wrote:
>
> As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
>
> "Your app can create sockets with IPPROTO_MPTCP as the proto:
> ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
> forced to create and use MPTCP sockets instead of TCP ones via the
> mptcpize command bundled with the mptcpd daemon."
>
> But the mptcpize (LD_PRELOAD technique) command has some limitations
> [2]:
>
>  - it doesn't work if the application is not using libc (e.g. GoLang
> apps)
>  - in some envs, it might not be easy to set env vars / change the way
> apps are launched, e.g. on Android
>  - mptcpize needs to be launched with all apps that want MPTCP: we could
> have more control from BPF to enable MPTCP only for some apps or all the
> ones of a netns or a cgroup, etc.
>  - it is not in BPF, we cannot talk about it at netdev conf.
>
> So this patchset attempts to use BPF to implement functions similer to
> mptcpize.
>
> The main idea is add a hook in sys_socket() to change the protocol id
> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
>
> [1]
> https://github.com/multipath-tcp/mptcp_net-next/wiki
> [2]
> https://github.com/multipath-tcp/mptcp_net-next/issues/79
>
> v5:
>  - add bpf_mptcpify helper.
>
> v4:
>  - use lsm_cgroup/socket_create
>
> v3:
>  - patch 8: char cmd[128]; -> char cmd[256];
>
> v2:
>  - Fix build selftests errors reported by CI
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/linux/bpf.h                           |   1 +
>  include/linux/lsm_hook_defs.h                 |   2 +-
>  include/linux/security.h                      |   6 +-
>  include/uapi/linux/bpf.h                      |   7 +
>  kernel/bpf/bpf_lsm.c                          |   2 +
>  net/mptcp/bpf.c                               |  20 +++
>  net/socket.c                                  |   4 +-
>  security/apparmor/lsm.c                       |   8 +-
>  security/security.c                           |   2 +-
>  security/selinux/hooks.c                      |   6 +-
>  tools/include/uapi/linux/bpf.h                |   7 +
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 128 ++++++++++++++++--
>  tools/testing/selftests/bpf/progs/mptcpify.c  |  17 +++
>  13 files changed, 187 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

...

> diff --git a/security/security.c b/security/security.c
> index b720424ca37d..bbebcddce420 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4078,7 +4078,7 @@ EXPORT_SYMBOL(security_unix_may_send);
>   *
>   * Return: Returns 0 if permission is granted.
>   */
> -int security_socket_create(int family, int type, int protocol, int kern)
> +int security_socket_create(int *family, int *type, int *protocol, int ke=
rn)
>  {
>         return call_int_hook(socket_create, 0, family, type, protocol, ke=
rn);
>  }

Using the LSM to change the protocol family is not something we want
to allow.  I'm sorry, but you will need to take a different approach.

--=20
paul-moore.com

