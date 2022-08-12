Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8D59099F
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 02:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiHLAqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 20:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLAqb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 20:46:31 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D74A00FC;
        Thu, 11 Aug 2022 17:46:29 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id z7so9397212qki.11;
        Thu, 11 Aug 2022 17:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YtiCpQrGuUY4mdD6mLJSDD/cyQnjQEA2au0Dt8ntMMo=;
        b=ozwYniWCDRySm2XG41U7I8zP4w5ufPtyiDEKyx9oWk/Jv5qBq4vhcj3E7l0zPLfb4e
         4Enm4V+quLX5x6dVSzaVwKlEnaPAx+KiaE2tdc7/KvrCiEVCN+Sktk3651msIpghZxIF
         AnLNT/glkoT0fBRtgpS4w2rMKVap4rih7RjcaSgArTTnUnhh8LNHISI2vZUmZUvsQhzm
         GvGlr+bsdfyR5mjzuPMUdQ50QTsw9PBr/WLIhh5WVm90vP1a7L4XJF0RYaKyuJVkrw/X
         BC8WrqlO8LLnj70TsLmPrInyK53+B8xNrAy8BZ5FqQQMwQXeW5GNCSmJwRhpY9A4rLs+
         LERw==
X-Gm-Message-State: ACgBeo2lHpJgreDZcveO36oujKo2xXEBFmXJDE+58rCgmP6BV8z8IM63
        kubJCIQC0xBdXLY2K+ag5fTYfpaXXrbXj+uD
X-Google-Smtp-Source: AA6agR65oiVKe0X0OygvFlOK4qqJxTA1NuJAeFDyor8w1Eo0vMoYoq7p5iDXjPPDPExeqKoD+DuVhA==
X-Received: by 2002:a05:620a:2a14:b0:6b6:6858:3146 with SMTP id o20-20020a05620a2a1400b006b668583146mr1255864qkp.758.1660265188135;
        Thu, 11 Aug 2022 17:46:28 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::bfe0])
        by smtp.gmail.com with ESMTPSA id o4-20020ac872c4000000b0033fc75c3469sm595366qtp.27.2022.08.11.17.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 17:46:27 -0700 (PDT)
Date:   Thu, 11 Aug 2022 19:46:25 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 3/5] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <YvWi4f1hz/v72Fpc@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-3-void@manifault.com>
 <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 04:22:43PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 8, 2022 at 8:54 AM David Vernet <void@manifault.com> wrote:
> >
> > Now that we have a BPF_MAP_TYPE_USER_RINGBUF map type, we need to add a
> > helper function that allows BPF programs to drain samples from the ring
> > buffer, and invoke a callback for each. This patch adds a new
> > bpf_user_ringbuf_drain() helper that provides this abstraction.
> >
> > In order to support this, we needed to also add a new PTR_TO_DYNPTR
> > register type to reflect a dynptr that was allocated by a helper function
> > and passed to a BPF program. The verifier currently only supports
> > PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL and MEM_ALLOC.
> 
> This commit message is a bit too laconic. There is a lot of
> implications of various parts of this patch, it would be great to
> highlight most important ones. Please consider elaborating a bit more.

Argh, sent my last email too early that only responded to this too early.
I'll do this in v3, as mentioned in my other email.

> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a341f877b230..ca125648d7fd 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5332,6 +5332,13 @@ union bpf_attr {
> >   *             **-EACCES** if the SYN cookie is not valid.
> >   *
> >   *             **-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
> > + *
> > + * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
> > + *     Description
> > + *             Drain samples from the specified user ringbuffer, and invoke the
> > + *             provided callback for each such sample.
> 
> please specify what's the expected signature of callback_fn

Will do, unfortunatley we're inconsistent in doing this in other helper
functions, so it wasn't clear from context.

> > + *     Return
> > + *             An error if a sample could not be drained.
> 
> Negative error, right? And might be worth it briefly describing what
> are the situation(s) when you won't be able to drain a sample?
> 
> Also please clarify if having no sample to drain is an error or not?
> 
> It's also important to specify that if no error (and -ENODATA
> shouldn't be an error, actually) occurred then we get number of
> consumed samples back.

Agreed, I'll add more data here in the next version.

[...]

> > +
> > +static __poll_t ringbuf_map_poll_kern(struct bpf_map *map, struct file *filp,
> > +                                     struct poll_table_struct *pts)
> > +{
> > +       return ringbuf_map_poll(map, filp, pts, true);
> > +}
> > +
> > +static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
> > +                                     struct poll_table_struct *pts)
> > +{
> > +       return ringbuf_map_poll(map, filp, pts, false);
> >  }
> 
> This is an even stronger case where I think we should keep two
> implementations completely separate. Please keep existing
> ringbuf_map_poll as is and just add a user variant as a separate
> implementation

Agreed, I'll split both this and  into separate functions (and the mmaps)
into separate functions.

> >  BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
> > @@ -309,7 +326,7 @@ const struct bpf_map_ops ringbuf_map_ops = {
> >         .map_alloc = ringbuf_map_alloc,
> >         .map_free = ringbuf_map_free,
> >         .map_mmap = ringbuf_map_mmap_kern,
> > -       .map_poll = ringbuf_map_poll,
> > +       .map_poll = ringbuf_map_poll_kern,
> >         .map_lookup_elem = ringbuf_map_lookup_elem,
> >         .map_update_elem = ringbuf_map_update_elem,
> >         .map_delete_elem = ringbuf_map_delete_elem,
> > @@ -323,6 +340,7 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
> >         .map_alloc = ringbuf_map_alloc,
> >         .map_free = ringbuf_map_free,
> >         .map_mmap = ringbuf_map_mmap_user,
> > +       .map_poll = ringbuf_map_poll_user,
> >         .map_lookup_elem = ringbuf_map_lookup_elem,
> >         .map_update_elem = ringbuf_map_update_elem,
> >         .map_delete_elem = ringbuf_map_delete_elem,
> > @@ -605,3 +623,132 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
> >         .arg1_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
> >         .arg2_type      = ARG_ANYTHING,
> >  };
> > +
> > +static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
> > +                                  u32 *size)
> 
> "poll" part is quite confusing as it has nothing to do with epoll and
> the other poll implementation. Maybe "peek"? It peek into next sample
> without consuming it, seems appropriate
> 
> nit: this declaration can also stay on single line

Yeah, I agree that "poll" is confusing. I think "peek" is a good option. I
was also considering "consume", but I don't think that makes sense given
that we're not actually done consuming the sample until we release it.

> > +{
> > +       unsigned long cons_pos, prod_pos;
> > +       u32 sample_len, total_len;
> > +       u32 *hdr;
> > +       int err;
> > +       int busy = 0;
> 
> nit: combine matching types:
> 
> u32 sample_len, total_len, *hdr;
> int err, busy = 0;

Ack.

> > +
> > +       /* If another consumer is already consuming a sample, wait for them to
> > +        * finish.
> > +        */
> > +       if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> > +               return -EBUSY;
> > +
> > +       /* Synchronizes with smp_store_release() in user-space. */
> > +       prod_pos = smp_load_acquire(&rb->producer_pos);
> 
> I think we should enforce that prod_pos is a multiple of 8

Agreed, I'll add a check and selftest for this.

> > +       /* Synchronizes with smp_store_release() in
> > +        * __bpf_user_ringbuf_sample_release().
> > +        */
> > +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> > +       if (cons_pos >= prod_pos) {
> > +               atomic_set(&rb->busy, 0);
> > +               return -ENODATA;
> > +       }
> > +
> > +       hdr = (u32 *)((uintptr_t)rb->data + (cons_pos & rb->mask));
> > +       sample_len = *hdr;
> 
> do we need smp_load_acquire() here? libbpf's ring_buffer
> implementation uses load_acquire here

I thought about this when I was first adding the logic, but I can't
convince myself that it's necessary and wasn't able to figure out why we
did a load acquire on the len in libbpf. The kernel doesn't do a store
release on the header, so I'm not sure what the load acquire in libbpf
actually accomplishes. I could certainly be missing something, but I
_think_ the important thing is that we have load-acquire / store-release
pairs for the consumer and producer positions.

> > +       /* Check that the sample can fit into a dynptr. */
> > +       err = bpf_dynptr_check_size(sample_len);
> > +       if (err) {
> > +               atomic_set(&rb->busy, 0);
> > +               return err;
> > +       }
> > +
> > +       /* Check that the sample fits within the region advertised by the
> > +        * consumer position.
> > +        */
> > +       total_len = sample_len + BPF_RINGBUF_HDR_SZ;
> 
> round up to closest multiple of 8? All the pointers into ringbuf data
> area should be 8-byte aligned

Will do.

> > +       if (total_len > prod_pos - cons_pos) {
> > +               atomic_set(&rb->busy, 0);
> > +               return -E2BIG;
> > +       }
> > +
> > +       /* Check that the sample fits within the data region of the ring buffer.
> > +        */
> > +       if (total_len > rb->mask + 1) {
> > +               atomic_set(&rb->busy, 0);
> > +               return -E2BIG;
> > +       }
> > +
> > +       /* consumer_pos is updated when the sample is released.
> > +        */
> > +
> 
> nit: unnecessary empty line
> 
> and please keep single-line comments as single-line, no */ on separate
> line in such case

Will do.

> > +       *sample = (void *)((uintptr_t)rb->data +
> > +                          ((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> > +       *size = sample_len;
> > +
> > +       return 0;
> > +}
> > +
> > +static void
> > +__bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
> > +                                 u64 flags)
> 
> try to keep single lines if they are under 100 characters

Ack, this seems to really differ by subsystem. I'll follow this norm for
BPF.

> > +{
> > +
> > +
> 
> empty lines, why?

Apologies, thanks for catching this.

> > +       /* To release the ringbuffer, just increment the producer position to
> > +        * signal that a new sample can be consumed. The busy bit is cleared by
> > +        * userspace when posting a new sample to the ringbuffer.
> > +        */
> > +       smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
> > +                         BPF_RINGBUF_HDR_SZ);
> > +
> > +       if (flags & BPF_RB_FORCE_WAKEUP || !(flags & BPF_RB_NO_WAKEUP))
> 
> please use () around bit operator expressions

Ack.

> > +               irq_work_queue(&rb->work);
> > +
> > +       atomic_set(&rb->busy, 0);
> 
> set busy before scheduling irq_work? why delaying?

Yeah, I thought about this. I don't think there's any problem with clearing
busy before we schedule the irq_work_queue(). I elected to do this to err
on the side of simpler logic until we observed contention, but yeah, let me
just do the more performant thing here.

> > +}
> > +
> > +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> > +          void *, callback_fn, void *, callback_ctx, u64, flags)
> > +{
> > +       struct bpf_ringbuf *rb;
> > +       long num_samples = 0, ret = 0;
> > +       int err;
> > +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> > +       u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
> > +
> > +       if (unlikely(flags & ~wakeup_flags))
> > +               return -EINVAL;
> > +
> > +       /* The two wakeup flags are mutually exclusive. */
> > +       if (unlikely((flags & wakeup_flags) == wakeup_flags))
> > +               return -EINVAL;
> 
> we don't check this for existing ringbuf, so maybe let's keep it
> consistent? FORCE_WAKEUP is just stronger than NO_WAKEUP

Ack.

> > +
> > +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> > +       do {
> > +               u32 size;
> > +               void *sample;
> > +
> > +               err = __bpf_user_ringbuf_poll(rb, &sample, &size);
> > +
> 
> nit: don't keep empty line between function call and error check

Ack.

> > +               if (!err) {
> 
> so -ENODATA is a special error and you should stop if you get that.
> But for any other error we should propagate error back, not just
> silently consuming it
> 
> maybe
> 
> err = ...
> if (err) {
>     if (err == -ENODATA)
>       break;
>     return err;
> }
> 
> ?

Agreed, I'll fix this.

> > +                       struct bpf_dynptr_kern dynptr;
> > +
> > +                       bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL,
> > +                                       0, size);
> 
> we should try to avoid unnecessary re-initialization of dynptr, let's
> initialize it once and then just update data and size field inside the
> loop?

Hmm ok, let me give that a try. 

> > +                       ret = callback((u64)&dynptr,
> > +                                       (u64)(uintptr_t)callback_ctx, 0, 0, 0);
> > +
> > +                       __bpf_user_ringbuf_sample_release(rb, size, flags);
> > +                       num_samples++;
> > +               }
> > +       } while (err == 0 && num_samples < 4096 && ret == 0);
> > +
> 
> 4096 is pretty arbitrary. Definitely worth noting it somewhere and it
> seems somewhat low, tbh...
> 
> ideally we'd cond_resched() from time to time, but that would require
> BPF program to be sleepable, so we can't do that :(

Yeah, I knew this would come up in discussion. I would love to do
cond_resched() here, but as you said, I don't think it's an option :-/ And
given the fact that we're calling back into the BPF program, we have to be
cognizant of things taking a while and clogging up the CPU. What do you
think is a more reasonable number than 4096?

[...]

> >         case ARG_PTR_TO_DYNPTR:
> > +               /* We only need to check for initialized / uninitialized helper
> > +                * dynptr args if the dynptr is not MEM_ALLOC, as the assumption
> > +                * is that if it is, that a helper function initialized the
> > +                * dynptr on behalf of the BPF program.
> > +                */
> > +               if (reg->type & MEM_ALLOC)
> 
> Isn't PTR_TO_DYNPTR enough indication? Do we need MEM_ALLOC modifier?
> Normal dynptr created and used inside BPF program on the stack are
> actually PTR_TO_STACK, so that should be enough distinction? Or am I
> missing something?

I think this would also work in the current state of the codebase, but IIUC
it relies on PTR_TO_STACK being the only way that a BPF program could ever
allocate a dynptr. I was trying to guard against the case of a helper being
added in the future that e.g. returned a dynamically allocated dynptr that
the caller would eventually need to release in another helper call.
MEM_ALLOC seems like the correct modifier to more generally denote that the
dynptr was externally allocated.  If you think this is overkill I'm totally
fine with removing MEM_ALLOC. We can always add it down the road if we add
a new helper that requires it.

[...]

> > @@ -7477,11 +7524,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                 /* Find the id of the dynptr we're acquiring a reference to */
> >                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> >                         if (arg_type_is_dynptr(fn->arg_type[i])) {
> > +                               struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
> > +
> >                                 if (dynptr_id) {
> >                                         verbose(env, "verifier internal error: multiple dynptr args in func\n");
> >                                         return -EFAULT;
> >                                 }
> > -                               dynptr_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> > +
> > +                               if (!(reg->type & MEM_ALLOC))
> > +                                       dynptr_id = stack_slot_get_id(env, reg);
> 
> this part has changed in bpf-next

Yeah, this is all rewired in the new version I sent out in v2 (and will
send out in v3 when I apply your other suggestions).

[...]

Thanks for the thorough review!

- David
