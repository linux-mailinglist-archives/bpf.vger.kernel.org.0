Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B1475253
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 06:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhLOF5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 00:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhLOF5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 00:57:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B4C061574;
        Tue, 14 Dec 2021 21:57:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so19374771pja.1;
        Tue, 14 Dec 2021 21:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vlxui2q+F6FmPOSAyat+UUCwygwUTGs6rH4JQWaB0To=;
        b=liZVPZ1/q97CZjgWg9BYL0T8jK/FaSLkqc0HKLirKofHXwpLE7Z/WKNmlltQ0B3nTO
         KSzvphAAHmsTSV/28kk5LS3AClDyXYkbIBetUiYGPxDbxTilDdTyt7tAM97sMEkiROnK
         gZq/8WSxhg6uwzKfi+IFsz3JovFjy6I26ZDFSkLYsBWzEzU+55jfAfK67NfkUA/J6OJ+
         mFXag12+RPrbfBr1zGCqr3iCOuLejdEnyGas1qC9jEhW6NSDIzelrtk6VSGKOCcsheyt
         fu5750jknHgh7Iv8cYxrcOEhA0hvFU2HZRoAcg1Fwjc1yB/RgzwOQKIVc9d75wgSUgNB
         WXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vlxui2q+F6FmPOSAyat+UUCwygwUTGs6rH4JQWaB0To=;
        b=RFqNutI2KfEgYpT2J13eTrTS3r94u/AxPnRsxkPV3PvTw/zbSlvR0wjp85L3mBNCXu
         gsuzYr/GKDdx65xtI2qDfQSMxPx2KJBqFCmipCTtLcBd5VVbrk1ULU9kUsZEnfWBJyBD
         DQP4i6pbzyI4chT5jAgVTcA5BM1ngTjEDT6oTb2LpJAGDqjRzL5hvGM9eJG2n9Nnkg+F
         LvJWnO20N6J6dscJqj/sTnkVx23E/ZfV0Qte9bidLvkhQULbPkUVVAtOb+zKDE/ksdwm
         KTzV14DnKoOuJrw0f3aErkbhOlC5U2cqq7O2EXg41fqh+JJFCxmnsbzFUIp2JH8bKFqy
         /Y8Q==
X-Gm-Message-State: AOAM530eodzAcy+8PoeuqM60fcHHCRj2x/vAAWrp5NpCO3E+MJxxCd5D
        tQfbxEMRZnyE9XE54TjTAlXAII7yJFWvGruGKoXFY8Ij5ms=
X-Google-Smtp-Source: ABdhPJxvGudOLccb8aIK6vKg1BRpVqsLl8YKL7XjEPIouQbInIJoreQWRBMsd6G7zofWd2wpnSyWokvfeZyOK75cowM=
X-Received: by 2002:a17:902:c111:b0:148:ab3d:7d44 with SMTP id
 17-20020a170902c11100b00148ab3d7d44mr590286pli.126.1639547821858; Tue, 14 Dec
 2021 21:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
In-Reply-To: <20211210172034.13614-1-mcroce@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Dec 2021 21:56:50 -0800
Message-ID: <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 10, 2021 at 9:20 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> In userspace, bpf_core_types_are_compat() is a recursive function which
> can't be put in the kernel as is.
> Limit the recursion depth to 2, to avoid potential stack overflows
> in kernel.
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

Thank you for taking a stab at it!

> +#define MAX_TYPES_ARE_COMPAT_DEPTH 2
> +
> +static
> +int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
> +                               const struct btf *targ_btf, __u32 targ_id,
> +                               int level)
> +{
> +       const struct btf_type *local_type, *targ_type;
> +       int depth = 32; /* max recursion depth */
> +
> +       if (level <= 0)
> +               return -EINVAL;
> +
> +       /* caller made sure that names match (ignoring flavor suffix) */
> +       local_type = btf_type_by_id(local_btf, local_id);
> +       targ_type = btf_type_by_id(targ_btf, targ_id);
> +       if (btf_kind(local_type) != btf_kind(targ_type))
> +               return 0;
> +
> +recur:
> +       depth--;
> +       if (depth < 0)
> +               return -EINVAL;
> +
> +       local_type = btf_type_skip_modifiers(local_btf, local_id, &local_id);
> +       targ_type = btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
> +       if (!local_type || !targ_type)
> +               return -EINVAL;
> +
> +       if (btf_kind(local_type) != btf_kind(targ_type))
> +               return 0;
> +
> +       switch (btf_kind(local_type)) {
> +       case BTF_KIND_UNKN:
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION:
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_FWD:
> +               return 1;
> +       case BTF_KIND_INT:
> +               /* just reject deprecated bitfield-like integers; all other
> +                * integers are by default compatible between each other
> +                */
> +               return btf_int_offset(local_type) == 0 && btf_int_offset(targ_type) == 0;
> +       case BTF_KIND_PTR:
> +               local_id = local_type->type;
> +               targ_id = targ_type->type;
> +               goto recur;
> +       case BTF_KIND_ARRAY:
> +               local_id = btf_array(local_type)->type;
> +               targ_id = btf_array(targ_type)->type;
> +               goto recur;
> +       case BTF_KIND_FUNC_PROTO: {
> +               struct btf_param *local_p = btf_params(local_type);
> +               struct btf_param *targ_p = btf_params(targ_type);
> +               __u16 local_vlen = btf_vlen(local_type);
> +               __u16 targ_vlen = btf_vlen(targ_type);
> +               int i, err;
> +
> +               if (local_vlen != targ_vlen)
> +                       return 0;
> +
> +               for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
> +                       btf_type_skip_modifiers(local_btf, local_p->type, &local_id);
> +                       btf_type_skip_modifiers(targ_btf, targ_p->type, &targ_id);


Maybe do a level check here?
Since calling it and immediately returning doesn't conserve
the stack.
If it gets called it can finish fine, but
calling it again would be too much.
In other words checking the level here gives us
room for one more frame.

> +                       err = __bpf_core_types_are_compat(local_btf, local_id,
> +                                                         targ_btf, targ_id,
> +                                                         level - 1);
> +                       if (err <= 0)
> +                               return err;
> +               }
> +
> +               /* tail recurse for return type check */
> +               btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
> +               btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
> +               goto recur;
> +       }
> +       default:
> +               pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
> +                       btf_type_str(local_type), local_id, targ_id);

That should be bpf_log() instead.

> +               return 0;
> +       }
> +}

Please add tests that exercise this logic by enabling
additional lskels and a new test that hits the recursion limit.
I suspect we don't have such case in selftests.

Thanks!
