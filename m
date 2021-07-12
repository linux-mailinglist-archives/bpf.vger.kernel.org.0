Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB93C61E6
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhGLRbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbhGLRba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 13:31:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7789DC0613DD
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 10:28:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x10so4842333ion.9
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6HX/mySYBAGOkvad/RP/sdVeJoPaO1pmR4d6ELHs21g=;
        b=W0BXPoTtHFh0KRmOcG3tJ1tJVq4/RuKCmrO/ZR/FCFp2mr+80Q7JSrN0zMYpkLVGkB
         tOBUuBxw4TAIRKuDdPqK/5U5Vgjk8KsNYvkgOQt7rEimJzIyseTOKatwkOIYTbpfTx51
         z4YXr8EmC2J1SmdHS2hODIlj15YrNfsipqhAwUqEZuokXphqfQ0Snpn0TI4O7kbHJVJ9
         BbQhp6EJIsxIjXAuy8YxqaY/lFtFp6RwNX9a2tgemaFPxMqH+iUzuSZqt16VxzaOo8sC
         w/sJK04NDLuj95GM6ZTCiEC/0auG/lyvqVwVtSYXVFKInmq0JU+vsxXc6DKjrjymBdXA
         Q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6HX/mySYBAGOkvad/RP/sdVeJoPaO1pmR4d6ELHs21g=;
        b=E3pusDDZg/+K72qLp2Itk93zaxDGTfh/iBPWYysj6YiV6dMiUKzFdnFFSSmoeEMzBP
         NXgwbNcFGh0YOM4S2jcnzYb5bDwuk4xnmhcsMQjUMZfaJ9mt/4gVX3Ed+x9JNUOQAP5s
         SXhhoeGXW8unXuvv9+NQDSoKD343EMLIXiifk6U2Nu7rzXyyfoo+xu9sl0Z7eYlgmQz9
         EGkR77AJnbsAY9v+sYohiQIJwvBzLn0IhCwVuqIju8AEExMnITiDDFQEJNW+7AeamPjM
         veGnBHXHkg9A1lu2so2joHRMcHIAyukLCjl4wSjDvZoyGKxZmBAovxhSKFoxAGKqb9tr
         P5Yg==
X-Gm-Message-State: AOAM531zKo/99zMkdLPa+Bt4RTIjly+FOzmD8sTlhIoPhnpSBHOEqF2V
        5/BWVXuYK4ZnTBtcAkoQVP8=
X-Google-Smtp-Source: ABdhPJxpVzzwwMf+D2VliCc4raepO9FT9ExYZ7zfxuhQpKa6IhWP9NzcwGvtzoAW69cfFCRZ2FcNCA==
X-Received: by 2002:a5e:980c:: with SMTP id s12mr42350ioj.128.1626110920798;
        Mon, 12 Jul 2021 10:28:40 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id t15sm8191302ile.28.2021.07.12.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:28:40 -0700 (PDT)
Date:   Mon, 12 Jul 2021 10:28:33 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Message-ID: <60ec7bc1a4537_29dcc208e7@john-XPS-13-9370.notmuch>
In-Reply-To: <20210712165832.1833460-1-yhs@fb.com>
References: <20210712165832.1833460-1-yhs@fb.com>
Subject: RE: [PATCH bpf-next v2] libbpf: fix compilation errors on ubuntu
 16.04
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> libbpf is used as a submodule in bcc.
> When importing latest libbpf repo in bcc, I observed the
> following compilation errors when compiling on ubuntu 16.04.
>   .../netlink.c:416:23: error: =E2=80=98TC_H_CLSACT=E2=80=99 undeclared=
 (first use in this function)
>      *parent =3D TC_H_MAKE(TC_H_CLSACT,
>                          ^
>   .../netlink.c:418:9: error: =E2=80=98TC_H_MIN_INGRESS=E2=80=99 undecl=
ared (first use in this function)
>            TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>            ^
>   .../netlink.c:418:28: error: =E2=80=98TC_H_MIN_EGRESS=E2=80=99 undecl=
ared (first use in this function)
>            TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>                               ^
>   .../netlink.c: In function =E2=80=98__get_tc_info=E2=80=99:
>   .../netlink.c:522:11: error: =E2=80=98TCA_BPF_ID=E2=80=99 undeclared =
(first use in this function)
>     if (!tbb[TCA_BPF_ID])
>              ^
> =

> In ubuntu 16.04, TCA_BPF_* enumerator looks like below
>   enum {
> 	TCA_BPF_UNSPEC,
> 	TCA_BPF_ACT,
> 	...
> 	TCA_BPF_NAME,
> 	TCA_BPF_FLAGS,
> 	__TCA_BPF_MAX,
>   };
>   #define TCA_BPF_MAX	(__TCA_BPF_MAX - 1)
> while in latest bpf-next, the enumerator looks like
>   enum {
> 	TCA_BPF_UNSPEC,
> 	...
> 	TCA_BPF_FLAGS,
> 	TCA_BPF_FLAGS_GEN,
> 	TCA_BPF_TAG,
> 	TCA_BPF_ID,
> 	__TCA_BPF_MAX,
>   };
> =

> In this patch, TCA_BPF_ID is defined as a macro with proper value and t=
his
> works regardless of whether TCA_BPF_ID is defined in uapi header or not=
.
> =

> I also added a comparison "TCA_BPF_MAX < TCA_BPF_ID" in function __get_=
tc_info()
> such that if the compare result if true, returns -EOPNOTSUPP. This is u=
sed to
> prevent otherwise array overflows:
>   .../netlink.c:538:10: warning: array subscript is above array bounds =
[-Warray-bounds]
>     if (!tbb[TCA_BPF_ID])
>             ^
> =

> Fixes: 715c5ce454a6 ("libbpf: Add low level TC-BPF management API")
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/netlink.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> =

> Changelog:
>   v1 -> v2:
>     - gcc 8.3 doesn't like macro condition
>         (__TCA_BPF_MAX - 1) <=3D 10
>       where __TCA_BPF_MAX is an enumerator value.
>       So define TCA_BPF_ID macro without macro condition.
> =

> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 39f25e09b51e..e00660e0b87a 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -22,6 +22,24 @@
>  #define SOL_NETLINK 270
>  #endif
>  =

> +#ifndef TC_H_CLSACT
> +#define TC_H_CLSACT TC_H_INGRESS
> +#endif
> +
> +#ifndef TC_H_MIN_INGRESS
> +#define TC_H_MIN_INGRESS 0xFFF2U
> +#endif
> +
> +#ifndef TC_H_MIN_EGRESS
> +#define TC_H_MIN_EGRESS 0xFFF3U
> +#endif
> +
> +/* TCA_BPF_ID is an enumerate value in uapi/linux/pkt_cls.h.
> + * Declare it as a macro here so old system can still work
> + * without TCA_BPF_ID defined in pkt_cls.h.
> + */
> +#define TCA_BPF_ID 11
> +
>  typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct nla=
ttr **tb);
>  =

>  typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, libbpf_dump_nlms=
g_t,
> @@ -504,6 +522,8 @@ static int __get_tc_info(void *cookie, struct tcmsg=
 *tc, struct nlattr **tb,
>  		return -EINVAL;
>  	if (!tb[TCA_OPTIONS])
>  		return NL_CONT;
> +	if (TCA_BPF_MAX < TCA_BPF_ID)
> +		return -EOPNOTSUPP;

I'm a bit confused here. Generally what I want to have happen is compilat=
ion
to work always and then runtime to detect the errors. So when I compile m=
y
libs on machine A and run it on machine B it does what I expect. This see=
ms
like a bit of an ugly workaround to me. I would expect the user should
update the uapi?

Or should we (maybe just libbpf git repo?) include the defines needed? Th=
e
change here seems likely to cause issues where someone compiles on old
kernel then tries to run it later on newer kernel and is confused when th=
ey
get EOPNOTSUPP.

Did I miss something? What if we just include the enum directly and
wrap in ifndef? This is how I've dealt with these dependencies on
other libs/apps.

>  =

>  	libbpf_nla_parse_nested(tbb, TCA_BPF_MAX, tb[TCA_OPTIONS], NULL);
>  	if (!tbb[TCA_BPF_ID])
> -- =

> 2.30.2
> =
