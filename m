Return-Path: <bpf+bounces-18014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5E814DBF
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BADB21DE5
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE63EA88;
	Fri, 15 Dec 2023 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgDMeTns"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2823EA73;
	Fri, 15 Dec 2023 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so1060793a12.3;
        Fri, 15 Dec 2023 09:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702659693; x=1703264493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGcat4FT7Y2z3MUHF2tQhN9WLelE3ranoiGCZ5nNcvw=;
        b=fgDMeTnsWwUW6zMRLGkC4tN9tt89HyfthpqqAXB1z6GkjDdGodS2netu0a+/XyqdbD
         G5eoRztgSE6KFHxASu+P/nhOr/5IY2g+JQvYEeji6Tp1F1IlsvUJIT189mE/UwfUdC9k
         Z5L3onzxoNswVrfPp1faiJkpU/tYbqXoUth1kVfcOX/m68ak7DICQFfif43elF5rYaBs
         ZswBRU5Ilp4xH6bqgVIJ6ZlDnTBrHf5v4kg2HuNQfNYU1hM4cdVDkhgUslHcxZlIgDHD
         w2wcAIRSqn/URuM7NpeZ6hX1Gw1sH32bhXS8DPTWYG5mcZJok9eNTTzd8/BM9qR30dBm
         SlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702659693; x=1703264493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGcat4FT7Y2z3MUHF2tQhN9WLelE3ranoiGCZ5nNcvw=;
        b=AdtBYMMu3Im9OC7ngRpE+ygcWHHI3jyWPmJG3oJq/CB8d+YTORTAo6ek2mSO/oQ2Ke
         mGrHhJGpwCDt/UkodfzhQryzBhq1zB+0l3G3rON6wpqrc0wafVMzNVkqJ4WOrW6YoqVG
         YTECp6quRfdJDYWjblENZ3d80BwwgGNJEpxvdf3hMeEDaTC+bqlN+YhE4EILPpRDgDC4
         d5MB8nBqrNqBvY9MKrzp8UGBYKV8PXcoMgSLRAs1gs1Ttlun+drt+CsLuJsURQmEYCsm
         i1yh3xirYwwp4Ihp+zwzlY9ggbxh4faGdKa7D/jgUcvU4BLaBb6GreyIpkuQ8pWkzyR1
         4fJA==
X-Gm-Message-State: AOJu0YzFMMgVH5n5ridYnLm0EnTcf9US7HzqsyTfgiHeTBucKtcl3xA3
	eZZR2oAWpiPQFX7G8bcB8tn+TYThz/451hZYHVU=
X-Google-Smtp-Source: AGHT+IEnC8cvgvKZ2OKDfNPiYGNq9P0dVY8E4BXcI85LTtzWcovMzM9QzZ25HYkC6kleHg7faI4m+zuTiWm9wN9zuhQ=
X-Received: by 2002:a05:6402:8c4:b0:54c:4837:81e5 with SMTP id
 d4-20020a05640208c400b0054c483781e5mr5568121edz.54.1702659693385; Fri, 15 Dec
 2023 09:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com> <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
 <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com>
 <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
 <CAADnVQ+RVT1pO1hTzMawdkfc9B0xAxas2XmSk6+_EiqX9Xy9Ug@mail.gmail.com>
 <66b2a6c45045c207d8452ad3b5786a9dc0082d79.camel@gmail.com>
 <CAEf4BzaTTv7oP2vcfVYXjUnA958MqohkRDJ9J7qOCtGfpijROw@mail.gmail.com> <149715b52bdd9ec9453a8a817d8339bd1a86a4f7.camel@gmail.com>
In-Reply-To: <149715b52bdd9ec9453a8a817d8339bd1a86a4f7.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Dec 2023 09:01:20 -0800
Message-ID: <CAEf4Bzb0a0zRsT-UfQGR03Bp-7ztxd2OGDTgG3F4fnBpxFme9A@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hao Sun <sunhao.th@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:22=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-12-14 at 21:20 -0800, Andrii Nakryiko wrote:
> [...]
> > > > can we detect that any register link is broken and force checkpoint=
 here?
> > >
> > > Should be possible. I'll try this in the morning and check veristat r=
esults.
>
> {still working on this}
>
> > > By the way, I added some stats collection for find_equal_scalars() an=
d see
> > > the following results when run on ./test_progs:
> > > - maximal number of registers with same id per call: 3
> > > - average number of registers with same id per call: 1.4
> >
> > What if we keep 8 extra bytes in jump/instruction history and encode
> > up to 8 linked registers/slots:
> >
> > 1. 1 bit to mark whether it's a src_reg set, or dst_reg set
> > 2. 1 bit to mark whether it's a stack slot or register
> > 3. 6 bits (0..63 values) to record register or slot number
> >
> > If we ever need more than 8 linked registers, we can just forcefully
> > some "links" by resetting some IDs?
>
> That should work as well.
> Probably don't need src/dst bit, as backtracker marks both as precise
> when processing conditional jump.

yeah, probably

>
> You mean "just forcefully [breaking] some "links" by resetting ...", righ=
t?

yeah, breaking, sorry, inattentive brain :)

>
> > BTW, is it only conditional jumps that need to record this linked
> > register sets? Did we previously discuss why we don't need this for
> > any other operation?
>
> Don't think that we discussed it.
> Here is my reasoning: the range transfer happens at find_equal_scalars()
> which is called only from check_cond_jmp_op().
> I think there are no other effects IDs have for scalar values.
> Thus, covering conditional jumps seems sufficient.
>
>

yep, makes sense, any other operation is breaking the link

