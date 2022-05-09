Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9401520483
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 20:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiEISdj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 14:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiEISdh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 14:33:37 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABFC2AC0EA
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 11:29:42 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h11so9899343ila.5
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HccUJ7ekrPufyJrqf+QB9yEUw31OGY2ZXkOVO8zZFk=;
        b=WCk20+Z6ms7/7Y52daLiw8tHvdBpsdDOi3AkKQh0qtW0f0jKJo3rFQn6AWbjrJSlFW
         mWG7frhake1pJAkXJelT3Ijja9WJ3KF3DkgSLizAx5FSQpfNR2wMqAca5CJAevDyd8Kx
         TxuvWf82tYXSa8oZCQzDv+rr9/kL3wVQ22bTZgffc5/kO9ccjBbr70Dw8S76YK/jOZHE
         B2iwxG4hn20EsWJ45ZCEzfU8x97PfQLIi9xIiIqH1kvCihrgSAWglkuZ+DhDvKrbTUxd
         ENRzEOcZn+hdShL96ckctgGqNSR/wbL0lPdlj3U2zUph6r3AaCrVLLtxMpMZt4GNrEnz
         oKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HccUJ7ekrPufyJrqf+QB9yEUw31OGY2ZXkOVO8zZFk=;
        b=j929A8dOqmXWmAmkX+q3ps0rxfEH1zAXRVj075GFyKjEvQJtut/AuQOONqWarsaEB/
         oY+sRfEORpNhbQClLht9Zi3UyIiHuPLNiScTPm0Ffqa3++PW6FgpgNzB7fW3sbaz5mBl
         eesAqrC19Fwb7wosG+gUybijV+IIpWT0akezVN0BUWBr4hK5hptqPPq9BadaTXgmyBTn
         sZHn/J28mNd3qGJClyMHyeLAJgUUgoIpnaWMpCwWeH11I6kQp3Hs8ysIaO4jKECSS9a/
         a/06xfXaPJzaiScW1sdxULd6IsixEF3w6anCzNCdvIj4FLbCu5nHUzbB6ndG3dC5HvAE
         H1ig==
X-Gm-Message-State: AOAM532B/ZbqwuL8tOWzL8SWACiFKq+YoRAIrftweSxU3lZfi9vkl9Ts
        D6R+SIi/fRmBjDRsZWlvOIPKkxkUMQy79aO/5h+/+ODXlN0=
X-Google-Smtp-Source: ABdhPJw77pK5OYdqu3f05NEMXulCryOrm1RI7Tb2BA83zxhCBL2XTkgcWrrJpF7qg2JhufzoJggBO7pC/bri0Qk64p4=
X-Received: by 2002:a05:6e02:1d8d:b0:2cf:2112:2267 with SMTP id
 h13-20020a056e021d8d00b002cf21122267mr7267888ila.239.1652120982346; Mon, 09
 May 2022 11:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-6-joannelkoong@gmail.com> <CAEf4BzY9eE1ud7RA4m6+kCGjNxhVsHo4uOQgrmbtS4C1i6Dv0A@mail.gmail.com>
 <CAJnrk1aN-HLdoauqVcj3jK7s6AWU=xSFefnse1JwixDOBLyWPQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aN-HLdoauqVcj3jK7s6AWU=xSFefnse1JwixDOBLyWPQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 11:29:31 -0700
Message-ID: <CAEf4Bzb438GdWO+t3nbrbCyZgTmFtuBai_RZqPu3Xo8KzPmVYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Add dynptr data slices
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Mon, May 9, 2022 at 10:22 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Fri, May 6, 2022 at 4:57 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > This patch adds a new helper function
> > >
> > > void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);
> > >
> > > which returns a pointer to the underlying data of a dynptr. *len*
> > > must be a statically known value. The bpf program may access the returned
> > > data slice as a normal buffer (eg can do direct reads and writes), since
> > > the verifier associates the length with the returned pointer, and
> > > enforces that no out of bounds accesses occur.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/bpf.h            |  4 +++
> > >  include/uapi/linux/bpf.h       | 12 +++++++
> > >  kernel/bpf/helpers.c           | 28 +++++++++++++++
> > >  kernel/bpf/verifier.c          | 64 ++++++++++++++++++++++++++++++----
> > >  tools/include/uapi/linux/bpf.h | 12 +++++++
> > >  5 files changed, 114 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index b276dbf942dd..4d2de868bdbc 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -397,6 +397,9 @@ enum bpf_type_flag {
> > >         /* DYNPTR points to a ringbuf record. */
> > >         DYNPTR_TYPE_RINGBUF     = BIT(9 + BPF_BASE_TYPE_BITS),
> > >
> > > +       /* MEM is memory owned by a dynptr */
> > > +       MEM_DYNPTR              = BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > do we need this yet another bit? It seems like it only matters for
> > verifier log dynptr_ output? Can we just reuse MEM_ALLOC? Or there is
> > some ringbuf-specific logic that we'll interfere with? If feels a bit
> > unnecessary, let's think if we can avoid adding bits just for this.
> I think we do need this bit to differentiate between MEM_ALLOC and
> MEM_DYNPTR because otherwise, you would be able to pass in a dynptr
> data slice to the ringbuf bpf_ringbuf_submit/discard helpers.

Right :( I forgot and missed ARG_PTR_TO_ALLOC_MEM, which relies on
this. No big deal.

As an aside, I regret using super-generic ALLOC_MEM naming for
strictly ringbuf-specific register, RINGBUF_MEM or something would be
better. But we can improve that separately.


> >
> > > +
> > >         __BPF_TYPE_LAST_FLAG    = DYNPTR_TYPE_RINGBUF,
> > >  };
> > >
> >
> > [...]
> >
> > > +               if (is_dynptr_ref_function(func_id)) {
> > > +                       int i;
> > > +
> > > +                       /* Find the id of the dynptr we're acquiring a reference to */
> > > +                       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > > +                               if (arg_type_is_dynptr(fn->arg_type[i])) {
> > > +                                       id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> >
> > let's make sure that we have only one such argument?
> Are we able to assume it's guaranteed given that
> is_dynptr_ref_function() refers to BPF_FUNC_dynptr_data and the
> definition of bpf_dynptr_data will always only have one dynptr arg?

That's why I think we should add this check, to guarantee it. Your
code assumes the first dynptr argument is the only one, completely
ignoring any more potential dynptr arguments if they are there. I
don't think that would be correct if we ever have such helpers with
two dynptrs, so we should be explicit about preventing that.

> >
> > > +                                       break;
> > > +                               }
> > > +                       }
> > > +                       if (unlikely(i == MAX_BPF_FUNC_REG_ARGS)) {
> >
> > please don't use unlikely(), especially for non-performance critical code path
> >
> > > +                               verbose(env, "verifier internal error: no dynptr args to a dynptr ref function");
> > > +                               return -EFAULT;
> > > +                       }
> > > +               } else {
> > > +                       id = acquire_reference_state(env, insn_idx);
> > > +                       if (id < 0)
> > > +                               return id;
> > > +               }
> >
> > [...]
