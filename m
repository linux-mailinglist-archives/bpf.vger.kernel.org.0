Return-Path: <bpf+bounces-35635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC593C18A
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2825C2827AE
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811661993B2;
	Thu, 25 Jul 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXv6ZPsm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6C142648;
	Thu, 25 Jul 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909715; cv=none; b=EZdfhHYWihKNdW1IpfSz7CLdw0OfeomISHh3Sji1S5j12cSMAd2rxraPaXfZg2AE8XcUCkuPWEBxHR+wOCKFORSjgPPXODTYZCA3qUZP0hZIu4ZSlwN61UW2yebBioiebTZHckB4ySB2/OxT7upg8Fu819bVxSSbSS/ODkAqbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909715; c=relaxed/simple;
	bh=e2K3AEr9Up8JOJvwuImmjpgEtgbv7qzkyY8t077+Bbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNVGtQAbrkcQ5+A3YfTzMKddAn+yqLT/lWMBp9l4/fg4p1UvJfcK1ptTXK9ok2EPTIKiE+dHCOfPm+ATsfHbMEk5ZC+MhYMUh1ZzrWlsaAIlvB8it7e6N8eg/JC55D/itkAi3PZOEKSlc4T0BY0G3V7PwmzA0TvJL9k3/J8I+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXv6ZPsm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fed72d23a7so5985965ad.1;
        Thu, 25 Jul 2024 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909713; x=1722514513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOmFpXy5u1VX4TCoM7/r3x66rOBntNESDIcJ2k/irIQ=;
        b=dXv6ZPsmfxbkoHGm4NJYasqmpPgTKzdjGofSNb07uM6nxGlRPfSOe2F5UM6iF0hz3x
         yt5UvN0+esvmyddUi7j2uSS1A2wJtxjD5yPKaJQqXEXkn7p2eqy3M1Ab3DTGW5/egF3L
         WkoNtzhEscjFgSL+S3hWORLQ80Ia7sim1M6QwzWeJOHOi3gEdDMHDbHB7KnMrepJV3g7
         2YSkuDNmh7wuuPo6yKCBB4iQ+fKg+kOpW+PNIqZKVAY1IGpO3uML3Sk9N4GPDaqXtoSf
         IHeU1JUxoSteVRkcxd9FDA/Gs7DRUnJH4J/47aSTQVG4b3hHurtsfUEwW0oM3uPoO5EM
         QbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909713; x=1722514513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOmFpXy5u1VX4TCoM7/r3x66rOBntNESDIcJ2k/irIQ=;
        b=XMFS7G/yBjUAA3TwXXR38Q108tSkdEa4H7gfrr3hFVze9wUioOihekyxwxgGIG9UtD
         qpStGk2f/kfKJWKY7HlTDBpl24yjJOC+J5LmCrKRHisUZnU19GgMaQp7tLYUV5LsF33q
         Fxz+oLDiSNggPUB3dGnXp0x5/c44RCtFV8YnM5TlsxDYnuh5HUHYo99ptgOjk5Nl2xGW
         KjbfpbRunZvgX9z1Za6yQTYRJfSjspvrsWdPd4URmJUd2sQMnDI/LkKoq1Hvsab6MDm6
         rZKMwzZfX9urgfFYC34cWy3DvKxm+gLWJOoTjJf3irvwUD8EPGE+aCMDUnNcW7lKtZ3A
         Gg7g==
X-Forwarded-Encrypted: i=1; AJvYcCUFew80qAus7PrEkh0uWVJ+hsKKF+Oo2H0FxTRKKafdVh8P/ITcQobEF/1Lmpb3MaV6KAKsfyx/tN93y8inq/ezm/hAL03rGkUhuCN2AYRojwdRf6kMv0mXWw/P3a4cUU16FI0vW98D2SkVz0bM+CMsIc5QnZM3jQWS
X-Gm-Message-State: AOJu0YwSWeWdgb6AK4YpULehe2EGx95+fEK/tTvqIioRIFaHCGZlmAiP
	KjbVAG24OsNLxWBTWweTppGYjKNr1fq/BDEsRd+yWIjn52RYXbf8
X-Google-Smtp-Source: AGHT+IEjGFTYFS0w+cJeXTKkRy/RyxWEdtsk1ZDwSlmudbvHSaSi8/WHEqslxuWBgsP7BA1RBfpSrw==
X-Received: by 2002:a17:902:e881:b0:1fb:83c5:cf93 with SMTP id d9443c01a7336-1fed926c950mr15502255ad.27.1721909712906;
        Thu, 25 Jul 2024 05:15:12 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8489sm12856075ad.148.2024.07.25.05.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:15:12 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: pabeni@redhat.com
Cc: aha310510@gmail.com,
	bigeasy@linutronix.de,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	jasowang@redhat.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in do_xdp_generic()
Date: Thu, 25 Jul 2024 21:15:06 +0900
Message-Id: <20240725121506.15501-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e263f723-0b9c-4059-982d-2bb4b5636759@redhat.com>
References: <e263f723-0b9c-4059-982d-2bb4b5636759@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paolo Abeni wrote:
>
> On 7/25/24 04:43, Willem de Bruijn wrote:
> > Jeongjun Park wrote:
> >> In the previous commit, bpf_net_context handling was added to
> >> tun_sendmsg() and do_xdp_generic(), but if you write code like this,
> >> bpf_net_context overlaps in the call trace below, causing various
> >> memory corruptions.
> >
> > I'm no expert on this code, but commit 401cb7dae813 that introduced
> > bpf_net_ctx_set explicitly states that nested calls are allowed.
> >
> > And the function does imply that:
> >
> > static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
> > {
> >          struct task_struct *tsk = current;
> >
> >          if (tsk->bpf_net_context != NULL)
> >                  return NULL;
> >          bpf_net_ctx->ri.kern_flags = 0;
> >
> >          tsk->bpf_net_context = bpf_net_ctx;
> >          return bpf_net_ctx;
> > }
>
> I agree with Willem, the ctx nesting looks legit generally speaking.
> @Jeongjun: you need to track down more accurately the issue root cause
> and include such info into the commit message.
>
> Skimming over the code I *think* do_xdp_generic() is not cleaning the
> nested context in all the paths before return and that could cause the
> reported issue.

Thanks to your comment, I re-read the code and found the root cause.
I will send a patch for that bug.

Regards,
Jeongjun Park

