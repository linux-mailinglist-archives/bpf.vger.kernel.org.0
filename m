Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E410C26261A
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 06:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgIIEMe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 00:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgIIEMc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 00:12:32 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC65C061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 21:12:32 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c17so918726ybe.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 21:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKk/7yHeC4nE7j5clVo7HcO/7iRZkJAeOttTSw3ex8Q=;
        b=DRnOl542DmBHYjjYZkr2K3E2yIqAtkCPTn3j6Bgx/wke1fT2jcTroI8wLSpRayEIj9
         nd1B5/PnFTwH7z6AwPwJhFDFwAujnWK3wUogyn0UR5xAQ4ASbLYCxa61jvn3/PzbogR7
         q/zD/BZ9nTQE9R4qS5J25T2tI2lyV9uwm6Fqdh9AhpVayiOfRKdg1YNSGcFN6w/ETg85
         GFKcd2ZkzWlPTzR0TTLB4TDbg49bIr1uXVpuFlfUL5fzM6QLnl2E60F4Yv+P9mgr9uep
         bPSskWpXb7L40t5JVjvocoXJerclvu4g+GtMb3G+simF2gRn+I1CuWrpUTxBOwB8IBs0
         d0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKk/7yHeC4nE7j5clVo7HcO/7iRZkJAeOttTSw3ex8Q=;
        b=QOW6a75SDrxdhgmJWIFWVfZx+L3sPqaAP004NlI95dBhtduf94pBERVQL9sYKOGDYI
         6osQHNRGa64LjCy7jvX7MwCc4NNt/ZFUPlDDJbCtJWDmW3XfMFCJ8LHMkaMuoHBVFHdo
         sP2ihgW+5VcNtDxov93Pt1qFJH4lhicIPnvhFMJ1LwAVIU1bjXnpGUq7/Ka4mMniSKlK
         E9yP5XnB2IpYxeg0KipQ10AV45aDqRs4tOByWFWrikZnPsUNZdA9sx7jGlxq13z7XKdq
         nkYS0zayRG9rYxgPw0f42NeQiD9OfV7aZSmj1tVjMnVhbKhoT2XzQ4O+xoysfU8b2Zrh
         Uayg==
X-Gm-Message-State: AOAM5305r373sfKxyQTMpO5RIat7J13cNuCdY6eaBRM5VlS2kWcMfTGr
        6zkLTo+dE3OyoHnZEVYYlwM9twKoN6IZgtx2YMw=
X-Google-Smtp-Source: ABdhPJy760NoSrPSxf27yhaANuzt6KVzC+ERFuS4oXB9zqW9ixmcstX6Z2FbnKyWTrLGGK8oFFp0bHfptVJuk1qBbjA=
X-Received: by 2002:a25:aa8f:: with SMTP id t15mr2985737ybi.459.1599624751658;
 Tue, 08 Sep 2020 21:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-3-lmb@cloudflare.com>
In-Reply-To: <20200904112401.667645-3-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 21:12:21 -0700
Message-ID: <CAEf4BzbCxJz_8GcjfRMCAt5xY2hfJdKd_14Af57Hz2H9oysj6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/11] btf: add a global set of valid BTF socket ids
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 4:29 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Similar to the existing btf_sock_ids, add a set for the same data.
> This allows searching for sockets using btf_set_contains.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  include/linux/btf_ids.h       | 1 +
>  net/core/filter.c             | 7 +++++++
>  tools/include/linux/btf_ids.h | 1 +
>  3 files changed, 9 insertions(+)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 42aa667d4433..eb6739ebbba4 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -174,6 +174,7 @@ MAX_BTF_SOCK_TYPE,
>  };
>
>  extern u32 btf_sock_ids[];
> +extern struct btf_id_set btf_sock_ids_set;
>  #endif
>
>  #endif
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 47eef9a0be6a..c7f96cfea1b0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9903,8 +9903,15 @@ BTF_ID_LIST_GLOBAL(btf_sock_ids)
>  #define BTF_SOCK_TYPE(name, type) BTF_ID(struct, type)
>  BTF_SOCK_TYPE_xxx
>  #undef BTF_SOCK_TYPE
> +
> +BTF_SET_START_GLOBAL(btf_sock_ids_set)
> +#define BTF_SOCK_TYPE(name, type) BTF_ID(struct, type)
> +BTF_SOCK_TYPE_xxx
> +#undef BTF_SOCK_TYPE
> +BTF_SET_END(btf_sock_ids_set)
>  #else
>  u32 btf_sock_ids[MAX_BTF_SOCK_TYPE];
> +struct btf_id_set btf_sock_ids_set;
>  #endif

I haven't looked yet how this is going to be used, but instead of two
pairs of #define/#undef, wouldn't it be more straightforward to do:

#define BTF_SOCK_TYPE(name, type) BTF_ID(struct, type)
BTF_ID_LIST_GLOBAL(btf_sock_ids)
BTF_SOCK_TYPE_xxx

BTF_SET_START_GLOBAL(btf_sock_ids_set)
BTF_SOCK_TYPE_xxx
BTF_SET_END(btf_sock_ids_set)
#undef BTF_SOCK_TYPE

?

>
>  static bool check_arg_btf_id(u32 btf_id, u32 arg)
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 42aa667d4433..eb6739ebbba4 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -174,6 +174,7 @@ MAX_BTF_SOCK_TYPE,
>  };
>
>  extern u32 btf_sock_ids[];
> +extern struct btf_id_set btf_sock_ids_set;
>  #endif
>
>  #endif
> --
> 2.25.1
>
