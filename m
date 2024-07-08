Return-Path: <bpf+bounces-34158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F72492ABEA
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5361F2304E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6842F1509BE;
	Mon,  8 Jul 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2kHekMX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008E2D058
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476972; cv=none; b=aBhwcpiHbXKU6Jz6u64RjBEUb4X7Lr6jzVNZVQoS/ipkrsYe+BYQ4d8s6a5tbT6x1G75m65jidNUzf1s+MF4FZKog1zNQrBPTl1HEecygG3w7vvD+87tgwzklwUq44Oqfx8dad06fugJVLmbUkbL4oSk9abk2IdcgzDAf4Vp9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476972; c=relaxed/simple;
	bh=h6vq6ownG6HIDtryCrk+PoGOueJGzfS405DNiCfiatc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRnsXoZHwYWSm1qDV1NBDPuPAaVmqqmzuHJ4NI45W8hRiYr/H74X0u+ywzfX3lx7B3F+Q+cUwdP6TnJkc7mThTpvz8ICWw6Uepbdxhg8syTGF1jO+2Bcxcq/cwU3VEYa60jywyGe/Fj70P0fD0SjhOAqIwTO/yWwtF6NuxP5JZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2kHekMX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c9a8313984so2870215a91.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476971; x=1721081771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h6vq6ownG6HIDtryCrk+PoGOueJGzfS405DNiCfiatc=;
        b=l2kHekMX8CG4759UA21FF5pkibV9g5Kf9OcKqxxRRR3rLW+PAL1O20B2mqNVxh6cyZ
         nELvpVy+GQzFwIEdE3MuXnsXjhDGeh3fXjsLSyYTJ5SFKRxkRzvcnnXPxXxX/i5W1Ge3
         4Ha0Lh7OMXtbtqaYcL+v2GsRN26nSt6AfBLAU1fMJZzPChsmaGx/c0TKSNfGDspFpF9C
         S7xwzrILB4bGK7nAR6N2i3tfTocAlmDkvsYzZIOhQPhlOXofir3eXQuAJfTBJsX0mNql
         HOK6Umt2KwKdlMJOYuYit/0of3hSa5gFNgJq7hb5+LkfOC0z+emXa16AR05eIJbpcS7J
         TNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476971; x=1721081771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6vq6ownG6HIDtryCrk+PoGOueJGzfS405DNiCfiatc=;
        b=vXAG8kqwoVDVcSU8f9JzVTZDqmVpX+LQiZI+YoFIvFXCy6mV+1zlFD1p+V6rgPdXmR
         IS7imDLy9lnFb6e9bfZRCYG6VYzm2urU/ffEfTzmTMUPwzhGrojI7iVvS94h/32KBG2b
         tdeMsqi7mooHH22pmkppdXcJPZWWhlbJlJInNJ0NFUJS3oUXv7KSq97l8My2fI2hH4Ps
         arG+2IKPT60cq6mi4IE1/ODXTd0IdyGLQ6pINMsEIfRwVEAkcSmlvfCfZ2W1pLDQ4SRA
         /oc+tWtGH+TDB6DOlbqflrOLaDtl9+XQYrFzW8P/ZR5SPdHqogsFFefnlVHCHqmCUX97
         TGDw==
X-Forwarded-Encrypted: i=1; AJvYcCUqDqPyWNzv3kRStHqre2ZQo7831yHpRxFo1VCXF0mv+O0eIrqdU6u9ixVKDSAuQZxezaBQlsoIQU0kQOdk6OLRGvuN
X-Gm-Message-State: AOJu0YxDurLrzllARnNWkxnV0Ruji604hN3aTATYxH4BsY+rnO4xolqt
	uIxmJgCFdlsP97dJsRMIT3xrWjFQskXeRTRrdyyDTQK4CbFotbNQ
X-Google-Smtp-Source: AGHT+IEu8z1Lnqyq/4GSllnIRgMjgk86omlQObfsZMiYswf/hC0zq4hNVWiJ56RhOYxIRy9jYanUFQ==
X-Received: by 2002:a17:90a:ca87:b0:2c9:7ae1:8f62 with SMTP id 98e67ed59e1d1-2ca35d599e0mr772985a91.46.1720476970839;
        Mon, 08 Jul 2024 15:16:10 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aabab9dsm8657210a91.57.2024.07.08.15.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 15:16:10 -0700 (PDT)
Message-ID: <27f9c0ab24f06c4215f75fe12e05b26c24e43071.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpftool: improve skeleton backwards
 compat with old buggy libbpfs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Quentin Monnet <qmo@kernel.org>, Mykyta Yatsenko
	 <yatsenko@meta.com>
Date: Mon, 08 Jul 2024 15:16:05 -0700
In-Reply-To: <20240708204540.4188946-2-andrii@kernel.org>
References: <20240708204540.4188946-1-andrii@kernel.org>
	 <20240708204540.4188946-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 13:45 -0700, Andrii Nakryiko wrote:
> Old versions of libbpf don't handle varying sizes of bpf_map_skeleton
> struct correctly. As such, BPF skeleton generated by newest bpftool
> might not be compatible with older libbpf (though only when libbpf is
> used as a shared library), even though it, by design, should.
>=20
> Going forward libbpf will be fixed, plus we'll release bug fixed
> versions of relevant old libbpfs, but meanwhile try to mitigate from
> bpftool side by conservatively assuming older and smaller definition of
> bpf_map_skeleton, if possible. Meaning, if there are no struct_ops maps.
>=20
> If there are struct_ops, then presumably user would like to have
> auto-attaching logic and struct_ops map link placeholders, so use the
> full bpf_map_skeleton definition in that case.
>=20
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

