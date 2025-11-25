Return-Path: <bpf+bounces-75500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36624C874A1
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EB6F352163
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD3317710;
	Tue, 25 Nov 2025 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5YA/ABG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BDB27B34F
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764108729; cv=none; b=sB1wU6E/pLpsPwCqnrd4vIe+txWNeSuMfcQS8xQZnYn1XEOj13WiszWNd3YCHU5EP2KLCFRmoqROBAMuTbguzYEXC3KVlxxc++UdfQKoXdiaTAxm0tD2CjtsgkwIro6NiFfU8mehodiSLjkSCUB5CrFEvaNVxoUe7TwEp8ifX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764108729; c=relaxed/simple;
	bh=USUosGKJyxUUMjhG9pasUFVbD3SatilPUj3IJWhHKZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhBd4KmHBxUME6EG2cSJ7oaVtzpTefAiEqNQAD45vTnK9KF7luCxn0N55ihzZF0Wt4/Wb2aDEhVTBbDY6TMZrXGTOyrITdqxD2OWUjROngjlXu10eDIF9+LtGb7L5acKxEQRz70uPrLWB+BnFsApCBCiAlQg7UzcbJv7KRzqRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5YA/ABG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298144fb9bcso66845345ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764108727; x=1764713527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xALO4blbqHtPbrqYHVgRRo9GiQsXaiUcilm4rPPdVok=;
        b=K5YA/ABGw89w8gFmsd58gUXSsWab1+tNhmPaqkraaRyxmlXddvxThQ5F9iY4vnlSwc
         XpfnVHjncPHoAOVP7hcW38wP+NeKlTopUx2NdMUMX04yKqtZr7EFTl5rc+JAU7chCYGu
         giPEDwLcEsJkxU3RNqzbH8cu98i8Rd/xb6kd8SraAyOHu5gRQL1qpXvR5l+ohtMg+Wvb
         Q0X8FGD6LWEZ6VdwzVXQEBEHy+cv6qukbwMMWYdg5tOd0dDtI8nnJBpj/YmmaLYrFdNj
         DDD8NP2AtKYYISlSLXPrW+HcroPpl58c2d4xeBykZ+mgAlz+0cihxoAlHocemsbJ2uC1
         xGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764108727; x=1764713527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xALO4blbqHtPbrqYHVgRRo9GiQsXaiUcilm4rPPdVok=;
        b=gflJiVCqzYZ/E+p6nCyVtJ/pExyusJgIRwTG5FHbNWOjCvHho09SHwNv/pnTlYyF3A
         uXdpURj16qUjR+gARr9WDTGW/DZkzoDxqj8+vGaqXEn1k15LyChN2/jpQ7rdwWGnLNUZ
         Z4dzkDQFiDZrkxy++oVO/T7c5+lZ4+g0mwl2iiGVxfxCacKS+o/V/9GEBWmtY7hr6OtU
         VpvkcKNsSx39gJHLYaKTCAdce7+MIbxMgzzRg1ywLZZEfdimMTbMpHVLUaE17MgTRqrs
         kh9MEM7EWe87Xas/4ClHlLtrOFYQ8i6wKWnrptg86cLBBWuwPy/D+VDySOgPJuHKSxau
         AAvQ==
X-Gm-Message-State: AOJu0YyPmBcNvaU1MAaL2M4s0oAYpkrfq8mzhwN74fIfm6BQw9IzSvoF
	wT+EWK5zWfX9mKz6GneeE6/uFUF3aNvYZTwLTBrGwX+BBbhV/aBI/hs8aq5+4SNo/vxLErFJGZs
	pUX3WQNS+HaLNlMPpOQ3uI2IJo4I49m0=
X-Gm-Gg: ASbGnctaYkWO8OqD+d8e1VglBadprVAnrD1KbiMWJ7NlMSgYjjdPgRW5KX5z66a/bEU
	ti/X/WGz0eQcLC9gkwjjZsKYKrHLsW7oOI7D1rPSZ2eK2cAZ5FhT2NtEM5KLAngSJ4PTpAMJLq1
	VRzHaEiEnjjru4At3JbSSIvFn3QJ4Kz9h3bViYLhrmpQ5qEYqKmzJF/AC8b6yX2FuYubucbGJ10
	hDmFGdOkKnq38SdgX78oTw2YmCRcE5ZnKezeCNmkFwZIM77pW4jx86XQhCrd0JZLvuOfWPve5Xg
	g5I2HaS3BG4=
X-Google-Smtp-Source: AGHT+IGGlym0/CSAIfa9R/8xeaEt/8agvRKO/RpVdWct3keSEHVsPGtabkzVaTXYrVsdBvZHu5oa4tpb4z0GRKtglJM=
X-Received: by 2002:a17:903:298e:b0:297:f8d9:aad7 with SMTP id
 d9443c01a7336-29bab1c4637mr43258145ad.50.1764108727202; Tue, 25 Nov 2025
 14:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118030058.162967-1-emil@etsalapatis.com> <20251118030058.162967-4-emil@etsalapatis.com>
In-Reply-To: <20251118030058.162967-4-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 14:11:54 -0800
X-Gm-Features: AWmQ_bnz7N_OD3y19TLni6y4aX4xxFa81LKLmxcgcANRo8bnEPUpshtmqAxfQ4Y
Message-ID: <CAEf4BzZC_3D8__a_j+A9bBJaKoHXP0Z3V+vmoDkg5gmhFnm5PA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena if possible
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 7:01=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> Currently, libbpf places global arena data at the very beginning of
> the arena mapping. Stray NULL dereferences into the arena then find
> valid data and lead to silent corruption instead of causing an arena
> page fault. The data is placed in the mapping at load time, preventing
> us from reserving the region using bpf_arena_reserve_pages().
>
> Adjust the arena logic to attempt placing the data from an offset within
> the arena (currently 16 pages in) instead of the very beginning. If
> placing the data at an offset would lead to an allocation failure due
> to global data being as large as the entire arena, progressively reduce
> the offset down to 0 until placement succeeds.
>

I'm not a big fan of adding a single-purpose bpf_map__data_offset(),
tbh, and the whole "let's try to place it within the first 16 pages"
logic also looks a bit random...

Can't we just say that arena-based global variables are always placed
at the end of the arena? Obviously, page aligned all that stuff, so
it's deterministic and well-defined. Seems like we always expect
BPF_MAP_TYPE_ARENA arena explicitly defined in BPF object file with
max_entries set, so that should always work as expected?

And also, I don't think we need to change anything about skeleton
generation logic for the arena. That padding is not necessary, libbpf
should be able to point arena struct to the beginning of arena global
variables, no? As you implemented patch #2, it breaks backwards compat
for no good reason.

WDYT?

pw-bot: cr


> Adjust existing arena tests in the same commit to account for the new
> global data offset. New tests that explicitly consider the new feature
> are introduced in the next patch.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/lib/bpf/libbpf.c                        | 30 +++++++++++++++----
>  .../bpf/progs/verifier_arena_large.c          | 14 +++++++--
>  2 files changed, 37 insertions(+), 7 deletions(-)
>

[...]

