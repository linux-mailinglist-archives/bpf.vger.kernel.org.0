Return-Path: <bpf+bounces-11561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7EE7BBEFA
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40101C20929
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6B38F99;
	Fri,  6 Oct 2023 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8VdU1AR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7A37CAC;
	Fri,  6 Oct 2023 18:49:52 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B79F1;
	Fri,  6 Oct 2023 11:49:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so23709055e9.3;
        Fri, 06 Oct 2023 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696618189; x=1697222989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxs4FWHmu2CqsebILhu7Py5TP6u7sNSZjtgjJAlPuQM=;
        b=T8VdU1ARIfowwLZj1C6DoIVUTKG4kdu30L1CTK4g+udMQYSMMjTrQGj8m7Xxs7Yo7q
         Uy5PUjIM5KN4R5CRssJ2Wo1ddi4xqMXUyI7693JvjdA+lBj6M2syZt0tkZ/kyrVnT4YM
         85RKrLWWXPLXXwRm4V+V8Ffw0B0iSGxz7hsQ/yWVZj2o3iHGWLt9JOqGO2iq+7U1EPT+
         A15TPBmlW6A1D71KBOnxLP8+LLnX4/tXzNTH2sxTmHzlotW23UeYjKA8e2lgj5lIOmkG
         /m26Ipok8ANMZ4vaNqLqiXENbrZWbo8IQJckdkfXC+pk7Tt4ESs2PMNG8lMPmn15estu
         gCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618189; x=1697222989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hxs4FWHmu2CqsebILhu7Py5TP6u7sNSZjtgjJAlPuQM=;
        b=p8+OHFlhHkmblZBA2J7OC/xIkCJDiJnWFBhY1lNHVOF7yhkmlM+RiTfHPmTQJIcMNV
         cfUeI/1TBJlPR8K926t/1dmA++IEa8qQvCb/EXGz7rrMg/STQGist3wGqklGjaftDazY
         LRLniugyLO1gNWhs4E0GqFOjKWEI8EyZ2tkG1HaUnWjYNPYjV4eicmy/94aq/+hJKRyr
         9TWEVXulDkJOMl3uBTpbxCnZQdsjhVD+D3Yf2TcAwWaNHzN6WaFjlWGRBsjSiP7ETg8u
         nMYcYbzFNX5aAHxRuGZOx7m7PTv9fVUGKJsVQvZvvLgDuimvmHpIY37/RCD0SvCgMKT1
         lCrg==
X-Gm-Message-State: AOJu0YxGYfuY4x/IHWufF/+PLui8YLAEtSXoJ5PBfiJyzlwoobM97yoX
	h6RJsEt5hzi5uQLdw/GtCat6cCVR9hR/WZ1VgutTMSOX
X-Google-Smtp-Source: AGHT+IGYOw4m8wtyRYtyqIWLKOVr6m9CglmB14mBk1/29V5kC4EhwV7aU9TxE7X82Ax8vcTtfXamDvKkWSOL+FNq5II=
X-Received: by 2002:a1c:ed07:0:b0:405:37bb:d93e with SMTP id
 l7-20020a1ced07000000b0040537bbd93emr7376778wmh.9.1696618188795; Fri, 06 Oct
 2023 11:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
 <87o8yqjqg0.fsf@toke.dk> <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
 <87v9srijxa.fsf@toke.dk> <20191016022849.weomgfdtep4aojpm@ast-mbp>
 <8736fshk7b.fsf@toke.dk> <20191019200939.kiwuaj7c4bg25vqs@ast-mbp>
 <ZRQtsyYM810Oh4px@google.com> <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
 <ZR_VBYHYKZzHqjb8@google.com>
In-Reply-To: <ZR_VBYHYKZzHqjb8@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Oct 2023 11:49:37 -0700
Message-ID: <CAADnVQK+_1-d0mHJzvsq4FZmL+GSY+uo6HjQRLu2tJybCAO9+g@mail.gmail.com>
Subject: Re: bpf indirect calls
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Marek Majkowski <marek@cloudflare.com>, Lorenz Bauer <lmb@cloudflare.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	David Miller <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 2:36=E2=80=AFAM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> On Fri, Sep 29, 2023 at 02:06:10PM -0700, Alexei Starovoitov wrote:
> > On Wed, Sep 27, 2023 at 6:27=E2=80=AFAM Matt Bobrowski <mattbobrowski@g=
oogle.com> wrote:
> > > static void testing(void) {
> > >   bpf_printk("testing");
> > > }
> > >
> > > struct iter_ctx {
> > >   void (*f) (void);
> > > };
> > > static u64 iter_callback(struct bpf_map *map, u32 *key,
> > >                          u64 *value, struct iter_ctx *ctx) {
> > >   if (ctx->f) {
> > >     ctx->f();
> > >   }
> > >   return 0;
> > > }
> > >
> > > SEC("lsm.s/file_open")
> > > int BPF_PROG(file_open, struct file *file)
> > > {
> > >   struct iter_ctx iter_ctx =3D {
> > >     .f =3D testing,
> > >   };
> > >   bpf_for_each_map_elem(&map, iter_callback, &iter_ctx, 0);
> > >   return 0;
> > > }
> > > ```
> > ...
> > > The fundamental difference between the two call instructions if I'm
> > > not mistaken is that one attempts to perform a call using an immediat=
e
> > > value as its source operand, whereas the other attempts to perform a
> > > call using a source register as its source operand. AFAIU, the latter
> > > is not currently permitted by the BPF verifier. Is that right?
> >
> > Correct. Indirect calls via 'callx' instruction are not supported yet.
> > Please use bpf_tail_call() as a workaround for now.
>
> Noted.
>
> > Over the years the verifier became progressively smarter and maybe
> > now is a good time to support true indirect calls.
>
> This is something that I wouldn't mind exploring myself as a little
> research/contribution project. Would you object to me taking this on?
> I feel as though this would give me an opportunity to develop a better
> understanding when it comes to the internals of the BPF subsystem.

Please go ahead, but let's get to the bottom of your concern first.
See below.

>
> > For certain cases like your example above it's relatively easy to
> > add such support, but before we do that please describe the full use
> > case that you wanted to implement with indirect calls.
>
> For the specific example I provided above, using indirect calls was an
> approach that I considered using within one of our BPF programs in
> order to work around this [0] specific BPF verifier shortcoming. For
> the workaround, I needed to implement 2 BPF programs that more or less
> done the same thing using the same set of routines, but differed ever
> so slightly for one particular routine. The way I envisioned
> controlling that one small difference between the 2 BPF programs is by
> supplying in different function pointers within the iteration context
> passed to bpf_for_each_map_elem(),

Early in that [0] link you were asking about kfunc detection and
the issue was that it's not backported to older kernels.
Here you're proposing a totally new feature of indirect calls which
is a magnitude bigger than kfunc detection.
Highly unlikely it will be backported to older kernels.
For google kernels you can backport anything you want, of course.
So backport of kfunc detection would have been enough and
you wouldn't need indirect calls ?

