Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBF4D6AC6
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiCKWzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 17:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiCKWzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 17:55:08 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5672A25D20A
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 14:42:35 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id j29so7006055ila.4
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 14:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+hL8rV7q3DyjbzisQadibVPVfCUIViElitkx0FtpFg=;
        b=KZrgMj6brxB45N/zqeGjt2Cwne2ePFzmWfYqb0lCtPkjFcF3azUNcThQpHzwp1oI1W
         +a4FfsVJVBBUTUI1385F1bN7qonmAmA5K7V1BKW/K9ejTdWDETSNtqnOLA4FHIXB4MXJ
         PAiGiqe7dZR6feckmcW0FvA6unKWfFvirGl6hor1oqyTwJ3+ktwHnzTaYzVJHXoCQAZp
         jhZldOQugT9p5PJ9vR+jxaRfmgj7lbd5TAMfKhBMlmuiH0UFTr6fCEhlb1RJi01e1ZWf
         JjRkNasHC2JlAPex+DkM5zwO2U4hYfAXpSRYfK3W0ZWlmWI8L6qbZizOJ+ubW5NIJb9i
         kvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+hL8rV7q3DyjbzisQadibVPVfCUIViElitkx0FtpFg=;
        b=BrNEHOGWohoQ4TSGia1+BtyBZrhlPXJNPSrUEykZa53BCJbYrAjOuSLkvVBhV+Ff/v
         Wi/+PSYKmX88loXFL0ig+ipQDMwwXZ2AHOH7pHsSXKNHKDZuN2Z6cdRXR+N/gldLCqsq
         TExQG5xFojVWiNiJqMDWNJhi7RSm3Oc4VVQcSNLoqNOOWw2xmJI565rPap0sK3QiRmRf
         9LNnbCkR5oOhHqJbMeJfkJFhnHcJetOOefzinwORSuWevybdVNh/8Uby2D4fj4u5x4o3
         Wbcz2scm+Jwq2JGsfcDtg5A62uh57mtAlHYXFrCjuCKmmrp1FjrJT+4Z2HAZRzydDH5e
         pfIQ==
X-Gm-Message-State: AOAM533FIe2BerT31bQzoSzQ82Tti/6a39bNorATJCOXyhYMuOjXIy3I
        /qFQV9pcQr0baO/BH98le0LSGs0IQXn71Tzd1Ek=
X-Google-Smtp-Source: ABdhPJz0WWJHcbPkkiVfo51+6M1W0UPg14QhDWoLi9c7RAezNK5jkhViiQKY8rED3cwQM1aD7aaI02Y75kIEKBrEF+0=
X-Received: by 2002:a92:c5aa:0:b0:2c5:f753:9069 with SMTP id
 r10-20020a92c5aa000000b002c5f7539069mr9320827ilt.71.1647038554708; Fri, 11
 Mar 2022 14:42:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <6d868b6effca2549681a9e42ccbdd71aac6287e8.1646957399.git.delyank@fb.com>
In-Reply-To: <6d868b6effca2549681a9e42ccbdd71aac6287e8.1646957399.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 14:42:23 -0800
Message-ID: <CAEf4BzbALV8o+dMjdW3fztBVa7Xq1sfgt6u8D79rQ4SWEJt7Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: init btf_{key,value}_type_id on
 internal map open
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Thu, Mar 10, 2022 at 4:12 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> For internal maps, look up the key and value btf types on
> open() and not load(), so that `bpf_map_btf_value_type_id`
> is usable in `bpftool gen`.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b6f11ce0d6bc..3fb9c926fe6e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1517,6 +1517,9 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
>         return strdup(map_name);
>  }
>
> +static int
> +bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map);
> +
>  static int
>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>                               const char *real_name, int sec_idx, void *data, size_t data_sz)
> @@ -1564,6 +1567,11 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>                 return err;
>         }
>
> +       err = bpf_map_find_btf_info(obj, map);

is there any reason to still do bpf_map_find_btf_info() in
bpf_object__create_map()? It's also non-uniform, legacy user maps
won't have btf_key_type_id/btf_value_type_id set until load, while
internal maps (and BTF-defined maps) will. Let's make it uniform and
call bpf_map_find_btf_info() from bpf_object__init_user_maps() early
on as well (and not do that at all in bpf_object__create_map())

> +       /* intentionally ignoring err, failures are fine because of
> +        * maps like .rodata.str1.1
> +        */

if the intention is to explicitly ignore error, then the most explicit
way to express this is:

(void)func_that_can_return_error(...);

> +
>         if (data)
>                 memcpy(map->mmaped, data, data_sz);
>
> --
> 2.34.1
