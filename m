Return-Path: <bpf+bounces-57807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A32AB05F7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F361C22494
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F620E700;
	Thu,  8 May 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYl00fOd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935D35966
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743519; cv=none; b=rHbywVTsP8BboojSZqKrFb19Lu3o3NZ19bZqoXiQLKelI9ScIKPvq4mCn1pY3I5HNoQrCmfUP6sBtqUv2s/oEFHmISLS4/6q0OaNcFaC/daY+iSYslA0xJsbCRQNJ9Xl4ArGOBDZ91efO8dvInJJYkKPmhA5Kus/MM85KoDS4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743519; c=relaxed/simple;
	bh=7AF158Ru2PM8MzYTTESAjkvS58aDCnGUafam6MVBR8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcQCJuwr4eUpPbQPlKgDrgMIGhJGwz6cEszFE5iH7Dw5FkuSjToAIxLJFVX49zdNch3eSuYUgUugZBMCdXFD4RLKeWilV2aihpgO219i/YwXMuljl/dyBF7PDdjpr9XmWrJV7O99Adr56G4OPtm2GrqNnJ/dTujYblrlt4DHK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYl00fOd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so1268918f8f.2
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746743516; x=1747348316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AF158Ru2PM8MzYTTESAjkvS58aDCnGUafam6MVBR8Q=;
        b=IYl00fOdgVNP71ZKDZWwXe5srCytyWZuoq/XVmWX9ierXViARx1C/8u4v70k2FBp32
         IbOI+PP+8WZgnHwdUCZ6F4oBtbfslNaqSMHoCjmgLkqXbN0KFQsFEoecd76QhUJxBwH8
         bhoAyYyN4EWgGf2SH/4WJ6aAMRkyKOg9BwyrilYEZVZqjQ1Frcf+j6hTUGN3XfS3Xab6
         0tk32EicQ7QMpuKEiyxVekS9b5pfhxsSB8gtCNNf36UevMykVFqt89gqL5k0PlK2UcmC
         4v9bdH6OvjZke8deQLMx/9H2sGZcEdpiSdSo/avpOv7gmT5/0pBtyIAAxogEzszt1s6f
         eNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746743516; x=1747348316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AF158Ru2PM8MzYTTESAjkvS58aDCnGUafam6MVBR8Q=;
        b=IiWZ5R3XuUakr1b0AwQ2irU1PHicPZj310Tor5k8zHpLoSiZD0orPH9Sd1Vh+tWsrp
         FigEOuAI6/oyu0j4+3UxUnqtTzF+32aFkbvkXYQZGoFTOwi31GYhWMq2N3IJVNTB40CJ
         bpwWZCDSdbdUEknsECn0+i9sm7nyBPJzP6LiqCOdoTwu842ErSe4XisEpFoQsiDQaZ6R
         7Lgi+j87PYMy0s2h1aHZvuv7WqEEDa+ljtXKypEy8dQh/y0bOU4gRnxr4lNzxuJhe6P7
         5vXY5VUpC9NQ4ZnHjzp8vy215x8hwL9sSS3eU+ZC0ShTrynX+uexxpHxhRdgs4cH8ntH
         /q9w==
X-Gm-Message-State: AOJu0Yxv7jWz1/hswXwqWH87vpUWiDQpY/WC/8nnlIsLJ+ioKGk3iemy
	G5i7W4xlvDEpoTnBL6A/xUc7vn70bqT/pi484XVXaqYtGZFxohdLdgRLKN9oXnRvD6c8QjnHJrk
	afToG5mUSExgzmb3+7dqdDWtSGcc=
X-Gm-Gg: ASbGncuL2akn2zUTXaHmg48gGNPPp1kYnmj7ETH32KniKtHBiw4/kec/T3KWStPF3u7
	u1DLeJd3W6iC6UVjUMAYBNSsbGM3hcQ8MOVn9wurNe3y/HuxCZE+nXg+G+T5tiu+ITJ34lzUlag
	vrj31pHIQZM7YAIatSFGmWbnklFyGS9ld51mgp9umrSEzfZQTMSA==
X-Google-Smtp-Source: AGHT+IHxlqJZnUFavFPC1xi8aSVFCzFb0PzQTGMNhCcnLwddC0M8fSj0XWBP46QCi0L4xYBkGgIwmcgDHMu61dFY4Oo=
X-Received: by 2002:a05:6000:186f:b0:39f:fd4:aec7 with SMTP id
 ffacd0b85a97d-3a1f643a593mr994130f8f.7.1746743515807; Thu, 08 May 2025
 15:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aB0WvXLMx5DIivc-@mail.gmail.com>
In-Reply-To: <aB0WvXLMx5DIivc-@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 May 2025 15:31:44 -0700
X-Gm-Features: AX0GCFsT2FqdJTWIU8SA_UqPybaUsNFc7GkTSxuCArFvFQ5cQwsXJGmhsJQ_lDw
Message-ID: <CAADnVQK7m=B7qg_uWV_GguG7NA+H4Wk-Rz7XNckUw0fww8zW9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Always WARN_ONCE on verifier bugs
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:40=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.c=
om> wrote:
>
> Throughout the verifier's logic, there are multiple checks for
> inconsistent states that should never happen and would indicate a
> verifier bug. These bugs are typically logged in the verifier logs and
> sometimes preceded by a WARN_ONCE.
>
> This patch reworks these checks to consistently emit a verifier log AND
> a warning. The consistent use of WARN_ONCE should help fuzzers (ex.
> syzkaller) expose any situation where they are actually able to reach
> one of those buggy verifier states.

No. We cannot do it.
WARN_ONCE is for kernel level issues.
In some configs use panic_on_warn=3D1 too.
Whereas a verifier bug is contained within a verifier.
It will not bring the kernel down.
We should remove most of the existing WARN_ONCE instead.
Potentially replace them with pr_info_once().

pw-bot: cr

