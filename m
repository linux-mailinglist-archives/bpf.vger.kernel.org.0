Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBEF6054B7
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJTBMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJTBMH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 21:12:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FA617C146
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:11:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d26so43861279eje.10
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcu479kc6NvYv2KgLz5QqJmo9d00RDK3GRjOQ0eShjg=;
        b=GQSedGLp6HJEEXU/ICBqs/FiNo7i/MPPNR4HnHwMTcezG4OCTmr8h9xxUF9+Q+aR9D
         ynh+09fgKxhTGdZLniUe5LkNVwkX0OEzOxkC96YRCbORDDcJFBaMCnxuQGTNl8PrkPun
         7C+LTtK8OjOYIB+D8ZU3bKW+Oz1/I+L31SRSQQKHOa+mCYHCwrM3vgsBW0aLU+JFyhY3
         t5CkJvAIoREhxkOOwWsjqje9DZexLAyi09FKj4q2kVJFN+cHAJutLU5Xr3zaov6yV/QJ
         0aI7M24NiYdxRLQPZwiqKT/VxlbCPDNlflgKIb8uMAbzZCN2XczkiNJG0Pz88sP24C3Q
         AdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcu479kc6NvYv2KgLz5QqJmo9d00RDK3GRjOQ0eShjg=;
        b=6fxv9LqLUG5pHpep8lNt0FnnTwzbrFUkhiM4fmd/wqf+q+TlJ8+eiR2CZ9qyKLaVgv
         NPLMEe9TiHsMkn1QBlWHXdK4VzO6EC/xXp9VFys8jkflSfz7UtRf2HPpRCdh6ci1bGDZ
         mYjxjsZJmjnHvy7poeeLkH59g9u/54qwmU75C5hMeOuv9q9ZVhh6GNc8WlacjazcC2xo
         zqWdUAJe1p60BEbhbsn1KTPLYznY2x4FLpa+0TQnNFCyzY6W+PP0X0bNBZ8Z8NkpbUlH
         wOoErvgkzRqoI/vOrx27moTdD1izf1g6knjx/pvllw0wScyiyiyUa7GbMFjy5anAOezf
         +tmg==
X-Gm-Message-State: ACrzQf1MPF2w1rQJmEfRywlPsd0wjqAbig4nH4OVPla3L+IowSbYgP1D
        3Scw6cm95RbH0eqfNIAme3GVdh11veC8Rbeh1YMXdL63EbU=
X-Google-Smtp-Source: AMsMyM74uNxDFRrqrIAQiRkWxCBN/gOvW2xpTLhJ1P0i5AWUGsNFGshyrBx1VtI/mCqFtlqapZ/pTxP/74sqUZm5aEo=
X-Received: by 2002:a17:907:7f93:b0:791:91a6:5615 with SMTP id
 qk19-20020a1709077f9300b0079191a65615mr9265265ejc.708.1666228302506; Wed, 19
 Oct 2022 18:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221013062303.896469-1-memxor@gmail.com> <20221013062303.896469-20-memxor@gmail.com>
 <20221019023124.47zzi3gs2zcdvxca@macbook-pro-4.dhcp.thefacebook.com>
 <20221019055834.ux5dfoot7hyuf4jk@apollo> <CAADnVQ+Q9LO1dkz-Q7jHRjgf5cFFk1go=gwYDfVrTtanjMCoHw@mail.gmail.com>
 <20221020004445.zuwwtqe2qdk6ccfj@apollo>
In-Reply-To: <20221020004445.zuwwtqe2qdk6ccfj@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 18:11:30 -0700
Message-ID: <CAADnVQKifhUk_HE+8qQ=AOhAssH6w9LZ082Oo53rwaS+tAGtOw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 5:44 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 10:01:21PM IST, Alexei Starovoitov wrote:
> > On Tue, Oct 18, 2022 at 10:58 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed, Oct 19, 2022 at 08:01:24AM IST, Alexei Starovoitov wrote:
> > > > On Thu, Oct 13, 2022 at 11:52:57AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > +void *bpf_kptr_new_impl(u64 local_type_id__k, u64 flags, void *meta__ign)
> > > > > +{
> > > > > +   struct btf_struct_meta *meta = meta__ign;
> > > > > +   u64 size = local_type_id__k;
> > > > > +   void *p;
> > > > > +
> > > > > +   if (unlikely(flags || !bpf_global_ma_set))
> > > > > +           return NULL;
> > > >
> > > > Unused 'flags' looks weird in unstable api. Just drop it?
> > > > And keep it as:
> > > > void *bpf_kptr_new(u64 local_type_id__k, struct btf_struct_meta *meta__ign);
> > > >
> > > > and in bpf_experimental.h:
> > > >
> > > > extern void *bpf_kptr_new(__u64 local_type_id) __ksym;
> > > >
> > > > since __ign args are ignored during kfunc type match
> > > > the bpf progs can use it without #define.
> > > >
> > >
> > > It's ignored during check_kfunc_call, but libbpf doesn't ignore that. The
> > > prototypes will not be the same. I guess I'll have to teach it do that during
> > > type match, but IDK how you feel about that.
> >
> > libbpf does the full type match, really?
> > Could you point me to the code?
> >
>
> Not full type match, but the number of arguments must be same, so it won't allow
> having kfunc as:
>
> void *bpf_kptr_new(u64 local_type_id__k, struct btf_struct_meta *meta__ign);
>
> in the kernel and ksym declaration in the program as:
>
> extern void *bpf_kptr_new(__u64 local_type_id) __ksym;
>
> I get:
>
> libbpf: extern (func ksym) 'bpf_kptr_new_impl': func_proto [25] incompatible with kernel [60043]
>
> vlen of func_proto in kernel type is 2, for us it will be 1.

Ahh. Found it.
__bpf_core_types_are_compat() runs in both kernel and libbpf.
We could hack it for this case, but let's not complicate it.

> > > Otherwise unless you want people to manually pass something to the ignored
> > > argument, we have to hide it behind a macro.
> > >
> > > I actually like the macro on top, then I don't even pass the type ID but the
> > > type. But that's a personal preference, and I don't feel strongly about it.
> > >
> > > So in C one does malloc(sizeof(*p)), here we'll just write
> > > bpf_kptr_new(typeof(*p)). YMMV.
> >
> > bpf_kptr_new(typeof(*p)) is cleaner.
> >
>
> So if we're having a macro anyway, the thing above can be hidden behind it.

Indeed. Since #define is there let's not mess with
__bpf_core_types_are_compat().

> > > > > +   p = bpf_mem_alloc(&bpf_global_ma, size);
> > > > > +   if (!p)
> > > > > +           return NULL;
> > > > > +   if (meta)
> > > > > +           bpf_obj_init(meta->off_arr, p);
> > > >
> > > > I'm starting to dislike all that _arr and _tab suffixes in the verifier code base.
> > > > It reminds me of programming style where people tried to add types into
> > > > variable names. imo dropping _arr wouldn't be just fine.
> > >
> > > Ack, I'll do it in v3.
> > >
> > > Also, I'd like to invite people to please bikeshed a bit over the naming of the
> > > APIs, e.g. whether it should be bpf_kptr_drop vs bpf_kptr_delete.
> >
> > bpf_kptr_drop is more precise.
> > delete assumes instant free which is not the case here.
> >
> > How about
> > extern void *__bpf_obj_new(__u64 local_type_id) __ksym;
> > extern void bpf_obj_drop(void *obj) __ksym;
> > #define bpf_obj_new(t) \
> >  (t *)__bpf_obj_new(bpf_core_type_id_local(t));
> >
> > kptr means 'kernel pointer'.
> > Here we have program supplied object.
> > It feels 'obj' is better than 'kptr' in this context.
> >
>
> I agree, I'll rename it to bpf_obj_*.
>
> Also, that __bpf_obj_new doesn't work yet in clang [0] but I think we can rename
> it to that once clang is fixed.

argh. ok. let's keep bpf_obj_new_impl() for now.

>
>  [0]: https://reviews.llvm.org/D136041
>
> > > In the BPF list API, it's named bpf_list_del but it's actually distinct from how
> > > list_del in the kernel works. So it does make sense to give them a different
> > > name (like pop_front/pop_back and push_front/push_back)?
> > >
> > > Because even bpf_list_add takes bpf_list_head, in the kernel there's no
> > > distinction between node and head, so you can do list_add on a node as well, but
> > > it won't be possible with the kfunc (unless we overload the head argument to
> > > also work with nodes).
> > >
> > > Later we'll probably have to add bpf_list_node_add etc. that add before or after
> > > a node to make that work.
> > >
> > > The main question is whether it should closely resembly the linked list API in
> > > the kernel, or can it steer away considerably from that?
> >
> > If we do doubly linked list we should allow delete in
> > the middle with
> > bpf_list_del_any(head, node)
> >
> > and
> > bpf_list_pop_front/pop_back(head)
> >
> > bpf_list_add(node, head) would match kernel style,
> > but I think it's cleaner to have head as 1st arg.
> > In that sense new pop/push/_front/_back are cleaner.
> > And similar for rbtree.
> >
> > If we keep (node, head) and (rb_node, rb_root) order
> > we should keep kernel names.
>
> There's also tradeoffs in how various operations are done.
>
> Right now we have bpf_list_del and bpf_list_del_tail doing pop_front and
> pop_back.
>
> To replicate the same in kernel style API, you would do:
>
> struct foo *f = bpf_list_first_entry_or_null(head);
> if (!f) {}
> bpf_list_del(&f->node);
>
> Between those two calls, you might do bpf_list_last_entry -> bpf_list_del, the
> verifier is going to have a hard time proving the aliasing of the two nodes, so
> it will have to invalidate all pointers peeking into the list whenever something
> modifies it. You would still be able to access memory but cannot pass it to list
> ops anymore.

yeah. ugly.

>
> But I think we will pay this cost eventually anyway, people will add a peek
> operation and such analysis would have to be done then. So I think it's unlikely
> we can avoid this, and it might be better to make things more consistent and end
> up mirroring the kernel list APIs.

Let's keep the verifier simpler for now.
We can go with pop/push/_front/_back, since they are simpler
and later add kernel style accessor as well with swapped
node/head order.
One doesn't preclude the other.
