Return-Path: <bpf+bounces-12693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1AB7CF8C3
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6013E1C20EA8
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFCD225A9;
	Thu, 19 Oct 2023 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wze9bdvh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462321369
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:28:56 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9956C181
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 05:28:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so1298763266b.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697718533; x=1698323333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AXROsG5vlLmgOR5vm8tBBIkDMN6+wko0/gA2kZBbTEQ=;
        b=Wze9bdvh2iHHYTXKn044ReKloT5jL7xmqdwVmohqB7yiioS3LGCVYgCrhbXL4vuGMM
         4XJXSzWihJFna2dbbSqB4JRu+9YHnMzjVnE6W7gI2vDq2lp3aaTk8kNjYlQvU2pkOLfi
         bkZoAgDxrRfFM+/OPOOL0cxOJ5SJSBaVIr5Xt2fnl4YjFtkabVvYsGTr6d/Sel1QSWvR
         Vqkfq1F0fTSksbPbz27yM280Guf9qq+fkmQ7IurZTUUBAKmnIn/rq4lheOVuzLGpeIu1
         Ns6ngb1xW+G5+uu5tHWI5V/rOZce2vPExd5anAtS5yhLv95dkvnVOeuPS9ulZkJNCNCj
         PBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697718533; x=1698323333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXROsG5vlLmgOR5vm8tBBIkDMN6+wko0/gA2kZBbTEQ=;
        b=GGBzPFToLMIW2wKspUmRRMiMkpivi/7cCjZ6vdIyeUmonUDbtUn9TEOpyxxKJM927V
         DXKUDwpkvqaNwOCligmniEDHtZdn0iTah+p2EXzbH8M3q0GiA4R2Txo59cbrf3phF7UF
         LZ7rouNETtVd4SSaNHeqGJzXhB7FK4WlcKMn6StK7LtzcyGMXklYpb4YVzkaorAtkUcF
         FF66LEfHPf1Q5Hp3Z0b9gE1RYc+lxDItOPhIVnT+4Ss9yx6R3oLhndlc1Smu35AZTOCL
         UnMYJ+V55MpE8KhivRyPdODDfbrjUpZMvB4yP3nY2IdAhK6FBVeuYrpKSuHZHXqsMvfx
         wpGQ==
X-Gm-Message-State: AOJu0YwB3JcxjckzX981m6r0Q1V2BF+C/02JbDDSujlkEQK4ewHwklmG
	a5VZue2qW9NZ9cPGhluUflmCug==
X-Google-Smtp-Source: AGHT+IGDxOb3ZPKVZdkvKXrBgWAQhru6CcdjnMGVzkYPvlAm/gE18M7J10+BZeq9+zlPA/CMSAdPXg==
X-Received: by 2002:a17:907:9306:b0:9ae:5f51:2e4a with SMTP id bu6-20020a170907930600b009ae5f512e4amr1815266ejc.36.1697718532893;
        Thu, 19 Oct 2023 05:28:52 -0700 (PDT)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id fi10-20020a170906da0a00b0098669cc16b2sm3427218ejb.83.2023.10.19.05.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:28:52 -0700 (PDT)
Date: Thu, 19 Oct 2023 12:28:46 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>, Marek Majkowski <marek@cloudflare.com>,
	Lorenz Bauer <lmb@cloudflare.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	David Miller <davem@davemloft.net>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: bpf indirect calls
Message-ID: <ZTEg_lJ9QE3VvLP5@google.com>
References: <87o8yqjqg0.fsf@toke.dk>
 <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
 <87v9srijxa.fsf@toke.dk>
 <20191016022849.weomgfdtep4aojpm@ast-mbp>
 <8736fshk7b.fsf@toke.dk>
 <20191019200939.kiwuaj7c4bg25vqs@ast-mbp>
 <ZRQtsyYM810Oh4px@google.com>
 <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
 <ZR_VBYHYKZzHqjb8@google.com>
 <CAADnVQK+_1-d0mHJzvsq4FZmL+GSY+uo6HjQRLu2tJybCAO9+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK+_1-d0mHJzvsq4FZmL+GSY+uo6HjQRLu2tJybCAO9+g@mail.gmail.com>

On Fri, Oct 06, 2023 at 11:49:37AM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 6, 2023 at 2:36 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > On Fri, Sep 29, 2023 at 02:06:10PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Sep 27, 2023 at 6:27 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > > static void testing(void) {
> > > >   bpf_printk("testing");
> > > > }
> > > >
> > > > struct iter_ctx {
> > > >   void (*f) (void);
> > > > };
> > > > static u64 iter_callback(struct bpf_map *map, u32 *key,
> > > >                          u64 *value, struct iter_ctx *ctx) {
> > > >   if (ctx->f) {
> > > >     ctx->f();
> > > >   }
> > > >   return 0;
> > > > }
> > > >
> > > > SEC("lsm.s/file_open")
> > > > int BPF_PROG(file_open, struct file *file)
> > > > {
> > > >   struct iter_ctx iter_ctx = {
> > > >     .f = testing,
> > > >   };
> > > >   bpf_for_each_map_elem(&map, iter_callback, &iter_ctx, 0);
> > > >   return 0;
> > > > }
> > > > ```
> > > ...
> > > > The fundamental difference between the two call instructions if I'm
> > > > not mistaken is that one attempts to perform a call using an immediate
> > > > value as its source operand, whereas the other attempts to perform a
> > > > call using a source register as its source operand. AFAIU, the latter
> > > > is not currently permitted by the BPF verifier. Is that right?
> > >
> > > Correct. Indirect calls via 'callx' instruction are not supported yet.
> > > Please use bpf_tail_call() as a workaround for now.
> >
> > Noted.
> >
> > > Over the years the verifier became progressively smarter and maybe
> > > now is a good time to support true indirect calls.
> >
> > This is something that I wouldn't mind exploring myself as a little
> > research/contribution project. Would you object to me taking this on?
> > I feel as though this would give me an opportunity to develop a better
> > understanding when it comes to the internals of the BPF subsystem.
> 
> Please go ahead, but let's get to the bottom of your concern first.
> See below.

OK, sure.

> > > For certain cases like your example above it's relatively easy to
> > > add such support, but before we do that please describe the full use
> > > case that you wanted to implement with indirect calls.
> >
> > For the specific example I provided above, using indirect calls was an
> > approach that I considered using within one of our BPF programs in
> > order to work around this [0] specific BPF verifier shortcoming. For
> > the workaround, I needed to implement 2 BPF programs that more or less
> > done the same thing using the same set of routines, but differed ever
> > so slightly for one particular routine. The way I envisioned
> > controlling that one small difference between the 2 BPF programs is by
> > supplying in different function pointers within the iteration context
> > passed to bpf_for_each_map_elem(),
> 
> Early in that [0] link you were asking about kfunc detection and
> the issue was that it's not backported to older kernels.
> Here you're proposing a totally new feature of indirect calls which
> is a magnitude bigger than kfunc detection.
> Highly unlikely it will be backported to older kernels.
> For google kernels you can backport anything you want, of course.

Well, that holds true most of the time, but it also depends on the
context you're talking about of course. As you can also imagine, some
areas are a little more receptive at applying a specific backport then
others.

> So backport of kfunc detection would have been enough and
> you wouldn't need indirect calls ?

Yes, I agree that backporting a specific patch would fundamentally
address the specific problem that I ran into here, but we didn't take
that route so I was left scrambling looking for alternate
approaches. Regardless of the decision made in this specific scenario
on whether to backport or not, it doesn't go to say that we shouldn't
look at implementing indirect call support, right?

/M

