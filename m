Return-Path: <bpf+bounces-72938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC9C1DD83
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707EF188FF64
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0084AD24;
	Thu, 30 Oct 2025 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGkWCGQL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DF9476
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782619; cv=none; b=Iue6j6QOsTaE5DsK1C2eFCJvDvFVzCSygepfF/dbLSBIJSoW9SUGFiTDBiPoDZMPfRqZFVoGYtRDwRR6/t0DcF4ykGQCLI22vIrhftTvD/jDtlEt3hMG1eJCilEfffQkV+zeReFELdfOWuAtzH3htRy+MtfEd6GJKjHOxJl/D2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782619; c=relaxed/simple;
	bh=IQdAVekv4irRGgMMfp/PjHkXohbkVOvsM/8HtebJv/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7mxed3T/dFZmbFOinxPTTAuFE/zsgbiye2OFBwWKI3GsMdQei2sTx3D43wivYm6eycdB2kcBBNHBAdUqIqPIrdTf6QH2H4JboB6rPU43EA/VbQtnNDDb2eS511WnPlJfY0IT1MMLVfiQa6Dn2NtdEwS4VSk5bFZmwNrVChtMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGkWCGQL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4285169c005so241713f8f.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782616; x=1762387416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El4J/tPU5GVXHSLQfOqUzKCRr5OClPDUdxz6lfYkO5M=;
        b=mGkWCGQLgx5y1ztnWdRLWrFPG2DE/dwLk3NSXZ1ocEQlwZEmwWQL7fT/ds1dDS4gKX
         gyi9cgN52qiO+lvSHVLBx+v21aubhfwHJxmnXm3ZKTDbW/uAfDqfWa36Jol1HvljrAZe
         HKN4ctxFAvkpu/rMsY4woNp2TCU3gW0VHngAKGc+cib3AITXZRZBmyoQ2Ql+ySku2M9A
         rWh4TWVOpW8tYYzz/qpiyVtCQk/d6Q07o4cpRBE4+VePUUuROAxZ+4j6s9dnqgcgW1nJ
         cQQkDp9Obv64O5VN3IfvIy3KZ4A7mxxXcJBCe3yTE9h+SFszAiYkcbB/P8ahMeHIgl9N
         /2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782616; x=1762387416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El4J/tPU5GVXHSLQfOqUzKCRr5OClPDUdxz6lfYkO5M=;
        b=VZsUGQAESs9nimupu0BHpUraRAv+S2taBSPB9zvLjKxb/QhhKeYRa58Wp6be4y32cY
         nrdtFqTzp+3nCV+fRe6t0ffe6lS/7mQaAO7QWxDtGMv1EGwI6MtqTnd2IRwL9nNzwVdV
         qaQtSNrU6gL1g4CLhSbI6Z8VPh6bXgsch0xqRmudXK8bLrZ6xYgKFGw2DRQzs6YOA2ry
         PS+q1b2/UoiipR1Rhik/nAaIdUvtIaNO7BeaL6uZo3irvxu6e7RqcumSi3mr4qt8qd6l
         zELSTFmZoXDvuKYd2CnlohZAJbe3z5vlRKrraykZ2tgWbRGSGjJeWjOCRhcW5S9nA2wV
         ng4A==
X-Forwarded-Encrypted: i=1; AJvYcCW96n0W7+BxH0frIc0/X6pfgHBjJ4XRYFYGIwjhm4EEnNZJM3As3sgoEKzYNYK4EJ+PNZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjWHO1IXTgByNgjpWIEWwdisjG2zT66WX6/guCMwqJh+hg6Oe
	uJKWJwEUEXfkB4yvYpgTNBZxQgmZn4b/vklmOfXulh46r5tWUJA5/NL8txb2y0j30smtoUFtFr3
	ibzWp1n9m+QJ/NcnDet+RocP8Iwjqbac=
X-Gm-Gg: ASbGnctg/xVPsz9bN1ZsbgehC9mcSOtYriIl4bzPLDe/k1AWiDtBfucfoa1uf1mbFUs
	ZY/2WTaC8heF5d7LVQaU2zfQxN6LgHA6hN1ZH14mEdy8p0zIgmquLq2j8SStXlBAz6j526gb7i1
	/Oue0EB17NI8Pi+Ii37SU3F5H8/a5nRUO7Dsx+x3WifrVGGECpurQzz9F3G6hN0y1vF6rkPAmqd
	QiqJAAipCMW6yK3FVrj5T0o5JwUZovyitVrdGPVbGbMh26GJ/H8eqa77bj3pzyaKD46cZdNTrs8
	7EifsSpJI+cMkhkpOg==
X-Google-Smtp-Source: AGHT+IFh+W6qz2ceIUI2QhqYoE/268h3PX3Rtjarak7sWgQhdPAZITWiUaam+JJ2eaaDJjXrqjrqy4uREJVwVsVFhj8=
X-Received: by 2002:a5d:5c89:0:b0:3e7:68b2:c556 with SMTP id
 ffacd0b85a97d-429aef84080mr4043118f8f.26.1761782615888; Wed, 29 Oct 2025
 17:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <20251029190113.3323406-4-ihor.solodrai@linux.dev> <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
In-Reply-To: <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:03:24 -0700
X-Gm-Features: AWmQ_blixd95JW4fMfByV1IsDwwur7m8Z0T058Ir4uDIHps2me8sOhgRz7Ob68I
Message-ID: <CAADnVQJPevofLp0B0h40t0X1gj_032kw42K0ykHW4BqdmY0eNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with KF_MAGIC_ARGS
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> > A kernel function bpf_foo with KF_MAGIC_ARGS flag is expected to have
>                                  ^^^^^^^^^^^^^
>                 I don't like this name very much.
>                 It bears very little context.
>                 Imo, KF_IMPLICIT_ARGS fits the use case much better.

+1
I hate the name as well.
KF_IMPLICIT_ARGS sounds much better and can be abbreviated
to "__impl" in arg names.
That way it will accidentally match our existing _impl() kfuncs
though there _impl meant "implementation".

I think this double meaning of "impl" as "implementation specific"
and "implicit" actually fits.

