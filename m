Return-Path: <bpf+bounces-54343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62AA67E09
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E56E423C13
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4152135B0;
	Tue, 18 Mar 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZciSisn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1A211A24;
	Tue, 18 Mar 2025 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329939; cv=none; b=Sr2ZeXJqHdM8WwWj2n4NBSkVotgsUD/5+kULZm8yEp3XimYuuVSjkRgKdaDqrUUByl7//8NARKbDRaN7Bs36N1bhPcg1G3qV0bvhngEZYBG5yolARLWUKnf8IaVRZsUCAPaCN5UciAR+45/l/BPgn6OeKYFgcuCvY2lbvttBvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329939; c=relaxed/simple;
	bh=jexLVPzYqzBcdalxgO8HKZ9UoMD//DZzklCyCCUK9XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlAs8xpiq49dn/Nhevvu8OC8AWMB8320hdlsYY9y1h2sVsnFdLzg69tRn6PKFY8xMX3REX2xACSmo30llxhC9HhltHXGAZMZKrizgddrPznj+NIht9U2/AiEC4iXv3FjntFBdJbkiT+e5QYeIOQpjxHVPnEV8UmJp9eH31dq5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZciSisn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so3722904f8f.2;
        Tue, 18 Mar 2025 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742329935; x=1742934735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfK6+5yvZwS++ZL1M3GTppwzhzu/JkYKf0pRnfCHdYY=;
        b=jZciSisnHehz1+HPcppgUnkX739cyuvQ2IOV6x4jLXfkHUoRWsbheQ3UA9HeHZkJXq
         mHJuTkSFLMl2+5nYypYSwC47uC4UvUt/3EIPIt7bPsbuCy/R/1SYj5dnS3rW6TSyFKeh
         3NfiBewdRewPf6fy5sTkBG+wqIMoYuCk9My2L5n6Abto+m/32sMF5dCM3bpJIvAsBUEa
         gGR3xBjp9OGpkpqNXRiZroge1DtW4PQD7qy1gkd8K6TESnWBxodzv5KYgfhFjX7Eu+ZJ
         6uiNLpaH1B1qMhrQEXjmtWP112Zw3MYxP2NL4DAol4bQbkVgt6saV2Jgwd4QdEdNKRJ4
         as7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742329935; x=1742934735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfK6+5yvZwS++ZL1M3GTppwzhzu/JkYKf0pRnfCHdYY=;
        b=IYAVdqaRtaYQPluNqV5pN0XhmP4Ljuq7PPuMjWpEpBixOHY48ofsXDio52sOY6gt+k
         9eZyx2IRRWuSg086MVBjBCX95D5hjWR5IOf9LOQ7Kddh3sD2rJiEt1IGHy6tBOo5g77o
         KMGuHKoI+aO/CtMxMGvPO6zxBhMVETLFlnD0LI4vdmBG/ukjIF94MESSkSA35H1gMHIf
         Y0mm6qWiuFJirltIBZWZ7OUu6Zjvmo+6o28gJQgain+41gUrleq5EQji3F9WOwsARcRW
         C4DZrWNTmIXbZOUwtzs+VpNm3ztUlOjE3cbz1DQaMgFA0sARwdwNwJwENOuOtT2uBRmG
         5ujQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo1918F3PtLvcCQNPwdVXJeVVtMQK9deo63T1v/UyUrSvBLWmGwKwKymA2HpVwUTQpPq2PR1SkYdkhIZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8MpptdKDu2CH3N9J1+OAD+VhulX3BjkUbX/m7axPncw7SdczF
	eDdqoPsdeS607P6w3jf0PTP3rNLSG5SFuTKX/p1Nggg2b/Pkg2O67gY1oa1D0FxHJBlbfDFIeht
	i9DWgdjJzxDVJdN5Xc+rzwF0HPrk=
X-Gm-Gg: ASbGnctApGGiXrPZXlx4tUtYklW6hKrvYXa3j5DeI08lNoJC0bZtL27OBAUpQoyxPDu
	vqHotzplWrnRlgl1JOplcwifzFR5hktur39ML0Vhyvaf6tqkMezitXYfWUaC2PKa85T10u79m89
	ey2R73kyhUJmDbOnBciZMShDMBfVxR89XwMjrHC1yJhc844CryHlPX
X-Google-Smtp-Source: AGHT+IGDSk690Dg2444bFHp255MxioGMVwnjaLZCAO/imq8VEe/4OCDb9UNwHAv0cZbd4BRQHTm4rkFt3vxht35PQpw=
X-Received: by 2002:a5d:47ca:0:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-399739bbc6cmr184160f8f.9.1742329934452; Tue, 18 Mar 2025
 13:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316040541.108729-1-memxor@gmail.com>
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Mar 2025 13:32:02 -0700
X-Gm-Features: AQ5f1JobP-bE03Krm6-jbM9LaJhqeVyXw4w6hFEVc9Q5_eCpxQmJX24-8FItlbA
Message-ID: <CAADnVQ+Q+meSfHmang0QYjsbBJsNG5rJXifUxrRXC0GNQKUcnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/25] Resilient Queued Spin Lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 9:05=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Changelog:
> ----------
> v3 -> v4
> v4: https://lore.kernel.org/bpf/20250303152305.3195648-1-memxor@gmail.com
>
>  * Fix bisectability problem by reordering locktorture commit before
>    Makefile commit.
>  * Add EXPORT_SYMBOL_GPL to all used symbols and variables by consumers.
>  * Skip BPF selftest when nrprocs < 2.
>  * Fix kdoc to describe return value for res_spin_lock, slowpath.
>  * Move kernel/locking/rqspinlock.{c,h} to kernel/bpf/rqspinlock.{c,h}.

Applied to bpf-next/res_spin_lock and /for-next branches.

bpf queue_stack, ringbuf, and various local storage-s need to
be converted to res_spin_lock in follow ups.

