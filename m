Return-Path: <bpf+bounces-43018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EDB9ADB5D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384ED1C21CE7
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 05:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC847171675;
	Thu, 24 Oct 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOMsbYw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2B1662EF
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747258; cv=none; b=cWvVOY6VwNpQLo5K3CnIqwZW2kSiUPZYKN2WmYtAPuaRm/Uk9Ldw6b/S/v++pzj7hAt0ruokmd6dHv3PbccowTFDjYxCqKuPMkN+BBOomATg854bOhTzHguc53H+P3gcSkOmjlRsTo5JhBuQ8NwHiFy89c5LwBiRnS+E36BGKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747258; c=relaxed/simple;
	bh=mFWrIPybWxErIoS1HOWNWtxVAZzxkiMNEWK8L7tzCMQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tRFtAd8AYJasFfkPvrzgRNt4zXAaJPHFQrUPtvaYam5KQUe9najgCgJvt3clzYqrsxPeQmKvyobegDeMUdpIN+tAZEv7omXQtP63Xc/vqIT9i8F0OQ+Qd3lmGXh0He0Y9aXybbAaTe6c/nonFQzUrrqhyPFR309v6Kb+cTOU2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOMsbYw3; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-715716974baso313585a34.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729747255; x=1730352055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq6gg4Wg7hra5nPxRWCIafHmnQoYvNLQy0N7xDxwQEY=;
        b=aOMsbYw3V7Ls7L5nTGSCe07pNKEOkwfbg0aj15zQ6XtLsB02r9KZZntBPQ12x2EOxu
         EmmrPUXdNRwPV6/nZ35PfgnrERK9IHIVxABkuJqpjOIpPUcuGLgZz7H5PGfRdP2jB/y1
         03Nxqpj7Q1MKN6AfIHv8d66LgpaPBBhFc7O7E/zkt8pyFv2IGCzZoboHH5W178nHq3ct
         rE3DoDkcPJjbuMirYAEyO5KPdhKCVfgpX7/kcEJ7Yishq96LMavST7CuXJ0sjAtNWAce
         ut//v1RBUd5ChYoTq6Ii81UDj+yjrQ2Z22Z/rOL5NutZ/VJittEaCq5yNHeEOGO/l5RB
         f1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729747255; x=1730352055;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qq6gg4Wg7hra5nPxRWCIafHmnQoYvNLQy0N7xDxwQEY=;
        b=GLdv3sOFbIgV2cBx0tn1FN1RWVg18Z/FF86GwhS/+bNF7GFxtEQTSbGR5NdL8Kz5OL
         fTrd0GE8+/dfXGVES6Z+MxyeItJ9xKnfQ9gV5ERbNCqygdTQRW+pmL8JAaIBhwGigT29
         pS7Sv7yhUack1KoJ25nEaBLyIpJ1N3Pp4m2lk/05mrbW8p6iwgMsXYF1qqxIvNbt9vfF
         8DHCLQ1FIDAcotewbbE9r9d4ai6W5sRDgeln7aUtIsEEaiqT0wCcY3j8NmzZZqnaACjf
         3Io10rAKlUkvAM/CHf4knwZhz8zkoSnqr58txyRqGbqPYNoudVDp17Zv5Nlb9Jx7D+/L
         X6DA==
X-Forwarded-Encrypted: i=1; AJvYcCWcWQq9tsh2wuqUjbw0GZnMopmI3jZWbz0gPXkyXDp3Y5sS+1E6p+FFRJ8GmtpCkNDk1uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBG7qqN1H7yCay8KD65C68M7gEpI+qm6u9ey71IPNvWrHaAViy
	G06SfaieF1lAJJnaS+q4yv5YypXAeU7JuptDgO3RRAo2ty+xj6Th
X-Google-Smtp-Source: AGHT+IE7X2W63UAKTNRSWO9XGwXZO9iL07++i289AKKiI4FdK1IbSjp0rmJoMwJYmxW1vhbJm4SSlw==
X-Received: by 2002:a05:6830:2701:b0:718:41c6:821c with SMTP id 46e09a7af769-7184b3688e2mr5892756a34.5.1729747255583;
        Wed, 23 Oct 2024 22:20:55 -0700 (PDT)
Received: from localhost ([98.97.32.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec135676csm7132611b3a.89.2024.10.23.22.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 22:20:55 -0700 (PDT)
Date: Wed, 23 Oct 2024 22:20:54 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 jakub@cloudflare.com, 
 liujian56@huawei.com, 
 zijianzhang@bytedance.com, 
 cong.wang@bytedance.com
Message-ID: <6719d93625174_1cb2208b@john.notmuch>
In-Reply-To: <20241020110345.1468595-5-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-5-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 4/8] selftests/bpf: Add push/pop checking for
 msg_verify_data in test_sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Add push/pop checking for msg_verify_data in test_sockmap. In pop/push
> and cork tests, the logic will be different,
> 1. It makes the layout of the received data difficult
> 2. It makes it hard to calculate the total_bytes in the recvmsg
> Temporarily skip the data integrity test for these cases now, added a TODO
> 
> Fixes: ee9b352ce465 ("selftests/bpf: Fix msg_verify_data in test_sockmap")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

