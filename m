Return-Path: <bpf+bounces-45400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651E9D5259
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A261F231B6
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF61A0BF2;
	Thu, 21 Nov 2024 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijvo6GrW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0A139579
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212592; cv=none; b=jZKR8kwvNB+aB6TmKu8gUCTMrt4HaDiszM023H6eYt7B6mlcjwyBa0EIzXis7xtdUYGSNow9oDBOdCZc79kca+8Ds73xyQFc4I8rMoAVCj0lSb4vHJoC3PlPRaGb4M+Pg9DAOVhk9Pt89M9FUbl4Q7yxTAqGjPr/+K8P15sjnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212592; c=relaxed/simple;
	bh=PsMkAeXv09SMU17gpcYH8G5DiOXYNaMCK56arJdBfYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AK6kLvQD31sqpsfSw/QQM0SmhEp7eoy+3YtE5j81pDMioyCIoBNp2w7pb5/nE5hFZ3fSs9Cf//E7mnUaUwrGKMXiJmwm7QhEmNRGJYXJNwLsNugomKKC7XmvZfZ96sMcHFcCyXCHj6z7xGmcPtWA5orzGHEzm4U5/sEVfCz0D7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijvo6GrW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2126408cf31so9371995ad.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732212590; x=1732817390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWEngjdu86rXPx+bLX9GpS7LgFByUF8yEy1jZS6efdM=;
        b=ijvo6GrWPcDu571a9n/nsP9VgdRNhQ4a/h78KRP5gE4dTdw7nt07nOu9XDlnksJZph
         O/AzpNsZ2me9rphgqFV2aWXQyDDJkPuVCa1xG08z3vSik4aO6SFFtbsheRKMZdYRLgsB
         IbqIt4NPo1OiWl+2U7SUZ8T4Ca68wMYIrzJT1cjmiM/0CC90LVHKsFOHRBUfj9vOmbyx
         rO3WcDFLjQJWMCQWYg+GQPM06iOz0aFHNp2cH59jMUtOEdHsSq/w6BCg8/OI1WLElLRU
         iVuKaqzJAdXFqyArYgp4BqKPifkNzksjV0P75VfFE/zptXEH3O1/bdurB9un6u5igrNy
         0zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732212590; x=1732817390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWEngjdu86rXPx+bLX9GpS7LgFByUF8yEy1jZS6efdM=;
        b=ExmwEGOhdRQvprMWTD7dToxlJ0P5XBc6HvKAPRJPgvMzva5YjjxYYMAIzDz7qdCKQr
         rpk8v92LZb86uvqWhof2YCablaWpFRLnd4AXdiiit1L8QuMxO0cMC2qhsvXOQQP/vU7t
         Cgi90GcfBIlbggcMli9DDgpfIXdCgH+5U8yveqJeKWUkuVD4vU5o5UANlJFR3PdMYrxM
         f3+OzHNym3ISnKkwv9+kesPxlDmOf+5YUkL6aPWc5K6VthdNVPaGudgd+si2r07GiU92
         oohOMInxhiRirucftWgNcnJXXKdGGITFfUf5++gWGhHpgNMm/cX8wmwlINfKbcRoX1Hj
         7PXA==
X-Forwarded-Encrypted: i=1; AJvYcCVE5egb7MZcAby57lP99BwFcau2TusLqXauhwcpnCjQYedArDM/L95GFLpGuH11FVSFTiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcKeQrPcV9212VAAe5Jc+Y7AxTMPAhfTAuzllX9uCQAA+Z7sd
	C9jvhrZvUhHFMTM6jh39Sens3mLSgZgE83ihREamLpLuVifp7pfp
X-Gm-Gg: ASbGncvnptlbQXOHYtKvyDshYKKjPHT37u8nsMlMXgsGkd9whcn83b0D2wnQUXclLsG
	XhxhXRBebqJZshD4m00FeHDW1DdrXleBtwMv9PVVZ16WumzK9XxG5DMv0nsIguHtBEmmxdPJ4fA
	Py70eV/wQlSLXZvDrGDnrry6/qnnYKzmSGK0TEollrj78JhhpMS/MR74+S4sK5P1P+as8bHm9+M
	DTIwdusI1HIyaTBOAFVacTVlx6qTrbtsltsImPG3z9wQoQ=
X-Google-Smtp-Source: AGHT+IFy96+BOJviOXCSY4TRidp+qinMkS9svzZLvB0CPNps08qLJdum8Yq6X1AVTYFvhXWHnJOFZg==
X-Received: by 2002:a17:902:e74c:b0:212:618a:461f with SMTP id d9443c01a7336-2129f2803e7mr423205ad.41.1732212590174;
        Thu, 21 Nov 2024 10:09:50 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc159aesm1145705ad.212.2024.11.21.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:09:49 -0800 (PST)
Message-ID: <dfe594d893ce83a3be0ddaa3559043908465eaec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Consolidate RCU and preempt locks
 in bpf_func_state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Date: Thu, 21 Nov 2024 10:09:45 -0800
In-Reply-To: <20241121005329.408873-4-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> To ensure consistency in resource handling, move RCU and preemption
> state counters to bpf_func_state, and convert all users to access them
> through cur_func(env).
>=20
> For the sake of consistency, also compare active_locks in ressafe as a
> quick way to eliminate iteration and entry matching if the number of
> locks are not the same.
>=20
> OTOH, the comparison of active_preempt_locks and active_rcu_lock is
> needed for correctness, as state exploration cannot be avoided if these
> counters do not match, and not comparing them will lead to problems
> since they lack an actual entry in the acquired_res array.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

This change is a bit confusing to me.
The following is done currently:
- in setup_func_entry() called from check_func_call():
  copy_resource_state(callee, caller);
- in prepare_func_exit():
  copy_resource_state(caller, callee);

So it seems that it is logical to track resources in the
bpf_verifier_state and avoid copying.
There is probably something I don't understand.

[...]


