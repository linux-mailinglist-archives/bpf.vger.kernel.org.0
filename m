Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C25603970
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 07:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJSF6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 01:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJSF6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 01:58:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4DC558F5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:58:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so15958024pls.4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtC3FkRHvfZ3xA2WpUxb157ArIdWTntY1lennyxNxdQ=;
        b=DTYhD6Ri+hb1NWg/6HF5RsEIjmrUFiWGinwPsdgZZO5TLBP9Ur240XxAQOXq9GyfuD
         G6CNAOCoA9O3TDCRYIIRMSvnIK3RxUUneSkSKO8IAbMhXaXFtLeWAmW8Lxndwy2t330a
         qpZwZVXvjbVZLiZ9TF26Ry5snw7x6nqYRJbnfljGViF4G1YqVRCqtuGAO/Y6xGl8f0QE
         kVNZ/iAsyY0R+BsCScJiuXO6peO4KVjdxqCcmYkqdjR9Gj9eE44YGfSf532IsrQExMsl
         DF58TMQdGluklgihXEbqcQxT39owx9fXDJ4xRkXw1Hpj4CVlMH9yZHbNeybfNuk4DVwc
         qscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtC3FkRHvfZ3xA2WpUxb157ArIdWTntY1lennyxNxdQ=;
        b=OnSieDDp2am2RW5tp3KgJ+8nzBYoECkqy5Gb5mwjzK1fZq6KeafpKEPH8LfsKlprqn
         H6hHsBcp8xm75m8JlYdjd4QL2UjuRcHmukuB8oPUgqWGgwDyGmP5GAevMIW2saawfghf
         ddDIFgVZ8bxXD81Q9ptMe4rzQfbYD1fZ3IjeZhyXUmApajzi/qCgOp2ewTrBmB0RUcSP
         5qm0fcSkc5ZK5cJ+r2LZzSm3ZhK8mZsuopi5CBLSGI8gt++Iccn8L6InZS9muZ9fxeMO
         wjV85NOa120/a0wd+jdPtveHDa81dfBnaVEunKHr3YqGfHiCxbNnyw2Wff24L2Rfibs5
         H48Q==
X-Gm-Message-State: ACrzQf3wGVh5gm2XK5ComRMXN++2DnKn58W7wmMccq5HsYc6c8TnU4+p
        jC9a6h3yVKFg9skzCfd3oPw=
X-Google-Smtp-Source: AMsMyM4vfL4fYJntGngwbjHFdQcByUDluYmc4D/ElVELkMGYP6bXRN/ySuqdGcqQj45J5715jwdlLA==
X-Received: by 2002:a17:90b:1d0e:b0:20d:a61f:84b1 with SMTP id on14-20020a17090b1d0e00b0020da61f84b1mr35346106pjb.172.1666159129308;
        Tue, 18 Oct 2022 22:58:49 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a64c600b001f8c532b93dsm9092218pjm.15.2022.10.18.22.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:58:48 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:28:34 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 19/25] bpf: Introduce bpf_kptr_new
Message-ID: <20221019055834.ux5dfoot7hyuf4jk@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-20-memxor@gmail.com>
 <20221019023124.47zzi3gs2zcdvxca@macbook-pro-4.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019023124.47zzi3gs2zcdvxca@macbook-pro-4.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 08:01:24AM IST, Alexei Starovoitov wrote:
> On Thu, Oct 13, 2022 at 11:52:57AM +0530, Kumar Kartikeya Dwivedi wrote:
> > +void *bpf_kptr_new_impl(u64 local_type_id__k, u64 flags, void *meta__ign)
> > +{
> > +	struct btf_struct_meta *meta = meta__ign;
> > +	u64 size = local_type_id__k;
> > +	void *p;
> > +
> > +	if (unlikely(flags || !bpf_global_ma_set))
> > +		return NULL;
>
> Unused 'flags' looks weird in unstable api. Just drop it?
> And keep it as:
> void *bpf_kptr_new(u64 local_type_id__k, struct btf_struct_meta *meta__ign);
>
> and in bpf_experimental.h:
>
> extern void *bpf_kptr_new(__u64 local_type_id) __ksym;
>
> since __ign args are ignored during kfunc type match
> the bpf progs can use it without #define.
>

It's ignored during check_kfunc_call, but libbpf doesn't ignore that. The
prototypes will not be the same. I guess I'll have to teach it do that during
type match, but IDK how you feel about that.

Otherwise unless you want people to manually pass something to the ignored
argument, we have to hide it behind a macro.

I actually like the macro on top, then I don't even pass the type ID but the
type. But that's a personal preference, and I don't feel strongly about it.

So in C one does malloc(sizeof(*p)), here we'll just write
bpf_kptr_new(typeof(*p)). YMMV.

> > +	p = bpf_mem_alloc(&bpf_global_ma, size);
> > +	if (!p)
> > +		return NULL;
> > +	if (meta)
> > +		bpf_obj_init(meta->off_arr, p);
>
> I'm starting to dislike all that _arr and _tab suffixes in the verifier code base.
> It reminds me of programming style where people tried to add types into
> variable names. imo dropping _arr wouldn't be just fine.

Ack, I'll do it in v3.

Also, I'd like to invite people to please bikeshed a bit over the naming of the
APIs, e.g. whether it should be bpf_kptr_drop vs bpf_kptr_delete.

In the BPF list API, it's named bpf_list_del but it's actually distinct from how
list_del in the kernel works. So it does make sense to give them a different
name (like pop_front/pop_back and push_front/push_back)?

Because even bpf_list_add takes bpf_list_head, in the kernel there's no
distinction between node and head, so you can do list_add on a node as well, but
it won't be possible with the kfunc (unless we overload the head argument to
also work with nodes).

Later we'll probably have to add bpf_list_node_add etc. that add before or after
a node to make that work.

The main question is whether it should closely resembly the linked list API in
the kernel, or can it steer away considerably from that?
