Return-Path: <bpf+bounces-21452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A184D6C0
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB6C1F2336D
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A520692E4;
	Wed,  7 Feb 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOF5j365"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71135535D7
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349394; cv=none; b=rLA39j0JEB4FCY6QBCIS7c107zSh/n/Io671+LcGuO/8HOtL8aTkFuynIDVoJSbdmtiatbWeA1WyiEj1wG2TU6L3rqOJPnCr4LEy0Xm0bx0mYgccUE09JTAIHVl0fHkN6CbvzxjhRzpc+10O/H9iRl08BVbwcX02D3Lebe7/zCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349394; c=relaxed/simple;
	bh=BtpXwjLT/BOSjvx9eYo1JGnR32arO4v5mWkPVlTMx8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeGSAnYh3J2LB0L2GJDhXHFHVA12eMHdE6O9VEXKBjt5uZEymD9bS8u/jNf1VJ3edPcnEDbcccrnNXaEry+pG9Sas7A/eVXJBMXyoW0e3LjH7OVCBzCRmPJ2em7haoCfkYR2IVpB/b2mUe9PvWI7xM7no9Lnv1UcxG3of/qMuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOF5j365; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3392b12dd21so805590f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 15:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707349391; x=1707954191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Scllvs6f1zTQW8kpli9koI4OYoj8W192QFTfrrhao=;
        b=UOF5j365EaaPBxjNo5sj0sQdp+gWJs7JXOm7AbmrQwv/xo49EgzwXm8udOSyIo59wv
         1PQwRnqQ5qCnSjXHCeCfuicFtTF0uGocQUExqI8nHg2JfdWiDeW1QM20ZZQZvGsUbuwZ
         jUWwRKuv9/tJdqrmAIqmd4rIjGLjQQd8YNFTCTaKvD0R4Z8L+Ffv6TmSInFjMnehM3up
         XLy362610uDgiMcJ7IjohAWDXghv10l1AH2mQATBa+ZTh8bO/yGNqXCd7UzLSK+PpjrG
         w2iGC94QQl+QlCUzYX65l7P0IT/RFR9/IdBT3u3teTabbJHqZtwONqsdjO+0FHxd6tH3
         C0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707349391; x=1707954191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2Scllvs6f1zTQW8kpli9koI4OYoj8W192QFTfrrhao=;
        b=mGZgeDCWS+61TF/dbygQXkAE51amex5AYKsNGy2dmUyPgkerisLaRBfeCHewQsIJE1
         jdVwMKuLZ1MMkGLOKy+QIPreQhln6xUFcja+UMx6WwVpqzuQHkCSbTP+1LAVudXuHBJ0
         RiXbzXhfCs/GKkCE4FioAETKzq9q32mAUyzM2QTNzkmxqk11EKaOwwlcft9vNJ7ala+E
         YE58CyjEonVZn9OzTM54bOPao51kbfB/Oc8bFt/zaor0ALPAJFaZ11vIBfVamabbGPcX
         ccXf5R2NnrN60y7buPLxo/QcA4rk5PyFCH5gDvOXfYthUwUg5uNLe9w2jLkchb1hryBb
         gd3A==
X-Gm-Message-State: AOJu0YzC69Cbe0gWv7cZJiyNvLhWjv81dtBFt8QJcI3iMSaGUUiYqAZo
	HDYWN+oIR+2amPGtL+1/xXkl6CHy+sjXLMRpPsbx6V7/D0dpWda8IvR6BtESzxi4r8AKBsfE0Yf
	m5V/t+b0P3/A+BhQRSsVCsIPOUkFhrDse
X-Google-Smtp-Source: AGHT+IFyonh2XQ6XAoVnFLbKGZMCTebHtcCJvC2MAwznJ63WdehuhfSFcfghTBs6iXBWz256TyRJ6cx3r7Eav15i84Q=
X-Received: by 2002:a5d:618a:0:b0:33b:5359:85c6 with SMTP id
 j10-20020a5d618a000000b0033b535985c6mr1030116wru.18.1707349390076; Wed, 07
 Feb 2024 15:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <134701da5a0e$2c80c710$85825530$@gmail.com>
In-Reply-To: <134701da5a0e$2c80c710$85825530$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 15:42:58 -0800
Message-ID: <CAADnVQ+sF2Zq0S+2XaVfu=tuWY0d-MecnExwdxj-pm+2JjpO2Q@mail.gmail.com>
Subject: Re: [Bpf] ISA document title question
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:39=E2=80=AFPM
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> The Internet Draft filename is draft-ietf-bpf-isa-XX, and the charter has=
:
> > [PS] the BPF instruction set architecture (ISA) that defines the
> > instructions and low-level virtual machine for BPF programs,
>
> That is, "instruction set architecture (ISA)", but the document itself ha=
s:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BPF Instruction Set Specification, v1.0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This document specifies version 1.0 of the BPF instruction set.
>
> Notably, no "architecture (ISA)".   Also, we now have a mechanism
> to extend it with conformance groups over time, so "v1.0" seems
> less relevant and perhaps not important given there's only one
> version being standardized at present.
>
> What do folks think about changing the doc to say:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BPF Instruction Set Architecture
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This document specifies the BPF instruction set architecture (ISA).
> ?

Good idea. Makes sense to me.

