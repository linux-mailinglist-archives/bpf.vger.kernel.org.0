Return-Path: <bpf+bounces-61031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4DADFCA0
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 07:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CE4178350
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E323F422;
	Thu, 19 Jun 2025 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ2AWCUk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885E23BCFD
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309211; cv=none; b=i5EQ+KKjNK5HAa+oZ8MeglYX3k8gvsasN5FPVhnnKt6pt/RS+GwD3NLgaBrm4B0BQZ5pVc4+d4H6dtlh92r6Hy+IIvY6sKxkjYEhkh32sT9Zj3UEMWvF0TpvJkCtbEVT75/kiwrbnk4JTfcOMal6CPALQlj8NZjhO9cySG+hvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309211; c=relaxed/simple;
	bh=vZTBEljybxBOpRT2d7fRkZZnGm3Lxb9/NK8AmGM3vO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDPHaOUaGZPbde99VeQdKd3SSgaiCgL1z5Lpv5zbSn3NnA3xapWRpjrSTHQjCNXEogeoqYDsME5ru1N6CGW9fJFRzOJZl6SaNsuYGnjQes6PCrlhH9zWwnh+Skky3M/RQSkhcduRuNOYhyYXShXQc1r57nWBT8GGw8O1w9R9fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ2AWCUk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so164063f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750309209; x=1750914009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ew9/htbS6qmeB44DjbHqof926Esy74N9I8ePNQuIac=;
        b=cZ2AWCUkOWlImiqK8JOOnfwo/Usj+L0AU4LiCDV5yqx1NxPSGjbQUC/kymwYf+i2pe
         47o0qrsCn0dSdRGlvy2tzApf/uMPZej2VxaBYdw6V014A1QYE6ShISKlpLDJHr32kz6h
         TYkQpH/JqqydQG1EUAghT7AZ40byr9/aWR3MY5nct2RVGhvFZEALKdujINzeohqc+fRO
         g3DFrnsQnu5xVzofuJ7LoRDw4pTn/aQggDqc5cs/rdXI1i4RnZdjZDaWq1o1jVs1Ap4+
         cJQM5+Kpw9uK4Ls4Pg0wdrwQZNFtXCyagoR8AWsAnGtMaAO4un3Iqs3mTNtFgiUfQLlH
         Wc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750309209; x=1750914009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ew9/htbS6qmeB44DjbHqof926Esy74N9I8ePNQuIac=;
        b=TQm5JFbUg+eb8Yq7sAmAfthPiAaqtTU7YmyKQKikDKUnTxKu0Bvh+BMy2c12ObI280
         16T/ERZ3FqesPyck+NHsG54J7TZnNXevRT/XfLO2+VtsXRfMWZtXRrDJxR/nrKx+bYyi
         A01jW6OHiHHDIWdViVQUG6KDYjPoFjHHz4tLxGag4wyl7w1QUHwFT9Mx0t7FZWIEUpYx
         IHWx5aFUYOHDKdsVFOUSoljTSQ2apvA53YM/orcj53ZKq3z9x87Q8kECLsuye2AQhy/k
         yzpSUHiXjAthlvGKBnizrTWlpdcF9uQ8Q8+Z2w1fpHq/+F31ACqdULJzAfIY59FJHtSF
         JYEw==
X-Gm-Message-State: AOJu0Yx0PJy1OU630H7GkFsxtnMFtimeXbMuSPhDMBAxAisNj6Qvf0dx
	hFrfz8/CPpHbpUbzhPoMJ1BznW0aEv8xyvBLhQR7XMY1Sg7ktzlVl/vnDLb+/g==
X-Gm-Gg: ASbGncs7peWMq9OoJ6h60M3XSecUZA2uiLIh8LSsA0HjSwNZ4Zlj+L+CxlqIXCSBG4k
	dcvRgajJioMeYwj8O0483qm6bWdm4eQ3AM8xv6MVih/UbtPBbQ8zbJv3Qv61El27+9WovUFdoEs
	YJCZDMGNjpD8ouqJEELgjxaSev7hiwHJTnhz2XAFS7ZcOqrO7j5SN7+EwbGJLQqcdCEzbVGehut
	jOHKvnmAFJq4DEP05OqTDW2DKLtIBkXg/wLKbIghQ8zYv+9Xb9NDF5YLlnxpLXP/7He76EGahYv
	NkthaUT6/xSBs+xDo33p2MlakEzWh06mP1IaiFLX1rjlI8fMZ6MsQnO+H3WG9dCzr700tAvx5A=
	=
X-Google-Smtp-Source: AGHT+IEG/WB/594f88Tt7Ru0tF5mRaJuJm1llrvP1SYB+9V697eWcRdYX7qi8iDlz9KPlTYkIEgz+Q==
X-Received: by 2002:a05:6000:2a10:b0:3a5:7c5a:8c43 with SMTP id ffacd0b85a97d-3a6c96c312fmr989512f8f.11.1750309208392;
        Wed, 18 Jun 2025 22:00:08 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a578f3ba84sm14542401f8f.65.2025.06.18.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:00:07 -0700 (PDT)
Date: Thu, 19 Jun 2025 05:05:50 +0000
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
Message-ID: <aFOarjmIt7PlOx0c@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-10-a.s.protopopov@gmail.com>
 <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
 <aFLR7NrdX3gbjC1s@mail.gmail.com>
 <CAADnVQ+nHemrEgeWYHxLi1UVeJ2u7DtSDTpcrPR7w2PgFPgQZw@mail.gmail.com>
 <aFLq/blfEEiIqXGz@mail.gmail.com>
 <CAADnVQK7M7L4j8ydo7GOFqZ4rbdJwg_Ghx6uNcD8SqMQnBbZCQ@mail.gmail.com>
 <aFMgvroYZapTkTSj@mail.gmail.com>
 <CAADnVQ+H-OMe0rUGr63SEJpYT4MVv=j9=5hcDBShfCNKSHf+mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+H-OMe0rUGr63SEJpYT4MVv=j9=5hcDBShfCNKSHf+mQ@mail.gmail.com>

On 25/06/18 02:59PM, Alexei Starovoitov wrote:
> On Wed, Jun 18, 2025 at 1:19 PM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/06/18 09:43AM, Alexei Starovoitov wrote:
> > > On Wed, Jun 18, 2025 at 9:30 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > On 25/06/18 09:01AM, Alexei Starovoitov wrote:
> > > > > On Wed, Jun 18, 2025 at 7:43 AM Anton Protopopov
> > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > >
> > > > > > On 25/06/17 08:24PM, Alexei Starovoitov wrote:
> > > > > > > On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> > > > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > > > > +SEC("syscall")
> > > > > > > > +int two_towers(struct simple_ctx *ctx)
> > > > > > > > +{
> > > > > > > > +       switch (ctx->x) {
> > > > > > > >
> > > > > > >
> > > > > > > Not sure why you went with switch() statements everywhere.
> > > > > > > Please add few tests with explicit indirect goto
> > > > > > > like interpreter does: goto *jumptable[insn->code];
> > > > > >
> > > > > > This requires to patch libbpf a bit more, as some meta-info
> > > > > > accompanying this instruction should be emitted, like LLVM does with
> > > > > > jump_table_sizes. And this probably should be a different section,
> > > > > > such that it doesn't conflict with LLVM/GCC. I thought to add this
> > > > > > later, but will try to add to the next version.
> > > > >
> > > > > Hmm. I'm not sure why llvm should handle explicit indirect goto
> > > > > any different than the one generated from switch.
> > > > > The generated bpf.o should be the same.
> > > >
> > > > For a switch statement LLVM will create a jump table
> > > > and create the {,.rel}.llvm_jump_table_sizes tables.
> > > >
> > > > For a direct goto *, say
> > > >
> > > >     static const void *table[] = {
> > > >             &&l1, &&l2, &&l3, &&l4, &&l5,
> > > >     };
> > > >     if (index > ARRAY_SIZE(table))
> > > >             return 0;
> > > >     goto *table[index];
> > > >
> > > > it will not generate {,.rel}.llvm_jump_table_sizes. I wonder, does
> > > > LLVM emit the size of `table`? (If no, then some assembly needed to
> > > > emit it.) In any case it should be easy to add this case, but still
> > > > it is a bit of coding, thus a bit different case.)
> > >
> > > It's controlled by -emit-jump-table-sizes-section flag.
> > > I haven't looked at pending llvm/bpf diff, but it should be possible
> > > to standardize. Emit it for both or for none.
> > > My preference would be for _none_.
> > >
> > > Not sure why you made libbpf rely on that section name.
> > > Relocations against text can be in other rodata sections.
> > > Normal behavior for x86 and other backends.
> >
> > So, those sections are just an easier way to find jump table sizes.
> > The other way is as was described by Yonghong in [1] (parse
> > .rel.rodata, follow each symbol to its section, find offset, then
> > find each gotox instruction, map it to a load, then one can find that
> > the load is from a jump table, etc.). Just to be sure, is the latter by
> > your opinion the better way (because it doesn't depend on emitting
> > tables?)?
> >
> > Those tables are _not_ generated for the code I've listed above.
> > However, in this case I can get the size of the table directly from
> > the symtab.
> 
> Since Yonghong's diff did:
> bool BPFAsmPrinter::doInitialization(Module &M) {
> 
> EmitJumpTableSizesSection = true;
> 
> and llvm did not emit jump table for explicit 'goto *table[index]'
> I suspect it will be hard to fix.
> Meaning libbpf cannot rely on a special section name.
> So it makes sense not to force this mode in llvm
> (especially since no other backend does it) and do generic
> detection in libbpf. It will work for both explicit gotox and
> switch generated at the end.

Ok, got it, thanks for the explanation.

