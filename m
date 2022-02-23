Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F329C4C0A16
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 04:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiBWDQa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 22:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiBWDQa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 22:16:30 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2175AEDF
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 19:16:03 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso906049pju.4
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 19:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/crZP71eJl9y0P9FwboRj7BiuT2+SmiIORcuK3GiRw0=;
        b=I416eO1mh7vq8UwpoPEx0Zfb999vvadrWDVgo5pi2tafkVr/GPgsHDeICfx4tdYS0k
         JkmcapOlnJawpaYFeA+LS4WP3kc5xe54OoBDmVrdKP7QC6RzS1mNLMAqZTatKCdnpkRh
         qw8bI7Cu05IgxtgE0KBAHf45g5LIHT2y0+XM8k9XOzmtiMEZYSnw66BqvRi9jbrfE24m
         E341Prr304O+R/mVrCH0PULk0mWm//Pu5Raw4ZENcw+IgXAsUSM/K6XxSZpPJjZx8j9g
         jBp3u0C5Z6so2OpFUbMvB/1hClBoCXi5obeteb1IroQ8NtU3Lx3EGIL2zhJsQwV8PTIA
         4Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/crZP71eJl9y0P9FwboRj7BiuT2+SmiIORcuK3GiRw0=;
        b=K0SwP3bg0w7v4RJ9h1boGia2OL79llCNROQJ+T5LIMV9DGcZs9DteLuvxpVtw30sKL
         hZNMRcPbLAuae534Om/Dnomuoq07zwGHUzuS6AOgFL92henBhX1Y+7qVrS7V39Tsnd/q
         45L9ojsjYSqij698GHL0NKDGjoqlS3O/2u19T5iWGLI3VYk0/zPeFySMMsBhWp30KNE4
         xnd6V54kHNZIUtjugrg+7kW4hjOV5r3tczph1VKIWEXQGJH9Ogg2CoptMmfLP1xV/WrI
         KxK37U3Q4y2DaMDYOXscJF9CGvPyVN3wybhx6/rNcifazfywcWSg0HJJUw9ayfnWjhgk
         KTIw==
X-Gm-Message-State: AOAM532+iRrf//IXu34ZL1mRa4XmpdCo0P2eEpBqKZT5W+K4Vg8q6haw
        foHyS/mdYMIZkdNk/zwJW+o=
X-Google-Smtp-Source: ABdhPJyeMDOCYeypqJY/G11Xm4wliHSgnmTD36/a4UXKF0Hwi3jB6rFMWt3uXVpSC5EZUFbR2Pah6g==
X-Received: by 2002:a17:90a:5a85:b0:1bc:8bda:6a42 with SMTP id n5-20020a17090a5a8500b001bc8bda6a42mr3270288pji.4.1645586162716;
        Tue, 22 Feb 2022 19:16:02 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id o8sm19891906pfu.90.2022.02.22.19.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 19:16:02 -0800 (PST)
Date:   Wed, 23 Feb 2022 08:46:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v1 1/5] bpf: Fix kfunc register offset check for
 PTR_TO_BTF_ID
Message-ID: <20220223031600.pvbhu3dbwxke4eia@apollo.legion>
References: <20220219113744.1852259-1-memxor@gmail.com>
 <20220219113744.1852259-2-memxor@gmail.com>
 <20220220022409.r5y2bovtgz3r2n47@ast-mbp.dhcp.thefacebook.com>
 <20220220024915.nohjpzvsn5bu2opo@apollo.legion>
 <CAADnVQJ-1D8f36EF-mQk_B_UmGyDbHZnEtYC_mNqt_yDncOCNg@mail.gmail.com>
 <20220222033132.2ooqxlvld7xxrghm@apollo.legion>
 <CAADnVQJ51KcMWnUwcwqmjm_fWShjZeOsOWEGQLX-htWKWixgrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ51KcMWnUwcwqmjm_fWShjZeOsOWEGQLX-htWKWixgrw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 22, 2022 at 09:51:43AM IST, Alexei Starovoitov wrote:
> On Mon, Feb 21, 2022 at 7:31 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, Feb 22, 2022 at 02:06:15AM IST, Alexei Starovoitov wrote:
> > > On Sat, Feb 19, 2022 at 6:49 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Sun, Feb 20, 2022 at 07:54:09AM IST, Alexei Starovoitov wrote:
> > > > > On Sat, Feb 19, 2022 at 05:07:40PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > >
> > > > > > +/* Caller ensures reg->type does not have PTR_MAYBE_NULL */
> > > > > > +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > > > > > +                      const struct bpf_reg_state *reg, int regno,
> > > > > > +                      bool arg_alloc_mem)
> > > > > > +{
> > > > > > +   enum bpf_reg_type type = reg->type;
> > > > > > +   int err;
> > > > > > +
> > > > > > +   WARN_ON_ONCE(type & PTR_MAYBE_NULL);
> > > > >
> > > > > So the warn was added and made things more difficult and check had to be moved
> > > > > into check_mem_reg to clear that flag?
> > > > > Why add that warn in the first place then?
> > > > > The logic get convoluted because of that.
> > > > >
> > > >
> > > > Ok, will drop.
> > > >
> > > > > > +   if (reg->off < 0) {
> > > > > > +           verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> > > > > > +                   reg_type_str(env, reg->type), regno, reg->off);
> > > > > > +           return -EACCES;
> > > > > > +   }
> > > > >
> > > > > Out of the whole patch this part is useful. The rest seems to dealing
> > > > > with self inflicted pain.
> > > > > Just call check_ptr_off_reg() for kfunc ?
> > > >
> > > > I still think we should call a common helper.
> > >
> > > What is the point of "common helper" when types
> > > with explicit allow of reg offset like PTR_TO_PACKET cannot
> > > be passed into kfuncs?
> > > A common helper would mislead the reader that such checks are necessary.
> > >
> >
> > PTR_TO_PACKET is certainly allowed to be passed to kfunc, and not just that,
> > PTR_TO_STACK, PTR_TO_BUF, PTR_TO_MEM, PTR_TO_MAP_VALUE, PTR_TO_MAP_KEY, all are
> > permited after we set ptr_to_mem_ok = true for kfunc. And these can have fixed
> > off and sometimes var_off to be set. They are also allowed for global functions.
>
> Ahh. Right. The whole check inside check_mem_reg dance confused me.
>
> > Which is why I thought having a single list in the entire verifier would be more
> > easier to maintain, then we can update it in one place and ensure both BPF
> > helpers and kfunc are covered by the same checks and expectations for fixed and
> > variable offsets. It isn't 'misleading' because all those types are also
> > permitted for kfuncs.
> >
> > > >  For kfunc there are also reg->type
> > > > PTR_TO_SOCK etc., for them fixed offset should be rejected. So we can either
> > > > have a common helper like this for both kfunc and BPF helpers, or exposing
> > > > fixed_off_ok parameter in check_ptr_off_reg. Your wish.
> > >
> > > Are you saying that we should allow PTR_TO_SOCKET+fixed_off ?
> >
> > No, I said we need to allow fixed off for PTR_TO_BTF_ID, but also prevent
> > var_off for it, but just using check_ptr_off_reg would not help because it
> > prevents fixed_off, and using __check_ptr_off_reg with fixed_off_ok == true
> > would be wrong for PTR_TO_SOCKET etc. Hence some refactoring is needed.
> >
> > And using check_ptr_off_reg ultimately (through the common check or directly)
> > also rejects var_off for PTR_TO_BTF_ID, which was the actual problem that
> > started this whole patch.
> >
> > > I guess than it's better to convert this line
> > >                 err = __check_ptr_off_reg(env, reg, regno,
> > >                                           type == PTR_TO_BTF_ID);
> > > into a helper.
> > > And convert this line:
> > > reg->type == PTR_TO_BTF_ID ||
> > >    (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type))
> > >
> > > into another helper.
> > > Like:
> > > static inline bool is_ptr_to_btf_id(type)
> > > {
> > >   return type == PTR_TO_BTF_ID ||
> > >    (reg2btf_ids[base_type(type)] && !type_flag(type));
> > > }
> > > and
> > > int check_ptr_off_reg(struct bpf_verifier_env *env,
> > >                       const struct bpf_reg_state *reg, int regno)
> > > {
> > >   return __check_ptr_off_reg(env, reg, regno, is_ptr_to_btf_id(reg->type));
> > > }
> > >
> > > and call check_ptr_off_reg() directly from check_func_arg()
> > > instead of __check_ptr_off_reg.
> > >
> > > and call check_ptr_off_reg() from btf_check_func_arg_match() too.
>
> Thoughts about the above proposal?
> In addition to above we can have check_func_arg_reg_off()
> and call it early and once in btf_check_func_arg_match()
> instead of hiding deep in a call chain.
> I don't like 'bool arg_alloc_mem' part though
> and would like to get rid of 'bool ptr_to_mem_ok' eventually as well.
> Such flags make the code harder to follow,
> since the action on the flag value is done outside
> of the main part of the code.
> For example reading btf_check_func_arg_match() on its own is complicated.
> The developer has to examine all call sites to see how they pass that flag.
> Same thing with 'bool arg_alloc_mem'.
> Please pass arg_type instead.
>
> This patch should be split into three.
> p1 - refactor into check_func_arg_reg_off helper.
> p2 - call it form btf_check_func_arg_match
> p3 - add off < 0 check.
>
> If you're adding "while at it" to the commit log it means that
> it shouldn't be a single patch.

Agree with everything, will split and respin. Thanks.

--
Kartikeya
