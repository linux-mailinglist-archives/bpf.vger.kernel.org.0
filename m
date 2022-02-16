Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD54B9355
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 22:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiBPVoX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 16:44:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiBPVoW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 16:44:22 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00BE19FAEB
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 13:44:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p23so3252726pgj.2
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+plStd/P4J0LHAzTkW0Yij9KcwU9ol9b99rneF+H/CI=;
        b=bSvrhxyDjZ6qWD4+ozraBt1FaDt9lKhZXpGVN96o6zmYmt7zt4m7nB5tTF90VAvXri
         rtBdgPrKrFF+LRbFs5Rx6vVICWsD2fEZNqFHEsNuM0cfU0hIWqLlGp8ZZ53v3/7TUWJQ
         HOSI96Qq4dnyVEavLT/xN7SWVHywHzcVVSCoRwbZ+Obr8ZqdjD7veNHkYNm0rUls27ei
         Z0eSHqt6L1U34yWiBGZrosUfZCHefcQqxE9YKJB7ABwzY2PRl/EGfoMs/5QbiAjpy7aQ
         8RktGKeJYJYXKh4rwl9zAcPNujAWWukdKYAoLjPPa1n8BeWho3N29hrf+d9ZIBncwlla
         P3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+plStd/P4J0LHAzTkW0Yij9KcwU9ol9b99rneF+H/CI=;
        b=V7N1rLRvrkShDfCxa8UzZabdEJagT2fSe+cRBmrRKr9NrUOvJ3hzblmRnbXoeENkah
         NqlaYrrre5U+NiYyhGdl7z0/KIdjmqPFlfsBsaFS5zj/tV7i585HXhqlYQ5Pdy0zfUBQ
         ScxRErsxPqHlsYmk/YGvL1fetSgLdgmPbRBNIwN8rNKWTDjKcCKzUGPqexChsOuSOyz9
         8skkW+NOegAW633+0rVrVLT47cXKduPeBGH6SKtsfiW8X+eIWDPlTrHmcWTh+jrh2GEi
         /4X+8Hp8uzsX8563GTdvGDoZI33VNXr6k8SYgJvoyYaTgMIkvXpbbClAEB1oDWKFdX1u
         /Dbw==
X-Gm-Message-State: AOAM532x43Nzu327twUN1HFUsKg88vZbp0Bbre+R3uetLRxwYVdbM2gA
        j2PfJ/EGFw/khH4YsOUZxGY=
X-Google-Smtp-Source: ABdhPJxxn+0RRo8EL81jDgtoSZLhrHAmZUaTGE+tGx872nqeSIixZNewZHhNUfSHhshtPiu9orWeGA==
X-Received: by 2002:a63:4b46:0:b0:373:3911:a3d0 with SMTP id k6-20020a634b46000000b003733911a3d0mr3941594pgl.590.1645047848982;
        Wed, 16 Feb 2022 13:44:08 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::3:ef8d])
        by smtp.gmail.com with ESMTPSA id k14sm45595895pff.25.2022.02.16.13.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 13:44:08 -0800 (PST)
Date:   Wed, 16 Feb 2022 13:44:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type >
 __BPF_REG_TYPE_MAX
Message-ID: <20220216214405.tn7thpnvqkxuvwhd@ast-mbp.dhcp.thefacebook.com>
References: <20220216091323.513596-1-memxor@gmail.com>
 <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
 <20220216173348.luidfddtou6yfxed@apollo.legion>
 <CAADnVQJ-wMjyBQUYELYCjDTST8M5+TKRw2fi7nfrv79319fwog@mail.gmail.com>
 <20220216182954.jwzrum5ivekxca72@apollo.legion>
 <20220216194956.dl3kjtxfrdownoga@ast-mbp.dhcp.thefacebook.com>
 <20220216205842.hurazq2qkduhsuye@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216205842.hurazq2qkduhsuye@apollo.legion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 02:28:42AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Thu, Feb 17, 2022 at 01:19:56AM IST, Alexei Starovoitov wrote:
> > On Wed, Feb 16, 2022 at 11:59:54PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > > Just use reg2btf_ids[base_type(reg->type)] instead?
> > > > >
> > > > > That would be incorrect I think, then we'd allow e.g. PTR_TO_TCP_SOCK_OR_NULL
> > > > > and treat it as PTR_TO_TCP_SOCK, while current code only wants to permit
> > > > > non-NULL variants for these three.
> > > >
> > > > add && !type_flag(reg->type) ?
> > > >
> > >
> > > Ok, we can do that. WRT Hao's suggestion, we do allow NULL for ptr_to_mem_ok
> > > case, so doing it for all of check_func_arg_match won't work.
> >
> > Right.
> >
> > > > But, first, please describe how you found it.
> > > > Tried to pass PTR_TO_BTF_ID_OR_NULL into kfunc?
> > > > Do you have some other changes in the verifier?
> > >
> > > Yes, was working on [0], tried to come up with a test case where verifier
> > > printed bad register type being passed (one marked with a new flag), but noticed
> > > that it would fall out of __BPF_REG_TYPE_MAX limit during kfunc check. Also, it
> > > seems on non-KASAN build it actually doesn't crash sometimes, depends on what
> > > the value at that offset is.
> > >
> > >   [0]: https://github.com/kkdwivedi/linux/commits/btf-ptr-in-map
> >
> > Nice. Thanks a ton. I did a quick look. Seems to be ready to post on the list?
> > Can you add .c tests and post?
> >
> 
> Thanks for the quick review!
> 
> Yes, I should be able to post by this weekend if I don't run into any other
> problems/bugs in my code.

The sooner the better, so we can merge our efforts sooner.

> > Only one suggestion so far:
> > Could you get rid of callback in btf_find_struct_field ?
> > The callbacks obscure the control flow and make the code harder to follow.
> > Do refactor btf_find_struct_field, but call btf_find_ptr_to_btf_id directly from it.
> > Then you wouldn't need this ugly part:
> > /* While callback cleans up after itself, later iterations can still
> >  * return error without calling cb, so call free function again.
> >  */
> > if (ret < 0)
> >   bpf_map_free_ptr_off_tab(map);
> >
> 
> Ok, makes sense, will change.
> 
> > I've been thinking about the api for refcnted PTR_TO_BTF_ID in the map too.
> > Regarding your issue with cmpxchg. I've come up with two helpers:
> >
> > BPF_CALL_3(bpf_kptr_try_set, void **, kptr, void *, ptr, int, refcnt_off)
> > {
> >         /* ptr is ptr_to_btf_id returned from bpf_*_lookup() with ptr->refcnt >= 1
> >          * refcount_inc() has to be done before cmpxchg() because
> >          * another cpu might do bpf_kptr_xchg+release.
> >          */
> >         refcount_inc((refcount_t *)(ptr + refcnt_off));
> >         if (cmpxchg(kptr, NULL, ptr)) {
> >                 /* refcnt >= 2 here */
> >                 refcount_dec((refcount_t *)(ptr + refcnt_off));
> >                 return -EBUSY;
> >         }
> >         return 0;
> > }
> >
> > and
> >
> > BPF_CALL_2(bpf_kptr_get, void **, kptr, int, refcnt_off)
> > {
> >         void *ptr = READ_ONCE(kptr);
> >
> >         if (!ptr)
> >                 return 0;
> >         /* ptr->refcnt could be == 0 if another cpu did
> >          * ptr2 = bpf_kptr_xchg();
> >          * bpf_*_release(ptr2);
> >          */
> >         if (!refcount_inc_not_zero((refcount_t *)(ptr + refcnt_off)))
> >                 return 0;
> >         return (long) ptr;
> > }
> >
> 
> Good point. I did think about this problem. Right now when you load a referenced
> pointer from the BPF map, we mark it as PTR_UNTRUSTED, so you can dereference

you mean UNreferenced pointer, right? Since that's what your patch is doing.

> but not pass into a helper like this, so my thinking was that BPF user will
> already have an additional check (e.g. pointer being reachable from hash table
> key) before accessing it, and that the xchg can happen after the other program
> has removed the value's visibility globally (by deleting it from table). And for
> RCU objects dereference of PTR_UNTRUSTED still works and reads valid data, they
> can also skip reading by observing ptr->refcnt == 0 for dying case.

I was thinking whether we can allow LDX to return PTR_TO_BTF_ID | PTR_UNTRUSTED
and do explicit refcount_inc_not_zero done in bpf program by exposing
functions like maybe_get_net() as kfunc and mark them as 'acquire' functions.
After acquire the pointer would lose PTR_UNTRUSTED flag.
That's another option instead of doing bpf_kptr_get().
The advantage of bpf_kptr_get() that it's one way of operating with kernel pointers.
No need to remember which kfunc to call.
But on the other side explicit acquire call is more flexible.

> So in case of fast path as long as you don't need to pass BTF ID into helpers,
> you don't have to increment refcount.

pass btf_id into helpers? What do you mean? Pass ptr_to_btf_id into helpers?
Right. If it's PTR_UNTRUSTED then having such struct as read-only would be ok,
but that is a narrow use case.
All kernel structs are beefy. They have a ton of stuff and would typically be
passed into something else. (struct nf_conn *)->status si the only example
I can think of where refcnt-ing is not needed.

The refcnt inc/dec is very fast when it's not contended.

> As you note, this is not enough, e.g. we might want to pass a referenced pointer
> into helpers without removing it from the map. In that case such bpf_kptr_get
> helper makes sense, but I think 1) It needs to be inlined, because refcount_off
> will only be available easily at verification time (from BTF), 

Sorry that bit wasn't obvious. The refcnt_off argument to kptr_try_set and kptr_get
will be provided by the verifier. The prog cannot pass it on its own.
The verifier will do btf_id of arg2 -> offsetof(struct nf_conn, ct_general.use)
and patch R3 with that constant before the call insn.

So inlining of kptr_try_set and kptr_get is not needed.

> 2) We cannot
> guarantee that it keeps working for same object across kernel versions, that
> ties kernel into a stability guarantee reg. internal changes, 

See explanation above. It will work across kernels. bpf progs don't need to change.

> 3) We can only
> support it for subset of objects (that have RCU protection), which we can
> ideally detect from BTF itself, by marking them as such, or using a flag during
> destructor registration (which is done for ref'd pointer case).

The kptr_try_set, kptr_get, kptr_xchg will work for sleepable bpf progs too.
rcu protection is not a requirement.
Since btf_id -> offsetof(refcnt variable) mapping is done on the kernel side
it will work as allowlist for kernel structs too.
If btf_id_of(some kernel struct) is not there, then such btf_id cannot be
persisted into the map value.

> 
> >
> > and instead of recognizing xchg insn directly in the verifier
> > I went with the helper:
> > BPF_CALL_2(bpf_kptr_xchg, void **, kptr, void *, ptr)
> > {
> >         /* ptr is ptr_to_btf_id returned from bpf_*_lookup() with ptr->refcnt >= 1
> >          * or ptr == NULL.
> >          * returns ptr_to_btf_id with refcnt >= 1 or NULL
> >          */
> >         return (long) xchg(kptr, ptr);
> > }
> > It was easier to deal with.
> > I don't have a strong preference for helper vs insn though.
> > Let's brainstorm after you post patches.
> >
> > xchg or bpf_kptr_xchg only operation seems to be too limiting.
> 
> Right, one other usecase me and Toke were exploring is using this support to
> enable XDP queueing. We can have a normal PIFO map and allow embedding xdp_frame
> in it. Then xchg is used during enqueue and dequeue from the map, and user can
> have additional stuff in map value (like embedding both bpf_timer and xdp_frame,
> or extra scalars as data), which should allow more composition/flexibility.
> 
> To also reduce the overhead of this xchg on fast path, we can consider relaxing
> atomic restriction for per-CPU maps instead, then add a bpf_move_ptr helper that
> is non-atomic, but ensures invariant that value in per-CPU map is either
> refcounted or NULL, and only in program or map at any point of time. Then the
> overhead of moving object ownership is also eliminated, and helper itself can be
> inlined to a load from the map and a store to the map (of the new pointer or
> NULL).
> 
> From my notes:
> 
>   6 * Introduce per-CPU map support, allow non-atomic update for ref'd pointer, and
>   7   enforce consistent value using a ptr = bpf_move_ptr(&map_val_ptr->ptr, ptr);
>   8
>   9   To move value out of map: ptr = bpf_move_ptr(&val->ptr, NULL)
>  10   To move value into the map: ptr = bpf_move_ptr(&val->ptr, ptr)
> 
> In both cases, reference state for R0 (with PTR_MAYBE_NULL set) is created, and
> since per-CPU map is only accessible to that CPU, we don't need additional
> protections, as long as we also block userspace bpf_map_update_elem in this
> case, or only permit storing such pointers with per-CPU map setting
> BPF_MAP_F_RDONLY_USER flag.
> 
> Will revisit this in detail when I post it, code for this is missing from
> GitHub.

Please hold on to that.
It looks like premature optimization to me.
xchg is fast when it's not contended.
Adding all that per-cpu map logic won't make it faster. percpu array lookup
will cost more than xchg.
You might end up doing all that just to realize that it's slower.
Let's land the main infra first.

> > For example we might want to remember struct task_struct or struct net
> > in a map for faster access.
> > The __bpf_nf_ct_lookup is doing get_net_ns_by_id().
> > idr_find isn't fast enough for XDP.
> > We can store refcnted 'struct net *' for faster lookup.
> > Then multiple cpus will be reading that pointer the map, but if only 'xchg' is
> > available that use case won't work. One cpu will win the race.
> > So we need bpf_kptr_get() will be an acquire helper.
> > The bpf prog will do an explicit put_net(ptr); which will be a release kfunc.
> >
> > Simply reading refcnted ptr_to_btf_id from a map is PTR_UNTRUSTED too for sleepable bpf progs.
> 
> It is already marked PTR_UNTRUSTED for sleepable too, IIUC, but based on above I
> guess we can remove the flag for objects which are RCU protected, in case of
> non-sleepable progs. 

Probably not. Even non-sleepable prog under rcu_read_lock shouldn't be able 
to pass 'struct tcp_sock *' from the map into helpers.
That sock can have refcnt==0. Even under rcu it's dangerous.

> We also need to prevent the kptr_get helper from being
> called from sleepable progs.

why is that?
