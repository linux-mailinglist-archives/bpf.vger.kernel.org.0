Return-Path: <bpf+bounces-6662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B6176C2F4
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B41C1C21134
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84FDA44;
	Wed,  2 Aug 2023 02:34:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDA7E6
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:34:13 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8116D1728
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:34:11 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56ca4171cb9so321556eaf.0
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 19:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690943650; x=1691548450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NmebHOtXlZgHQwI3hcOIMEjHaYQnEDiBuPQ8ahygC6Q=;
        b=AHTZUae2aqA5w3llG3TMs+2YGLmJP6qkUlzSoseE24un71Z2nPKOBva4ImYpNp8Knt
         AS4SDDPnduWwLgwp5zZ9UflhJW8YtJhCYR7BHLQ00m3LlWlZnhQnwi4bDgbd4FczKqa/
         cJt1yg0cR1QF9MEsRgKjWNt6n+/qjwc8KDC/yYQ4lmcvHPPBFtdN70quXqLYGcgro4s8
         cUwc2YGta8V40lKr69HY0l+GFq4zCoEC+7xkqV0cVnEzfSY+HoRMjrMGnA1z9ILXxhKJ
         hyySWpoeU+rTFasv4cXElYMF4qZYfAis8F/AW2chDNnda5SUxMdRhcZ22+W0nKJqd/Dk
         NUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690943650; x=1691548450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmebHOtXlZgHQwI3hcOIMEjHaYQnEDiBuPQ8ahygC6Q=;
        b=KmhCP/IypTBu7e2FJgYYAKs7hqAktqxeALp5EBP19H2EfGEbPvq3fJTcZAqp6A+fnN
         0Vx/eukzxWwV+44woaPLyqs4ThbeFux26iji0SS73K9uz/gNDNKYljeFhwenD5+LwGP/
         GjEvVcNyOrqRhflGhxVGtJ4ySKvGtn8uoQQHCI8QJfoHW0tYYyq9WwHi3LMHCJvuzeMd
         6CyqJmSdcRF/Krcc2dzZ8pevuJBphR4dX5AWCKPaI0Zh32RyROWVTFqVIi0qOChdAucY
         U7KGmairs46o3A51pp/2RxICIgB6iHk0smlYkYB50MIZKGnhGCnz7i4g3HeyCI5xy3HA
         woMw==
X-Gm-Message-State: ABy/qLYvTEFdPxmRPkFF4zOeEMos6E99Hux6WOVEYV4otOr5W/o8ywwl
	JtykcBK2SHf8ao5fHdNV/hkkO1UPezculq3T7rMdDLJg
X-Google-Smtp-Source: APBJJlHJIKaVyPwnRlcXpSJpebRp130dDAfFDW3pcZ0xkVR+sM78ddMaA6feaqLyeOPO7DnewjxLgfA7BnjF+m56qwo=
X-Received: by 2002:a4a:e9b5:0:b0:56c:cbb1:b6c7 with SMTP id
 t21-20020a4ae9b5000000b0056ccbb1b6c7mr5751194ood.1.1690943650442; Tue, 01 Aug
 2023 19:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com> <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
In-Reply-To: <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Tue, 1 Aug 2023 19:33:59 -0700
Message-ID: <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In reply to a long conversation:
<snip>
>
> Could you please be specific which instruction in table 4 is not obvious?

The question isn't obvious, the question is unambigious, and C is not
great for this. Maybe with a reference and some text it would get
better.
>
> > >
> > > > > The good news is I think this is very fixable although tedious.
> > > > >
> > > > > The other thornier issues are memory model etc. But the overall structure seems good
> > > > > and the document overall makes sense.
> > >
> > > What do you mean by "memory model" ?
> > > Do you see a reference to it ? Please be specific.
> >
> > No, and that's the problem. Section 5.2 talks about atomic operations.
> > I'd expect that to be paired with a description of barriers so that
> > these work, or a big warning about when you need to use them.
>
> That's a good suggestion.
> A warning paragraph that BPF ISA does not have barrier instructions
> is necessary.
>
> > For
> > clarity I'm pretty unfamiliar with bpf as a technology, and it's
> > possible that with more knowledge this would make sense. On looking
> > back on that I don't even know if the memory space is flat, or
> > segmented: can I access maps through a value set to dst+offset, or
> > must I always used index? I'm just very confused.
>
> flat vs segmented is an orthogonal topic.
> We definitely need to cover it in the architecture doc.
> BPF WG charter requires us to produce it as Informational doc eventually.

Huh? If you access memory through specialized descriptors+offsets
that's very different from arbitrary computations with addresses, even
if they do trap. A little explanation might orient the reader to
understand what is going on. As is I thought "ok, it's flat" and then
saw the maps and really got thrown for a loop.

>
> As far as memory model BPF adopts LKMM (Linux Kernel Memory Model).
> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p0124r7.html
>
> We can add a reference to it from BPF ISA doc, but since
> there are no barrier instructions at the moment the memory model
> statement would be premature.
> The work on "BPF Memory Model" have been ongoing for quite some time.
> For example see:
> https://lpc.events/event/11/contributions/941/attachments/859/1667/bpf-memory-model.2020.09.22a.pdf
>
> BPF Memory Model is certainly an important topic, but out of scope for ISA.

I expect that an ISA defines the semantics of the instructions. Which
absolutely includes the memory model.  Now maybe we're envisioning a
different splitting of this information, but I don't see how it can't
be at a different level if you want to give the instructions
semantics.

Sincerely,
Watson Ladd


--
Astra mortemque praestare gradatim

