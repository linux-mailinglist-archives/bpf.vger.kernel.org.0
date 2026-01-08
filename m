Return-Path: <bpf+bounces-78171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4729DD008B3
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 02:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E9F73010A99
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90947207A20;
	Thu,  8 Jan 2026 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCLEGQO2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF72D7BF
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767835161; cv=none; b=u0TerkDw9RI/eR+oAmwVLpxkCGio6L79d+iHV+paY2suHdJQnek+27nnxGP0qOSQLHRJ4ZnbRiEhpK0XkIyIhxwI03uWuJ8cQ2aTWnxh1HXJdwNlHoLIZLDCwJKQqlULVOM3uYJrEn58Gh+GpURSBNaY+kRONV3sOMG0UVZXCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767835161; c=relaxed/simple;
	bh=ubn07qUCp4gZnGzRXzEA00EmbSDMP7KQ+ey8SpZjOlo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZgK9bXGBXtcIgaHGE+xGiJdS3f0kRwtZ4JzQ7GiWuvLZUy7G86Z+PVstJ1NNNnyx+AhV4zPEm48/NX1AATr1P69/UyhSPZuvWsLO1nMXCSsqzedYYocLPRUs7+LrlSBJJb5O9jWuqrkb/6mxELq39vH7rGrvjLn9QvuGrk7uXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCLEGQO2; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae24015dc0so774461eec.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 17:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767835159; x=1768439959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9wRJXt/JDvzlXXpA9snt7HQtx6JEFL0RbH6bObWWj5M=;
        b=eCLEGQO28JjEqWjn48cNil1i0WClHI8ZfymZH2yghSFjje4RavTu4yggJlFR6yybiY
         tZTYIRD/DdKFwkvsBCqgwsvno9w8mkjTJao116hhJtTe2ugAa86KnpErG0Zr7x8cdi7e
         a0MmpewIVYUmMDBlobTW3/ijUDwqkCiu6DFJCVwrd9KraRtcRJaHyPQuDjWhteBi9Bhk
         b6DKAmVJJNIsNdpkkJtSWbToFZL2atkP8WX+873SluUOnEv1g3aRfc7qnlFLU2i1eTWU
         fCmKAF9DfyxjYwtJi/mDuoMFxDeae+nmQIlumETwyw30c2gP9Fh7fI/rzyaj4sy/fsUi
         FfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767835159; x=1768439959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wRJXt/JDvzlXXpA9snt7HQtx6JEFL0RbH6bObWWj5M=;
        b=T8UdG2NZcuOp8dm+p/OHopvU8pwWPuMoDSyjz71lB8cmD38h7Wv+jHPtmHlFOwOXbh
         aAuOXbXutL/4WWw18JpbwsRjyIm/mBtplcwt8IbeJ0agHVpd4lQ39XSAXqUgqGm4QLv+
         XkQfWqC+BIk9MMEVFsARrnRUHIBHP3znHz2opPs50ocB6bk0v+ljhPD1C43MruJCqssS
         mzIDtShsRz32PUpsowoF3WkRxk02dSD3EIr6cXvu1IPpLxwG98VJltuIVjQphSyTXVuw
         j/2RiT5vJtvZm2uN3RR1mbZ1ERCUnmnoNIwZVXq0CwU84rDqFQ7PHEomSi+7WJdFgo28
         tubQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYQdHRRL4FIy649ucTnkDY1Jo1n/TgVIlfbOf6fGQjXYZbKYx/ZwiGdEZzJxBnWFRF2X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBLSZb42tnzuVcviGJIQxzNvGNUKf2anGvyqxMM5nsMOSoR6T
	v4Tlgmyg1gNTGUbFZWkDmitY+ezhp/WXPRFubmnSIoVzgbMNofYcuFji
X-Gm-Gg: AY/fxX5v7Y5QtLtn76jz2tUJg4u8k92yAA7t5N2YY7XX9+iX4N0sEliYldi+wOsljgt
	A3lhm7wrZC7So1k1gu2lFzwWJ59idQgCImHZX16q5k9v/XU8owysGcMWtgfiBJEUzGCpgEAWIrx
	t6sLCkNDdsBbKRl2VOe0mfxkNu4+5yO1/KbltAfcP22Qs5CduAwfReh7VrbPeR6645GH10jgnc2
	ruBo4GcwNmZMMPtcXIBLmuQcZEQuFNSRIZA1yFpQ5ccPYXwnDDDkr4gCwLVEsn6DnLgpG5TMgQd
	ommfkcwJ40yAI0kosvXMmtK7PFxYSK9z8a1+873lHcDNew2kl39gMj1mzk3XV+Lxo+LGCJsqopp
	Xl+F+658wXkSEdtr3K4GqYz4TOUf4yOBKovEsVPoZBUZY8uinZmkyXTAXPdIoMqhWr2kWOq2LRq
	96CrYfPTn7SPxyXC7h+9yGR+ZLdAOOXMfHDl8Q
X-Google-Smtp-Source: AGHT+IGlHMAmEtfmS1sm9Tdzrpf0/GKomM4XoDRTCFo8CdjbAp0YovBrs2C8XqJYUGSC5Wpv27SIXA==
X-Received: by 2002:a05:7300:cac5:b0:2ac:2f90:8e03 with SMTP id 5a478bee46e88-2b16fd9d9a8mr5793871eec.7.1767835158765;
        Wed, 07 Jan 2026 17:19:18 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6741:9f57:1ccc:45f2? ([2620:10d:c090:500::2:4706])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm8156387eec.2.2026.01.07.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:19:18 -0800 (PST)
Message-ID: <fc3540e401ee26b8a05da0914ff664f2c81e5884.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
 Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, Kernel Team	 <kernel-team@meta.com>, Hao Sun
 <sunhao.th@gmail.com>
Date: Wed, 07 Jan 2026 17:19:15 -0800
In-Reply-To: <CAADnVQJitkFOZO3dmdZWuzfYgixqi_=P3qZZBoLPR9KxWiph_A@mail.gmail.com>
References: <20260103022310.935686-1-puranjay@kernel.org>
	 <20260103022310.935686-2-puranjay@kernel.org>
	 <39509bf2976a9812e89e5d1259fcaf1692b97fe3.camel@gmail.com>
	 <CAADnVQJitkFOZO3dmdZWuzfYgixqi_=P3qZZBoLPR9KxWiph_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 17:07 -0800, Alexei Starovoitov wrote:
> On Wed, Jan 7, 2026 at 5:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > > +
> > > +     if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D=
 0)
> > > +             alu32 =3D false;
> > > +     else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_v=
alue =3D=3D 0)
> > > +             alu32 =3D true;
> > > +     else
> >=20
> > If we rely on specific dst_reg range, do we need to mark it as precise?
>=20
> I don't think so. We're not relying on the specific range.
> Just like plain AND&5 would convert [0,10] range into 5.
> It won't be marking it precise until there is a need to treat it as preci=
se
> somewhere down the verification path.

Hm, makes sense, thank you for explaining.
In that case, lgtm.

