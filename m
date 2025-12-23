Return-Path: <bpf+bounces-77331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF0CD7D52
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 503D63001C3D
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 02:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5352405ED;
	Tue, 23 Dec 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUMjm2Wm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3821F1537
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766455894; cv=none; b=MlBUDa4fYtMRZDrF20c8lo485zaFfC2GgovwQwOnmTiOVqLMsIy/cTWBajj3pdK9+e1quSf3c2TRP8mM0D4yr1ycut4ke/rv3xcRQLNtlw9Yz9Bo/XqXu8o66jkTKuEEYx5bqIbHkBDF2mCF0SITlO2bNpjvDJP9imOjaKDrAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766455894; c=relaxed/simple;
	bh=PKujwizGQfA2IeN+LQnjXoHRRy0tc8BQfCoYCWFqSdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jvvppe3ni8UOnBbKwFz9nq8hD8nkaxxp5iwqt1OKHeBT9Q5mE1T8c5iH9nG0n9b7bzvdgExt1QQElPY4bcvomN5vJ5KPUrKXEYqYgsGyEpythGAbFqVbczrHoE53BHcJpjFY/ZvrLC4mWkWmFs87sj5bZMDbauOcxARW84Jz9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUMjm2Wm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so25527835e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766455891; x=1767060691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6XfH/unjs2YY5vH7P9rUbisIadizeaMLvKYvXY7Qxc=;
        b=dUMjm2WmMz+OEdygwDt+LaajJcpWyJ7xGhmRAsU7RL96R+7hCDTlLVtaB27siri3QN
         BwLWj4y4cQc1sg7qUq+WgEOkpiwrXS27jMcFaRcY/bmTsMsJYluKIwwI7g0sHcOWqAVB
         E+rbzYmazGkzm9QB/spWmniB+4pLnvRTF9ZE+Y6E+3GcwZa+Q65sZo9SGFl6gFPwt4Mh
         U/QG9YKMGAF3wITywqR/FxB+KX0DgwBdnhxro71QRrJdyMkZwZc8Z0seBVpZy3OzbIxM
         JYNjrNubMQw+W7mk+Kj+SfGOkiSrsDhIf2cN64Ddb8FGtfd/AMpNrlADW3A/uXpKK79r
         KR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766455891; x=1767060691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6XfH/unjs2YY5vH7P9rUbisIadizeaMLvKYvXY7Qxc=;
        b=kM7CU+Y8WTByk5hRhp6Ybj/zMW5JgeMuTr0qEaqjc1j5XFhtdfhmm18QdCfcwxWaL6
         7GqSLbI7OMrMlnFJ7vtJ/qBeeoTop8kmtko82byceE7GwArP3UfxXal1ACtEruan5B9+
         F9T2c3H8Tw7pbRd5fqPcJQUPTfqTEWEdqa1QliFTrMrhC9XTYzRMMNVdxT2JN0ZtsSmm
         mp7x7rJe/R7ih/5TxWnM2S+ZKEgmIHZ6HAQjpjw8OVy9ECwX3NHaRiSSqeNPq8h12sms
         hyh6HOGXpXHJOhbKIuqjc+L2eQzKRg/byGmnR6GYe+ZcM2DSjEDoHBBp2KnKns22iu7b
         /8dA==
X-Gm-Message-State: AOJu0YycVcMo20wZ1HrEvMtbbdaaBzT4jXz+3cVo87zCc6tGr34fS9le
	XtALGVIB2DCZQFOcc6u4lspdEvanrAzz03YW2aYpoem0uNyzR91EOOMSMe44e+pm6UEfSLau45T
	RITZuxAzyELAnHbmBUIr6ljG/IifgH4U=
X-Gm-Gg: AY/fxX7QpsYTJvXCvhMxSrYtUD8M1xGKBo+9FjEhsPIlXDDqPv+Lz2FjvtKrFh4Iyey
	46IBMwggSgCn/TJKIEtJ4TXs8KYSWOd4kplmhjMJFXNs37TtgAcdgdEZ5dBC6W7E5vVaDtMq+4f
	xVKNafUJYXSYSuTIPnvLXArudYcgx0k/fkNAcJzX4w4a+dKcEj2sXcGoeWVx5siXreZltqWIWvO
	BNQLWhbzGI53UzgLmX8g5MTkncrMID4yLF0BYHn7xo2xolzUCsCz2xyBL2pjo3//nDGSeTM
X-Google-Smtp-Source: AGHT+IF8BfcA5cvU+pxFPwDxmKTdBV/w13ESm1DnzKFgnWkd7KrlYrVdHx+Jn0QifxMjszHNpoYKpr1/f0zvUzcoB7w=
X-Received: by 2002:a5d:588c:0:b0:430:ff81:295d with SMTP id
 ffacd0b85a97d-4324e4f9350mr14068995f8f.41.1766455890563; Mon, 22 Dec 2025
 18:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222221754.186191-1-roman.gushchin@linux.dev> <20251222221754.186191-5-roman.gushchin@linux.dev>
In-Reply-To: <20251222221754.186191-5-roman.gushchin@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Dec 2025 16:11:19 -1000
X-Gm-Features: AQt7F2oG8qKh_LrIImutrfPDVfsQ-CzA11AhccPedSQPp8mFoIFiyOb3CeObrO4
Message-ID: <CAADnVQJ_WLMRXYV5p4Lk2+nxdC01iAaKQhYecMjx4rXdBeXjNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] mm: introduce BPF kfuncs to access memcg
 statistics and events
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 12:18=E2=80=AFPM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> +       if (idx < 0 || idx >=3D MEMCG_NR_STAT || !memcg_stat_item_valid(i=
dx))
> +               return (unsigned long)-1;

memcg_stat_item_valid() and memcg_stat_item_valid()
helpers introduced specifically to be used in these kfuncs,
so I feel it's cleaner to do all idx checking within them
instead of splitting the checks like this.
Then it will be easier to see that
memcg_stat_item_valid(idx) access is in bounds when idx < MEMCG_NR_STAT

Also I'd do one check like (u32)idx >=3D MEMCG_NR_STAT
and drop idx < 0 part. Compiler is probably smart enough to
optimize this way itself, but I'd still do one check.

