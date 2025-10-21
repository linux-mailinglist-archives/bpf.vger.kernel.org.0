Return-Path: <bpf+bounces-71618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBFFBF835A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFB33A3C31
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA99345CC7;
	Tue, 21 Oct 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3DcFpOh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D834D91A
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074131; cv=none; b=IyRy6PQ0kWWLoy7AD9XOM9CBTPR6v2CErjJMTmh0icFqYfIghpXTDPlDl/Bg860j0+O3qBM3WHYlrqY62JZwSRP9zJ2svo0PKw/KvVlnOiwWMVu6UaBvMLHl/EzfByklHnJ0CkcPbcTSiaEcOjXLcjS/5iwHK4Ivt0jAc+Jqut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074131; c=relaxed/simple;
	bh=ubmzLhuN2w+cJe/Qme9PE1q5vg0zYnrw6N2sM7rcD4k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjC+d6b0RFFEE0n2pLozsHe1GjGJvdKZ+mNssXGcyVRlkOldMpQROgbxUZET7MjVgIwt3sRIqq23dY+5UOHmdf4MnsGokz5DeY4gB67m0Uuav6CFlAKJc429/Bmsf1ZFz/nkK57NpX67vhzCot6IqXctjqJV5LBaahRas0K9QsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3DcFpOh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b593def09e3so3976563a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761074130; x=1761678930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh1z7mRAoW27yDYM6XeB8rKg1n9CpRCc2CamSKhNvCI=;
        b=P3DcFpOh2UCftekzpezP4D0NshMXqqw8+dYnt/crc26ylPaKUUJlAk5cz27f3iM/FJ
         whKlvwKnQBeDAnsTFmDVXhmrgl2AF2ytP6XWrNrDcDnOz2v7CoMDOQymgWFIuEAlgAcx
         et6ffqXqsWK5UhGReUV/4CI6KpE26HcqzjpjH1/yLK9GgaAOXZSQXMmI1lWN3dEfinuE
         nIMwNXW+ChgqyqdaQAfLXKafmOXWTrmt7/Vm45DS3Y9BxvnmmRy6r/eAVQ6JAfg9AxEb
         mI+XdOn+BoR5cvNRD51KClYGk/0ZFEUltp8Ttlyr44KI745o5asf8I3DwXJUCC46OoMG
         TyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074130; x=1761678930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rh1z7mRAoW27yDYM6XeB8rKg1n9CpRCc2CamSKhNvCI=;
        b=TdsHKAd8Krnur7/O44XP5Vtev0jMMBkSiwBfqWNlfHQ+M7Ioriuqpq1Kzst3XNQqR4
         PqOlSZf9YVHIK7kqnObqZ6Y8wbajY/K4MteviAwGqXffnEVixw/YoEZGK5OYQy04253D
         ZoCG4hkHbr1lbZFTyKUlbH1dOnpNfZNgrexPOYwKR02oH2C9jqFzkXHbdQTkiLRY0X3Y
         0u/gnrFvgZovaPLb5UNZoSh6BcdCEsMs7Wr2qtOwuadHUX1lKVmtAgobQFB3GFtGt8tZ
         tdtrXoV17ArTu8h0yTjKplzy0M8t0asXRtyyG6SM41BDt4RKE9T3HJowKSCidxdZ+JqD
         HnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVidHFJbKL07VMHaQAzLXXCx3M+2lgGRTQ4eqpT2p0IrkqsFXxtby9zVBrU3ZlET0le9SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAWLdxttrBQthD8qn1zjb6EWYjLmW+SzeF9DY6lYH6a6DZ2uV
	SRe15tEu9H9Q6NKB91AtelN89VgWvhRBR5HDVy5KLjsRLjrudv18i51m
X-Gm-Gg: ASbGnctgF74G7LspIzo6UYE6XHx15ZoVhu69rB6SmANvkJjnQm3Rh8hc+46npZJaPJk
	nk9oL6ma1RloDmJh5TFodVirBuVt9Azh0LMp6BEgHio0CBSitsnwGK2rs3nN8G3FUShIrcAIZi/
	klHQTT+q4rlcOLyDU3t+0nbw4Rzdm+YoT0mZLNZiwAFASn/tjx7Zt/JOTLvej403iA1JKFQDeZR
	VZ1MLfbfWEt0kQrgsTLiYInvKDD6cDbp5Q0JlaulKqAJ/3jL1pwnV3elsupRCVzg57sHXIhOk0t
	x1K+S2VNv/lMoRIiJK0Fjjzl+3emcAiRpOdUTBCHw9JcArX4BqOUeGdcutoRl0fBHuhliFrzZSk
	1G0bz/XW9yFnuug+hSs66Mn7ymY2oiZQR34HcZoAcAtuWWHwM34p0hiJYy/uX/F0UY5OOmWMlL6
	BWKI7ab9evBhjEzLID0/LnwdhB
X-Google-Smtp-Source: AGHT+IFl2EmiJn2rWwa/Ba3RJDYSW2CaAW+P5ePYg2gG6g/ytzn5NyAZ0uJ+HPq6fVDJ6DA+42YIsw==
X-Received: by 2002:a17:902:d490:b0:25c:8745:4a58 with SMTP id d9443c01a7336-290c9c89c8emr201163845ad.3.1761074129685;
        Tue, 21 Oct 2025 12:15:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcc1sm116520835ad.82.2025.10.21.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:15:29 -0700 (PDT)
Message-ID: <83225612f07f1d0f2f488efaee9c075b44e8cc03.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 12/17] bpf, docs: do not state that indirect
 jumps are not supported
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 12:15:28 -0700
In-Reply-To: <20251019202145.3944697-13-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-13-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> The linux-notes.rst states that indirect jump instruction "is not
> currently supported by the verifier". Remove this part as outdated.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  Documentation/bpf/linux-notes.rst | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-=
notes.rst
> index 00d2693de025..64ac146a926f 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -12,14 +12,6 @@ Byte swap instructions
> =20
>  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` a=
nd ``BPF_TO_BE`` respectively.
> =20
> -Jump instructions
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
> -integer would be read from a specified register, is not currently suppor=
ted
> -by the verifier.  Any programs with this instruction will fail to load
> -until such support is added.
> -
>  Maps
>  =3D=3D=3D=3D
> =20

Nit: bpf/standardization/instruction-set.rst needs an update,
     we don't have anything about `JA|X|JMP` in the "Jump instructions"
     section there.

