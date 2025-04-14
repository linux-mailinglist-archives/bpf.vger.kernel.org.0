Return-Path: <bpf+bounces-55900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15481A88E22
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC963B3472
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D71F3BA9;
	Mon, 14 Apr 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FZH8HNr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A671CAA6D
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667004; cv=none; b=p2K6btUHtCCi0/GFXx1Rr7T79knhqcplQ3pYlfylTAY5+4tPaB7bKbh85ItASRAkmo530A75FeHoEHqYsMnZC9lhZHR8J5nG1QMaEG2BoYJ6KvEZf8aYjewzpG8Bo48bTm42dEsL5Rzk18gJ8y4OHvpbwm9MXnoKN+5npUSuPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667004; c=relaxed/simple;
	bh=jliqBof10kGvn2stsr88DwEv0qVbyZTOfc56zdJieWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX4S0uoD9Rjf0D/P3yBVQf2V1MwMjdvbbQUFuh1e/VU77RduQvZOQQDI3jLP+inzDuqAnQ/mpt8RJCoF4cBWU5mKWlFAdE/7ca1t18Nmbp9JUpTG5FrPjn+sJ9ZC1z74Mu7YEa/1iusOU8B85tgYr49QL4aqbIJ8vAGarw6n6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FZH8HNr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so4354a12.0
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667001; x=1745271801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jliqBof10kGvn2stsr88DwEv0qVbyZTOfc56zdJieWM=;
        b=2FZH8HNrRwKF0Ec9G6GLKq9ogdas+SdEh7a93+WPeHqbpL4UK7AuztL4wtRsLzbOcM
         fIjvbjpK0hFLy+m3JokuCgUklhXxT8pLgJjkfml2vWYNFAi8TLONlc/P9G/d8CGSdra+
         rF1BeUoQmKQX6VbJ4PRLKVsl277p0c3+n0FyaDfj/0P0/73nMhKGABq16ORzOjtoxTJA
         r+xe8AFop/GABYYsP796W64kPAC5LtiFsG87oDd3hnHHOs4fClBG4UbCytQ75m7wVjiY
         qTpQgLe5sOxyY1fQiHYUezEhHmieBP/BemwdcorU0TqtLtUSbrnNmiZCIYEc9nkORmgs
         wZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667001; x=1745271801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jliqBof10kGvn2stsr88DwEv0qVbyZTOfc56zdJieWM=;
        b=W2Y0YesgsQVFdnaTUYlW48hUiS5cObykwmTG1+SnY1YisOB4zEY92Qs8iIsPKt9sUe
         ZybkQ48Vixh61mWkZ0O1pjDiIPgIP8I6tFg/OYhLCGtZCKj+nHMhvqRd5oslO2k6fUtJ
         C8Q/Rwy/lDkkX4KaZLfxoFW0wDNZKhFrwMCqblIMsp8eMr7gyJTgomY+omSBqk/NOsYm
         W9FcD13x23zZTbrPQSNlpi4xxAXFB+3vbnCoPievNmdBGrkGV6lq2kXWPwgjOJm1PZ8h
         h5OpyZX6+ncWW01M4+56eU0nGfh1rbryVvpiBt+yEEJNSoeBsp5GNS7mxykjj2mqM+eG
         3xyA==
X-Forwarded-Encrypted: i=1; AJvYcCU3ccTbAQonbwBLa4QpymAGZRqcupqa0/rkjNJeVVQUEerQA1G0c5e3CkSKtV1M3cZ7Xzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLlhZYnZBaPx7lbDObNkmkRoQMHW3q3jJAzM5sX1FUrEyyQ/i
	monjnDpnIm7gm/RGyL51p1KUTvdK5QLfJN1Rh3zL8Z56j015Y3cw4hXHDehjA0ni+zDUHV5YenF
	caf78yywQIQaxg5/DJL9dpmdJRr9LPuDV3DtS
X-Gm-Gg: ASbGncudQBsP/72mH+iDC2InbWaw5YszHHycmVBKE0k2wrIJ+1Xnk/5SeKxURtdlNq5
	LggakJFm1dHDV7mi187NOdcNRnO+5O68W21IniPTk/zpMmDrNKo5scX141k2n54XTf+b/2nPs7F
	OWz/GNcPXRX0XnprzYNobTsoZXV7xO4w==
X-Google-Smtp-Source: AGHT+IF5jEV8t9GKXR37hi1efKrfDy4gSlcsUnWqdZfoa8G3x5RlMK5uNSj4O9wpiMQjxd5mc1NgLS1WEEc6drcdrik=
X-Received: by 2002:a05:6402:1cac:b0:5de:c832:89ad with SMTP id
 4fb4d7f45d1cf-5f461612fcemr15338a12.6.1744667000732; Mon, 14 Apr 2025
 14:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310222942.1988975-5-samitolvanen@google.com> <1744624410-471661-1-git-send-email-huangdao1@oppo.com>
In-Reply-To: <1744624410-471661-1-git-send-email-huangdao1@oppo.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 14 Apr 2025 14:42:44 -0700
X-Gm-Features: ATxdqUF8Q8A-bzpJY7EigqAvtM5EQ-PQqm5e98cbBX9TPkbAF9oeXUHfstec0l4
Message-ID: <CABCJKufDbYVAMi23aF=+daNkZa-8YHOoZfnLGtZ4qCG3EzJtCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/2] cfi: add C CFI type macro
To: Dao Huang <huangdao1@oppo.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	catalin.marinas@arm.com, daniel@iogearbox.net, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mbland@motorola.com, puranjay12@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 14, 2025 at 2:54=E2=80=AFAM Dao Huang <huangdao1@oppo.com> wrot=
e:
>
> we oppo team have tested this patch on Mediatek DX-5(arm64)
> with a kernel based on android-16(kernel-6.12). It has been running
> fine for a week on both machines.

Great, thanks for testing! Can we add your Tested-by tag to the patches?

Sami

