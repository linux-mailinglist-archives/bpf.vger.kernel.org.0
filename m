Return-Path: <bpf+bounces-76197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A23CA9AE2
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 01:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCD15300EA30
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF8450FE;
	Sat,  6 Dec 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzLwRL+F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790520311
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979916; cv=none; b=OqG8ccejCgtxnWBFmQlI8BfvsJzmcOH+SMQJ9bQYC552QBNevTI4BaN+V6tUYesCbZxESLBuOw2WB+O5LwNgKZtYufw/2pJTX5J9lJD2Rjsbzs34H6yIygQrAh+OesODYtecsYrrLR1Ip0iY2G5TF4cNOxEa99bT1xVz7Fx5ypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979916; c=relaxed/simple;
	bh=AxjmDP2VstXUH+wRAi76kcNSV0QT5veifRqlBm31Upg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3n3YHACvMiGGu89KRmxTRkgoS9egHn5NRyNq6bVEVHfvWHh8E5iGMO49I+3VwYeL2G4mPUuvt00Qo9rstW2QutjbHJ6gS4etEpknjoBBJdZZusOzV07ShxYVOHeVe4Lc+aOM7gL9jQWvr6kyi0cGDLDysDivKnk+5CBEQZ8vSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzLwRL+F; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so2629321a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 16:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764979914; x=1765584714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us8q81MN+gX88qnHSf2jH6cxEjrcXxpkRxHshLcyBuk=;
        b=kzLwRL+F7CnYSKPR8W2uH2gNidb2PPJVSBni7ZUprMJ8Yd+2MQdqj1gJOTsWdVqSkE
         etz1R8Hc34pi7fWRdsi/86g9LE2c5vsQ4vFJY/Ci9zRbxuG/RaSfLA33A4nc92/4kmCF
         8CWs8FIGQuytBxDKVVBR0CxhrKnGQJtX15SDzMdgeRKcPe4YM5SN52N9AlGlRCItCCVf
         udmS88SMUSk//O0ETV4mdmqkYV0bE0uf0mxqjxDPj/4DIZNNyAzq2gR4VHyVYPKVjZJP
         wd1HvMEsP1np+chVvSnZWvOvm88lV1iWGmjS0s14Ns0yIrYLevd5Uep7QNOalxMLW/Mz
         qGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764979914; x=1765584714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Us8q81MN+gX88qnHSf2jH6cxEjrcXxpkRxHshLcyBuk=;
        b=Pz+FbpTUc5XA4j4fq8kxhn9/FOqSo3Y+KNUyMbZMv7S9EYtD9YfAcGLT4woM0jajoe
         51m9Dz/j13PuTkV+/2fW8Pw3KLJ95dpJP8/gRhPlCBJxmWDnEEzoT0aBEamVW7MjjOA6
         3PCPDjri/onr+gtni4bUdsJTmVwy/lxY4Qco7jnyIdXkClX2KtYOlA+Syf1/4jNnkHwV
         qBIX5eoIDwqPNfO4rkWZ5r/bSHXFv2z1AGqTZ6WY9I71XG86atZQjJDG0H9gYEQviwcK
         aQYtK6w7RwPZsa9yS4PiBJb1w/OdAbfAyNbU40uENu7Ae228auxV5a+/mPuqL2X+ue/W
         nUfg==
X-Gm-Message-State: AOJu0Yzg1fscU3CSNFxe5Dvj7lY8l35oAO6wpGf5UFX5nLHlKOY6WOAd
	JL9QeV44+CSjmca3hO/1wRYDh7L2qr9Gr3HWM7BUnGxfs1PV1r63vARyUbvJr3KIaQQlmheDz81
	9IQg0hb21QchSTu8SMrEddKDnvPzbNAo=
X-Gm-Gg: ASbGncukoacZCWSXDYzWkYnkD9wCNMf7wrNyeRYDnZIkk2dScwyqHSrQmxOV8nBR6Vl
	bcDbb2e+eHhbovqqLjWYm6A0BhOzoPdKAi5Am2UGW1fbPxldEtzG+ZkufmHBOFXf50pEOlS8sjc
	1JxY8lYnutzRp9WCMfOd7mtJ9CbmTuNIJ8o1cbianINTfueoPV119VSpxYpTi6KVgkkORyTt4F9
	nW7ObcLrvEo33+r3uen+hcVfU1ON1egQCni6+7Jr8IvUIORT/YThTFUbVguTXHlQlF9WDqTahna
	/LTpnKglQ4M=
X-Google-Smtp-Source: AGHT+IGdNcmi/XOq9lJ5sxXw7jVMzz2PWPyN+Nzo1bVpnI5/C1SGjrH+5Lb6eo10vv5nPeFlusEFf80Pi1cT+j/JVN8=
X-Received: by 2002:a17:90b:28d0:b0:340:f05a:3ecb with SMTP id
 98e67ed59e1d1-349a25e61ecmr575558a91.28.1764979914171; Fri, 05 Dec 2025
 16:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203162625.13152-1-emil@etsalapatis.com>
In-Reply-To: <20251203162625.13152-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 16:11:39 -0800
X-Gm-Features: AWmQ_bnPni6bPrBFvAxzXMPrEi-yBZVhmVLd6vtSjthAHPpZ4xFbwQjWrG_lEzI
Message-ID: <CAEf4BzZ_x9aeOFKS0POGAUVD1nZD4yKif7MWt3kX+vJs3WgmvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] libbpf: move arena variables out of the zero
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 8:26=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Modify libbpf to place arena globals in a small offset inside the arena
> mapping instead of the very beginning. This allows programs to leave

Description is now out of sync with the actual approach?


> the "zero page" of the arena unmapped, so that NULL arena pointer
> dereferences trigger a page fault and associated backtrace in BPF streams=
.
> In contrast, the current policy of placing global data in the zero pages
> means that NULL dereferences silently corrupt global data, e.g, arena
> qspinlock state. This makes arena bugs more difficult to debug.
>
> The patchset adds code to libbpf to move global arena data to the end of
> the arena. At load time, libbpf adjusts each symbol's location within
> the arena to point to the right location in the arena. The patchset
> also adjusts the arena skeleton pointer to point to the arena globals,
> now that they are not in the beginning of the arena region.
>
> CHANGESET
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> v1->v2: (https://lore.kernel.org/bpf/20251118030058.162967-1-emil@etsalap=
atis.com)
>
> - Moved globals to the end of the mapping: (Andrii)
>         - Removed extra parameter for offset and parameter picking logic
>         - Removed padding in the skeleton
>         - Removed additional libbpf call
> - Added Reviewed-by from Eduard on patch 1
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Emil Tsalapatis (4):
>   selftests/bpf: explicitly account for globals in verifier_arena_large
>   bpf/verifier: do not limit maximum direct offset into arena map
>   libbpf: move arena globals to the end of the arena
>   selftests/bpf: add tests for the arena offset of globals
>
>  kernel/bpf/verifier.c                         |  8 +--
>  tools/lib/bpf/libbpf.c                        | 19 ++++--
>  .../selftests/bpf/prog_tests/verifier.c       |  4 ++
>  .../bpf/progs/verifier_arena_globals1.c       | 58 +++++++++++++++++++
>  .../bpf/progs/verifier_arena_globals2.c       | 49 ++++++++++++++++
>  .../bpf/progs/verifier_arena_large.c          | 21 +++++--
>  6 files changed, 147 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_glob=
als1.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_glob=
als2.c
>
> --
> 2.49.0
>

