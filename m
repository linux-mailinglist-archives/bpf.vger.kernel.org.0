Return-Path: <bpf+bounces-40320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D255986725
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 21:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5DA1C213CE
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 19:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633E145336;
	Wed, 25 Sep 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASliGkOy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1B7483
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293693; cv=none; b=KpTSR5Bq9D3Om8KtwwK+JRGH8ocWZAUZYJciRBJ3ZkaNem2yRDVYQpQ3IUbO5hPZPZK72ZheEXCre3xoOwvSLMy7zzZG8NLjXkd6yuL69l1vUSTG460gY1jeb0dOZKoeeyckwouhIvmbrUAW3nXLKmejkKpToTmglVHbvIzuwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293693; c=relaxed/simple;
	bh=iK2sLx8oGUCucbSQdL+4ObaCjTlh+g4nguJaaWdXfpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcNg9JR22Lb6P0HVUH6A6x3fJIG+fW9uJ3CoZrHqZ+y56LDDWA/8S35sngLhloo2Hv0cbjQ4SvZFrDRgBtc+M8cJD1vr+CVyOFiwvUWBNlKUoLJ4nzOHHnQsXclNShQJ87wyv1QECgpZXczUdTsgUbkxkdddD741zZLnoS9Y5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASliGkOy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718d606726cso188548b3a.3
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727293691; x=1727898491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8GD1uqZsuLvGsyqlZUmyDCMbZje3d+g6TKFIwEOT5Xk=;
        b=ASliGkOySsYgy5NosvCXjEduLQvgtgcuOXm0UX7IDCBr6rq1LdvMjENzzLG5bYbB0K
         i7urQPh/qVt5E8ldS/EtGYP0yyGpygxVoYK6QkhZY2K18FsZrYh9RVhuTkjcFQKyn9KB
         OcD0PGCS8An8Nq61UAJuTbE1XFvKbZZVZyiFvXdIeggbFT+ozdo3+1k+jtlB1FoZixox
         kJs4K8jECR9wmvQmVlgc4RqiHxN+SxoqWi5816AB1M3+8Ty3aDTv9lEzJq6UAEiiz60A
         NTkhAGmwAmNkTrlI5QAnP9V66yfQFLPItIlJSC/bxuprIOanATLnJUaNJnbTCxKNl131
         PhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727293691; x=1727898491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GD1uqZsuLvGsyqlZUmyDCMbZje3d+g6TKFIwEOT5Xk=;
        b=d2QA7QxlqdgzWfwlBUlUK0PLn7Uss5Gz9m2AWOjbvOF0+ifOy8V304mK6ec9MFsWx8
         IOXf82qbCq+qNUVdXFAZ3jvl59zB/sCX9hdp28KtnZcL5NWOCXB9esjGXECMHtQfukQT
         LtD7NcU6+6bOOfNDZsg+zbvDJJnfcNBtp0NRUaQY/MeD+owQaJ7D73Yj716vKerOM0yY
         AAGR3oE+GHHPFOl/ZYXIezZQt/zlBnGOeEwhpNF3AziZiPHhFuCx0xlV7LgdfTZ2Fsyl
         DG3HQiTSgjsuBBgv8kNHVb9Hbxx7Ud6acC6n8HPqelNeM1sT/SnjxfzZureu8oyqJ9Rd
         DX1g==
X-Forwarded-Encrypted: i=1; AJvYcCWIxDrIVXdbyF9L7vO8bCLGrXGC8ycpy/gFBe3GJC3mARKfBaYLN08jA1b4pQSLprueKmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrS2At6CzthNBoLF+kp2UJGzvvlgfn+uUd3CYcG/SizKYUXzFI
	0WnHo36MxrXhRoH4MO5iEcmpJgLPizhxWRGmReXYyWxTkHFRtJSq
X-Google-Smtp-Source: AGHT+IGqRkXtlcodS7J5OXsbwPV8AKr9d7o9Wq5psvIM++a7KL83PU1T4Dw0cyqIqotC7v1r3MVrwg==
X-Received: by 2002:a05:6a00:4b0b:b0:718:9625:cca0 with SMTP id d2e1a72fcca58-71b0aab3f46mr6026100b3a.7.1727293691579;
        Wed, 25 Sep 2024 12:48:11 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5a9bsm3091935b3a.186.2024.09.25.12.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 12:48:11 -0700 (PDT)
Message-ID: <ffb55362a04fcc6e20db4705902e721c639b4245.camel@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: sync_linked_regs() must preserve
 subreg_def
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Lonial Con <kongln9170@gmail.com>
Date: Wed, 25 Sep 2024 12:48:06 -0700
In-Reply-To: <88488499-771a-4179-b959-37a3d8f0cf51@iogearbox.net>
References: <20240924210844.1758441-1-eddyz87@gmail.com>
	 <88488499-771a-4179-b959-37a3d8f0cf51@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-25 at 11:44 +0200, Daniel Borkmann wrote:

[...]

> Do we have a Fixes tag for stable?

I think this bug persisted from the beginning:
75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")

E.g. here is original find_equal_scalars():
static void find_equal_scalars(struct bpf_verifier_state *vstate,
			       struct bpf_reg_state *known_reg)
{
	...
	struct bpf_reg_state *reg;
	...
				*reg =3D *known_reg;
	...
}

And bpf_reg_state for 75748837b7e5 has subreg_def as a member.

I can post v2 with this "Fixes" tag if you'd like.


