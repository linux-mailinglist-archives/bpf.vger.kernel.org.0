Return-Path: <bpf+bounces-6088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA67657D9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4481E28241D
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCD17AC5;
	Thu, 27 Jul 2023 15:39:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA817AAE
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 15:39:17 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FF2122;
	Thu, 27 Jul 2023 08:39:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso16825151fa.1;
        Thu, 27 Jul 2023 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690472354; x=1691077154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+lkkF+CLVMT4BhNE7E5cz+wEvXfUMd8e9OamCGK4HU=;
        b=F6j8OCqcwyXUBtmVT65R8NJsFMHmPiWy6i9WOipPq1JUReuJwpp7aO5NpFmwsAR2Bj
         CJsCu4ELCKvHF6Buf+HIqoBv1aHEZRzFmiYnY12OVJWMAQc3pKkjRFzkCEydeheZhyt7
         655vh5dN+OSj6B90HrfVerPLGyIkLsuB8bRpc0VZ5MY8eoS1SY8BMK97RksKA/3jqBB2
         HvFMgnXzruA7ExqfCWlPjGThQW7hoVWSqFEyAjlpmwWQVZ63nTxXDARLt03BdH+hNbsH
         0uva1GVN1nm8Q5p97DFv+VhppdMZWgwz8cu8qnpoOLrSaxRMW6Rf6LxY/aSTEelVvfHP
         rNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690472354; x=1691077154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+lkkF+CLVMT4BhNE7E5cz+wEvXfUMd8e9OamCGK4HU=;
        b=f3rjp5b04tu9ncrFt5+SZ843ydDSIPEgxjuQrNUM7DCuK6vpyJrNKoGlKBuOlfdO88
         LfGAIt8rrlM4dVpqXg5py6Nwm/AFeP00L7jJVSP532KFHYkBP2CTXk53Q07tySJjmQ1l
         VcYY+Hp51yibnIpYr5u5JpveyY9I9X9UHN82JKI+pIVVy5iAl2XFRVY4w2syPG4hl1+K
         kgTSBnx0BKtu46yOAEOY1EdyUVn9JvwStt/hFAz1yrX/NqCvOJx+/p9diV0e1CaRc31A
         AVN2Rnqf34YOfoNi+wIoPZ1ECGH/auOg31DkZYn5jeVJoh5vYEKT9yoXZojWNwEjWPTj
         YAXQ==
X-Gm-Message-State: ABy/qLbq0md90o4yKFYLCl5feGLeuIHLIpPebBuEPUEYntZrXQZug8ur
	l1jxU3dB821RCG4kYU+y3syRKpnzmYVnlgEi+YDerJ1e
X-Google-Smtp-Source: APBJJlHA2LryZdAFZw27OCE9QuUIMumteqO47AfYJLgL+VdWfhBqstNeXHkJEEr8D5zw7EBJt//GSIIFwIGvSWZJgLs=
X-Received: by 2002:a2e:9842:0:b0:2b6:cf31:5e81 with SMTP id
 e2-20020a2e9842000000b002b6cf315e81mr2080102ljj.20.1690472353501; Thu, 27 Jul
 2023 08:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169037639315.607919.2613476171148037242.stgit@devnote2> <169037642351.607919.10234149030120807556.stgit@devnote2>
In-Reply-To: <169037642351.607919.10234149030120807556.stgit@devnote2>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 08:39:02 -0700
Message-ID: <CAADnVQJjZt=e-nSOmrxGJa59DLEQfaJupyx3RfwQhqXx8Vghmw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] bpf/btf: Add a function to search a member of a struct/union
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 6:00=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add btf_find_struct_member() API to search a member of a given data struc=
ture
> or union from the member's name.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  Changes in v3:
>   - Remove simple input check.
>   - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
>   - Move the code next to btf_get_func_param().
>   - Use for_each_member() macro instead of for-loop.
>   - Use btf_type_skip_modifiers() instead of btf_type_by_id().
> ---
>  include/linux/btf.h |    3 +++
>  kernel/bpf/btf.c    |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 20e3a07eef8f..4b10d57ceee0 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const char=
 *func_name,
>                                            struct btf **btf_p);
>  const struct btf_param *btf_get_func_param(const struct btf_type *func_p=
roto,
>                                            s32 *nr);
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +                                               const struct btf_type *ty=
pe,
> +                                               const char *member_name);
>
>  #define for_each_member(i, struct_type, member)                        \
>         for (i =3D 0, member =3D btf_type_member(struct_type);      \
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f7b25c615269..5258870030fc 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -958,6 +958,41 @@ const struct btf_param *btf_get_func_param(const str=
uct btf_type *func_proto, s3
>                 return NULL;
>  }
>
> +/*
> + * Find a member of data structure/union by name and return it.
> + * Return NULL if not found, or -EINVAL if parameter is invalid.
> + */
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +                                               const struct btf_type *ty=
pe,
> +                                               const char *member_name)
> +{
> +       const struct btf_member *member, *ret;
> +       const char *name;
> +       int i;
> +
> +       if (!btf_type_is_struct(type))
> +               return ERR_PTR(-EINVAL);
> +
> +       for_each_member(i, type, member) {
> +               if (!member->name_off) {
> +                       /* unnamed member: dig deeper */
> +                       type =3D btf_type_skip_modifiers(btf, member->typ=
e, NULL);
> +                       if (type) {
> +                               ret =3D btf_find_struct_member(btf, type,
> +                                                            member_name)=
;

Unbounded recursion in the kernel? Ouch. That might cause issues.
Please convert it to a loop. It doesn't have to be recursive.

> +                               if (!IS_ERR_OR_NULL(ret))
> +                                       return ret;
> +                       }
> +               } else {
> +                       name =3D btf_name_by_offset(btf, member->name_off=
);
> +                       if (name && !strcmp(member_name, name))
> +                               return member;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
>  #define BTF_SHOW_MAX_ITER      10
>
>  #define BTF_KIND_BIT(kind)     (1ULL << kind)
>

