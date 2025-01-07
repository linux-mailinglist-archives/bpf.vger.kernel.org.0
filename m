Return-Path: <bpf+bounces-48178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B7A04DED
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62721887CBA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39951F7098;
	Tue,  7 Jan 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZNm46zRX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FB1DF27C
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294098; cv=none; b=dR8TVKH767DfUCS6ZkMVYjvChGLnqtlfI3Jjc6bJr1SGMxOK+6u3m+9ckTNVYzGhJFQUD2VO7IvZq2t5ElwrET0GORst8wQT4gW5NCOcvJSekLJzBxVOdsCi/QSMNC+e1MEV400VYdDbvs8U9jza3pGJ0hDiFiuiMPhLMPVpQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294098; c=relaxed/simple;
	bh=wrcJ5WzBpVmHDECD0LbTYIavL75D/ZEnET45Njn8V+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0vtZ1FZSYZE5O6gkKTIWvP/La9pHx973MdRYGS+dqkvzg5zrShCuT0ntOUPk5W32u31zxBPfs7dmLNhXmojXk9lQFZZrGwRAWncZ+D3I4pJeTNZ/pjRQUSrOb4ygc7xear0rhwdweMFdWEUa2bQvnqNSbAl1w/yU3Z5y0wzojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZNm46zRX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso2254906766b.2
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 15:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736294094; x=1736898894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t2Mbpko8ZH+edX6zIwUZ+mSrtKO0X1eo3T/ctVYs4Rs=;
        b=ZNm46zRXJ17TIiXXwdXL8PqQj9fhxSM38Ti1GBqNt0u4cmBwDsGrR94MgBBgu+sO/G
         oyvJaEq1L1eTTPNkzqhx5fMNl9zEv/zjFHm40eXmInzHTcz4glOtmbAMWV2g7qFkmrad
         YC8kyWxo5Z9kxIfLqNKMvRrU4ejPdGkSuTsMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736294094; x=1736898894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2Mbpko8ZH+edX6zIwUZ+mSrtKO0X1eo3T/ctVYs4Rs=;
        b=eiU8aA7ido14c4j3DhJpFrVq2aCrhfRjqyHR9Bv//XN625t2T9zgF9Hc5QVmd3fZLM
         0jHbCkXx6MsvMYZ+7BVjoXDx3TEBxDN7xsPNNI40wATUkzaZpQ1q32GQ7aqSKuC6inOE
         GTaF71zdsS/D9lFM08CANVEHJMYfUMBttcsrxSEwt8+og32GqbX+7xKxiSUgJpVnwD7r
         nqjt8TyIET0twIba5I3dWapXVIRC7wRni084vLCHh8WDCCkO24iE8FG48eKdMJlYh1mZ
         8soCQoLxlDy1p2xDDgL1GYl457hVnQGC4vgv25l06AL8yzcSqw4caCfbP9fFFtYPwns2
         jouQ==
X-Gm-Message-State: AOJu0YybA8oDuAjqcdsUSJgUPNbIqUtI/WgTHBgffD5+JNgscX7rObJW
	AhG6JJBiDjcbsVe+ibWqXgAk0N8zcm92V72Zrp0s7UsisUudJSFJUl2jDDe0MXODl4bkuSGjTsf
	/Wg0=
X-Gm-Gg: ASbGnctIMDxtL4E+P9my2pfXKvHJ9U/tfKAkgTubpLBL/HFTshkZl/DGrIyKxL/HyOz
	zqpzX+3dDScX9er8bUVJ1yRj9wASG7rdqaObqBSHtuwDw7KFmKsW6ujezlNoNR/68tW2KWVO38u
	7gGXunDrXUQfV4NI1g+AQ5Uh7EjKl9uU2TKX/Wo4F3JSj5pq2RKRkk/vqNCL+v8j2aOh8Itk58F
	Cz0p9bFMixav2F8NNlDEvTHT0RDZwqy43bwCv/QQKu1W3xY+pYBPghc1tpj9DS767I/NGfzGiqp
	UqjDCulYQBBnWf1YK5jaUBMpIBV8Idw=
X-Google-Smtp-Source: AGHT+IHY0JYvIdUo29PxN7XTxCBlTNlyAhCh8tjOxmWIpdvJN9RVAdCW2P+vs9O7uCQYaZ4G9GOKMA==
X-Received: by 2002:a05:6402:388d:b0:5d3:da65:ff26 with SMTP id 4fb4d7f45d1cf-5d972e707damr1389217a12.31.1736294094339;
        Tue, 07 Jan 2025 15:54:54 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895d31sm2438331866b.61.2025.01.07.15.54.53
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:54:53 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso27299313a12.3
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 15:54:53 -0800 (PST)
X-Received: by 2002:a05:6402:40c1:b0:5d1:1064:326a with SMTP id
 4fb4d7f45d1cf-5d972e1c39fmr1544299a12.15.1736294092739; Tue, 07 Jan 2025
 15:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com>
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Jan 2025 15:54:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
X-Gm-Features: AbW1kvaJ4eX2KjwYvKX_pDbUvs0Jo9vFheC_FA-vOPe7ybDp6O4J7idhhk8Pyvs
Message-ID: <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 06:00, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
> res_spin_lock() and res_spin_unlock() APIs).

So when I see people doing new locking mechanisms, I invariably go "Oh no!".

But this series seems reasonable to me. I see that PeterZ had a couple
of minor comments (well, the arm64 one is more fundamental), which
hopefully means that it seems reasonable to him too. Peter?

That said, it would be lovely if Waiman and Will would also take a
look. Perhaps Will in particular, considering Peter's point about
smp_cond_load_acquire() on arm64. And it looks like Will wasn't cc'd
on the series. Added.

Will? See

    https://lore.kernel.org/all/20250107140004.2732830-1-memxor@gmail.com/

for the series.

               Linus

