Return-Path: <bpf+bounces-10415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E17A6F4B
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 01:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36750280D7A
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938B37143;
	Tue, 19 Sep 2023 23:14:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35C46A1
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 23:14:41 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4EC5
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:14:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-404773f2501so59667845e9.0
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695165278; x=1695770078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPk+WKhimpYwBdX8XFHH0nBVuna5VV3c38rjq7breIo=;
        b=HZ1KADIhQ9IEMCZrbrJ9+StTV+ndiSTiPzKN6Wt0mSHp6oucTrzOnArp5eWR/+HNoV
         L01Y/pseQ3+gtvHEqVED3YDu4tMfQ4KTemqbdsFG0CWpIVF1qvAQdQPiuztqyYaqtFsU
         BfDkJ8Ay9hOZLv5aSbwoco087JDWBJ6sp61aHrlIFH2fPXB9NABBZvG+UIajREv+oxdh
         OhOZxFpF7kqdqhDgsmqK9prfnusB948UmuxZJTWSUDrKDRl2XisHFX0d0bGbkMQXHA6O
         kqefIZhChSlX1SzV4FdQD/3xTTdcEVAZQ3HnSimc3MNneNFEcaLW9GyJYAWi6R2g+6MH
         t2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695165278; x=1695770078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPk+WKhimpYwBdX8XFHH0nBVuna5VV3c38rjq7breIo=;
        b=B7rSES4KQ7Km4T/Qk8DwZJvxGYKBA5r5uZynZYpxfNcl8/nt1vfIvBORAkZ9Teurnt
         CVoNVKAD0uIL2vXrFaWB2Aj0FEvzfkYWs2ByEaE/RhcBmU/4vjBJJSAHr/1x2D4PW4ua
         soWgJi/UglcXze8w4Gc7GhUr3R597JC7Xxu5WjmrBDNIly/bVUY7mtr+lh1kKRY7Lib9
         MktAozRlUGMa7faK1lJFKzlXC9bNZHTmpAGcKH6s3lWxLPKBfcNRjWX3cJ/YYhhSOIha
         HLCk6reQZ1/8FbkPao7M3C96eKoHaJryQL99sxe96jB9x2eRFGSOk0echqyZihPqum9A
         KqXA==
X-Gm-Message-State: AOJu0YxkTRdC6GQXrLUjFkIEjQw2+x6C8xQEgkJ7UmvnrNWqEVMxGCFB
	CyzHk3/A6qn9Y4IC3wwYD2cLrKygLAAxvHNgtB0DYjoF
X-Google-Smtp-Source: AGHT+IEknXJmgpVA0vxWp/0m3NYF6FY8Txs8UHRXTTAiGS3GDCzjRsNvP6NopWvDgQaw0KCz71wAdpAi7d4bNblCAOo=
X-Received: by 2002:a05:600c:2249:b0:3fb:e189:3532 with SMTP id
 a9-20020a05600c224900b003fbe1893532mr936169wmm.20.1695165277853; Tue, 19 Sep
 2023 16:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com> <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
In-Reply-To: <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Sep 2023 16:14:25 -0700
Message-ID: <CAEf4BzbKV5eHSWk8LgQmCM1vx1N2__ANUbB137i7_7RqBOsTiQ@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 2:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-07-07 at 11:08 -0700, Andrii Nakryiko wrote:
> > On Fri, Jul 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 7, 2023 at 7:04=E2=80=AFAM Andrew Werner <awerner32@gmail=
.com> wrote:
> > > >
> > > > When it comes to fixing the problem, I don't quite know where to st=
art.
> > > > Perhaps these iteration callbacks ought to be treated more like glo=
bal functions
> > > > -- you can't always make assumptions about the state of the data in=
 the context
> > > > pointer. Treating the context pointer as totally opaque seems bad f=
rom
> > > > a usability
> > > > perspective. Maybe there's a way to attempt to verify the function
> > > > body of the function
> > > > by treating all or part of the context as read-only, and then if th=
at
> > > > fails, go back and
> > > > assume nothing about that part of the context structure. What is th=
e
> > > > right way to
> > > > think about plugging this hole?
> > >
> > > 'treat as global' might be a way to fix it, but it will likely break
> > > some setups, since people passing pointers in a context and current
> > > global func verification doesn't support that.
> >
> > yeah, the intended use case is to return something from callbacks
> > through context pointer. So it will definitely break real uses.
> >
> > > I think the simplest fix would be to disallow writes into any pointer=
s
> > > within a ctx. Writes to scalars should still be allowed.
> >
> > It might be a partial mitigation, but even with SCALARs there could be
> > problems due to assumed SCALAR range, which will be invalid if
> > callback is never called or called many times.
> >
> > > Much more complex fix would be to verify callbacks as
> > > process_iter_next_call(). See giant comment next to it.
> >
> > yep, that seems like the right way forward. We need to simulate 0, 1,
> > 2, .... executions of callbacks until we validate and exhaust all
> > possible context modification permutations, just like open-coded
> > iterators do it
> >
> > > But since we need a fix for stable I'd try the simple approach first.
> > > Could you try to implement that?
>
> Hi All,
>
> This issue seems stalled, so I took a look over the weekend.
> I have a work in progress fix, please let me know if you don't agree
> with direction I'm taking or if I'm stepping on anyone's toes.
>
> After some analysis I decided to go with Alexei's suggestion and
> implement something similar to iterators for selected set of helper
> functions that accept "looping" callbacks, such as:
> - bpf_loop
> - bpf_for_each_map_elem
> - bpf_user_ringbuf_drain
> - bpf_timer_set_callback (?)

As Kumar mentioned, pretty much all helpers with callbacks are either
0-1, or 0-1-many cases, so all of them (except for the async callback
ones that shouldn't be accepting parent stack pointers) should be
validated.

>
> The sketch of the fix looks as follows:
> - extend struct bpf_func_state with callback iterator state information:
>   - active/non-active flag

not sure why you need this flag

>   - depth

yep, this seems necessary

>   - r1-r5 state at the entry to callback;

not sure why you need this, this should be part of func_state already?


> - extend __check_func_call() to setup callback iterator state when
>   call to suitable helper function is processed;

this logic is "like iterator", but it's not exactly the same, so I
don't think we should reuse bpf_iter state (as you can see above with
active/non-active flag, for example)

> - extend BPF_EXIT processing (prepare_func_exit()) to queue new
>   callback visit upon return from iterating callback
>   (similar to process_iter_next_call());

as mentioned above, we should simulate "no callback called" situation
as well, don't forget about that

> - extend is_state_visited() to account for callback iterator hits in a
>   way similar to regular iterators;
> - extend backtrack_insn() to correctly react to jumps from callback
>   exit to callback entry.
>
> I have a patch (at the end of this email) that correctly recognizes
> the bpf_loop example in this thread as unsafe. However this patch has
> a few deficiencies:
>
> - verif_scale_strobemeta_bpf_loop selftest is not passing, because
>   read_map_var function invoked from the callback continuously
>   increments 'payload' pointer used in subsequent iterations.
>
>   In order to handle such code I need to add an upper bound tracking
>   for iteration depth (when such bound could be deduced).

if the example is broken and really can get out of bounds, we should
fix an example to be provable within bounds no matter how many
iterations it was called with

>
> - loop detection is broken for simple callback as below:
>
>   static int loop_callback_infinite(__u32 idx, __u64 *data)
>   {
>       for (;;)
>           (*ctx)++;
>       return 0;
>   }
>
>   To handle such code I need to change is_state_visited() to do
>   callback iterator loop/hit detection on exit from callback
>   (returns are not prune points at the moment), currently it is done
>   on entry.

I'm a bit confused. What's ctx in the above example? And why loop
detection doesn't detect for(;;) loop right now?

>
> - the callback as bellow currently causes state explosion:
>
>   static int precise1_callback(__u32 idx, struct precise1_ctx *ctx)
>   {
>       if (idx =3D=3D 0)
>           ctx->a =3D 1;
>       if (idx =3D=3D 1 && ctx->a =3D=3D 1)
>           ctx->b =3D 1;
>       return 0;
>   }

why state explosion? there should be a bunch of different branches
(idx 0, 1, something else x ctx->a =3D 1 or not 1 and ctx->b being 1 or
not), but it should be a fixed number of states? Do you know what
causes the explosion?

>
>   I'm not sure yet what to do about this, there are several possibilities=
:
>   - tweak the order in which states are visited (need to think about it);
>   - check states in bpf_verifier_env::head (not explored yet) for
>     equivalence and avoid enqueuing duplicate states.
>
> I'll proceed addressing the issues above on Monday.
>
> Thanks,
> Eduard
>
> ---
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index a3236651ec64..5589f55e42ba 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -70,6 +70,17 @@ enum bpf_iter_state {
>         BPF_ITER_STATE_DRAINED,
>  };
>
> +struct bpf_iter {
> +       /* BTF container and BTF type ID describing
> +        * struct bpf_iter_<type> of an iterator state
> +        */
> +       struct btf *btf;
> +       u32 btf_id;
> +       /* packing following two fields to fit iter state into 16 bytes *=
/
> +       enum bpf_iter_state state:2;
> +       int depth:30;
> +};
> +
>  struct bpf_reg_state {
>         /* Ordering of fields matters.  See states_equal() */
>         enum bpf_reg_type type;
> @@ -115,16 +126,7 @@ struct bpf_reg_state {
>                 } dynptr;
>
>                 /* For bpf_iter stack slots */
> -               struct {
> -                       /* BTF container and BTF type ID describing
> -                        * struct bpf_iter_<type> of an iterator state
> -                        */
> -                       struct btf *btf;
> -                       u32 btf_id;
> -                       /* packing following two fields to fit iter state=
 into 16 bytes */
> -                       enum bpf_iter_state state:2;
> -                       int depth:30;
> -               } iter;
> +               struct bpf_iter iter;

Let's not do this, conceptually processes are similar, but bpf_iter is
one thing, and this callback validation is another thing. Let's not
conflate things.

>
>                 /* Max size from any of the above. */
>                 struct {

[...]

