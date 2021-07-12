Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F833C63B3
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 21:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhGLT2Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhGLT2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 15:28:24 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99DDC0613DD
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:25:34 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o8so9941767ilf.4
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0uqWiDX3KkGEZk4mJ49siOHil9bmmONxYoxtunIyW20=;
        b=J/3TB2Veudbm6Vrbjvx2aUJkTg/axOxtBXZEyFcZgX3DqyXwsgRyC5u3hH6EIichTS
         OE4u4W20iiKuWCI5iohgI3yiT+6lUDXkdmHHFsaV/J5nvIGix4lHOSZWjXk/WTyFwFcU
         QKn6aTt6k2Z8Z1qy7oMCvXpoGwu/lqd+7Jr4NNoHVJN2hWwq5tlo7U1NcM1+fCdv/Nmo
         8viokpLvzIVyJy0JVb6HaWk4UVxSzHcK4t8n58zqrE/zSRi8AYpY4sNvIGooVxrIgQ6z
         QRVv45FbttoFP6a9VjNa+NuFIp8fr8Y9j/7F2W+bkWdTNElFg1j0NMW6SdL8VyDE+CcU
         M2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0uqWiDX3KkGEZk4mJ49siOHil9bmmONxYoxtunIyW20=;
        b=a2LIVcMnc7qX45Q9bLAdalg5tco3Es3SBrw3wT0DzM+bTUcT2GAw95S/eK5E2HBKF8
         1Q4P5sHy39+RBec/aYJ1t1hVv/kXpu+dIWL+i4QhfT0oaSJcgqOziKQDc6jq2/Mac8/A
         /91dUfvu684mVv5HNRq5eSAhzKaH0lvc7flirg1NCUAakNgcZfBk28JQEMk0bE7Ptrgf
         EwZ95HumSRzc7Bm0aaozLF6aVQl1rkyWeXILUiSbSHJ2zRxDKu0Rd1Nm6pUtQ5fDVStR
         PE1jX6nV2jal1P12L35Pb+05M144tHWKz7IEzFqWpQcfvncpop18ZhpgqIkPfpLgj5H+
         Pgkg==
X-Gm-Message-State: AOAM530m3XxUzmOjg7deZP2jOUfvFFi3PIwBInHNiDX6xV0QMLNj1cRH
        e13MEiT2BOEmD3M7PEDPej0=
X-Google-Smtp-Source: ABdhPJy4VZCDAuB8Ep/JE0K8X8LIBg/H6X8IoRR3Pl3un7pbhQutxa3ohaEEHaIIQ57Wn/oE3m9WVQ==
X-Received: by 2002:a92:c10d:: with SMTP id p13mr285008ile.83.1626117934191;
        Mon, 12 Jul 2021 12:25:34 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id p21sm7800iog.37.2021.07.12.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:25:33 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:25:27 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Message-ID: <60ec9727a6c9d_50e1d2085c@john-XPS-13-9370.notmuch>
In-Reply-To: <20210712192055.2547468-1-yhs@fb.com>
References: <20210712192055.2547468-1-yhs@fb.com>
Subject: RE: [PATCH bpf-next v3] libbpf: fix compilation errors on ubuntu
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
> TCA_BPF_MAX is also adjusted in a similar way.
> =

> Fixes: 715c5ce454a6 ("libbpf: Add low level TC-BPF management API")
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Looks better thanks. Now even compiling on systems with out of date
uapi headers should be fine and running on newer kernels will still
work as expected. Thanks.

Acked-by: John Fastabend <john.fastabend@gmail.com>

> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 39f25e09b51e..37cb6b50f4b3 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -22,6 +22,29 @@
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
> +/* TCA_BPF_ID is an enumerator value in uapi/linux/pkt_cls.h.
> + * Declare it as a macro here so old system can still work
> + * without TCA_BPF_ID defined in pkt_cls.h.
> + */
> +#define TCA_BPF_ID 11

I guess compiler is smart enough to see TCA_BPF_ID is the
same value as in headers so it wont throw a redefined warning.

> +
> +#ifdef TCA_BPF_MAX
> +#undef TCA_BPF_MAX
> +#endif
> +#define TCA_BPF_MAX 11
> +
>  typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct nla=
ttr **tb);
>  =

>  typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, libbpf_dump_nlms=
g_t,
> -- =

> 2.30.2
> =



