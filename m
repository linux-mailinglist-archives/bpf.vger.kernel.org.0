Return-Path: <bpf+bounces-68584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33108B7E458
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447ED1C04895
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4B2F3605;
	Tue, 16 Sep 2025 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNkdre8K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F842D3ED2
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066293; cv=none; b=a0yolp9u9/ASVig5awRNX8+lmi0BciQgR01p33p/BMynBuu4CkPL4+Hbw2c7w4qtidLXvsaYSMwdqyRXLSYrwua/ScHfzOTwxkuzw2QnPksaTp5/6pEyTSr3gRCVZWzwsiPTFm2We6b2ZudZgAfamBaXzOINtOau4NL/UqkH6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066293; c=relaxed/simple;
	bh=MDfvdCUTezwS+cwI5hKWdMZx8H0xzumevzpi86C7dGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1ic7bFgXaNEaPHLhIbOAxjZm77Sk9ORwVg4s65yk23sDXHFi1FJ0VFLt4tbitqlmyCGax5RUfd2eUi/I8LpVhvFbn241Oge1I+Uj/xPsQkV0KtjtJAjPIxcgFT1rcUU8l8l0jhJ8EkQ16bS9hHm5go7xukGEK6EYB++0L68ym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNkdre8K; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so4204181a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066291; x=1758671091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr7Y6YjURYHlu5cmkyeHIONPCgS8Mtm+NBmHezL/gFw=;
        b=YNkdre8KQT8IuPUI3PomzkrNUQMTZoMwy6kWWmr6F31IG0TPLzDQeYHBoZ8C61eU23
         94opnK387fQqzXyrX7QCI4PHFVCx9swe3acjJGSsBsdEQ/r94VEVw3z8bRrSucDGdeUu
         5Yp4hBnznJOvCH8so1WnVIv2AiY51L/OiJeEXWkGYWgPr7kYK2EMgJsmh6mE5+O4o1U0
         ZpmxL8i87w6NTwNmqowjntjwff84QQAXq4Ls6j4Ap8nShhgWMYouTckPVpYeNIVw69tR
         nRwX48Rzn00YaeFwMD7WVTwtPjWhiqS1ZLpBw2X3i7hqD9mRgXA9Ci3hIwcG3z3A6Pa3
         46wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066291; x=1758671091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr7Y6YjURYHlu5cmkyeHIONPCgS8Mtm+NBmHezL/gFw=;
        b=baR7Cjliz+hYWWO0xdrSmX0V00wzPGLfixjNHMNOduPqQoXDdGaL1p72ZoCJlq5vQl
         rrVyL0X110LFeEFgk4RE+43lGWmqYtFw2yhBmwy1fJpQkzynML3Ao48/nYL/qJemNGlH
         p6KVmbZEUJQ6UZjPiKXuMSRGU/+m0j9dJETxQSPaSREYtqOQrCQNC5An4lvrmr27p16G
         GWrDo8ayMVYg698KjjDhWGg18KlVXighv+m1593oTw+eLoxdwjA/PKgrHB7BHdBcl5DN
         g5ksziC2ez/MDv6jZ42eeUTMYyBt1EFzfs5ZEkc6FfsQdAjqZOdIO9tcYH9WkKYnb+tj
         sNgw==
X-Gm-Message-State: AOJu0YxE8DXp3lHlOTW3PQlR9CfMm0w8TgtgSuPpoitLfEiR/IkQTdQg
	SmvYNfj8DwKXvfM8kz5WMD54tOtWyf3XabZ2VMq6LVvSuXLQ+mxxXhZXm+4bm1m67zav5HHN+V7
	2f4w8AYZdhwAYijOAaKXd18WRIDtzpaM=
X-Gm-Gg: ASbGncsnQ+GFdD1Nl7JPEGcHE6vTLi8uSYDR6p+9e5z2o1pVsh28po861yKrvWmkX1x
	AhLLdXOvznypYMELfDtBoWD5cLP61HvAwPJjSuVRk4xo1nO/CXvqtsZc2rlFsWh2Dj2DvD8wppt
	aKEC7ZhgVzAKdOEUDLBSWGDgWLLSW+LSZcCIYtKy+ZT+NAxb6muFhN84jjyRZEpjHoSrf5C6Zxu
	fsropDNRnxGnkw3FxlAKFk=
X-Google-Smtp-Source: AGHT+IH/asLpJKxSH55336JV5hDyPhMMhr5rexwBYhpZOwfs0FNK5GDp2XJKHHdTpjCrmih+M38r9XlvxNUVDcQkI7o=
X-Received: by 2002:a17:90b:57cd:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-32ee3ef06c1mr213945a91.15.1758066291340; Tue, 16 Sep 2025
 16:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-3-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 16:44:35 -0700
X-Gm-Features: AS18NWCSPafGSW8d-82vD8CR5jjgSdqsmBXUAPCtEJIUiPgXqNuMNORBbd1vM0k
Message-ID: <CAEf4BzaPUkkMZ8J7fgeqHvxPD=zK6ODQmkbcvJHfaX1mT2cZAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and check them for
> following APIs:
>
> * 'map_lookup_elem()'
> * 'map_update_elem()'
> * 'generic_map_lookup_batch()'
> * 'generic_map_update_batch()'
>
> And, get the correct value size for these APIs.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            | 23 ++++++++++++++++++++++-
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/syscall.c           | 31 +++++++++++++++++--------------
>  tools/include/uapi/linux/bpf.h |  2 ++
>  4 files changed, 43 insertions(+), 15 deletions(-)
>

lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

