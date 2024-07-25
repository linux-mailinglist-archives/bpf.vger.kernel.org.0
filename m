Return-Path: <bpf+bounces-35602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5CE93BAED
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 04:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBA41C21739
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B412B72;
	Thu, 25 Jul 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRXS/RET"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A30101F2;
	Thu, 25 Jul 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875435; cv=none; b=Y67WjWShKQLwowRwpnuZSHpGFPMZIHSI98rI2+7roP963ZaKS8ddsYOxPxu4Cb7DbOC/y9BWaHYc5fqhbQG6lsRq974+fXwu+4rYnLlmVrZ8Q+NgCtxvCIrHYHt/42X7CmQBnhEjPlvZL6nyTL5rCfub2Co+fFe3Rm740/iqiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875435; c=relaxed/simple;
	bh=XmyQ8tULN1U4pgeEwCQuqyP7UJ3aAgGZyKsO4dCLxDY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r9JKBUajhSxEHp1RInk7VFtv1Ti2wA4qT0T+bGhw0Jib4UVV9hHXnTN2V65wKbGl8myhzWMrmuUBWQMaJYdfJQ7yQ5DRiGMZu9cTzketc+u4bW3WdrME5hLppHQk/zJSgjjUcuRObkkhte8OMl0rPiMXRr6b/FfQAHqgzFUXLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRXS/RET; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7a4668f1fso3095886d6.3;
        Wed, 24 Jul 2024 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721875433; x=1722480233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjfGIZAA4gtP60LkJTDv3AEUoTM8F0CLiYubK11ZcS8=;
        b=LRXS/RETb/gvG5QfnBXmxt08Rim/QY2jyS3EMyNnmIcMamV46c0YtyKLgsZbUqyTS1
         r3IAVFVGmXsPozt9DXU108UsbwABG3x7Y327xKqJTe3BIQRj/U7t9NJE1lLDY8cVEmIW
         JYhl0I91ifQteWRj3Q9QF0zcF4Fke/HHEXZPIRMfqe4cA82yUuum6aecF/Vc91BUSz3o
         FwY75TrxeZGUV9HCLDZaf6VCCuhS6SWMLovtQ93bFiLvaI3pwq7twG7JiS1a4oPVdzz/
         DOBAWJ8Ck70qrgX1xvXGOtDRq6WWNP/ON4rJXmFXOA58oUMQ9BAfAt+Bn4DGStIkegAY
         +4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721875433; x=1722480233;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JjfGIZAA4gtP60LkJTDv3AEUoTM8F0CLiYubK11ZcS8=;
        b=ES2JkcmCsNCynU1AOne2xhXzlplHWb8LIwczmmCOdw3mdp7yH7n/lOC4a5IOlKKH/u
         Ajvh/LqAK5Y6d0bEs8csMKgfzu3q+eA4QlRehlNwckrSHc+NF30ySaOOKvRKC/Q74yTo
         WNJmbbRLMPS/qCCHvNV6Atsd/+wIfRtaQvmy1cxT6Tk0INZZqO+kn3DzdTIhIP7T/QLp
         LLTf4cGwJwXVd69cGFaG4uV2PGpFbLgqQGaVigfrJt8uEoYGsGtXQXM50qTjNdoBu6J6
         wD1Gfs9qR/GFtQ1NIwLn2TjQYFwOW4ezj6/KdzDuomhqkpwITrSR4SJp+GWcb0/IebBc
         b4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaMVNcFdl2ML5PHEq/WPjxx9tu3x1LZwoA83Q6mqbMoOk5J73SpY/teLmcGAptXP7ItUO25PUSOrNKH9npD8hZkt0Hk7XqSQva5EQTaQKBRX4VhDBuMt9XVKquz35D6uZ7LwuwYDlp8iXQWGobOMKo5s58K6dG6AQp
X-Gm-Message-State: AOJu0YwhRrhqQHHSKRU6D+0bj+ujtz2nOhCgnhdpOM+7Oge69idye/mG
	AvtbOAoPUo1lhRhJgBWVk34g5QF7f0JhhTBolnWrkp3C83uhzPkf
X-Google-Smtp-Source: AGHT+IFWn8bOgktR9bLOhEby3hxW2Zh3fFKXImjybv/vhdVQtoxpZq10MeHIyuaN8FJoQZIXsKaf1A==
X-Received: by 2002:a05:6214:dae:b0:6b7:affa:6f2d with SMTP id 6a1803df08f44-6bb4071e78amr4680866d6.29.1721875432788;
        Wed, 24 Jul 2024 19:43:52 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa9b045sm2254386d6.97.2024.07.24.19.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:43:52 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:43:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 jiri@resnulli.us, 
 bigeasy@linutronix.de, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 Jeongjun Park <aha310510@gmail.com>
Message-ID: <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240724152149.11003-1-aha310510@gmail.com>
References: <000000000000949a14061dcd3b05@google.com>
 <20240724152149.11003-1-aha310510@gmail.com>
Subject: Re: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in
 do_xdp_generic()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jeongjun Park wrote:
> In the previous commit, bpf_net_context handling was added to 
> tun_sendmsg() and do_xdp_generic(), but if you write code like this,
> bpf_net_context overlaps in the call trace below, causing various
> memory corruptions.

I'm no expert on this code, but commit 401cb7dae813 that introduced
bpf_net_ctx_set explicitly states that nested calls are allowed.

And the function does imply that:

static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
{
        struct task_struct *tsk = current;

        if (tsk->bpf_net_context != NULL)
                return NULL;
        bpf_net_ctx->ri.kern_flags = 0;

        tsk->bpf_net_context = bpf_net_ctx;
        return bpf_net_ctx;
}


 
> <Call trace>
> ...
> tun_sendmsg() // bpf_net_ctx_set()
>   tun_xdp_one()
>     do_xdp_generic() // bpf_net_ctx_set() <-- nested
> ...
> 
> This patch removes the bpf_net_context handling that exists in 
> do_xdp_generic() and modifies it to handle it in the parent function.

Is tun_xdp_one missing? That also calls do_xdp_generic.

