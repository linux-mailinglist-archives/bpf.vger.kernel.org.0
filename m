Return-Path: <bpf+bounces-72168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB76C083FF
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 00:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4591AA202A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89E309F03;
	Fri, 24 Oct 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM7oMOxx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D52FFF8E
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345293; cv=none; b=DBNH4Gm/x/GEIqhHHNDnml1mxz/Zx7x8MKm4mW8QmLVlzc0U18sKSheellWG+rVeLnaC+W98qfLB3zlbrLyINRWPFmMYAP4ozJRD2eXaFv7D6KrMsbkv7kArS7Hp9uTL40WH6lUPHPTn0zVXbqe2BYp6LzO/j+6qaOeEHPIizzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345293; c=relaxed/simple;
	bh=/1lCqzDVfSqKcHOVvqPIUIhFwtXQWPe83gIVdwmBx9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuWR+Gvn0e5HtRGHQ6jrtsxuSVbgZ5spuUXa65QwKAUpjYrxVQ9hAxoR0jfjB1qY/P2PyRFDSUvj+jgr55P+yufivahgh7STaLXLMs5+zhy6pMq9McH1wpIaxnkA//d1m3xgEUIGhfJGlTDNx/necJIRKzlPzQSHGjPzjwa+X0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM7oMOxx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so2581217f8f.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761345289; x=1761950089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgWMmy8jJ+GexnEc4sqtdfOGQCxpNGU9Ux5BrjtS6oA=;
        b=QM7oMOxx7+3JP6Nos+OzBy89rmsvVBDDAlUa0JFbnArfTFZL2DDCv1KUIX4vX0Pimi
         vzBdvKazoTSpfZammXUIh8SXdc4IbR2Zl8iUUVBBhphmIxQS/7IBQSeH6TFvbW8rmbfP
         5BoKYpS/FSMSNPUnY03GlDqxKIVwogaN1VgozobpWrZ+f84NkrSmyngCH6R5nA0Iybjt
         I8iYGj0mBAUftxTJvNg64s4gQ1X0FENWzt7SkwFvC+OTAqE6YHMz6zxYA6pcPd2cWM6d
         h5fLopTIvEOGsV89M6Bx6D1HnGd6LncOMSZFXmz7ivyBXW5we6XydkH5MHHq4q4nqpFV
         omSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761345289; x=1761950089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgWMmy8jJ+GexnEc4sqtdfOGQCxpNGU9Ux5BrjtS6oA=;
        b=JO7j5yzwv6tr9wNo0YwTZoX0Dfs/zYFjMOvhFEDUueQl2YIu9Yf3C9/cFuqfs7Dqs3
         FA50ztvTnyJrZc/E3ZweY6i8vULmXiddLq0LVDtlP0k12Yq1mDVPqfu5pLJSJuZik+ZV
         e5lXYRVEBFPAB5a1indNzx2mVCyDE9PeikuRwHYvkzNlljkcO8t1PWB2dR4uch7IZDm1
         QsO2L+SkEjvU4yUR8C1NaCA/FinoUstwlOT9nT7XR9b2Gcorrzdh1QW0pPyptgXLOy1p
         hywBSno+fnA0OKs8i+P/TkqqmOw0I862AbSeDPgkDvyDMCZ8ThdajA7YZsv0RmpLk+df
         WZMw==
X-Forwarded-Encrypted: i=1; AJvYcCWtVo+m+P/kw8BtIC6aF9sLAg0ggeBz1/U0HfScHzV25sPirM31HfBXGFvp2+Kbc/B6XwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5so34+as6JrzGSH0odYqhvDppU6IVgGQh1u8CQa5Bljt6o9EQ
	9IZo1eyy3NTdi+U334H4DBfXs8XENC80dy2fk/3uxxngSFlzJ+I2WKbrk06Wq8T6VSzitdAFkIY
	aWAHDK7WlEeG7b35eQmKmCU9T1L4N+is=
X-Gm-Gg: ASbGncvoPpcr1gXqNOBQ/s92bQrpRFzI9uAsz3fjqNHkXnMrfGK6gYUoenX7Y2TUhAn
	kJfPWgHBFOp03pFv9SZX/426mZi/x1d4bjlgoqkBCjW2AMwdwR0sDFWMwmIMtK6+Y9kXRPrVigH
	ogv3NBQJQK+U97F9xIQke0DKIHUkGgPt649g5Qkhauotjvqrol4pEXdBQZi0DnrjETZPCS6HrJ3
	hsMn3STmm+s9IDn8Hu0ts6lyaYb1nVuLMm4cbGO/AGlfduou5AMyHdVO1s+zXK5KOvdCsyRcq+T
	6Q83NZHQYctoGeTsKz9u6DBPAhVX
X-Google-Smtp-Source: AGHT+IGVBqTo1Qga775DM3PeXJFOBVyycwfIPdw/nCiZHEmybAiqSl5amP9rqdkQHIC0hvV9j/gd2HZiroKhtTMd1Iw=
X-Received: by 2002:a05:6000:40c7:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-42708479e00mr22413715f8f.45.1761345289151; Fri, 24 Oct 2025
 15:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-3-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-3-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 15:34:37 -0700
X-Gm-Features: AWmQ_bm73zAZG0hwU9rfMl02lZ4uq3I2SSq2VpZGEnfSrxZZCZEFxDP-C90Ympo
Message-ID: <CAADnVQKYkMVmjMrRhsg29fgYKQU8=bDJW3ghTHLbmFHJPmdNxA@mail.gmail.com>
Subject: Re: [PATCH RFC 03/19] slub: remove CONFIG_SLUB_TINY specific code paths
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

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> CONFIG_SLUB_TINY minimizes the SLUB's memory overhead in multiple ways,
> mainly by avoiding percpu caching of slabs and objects. It also reduces
> code size by replacing some code paths with simplified ones through
> ifdefs, but the benefits of that are smaller and would complicate the
> upcoming changes.
>
> Thus remove these code paths and associated ifdefs and simplify the code
> base.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h |   2 --
>  mm/slub.c | 107 +++-----------------------------------------------------=
------
>  2 files changed, 4 insertions(+), 105 deletions(-)

Looks like it is removing most of it.
Just remove the whole thing. Do people care about keeping SLUB_TINY?

