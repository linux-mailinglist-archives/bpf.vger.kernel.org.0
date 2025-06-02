Return-Path: <bpf+bounces-59434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B0ACB51F
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53374161F30
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F722B8B5;
	Mon,  2 Jun 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SqUXdBcl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221E22A81D
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875537; cv=none; b=bvKG2KOp10mfTagDHhbjRqYOQfT9Ou/gXaursPO06Mxw0TyheiSnPCNgYfW4cGG9UcclvjjvVUPpktM1cftcuFeCg/KJgg2JTf3jkNbquAY2qo8CIpimlFl3+OrbLp7xlXatOBOWEUdv5mvkLZqvY0/Xq2vH5KWG3O2VgdnbvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875537; c=relaxed/simple;
	bh=qf8xhx/P8U6G8/9ptr04NOdlpjybtwrNiRY9oxiFgCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgHuktr11kSfjHN01OxBRQdwQIZGG1nf4Q6rJEhwEDCtXKLSR2SaWZXbqwQDHtCbn4L9PnVu85hoXUkvRQfi4VzxkiP/H6fNypBIYJBf8u4oLYRs4Ni2TWakEqVvb9pgT7nuCxSxvSB04Tlzelm0hXXqfaTqUXhQQ+AFAKkEVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SqUXdBcl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fdc27c4aso1197291f8f.3
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748875534; x=1749480334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qf8xhx/P8U6G8/9ptr04NOdlpjybtwrNiRY9oxiFgCo=;
        b=SqUXdBclmE5O6zjByqrDF5y6WZUKgd5oCUClVCr1PU/WT5pvhHGAcNtGfrq2onZRwX
         0uFfUkXEhwN9lxbIrn8SxKwkmjYyL6fSh45cAEKVxTr7DU2+QnxJK7hYLBK1Kj2r1kxJ
         PcEepwIisICvcGqvHem7trQR7I6rMAEBT1FYYq/ZxmPApKORDS9Scg4EGvWW9BnLGdLF
         RNYI/8AOIIO/hr61h2iatoXsGjGpHZS8orBmtlfj7Ivysi93Za8SWvyhbbD0ZgHrOLbN
         2B+Sq3Gaf0MbpLVpC5gl2nb7ASFDTz0S/6HOzOSDaO0fQSPYvOqFjlpLq50CWlkPQdKu
         KEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875534; x=1749480334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf8xhx/P8U6G8/9ptr04NOdlpjybtwrNiRY9oxiFgCo=;
        b=UQYR6122ivaVBB5SkehtZBbTVwgpcx8UfKIfC8zcljBaNDrX4ue7IAWJL22/cu1iDy
         1x1m2HXZLkzIylBfhskp30wZtbqQkfOWNUa+HcY/4WpetowCYTdKk/TN7a1153o/0HQD
         n4S4xK8Vvo3GKzHIj+8zbJJ3CLpP9jhvA053Ea9atiCzWWeJD25o7hEMfhm6TT1UwRoG
         JjEz1pO9KXNUBOMD76ZeBDnCfbvp0Tizkcb8HZZmym8lw3uPpkB3QaAdxx91FPawzqoP
         vbOJOuF+WB1us6cwkBUtuu55pJuoAo63B+BAryUBc+VO3C4L5fE5BmDkQLGBDs3cliZc
         36Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUMBIYxYflTQTZWcF7C4DV4NLKUuBVs3LLbDfpQNDlsucq0GIvlxvJTm40GpefKDrlaexA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+MhO087w02lwhETQjU+3lvvFfOVVsYjNh6BXV0hviYdC34Cg
	am9RyLCZVAGS04CDigJXrz/z/9cdLPliXgVC5O4K7gGxdK92eWDKtQdRLNi90Vzt1+E=
X-Gm-Gg: ASbGncvbNn98s+Rbg5dy0dDpRKeqRaZuvWMEEXLM1PGfmhow31s4opxNQkjfh/GL5TC
	wncT2rMNRZchSccZwb8h1zP23kPJLF4bmwuI0x51SBkPZcygGsYkhyj2DXgheCYxUMwN+eV3Kax
	/M8F2v/HwV4FdZIAAvc4m3SkrOieSoUKiK7TvJzyNvz1qdW80z3qyEGrFYiqlyBSSuYww/knfno
	eeKvf8XZTKQHEfoW2E2wiX8dJndVgxsqTZSBu0WGRn1e4HTCC843CnNasktficLIQqrz128rBWA
	uKpHt0M+FHh7nx/NZ63VeFBbnqg0aS04o7WLDag8VTBSyyqqUwTTjl267za9EK04
X-Google-Smtp-Source: AGHT+IHhOLPK3wy+JJwKSLsDWydjB4lRADzhyLKMg8NOlNveSdw1CmJFuZPFx5ougj5v+ByLkjCMxA==
X-Received: by 2002:a05:6000:40e0:b0:3a4:f41d:6973 with SMTP id ffacd0b85a97d-3a4f89ad29emr9750624f8f.13.1748875533919;
        Mon, 02 Jun 2025 07:45:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971fasm14937650f8f.77.2025.06.02.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:45:33 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:45:31 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v4 0/5] memcg: nmi-safe kmem charging
Message-ID: <gqb34j7wrgetfuklvcjbdlcuteratvvnuow4ujs3dza22fdtwb@cobgv5fq6hb5>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7o34cr4hrs2kk3cc"
Content-Disposition: inline
In-Reply-To: <20250519063142.111219-1-shakeel.butt@linux.dev>


--7o34cr4hrs2kk3cc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 0/5] memcg: nmi-safe kmem charging
MIME-Version: 1.0

Hello Shakeel.

On Sun, May 18, 2025 at 11:31:37PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> Users can attached their BPF programs at arbitrary execution points in
> the kernel and such BPF programs may run in nmi context. In addition,
> these programs can trigger memcg charged kernel allocations in the nmi
> context. However memcg charging infra for kernel memory is not equipped
> to handle nmi context for all architectures.

How much memory does this refer to? Is it unbound (in particular for
non-privileged eBPF)? Or is it rather negligible? (I assume the former
to make the series worth it.)

Thanks,
Michal

--7o34cr4hrs2kk3cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaD25CQAKCRAt3Wney77B
SQiTAQC/eAKARy8kEU7fP7GCMHE1+7v+d2sSxmXDyaCQ6wqidAEAu4q3hQa6TLAp
Pqns7WVL19JaCImjilT1rPY77Jv3aQo=
=nNTq
-----END PGP SIGNATURE-----

--7o34cr4hrs2kk3cc--

