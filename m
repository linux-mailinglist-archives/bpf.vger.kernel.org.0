Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4960A5537B1
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351773AbiFUQPr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbiFUQPr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 12:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCFECE29
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B23E61455
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732C0C341C0
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655828145;
        bh=TaD1kh/EZbrNWNO+8Id05vwOi58GQwGCbkvT6ynmKpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Id5Srzj4foUzmuMZXzbFwVYWILgx1lkNot8vMmc9FBcf/JwnxWGX0J0sXYnI5mc9B
         DvFE4tDeRC3d3XVxz+kSoYNppuBPpPh7Yu8/jWW+jErrMLFvQn3Y4rkRFETk81w8WV
         JKjazRSBaM25xUt5SBgb+R9HLIhWoxJTqfWw4liYNLglcf9axNiTjDQHPSRTr6RYme
         E3PrNQugCI+oxQjYa4dl0gsrT1Dv8xvztFfQvVOIsBV2JVyMxSqwdewPECgbsYELX/
         fNRCnYDW3xHQMYGM1HCM7ErgzysQjjSOGojZjggfROEncWPHJEHcgXyiwh60cElR7V
         NoL0me6eTjYWg==
Received: by mail-yb1-f177.google.com with SMTP id l66so23859388ybl.10
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:15:45 -0700 (PDT)
X-Gm-Message-State: AJIora9khtyY7q4rAZjJ0v9oCJvbgKZ0qGjfwfoW5FJopYnPG42Dcx1U
        GTm+4a3+3kznycWdMMgN2K8ctOkZyxfPRRi58VUcRw==
X-Google-Smtp-Source: AGRyM1skewrImzjwL+kD2OXnZWPsE6Lxy0NG4b3/zLxt1P3sKABU+1xevJ1oANCz6UpA+hhYhbDkmt5ma8rWKXbQ6bQ=
X-Received: by 2002:a5b:74a:0:b0:669:3f60:9bcd with SMTP id
 s10-20020a5b074a000000b006693f609bcdmr7880382ybq.404.1655828144564; Tue, 21
 Jun 2022 09:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220621012811.2683313-1-kpsingh@kernel.org> <20220621012811.2683313-3-kpsingh@kernel.org>
 <20220621125021.na2lctgyqs6ybto2@apollo.legion>
In-Reply-To: <20220621125021.na2lctgyqs6ybto2@apollo.legion>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Jun 2022 18:15:32 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6MiSsRx5XWDQPt8EuFTKKiTyRDXUUr9s4eH_OWppT=4g@mail.gmail.com>
Message-ID: <CACYkzJ6MiSsRx5XWDQPt8EuFTKKiTyRDXUUr9s4eH_OWppT=4g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 2:50 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 06:58:08AM IST, KP Singh wrote:
> > kfuncs can handle pointers to memory when the next argument is
> > the size of the memory that can be read and verify these as
> > ARG_CONST_SIZE_OR_ZERO
> >
> > Similarly add support for string constants (const char *) and
> > verify it similar to ARG_PTR_TO_CONST_STR.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---

[...]

> >                       if (is_kfunc) {
> >                               bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> > @@ -6354,6 +6375,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                                * When arg_mem_size is true, the pointer can be
> >                                * void *.
> >                                */
> > +                             if (btf_param_is_const_str_ptr(btf, &args[i])) {
>
> Here, we need to check whether reg is a PTR_TO_MAP_VALUE, otherwise in
> check_const_str, reg->map_ptr may be NULL. Probably best to do it in
> btf_param_is_const_str_ptr itself.

I added it to the check_const_str as:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14a434792d7b..5300e022398a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5843,12 +5843,16 @@ static u32 stack_slot_get_id(struct
bpf_verifier_env *env, struct bpf_reg_state
 int check_const_str(struct bpf_verifier_env *env,
                    const struct bpf_reg_state *reg, int regno)
 {
-       struct bpf_map *map = reg->map_ptr;
+       struct bpf_map *map;
        int map_off;
        u64 map_addr;
        char *str_ptr;
        int err;

+       if (reg->type != PTR_TO_MAP_VALUE)
+               return -EACCES;
+
+       map = reg->map_ptr;
        if (!bpf_map_is_rdonly(map)) {
                verbose(env, "R%d does not point to a readonly map'\n", regno);
                return -EACCES;

>
> > +                                     err = check_const_str(env, reg, regno);
> > +                                     if (err < 0)
> > +                                             return err;
> > +                                     i++;
> > +                                     continue;
> > +                             }

[...]

> > --
> > 2.37.0.rc0.104.g0611611a94-goog
> >

>
> --
> Kartikeya
