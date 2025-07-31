Return-Path: <bpf+bounces-64833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13163B1761E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EA1A821C7
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126C2459F0;
	Thu, 31 Jul 2025 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmwE7aFN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BDD189F5C;
	Thu, 31 Jul 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987146; cv=none; b=F2utgHN0SE3afn3+uOwIuTCrSsyj/1jjZE7qUj2Yr/1ZnRWB6BOBAAK/T/DHAiELPvhAN11eyOwIUWPOgFrx3AwbR510paSnBOS5wI7wZnYQPfsa7DClQNQS66kAOzTN5EMc6VT5GQLbv54ipuHQCzKWctLhUt7hzeBpXudNm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987146; c=relaxed/simple;
	bh=PxMcmEzVm3WDriTzl+CQSmXbbYSRZyP1GfHg/qIUeik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiR62j2PPghncFrX3DRQnTciQTCjRYocfKFHd2Y3evt66iB1ks01cI42oLLLt/uis5DGlaOn/ExdERTyZUf2dZ4vi++UYh3wXFE65tQL4DyJj2YvY7Z8opjQPep8QHuqSRMsA/ljPANDXfnR5qOzgdUw3wC/X+yYn9KqmcZcHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmwE7aFN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso13181975e9.2;
        Thu, 31 Jul 2025 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753987143; x=1754591943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdM/4c0BaGsTBzjmE3nYXMTVYUgF5F0VUqduP5rOLl4=;
        b=fmwE7aFNPTMtqmng0V2+cu0vjveNUA3p1cT2gTW6I+QgKnFnP2uFtu3ciHmawNZn7c
         p9sjvOijDAvxIOXRvaH7xCXu5FtbppMQdFA1SDjeAZqhwCQztZPJKR5PWElIn41htwZY
         EqoYAh3pILNu8Nh2csX1X0ILEkdMAlnr0WS3b2ul87O+Ywr2HiNS4h0WcvMcTMtlWVBK
         DXg+WZp/xNGxeAYOAmU8XN5RELbb2spUJhWW9M78J3WQGuY/lZW9IUhdV30ihDvmuhni
         Lzi+DSXU4dZCvslTh/k3AqQUUxvgD1bgG9pSdYf+K+suBeZaOrmC6cJ1C1XDZgXXGly7
         p/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987143; x=1754591943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdM/4c0BaGsTBzjmE3nYXMTVYUgF5F0VUqduP5rOLl4=;
        b=e4B6Gh0TQHpwyTCMt9jmSmTIR3TfVzkIx4yaicAAMwP0gcbOBsQYweGDPdtTAi4KCq
         jdNqPvpwF8chQzNIUcnVExmVrmi693osKJ7VcC/2XalatYd6swD8YLTXpXdmA3Ob82vI
         TRuk3DLwdN/BNc+B8r4Yit+s3CSL6Mon0d87SdRVLnscTDo4sw8XWk70DqlV+AOncJZW
         Zh5qDYjqmjozG36QcTMBEo2/B2qfrXVQbUBJX5Bm0DQTg/PIxhDEKXoc6Cn7abwHyOxe
         +inAeCJJzPOGadGJUZBOspEmbQVS6lrIIG/GoPP3v9fHBDy9VlqfvlZRTUN3ARpmYXca
         PBCg==
X-Forwarded-Encrypted: i=1; AJvYcCVqrsmNxOnJuh8zn6vsFM8brReST+VR0BjvGuQBvvAmW/UQon+e4kFtWf0qFITBBiA9pKxs7maYgn3iVw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5N1E+MLohyYXuZIudePlsmwNLeOoYAoyRIiCCgrqo6sL2i0hf
	1lAmNc5TZlwHfMm0yGoKanVuRrrQ85pHFHrUui01+wwfkCDhJ1WT7dsqxRUIBVmHBVcjhzYHVYf
	G/JD4D4U8Rrxu45PnJVoCop3Bvr7LYwc=
X-Gm-Gg: ASbGnct6ThZ67knHc0D0psm4jgYcRmj2WcRt3/DlV72piLLz0BvnDlDfkB08LSS+QJQ
	XcQJnl2uReltPVFI0yOF3cG2nXgElZxgOa+Dw1RpH7EuTMhX3j3G9HB0C1DJ4FZO/T+eauU18sd
	a5jtXglvYBBLYocDSuUE4pWBUzoqXVa8fEJjBTSRCpy4SrsVEjcE5EwdKRLAOVehD1c2909HX7r
	+UDY1IYEp6+CQcyDFAjhn4=
X-Google-Smtp-Source: AGHT+IFJL8NBAWQY02zy0tEAWl/qP3DrbLkDthNjpOnxX6jcZZ0At+S8eHNdcBVEIsN3QGpLJ1a9BHZMro9h9uBqIE8=
X-Received: by 2002:a05:6000:4312:b0:3b6:936:976c with SMTP id
 ffacd0b85a97d-3b794fecc6cmr6327698f8f.17.1753987142650; Thu, 31 Jul 2025
 11:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722205357.3347626-5-samitolvanen@google.com> <20250722205357.3347626-8-samitolvanen@google.com>
In-Reply-To: <20250722205357.3347626-8-samitolvanen@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 11:38:49 -0700
X-Gm-Features: Ac12FXw1CsiGw1xqnFICxDSaAwN-blfRuazTaEhPIwPWVxcnOPQAXUsIGCjRDVQ
Message-ID: <CAADnVQ+FeGjNAJFyvpF_POB8tZUMXDN3cz_oBFNZZS_jOMXSAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:54=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> From: Puranjay Mohan <puranjay12@gmail.com>
>
> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> calling BPF programs from this interface doesn't cause CFI warnings.
>
> When BPF programs are called directly from C: from BPF helpers or
> struct_ops, CFI warnings are generated.
>
> Implement proper CFI prologues for the BPF programs and callbacks and
> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> prologue when a struct_ops trampoline is being prepared.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Co-developed-by: Maxwell Bland <mbland@motorola.com>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Dao Huang <huangdao1@oppo.com>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/cfi.h  |  7 +++++++
>  arch/arm64/net/bpf_jit_comp.c | 30 +++++++++++++++++++++++++++---

Unfortunately there is a conflict. Please respin.

--
pw-bot: cr

