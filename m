Return-Path: <bpf+bounces-19229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2E827A6F
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 22:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD131F23B9D
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63756463;
	Mon,  8 Jan 2024 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0llUDhf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CB5644F
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3374e332124so2146629f8f.2
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 13:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704750692; x=1705355492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFjJvsEhqXup3j2qGLKp11lpSR0rG1msW9Lv0vUhXdE=;
        b=Y0llUDhfZ/ilcp5asPJAXoq9umev3PHyimNP+eks02aOslDarODSxcuWmADxCVIDaU
         pxffwplYIHhsqvfJz0ntgKccmuPvWZH6r00Q1Oz9Y+PC9aF0HptJ+ZcP1r9Y0SVn18Ln
         sZDUha0RS6GcE5D1uDVMwwXnGv1GXNOCHHDyTMGMSYdtHCRYjHpfUQHriwULCg8MSXLV
         vqdXBNWdHSYtpvCpuow+/p2sm83Iby5cEU5/Xno1igqGXsOwAeHs3FL52QgDC2seHoQW
         Pc/Do+7pkN/69FuewAEKLotV8FFtQPoR03j1BIISoznRPPgGL2ll7khYqAKN4u8F3iSC
         6YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704750692; x=1705355492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFjJvsEhqXup3j2qGLKp11lpSR0rG1msW9Lv0vUhXdE=;
        b=VdEYORArS7BVVEk0jmZopK55mXJHyHA8PxupG6AmWYAAZKnUfkUBbJUqZAUCut/Lee
         +rGIBGPBWKjDjF7R5eEHoifAjgxlLTOf4npHQn8zmcsKiJfQL5BD0ggq8vjXnGN4MZYC
         4J1lh3k7jdnbbq3ubRi5Tg7+KKUyybqQkI90cnVPtO/12G061m+3ksXq1e7i/HVkopk4
         PSO5yk2BmqI/pJR5VsBjVDSDG35y9lo0YvWP7CQl6R36z+24cWMKG44TpH76il3gZEoe
         VDCSphHS4wA4e8wL9Pbxtwch8NCAbGl9eLyrpjbLaCipUEd4mDLYq+Jap0JDumYYZ8t/
         LDuw==
X-Gm-Message-State: AOJu0Yy9p7HRNAuuFYbv29KTSeVn6VDrUcOFSe7CwFPINi9i9t+U2fGV
	IPY1W+ORr45oOZy39GzO2gK+GFDq5JimumbOfyw=
X-Google-Smtp-Source: AGHT+IGhzGzUQ3Fdqtiy5uPad4IAAQOBq0FCjLFVDQ2XzhO2DD4gChQhZ3xPSafIL4/5BKirDULPz62FAa3skByD0/Q=
X-Received: by 2002:a5d:598e:0:b0:337:5a1b:8212 with SMTP id
 n14-20020a5d598e000000b003375a1b8212mr46493wri.109.1704750692126; Mon, 08 Jan
 2024 13:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge> <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com> <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org> <20240105220711.GA1001999@maniforge> <ZZwcC7nZiZ+OV1ST@infradead.org>
In-Reply-To: <ZZwcC7nZiZ+OV1ST@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jan 2024 13:51:21 -0800
Message-ID: <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: Christoph Hellwig <hch@infradead.org>
Cc: David Vernet <void@manifault.com>, Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org, 
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 8:00=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Jan 05, 2024 at 04:07:11PM -0600, David Vernet wrote:
> >
> > So how do we want to move forward here? It sounds like we're leaning
> > toward's Alexei's proposal of having:
> >
> > - Base Integer Instruction Set, 32-bit
> > - Base Integer Instruction Set, 64-bit
> > - Integer Multiplication and Division
> > - Atomic Instructions
>
> As in the 64-bit integer set would be an add-on to the first one which
> is the core set?  In that case that's fine with me, but the above
> wording is a bit suboptimal.

yes.
Here is how I was thinking about the grouping:
32-bit set: all 32-bit instructions those with BPF_ALU and BPF_JMP32
and load/store.

64-bit set: above plus BPF_ALU64 and BPF_JMP.

The idea is to allow for clean 32-bit HW offloads.
We can introduce a compiler flag that will only use such instructions
and will error when 64-bit math is needed.
Details need to be thought through, of course.
Right now I'm not sure whether we need to reduce sizeof(void*) to 4
in such a case or normal 8 will still work, but from ISA perspective
everything is ready. 32-bit subregisters fit well.
The compiler work plus additional verifier smartness is needed,
but the end result should be very nice.
Offload of bpf programs into 32-bit embedded devices will be possible.

> > And then either having 3 separate groups for the calls, or putting all =
3
> > in the basic group? I'd lean towards the latter given that we're
> > decoupling ISA compliance from the verifier, but don't feel strongly
> > either way.
>
> What would be the three different groups for the calls?  I think just
> having the call instruction in the base group should be fine.  We'll
> need to put in some wording that having support for any kind of call
> depends on the program type.

+1

