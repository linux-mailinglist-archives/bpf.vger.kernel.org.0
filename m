Return-Path: <bpf+bounces-78834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA51D1C48D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E07E3006474
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91B2D77E9;
	Wed, 14 Jan 2026 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAB1By9f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EF284896
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362135; cv=none; b=nXVPYx4OiasOeDkIcLSqJqYQk8EYOf37EhEold5ph495reYLPLXoqjhBZ0tNr2Wayid/gkN546wWjpoPutayiBWVIg40AYALOSUKX+vVNMxr+ElCOnngid7SzIbTifLiuMKJLwp5u96b0tIdrWHNfCtEb8EG2lvXKrBsaDagOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362135; c=relaxed/simple;
	bh=6hbicXXmERQ2Zwqv3mA84pqzJuKeBjHJ7zWItYtxOog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsazb+M/CBrYlsCHJjRaQuPVmAOAHcboe1G46LYiuXQeR221yFPJYZuGkiHVL/PHpFG0ylUgh13w90yFgkZkC5QCgOk2nAVF+usVPxyz771mpI5xDSWlCrtHGfzEtHRsN0UN/y9AUwCRcLGY95O1gFgQcZpyMSYeqW5VVLPe6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAB1By9f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43246af170aso236633f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 19:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768362132; x=1768966932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hbicXXmERQ2Zwqv3mA84pqzJuKeBjHJ7zWItYtxOog=;
        b=GAB1By9fREyxCbO0j10ZY8KtsHjHqYlKZEcnE/512bc8mCwEGLuuiExALoBZPb7cXb
         2KorLaoTcyaeeigIWOpceLKMyOogzIyy8/gvBgqIxc73RiDVpsh9laVe7Tchlzob07ve
         dDMjnlzfyQF6Ix7WjAelce5h5T4YmH9EB84P+axScZaxFjzaNV8BlkmiNbOK3v9pa/6z
         p0lwILqtjRpcEusULOyfbXalFXykvQEQinzYIqd5TO+UJff3z/NtQpWK/eoTefFreyva
         wm9wSBLAwu5cIyUH9fkAT7SYXixjZo/FXJ2gjQezQb/B0cMNIUZctjW0ReHmmXayKtY0
         EVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768362132; x=1768966932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6hbicXXmERQ2Zwqv3mA84pqzJuKeBjHJ7zWItYtxOog=;
        b=X67acWqnjLUe5EZMdWuwDvlbsSFwCpl4OL60BLRdmx8MSqSdZ3SoXVyM23fxLfPoOP
         fJXLeo4pJ7FMPR52Bzq8/ZKLDlXbb5O2m3hzXqiE52rxXYbTKnxACmZw5IPKvSChpdQp
         PPZasEIaHCX5h5ZnceFzm6GtuQ6QbbtE3pdIylE4gYzZDNS7KVMcYkrNg+ZrgBqtDVfG
         9hAswepHv3DsRbnteMK1pE15m4Cy0hVxyF01HT5efCqqya/Oo6Ki3UxnuWclhXIOruw9
         5OnSLvQ57KERDyPtwraUETwOOsRat1BDZhYXHqDt0lJdYinfjhvimpB/Psx26YkQWt5v
         TYhg==
X-Gm-Message-State: AOJu0Ywt/vcPBqWHcFddhp7PdBGTPXu9j6CqaVFuw9RWLkBR8Ir4nXEO
	3M/K7ral9JuS9xwzjIuOxOfKlIfphmQ8JXhOqN0GpcQrtZ9Em5aAfgHzul+nPvE6JDk9e/5ow+C
	sr0N/DhcmYoskIYvrkRGGvbpD/LFiHrs=
X-Gm-Gg: AY/fxX53Y7h3u2MXKcJ0EPf2AC7KhxH/Fg+D3OTXPBsEw0EP/8apXFQboSlcv04V3LM
	DXdaaH1ymT2RtvlyZF1EhyB/+xwfIIGcmugw++AGlC05VopjZXA3/lp3HCLrfSTPeqmypC6+kjd
	/cHxH/WYJEvFHTs4tITcjx12bhEsMvzmOkV1MBDp9tiZEsvQhLNoxxzSd55dkcleNSYoWASVOY+
	qmbrxvX2q8MJ2OB6XLgHEaShiBKhss3FFwXEX90hiBaVA1Ecy8PdzgEDrFQ3GwddViqQOrwxVmG
	ssH+6oQAPSd1gfeiUvIOk7O4U+bM
X-Received: by 2002:a05:6000:1889:b0:42b:2a41:f20 with SMTP id
 ffacd0b85a97d-4342c0d5d5emr1155789f8f.18.1768362132237; Tue, 13 Jan 2026
 19:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111153047.8388-1-a.s.protopopov@gmail.com> <20260111153047.8388-2-a.s.protopopov@gmail.com>
In-Reply-To: <20260111153047.8388-2-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 19:42:01 -0800
X-Gm-Features: AZwV_QiyyGUGT0UFZyZuOWk9InMn-ccznBBEMeekNGLZkpb5rje0Fp_0Vf9xpVk
Message-ID: <CAADnVQ+6aByMvKttzhMWSSHM=mwiZnAd9CLVE1beHoC2o1xvrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: insn array: return proper address for
 non-zero offsets
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 7:23=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> The map_direct_value_addr() function of the instruction
> array map incorrectly adds offset to the resulting address.
> This is a bug, because later the resolve_pseudo_ldimm64()
> function adds the offset. Fix it. Corresponding selftests
> are added in a consequent commit.
>
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

Applied and tweaked the subject line of all 3 patches.
Please see what I did and don't invent new prefixes.
bpf, libbpf, selftest/bpf, bpftool, and "bpf, x86/arm64:"
are the only categories.
If you see others, maintainers were too lazy to do fixups.

