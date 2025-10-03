Return-Path: <bpf+bounces-70320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1065BB7C71
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FCE19E4109
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1D2DA77F;
	Fri,  3 Oct 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM+pmc0t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818024468D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513119; cv=none; b=hSILxt11lPzf0yFVmZn4PbR1p7KlMLmN4Kt9GWl3TqS0HI016NQw+3dNMJQ9/27YWy8QzESA3pUFl1xC3zrMLDMgoN9F6o+MeyG3gnrusXKonnRLW79MMqLgKRzNh8+MuU0NlvGdauCKbPFXaoejP9zj1pZk5thaG0XZCYmqaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513119; c=relaxed/simple;
	bh=Kkt3Q+S/PZZAqTBar4IVDYCQ1W/NJZMcV2IGgBZAPSw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DD7SyxXf7EdImm9vNzugOJA37ZxrNoxzLeY9DADqLMgJTfzjLDgfLo9ff+2QVaVr5Abtppx6C/tmdEYzd8k0gskt1RXXRabarzaGbVz6NDY2FjuEXKn/IQWs6yj1ImHBqh6R5eOD9+YYi6nNOdwh+QMgoFvCmoWY2fnbb5yOabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM+pmc0t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-789fb76b466so2408627b3a.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513118; x=1760117918; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kkt3Q+S/PZZAqTBar4IVDYCQ1W/NJZMcV2IGgBZAPSw=;
        b=SM+pmc0tto2fEUFaDxWcKBS7aTnaL3kP5RhVI5w7bljvRXjk/Df+/fCCpQgMnMNNGF
         IYFAVD+a6qqAFWFgocPV5A9HDpiFGKnGe49DhPO+0jSqgviApPgHLk3dXOccqRY7xVnl
         hbseZxxEFobO581dTysd+hFANGebYI8FjkNCoXrlrMpTik19RTTLCztKckjZLanRw+36
         lUbSh4KWthTme58Cjm8ZiJndv3kM0uJAE/aCeLxxBmj+N+e59QbYxUDbhimHGga7giv0
         kC7nEnA+6RxUZCm02viFxvlQU7W2/kTOy1RYmBGAzP5AKqY552LhTAVxuvG45rO8JbQU
         P3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513118; x=1760117918;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kkt3Q+S/PZZAqTBar4IVDYCQ1W/NJZMcV2IGgBZAPSw=;
        b=NcWtt2CGGPtn0Y6sqK/qem2qJNE2Q95pPJJ6njz6yKwk30rm0pNhAouXQCzA9i+NYS
         /G/IW7Qup6gb4k5u+XpsPl/Holxi49pbTBfcsR/t/DM+5slRFCQr5Aq5heLUsRfKOkJT
         0hIinWbzFS8Sh+0LRidTKgUeqxoT7OXIDch2R8lwB3u5kfy+A9WJhjYf1JNI83CCJnZc
         yLkZ4YxiKwRf7bYSTmF/MKvuW2uZfwyMmctyYr1Cd/e3y+ruhpB3+WHuNzDgXyMLFjXr
         EePD++gAAj/HVvLsnvKq9EYbIP5RCTNLkzbtYnpPTAwiTg+zVCvgnP2ISMhvf62GKKJv
         f03A==
X-Forwarded-Encrypted: i=1; AJvYcCUxfPpLXsBYLXbOY8KYXMD1ukyjndPoOpiM8Iq+7DRL0uSCz4YAKZ4PgkCDruye79BzwxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywwmtS5qMJbwqOIoUQD9tocXmVIOvkNI3+oJ69rVfo0kDxoegR
	6R0t3TFxQi0m0wUltSi7JvWS+xENb+w6IQ7PcWcUiyKj2BoKmkP8vzJ7
X-Gm-Gg: ASbGncsSjIgRttKP1LIjKwWmCaSQgQ5QnO1zzNuO6kt5tnwf8ZJTtJw/81ryP0Q8nRO
	mjvnc4osQvumUFH1bId/4No4JSUSNJgHNAWU5IfqN/cFwWywnGqncV09767z18/w6TItjrqnsal
	U5yWhy9xzJEnSdLGHETmsumwmZSZ3aoWZ1iR/euCxYVbI8w2I1ddbKny2+uYStzNNeRzvPVHe0G
	wsXQYiJfN0WgFuuFidxP5SBszv0Jm6kM6sMaiSr1tyUf7nO0jMshcEfIP86Aw5keqXYp6GjZQfd
	gBj9BG7c5oKwby79zsqp+SPsy2FXMrJNYsA6FFod43Y7nRVD6e086mptIQqvBKPUPMhi8vrutfD
	2KqzaXn3tKZFdG9gtNOWJMh0fsxItBawpQhS3VLsWBMDle+Ke51JzlijIAjXq7gq2ecBSJHix
X-Google-Smtp-Source: AGHT+IG2wHG04FhNC7WpeM8vCfEO+Ef8YrEeXxN5v5Dr8TFY8cbd1zIFv96rH8c5BnlFWo7+OUIDHQ==
X-Received: by 2002:a17:902:db07:b0:272:f9c3:31fb with SMTP id d9443c01a7336-28e9a6fdf65mr44997195ad.58.1759513117692;
        Fri, 03 Oct 2025 10:38:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d1ba4sm55169045ad.109.2025.10.03.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:38:37 -0700 (PDT)
Message-ID: <3b24f3ff3e6b1a8249544965c7c9c3128747f6a7.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 06/15] bpf: support instructions arrays with
 constants blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 03 Oct 2025 10:38:36 -0700
In-Reply-To: <20250930125111.1269861-7-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-7-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> When bpf_jit_harden is enabled, all constants in the BPF code are
> blinded to prevent JIT spraying attacks. This happens during JIT
> phase. Adjust all the related instruction arrays accordingly.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

I have to reluctantly agree that this is the simplest way to handle this.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

