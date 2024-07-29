Return-Path: <bpf+bounces-35901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9468B93FBF0
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3077FB21218
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A415A87C;
	Mon, 29 Jul 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIkNpI+e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D0148FE0
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272259; cv=none; b=mQjDl7AUWm642eDs2sRzG733HJG7Ilbam07K3vA3oP52usDD8U/SGQmRY+pcAE0AZAFkyV+O0VzCoKd4h1NNn3OtSPXzSr50QY4vhYAKSfRlW+pz3ARUC6fg/1aXrV3jXc1n5y/LAT7/0tuP5fboaeuTLDmQ/kdQPiZ8fIeyCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272259; c=relaxed/simple;
	bh=2zUZFG2f84o6sNKu/3go7HffEdyYUToXbHI3tdtq1BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao9ZKnoof5qGC68+dfSWtniO5/3Fbm7OQ8fTYUDlquKONvpuQeY5jSTeWnC6MGGnPjgIV3czAHR2/oCE+Fv9FHmYTAn3KZNSGD8qRoSmow1Fka5EcYXAVAkIgah9VOqvRAMMD+MiRUTdrQ0iJYyT1Lgrbx4mrzK1B7cvt+1NOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIkNpI+e; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso2705252a91.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722272257; x=1722877057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zUZFG2f84o6sNKu/3go7HffEdyYUToXbHI3tdtq1BA=;
        b=VIkNpI+eIZh0VcESbR3gcIMY6i9opKcpe3JZAUX95GjM4fLBPFks/OGWeDr12+Dxsy
         lco6hbkodnalwQlL93OLCxvJxXBGuG5Axtk7htccUDrZSIw75y9F51FlyPMLEIfeABUe
         ZeqrnBc6AOt+V2q/duOAPfWoyZcRPnUsLNaXA1aeIYvpZDl5ZkbI2/QY4Wr85/qaj/im
         z/W5lCyLT3apww2EFfiFMZguzkQH8KfbaEXmsI2+q2xMsALy+52A3GAJ/rG6xb9QBWxS
         Co3fWt89c/WoW1Gobzlyh3c+2lY8IqozHQ1hg/MTQO9qQErBdh3LKL9L+fQbupoISxZ8
         hq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272257; x=1722877057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zUZFG2f84o6sNKu/3go7HffEdyYUToXbHI3tdtq1BA=;
        b=p1W1BVQleziYzMK7bvJpuMciluBvsDzueQrARhcjraoupr+5vC4URX/E6q6Vze5ymB
         skckNt4JXCUgajUWia5oIlhaapp4+Sj8QOD1YlZOuRV/Dmx7imAL4NROsUHuJlLwf5xW
         oNTn/U6nNRFJL+V5/o9JtOCPbrKG1V8yFuyhbk/WytAPcWcGujI3LiwDud5RE3I8+Z0J
         stP3/uAmsJD6MDFYSsnUpINjGA0LAsciVY7grhNQNQqkMXiRZL5V144tBBXp/XY+GnEc
         xa+l1bA/5ryp7ab/Ol5bSC1N4OtfB7+hMSvNvRZkWbSs4x1Rn0XIJWiY9/X7AGoXGZbE
         WQuA==
X-Forwarded-Encrypted: i=1; AJvYcCX1vn71Ea8euUifvk3Ko4j9EcoTAtc1DFNaaH9g0PDG1QrgzD3xyK3aDcMYRMG498pVvH/WkxKBeAqXfTwVxH0TcFUn
X-Gm-Message-State: AOJu0YyHOr/MeBuzUZpJZPFZ6PVeQhZM13QRMPfgu9Kf0DeB5O08dd+k
	cQLjDE1rnndh30beOScXjsSplZPQQuP/s5RFS96TgBGZlwpnDMUiARkXweF/+l/C11l/kUel8KR
	kgUxTtxSTgn+OoyxhS6B56xXbGpEvDA==
X-Google-Smtp-Source: AGHT+IFoZBfuBvE9anAJU2bQ8AgwDiVO4Fly1G7+FGb8C1xyeqLKUXCUtilK59ZgzVZPMZpP/ww9M370qO8o9V4GHQo=
X-Received: by 2002:a17:90a:ae17:b0:2cf:28c1:4cc2 with SMTP id
 98e67ed59e1d1-2cf7e1ac75cmr10052230a91.3.1722272257650; Mon, 29 Jul 2024
 09:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-8-andrii@kernel.org>
 <CAG48ez0p-oH6VCv38NYyBq1g4URu6Tntj0B7Moz6Cmpr=vy5PQ@mail.gmail.com>
In-Reply-To: <CAG48ez0p-oH6VCv38NYyBq1g4URu6Tntj0B7Moz6Cmpr=vy5PQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 09:57:25 -0700
Message-ID: <CAEf4BzaDOywMi0mWd5EJ7cG4WiF2vMABTUGdzpu0HvPkBNZUig@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/10] lib/buildid: harden build ID parsing
 logic some more
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 9:16=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Jul 25, 2024 at 12:52=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > Harden build ID parsing logic some more, adding explicit READ_ONCE()
> > when fetching values that we then use to check correctness and various
> > note iteration invariants.
> >
> > Suggested-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> If I understand correctly, build ID parsing is already exposed to
> untrusted code since commit 88a16a130933 ("perf: Add build id data in
> mmap2 event"), which first landed in v5.12, right? Can you put fixes
> for parsing build IDs from untrusted memory at the start of your
> series with stable backport markers, so that we can fix this on
> existing systems? Or should this be fixed on existing stable trees
> with a separate stable-only fix?

Ok, I'll try to refactor to have fixes upfront before we do the
freader_fetch changes. If that turns out to be too convoluted, we can
think about separate stable-only fixes.

