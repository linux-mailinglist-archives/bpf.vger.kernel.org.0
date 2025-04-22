Return-Path: <bpf+bounces-56363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE26A95A9C
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCB83B543E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B318D63A;
	Tue, 22 Apr 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUlSRVm5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C62AD2D;
	Tue, 22 Apr 2025 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286313; cv=none; b=dZ1r9NZtX7YxL9gocm5b7A467KCuZYz60WshsFcbVj74Py1AKi6VfZ/isPrPV98+tLY/Qx/XBRK49/KDtB3P01Ta3wMhShpL8fUF5X1fOJQ2ubV0g0HB4xGoZeA22AUyS8e0+jxis1yTZnWZOJSWHQHr1TYenahBTJGx+5phpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286313; c=relaxed/simple;
	bh=c2237zbkihLi7D4ncLnEvgs7dHis7sqZutBBQO+/m+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2ZeFOHZTR0vErjpm561a2t2SS5NoEeKRYyG/u0RN8p+DZBTCeFmbgA/ZwjFj7AjWR7mIGBBt5jHNHCj42xs9n7BPjAEOhLNpcm5FbTOc5QAYykWvBkmUwa1QuUpzUmG3MECVAokPqAjuhMl0esqwJ4KvRfHTEdc7xmbSmkhOiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUlSRVm5; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5f4d6d6aaabso6466919a12.2;
        Mon, 21 Apr 2025 18:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745286309; x=1745891109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c2237zbkihLi7D4ncLnEvgs7dHis7sqZutBBQO+/m+Q=;
        b=jUlSRVm5iL2g3vDcuvR6vvHboIjqboRVmK+XsEhdxO2JGVwfNtJp8uh0AspJoTUEAh
         B/NHKDTF7iLYhNbrkArgbcn7M/KBHeJLfoRtqcbst2sdDPPzarknQq/C09bMXhz1fk65
         rdxj4GNJhRgRe0nzJCANeCUUSU27BlOt1kdFwgqI3tRX/4WG4O/gLFZ83E1DhTCQJYjD
         8iF8Lg0eH69cmyo6XHQh3mI9cJ1tSkUv3Z6Fksfm28UdD1072k54kGggjHzfg+A/o2Te
         y9wX1hvr4YRVjgm+vW9nrl3naLcuvoyszSTCYoVmiPzuAAQe7GXVAsuupqRE0TRwaEXb
         OL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745286309; x=1745891109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2237zbkihLi7D4ncLnEvgs7dHis7sqZutBBQO+/m+Q=;
        b=FMZ39rQuJ24/nKuEdddrccedAAANUzkyHtRHDTu+AAMEbwLOe3Y2enTpJtg1432gvK
         I/186GBIck13PlDyds+LReaB4b8Ar/IUyKEFeXpMobQ2ylRztZPioQPHSZ77GBF/6sJe
         1D2b987JtX0E4o2tbhrr7s+Q2TFjeJJPK+d+XrF6r5KJ6e3wqfGm1Dp6k+aEIG1M0b9L
         upy3b9d7yJzU32ZkvDuv1Rdv9FcT4178Pvz3pVCmFCM3TTDmjpY9Ih4gJUIjaBAdjX+5
         bDz0hJw+Gpp/cA30pVNUGkvVGgLrUN23JbeiNNdZfbap4PpgyU3GJWtQqfSBXKAG78rm
         1mEw==
X-Forwarded-Encrypted: i=1; AJvYcCUjhSs4P5vmXJXPGjO8e4Xcjf4z9acI6Os5HguJ95n9HgWTHsXOkIfvHMRnG5E8xvYos526Z8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPPEH8NcknNTH/fwGcun3857SaqSpXrsSae0qV04oyxJI/qZq
	DO2mg1/E4ulBfk7VS6Ina4FkybIRmhDuezGQO2c5GgsAMMvyPvtPHfK7ZFFHysaPepeELjV90fa
	vAN/6nZXIFxFMrw/1TiOGUNDsvNM=
X-Gm-Gg: ASbGncs+1DrCfGNTe3+bWBbrC5Uv7kueJi7uePM1ZOKecnMwMJlQFG9HvKS1V8Z2mbo
	xcye3YDx5vOK/XyOb7qe/mRCwrNXQ32ewno919ITwDhmNCRukVqT/IdeX6Dsw2LdeY7eKfcID/i
	+xYdQxyINWsmxysFeRY2M4+wi9wER8tIUfv6G2PCNgKEI=
X-Google-Smtp-Source: AGHT+IH2oL0xOtOo0j0S0gOYluQPMddtCX6ibW5o+PFpyWDdOF64ERR8Ob89bk19gZqnvhDPxtonuF0Ja1d/fg2CIvo=
X-Received: by 2002:a17:907:6e8c:b0:ac6:b639:5a1c with SMTP id
 a640c23a62f3a-acb74b5089emr1007990366b.22.1745286308711; Mon, 21 Apr 2025
 18:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-5-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-5-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 03:44:32 +0200
X-Gm-Features: ATxdqUF71owxnlguR7ZT8NunMxDeZCzlB9-LZKjDUVYHIcB1xU-tyySxvmkr6TE
Message-ID: <CAP01T769B_qpkrs9Bgs2ff8o1D0-vonTXHFuSwtUmc9cULZNng@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 04/12] selftests/bpf: Adjust failure message
 in the rbtree_fail test
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:47, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Some of the failure messages in the rbtree_fail test. The message
> is now "bpf_rbtree_remove can only take non-owning bpf_rb_node pointer".
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

You need to fold this patch into the previous one to preserve bisection.

