Return-Path: <bpf+bounces-16687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318D804436
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843C71C2095F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E1D1870;
	Tue,  5 Dec 2023 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZDFPaH4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254EFA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 17:45:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so29206285e9.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 17:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701740714; x=1702345514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4sCiXj4uQsZvPOAk43Dhw4LS2zzRif5vtRBkw4UQN4=;
        b=iZDFPaH4CP07k6OUuSEm0xK6iy7zveA9ZoUjMDVHE56HzT2AUQxPxvihLv2tpf5DEM
         1qq2VRB9RovVZe/APZz/T28/D9XzoFNa8aZERz1SG0Gy8OLczG/TxB8TTZMwudou4C4O
         m3ePAvv3BWsRlxiVo8Wvx1ZbrdleAWdvEJ9gGe84r6gx5dJAVAyOBbvasj3OtjH3N9a2
         Kp6mJweqqAsBIgYwVybSruUk2fEMcJw6rStK4bgqzJtQUAmHhVUEnTrYkXPvc1fbeCPw
         ExsaZc3ie2zNIR4xKSon5i9p/vauwXRpVuu/ZcqyExMk2nLvIgqm6iMfLwU5/IbhIQmI
         ev6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701740714; x=1702345514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4sCiXj4uQsZvPOAk43Dhw4LS2zzRif5vtRBkw4UQN4=;
        b=Mn+zSZ3Lzl1oB36F7fNEhla2yhzIPfKdP6k2Rcw4xync45HL7QmgqUrKuyP3IfvoVQ
         HrBgSss7ziXN+d8vWyH4QcPqp4tKdJkHioAC6GEfY8wgQhNnxs0F1RLHd6sjkieGZg2H
         8UFnRB+rcbgYxd333mku9sIHZbb4P6KzU81V0FSrptgXs9BSspHAWTTlhmP+ZtlM1id/
         hxtTw8c/PCQ9SepoeROM3Mue+MDWGPZRfmcYqsGrhDqfrH6qfyNkXHwI63v19orZVsVA
         RLJAF/2xUMLC2hWVx0N1GT3M3hFSIVSIsNk+Xj7sYcMxq6k/NnmyczPc9d7XP+M89S1e
         XtiA==
X-Gm-Message-State: AOJu0Yx314nIw5NA5d5TSLb9b2A4pZKG4GIn/4gO691aBxFsSN+S+Ezb
	Ezh7mAcKx/yFJAwdJNBTP6Y8e9pcgRRvoVDjoofMzJPbX0c=
X-Google-Smtp-Source: AGHT+IG1Kh5XmosyXFS+/iNqPVv80eBYe4PEsVsIXdqVwmrjj+cpvAhF93vjWmnVYDtNCpBjcqLGsbjbZAkEymutv0Y=
X-Received: by 2002:a05:600c:4d02:b0:40b:5e22:2f7 with SMTP id
 u2-20020a05600c4d0200b0040b5e2202f7mr1587100wmp.99.1701740713845; Mon, 04 Dec
 2023 17:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org> <20231204192601.2672497-4-andrii@kernel.org>
 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com> <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Dec 2023 17:45:02 -0800
Message-ID: <CAADnVQJRdu69g4nXRXNopDLBPxw=aA7p1NakOwhvsgF8PKYqqw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:23=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Alexei, do you remember what was the original intent?

Commit 27113c59b6d0 ("bpf: Check the other end of slot_type for STACK_SPILL=
")
introduced is_spilled_reg() and at that time it tried to convert
all slot_type[0] to slot_type[7] checks.

Looks like this one was simply missed.

The fixes tag you have:
Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
is much older than the introduction of is_spilled_reg.
At that time everything was checking slot_type[0].
So this fixes tag is somewhat wrong.
Probably Fixes: 27113c59b6d0 would be more correct.

