Return-Path: <bpf+bounces-11229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACECE7B5C4F
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 22:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5D39F281FF7
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3D20327;
	Mon,  2 Oct 2023 20:57:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FA200D2;
	Mon,  2 Oct 2023 20:57:19 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD0C6;
	Mon,  2 Oct 2023 13:57:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so24564766b.3;
        Mon, 02 Oct 2023 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696280236; x=1696885036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exaza9diQenOrShvV6MMCLhRCzDC5rAMUMxRmEmm+Nk=;
        b=Gxcho68KHbKoMwan6BwguY4++1u9kZeSQZYfPJE9St+uwmL6q/F/Fp9RQw6qXIGFzm
         ZWfTzNvNqDImeScAdRJzORIiJpDgMc7ZqdWIxAzf2w4FWTkjF9cedmG+T1e461nbYDEK
         mvHSqpsFQPjekuOFP17aDknwKR9BhqOs6Wh5yj/+19IkwB+MavUrN61zeOkLsNfTxSUP
         eXAMi5WHEJwQVZW7MY+8vLRkHmpGSMkpW6DdQ5CmaS/UVLYr7kapNbkgk6/mTrcIvQXp
         /cFOHzAx2qsPY9CJjmmFgQkFOG7AGIECQZAuyVB/60ASrxTMYvEDkhWK/mmBRrTRxWQE
         h6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696280236; x=1696885036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exaza9diQenOrShvV6MMCLhRCzDC5rAMUMxRmEmm+Nk=;
        b=NmprBQ6olcyHoqDM5ZrIa6gjpEzbOfuQawoZi99IL0mFU5ww7GOtk9tzR4nmk7WL61
         NRrDm5Bgoo22Uek+y1XB5l3ttmYirBtJZF4477rhlsG3ytY4mlF8X744ud46bz4ZCGk4
         QwCJMJPOCW/wKstAqpi1WbIPy+optpZE6RK6xp7hikktIgBuPYpelf46SPSkQzRMeJqK
         kz60B69eA2QOcRCcdvJFjUqFn3V/HLteLw+4oHvgBKEDV8gBL4s10mKM3zmxqNIo8tGJ
         81De5QtPCFcNbBuEI8gdkUVML0PKd/thQ8bOVsHsx3DHCuat7qMBqVQT9EoUX9ALOXlK
         Gvww==
X-Gm-Message-State: AOJu0Yw8vz6DAXYo0izk9Zklo+CPUfw7w/miiw6uJ/XIds1G7cfLpOuT
	FKdEH3PcepvIXDjI+nK4uHs2otPITKECNTChnqE=
X-Google-Smtp-Source: AGHT+IHSo40cmKeex7UOmhM0j1X2NYVxhmeg7ikY6OaTtOg51K/sdDBDYr4eNc5xVjY2l02Ds0xihQJ4RONf8E/j4Mc=
X-Received: by 2002:a17:906:ce:b0:9b2:be5e:7545 with SMTP id
 14-20020a17090600ce00b009b2be5e7545mr10362457eji.36.1696280235907; Mon, 02
 Oct 2023 13:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002122756.323591-1-daan.j.demeyer@gmail.com> <20231002122756.323591-6-daan.j.demeyer@gmail.com>
In-Reply-To: <20231002122756.323591-6-daan.j.demeyer@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Oct 2023 13:57:04 -0700
Message-ID: <CAEf4BzbxF5RxX6vLiAAA4i+9V-pYeue55eTA7Zfk3FGFdQC8dA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/9] libbpf: Add support for cgroup unix
 socket address hooks
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 5:28=E2=80=AFAM Daan De Meyer <daan.j.demeyer@gmail.=
com> wrote:
>
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into libbpf.
>
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 31b8b252e614..dd3683b98679 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -82,17 +82,22 @@ static const char * const attach_type_name[] =3D {
>         [BPF_CGROUP_INET6_BIND]         =3D "cgroup_inet6_bind",
>         [BPF_CGROUP_INET4_CONNECT]      =3D "cgroup_inet4_connect",
>         [BPF_CGROUP_INET6_CONNECT]      =3D "cgroup_inet6_connect",
> +       [BPF_CGROUP_UNIX_CONNECT]       =3D "cgroup_unix_connect",
>         [BPF_CGROUP_INET4_POST_BIND]    =3D "cgroup_inet4_post_bind",
>         [BPF_CGROUP_INET6_POST_BIND]    =3D "cgroup_inet6_post_bind",
>         [BPF_CGROUP_INET4_GETPEERNAME]  =3D "cgroup_inet4_getpeername",
>         [BPF_CGROUP_INET6_GETPEERNAME]  =3D "cgroup_inet6_getpeername",
> +       [BPF_CGROUP_UNIX_GETPEERNAME]   =3D "cgroup_unix_getpeername",
>         [BPF_CGROUP_INET4_GETSOCKNAME]  =3D "cgroup_inet4_getsockname",
>         [BPF_CGROUP_INET6_GETSOCKNAME]  =3D "cgroup_inet6_getsockname",
> +       [BPF_CGROUP_UNIX_GETSOCKNAME]   =3D "cgroup_unix_getsockname",
>         [BPF_CGROUP_UDP4_SENDMSG]       =3D "cgroup_udp4_sendmsg",
>         [BPF_CGROUP_UDP6_SENDMSG]       =3D "cgroup_udp6_sendmsg",
> +       [BPF_CGROUP_UNIX_SENDMSG]       =3D "cgroup_unix_sendmsg",
>         [BPF_CGROUP_SYSCTL]             =3D "cgroup_sysctl",
>         [BPF_CGROUP_UDP4_RECVMSG]       =3D "cgroup_udp4_recvmsg",
>         [BPF_CGROUP_UDP6_RECVMSG]       =3D "cgroup_udp6_recvmsg",
> +       [BPF_CGROUP_UNIX_RECVMSG]       =3D "cgroup_unix_recvmsg",
>         [BPF_CGROUP_GETSOCKOPT]         =3D "cgroup_getsockopt",
>         [BPF_CGROUP_SETSOCKOPT]         =3D "cgroup_setsockopt",
>         [BPF_SK_SKB_STREAM_PARSER]      =3D "sk_skb_stream_parser",
> @@ -8960,14 +8965,19 @@ static const struct bpf_sec_def section_defs[] =
=3D {
>         SEC_DEF("cgroup/bind6",         CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_BIND, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/connect4",      CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
4_CONNECT, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/connect6",      CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_CONNECT, SEC_ATTACHABLE),
> +       SEC_DEF("cgroup/connectun",     CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX=
_CONNECT, SEC_ATTACHABLE),

I don't have too strong feelings here, but is "un" suffix a clear
enough designator that this is working with unix sockets? Nothing can
beat "connect4" and "connect6" in succinctness, but
`cgroup/connect_unix` is not too verbose, but is probably a bit easier
to guess?

Again, if this was some sort of consensus, I don't care much, but I
thought I'd bring this up anyways.

>         SEC_DEF("cgroup/sendmsg4",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4=
_SENDMSG, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/sendmsg6",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6=
_SENDMSG, SEC_ATTACHABLE),
> +       SEC_DEF("cgroup/sendmsgun",     CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX=
_SENDMSG, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/recvmsg4",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4=
_RECVMSG, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/recvmsg6",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6=
_RECVMSG, SEC_ATTACHABLE),
> +       SEC_DEF("cgroup/recvmsgun",     CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX=
_RECVMSG, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/getpeername4",  CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
4_GETPEERNAME, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/getpeername6",  CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_GETPEERNAME, SEC_ATTACHABLE),
> +       SEC_DEF("cgroup/getpeernameun", CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX=
_GETPEERNAME, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/getsockname4",  CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
4_GETSOCKNAME, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/getsockname6",  CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_GETSOCKNAME, SEC_ATTACHABLE),
> +       SEC_DEF("cgroup/getsocknameun", CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX=
_GETSOCKNAME, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/sysctl",        CGROUP_SYSCTL, BPF_CGROUP_SYSCTL,=
 SEC_ATTACHABLE),
>         SEC_DEF("cgroup/getsockopt",    CGROUP_SOCKOPT, BPF_CGROUP_GETSOC=
KOPT, SEC_ATTACHABLE),
>         SEC_DEF("cgroup/setsockopt",    CGROUP_SOCKOPT, BPF_CGROUP_SETSOC=
KOPT, SEC_ATTACHABLE),
> --
> 2.41.0
>
>

