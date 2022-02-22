Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA54BF09F
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 05:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiBVDcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 22:32:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVDcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 22:32:00 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8911D31D
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 19:31:36 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z2so5812450plg.8
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 19:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=26aoSD393Vad9xHOiG1DNV5ZDRAZAnhVBDpeunLQYb8=;
        b=H0chg6jnN2J1EBTFKqeWu5u0UvJD8vbJOSozXT1zVqtw6xl/HWlss3NUfj63oeUpIP
         WhwtUS1zEiKDmn/nLbqOELOGc/61tYjuj0cOh73ZuTkRL+Pxjo0cVDFEIZ7zmiZboQQp
         i12BCYxgBs5NIE5nNdC0S+VM8yusQTN8iI3ZG4qTWfGxUYyaPKRVzetvrjW9QlZD5/HW
         a5RrRIxmPLHnILq1pzLmWlxemmW8oTl9jnUMxFEXDLGzeOApmZtk+IjPQnzj4lsS3E7T
         7OWBRFlgB1ZdEW9G08zeGK0RWH+bzRt3rIiF5Uxu8Mcotf3+andSmBCmeP7nOgY4uJXt
         i9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26aoSD393Vad9xHOiG1DNV5ZDRAZAnhVBDpeunLQYb8=;
        b=M46HHLZqDJ2QSrzVn87UuhtXkg4U/DZvRatI4a3L4sMbWAE7bxNXJY+c2MwUZD3fNB
         yCQtp1Wr+Ujoag7pfjPwp7K5oCVHEIxWzhc5QHbnSxRaAXdHcGTIcSn8t36/FE7JLl88
         xipJS15RcqMabOwR5eVUUBnQJ1NSwRXoQnGqEN9NckdaGjQmJJgeC/ZKRhKl8btkQru5
         hUTQZ2Rc1EG4pqYAwWSOBtexRWvxnpwL6WSPvKWuOY4HoyiMLISrUuvtQPEBCPz6cZWl
         SyDLRM/qbwxEv1PBYP6fzpAr+WkO6T39+h+R6FX1W29Aq2A2BzKUOWKQRQTixQ2nZpXD
         8Q8A==
X-Gm-Message-State: AOAM533qsIWFV28rZFQAD0OsRcywM8blDJqNCd+VVGRUbiCasfjWrQ+k
        ljXy3s1HLkDXZgsz5gX/cQDksjSX+q4=
X-Google-Smtp-Source: ABdhPJywohDjA4rYe66WjBZgvpwGw9oAd7PVyMM5j1FBn+ZFRSisy7mj5K/hN6xgj4vkaI/dEWHpJg==
X-Received: by 2002:a17:902:9a8e:b0:14d:ae35:19f9 with SMTP id w14-20020a1709029a8e00b0014dae3519f9mr21333217plp.66.1645500695784;
        Mon, 21 Feb 2022 19:31:35 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id l7sm14002563pfu.47.2022.02.21.19.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:31:35 -0800 (PST)
Date:   Tue, 22 Feb 2022 09:01:32 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v1 1/5] bpf: Fix kfunc register offset check for
 PTR_TO_BTF_ID
Message-ID: <20220222033132.2ooqxlvld7xxrghm@apollo.legion>
References: <20220219113744.1852259-1-memxor@gmail.com>
 <20220219113744.1852259-2-memxor@gmail.com>
 <20220220022409.r5y2bovtgz3r2n47@ast-mbp.dhcp.thefacebook.com>
 <20220220024915.nohjpzvsn5bu2opo@apollo.legion>
 <CAADnVQJ-1D8f36EF-mQk_B_UmGyDbHZnEtYC_mNqt_yDncOCNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ-1D8f36EF-mQk_B_UmGyDbHZnEtYC_mNqt_yDncOCNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 22, 2022 at 02:06:15AM IST, Alexei Starovoitov wrote:
> On Sat, Feb 19, 2022 at 6:49 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sun, Feb 20, 2022 at 07:54:09AM IST, Alexei Starovoitov wrote:
> > > On Sat, Feb 19, 2022 at 05:07:40PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > >
> > > > +/* Caller ensures reg->type does not have PTR_MAYBE_NULL */
> > > > +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > > > +                      const struct bpf_reg_state *reg, int regno,
> > > > +                      bool arg_alloc_mem)
> > > > +{
> > > > +   enum bpf_reg_type type = reg->type;
> > > > +   int err;
> > > > +
> > > > +   WARN_ON_ONCE(type & PTR_MAYBE_NULL);
> > >
> > > So the warn was added and made things more difficult and check had to be moved
> > > into check_mem_reg to clear that flag?
> > > Why add that warn in the first place then?
> > > The logic get convoluted because of that.
> > >
> >
> > Ok, will drop.
> >
> > > > +   if (reg->off < 0) {
> > > > +           verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> > > > +                   reg_type_str(env, reg->type), regno, reg->off);
> > > > +           return -EACCES;
> > > > +   }
> > >
> > > Out of the whole patch this part is useful. The rest seems to dealing
> > > with self inflicted pain.
> > > Just call check_ptr_off_reg() for kfunc ?
> >
> > I still think we should call a common helper.
>
> What is the point of "common helper" when types
> with explicit allow of reg offset like PTR_TO_PACKET cannot
> be passed into kfuncs?
> A common helper would mislead the reader that such checks are necessary.
>

PTR_TO_PACKET is certainly allowed to be passed to kfunc, and not just that,
PTR_TO_STACK, PTR_TO_BUF, PTR_TO_MEM, PTR_TO_MAP_VALUE, PTR_TO_MAP_KEY, all are
permited after we set ptr_to_mem_ok = true for kfunc. And these can have fixed
off and sometimes var_off to be set. They are also allowed for global functions.

Which is why I thought having a single list in the entire verifier would be more
easier to maintain, then we can update it in one place and ensure both BPF
helpers and kfunc are covered by the same checks and expectations for fixed and
variable offsets. It isn't 'misleading' because all those types are also
permitted for kfuncs.

> >  For kfunc there are also reg->type
> > PTR_TO_SOCK etc., for them fixed offset should be rejected. So we can either
> > have a common helper like this for both kfunc and BPF helpers, or exposing
> > fixed_off_ok parameter in check_ptr_off_reg. Your wish.
>
> Are you saying that we should allow PTR_TO_SOCKET+fixed_off ?

No, I said we need to allow fixed off for PTR_TO_BTF_ID, but also prevent
var_off for it, but just using check_ptr_off_reg would not help because it
prevents fixed_off, and using __check_ptr_off_reg with fixed_off_ok == true
would be wrong for PTR_TO_SOCKET etc. Hence some refactoring is needed.

And using check_ptr_off_reg ultimately (through the common check or directly)
also rejects var_off for PTR_TO_BTF_ID, which was the actual problem that
started this whole patch.

> I guess than it's better to convert this line
>                 err = __check_ptr_off_reg(env, reg, regno,
>                                           type == PTR_TO_BTF_ID);
> into a helper.
> And convert this line:
> reg->type == PTR_TO_BTF_ID ||
>    (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type))
>
> into another helper.
> Like:
> static inline bool is_ptr_to_btf_id(type)
> {
>   return type == PTR_TO_BTF_ID ||
>    (reg2btf_ids[base_type(type)] && !type_flag(type));
> }
> and
> int check_ptr_off_reg(struct bpf_verifier_env *env,
>                       const struct bpf_reg_state *reg, int regno)
> {
>   return __check_ptr_off_reg(env, reg, regno, is_ptr_to_btf_id(reg->type));
> }
>
> and call check_ptr_off_reg() directly from check_func_arg()
> instead of __check_ptr_off_reg.
>
> and call check_ptr_off_reg() from btf_check_func_arg_match() too.

--
Kartikeya
