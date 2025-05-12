Return-Path: <bpf+bounces-58056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F76AB4698
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 23:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D990189BD3A
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA22951A5;
	Mon, 12 May 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhlKiDEA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AB22A81E
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086123; cv=none; b=naTX35hfqH9tjMpxrKsziWr6YlZnsk1mczH9EbT+YWApmv/94wrskKMILR44lGoNn45ua6p0gE3ESfnC87VfjAZA2cUl9TdS02JDgbYgOZc99lGvF+6Ocemgw5P40cL+Twd/xw4QTRpsmMemNfORDbng49Y/U1OcnR4qukEMIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086123; c=relaxed/simple;
	bh=W/mk4pmaMvrDIQ3EV0JK2BEklh5EKoarRNZ9L3zS9Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lr33cKHagfIasX4hj1aYFS5uoYupmIgpy4i6ctV3LHtzi1Z2tx6FKj5u2Us59Mh/cheSu/mEF+3EeLH5JWeQMjdxaSomdaWVRG/1zTfsh8kXgyIdwBleY3UqOhF4jdNjHhWzU3QyCWiMrFT6PV6NsuikycOGA8ee4uVaX364D9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhlKiDEA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a8c9906e5so6273667a91.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747086121; x=1747690921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT48F4yNS212pcgzJMd2pYDleXf+IvfmQBXejc8Hu2o=;
        b=DhlKiDEAXvQ5qzkaZDulGQuvzrOW3TBk0VyEC/2s4xPC/d0NhYUx00FBAY0Ucmnjdc
         HB+zoR7QWMM3AlaGu3iu39tqg/FMUu4YXfKFFNbJoBIbPBkfsLuN6ksI77GeHom60TbO
         hqPkEANu1Cv/LHjJnkbPilN0BRN/z1IWI66DywQqG8eH6aNjuvMzjwDAJUmt82/DZ2N1
         BEQSx0eFlFYHLkp7b2Xl+rP80/2jRiznMVr7xMXQyQEGXWSYKPI+5UulhQvuBuAqBZDU
         RwRrv69EIMr03QNY2mIdPvTZjjdgaUWNHkvIwmF3q+sAS6QHdjCdQN9ZGyCvi2ms6Q9C
         oTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747086121; x=1747690921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT48F4yNS212pcgzJMd2pYDleXf+IvfmQBXejc8Hu2o=;
        b=Hwbjw4gJcEdV0lZA9Q9X0WTCX9nG1t+F3rliMuMVZX78l8QWP/4dWNyr0tk4Zikd8e
         GJ3q5g8wHvLBauHge804nwosz2Mzahpmc9ZHyTERU5qw7W2a4h+GEn5QRFAOeznzBfJM
         XH+brQrPdMqTcbLC63Xo7zMr7Oi/8e/7Q7BKGMxTkVip60ekB8vI3BggMupxQoDmaS5c
         R9tLbxr/AkHJdMEZYZG4vAjS5l4uqtaQXmn/pw02lWV6TkmdqtWaDUbqMaULqaBG+AeW
         xyT/DdVeVigpHBhB8LPCgnNJ4Zc7RYILP75MM84ymmxcNBKkqOs7h6wr/18+0ebvFAgt
         Aihw==
X-Gm-Message-State: AOJu0Yz3ulUzFBARb5DSZM/C9ejASDPOJehbhg6Fin1O/3MpmwXnQzbv
	LSaRG+Sk5sOGlE+XzOcH0twAO91biSpV+yBb1ayYm3BUH64qcgcfaovKIZGrwrp9kDcWRX7o5Re
	DNOHwxXzolYEeqOXZOpq2cxghuPetvYY1N98=
X-Gm-Gg: ASbGncvgc1Z6IdlWhnFtRzUby/VO5Gh7sYk/N1krlxLfKIr1l9I3vLdn2sfqgvhHgOV
	S0R0Cdr8W65Bjn7iyfs1kdbSCd5SlkI7IJFlyuA/zq4AP+0BJz+ocIyGzifnHFpEya6xDO93cHX
	Ee4n9yJYiwoRcyIi8EV3UNfkeT0tfIAKSklOTPyuinqYLBex/K
X-Google-Smtp-Source: AGHT+IGLHi6fytoLJtBNYQCtl52duEpy9Ijfh9Gq/I8BuyeHIdmDSKxW4FBjna6tp8U9CemkM6yrEftT2kWZl0xJ93I=
X-Received: by 2002:a17:90b:41:b0:309:cf0b:cb37 with SMTP id
 98e67ed59e1d1-30c3cafd29amr25570962a91.7.1747086120728; Mon, 12 May 2025
 14:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210246.3741193-1-memxor@gmail.com>
In-Reply-To: <20250512210246.3741193-1-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 14:41:48 -0700
X-Gm-Features: AX0GCFucTsmfM7G0Chrj0LNAqRuZasgwQ_Npq7QQE_bEMj42NHmzAVw9t-jDflc
Message-ID: <CAEf4BzYbWBJ_m553ju+azX_UxyWgsBx=nwev9vyy7m2DfeVVhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Add __aux tag to pass in prog->aux
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:02=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Instead of hardcoding the list of kfuncs that need prog->aux passed to
> them with a combination of fixup_kfunc_call adjustment + __ign suffix,
> combine both in __aux suffix, which ignores the argument passed in, and
> fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
> passed into them without having to touch the verifier.

I have this wet dream that one day we'll make sure that all BPF
programs have bpf_run_ctx set up for them, across all program types,
and we'll just use that for these "BPF environment"-like things like
getting currently-running bpf_prog/bpf_prog_aux pointer.

Do you think it makes sense? One of the concerns for wiring
bpf_run_ctx for, say, XDP programs was perceived potential tiny perf
regression (but it's just current->bpf_ctx swap, so shouldn't be a big
deal at all, IMO) and just generally no immediate use case. So maybe
this bpf_prog_aux access is a good enough reason now, WDYT?

>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/helpers.c         |  4 ++--
>  kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
>  3 files changed, 30 insertions(+), 8 deletions(-)
>

[...]

