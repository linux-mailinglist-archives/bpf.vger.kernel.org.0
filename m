Return-Path: <bpf+bounces-20142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D77839D32
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7561C24736
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8A054669;
	Tue, 23 Jan 2024 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ai2X0rCl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7253E19
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052586; cv=none; b=KzPrDHDiyQRIXjSs0Lmlz2w4oB2f1qveuedl9xaQu5uZeBVINiPFwpea5fvvKOLZaA7EE+dPtav+COBMmFL2Gutd8gzLI6osQg8TZBKuKKrLIlo4bpZDgHgd7EGQ0PUJFzzrrIo/woJlSSiyeqf+1opb35YlnxsNWDDZpdbjKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052586; c=relaxed/simple;
	bh=nV0JiYpVt2Qdrm6m9BfivzkMbxM8shwReWuIgOB6vhE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSkZufChrbt3LAfqvzYSmvquBs3Ks0CZu4dWLwA+hppjhPk/FonEqw5bn8NQKvFovyJI2mlACD3jHWNvEPPpaNi8BQBcKgPZa2z9S3xedla/klcSzN/P2fL2dUhtoUOkaflo3EFLYh4bMXRwSDGtssgEr0IL22g5e4DlVnW2n6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ai2X0rCl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29026523507so3718886a91.0
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 15:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706052585; x=1706657385; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxp7csI7GVkKVo3iyFT9bVz+XlkrKNjW2GUNPvl/QNw=;
        b=Ai2X0rClPHv66BL69uBxID9JFqfwcKZrToKrdZbqa82PbtVQighVOlRo4bOkEFzVmS
         KdCBxNs8I/YAYX5q5p9K7QO9KTUfRegfroHRn29Q9pQ4UYbbnsIHiigQdfQ+Iz8IoLE3
         Sf18t/Q5z8/x+n7Cbqe5CX8PrmfmNHJgngJTakEgj1Nj7pIxRKj8LmK596oqmF8zu3l/
         C5nVNvxtpqXfLDtooiwn9An5fDvDxRFEuyLThJmEW1WXGbJ31aAf7CJMZSYkzmNK4vHm
         zv+IbBYZLOyhwdw/kE8/Nkk/eLzdOOPj/wFDzl8fAu49YEaOAHFwZ0g8odxUrIH1JgSc
         +d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052585; x=1706657385;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxp7csI7GVkKVo3iyFT9bVz+XlkrKNjW2GUNPvl/QNw=;
        b=M1vwcUnhW0UnMP91mpa/T2w4c8Hqo5Qeq7msHMbPYouHoImNEmEwAIxbVa4PapwuyI
         wPtZYt3D0nvePSi+SeYzy8HAcpK3J+y9DPGjKoA32WBuNWrvu82EQoFAg7ctmn4/x92r
         k5vmlfsb2S8/bDfQ8KtQVR6MZDA/Yfjut6fQHBhnfnJuy5FZBp+pj9+3t43+RfGjtgFl
         vG5kIJCnPpX0ZpstoGzXO4DQ1mSkfXdOdwgqMWeyuIGKNC64xdDsr04yjXJOamAWgjwA
         xAWbIDc91I96XsVniwBPjz0+HFRxJiIo/CLqvIL04rQs6LbuESugW/Lw9fuwYXOSQk3n
         HKPg==
X-Gm-Message-State: AOJu0YwaxYBNK5v2cuNzXQiCzI600fJ6QfNxtJ0t0o9WMBCOXSzbEvOM
	Nf3liAel0ohoct4aysfLS66gUA3YBuAdtZm3A9jL1Gp3UWd8jng6
X-Google-Smtp-Source: AGHT+IEGvt/yImDo8Ob1k0Z4lY994xLw3f+pk6Sv7zqAkcyFvFUUx3Hd7wrrrOUxBx08cxEdejrjvQ==
X-Received: by 2002:a17:90a:f614:b0:290:6c4:ad45 with SMTP id bw20-20020a17090af61400b0029006c4ad45mr3688918pjb.39.1706052584666;
        Tue, 23 Jan 2024 15:29:44 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id nc15-20020a17090b37cf00b0028feef1f7adsm12227727pjb.50.2024.01.23.15.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 15:29:44 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	"'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'Christoph Hellwig'" <hch@infradead.org>,
	<bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<david.faust@oracle.com>
References: <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org> <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com> <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com> <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com> <ZYPiq6ijLaMl/QD8@infradead.org> <20240105220711.GA1001999@maniforge> <ZZwcC7nZiZ+OV1ST@infradead.org> <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com> <874jfm68ok.fsf@oracle.com> <20240123213948.GA221862@maniforge>
In-Reply-To: <20240123213948.GA221862@maniforge>
Subject: RE: [Bpf] BPF ISA conformance groups
Date: Tue, 23 Jan 2024 15:29:41 -0800
Message-ID: <1f8301da4e54$0b0ad690$212083b0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQClir6lI1sScEFfIiSZU+wYPRcfRwJboihlAe8iqfAB/zVPlgJHtDdIAuBp+8cCBQmzlAH9CezDAX+HGP0B/YYFwQJ+11wssqYPW3A=
Content-Language: en-us

> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Tuesday, January 23, 2024 1:40 PM
> To: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; Christoph =
Hellwig
> <hch@infradead.org>; Dave Thaler <dthaler1968@googlemail.com>;
> bpf@ietf.org; bpf <bpf@vger.kernel.org>; Jakub Kicinski =
<kuba@kernel.org>;
> david.faust@oracle.com
> Subject: Re: [Bpf] BPF ISA conformance groups
>=20
> On Tue, Jan 09, 2024 at 12:35:39PM +0100, Jose E. Marchesi wrote:
> >
> > > On Mon, Jan 8, 2024 at 8:00=E2=80=AFAM Christoph Hellwig =
<hch@infradead.org>
> wrote:
> > >>
> > >> On Fri, Jan 05, 2024 at 04:07:11PM -0600, David Vernet wrote:
> > >> >
> > >> > So how do we want to move forward here? It sounds like we're
> > >> > leaning toward's Alexei's proposal of having:
> > >> >
> > >> > - Base Integer Instruction Set, 32-bit
> > >> > - Base Integer Instruction Set, 64-bit
> > >> > - Integer Multiplication and Division
> > >> > - Atomic Instructions
> > >>
> > >> As in the 64-bit integer set would be an add-on to the first one
> > >> which is the core set?  In that case that's fine with me, but the
> > >> above wording is a bit suboptimal.
> > >
> > > yes.
> > > Here is how I was thinking about the grouping:
> > > 32-bit set: all 32-bit instructions those with BPF_ALU and =
BPF_JMP32
> > > and load/store.
> > >
> > > 64-bit set: above plus BPF_ALU64 and BPF_JMP.
> > >
> > > The idea is to allow for clean 32-bit HW offloads.
> > > We can introduce a compiler flag that will only use such
> > > instructions and will error when 64-bit math is needed.
> > > Details need to be thought through, of course.
> > > Right now I'm not sure whether we need to reduce sizeof(void*) to =
4
> > > in such a case or normal 8 will still work, but from ISA =
perspective
> > > everything is ready. 32-bit subregisters fit well.
> > > The compiler work plus additional verifier smartness is needed, =
but
> > > the end result should be very nice.
> > > Offload of bpf programs into 32-bit embedded devices will be =
possible.
> >
> > This is very interesting.
> this is necessarily something we need to figure out now. Hopefully =
this is all
> stuff we can iron out once we start to really sink our teeth into the =
ABI doc.

"Integer Multiplication and Division" in this thread doesn't seem to =
separate
between 32-bit vs 64-bit.  Is the proposal that multiplication/division =
is ok
to require 64-bit operations?  I had expected one rationale for the =
32bit
multiplication/division instructions is to accommodate 32-bit-only
implementations.   So should we have separate groups for 32-bit vs
64-bit for the multiplication/division instructions?

Similar question goes for the atomic instructions, i.e., should we
have separate conformance groups for 32-bit vs 64-bit atomics?=20

Dave


