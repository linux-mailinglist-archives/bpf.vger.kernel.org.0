Return-Path: <bpf+bounces-51862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9479A3A7F5
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16ED31889C25
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4117A2E9;
	Tue, 18 Feb 2025 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhEaCJLl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A617A2F8
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907962; cv=none; b=YwoZ8+8gZ+Nm9gMVsLkkMUFZlzoniipA01F18qpQX2UAWnrnK70BxKUz133CEV3bHQAXpj2FdvHJ5quReMslLA1YFe5HK30fewypZy5aTpg4nNmjravjjF8XVuCMST++HUQAf1S1ZuRylDCxQ0iE/pq10Ld4n9awmUAtnGISJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907962; c=relaxed/simple;
	bh=KwK2yHf+hYqrisrWgnf3awncfoL3FYu2KwQCsgDRT5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eilws1qYPE9bKiNkxNG6qXt8gPe0RyHX05AL593L5X1ymes4mhXADiYQwTgubLpO44iIIGk6/Y0BO5TLnPU37x4fOEL4fxgu4mujohc/NHo4iDUU9bAUG83fUobFzQyhWRI4z6E8yBbzrmNBmDk2QhHxfDKV+7bYV25BIn/RQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhEaCJLl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so41062415e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 11:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907959; x=1740512759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwK2yHf+hYqrisrWgnf3awncfoL3FYu2KwQCsgDRT5w=;
        b=YhEaCJLluceFKisqLihWLEKUR75I2qJ+gvuDhOObrL1qepyL3QyvrZwKuE0QoXCu3I
         l9pKGMFSNJ0no/DB5/PtObA8Ku/oRgY4bRkGF4p0YquoIOQ1JtuZQ1Cs6S33ls7E9MLX
         gB4dHUpyAasmFifCawaJlVNTV6o1xm326OmzAZKSDbR7EQjAO5CS6b8F0wRaOhJ/5FXI
         wpHr2B0VhAJGOHnporZIxgqIci5ReQzr6gD8PyhmOn8tsM6k1biCgoAZd/suAgw18Pyd
         nas4hZfJJegNtYLXsd+ZwxNUg0NMKK5JgyRsjF+/fCW1PdOAPwWOdmAuP1MCERjGsi0f
         k6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907959; x=1740512759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwK2yHf+hYqrisrWgnf3awncfoL3FYu2KwQCsgDRT5w=;
        b=oTn48lb0tiyhZRBdz5N+N2he8ZG3sRBBO5lrFkD35lkUKYE0bALXTe//giCuJQCFsi
         vJlWRHQVrtUzDHxqA49uN6sa0EP2dfcJOt1g7PnUXCeERUjAd7ZKHwBKPQHRT3/aazx+
         CCM9PeuejHfUS2oZKfFrGga5Xrs4OG526roGTX+lD+gZlte+QEhO6K7KDIJXSCczfxRb
         dY2O2WVCehnQH4iThF9bPu7SaC+CF7UJHOq60VRk37ZyDqFHsERwgZpv2gKPMw02fMB3
         6q6QqxPqeTRpywWLoMext8aG7lFpVGDIXIfl1DxCFQjnfERgeOu2ky6cWsnJUimtdPQA
         UBVw==
X-Gm-Message-State: AOJu0YzqvfkZCUncuiXRyg4lWRWVPwOriM3Qw7kwv/bjDPHoTlH6Lzxo
	tS4TYM35hCUsjtKMElif2za3FrvqD0CiPrLMHdj0CyOx3ii2XdBVQJjTiVNBgbG1wQmkYpJl3Gz
	9511w1xFdfy5OryNc59oHPDVOeENS5gI/
X-Gm-Gg: ASbGncu4hvhqYYNEMVsPqY7/09BA5uz38BvPyw6p/FQDJZr7Dqp90T91UoooLna6Yw1
	8QfeTm6EzBWRL/UlazoAXCkEz6ANFmA4GNNfGb2laOpJTDfDyeVyguBJWYLR1lnkZHFGgCKzZFZ
	NTMaGtetNeK1a1
X-Google-Smtp-Source: AGHT+IGrj8wV4WlRTXi5d+8QJJkUFtyDsES6kXmjUDl+uyrrGY/tud9uJC37yCQaxmGxcZnQ7JRcipuWsqKITkqgvzc=
X-Received: by 2002:a5d:64e6:0:b0:38d:d946:db15 with SMTP id
 ffacd0b85a97d-38f33f1186cmr15306075f8f.5.1739907958780; Tue, 18 Feb 2025
 11:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHdT9g2Y6eXR4VsjOGk8i3kPukpB4vt5fJyM=B_V5aUgazVhVw@mail.gmail.com>
In-Reply-To: <CAHdT9g2Y6eXR4VsjOGk8i3kPukpB4vt5fJyM=B_V5aUgazVhVw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Feb 2025 11:45:46 -0800
X-Gm-Features: AWEUYZl_LOKvjQATa_0jXFL2Q8xe4D2j3g1Cpndxawzf5pq6SFutpFi0oX_m7Sc
Message-ID: <CAADnVQLdRrgvBSwS6ff=KOXGcrpo4tBQ5iZ_TvVow=E9qoF=Ug@mail.gmail.com>
Subject: Re: Question about possible NULL dereference in linker.c
To: Egor Egor <xwooffie@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:19=E2=80=AFAM Egor Egor <xwooffie@gmail.com> wrot=
e:
>
> In this line we assume that dst_sec can be NULL:
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+/r=
efs/heads/master/tools/lib/bpf/linker.c#2160
>
> But after we use it without check:
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+/r=
efs/heads/master/tools/lib/bpf/linker.c#2167

Andrii,

back in commit faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
&& dst_sym)

should have been
&& dst_sec)

?

