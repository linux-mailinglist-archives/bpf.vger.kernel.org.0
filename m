Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49938604D73
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJSQbi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSQbh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 12:31:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54615F335
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 09:31:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so41296796ejr.2
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzwrkDuFpARPQBLHkeuxXMN2tnLqTO3Q+KR9a8q5n9M=;
        b=Guy676hx6L0iOTXjPp76xayeQSblWF2F1oB+2mmKXUpOr7+ZAklasQiSMTomEMAVMv
         g2ECUvPX54m09Vapg3puiq/zfvuhoz7hq8AO7YMFfR8o2aWpdqe+b1U9/lDQz5ycXq2v
         JirWdj+YNnwdRDSmwTN+ti+nKsl6Rq98il+kY29VwEzDvkgizbhtrjrp0ROI4bIqAL9i
         sU0rutfU4v97DYUWgEQAL6c7eU4OFTuv7EfpY2Us0DH2Kcg4vditfehIb65XDiHF6XrH
         +LZIrY3FgqbMB+doO2GkR0wNCHxwiimnzj4KcISa6+OwHKnBKV3cqWqKrBEDEPccUEAI
         PZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzwrkDuFpARPQBLHkeuxXMN2tnLqTO3Q+KR9a8q5n9M=;
        b=U4Qzn0be/Lh9A6AOoIOidBCfidweOIRvXXV4QLplkSqx54EBl8MtU7nMnBA8X2AxEe
         vcrO/owpK+rbH07WWVzraeroeJWVKUPiWpQi1gocm0gOqfV/AX6OYkqI0AayFbRZayNu
         bcFvwJ1MX2JY7O+2FvZeDmXllLYCmrDTql+fNeNXhfk6qW7LUNPRmUSIJaqIMs+Jjn7t
         Fb09FzrCqGvpcQHOlJETLANNVvrXe6VwKEuOpUzgZ/Frufg3OjZxVUjTz596Xgdb5WJs
         HCaO1CVqyYqzO1OQxek+eZt0Zbs7pvJ4Gn1/eMqKzppzH6xfWIza+RsKrFsw+G7eKHFt
         pH2g==
X-Gm-Message-State: ACrzQf37HtC5qgbzQ/l39pG5HtEfzy0RBwGtFX1jElOM7AoXgvQGm3QD
        Cbrgmg0m6LISSMAe9Jb9Jegk5FrW2UJDc+rSrNk=
X-Google-Smtp-Source: AMsMyM5FKLwmg4NoJUGusC0cd1g/FLHyfzeRzqP3Zt8ElWDkP8nkvk8el7Ny3miEAUT6cB4cnnC4xW42bSlAUNPGyz4=
X-Received: by 2002:a17:907:2cd8:b0:78d:9c3c:d788 with SMTP id
 hg24-20020a1709072cd800b0078d9c3cd788mr7654698ejc.327.1666197093236; Wed, 19
 Oct 2022 09:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221013062303.896469-1-memxor@gmail.com> <20221013062303.896469-20-memxor@gmail.com>
 <20221019023124.47zzi3gs2zcdvxca@macbook-pro-4.dhcp.thefacebook.com> <20221019055834.ux5dfoot7hyuf4jk@apollo>
In-Reply-To: <20221019055834.ux5dfoot7hyuf4jk@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 09:31:21 -0700
Message-ID: <CAADnVQ+Q9LO1dkz-Q7jHRjgf5cFFk1go=gwYDfVrTtanjMCoHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 19/25] bpf: Introduce bpf_kptr_new
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 10:58 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 08:01:24AM IST, Alexei Starovoitov wrote:
> > On Thu, Oct 13, 2022 at 11:52:57AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > +void *bpf_kptr_new_impl(u64 local_type_id__k, u64 flags, void *meta__ign)
> > > +{
> > > +   struct btf_struct_meta *meta = meta__ign;
> > > +   u64 size = local_type_id__k;
> > > +   void *p;
> > > +
> > > +   if (unlikely(flags || !bpf_global_ma_set))
> > > +           return NULL;
> >
> > Unused 'flags' looks weird in unstable api. Just drop it?
> > And keep it as:
> > void *bpf_kptr_new(u64 local_type_id__k, struct btf_struct_meta *meta__ign);
> >
> > and in bpf_experimental.h:
> >
> > extern void *bpf_kptr_new(__u64 local_type_id) __ksym;
> >
> > since __ign args are ignored during kfunc type match
> > the bpf progs can use it without #define.
> >
>
> It's ignored during check_kfunc_call, but libbpf doesn't ignore that. The
> prototypes will not be the same. I guess I'll have to teach it do that during
> type match, but IDK how you feel about that.

libbpf does the full type match, really?
Could you point me to the code?

> Otherwise unless you want people to manually pass something to the ignored
> argument, we have to hide it behind a macro.
>
> I actually like the macro on top, then I don't even pass the type ID but the
> type. But that's a personal preference, and I don't feel strongly about it.
>
> So in C one does malloc(sizeof(*p)), here we'll just write
> bpf_kptr_new(typeof(*p)). YMMV.

bpf_kptr_new(typeof(*p)) is cleaner.

> > > +   p = bpf_mem_alloc(&bpf_global_ma, size);
> > > +   if (!p)
> > > +           return NULL;
> > > +   if (meta)
> > > +           bpf_obj_init(meta->off_arr, p);
> >
> > I'm starting to dislike all that _arr and _tab suffixes in the verifier code base.
> > It reminds me of programming style where people tried to add types into
> > variable names. imo dropping _arr wouldn't be just fine.
>
> Ack, I'll do it in v3.
>
> Also, I'd like to invite people to please bikeshed a bit over the naming of the
> APIs, e.g. whether it should be bpf_kptr_drop vs bpf_kptr_delete.

bpf_kptr_drop is more precise.
delete assumes instant free which is not the case here.

How about
extern void *__bpf_obj_new(__u64 local_type_id) __ksym;
extern void bpf_obj_drop(void *obj) __ksym;
#define bpf_obj_new(t) \
 (t *)__bpf_obj_new(bpf_core_type_id_local(t));

kptr means 'kernel pointer'.
Here we have program supplied object.
It feels 'obj' is better than 'kptr' in this context.

> In the BPF list API, it's named bpf_list_del but it's actually distinct from how
> list_del in the kernel works. So it does make sense to give them a different
> name (like pop_front/pop_back and push_front/push_back)?
>
> Because even bpf_list_add takes bpf_list_head, in the kernel there's no
> distinction between node and head, so you can do list_add on a node as well, but
> it won't be possible with the kfunc (unless we overload the head argument to
> also work with nodes).
>
> Later we'll probably have to add bpf_list_node_add etc. that add before or after
> a node to make that work.
>
> The main question is whether it should closely resembly the linked list API in
> the kernel, or can it steer away considerably from that?

If we do doubly linked list we should allow delete in
the middle with
bpf_list_del_any(head, node)

and
bpf_list_pop_front/pop_back(head)

bpf_list_add(node, head) would match kernel style,
but I think it's cleaner to have head as 1st arg.
In that sense new pop/push/_front/_back are cleaner.
And similar for rbtree.

If we keep (node, head) and (rb_node, rb_root) order
we should keep kernel names.
