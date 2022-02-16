Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960724B92AC
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 21:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiBPU7A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 15:59:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiBPU67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 15:58:59 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD7202054
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 12:58:45 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r76so3155400pgr.10
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 12:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kc5rplXv7+0Cz5eRL6ONS0vbFiYtBDcnq1Oeay7khyw=;
        b=LSHAzyOM8qhfNC1ORl4OaYr93Rr2AFbDyCFtFWHtoMWHNe3rUY2fc2e8zcTb4HmH3q
         Re08dnFOEzP2gID5Xl7ocU35lIRdU2VUh2x956mQx+NqFldNnIZzIXLNFhzgvWq1ZYcl
         1df6wxFvIZXzg83CqtYHH5jqB0PgH0ED+4mkrZd2RohdqaUha4KIoc+Umx1vOLDXyvAe
         M0vj1lxZHH3z8xxJjPzi87+WIJxPplf8TZwIFx6/MGC3D8lcZK0ye0gWEcYDwpDE/dL1
         e6RDBXKYCxEoWWRyX6x6Dtgu+YTbJLfW05I7jWwmx/1bId7rH57BJ++u+6R3YkxJNQFN
         Y8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kc5rplXv7+0Cz5eRL6ONS0vbFiYtBDcnq1Oeay7khyw=;
        b=hLfOjFXCacxQoL/l1I3vLZ9Ol2Uqhw1QWhX0wavrT2LOXhAeETgdE08XEgp8Mmpzgv
         ORHNpM5t5FdV9C33Ii+jQD6sf8+GlsVLJu3tVnRwiYprCoIub9keRQ60BNLLwDuNwz0s
         hyhTYPUqR1eIvhKotZP1mn70/FqyK39FPmF89e2S53+cRaeWuGgyge0W3m0Li4nGpeZ7
         1yBSqMs+vbZITiswoIyJljMYAw7Xn63W59e8RgKK6mmXBZaNAibq3BnCIXgXA35J2S2N
         RKdolG26nzXIuqHtZZdYnxbfZSG93KESZ86bgHHgLIYRw0g+35SMWp9zaPAvNsLeukvi
         Z6aQ==
X-Gm-Message-State: AOAM533KM0OcrwzOW+bjJ6+IFQpTzyTKRPSoTOvIw58UnthRzEznL7hP
        z13DSa+wNGDD7Ff8W1HMHak=
X-Google-Smtp-Source: ABdhPJxEdZ0tIXbUp9JC1mming7q74Igi23zlXpGnD31iAI1yh/0YwC1JRyFG15Pwl/XgSM4g3RoJw==
X-Received: by 2002:a65:4c4c:0:b0:35e:3c81:5b7f with SMTP id l12-20020a654c4c000000b0035e3c815b7fmr3906146pgr.162.1645045124931;
        Wed, 16 Feb 2022 12:58:44 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id 131sm920477pfz.76.2022.02.16.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:58:44 -0800 (PST)
Date:   Thu, 17 Feb 2022 02:28:42 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type >
 __BPF_REG_TYPE_MAX
Message-ID: <20220216205842.hurazq2qkduhsuye@apollo.legion>
References: <20220216091323.513596-1-memxor@gmail.com>
 <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
 <20220216173348.luidfddtou6yfxed@apollo.legion>
 <CAADnVQJ-wMjyBQUYELYCjDTST8M5+TKRw2fi7nfrv79319fwog@mail.gmail.com>
 <20220216182954.jwzrum5ivekxca72@apollo.legion>
 <20220216194956.dl3kjtxfrdownoga@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216194956.dl3kjtxfrdownoga@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 01:19:56AM IST, Alexei Starovoitov wrote:
> On Wed, Feb 16, 2022 at 11:59:54PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > Just use reg2btf_ids[base_type(reg->type)] instead?
> > > >
> > > > That would be incorrect I think, then we'd allow e.g. PTR_TO_TCP_SOCK_OR_NULL
> > > > and treat it as PTR_TO_TCP_SOCK, while current code only wants to permit
> > > > non-NULL variants for these three.
> > >
> > > add && !type_flag(reg->type) ?
> > >
> >
> > Ok, we can do that. WRT Hao's suggestion, we do allow NULL for ptr_to_mem_ok
> > case, so doing it for all of check_func_arg_match won't work.
>
> Right.
>
> > > But, first, please describe how you found it.
> > > Tried to pass PTR_TO_BTF_ID_OR_NULL into kfunc?
> > > Do you have some other changes in the verifier?
> >
> > Yes, was working on [0], tried to come up with a test case where verifier
> > printed bad register type being passed (one marked with a new flag), but noticed
> > that it would fall out of __BPF_REG_TYPE_MAX limit during kfunc check. Also, it
> > seems on non-KASAN build it actually doesn't crash sometimes, depends on what
> > the value at that offset is.
> >
> >   [0]: https://github.com/kkdwivedi/linux/commits/btf-ptr-in-map
>
> Nice. Thanks a ton. I did a quick look. Seems to be ready to post on the list?
> Can you add .c tests and post?
>

Thanks for the quick review!

Yes, I should be able to post by this weekend if I don't run into any other
problems/bugs in my code.

> Only one suggestion so far:
> Could you get rid of callback in btf_find_struct_field ?
> The callbacks obscure the control flow and make the code harder to follow.
> Do refactor btf_find_struct_field, but call btf_find_ptr_to_btf_id directly from it.
> Then you wouldn't need this ugly part:
> /* While callback cleans up after itself, later iterations can still
>  * return error without calling cb, so call free function again.
>  */
> if (ret < 0)
>   bpf_map_free_ptr_off_tab(map);
>

Ok, makes sense, will change.

> I've been thinking about the api for refcnted PTR_TO_BTF_ID in the map too.
> Regarding your issue with cmpxchg. I've come up with two helpers:
>
> BPF_CALL_3(bpf_kptr_try_set, void **, kptr, void *, ptr, int, refcnt_off)
> {
>         /* ptr is ptr_to_btf_id returned from bpf_*_lookup() with ptr->refcnt >= 1
>          * refcount_inc() has to be done before cmpxchg() because
>          * another cpu might do bpf_kptr_xchg+release.
>          */
>         refcount_inc((refcount_t *)(ptr + refcnt_off));
>         if (cmpxchg(kptr, NULL, ptr)) {
>                 /* refcnt >= 2 here */
>                 refcount_dec((refcount_t *)(ptr + refcnt_off));
>                 return -EBUSY;
>         }
>         return 0;
> }
>
> and
>
> BPF_CALL_2(bpf_kptr_get, void **, kptr, int, refcnt_off)
> {
>         void *ptr = READ_ONCE(kptr);
>
>         if (!ptr)
>                 return 0;
>         /* ptr->refcnt could be == 0 if another cpu did
>          * ptr2 = bpf_kptr_xchg();
>          * bpf_*_release(ptr2);
>          */
>         if (!refcount_inc_not_zero((refcount_t *)(ptr + refcnt_off)))
>                 return 0;
>         return (long) ptr;
> }
>

Good point. I did think about this problem. Right now when you load a referenced
pointer from the BPF map, we mark it as PTR_UNTRUSTED, so you can dereference
but not pass into a helper like this, so my thinking was that BPF user will
already have an additional check (e.g. pointer being reachable from hash table
key) before accessing it, and that the xchg can happen after the other program
has removed the value's visibility globally (by deleting it from table). And for
RCU objects dereference of PTR_UNTRUSTED still works and reads valid data, they
can also skip reading by observing ptr->refcnt == 0 for dying case.

So in case of fast path as long as you don't need to pass BTF ID into helpers,
you don't have to increment refcount.

As you note, this is not enough, e.g. we might want to pass a referenced pointer
into helpers without removing it from the map. In that case such bpf_kptr_get
helper makes sense, but I think 1) It needs to be inlined, because refcount_off
will only be available easily at verification time (from BTF), 2) We cannot
guarantee that it keeps working for same object across kernel versions, that
ties kernel into a stability guarantee reg. internal changes, 3) We can only
support it for subset of objects (that have RCU protection), which we can
ideally detect from BTF itself, by marking them as such, or using a flag during
destructor registration (which is done for ref'd pointer case).

>
> and instead of recognizing xchg insn directly in the verifier
> I went with the helper:
> BPF_CALL_2(bpf_kptr_xchg, void **, kptr, void *, ptr)
> {
>         /* ptr is ptr_to_btf_id returned from bpf_*_lookup() with ptr->refcnt >= 1
>          * or ptr == NULL.
>          * returns ptr_to_btf_id with refcnt >= 1 or NULL
>          */
>         return (long) xchg(kptr, ptr);
> }
> It was easier to deal with.
> I don't have a strong preference for helper vs insn though.
> Let's brainstorm after you post patches.
>
> xchg or bpf_kptr_xchg only operation seems to be too limiting.

Right, one other usecase me and Toke were exploring is using this support to
enable XDP queueing. We can have a normal PIFO map and allow embedding xdp_frame
in it. Then xchg is used during enqueue and dequeue from the map, and user can
have additional stuff in map value (like embedding both bpf_timer and xdp_frame,
or extra scalars as data), which should allow more composition/flexibility.

To also reduce the overhead of this xchg on fast path, we can consider relaxing
atomic restriction for per-CPU maps instead, then add a bpf_move_ptr helper that
is non-atomic, but ensures invariant that value in per-CPU map is either
refcounted or NULL, and only in program or map at any point of time. Then the
overhead of moving object ownership is also eliminated, and helper itself can be
inlined to a load from the map and a store to the map (of the new pointer or
NULL).

From my notes:

  6 * Introduce per-CPU map support, allow non-atomic update for ref'd pointer, and
  7   enforce consistent value using a ptr = bpf_move_ptr(&map_val_ptr->ptr, ptr);
  8
  9   To move value out of map: ptr = bpf_move_ptr(&val->ptr, NULL)
 10   To move value into the map: ptr = bpf_move_ptr(&val->ptr, ptr)

In both cases, reference state for R0 (with PTR_MAYBE_NULL set) is created, and
since per-CPU map is only accessible to that CPU, we don't need additional
protections, as long as we also block userspace bpf_map_update_elem in this
case, or only permit storing such pointers with per-CPU map setting
BPF_MAP_F_RDONLY_USER flag.

Will revisit this in detail when I post it, code for this is missing from
GitHub.

> For example we might want to remember struct task_struct or struct net
> in a map for faster access.
> The __bpf_nf_ct_lookup is doing get_net_ns_by_id().
> idr_find isn't fast enough for XDP.
> We can store refcnted 'struct net *' for faster lookup.
> Then multiple cpus will be reading that pointer the map, but if only 'xchg' is
> available that use case won't work. One cpu will win the race.
> So we need bpf_kptr_get() will be an acquire helper.
> The bpf prog will do an explicit put_net(ptr); which will be a release kfunc.
>
> Simply reading refcnted ptr_to_btf_id from a map is PTR_UNTRUSTED too for sleepable bpf progs.

It is already marked PTR_UNTRUSTED for sleepable too, IIUC, but based on above I
guess we can remove the flag for objects which are RCU protected, in case of
non-sleepable progs. We also need to prevent the kptr_get helper from being
called from sleepable progs.

> Such pointers are under rcu_read_lock in non-sleepable, but it still feels safer
> to always enforce refcnt inc/dec when accessing them to pass into helpers.
>
> > I was planning to send a verifier test exercising this but it seems
> > fixup_kfunc_btf_id support for test_verifier.c is not in bpf tree yet, so when
>
> Obviously we have to wait until the merge window.
>
> > it is merged I will provide a small test case, it is basically this on bpf-next:
> >
> > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > index 829be2b9e08e..5f26007ceef1 100644
> > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > @@ -1,3 +1,22 @@
> > +{
> > +       "calls: trigger reg->type > __BPF_REG_TYPE_MAX",
> > +       .insns = {
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > +       BPF_EXIT_INSN(),
> > +       },
> > +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> > +       .result = REJECT,
> > +       .errstr = "XXX,
> > +       .fixup_kfunc_btf_id = {
> > +               { "bpf_kfunc_call_test_acquire", 3 },
> > +               { "bpf_kfunc_call_test_release", 5 },
> > +       },
> > +},
> >  {
> >
> > Sending it rn I think may lead to flaky CI, so we can wait.
>
> Right. Let's wait until bpf tree merges into bpf-next.
>
> > If all of this makes sense, should I respin?
>
> Please do.
> We can get bpf PR out asap after that.

Sent, but looks I missed the bpf: prefix in haste :/. Please fix it up while
applying, otherwise I can respin again.

--
Kartikeya
