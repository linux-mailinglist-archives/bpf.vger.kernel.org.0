Return-Path: <bpf+bounces-71855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0265BFE5E6
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 00:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1EF3A8F6D
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 22:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCEE30596F;
	Wed, 22 Oct 2025 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6Qv0fVj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6B3043DE
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170695; cv=none; b=bh2DfBr4GR/bKwzYVGcaB4b5oywzKbB7SM+wG6Klm7KBe+7t1t9eTWLW8D/MLu7r3v0b1Xfrd22/6OxLmXHjE1ZowYMMLOctBY0H/U8vswb4yT4URgNte7DjOjMLsPvkBJ356o2h2CerKr7mWFVm/dGxGn+6apLbFfgGJ6He4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170695; c=relaxed/simple;
	bh=r5ZyzJqnIM+ltNqxtG0rusWGIroWJ0GvNuAv45svRjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4BEc0s1xLRUTqPTtNXAa6xoZbUUv+i5kguGB8U14XWdI4n5fuA8y+Ev/uq49eyx40nqqXKrvTKG1JKEAEJuPZEBCY5/UcMTJyvYB826mbL4NCdWIh/mo0EbMBqmf8gG1Smd9hUbIsEpXQS4+jznOkmMAD1fr9AGmURu9zofLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6Qv0fVj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso56036a12.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170693; x=1761775493; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r5ZyzJqnIM+ltNqxtG0rusWGIroWJ0GvNuAv45svRjo=;
        b=P6Qv0fVjIMM444tbDcIM8QcKMFX4/nPF0jEQokkp/JpxDhBqjm8GeM5ySkm4MOQaQy
         fKNYBWJwCPcrf4cUtktce01To9vV9KKiylXBsLRwi4SbmnyoVYPuTmF6I23zuj9l13W3
         SuFds28TVa3GIFp0oeja1WJSfwlEwlWZ8HkiIkdcQdbhXVfuBgtfxnIumuLOUDOGknf0
         ysI3JSUESMCR+lgDNnHzs37XPYkY3cZsQ4Q2iRNNM5Yzv3425IwHW10EdhRvPqVpPuN4
         UrdUA1VCD/qpj2ZO8YOKyhsHMua+uolxNIzravZcFR0YLZCLAV+tFNLj3D84J2BNE9fL
         i/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170693; x=1761775493;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5ZyzJqnIM+ltNqxtG0rusWGIroWJ0GvNuAv45svRjo=;
        b=B6PiRNBaRHQX/UNBDL7NEkNLz5qsWMS5aJjHu17y+abuNqfIRQKtCOrE0JpvASz6QL
         IKQYcqcTdQge5pLcoXuYQ12r5sLTrFLEFvdQGUVq5trYXvLXFqxdu1qfLk4rcOSZ91U6
         hddhyhS8EAB+rMxDS7+MSKnmG4Gn4gsEaVH9sHK4HeuGjyQfV3tuzvPoiRBaFRA5GpUO
         WIWO4Hm/ZSIORn85zjk3Kj/RrqULEIdf933H6gC5XGwBr1ORYZHZYdduJJjS1YjVa8PA
         FJoIlmkkPt/50xyZ78m/e7nsJLxuxAL6pzsj9OBfhKHfNHm4uVVkFpTlGO04bsc2F0UU
         m48g==
X-Forwarded-Encrypted: i=1; AJvYcCUfI3zdQnK+PtKAS5RedhyWf2sSUBXsSXMFteFQFsWMBNC0I4F6J9/FttvT2Saj5P2VgEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn28O3UaRfP2czE864pb4df7LyMZqviV9+t3QBN49b6pBKr0mt
	WzlK9m0Kl35nmFx/Fy3EhPQYEnhKu3dGpMO7KqJyJiBXKATlhctDXTKf96L4Tn1E
X-Gm-Gg: ASbGnctigVL0t40eArTSNEG8z6T1YKmuapavYxQeNWFl2uFHMGS+TmNsqME8p9uJ49i
	3eWwPp35pjBaVCZyZeh042ST0mbXpPq8S69Mi98qufVpSJaD3Lp4Ub5jop8Db2RoddyXhrHqj7T
	NsLqz3wm/eN3bobHZ3pvwyYtQiDJ7JBK8rk+oxrd9eCWTibXcyizp0bYo2aVWYijqI+MMy83vNL
	lbx1H2CSkutzAN2hAIzZaJ0DqHDLbMEulUfQW2VbMDzZcWSmL9qBtGXBQ1YhWP3oRSBws3Y8iOt
	+TUn6wWmE4bWfxF/rs9RL8ispUhq4JjTkqxTqnh5FT5CighuLIRwW5ka1BqgkdFHdzF9i3TG+q8
	o/dBVk4Oln5UND62pxE4WeaAtI9/zKTRTNI+FaWrVigZgTPnKeLZJHmjtIf9WTOWcW6NvsgOtZE
	4WxxRG7AVWw26EVVwAfNunBoHx
X-Google-Smtp-Source: AGHT+IEvP86cY7yqRteeGdKTgVq05jUy5Tvy6vOVtS0TVWn69340n5r6kUjaD3Zu8ZCRXeDCTu/QjA==
X-Received: by 2002:a17:903:2f86:b0:272:a900:c42b with SMTP id d9443c01a7336-290caf85185mr300640585ad.31.1761170692810;
        Wed, 22 Oct 2025 15:04:52 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda72ddsm1605075ad.6.2025.10.22.15.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:04:52 -0700 (PDT)
Message-ID: <93e428555500f60c3dbcb04b79807d3ffce024c5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add ABBCCA case for
 rqspinlock stress test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Wed, 22 Oct 2025 15:04:51 -0700
In-Reply-To: <20251022175402.211176-1-memxor@gmail.com>
References: <20251022175402.211176-1-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 17:54 +0000, Kumar Kartikeya Dwivedi wrote:
> Introduce a new mode for the rqspinlock stress test that exercises a
> deadlock that won't be detected by the AA and ABBA checks, such that we
> always reliably trigger the timeout fallback. We need 4 CPUs for this
> particular case, as CPU 0 is untouched, and three participant CPUs for
> triggering the ABBCCA case.
>=20
> Refactor the lock acquisition paths in the module to better reflect the
> three modes and choose the right lock depending on the context.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

The overhaul makes sense to me and the code is easy to follow.
The only nit I have is that test does not fail if deadlock is not detected.
E.g. if I remove raw_res_spin_unlock_irqrestore() call in nmi_cb(),
there are stall splats in dmesg, but test harness reports success.
I suggest adding some signal that all kthreads terminated successfully.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

