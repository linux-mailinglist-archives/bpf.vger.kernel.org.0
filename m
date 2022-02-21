Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4304BEBED
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 21:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiBUUgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 15:36:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiBUUgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 15:36:50 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1C237D2
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 12:36:26 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 132so15232388pga.5
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 12:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpUxuLTBHfOD8R1tB/pLEMruDJTvSn+RjnSlg19SuZ0=;
        b=Kh4zFj+1eIHukIvlHwvuwwE9w5HzqzK1LTCHLpA0ORQFK9ejaSXKLtTY+0XYH2iQTX
         bRZp1eXdUWIj0eNgejMvLIuoEA7FT3YZLshA+Q1zosM+FuK5cBJFoG7M7hE0EtAxB/RS
         SNqyC9sR4EWejtcQHAL8Ob5x+qL+E9G9ReO8t/0hqu+hed3IfC0djoEh0pd3LKTkB4lR
         KVPCAdrUnAnM/YQ5X/INRgKbaUwiEHD4QL4KEUqzqAdRrXk2d4zpQbfM+ECIjbBSpbn+
         1gKc3SlMcUXq0SfXW3CBH3nSkbHbz+8Zuswa7ofolksDLyEFgpOkWNbR8Lc8yq5qz4+Y
         xvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpUxuLTBHfOD8R1tB/pLEMruDJTvSn+RjnSlg19SuZ0=;
        b=0+9rINhtri/QdylvCQbsV0/1tAUJ8Vi7kPnz5hwBBWdd5u7VyMqXw/Rv/x/SLNlaED
         VdwLIM4V3erPRtnYcYRBkP/7Nnox5bDKExhmzXAtxtbsxRYWlOit+4L/FjL/Zwalymxy
         h/fJHfpFFIiTZBfHi8EPS7Ve2IBp9LJEwRsiTxcyAYM35gUqzWlMnrb5E9LEqxNG+Zyz
         tJTDTmI7JGVRYPOGwmjNPb7SdGpT6+Lmep6CW7fQooEBCWreJqxY8Y9Bq6nt+ANBs+ck
         HC6HngP6A7JYGTKSSzme5mwLioKpfMZMPvHfQRm7dEKKSuATxcPEtueBhLCSSS1MFDn5
         XQIg==
X-Gm-Message-State: AOAM533uU1AB9tb9d2gHBN4p9D04tPRvmhzcJ3g/rkS49jh8Lw2sJdIl
        zzUkwVa03z/FdCuYqGqjjDjBaYW0OhrqPtqiquA=
X-Google-Smtp-Source: ABdhPJzMK7+yS57C692K7vhvj4d8pbF63aFFprwgc3ncra751FjVgFVJATE8t83+UiqRT6Zes0EoOWQ5Iic3NHOuQvI=
X-Received: by 2002:a63:602:0:b0:373:efe4:8a24 with SMTP id
 2-20020a630602000000b00373efe48a24mr11907624pgg.287.1645475786241; Mon, 21
 Feb 2022 12:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20220219113744.1852259-1-memxor@gmail.com> <20220219113744.1852259-2-memxor@gmail.com>
 <20220220022409.r5y2bovtgz3r2n47@ast-mbp.dhcp.thefacebook.com> <20220220024915.nohjpzvsn5bu2opo@apollo.legion>
In-Reply-To: <20220220024915.nohjpzvsn5bu2opo@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Feb 2022 12:36:15 -0800
Message-ID: <CAADnVQJ-1D8f36EF-mQk_B_UmGyDbHZnEtYC_mNqt_yDncOCNg@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/5] bpf: Fix kfunc register offset check for PTR_TO_BTF_ID
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
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

On Sat, Feb 19, 2022 at 6:49 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sun, Feb 20, 2022 at 07:54:09AM IST, Alexei Starovoitov wrote:
> > On Sat, Feb 19, 2022 at 05:07:40PM +0530, Kumar Kartikeya Dwivedi wrote:
> > >
> > > +/* Caller ensures reg->type does not have PTR_MAYBE_NULL */
> > > +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > > +                      const struct bpf_reg_state *reg, int regno,
> > > +                      bool arg_alloc_mem)
> > > +{
> > > +   enum bpf_reg_type type = reg->type;
> > > +   int err;
> > > +
> > > +   WARN_ON_ONCE(type & PTR_MAYBE_NULL);
> >
> > So the warn was added and made things more difficult and check had to be moved
> > into check_mem_reg to clear that flag?
> > Why add that warn in the first place then?
> > The logic get convoluted because of that.
> >
>
> Ok, will drop.
>
> > > +   if (reg->off < 0) {
> > > +           verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> > > +                   reg_type_str(env, reg->type), regno, reg->off);
> > > +           return -EACCES;
> > > +   }
> >
> > Out of the whole patch this part is useful. The rest seems to dealing
> > with self inflicted pain.
> > Just call check_ptr_off_reg() for kfunc ?
>
> I still think we should call a common helper.

What is the point of "common helper" when types
with explicit allow of reg offset like PTR_TO_PACKET cannot
be passed into kfuncs?
A common helper would mislead the reader that such checks are necessary.

>  For kfunc there are also reg->type
> PTR_TO_SOCK etc., for them fixed offset should be rejected. So we can either
> have a common helper like this for both kfunc and BPF helpers, or exposing
> fixed_off_ok parameter in check_ptr_off_reg. Your wish.

Are you saying that we should allow PTR_TO_SOCKET+fixed_off ?
I guess than it's better to convert this line
                err = __check_ptr_off_reg(env, reg, regno,
                                          type == PTR_TO_BTF_ID);
into a helper.
And convert this line:
reg->type == PTR_TO_BTF_ID ||
   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type))

into another helper.
Like:
static inline bool is_ptr_to_btf_id(type)
{
  return type == PTR_TO_BTF_ID ||
   (reg2btf_ids[base_type(type)] && !type_flag(type));
}
and
int check_ptr_off_reg(struct bpf_verifier_env *env,
                      const struct bpf_reg_state *reg, int regno)
{
  return __check_ptr_off_reg(env, reg, regno, is_ptr_to_btf_id(reg->type));
}

and call check_ptr_off_reg() directly from check_func_arg()
instead of __check_ptr_off_reg.

and call check_ptr_off_reg() from btf_check_func_arg_match() too.
