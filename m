Return-Path: <bpf+bounces-35605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE093BB6B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 06:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5384B1C22A96
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 04:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084521865B;
	Thu, 25 Jul 2024 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+mpdaXA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9C17C8B;
	Thu, 25 Jul 2024 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721880841; cv=none; b=meGmNitLnDjfxcXVUlVYQV+j4bde2R0QgAqU/eIWaiChYKUkdGnVMmzinMQ5z1s9G5F6ubPxP4kaZID7GT58q43OYTrhceq/nBkwcTW16ATIM08cL3/lOo5kQAtNufiSnWMcZlwnrGji3RTpN28yCKaysc6yftnAzclSb5HpxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721880841; c=relaxed/simple;
	bh=TRuvZZRBaWpYgyqk1HwFhS94kLiz/TEG066cWkhF1So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjBT0tYBUwAEyPuWw/LkXDXcK72b6Dr8dZBPhzPVmDCljieu8twb55VdN63DTOTK++cnoRycrA1//Jnh2L4coKlrxgDXf/LJCshVkdh1lTmB2/42ShIzlhwVGP2NfFrhdU3pn/Pg0K1B2ddmF/tUXrZGqMc4XCno++fnLX49hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+mpdaXA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb5deb027dso376287a91.1;
        Wed, 24 Jul 2024 21:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721880839; x=1722485639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiNnfAvln06LT7CHC6429gVKToNrRPAsuMaL0fJ7u1s=;
        b=B+mpdaXARNLzn/+nlTwsPGKLiWybQ5vT14oOrqYbuzeFRtjuCxXGkgfAM9LKCiBVCh
         KlreKnkbi5NdwT8wJb+P4J5FpWRNnt/v9ktvBwmNfQFXx2qh6PCCurpy9mMxt4v7op+D
         61opCJ9o9qK0MxElUAE+i1CPzG/75YvlbYgxjDHs0wsVfNVdmU7NlLAFZweIlNXkxcM8
         uCr7pTOr9CjpNuB+A45VywVNdS16BFcjKfmlhu72anURXrJcbFQGu90QKfgCcNOeDDaN
         yyWnoZQ0PIqqksKXnn2DLeaHURfyPLY3UTSnAH0hnVVMMs5zp5sC4fncifX8x1nblLNf
         GbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721880839; x=1722485639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiNnfAvln06LT7CHC6429gVKToNrRPAsuMaL0fJ7u1s=;
        b=EPE993IaPEdWcNjao1LvgH74MaVB01JTnnXMfSLwR+dxENEYTinlGSXYt4lblmcQhj
         FoBnbP6aNzLlzUiY2WUgDxM82N44C9cZfHAfZjmgmy8KUdvo+SbvCD7AMoZ/VzW5Zyr8
         urnQJyag322UYBMIfZ4KUkQTd8B4yc5gP3fJs2yBbdGywBIFmPp5PMvvmjlnFTDEUijy
         KC7VQwIqVLmhUelPIgyl1hjS+44XGwUz8Ip4pweFCE9dziFmMB0BvU9kfSl4SgnQneUm
         tmCNVH6rfK1kCFJaSCA3SH4fxM6KN99OnAKJHVjQAvfXZk1aFbwHOjSwY9WL6cUoLWdB
         o9/w==
X-Forwarded-Encrypted: i=1; AJvYcCWWK+wZgoN4r5i+S+V/5u+VTmAJO2i9p6hnZJOLb5h7g5XoPuzdzZI0gGuJKJ4RyFNK783SsrQW4qY5abEtpDkT6xOC99ujcWoipdGUtDg4nbeuq8AIP3JKtd9kzdJpvLn9BjOOYzSPt+3NOHJtni2rI935mh2Dp9jl
X-Gm-Message-State: AOJu0YyDUUq8Y0GuVY98AIYEoevf5ZjBkPKyzgAaHu6kz0UAYm3ZJGb0
	IINfWGewChGUNNhqYkEx9O4d6Mz+sR7OMhaHxrJa2U6bxpPYUPOo
X-Google-Smtp-Source: AGHT+IEWFEE7WOLRMqbu38ypX0hf+2DqNuFs3C0qV/EHBnsSdozR/hLFUa/Y5SH1ViGJvp+KkHM+Mg==
X-Received: by 2002:a17:90b:380f:b0:2cf:2ab6:a134 with SMTP id 98e67ed59e1d1-2cf2eb843b0mr684546a91.32.1721880839480;
        Wed, 24 Jul 2024 21:13:59 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28de8f74sm447650a91.43.2024.07.24.21.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:13:59 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willemdebruijn.kernel@gmail.com
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
	pabeni@redhat.com,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in do_xdp_generic()
Date: Thu, 25 Jul 2024 13:13:52 +0900
Message-Id: <20240725041352.13515-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
References: <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Willem de Bruijn wrote:
> I'm no expert on this code, but commit 401cb7dae813 that introduced
> bpf_net_ctx_set explicitly states that nested calls are allowed.
>
> And the function does imply that:
>
> static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
> {
>         struct task_struct *tsk = current;
>
>         if (tsk->bpf_net_context != NULL)
>                 return NULL;
>         bpf_net_ctx->ri.kern_flags = 0;
>
>         tsk->bpf_net_context = bpf_net_ctx;
>         return bpf_net_ctx;
> }

I'm not an expert on this code either. As you said, there is a 
possibility that the bug is not caused by overlapping calls, but various
memory corruptions are occurring due to the handling of bpf_net_context 
in do_xdp_generic. Therefore, it is appropriate to modify it to handle
it in the parent function rather than in do_xdp_generic.

> Is tun_xdp_one missing? That also calls do_xdp_generic.

This is no problem since tun_xdp_one is only called from tun_sendmsg 
and tun_sendmsg already does the bpf_net_context handling.

Regards,
Jeongjun Park.

