Return-Path: <bpf+bounces-11532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E17BB452
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF37282235
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D9134D9;
	Fri,  6 Oct 2023 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2iYMWoU+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DA1173C
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 09:36:15 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A6BE
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 02:36:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b64b98656bso333908766b.0
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696584972; x=1697189772; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cjliP84cNex8iX/xFxD5gf52DEPDu15y5gIQAC9tZlE=;
        b=2iYMWoU+aCExjHze/1OzDSdmqyFMED0fy7MkSg+2Xi73ClyHY+2wlHpFVlJuTM7soL
         QJi6s3MVK01jsORCii+jVTh9SgaFGHYb5LJly8uIclKnlu1hb24OJ+06kmCkAW2kRl11
         J8G5j0pxD7AVjaMXY9Pd53d4fxT+1vqPLvCVWLSXDrhixIj0ge3rGTy+6oaS5nf1qKkR
         Kit8knS8kfUzIchN9WcVpNEXzAlZ9aXuAk7hXhBFP3Uz6lxE/Bva6lv6XDnu6VYVTbPX
         VgpY4vNS7SS/35BOvpr3g/lQDQkZYu9xcZyqLQ0Udx+1ng64UwNSjf5SShK776KZ9JIy
         4UrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584972; x=1697189772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjliP84cNex8iX/xFxD5gf52DEPDu15y5gIQAC9tZlE=;
        b=g+3An0ja3GRKUleiImnI/V7118Xrq0CsTEWCWx2+xrZwK9P2zb0nphVZ3TMaVyJqkM
         dYzC/mphRFyL+guOiq7aKG5KknuCemgVUQ9/ck3AzxqYK6oY8HwpKqnU9cye7zdkuPLF
         nJmunLPkYkIJgPeAmXs7CVmtF0NtdRpcQji45FUJRdvQAoP56Mu4/wF/cpSdzmk5eRX9
         2BZCunBQONryxi0xeRLVfWnkbwJYX/JDBBlrlbcKhuDmVbnB9G6/jTDNdPvMh0/97K1e
         Uun4MUDR0FKVpHM9T/GsUZx3f8e0ANpyBi9sSsQod0WZczdcxi8LJXtORMbhSJA0Mujh
         H0jA==
X-Gm-Message-State: AOJu0YxTpkeqe78S4KsBYSkWsakYw1EY9/PUuUXaNOdlg4EwYhL+GdSB
	mfWtGyWf+ksB/YKBewZ46BI01g==
X-Google-Smtp-Source: AGHT+IEn7uEu28fsrp34nJlwlapCGvHJ5RfK2gucLzLSWqPEfhDJc/8BoRh2L2YLPNWKqw6h0xyKbw==
X-Received: by 2002:a17:906:530c:b0:9ae:3f69:9b8c with SMTP id h12-20020a170906530c00b009ae3f699b8cmr7587614ejo.2.1696584971409;
        Fri, 06 Oct 2023 02:36:11 -0700 (PDT)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090613d400b009b96e88759bsm2662951ejc.13.2023.10.06.02.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:36:09 -0700 (PDT)
Date: Fri, 6 Oct 2023 09:36:05 +0000
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
Message-ID: <ZR_VBYHYKZzHqjb8@google.com>
References: <87sgo3lkx9.fsf@toke.dk>
 <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
 <87o8yqjqg0.fsf@toke.dk>
 <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
 <87v9srijxa.fsf@toke.dk>
 <20191016022849.weomgfdtep4aojpm@ast-mbp>
 <8736fshk7b.fsf@toke.dk>
 <20191019200939.kiwuaj7c4bg25vqs@ast-mbp>
 <ZRQtsyYM810Oh4px@google.com>
 <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 02:06:10PM -0700, Alexei Starovoitov wrote:
> On Wed, Sep 27, 2023 at 6:27 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > static void testing(void) {
> >   bpf_printk("testing");
> > }
> >
> > struct iter_ctx {
> >   void (*f) (void);
> > };
> > static u64 iter_callback(struct bpf_map *map, u32 *key,
> >                          u64 *value, struct iter_ctx *ctx) {
> >   if (ctx->f) {
> >     ctx->f();
> >   }
> >   return 0;
> > }
> >
> > SEC("lsm.s/file_open")
> > int BPF_PROG(file_open, struct file *file)
> > {
> >   struct iter_ctx iter_ctx = {
> >     .f = testing,
> >   };
> >   bpf_for_each_map_elem(&map, iter_callback, &iter_ctx, 0);
> >   return 0;
> > }
> > ```
> ...
> > The fundamental difference between the two call instructions if I'm
> > not mistaken is that one attempts to perform a call using an immediate
> > value as its source operand, whereas the other attempts to perform a
> > call using a source register as its source operand. AFAIU, the latter
> > is not currently permitted by the BPF verifier. Is that right?
> 
> Correct. Indirect calls via 'callx' instruction are not supported yet.
> Please use bpf_tail_call() as a workaround for now.

Noted.

> Over the years the verifier became progressively smarter and maybe
> now is a good time to support true indirect calls.

This is something that I wouldn't mind exploring myself as a little
research/contribution project. Would you object to me taking this on?
I feel as though this would give me an opportunity to develop a better
understanding when it comes to the internals of the BPF subsystem.

> For certain cases like your example above it's relatively easy to
> add such support, but before we do that please describe the full use
> case that you wanted to implement with indirect calls.

For the specific example I provided above, using indirect calls was an
approach that I considered using within one of our BPF programs in
order to work around this [0] specific BPF verifier shortcoming. For
the workaround, I needed to implement 2 BPF programs that more or less
done the same thing using the same set of routines, but differed ever
so slightly for one particular routine. The way I envisioned
controlling that one small difference between the 2 BPF programs is by
supplying in different function pointers within the iteration context
passed to bpf_for_each_map_elem(), but I quickly figured out that it
wasn't possible and now I'm left with some highly undersirable code
duplication across the 2 BPF programs. Understandably, this was an
incredibly trivial and niche use case where using indirect calls would
nicely solve this kind of problem, but I'm almost certain I could find
other places where using indirect calls would be considered incredibly
useful.

[0] https://lore.kernel.org/bpf/CAADnVQLkB4dkdje5hq9ZLW0fgiDhEWU0DW67zRtJzLOKTRGhbQ@mail.gmail.com/

/M

