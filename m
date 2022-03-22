Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4B14E4820
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 22:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiCVVL7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiCVVL6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:11:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C42BE36
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:10:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s8so19186131pfk.12
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N45Yl/mRt1WCXhv3Pa5BOFlDvRsGJBWlQ128EjJRBq4=;
        b=V0y7zK4pl8TJrUH2Ay2zCdWsUDIhsGTgkAHxmo354kR20BVz4dt8nFWB2fCGnK87yt
         APLIpnYMBi+bDaRIh/zhZEQ0hZtc/S+T0etC1vrFYgqYltZdZrZpS2ug7qErVg5dTnhr
         e5VpSSTpki6AeAlC4TQt7G/FQiumkIhbbKU7LvhDIOdTYqQUQyB7jDTYwZmgQq5rl81B
         UjqWHm/hWH7at9Q6yKofqJYO9SW7GvIFNRCZ/X/3T7+U3DFssHFmjnABTg1kYix9MCzA
         7IrHcQvFW6Zs0oBKguDVtub6EhdaNn/lbnjo9pmashK0fVKRQobW1dI/MF4lpEzlC+QT
         ARrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N45Yl/mRt1WCXhv3Pa5BOFlDvRsGJBWlQ128EjJRBq4=;
        b=IXsoaQV7RSZdBbSRsRIE52KEaL0FwCGpPN3R13f2LZMT+h/NYMfINTcGt2LdbgHcmF
         V+5JvJe9kV8t0nT8OtO3c1lDrVyCG1Gux4GxaiTNJwYyjXAY9COrnG+EHroJTKt9pjL6
         HQt240blJuE1Y0IsvwOUli3IGBH5vy/xTM+n1QG7yFlb0/5n1Cyy3dMyAvEk7Mwj9ebh
         uzhs2G9CcSAE0y9nxbsOoSlJxzClhQeMIC75LjJ/YF6HhNdWyRheq0EiBXHV5GRW0IbJ
         a7RKsI9d3fIR1jbPM2/nmcouygkLe+WEO+mf+jtkNcPOyeHn21dtNtn3RT7y11VQu6Oa
         75TQ==
X-Gm-Message-State: AOAM533JMjJuMbGo4EFm36xUIbgQU88sGZ7rDE/gXc3RCzVyxNOjuUUz
        RGJha38no8/0wdXSAiGvnDgvYPqMvTi8wHrJwqM=
X-Google-Smtp-Source: ABdhPJxZ8YYAqfEhucbHLAatNgwhMQs80T5vq/SHwpXdRlT/EoUQ+s1/6uiasmUJErs3p+odY0VVsbaxGEn6IcUr1uk=
X-Received: by 2002:a63:6809:0:b0:37c:68d3:1224 with SMTP id
 d9-20020a636809000000b0037c68d31224mr22835528pgc.287.1647983429676; Tue, 22
 Mar 2022 14:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-10-memxor@gmail.com>
In-Reply-To: <20220320155510.671497-10-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 22 Mar 2022 14:10:17 -0700
Message-ID: <CAADnVQJd8E6T1GRMVS+XZxKDdnMjo-WQ-CdM7+x18VPj9ufpFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Wire up freeing of referenced kptr
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> +               /* Find and stash the function pointer for the destruction function that
> +                * needs to be eventually invoked from the map free path.
> +                */
> +               if (info_arr[i].flags & BPF_MAP_VALUE_OFF_F_REF) {
> +                       const struct btf_type *dtor_func, *dtor_func_proto;
> +                       const struct btf_param *args;
> +                       const char *dtor_func_name;
> +                       unsigned long addr;
> +                       s32 dtor_btf_id;
> +                       u32 nr_args;
> +
> +                       /* This call also serves as a whitelist of allowed objects that
> +                        * can be used as a referenced pointer and be stored in a map at
> +                        * the same time.
> +                        */
> +                       dtor_btf_id = btf_find_dtor_kfunc(off_btf, id);
> +                       if (dtor_btf_id < 0) {
> +                               ret = dtor_btf_id;
> +                               btf_put(off_btf);
> +                               goto end;
> +                       }
> +
> +                       dtor_func = btf_type_by_id(off_btf, dtor_btf_id);
> +                       if (!dtor_func || !btf_type_is_func(dtor_func)) {
> +                               ret = -EINVAL;
> +                               btf_put(off_btf);
> +                               goto end;
> +                       }
> +
> +                       dtor_func_proto = btf_type_by_id(off_btf, dtor_func->type);
> +                       if (!dtor_func_proto || !btf_type_is_func_proto(dtor_func_proto)) {
> +                               ret = -EINVAL;
> +                               btf_put(off_btf);
> +                               goto end;
> +                       }
> +
> +                       /* Make sure the prototype of the destructor kfunc is 'void func(type *)' */
> +                       t = btf_type_by_id(off_btf, dtor_func_proto->type);
> +                       if (!t || !btf_type_is_void(t)) {
> +                               ret = -EINVAL;
> +                               btf_put(off_btf);
> +                               goto end;
> +                       }
> +
> +                       nr_args = btf_type_vlen(dtor_func_proto);
> +                       args = btf_params(dtor_func_proto);
> +
> +                       t = NULL;
> +                       if (nr_args)
> +                               t = btf_type_by_id(off_btf, args[0].type);
> +                       /* Allow any pointer type, as width on targets Linux supports
> +                        * will be same for all pointer types (i.e. sizeof(void *))
> +                        */
> +                       if (nr_args != 1 || !t || !btf_type_is_ptr(t)) {
> +                               ret = -EINVAL;
> +                               btf_put(off_btf);
> +                               goto end;
> +                       }
> +
> +                       if (btf_is_module(btf)) {
> +                               mod = btf_try_get_module(off_btf);
> +                               if (!mod) {
> +                                       ret = -ENXIO;
> +                                       btf_put(off_btf);
> +                                       goto end;
> +                               }
> +                       }
> +
> +                       dtor_func_name = __btf_name_by_offset(off_btf, dtor_func->name_off);
> +                       addr = kallsyms_lookup_name(dtor_func_name);
> +                       if (!addr) {
> +                               ret = -EINVAL;
> +                               module_put(mod);
> +                               btf_put(off_btf);
> +                               goto end;
> +                       }
> +                       tab->off[i].dtor = (void *)addr;

Most of the above should probably be in register_btf_id_dtor_kfuncs().
It's best to fail early.
Here we'll just remember dtor function pointer to speed up release.
