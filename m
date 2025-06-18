Return-Path: <bpf+bounces-60993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877BAADF792
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA617125C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182421ABD0;
	Wed, 18 Jun 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASeSRVaf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF020CCD0
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277995; cv=none; b=heGMjQAv2f6DseQ11dmMvHT1o707IlM+s6ZiDDN7CYZV44KnhSVDFGSq/gT4pSH+aANH0IZDSq6DtYwTt0gxGk2QXvsZVU9uPMarOto7Z/v/6uYJUzT7gE7xIWVLGdkQPIpQUbCJBgyyWsprT3I2FNR8XiMUV+exTTrjDKNJ1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277995; c=relaxed/simple;
	bh=BuA8Db1xEvLlpkAhBdzTbojqHkzmn5Gte//Y8IFeiRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRFOy/HwZ3hegHxrzzHtdou00aVzyW8JtG4z+ZCHKmZh3/PKwp4KmfN9X341PTuCtfZnGP7l6eUxLR9loO2NT8mI0Ca+BwrqSnwkK0vyNMJa88aicW1/IQPSzPD0oMtncXihseb9hojGLios7AEs8r53i9ivhQJ82TqY826JxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASeSRVaf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cfb79177so365385e9.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750277992; x=1750882792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rjw8fdGTX2nFKEkpBLYbIU9IBE4sqVmKV9cISVjZbCI=;
        b=ASeSRVafvJGqOltKbbHH3fB86FCrDdbCAX8a8Pv6uiepBJ0xH86AMSr7ey76578JJM
         GPvksqw1OgMOCNUqEmzJcgU/uw1ra/jGkOAad2Sm+M08UwaeRXWp2zBSwUK6c1WDSO9+
         QgugUzNRlZf68jRXxZ3idN3lKJJdY45K/QyFj5fAWiiEFZa35HS1X8Yhq1SgLWlLRRtU
         arwWfw7opewQXZJ5H99EwmiaMQqkQr5tDLV+a8OTU8MqPILvpWKjsmm47bJgzkBlqYH3
         fZ4rbbGVNMWZ8euCKAitUkSpwZRrMpj/7BVtkO+E7OH46gWAvP7FT/vNb+xOoIRHam8g
         n2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750277992; x=1750882792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjw8fdGTX2nFKEkpBLYbIU9IBE4sqVmKV9cISVjZbCI=;
        b=Sx427BvobAFBR/vn2XRJuEqdmHnFjj38jDJB1wO/Y0VnyiyIoCppNLATGKTAndPiRf
         GG7QLDkC39HIVBiTiVXurP331ySuuLuR8f7umNrrE0On/uvHz+nXb3E5b/gb62HgWnqy
         wM2fB/YZn3QqaIpqKVxnd4O7Cs1ebT6TPijbFBbqidJxj65Hntkts5f16rWSo4IH82x6
         gnY+VhiOP0JNElPSwZpyZ6/gELmqncNTK8zeNPOMXtmiX7DJmt7Uzr3TejaiNp7NWone
         9FMmSohKN6G7aKAGRVxdam7SX9H7R6BLyTJQ6aBQPsLtZX8gFHsN8z0Uv0f+YZZbm6wN
         oYrA==
X-Gm-Message-State: AOJu0Yz9jwaGROMN6r05bmnBSf2CuzZTPs/5kWzrTFvpzAsK99OwDVqX
	T0oddC6UjhfE8u0ScgS8s+dUR/msRI+rGAbwAF1hf5nA7XQ5kl28s4Yh
X-Gm-Gg: ASbGnctZEAPTCkSC66EWgfA/kvZY5jTz4Wv902KBcY+SoPfzqKAjAGIcltMUopALcjG
	m4rrkD66UG6CZoS5PbJPxh0pnNV7JjZwLs/ooEy4ry68XqvHn5s/ZzOR831XoLzU09ryGGHxyuZ
	uGCMo+V2pSk/m1JCEvUlSqCBsENDee17/AFJo2KScaf0M7PGSNniHa6Imn2Xmm1uU185OHVFZaW
	0MGo7rNCTc9wD+D3gYum/0YDue0hbrCmVMJeYDd+ogHRy/8sMyOsfBGS/AjAAGjCUKzbXCnnmuk
	2MmUl3IXngE3BMYCTWWXsXdfyAlmXDeTJZxBLvSy0cCvf0/vmz9OBQ8q1BeWSZFQBKi6xfAbUQ=
	=
X-Google-Smtp-Source: AGHT+IHJn7MKndoXPtBf2GipNJs1pGUHn5Z3vWvbkQUwdyb15vzgKfdPjU9g6z+ztss+vE6ACefWzg==
X-Received: by 2002:a05:600c:8685:b0:453:483b:6272 with SMTP id 5b1f17b1804b1-453483b6369mr96927195e9.7.1750277991905;
        Wed, 18 Jun 2025 13:19:51 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7cb65sm18027569f8f.38.2025.06.18.13.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:19:51 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:25:34 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect
 jumps
Message-ID: <aFMgvroYZapTkTSj@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-10-a.s.protopopov@gmail.com>
 <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
 <aFLR7NrdX3gbjC1s@mail.gmail.com>
 <CAADnVQ+nHemrEgeWYHxLi1UVeJ2u7DtSDTpcrPR7w2PgFPgQZw@mail.gmail.com>
 <aFLq/blfEEiIqXGz@mail.gmail.com>
 <CAADnVQK7M7L4j8ydo7GOFqZ4rbdJwg_Ghx6uNcD8SqMQnBbZCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK7M7L4j8ydo7GOFqZ4rbdJwg_Ghx6uNcD8SqMQnBbZCQ@mail.gmail.com>

On 25/06/18 09:43AM, Alexei Starovoitov wrote:
> On Wed, Jun 18, 2025 at 9:30 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/06/18 09:01AM, Alexei Starovoitov wrote:
> > > On Wed, Jun 18, 2025 at 7:43 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > On 25/06/17 08:24PM, Alexei Starovoitov wrote:
> > > > > On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > > +SEC("syscall")
> > > > > > +int two_towers(struct simple_ctx *ctx)
> > > > > > +{
> > > > > > +       switch (ctx->x) {
> > > > > >
> > > > >
> > > > > Not sure why you went with switch() statements everywhere.
> > > > > Please add few tests with explicit indirect goto
> > > > > like interpreter does: goto *jumptable[insn->code];
> > > >
> > > > This requires to patch libbpf a bit more, as some meta-info
> > > > accompanying this instruction should be emitted, like LLVM does with
> > > > jump_table_sizes. And this probably should be a different section,
> > > > such that it doesn't conflict with LLVM/GCC. I thought to add this
> > > > later, but will try to add to the next version.
> > >
> > > Hmm. I'm not sure why llvm should handle explicit indirect goto
> > > any different than the one generated from switch.
> > > The generated bpf.o should be the same.
> >
> > For a switch statement LLVM will create a jump table
> > and create the {,.rel}.llvm_jump_table_sizes tables.
> >
> > For a direct goto *, say
> >
> >     static const void *table[] = {
> >             &&l1, &&l2, &&l3, &&l4, &&l5,
> >     };
> >     if (index > ARRAY_SIZE(table))
> >             return 0;
> >     goto *table[index];
> >
> > it will not generate {,.rel}.llvm_jump_table_sizes. I wonder, does
> > LLVM emit the size of `table`? (If no, then some assembly needed to
> > emit it.) In any case it should be easy to add this case, but still
> > it is a bit of coding, thus a bit different case.)
> 
> It's controlled by -emit-jump-table-sizes-section flag.
> I haven't looked at pending llvm/bpf diff, but it should be possible
> to standardize. Emit it for both or for none.
> My preference would be for _none_.
> 
> Not sure why you made libbpf rely on that section name.
> Relocations against text can be in other rodata sections.
> Normal behavior for x86 and other backends.

So, those sections are just an easier way to find jump table sizes.
The other way is as was described by Yonghong in [1] (parse
.rel.rodata, follow each symbol to its section, find offset, then
find each gotox instruction, map it to a load, then one can find that
the load is from a jump table, etc.). Just to be sure, is the latter by
your opinion the better way (because it doesn't depend on emitting
tables?)?

Those tables are _not_ generated for the code I've listed above.
However, in this case I can get the size of the table directly from
the symtab.

  [1] https://github.com/llvm/llvm-project/pull/133856#issuecomment-2769970882

