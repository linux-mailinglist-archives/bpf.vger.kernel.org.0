Return-Path: <bpf+bounces-35257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E039393C7
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4F28157C
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379E171651;
	Mon, 22 Jul 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew7Xgm2z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED009171677
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673735; cv=none; b=ZXvSh80sLwLlnhjv0VD2chwZ/mLYmt84KIb7nCuGDqxn5VDgYnPIo4hNz28vtJmt+bfv55oNGGtQWEs0YgGq0LbyVF/H88hwOpsxOMFsQ61sg4KWLEwqGcWLqMckZsovT2ng5QbRPXJHmmJE9C4GPnVIJh6HooSttbuPWqWlbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673735; c=relaxed/simple;
	bh=WtTlOjMyUR6gmn96vgOmSDN7zbUtzjUvWl30ALtr9i0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RP3CfF9u4aum/DUViVZDySQjftZfuxqkYkGiBPt1HGWGd+xenil/Q6+Qm57GaUa6xyDEvWHGtXhDO3E9yPgf9RtreatPTiZu45+7rl+1NV/0p3PMRmaM5QRJSKkWuFIUmllv/PpoCZAKz8e437lLkje+BeiVk0pbPiBV9JRMI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew7Xgm2z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso2734531a91.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721673733; x=1722278533; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WtTlOjMyUR6gmn96vgOmSDN7zbUtzjUvWl30ALtr9i0=;
        b=Ew7Xgm2zzrEKhp8pbErKEy4AMu8uIHVGSqwA1/Zdp+QS6crkhFEEVEjRfiBchHdvNw
         Zaa+7CV8qh9gLhbU/JcXDfovvLlMiFh4qWmnuAQ90/JQbv/iWk1IolG3pxX1Wi35lxv0
         cy0iplNVkDCEn/WkMETK2v54h7+njBz9tG9oLCJxXy7lDbUdmUD8f3bvkF3NI4cWuhM3
         czGf1VMdzZgxSzIFQQ8KVzio7pHi6yGP4X3FF7Me6VN2PpgasALLWnvQVSXmUJFCiVPe
         13DRMfaK6cWuEhCCSCMyi5uLHNCyJnlpYsZHYNDYoqvkg9QT4kXZRebMyejpyxOvlbRf
         aAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673733; x=1722278533;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtTlOjMyUR6gmn96vgOmSDN7zbUtzjUvWl30ALtr9i0=;
        b=K5HfSto9hLfzttJXlW1TFgL0e7JGz1qJF0EmqmUcnXIeYM5lcgeEQbP58mpfMo8eIC
         WhYC2vrP6jie5OF5hVa/s9lAgeG90Q9Vyjc/YQygC0yQhlbKOkhb8PtQgo/pyEleqiiT
         /mRXo8GRF18Yfy/9WtNmHr2InU9xVMK2Oi9mZFLHPnf8DKGfHYPVsF7NRULD+4FgUDE1
         iKBi1/5mno2p0nYvl77DT32Evlh/cQ9O1IcaAWydJcZdTAgN9tHyd1UeCh3sR2HRfA9j
         n+1w3T74h/NuOf2dATEcr9GUHeq7OyD4W66ev2kDn8ailq9EtMccLvtOZ4861cWC4sWm
         x83w==
X-Gm-Message-State: AOJu0YzqTdf2Q91S/7GqtfX6a1QqTSKbSvUHYe4CTlOCLoc6RaPU9HTR
	Ll8BwZUEaZmCGSxKO2xDzzWyOJoiHe/mEz9qW+nciHXGonAw9XaGh+IcS+ih
X-Google-Smtp-Source: AGHT+IHDEs/sFjaRwBxGiT9e0FhIwQ+ytgv2yMBPpnN6vg+S9HVlqtyc0/Z/xTJNX9aBaVIt6RPswQ==
X-Received: by 2002:a17:90b:344:b0:2c9:6aab:67c4 with SMTP id 98e67ed59e1d1-2cb7735dcdbmr20045276a91.10.1721673733002;
        Mon, 22 Jul 2024 11:42:13 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb775416fasm8497123a91.53.2024.07.22.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:42:12 -0700 (PDT)
Message-ID: <cf862f584ac053f6485e3dc2e57598f0ede582e6.camel@gmail.com>
Subject: Re: [bpf-next v3 02/12] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Date: Mon, 22 Jul 2024 11:42:07 -0700
In-Reply-To: <CAADnVQLp=NVoPPn0_mUvQEVuXMr6YB-WmY0pQoFMrOY=+H2Ydw@mail.gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
	 <20240715230201.3901423-3-eddyz87@gmail.com>
	 <CAADnVQJ7MAtt-EZLorjuyhoOFijyff7tNDy4-up0L6pjnrZHvg@mail.gmail.com>
	 <b660e0becf9b629a4d236ec5c03b8cc0dcdc2502.camel@gmail.com>
	 <CAADnVQLp=NVoPPn0_mUvQEVuXMr6YB-WmY0pQoFMrOY=+H2Ydw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 19:00 -0700, Alexei Starovoitov wrote:

[...]

> > It is possible to move remove_nocsr_spills_fills() before
> > check_max_stack_depth(), but check_stack_access_within_bounds() would
> > still report errors for nocsr stack slots, because
> > check_nocsr_stack_contract() and check_stack_access_within_bounds()
> > are both invoked during main verification pass and contract validation
> > is not yet finished.
>=20
> Agree that it's a half measure, but it's still better than doing it
> after check_max_stack_depth().
>=20
> We can also allow check_stack_access_within_bounds() to go above 512
> for nocsr pattern. If spill/fill is later removed then great,
> if not then it's not a big deal to go slightly above 512 especially
> considering that private stack is coming in soon.

Ok, I'm going to update check_stack_slot_within_bounds() to allow
access for up to 512+48 (to account for all 6 nocsr registers)
if accessing instruction is a spill/fill marked as nocsr pattern.

It is a speculative thing, because nocsr contract might be found void
at some later point during program verification.
However check_max_stack_depth_subprog() would still catch access below
-512 if nocsr spills are not removed. So, the worst case -- error
report for stack usage would be less user friendly.

Don't think any other uses of MAX_BPF_STACK need an update,
as all the rest seem to deal with registers representing stack pointers.


