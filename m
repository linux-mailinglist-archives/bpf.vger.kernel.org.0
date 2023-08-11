Return-Path: <bpf+bounces-7611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893D7799AD
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EDE281A01
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00457329CC;
	Fri, 11 Aug 2023 21:41:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761E8833
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 21:41:37 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FEF213B
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:41:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6418dd60676so6770056d6.2
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691790094; x=1692394894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXtaaKHxnypfgs/oLbWQkYgVmbOAwz8sg7xsZiTGfbQ=;
        b=krsHfd0UcQW1NZ0taSMM6R3PC1OG48OOCvvMh/7oZtxxIWWlESTizz1Cwe82z/CAyn
         /N98lq0/ptdjlRfrjjOVol4KSL5dqBvU6e34Evak/pj1D0gp9ed1H6Pb4+Dk5/kPsroT
         JunBMasaCckpt2J92lsQo4UgyVX8p0Q6CkuXH/c/M4IZjyjR5keegClefvAnBjrr1leb
         Y8mgp53P/w3bPkk5t3hgtGUyiwevgr5ljsU1PAT47cpg5HeuIvK43aZSR9MrFZ421RCV
         EQQK0zVzCgEvWdvBKhcnEf5O/EQVt++ljpWMEc6sOWrHzBAGPlC/jJPjwgn6bLXd26qs
         ekPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790094; x=1692394894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXtaaKHxnypfgs/oLbWQkYgVmbOAwz8sg7xsZiTGfbQ=;
        b=JLkS9zaGodxnZOhALioB68jcvy0rpIpaSa6Z1betpzoBbnnPp8QoTZA2agbwjawtd4
         Qxbz13nKBXcwibSYCRMAXaP7alGIk00d1uML+/bQFkIrqjF0tekschhi+1R1ctzWlimw
         yrwn5BdfyZtNtP/xaioEfG7I+6qgrFHmtLLj9OBmXKuOFUeh5UiFxcIyPfkcH8/4tErY
         6dVPrvRD5mpr/e9K74NFVMxChPPlmo8YtCTVJo8YKrCF+5fiqGwAZYDJa8/RYMbPYU/d
         d486fmEyV3N7XPkwiqcp0XTzqhrNc2Plo0wwXAN4aXrbW4xKQe9vI0UI9sQhlV30Gujb
         kNGA==
X-Gm-Message-State: AOJu0YyluClgqivZre5n9JHdZ2MuzVhOg+2Asf2TLYH87PRZXiP7XLiq
	enTg8RB9VCZCRFanxXIJ4zsD5tP83znGSIBeNkn+IQ==
X-Google-Smtp-Source: AGHT+IELZq70c2oqQkcGwqmSXXlxVlWtzpNt/UmTAHkCYpRqPjf1MosPsrf8X4+k2O46nG5deyST/VJYdyhDQa+rgWo=
X-Received: by 2002:a0c:b28f:0:b0:646:1b3:7d2c with SMTP id
 r15-20020a0cb28f000000b0064601b37d2cmr650814qve.46.1691790094416; Fri, 11 Aug
 2023 14:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
 <20230811172116.GC542801@maniforge> <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
In-Reply-To: <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 11 Aug 2023 17:41:23 -0400
Message-ID: <CADx9qWiJCQyLdz5rG33K2iWtsgXQ65K3aiwQiEsjSwY2ofNy1Q@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Watson Ladd <watsonbladd@gmail.com>
Cc: void@manifault.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Dave Thaler <dthaler@microsoft.com>, Christoph Hellwig <hch@infradead.org>, "bpf@ietf.org" <bpf@ietf.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Watson, thank you!

On Fri, Aug 11, 2023 at 5:36=E2=80=AFPM Watson Ladd <watsonbladd@gmail.com>=
 wrote:
>
> Dear David,
>
> Thank you very much for your lengthy and kind email. I agree that we
> should punt on contentious points and aim to standardize what has
> already been implemented across a wide range of implementations. Most
> of my issues are with the format and presentation of the text, and I
> think the content changes it would take are pretty noncontenous. I
> don't really have any insight into what the content should be, and I'm
> sure that for those who live and breath BPF every day, much of what I
> am confused about is indeed obvious.
>
> Concretely I think the following would help improve the
> understandability of the document:
> * After the register paragraph, describe the memory. As I understand
> it it is a 64 bit, byte addressed, flat space, and maps are just
> special regions in it. Maybe I'm wrong. There's some stuff about types
> in the big space of instructions that maybe makes me think I am wrong.
> * Say this is a 2's complement architecture

I just wanted to quickly follow up on this ... I, too, believe that we
should say this in the ISA and put forward a patch with some language.
You can see the discussion about that here:
https://lore.kernel.org/bpf/20230710215818.gCPVzgaK-YEXRFNixwcVrMLKlkiM0Fqk=
QbUytFlDTQQ@z/

Thank you, again, for the conversation!
Will


> * I finally understand why the code fields have their low nybble zero.
> We should maybe say this.
> * Explicitly call out after 5.2 that there is no memory model yet
> * Pull up section 5.3.1 to the top, or figure out some way to punt it
> to an extension. Maybe introduce maps up top then explain how they are
> indexed here.
>
> For extensions if I think I understand the conversation at IETF 117,
> it's easy to add more calls to the host system as functions. It's a
> lot more of a difficulty to add more instructions, but in the wide
> encoding space there is room. We could definitely say that. The memory
> model should only modify the behavior of environments with races, so
> if things aren't racy, nothing changes. That should work, but maybe I
> don't understand what other extensions that people would want to add.
> Verification might be an extension, but probably not in the sense we
> need to worry about it here?
>
> I hope the above is helpful: as always my ignorance can completely
> negate the value of the concrete suggestion, but I do hope it
> highlights areas that could use some TLC.
>
> Sincerely,
> Watson Ladd
>
> --
> Astra mortemque praestare gradatim
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

