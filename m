Return-Path: <bpf+bounces-56373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4EA95C7F
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 05:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880DD189675E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B7C1A00FA;
	Tue, 22 Apr 2025 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6vYb4Hp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0D19ADA6;
	Tue, 22 Apr 2025 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291275; cv=none; b=J2zCkFsdDBcYrirZ2gCmWarQqg8DAj+aVYF9KswoY74C4CVneLl4ALsNnGCgZM6zgLykbsq+WEXgqKfAglp7iFQPz4yG+OJ7odvl8xvg+sA+YlMsB2F7ZK0kMPSzrEv2k981VpEt2cpYo+lPQY8LnaswHTW04O1xfYVxag/pMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291275; c=relaxed/simple;
	bh=agMsEcogA9FkDvvOXrfGF9dRGR1V3w8+o8c/rRGx0Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2ijW1AoNt7Hp9rOSNxtx7Yi1LBUlmEltqNYUG8d4krVCa/iuFtr41hmPMP93kHAAsqka/uSFC2hkCjSdjLb6TM4Vf964tuh1+fHsCwNuq3Fql1uZgxOTI71RQRSsYKokmHc1jX2si98V7p++DQOuVx/m75bsCv5JfBQNP88NT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6vYb4Hp; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso6236268a12.3;
        Mon, 21 Apr 2025 20:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745291272; x=1745896072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=agMsEcogA9FkDvvOXrfGF9dRGR1V3w8+o8c/rRGx0Y8=;
        b=c6vYb4HpFOfb7qOPVRWoWUfQOXeyDLM+bj5XjZmlt+mvYhz6RYzt++tObavndOS6Yo
         KrY8jzg06wUUvVA0RQGvWH5ITEPGZzyJj0WXEuXW2ubLPURAaSAIVwRuS75uhRxhzZkT
         jJsL4gxxFnPSQe6OlqrELeZskuUUDV2vazdTL7V6urw9Xew3uI163TR/+ZMfIy0ihLPJ
         VTH0x9ZJ1mR7rk5mMFl3GcyBYhTGXAthOrwtxb1vVBQGf+iVqCgvQ6Ssodph1QFvMwsf
         i123XS54UN53zpro0QhPhi8K73eLXC63Vx6Z3387WtpXFOqGQagfGWB5VAzyMOGjIf6c
         94Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745291272; x=1745896072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agMsEcogA9FkDvvOXrfGF9dRGR1V3w8+o8c/rRGx0Y8=;
        b=vAwXlgY82s4plvipnKVr5/S0VbCJw7l0nkF7HH4cd5HWIckWjIKQSLgb1I/N8erxG/
         AZwNtPM1fkmXr4cwIQcQ5mbb3e4lFXo8/354be23NqBAd6okkoX4GI1w8+9pgR7YTJxX
         2eEBj0T+Q77sxE7NOPG4VVGcjowU1gn+NJvnPxObljgeoGD6P8vU2ZYKiLBs/Ad3ak/P
         eC87eyDcwm6vrWeJp6PxOvpfPNp5dwMz00MRQ5E9sUB45XRbhndFf5Hk5cc1S1wJHojK
         XiZYx74nGvEsP+NpC76WnvK5ypM+bVkEQfEeyNlFLv4z8i1WoXMvHYabtt+GuGcO14RK
         lkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoBHeF1/fsSKdrbSi3ib8bIVDlFvRKZHG6e2zWheD18xH3m5PzmAC4KfnwF606w1LmIvOSR+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlw6wi29Rgga7MdHgt7Zr/MyeNjNRSjdoDpQNBYbs2v9a0FX/v
	04T6bsUT9TmJXWaaWiFB2O2vPNbIkYYqLOY+d2CjpAHFyQIRsIltwb31N5Hst5I+dEdvii8bWrO
	4QYUhfW3JN45tLmm84u9tsvfKdTA=
X-Gm-Gg: ASbGncsUrvwxv9jM176CFVkS2vHA6xM2i3dusWE/lrYEkEsmAn6IIpxIdRIOuD/pBgW
	LUkyZiFg0KiKZsnuZpy79amaC8oN5wU1pCloHk0TnJBCqWkrowlmfAdYV01RGU0/jGwWr+pZqUf
	JFZNDi2V/wp5zqDmFtHYmhvwT/KSknhQkgyk8MPzwFByQ=
X-Google-Smtp-Source: AGHT+IH7ShYAmdA2OEts7flNyU1tawqR117BXluLPd95PkekAhNDaMlteJf9t0rs2leM3WfW4IapBDVkiCgsYfKVhKo=
X-Received: by 2002:a17:906:4fc7:b0:ac3:eb24:ab26 with SMTP id
 a640c23a62f3a-acb74e04f93mr1211213266b.51.1745291272385; Mon, 21 Apr 2025
 20:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-10-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-10-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 05:07:15 +0200
X-Gm-Features: ATxdqUFQqmrb2NEh3AsA1rJ9xRGuG6nUycP9XEo1sEzQSw5jtp2dPeB3Rc_Lu5I
Message-ID: <CAP01T77F_uwEyFb1Gp=+oczyU2U=2pJjOEQBRx-wSYdjpHZG8A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 09/12] bpf: Add bpf_list_{front,back} kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:49, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> In the kernel fq qdisc implementation, it only needs to look at
> the fields of the first node in a list but does not always
> need to remove it from the list. It is more convenient to have
> a peek kfunc for the list. It works similar to the bpf_rbtree_first().
>
> This patch adds bpf_list_{front,back} kfunc. The verifier is changed
> such that the kfunc returning "struct bpf_list_node *" will be
> marked as non-owning. The exception is the KF_ACQUIRE kfunc. The
> net effect is only the new bpf_list_{front,back} kfuncs will
> have its return pointer marked as non-owning.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

