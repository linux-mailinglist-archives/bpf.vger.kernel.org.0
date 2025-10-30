Return-Path: <bpf+bounces-72950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189DC1DE7A
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00164E5582
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4791D6193;
	Thu, 30 Oct 2025 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlF5m9Fn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CA33987
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783990; cv=none; b=SOh8XdCAK+e/vnmjQ0VCMJlh/zePxBJnpYxnOe5RGzVGy8fknoS5LcmZFH7pUbvNx8cyt2c9VUMNVnBvhMEuMrs/OdGXptpTB7GeCnh/ZlFG5fH9rzNUq8pHDEYq458cDzf7+P+AdGowveET4vm5tuPu9hDjZ467FApJ0Bt2Z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783990; c=relaxed/simple;
	bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dw81g/bs3CYVsEsbkAWsFi2i0uQy9YXF/mrB7Ywb54bHafHkL3kIgrn5s9MQU2OzbrOrrgvtL5ZN1SrwdxPbWOOpHaONyu+znK/eDbCFxCJIxucMaYDHXkm6AzRIvgjPAGwFyVftaqGs880Zcl5PwktoDDV7KOYbWlnHxKw2RGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlF5m9Fn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso344425f8f.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783987; x=1762388787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
        b=JlF5m9FnkbbVGp8Cz3NpbfW2l4rqF5UkP1hf9/jq504lzHJTGac9E+bakybWEXQvIB
         Gl9dDe1BbZjBIrR7io6i82v+UDiY/v5PPECg2Qs3kukLcvTvXweRDUFmKjoX/e5O6SAx
         FL53ny1ejERTGMsm4zaDi7oyj0qoPCr7EFI6BwsJ+0h0/J4k7ZoFKmPAwwWIiU3wbNpo
         LmmwgZIObb5pyXKDqJFD3SmPa+MzF61Uy9eDdhNbHodnAzzfxrQ86hnr6b/st5BwR+DO
         3uDbP5aSQSb/hu+mJiPzO3nNUDBsbfqun4JurAIF8eAIasRKEMwgNaCBbbjIU7YcAHcD
         2noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783987; x=1762388787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
        b=hT64hs3zAsD4R11083JIz5IoitjFWzwY2qDA3BrJHEkhw8GlWT4+vSDOK7g+danFoB
         /93jG+X5GeAoV1sllKSN50gSCt61ajqmZkB3b6ApVuyE1D7lU3qN2y7tPolP1cMlBq0J
         DhiNluBvqGUi7Yuf02U4WkzQ8XwMf+OXXHfiw0b0f8I9wPnm2IP6RISUIhU1w9HvVnw6
         Nm4zC0HbQx5knKe7r6SPFtbEc0e8W5FcDSx2TTOqa/cjFafTx+yhw8s2m6s4yhVka45r
         ERX/DdaAVjTEGoVljIaFiIBD6iRX2/RYSzbyK7zZXrLjPcVwSSVwqQS27xZlo4oqkHfM
         mbmg==
X-Forwarded-Encrypted: i=1; AJvYcCV2FHWr0BhmYZ7rJ8J1CF8fgYQB51wjQDmcOHSicwfAdyhHSjRdJAFADlCx3qewFVVtVfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTf4KcPgXyFAU5RWnMiX8SgCTMCDzcBSgw0DOiE38mxJkf6Vh6
	RpJ2PKtk1lemXr6qLv5BBbY7NkJakNHlcbZCCQorfOFIOu0EXs8FUEuFumshfQ7JIGr57bMWTjX
	k/WRBYdmYkvoIdxd7iwR+Nbh3SSIl5Yk=
X-Gm-Gg: ASbGncueqKR+Dv9nw4iEolZyf4X5kNfSuXtJWm8Zs2P0GFnCjrJRENKPjvMxWbL/FDE
	+/YxVny9TWnz+BH/mCe3UTa4Yuemz2Zv2dsOcLtoRI0De74pvU4LBRloA9kzvpB983UeNsZk8xo
	nSi7e6xW1y9V9TWJRVbrFzoNed8DGhq0x9Ox1dQMI+mJ9ePPugNTT5VNjsDY1LdXnR0rbX92+P+
	SlTlDwcGbY5x+kSPYIvei3GIqqESMojbSXJt8OEypcJIuPnQ/a0Yu0dadnLeEldHh4QJ60HP8NL
	CIpNIqyPC7/Zt3t7tG5r/GpVDqpHjxztWddZIO0=
X-Google-Smtp-Source: AGHT+IGkQ/Jwdz0hen+IZZordaBwb0FnIsLHdm9Vab1VmHts7m1t5JFOOcsAaPj7+O5XwKDwKAOewvz8pmWBLAdPVtg=
X-Received: by 2002:a5d:5f90:0:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-429aef715f6mr5362079f8f.5.1761783986804; Wed, 29 Oct 2025
 17:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz> <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
 <df8b155e-388d-4c62-8643-289052f2fc5e@suse.cz>
In-Reply-To: <df8b155e-388d-4c62-8643-289052f2fc5e@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:26:15 -0700
X-Gm-Features: AWmQ_blIRE7qylf1r00bSF1LUzzYB2Ikdwsc9BuLrth2mRvMZNLO8ddWxSZ_asA
Message-ID: <CAADnVQ+TQZXhOhfG27kKdX8QUmua6AAqX81CnkS2W=4TANPUiA@mail.gmail.com>
Subject: Re: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> > but... since AI didn't find any bugs here, I must be wrong :)
> It's tricky. I think we could add a "bool was_partial =3D=3D (prior !=3D =
NULL)" or
> something to make it more obvious, that one is rather cryptic.

That would help. prior and !prior are hard to think about.
Your explanation makes sense. Thanks

