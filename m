Return-Path: <bpf+bounces-21701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCA850390
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BA11F238D9
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2102E3E5;
	Sat, 10 Feb 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALF+bgyx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2D63B3
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555114; cv=none; b=uLCgWaLjZGb3B0Zltk6Dgb3mcubjnwWsZuZHJPl7J0tjsSJcZzhTSxFPZ7JL187rZrJMOkghR9y6kTycs9NyFLO0Iz05KTUqCNglg2Xb6rxb9uIeutzJruVQQi81e25S+R6WvJD1sRYlhYQBXAWs7DLvQDjErG4WycAG80L/5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555114; c=relaxed/simple;
	bh=8TKz3lSJCMhCnbog1yJu3Wo8kJ93npfxmxL0Ufh5ckE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ/8D2/HiK6gO6p/SLCS6o1ES2/TpVC1S4LIcMzOtFqMP7TdCKrbIY2whbM8/IAUAsK0PJt8j5RBILOsfXdYr04zVgpfQq4+uW0L9oYu8QLwZsVzrQtHV93HEKoP35Qc7JPgPlfpUdXW4ppdy9bo6OYW++dkg79UVLe5zO3ChLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALF+bgyx; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a3850ce741bso170506666b.3
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 00:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707555111; x=1708159911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TKz3lSJCMhCnbog1yJu3Wo8kJ93npfxmxL0Ufh5ckE=;
        b=ALF+bgyxqmTYzP1s9pJ/UQ1ZqkfEfJCvTx9C5KVptz9msCNoF9vZwd2cELe05cGX2G
         MPEiGyT9sTs+Zpx+AZOXbMknpTvv0IlpmXXLDRJFTGiMvXAjfnKFXKm1S5V0vgFyOno0
         OrJsso2KJx92kKoSNw3GDLj74oT62qGiAHs9iLElirbYiU0ijpfbXmK9k9a+NSLUZOFY
         5z44fb6UYdeObHVEqkFno8fkyv/e/5xrWlZQgU5ceLxubgUsWn2jknza4bFpMAD5GMPh
         q0AXROQwLKXNawZgyW+p6f8hWu0xLTJHoDUBf0GSxl1UUfdCFOJ9CzqQTmL+VA9Cl7dq
         ZN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707555111; x=1708159911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TKz3lSJCMhCnbog1yJu3Wo8kJ93npfxmxL0Ufh5ckE=;
        b=e+BtOQju/Tqo7jBgr3++LhpkZEEPtZIcPWM2lMFpJFgoD5iMcP4tkCO796gTMBO03+
         9b1Cz0BS9kUBM/w2MNEa4hCmaP/GlMXc+4FBCfR4BflMEEduabcShPtPK07PnybN8w9N
         v+h/83cFc5S6/HQwI59JicEYSFwUkfMLzO20KOvClK+tND5Y+oVuZjGXjDPLe/tXZk/d
         iFnYq/lLPF45hyR6nUhBqt0D1udOHGBxi4t03kyPWqRO90IDjv9lA2WHXRv/SYwLqduZ
         TyFCiXIsDVK69yLGlJv/AlJaNxoC5B5pxyMZYkBSwr21VopkTDF3M+RycfO8ZLfTq9HC
         G1kg==
X-Gm-Message-State: AOJu0YwmJ9QDP/3lXGTuZaI6lAT6qsEfPsLrGDKhU43EK5bnIqfFBANF
	V07XfediWqAoWxM+y6jI22P5J8WmIykggnnlUOTmEB8zWrrSvzQ9FDmkiA6GiPzAtKX1cmc2Lrl
	EEY4QY+FfIMWa3oZzC4QKTCoFrtaRTKeGMvq/vA==
X-Google-Smtp-Source: AGHT+IFkChkSYR1qDpYvK6/bGAHaueYvBcB8ByCwhy1fXoFRjvSV1Be+IARd7eiNtXbnJkZaWTePTshmnUl8YVU2wO4=
X-Received: by 2002:a17:906:b16:b0:a3c:3ed6:ee05 with SMTP id
 u22-20020a1709060b1600b00a3c3ed6ee05mr372396ejg.14.1707555111319; Sat, 10 Feb
 2024 00:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-11-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-11-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 09:51:15 +0100
Message-ID: <CAP01T77UMJrtVzE6nGAEpApvi5mJgpw5pQ+Ci3c3K91oEFEyOg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/20] bpf: Recognize btf_decl_tag("arg:arena")
 as PTR_TO_ARENA.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In global bpf functions recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
>
> Note, when the verifier sees:
>
> __weak void foo(struct bar *p)
>
> it recognizes 'p' as PTR_TO_MEM and 'struct bar' has to be a struct with scalars.
> Hence the only way to use arena pointers in global functions is to tag them with "arg:arena".
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

