Return-Path: <bpf+bounces-52909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A1A4A45E
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306E0189A29E
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3AA189BB0;
	Fri, 28 Feb 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miPUVl4H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A523F36A
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775334; cv=none; b=N2RV/8cSkuVayGeAHRaL5s1zOFbn4EoV378sTxVLV6NWgsJ7h6w6uFBVF5kpI3B8pKgVoIEKrjaHFn54DUHNXPqESra6rW/bBcqrU+H/YAaVHWrzq7Z0ywJdLsNbcn2shaYX7rRe1O9m+w7aHrf7U3m65qxdL+svHvvQxgUFVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775334; c=relaxed/simple;
	bh=yDUuXlyHhBN+vedQcz3aMDgItkShPEzRxyafDv3MIsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zv0RArssfSrv4vxp+qZVhGFnuBZqC4aIfw+zLP2RLcxJslqQIu4Poucy0Bu+9Zxqw+LJph7Qf8ulCItlAYmmO3x45p600UvLiNPaGsN1NLUNtAkHp6nKQhc1J0YQmjNymquajXVqO76J4kCOxbgCRVEv71t9vgGyrqvUhJyhEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miPUVl4H; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22356471820so41951745ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740775332; x=1741380132; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yDUuXlyHhBN+vedQcz3aMDgItkShPEzRxyafDv3MIsY=;
        b=miPUVl4HPiVRH7B3avMU7SxmJ/r6DSBkvybbKQcPymonNOoS6y0CUqseVd/3IFT9MO
         NI9wgxa1hHbXrBb5bPVAFuDkBkNZEDr9ojpyVPt0eT6cWWGMaqDYdvaVUkTU+QzPRZLg
         G5yBn1htIxPDuliILHA+ucvJOswZ0CarmBxXxfVgA7YHoWH/vCtBWaLm0viHKkZxBlxV
         uWPPMgNZ52CgKERFhnGba3h70ie1F24CStPmQfPC6DnLwQUT3FSXt6Vk15XAo8XtZeFC
         fWJveBH22jKAyFniqGwHZ4D5dm9cvef+hs4hyljiPMUfhIO+H7ItGwZSCs72+VeKzIC5
         icOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740775332; x=1741380132;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDUuXlyHhBN+vedQcz3aMDgItkShPEzRxyafDv3MIsY=;
        b=CUD709I876sz1fHOE1cySbHQdGFu7obYOtd/CxDNWDPzdBKF4vVZzIvrbUjfR5MhZJ
         ND+R3E08jdGDmAhY2hD54tq059FfrFQHmG3oIHc1Z/EFfyC36t368D+dpb+3Wckk0Vih
         9FFNImhrZCeFFeJn+KHskDs9MPRCFQnTnGNmcPPqpzKxJ4kn+nXkdB9iGmlzakxtWeOK
         +UGQdfQYs3R/f1RrPpmPdrVr/DcJ+IgeNTlbc0dddGouRA8zAz8ufxgsgqZq2opO6+Ve
         NN+cthJlqL0fXWg+iLHQgsbHKezPpEzF+SIV2PU3nH8EC7EHYnOIjaFtrool9z+vURZc
         39Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUvm21PPGUUkTzRd3wxFl14d2IRuEZF4vQSf+/enDeC4YarEdzHP20wBWe9SGF52TFLK7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQNL+P3kJT+2CQ2zjEmrNfOM4XrNrM5KmAAc6LBmz5qf0eQrT
	Y+3T6oBkEtat4RqUP8/Hu9PQaA3bWtpge8xEj2zzrInGa0Gg8QMErEgKCQ==
X-Gm-Gg: ASbGncsvKuMDQjAdNmV2MVM5eLZu5kiqgC6Inx/ZzfUazux6Qyzt6rwqa9n3jixrCIK
	IaD9m/qI2g5/PL6EYaZBXQbg4Qi555Q+M59RgZl01x3vt/8YY1eJolsBrZXQJzuhMQPNWiS8LQg
	ikJZq96lLqRUPNrGRgYJSirZ8xExApURSAytMHqF5RViPcKfxSMwr5GIaKLWoPLckkhHstizw7Z
	oOVgmVTwf5bjO1e/RYpxdljMLmylTnDq65S7SxDRzugVvTxRBTiqxPETO+WoCXH043G8D0omrHm
	TFbVz51JpWlA1NdRyVlWis4=
X-Google-Smtp-Source: AGHT+IHOyRXXGrkcHuXBIyEZ8TJyrDww2/fp8909FfoqjbflTS+QabZNpKX84/oT9qkh6KdM56/ZiQ==
X-Received: by 2002:a17:903:1988:b0:220:eade:d77e with SMTP id d9443c01a7336-22369255615mr83891905ad.40.1740775331977;
        Fri, 28 Feb 2025 12:42:11 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504f715csm37568155ad.191.2025.02.28.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:42:11 -0800 (PST)
Message-ID: <be5c35ce48592380e4edfabac2866bfc4f822cac.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Fri, 28 Feb 2025 12:42:07 -0800
In-Reply-To: <20250228162858.1073529-2-memxor@gmail.com>
References: <20250228162858.1073529-1-memxor@gmail.com>
	 <20250228162858.1073529-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 08:28 -0800, Kumar Kartikeya Dwivedi wrote:
> The verifier currently does not permit global subprog calls when a lock
> is held, preemption is disabled, or when IRQs are disabled. This is
> because we don't know whether the global subprog calls sleepable
> functions or not.
>=20
> In case of locks, there's an additional reason: functions called by the
> global subprog may hold additional locks etc. The verifier won't know
> while verifying the global subprog whether it was called in context
> where a spin lock is already held by the program.
>=20
> Perform summarization of the sleepable nature of a global subprog just
> like changes_pkt_data and then allow calls to global subprogs for
> non-sleepable ones from atomic context.
>=20
> While making this change, I noticed that RCU read sections had no
> protection against sleepable global subprog calls, include it in the
> checks and fix this while we're at it.
>=20
> Care needs to be taken to not allow global subprog calls when regular
> bpf_spin_lock is held. When resilient spin locks is held, we want to
> potentially have this check relaxed, but not for now.
>=20
> Tests are included in the next patch to handle all special conditions.
>=20
> Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

I think this change also has to deal with freplace for sleepable
sub-programs, e.g. see verifier.c:bpf_check_attach_target(),
part dealing with `tgt_changes_pkt_data`.

Other than that the logic seems ok.

[...]


