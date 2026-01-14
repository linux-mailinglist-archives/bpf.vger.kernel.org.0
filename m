Return-Path: <bpf+bounces-78964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D019D213F8
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 21:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E8E30A21AF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 20:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615D357A3B;
	Wed, 14 Jan 2026 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDtmXTIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B529357A34
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424238; cv=none; b=eo3vVeui+eY2l+hRB1+5pEzVfgjpYXvtV7PQ+AUQtCZy0sdJ64rj3EHJ3cD4v2xN2NCdH0nc/rTszc3qiTQr+jQS2XtFUkmMCUYMF4EygnctY1K6KiV7YSqpz6aJMsgZDjqwccwH2xxNt0q4cdKgNEDP+0LUOJa7F3m6e+mrLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424238; c=relaxed/simple;
	bh=6lgqOxbPHNOArWY45nHfTm2tPRqlerXXqceazU8APT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyYHiL/X90QSCQynJi6JMsKGHHtPMrBCd7xO8LV/sv4HuBIkUbORq0N43qjxSAHY00fiIUiHVa91ABYNYQ8LBLVL+m97PfArbYfUC4h/3WTy9v3TtKm6uoZahdATVFrrdzjxbMTdmUurN2SxoZf3FqOMXJvtlg6NG7hv9SS8SUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDtmXTIp; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11f36012fb2so291911c88.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768424237; x=1769029037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5PeObjK+JU3X3/JKuMBe+NM0vlnH+5ojUyknKOr5kc=;
        b=FDtmXTIpC31GPVQ2m+9+HvTmwTa5mn9kgkanApcRxv6wxepam9nt37W/rZ+ebbK5g8
         ZWCUSgnSzmQFa3vtVy3zwBTN6eZxzjwWYOR0mn44DrTY7APATWU8jFBPGzVvbbn5n9WA
         1cV+oySYapsPWG+X1bpajS3gmDdL7bcgW9FV9is9GDV8QTF4u+CdTdLRpOrMjUVZFIie
         aw27vdtjsQ82zb831pwNW9cx1XlInRgm8+yziQyjo+OazbFWupnEXUwvgf41w32cj1CA
         xLmYn2j6uMNEARnYKHtM83a4xnNBoFfVUv4bQPCqwESFQi85cpkSAds949Vanx0Ax83q
         bMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768424237; x=1769029037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5PeObjK+JU3X3/JKuMBe+NM0vlnH+5ojUyknKOr5kc=;
        b=g3apR5z/egXF/q2vzpbhQvV5y7davk8rwCQywXnJ2BuhLdcVltG0Mt538vYXMi8ImW
         Sn6ZDXAplMU3iQlOFkdZcegdcOm4F7MblWlrcE6Zi7uQMWNg9MB4ctFxNDVhE7SNy5wf
         +JOyywItBx/hLczVxgb5MfOKLRLxI5Ym2TCl4HFd10xv/ClAawJu4gwbD4GPDPueXPae
         3cAaGrjHkh37c96YgUZZYJVQCoulmJkkz/bd6nuDUScXjuS4fGmUmkx4HAiXyKycykH8
         E7OXLyV1Edeke3thqlKhCbEWDv+s5QXjaKJ3cNu5dGbAYr7vV1cl3N6jy9dQWZCfPXYV
         NpCA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ub+6p98dyLe3Rj0L9c1TmZsTLtbDbaH8EOqXKONZvDQ7yGYGmlfO+0E33yy36doIQ4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrH1fEV36GPIyhIaaTbHZ5Lau1ecA+jUiszLcpmL8vwjmcVAC
	u39RUbvBh1lOgxzKcxc+oBA8Kt50VeAL/6nQajIyAiLMa9BT+NFIIls=
X-Gm-Gg: AY/fxX54OXAbjQTj46XfPxymiX5jDbImCkP1LBLTb7UBlkno4USsFXxjKfhwZPQmxjz
	8N3AeG81AvPRo/TKNb29GqIMyYc0b04ms9g0iW+fkn3aqQG0sMOj6Rh60yA7n047lEmxjjyIiMf
	/MyAfSwNppklvZgXT/VGH8i+rqW54P4viLWZ0JU28sZS91wYYNkHH6MD4RyrKUPzCntKqlIAnB8
	mr4Y+uuspWj0r7Q7TF7zB9anWnVHuDlnSQg+UGrTDMujrVZiHj233IgfsbWR0fL6xEj+fk/p3g7
	pRiZDt6uGx+uJiSLGMqKJujoBZSTi3aC+MwLGFmG6aTLvvXUz/yEygSyvcIyDxQs0iWw6JbTBzL
	w/Lz+t0ESNLcStwuAXxgkzuVO+bO+6MKb9i2HMQgkVotJGNEy6rfl3Ga2tZg80jrFNNL7zHp2vo
	vgFdabyiR6vqcXRsNux0KkFF56QV0UV+DXueEr1HGP4ZybKx17jMYrXg08wWSh7eNw1qL0N+PiK
	ixekA==
X-Received: by 2002:a05:7300:1484:b0:2ae:5d3b:e1c6 with SMTP id 5a478bee46e88-2b48706e7b7mr5125641eec.21.1768424236381;
        Wed, 14 Jan 2026 12:57:16 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673bc0sm21277584eec.5.2026.01.14.12.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:57:16 -0800 (PST)
Date: Wed, 14 Jan 2026 12:57:15 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
Message-ID: <aWgDK4Zq7NShgql5@mini-arch>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
 <20260104012125.44003-3-kerneljasonxing@gmail.com>
 <CAL+tcoDgNWBehTrtYhhdu7qBRkNLNH4FJV5T0an0tmLP+yvtqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDgNWBehTrtYhhdu7qBRkNLNH4FJV5T0an0tmLP+yvtqQ@mail.gmail.com>

On 01/13, Jason Xing wrote:
> On Sun, Jan 4, 2026 at 9:21 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We (Paolo and I) noticed that in the sending path touching an extra
> > cacheline due to cq_cached_prod_lock will impact the performance. After
> > moving the lock from struct xsk_buff_pool to struct xsk_queue, the
> > performance is increased by ~5% which can be observed by xdpsock.
> >
> > An alternative approach [1] can be using atomic_try_cmpxchg() to have the
> > same effect. But unfortunately I don't have evident performance numbers to
> > prove the atomic approach is better than the current patch. The advantage
> > is to save the contention time among multiple xsks sharing the same pool
> > while the disadvantage is losing good maintenance. The full discussion can
> > be found at the following link.
> >
> > [1]: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> Hi Magnus, Maciej and Stanislav,
> 
> Any feedback on the whole series?

LGTM, thanks! (I'm gonna be a bit slow on the mailing list in Jan/Feb)

