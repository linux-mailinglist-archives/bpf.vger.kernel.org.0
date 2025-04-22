Return-Path: <bpf+bounces-56464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC43A97B3A
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F59189DFB4
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0EA21C179;
	Tue, 22 Apr 2025 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoWQVisN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116921C176;
	Tue, 22 Apr 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365713; cv=none; b=q6arfVlodiloEvIse+21DvejKzrpvGfcCbb6w+tbxMXNj+LdQg23S9H9P6tjt++NepqWQXlocikbGp+SRZuVeb1KWsao9kBU2sa3vPZQKHGyDMl//3dXSEiV6sx3STdPn5Z2Kt+ljkaAIqypTmGwzeCUp3EQgycKUB3gY+amO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365713; c=relaxed/simple;
	bh=O6mAv6ifp9X0QBL6dEs1CrXtSoPxPRuE19/CKtNagmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftmLvbqHNWbd3fKe3E2S9iHPM1XKOwz42qlu/fUBR1XHWZTDQAacoXNgG/R89z2smq0SvC/EWeUlapNAF3U5pugYDLY9FhjG/mYPON40WJXDOZqNx8d2r0he2mpTGQTxdQfYGyIOLy/k1kqh1NKxnNath9H2tfp/gnER7b6q1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoWQVisN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-306b78ae2d1so4637852a91.3;
        Tue, 22 Apr 2025 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745365711; x=1745970511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GyEww2Ss/PfF8uYlDoiHPB7h0OHExkiJN3If+wg1Bo=;
        b=DoWQVisNXzg6HvohJO3mhaeWyCFZxtX8ckph0xmO167FRca/tdbFYLsTjepJufWViu
         3vhfWpicyEZ1QvFAuUdWSzqO/TdHDUAn7FU32VGrBWb9UUpAjgh5iN4CnPONjdiKwAu8
         Yu5EQNQAx9Q6EaJ5x8LtwCxzqeZ/zsdRV6CTyP+Df6luupb58gqXb6d/f/Igkb73GTYU
         LQy/yrj1ejWKASuQ8+4zxd2V3bEAYIoMGNX7hATcyipT0DJAlGpipCbpY+8TQnQ0lwd3
         IPa1/2BS3kMo8qJ1mMdMz7cAJIMBiRXf5RNxudvhkqTPsmRZEmfGQ2Odb3zXy676+hcA
         QbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365711; x=1745970511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GyEww2Ss/PfF8uYlDoiHPB7h0OHExkiJN3If+wg1Bo=;
        b=LeVa0rtAaIwpwFEhFYVuXNj3ExxdSFxidsgj3tdl0Zaas9MEIj47tkT3oSXvM5nAVI
         q2eToTPnkZtc4PBI8Wh3KNqG5AquW1If9vf1XUXN4eU/rBWxqIIMebmtus1uEECXW6hL
         M+t04O4d7MpANVTpNHfJynvmUd4u3yH2eiTfAMv2/EDB1x3825jWyMzkvZDC0IViL6IN
         gzermx2r7ZgTzbZaIbliqa1g2gfcnm/dOtOa30ZLBZhI5d1fuJnESoFltuc4SjefJ1Au
         MAriBQwBrrZ8H8XWf/S8PurSWd3xcWmSnZqI0avLwdKm+6PbTVZTyUvjOlSd3MViyHwO
         faWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgTYen7argvLF/8iSa6+5SzxoMCLkUcgrqidzTXEgsHKaRRfe1wA2xZAlf0YGNSSQtSlQ=@vger.kernel.org, AJvYcCWoNanordgkTXbQvSl9iiZmnmrgsO+O7Q9BcqQ/ya7swavI2FeCZEBZWp1ws6QJnfk2M8htl6qyeeZ2GiKs@vger.kernel.org, AJvYcCXLL1YbG+jITVgwDCVhsW43EJvhEPjMJZ3b2kOyhXY7VMVzPWPIoD3nlfheedwkgoYJW8nLykcO0+KrZgJ2p1LZOdEV@vger.kernel.org
X-Gm-Message-State: AOJu0YywTMnagS9sDYQ/aagHKCLod59Cm1s+ZWcn2ux0u7rE5/6TXNYw
	knZbXpFf1b2r2dqCLx2uv/Bfd2PHCtIAfHgKc3yW/kkVpqI8UMKCDxt/AVaZ75fDUiRhhhl9p6a
	Z/WiiUsAfLsBcIGSk6/InMipvDFE=
X-Gm-Gg: ASbGnctBSvNhcuzThgLHHSCmhG7ooqNAoDCQiyNDBPhTQgtVsih+Yr4WJolb/20dZW/
	T2ILJjiS8XATxuOGe/OZyKecASHsKpvKPWqbnJf9uwOLT0+JhhGnQ5Tp4Bb03IeY4WsHdTV8YTQ
	X8ssV+Z653rqEuLmRQJUTl81PFuLvDgfaJ9OKIGQ==
X-Google-Smtp-Source: AGHT+IHURaMcxvopFeNZ1Zl/jsjQeK0UDSBJ+gPJZohjrjYJK1fbwtQ/dsNOUD7Z38+i/PMC27/6najHtrGxjm/FgBM=
X-Received: by 2002:a17:90a:dfc5:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-3087bb6bcaamr24531723a91.21.1745365711458; Tue, 22 Apr 2025
 16:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-6-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 16:48:14 -0700
X-Gm-Features: ATxdqUEMo0_fA58o4v09I-sv2UgVEm5CJQx06RmTe1s2Rm3JMF3nLPbpEyU3xrk
Message-ID: <CAEf4BzZxMxK3KO91jn5M--+=2QerNJZic8xFTYir04SGs6DZGQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 05/22] uprobes: Add nbytes argument to uprobe_write
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:45=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding nbytes argument to uprobe_write and related functions as
> preparation for writing whole instructions in following changes.
>
> Also renaming opcode arguments to insn, which seems to fit better.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  6 +++---
>  kernel/events/uprobes.c | 27 ++++++++++++++-------------
>  2 files changed, 17 insertions(+), 16 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

