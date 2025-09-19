Return-Path: <bpf+bounces-68925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7EB88AC8
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55B017BDED
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB85824501B;
	Fri, 19 Sep 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xc/La4vd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91011CFBA
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275751; cv=none; b=lpAQCTUeFFQZobBdQBtWwim/laRcZxAPR8msM7A+PZA3pIm7Uk9rzYsolDLvJRZDETlD0FGdbavxE5Brl32b4L/VHHK1keZreCuHyWj12vqL85sBWaH4u2CKgIq86piHIkAzIqyVPjeEMLO5lNUP1+hRqzR85n8vkEEto0xe4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275751; c=relaxed/simple;
	bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5NKr6LqnWIwF/W9GMW2pODLod0RXwvPcfZrdJjU0RyOVB4PUn/Wa+8ICfIn9Hy1JSy3sQsBeAG+T1XZwSMF2IMRVvuq8EjxKT5V1R+tBysHdVcXTXyMeRQ5X8VqueKXEjNTf9QRuaUZ5BtkxQgzHqsYJtOXnXQNyEH88iRfj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xc/La4vd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2381c58941so188431766b.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275748; x=1758880548; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
        b=Xc/La4vdrlq47g21xR53WFqRYbNKRxvRpqWMz3Y1dgypGl1GETmRRc1gSsMiQTe8QI
         mP2gRq+JA8FbBlEb0kGiImEGDR5zbzZQX0/DhqOOWDL2NLwM0ul1p9fVDB8K3UsxJ7Ae
         KN6gTCERtZvkcA3ABafQrmTwGKNmq83YiRQrYjIRkl4XxM8G9ZsVqpovXykhB2gC7PIl
         PktzFAR+Fwbj9960pFz4AxGATYKH1B+iZBoNe1+2CKKmGcoPf4wtUtXSpfyHsgrtdToa
         I5k7NWqEc1JinCsC4lOrsU/8M2/pguLxx07g2io2Av/VHnWZDYXV+roH84QDQDVjbvfe
         oc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275748; x=1758880548;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
        b=C/PrMjC7+ghiiwcRZQ5N0bVz+RFdPW5ckHEwL9g0JzjVoiURKNH94rmV0N0j6dqKU0
         VH2p6ihKRD932pV+1DaTMg68B8FUZfzsi5OzMkNRmP9lx3tH3KIzMIcRVAJ6GNeXiO0c
         4UjRnUP5EUDTe5aNO6wGVVM5MpYT53W2RPZDgOVcSok8Fm5R+39lxdXveiZ5d/4CUDaK
         5ucMZYbbJsNhoeBYevBeas/Ej5bnAdb2F7NSumza/omU+KO5+UGuvfniQhw5qh9WKWW9
         V7L2ga1SqWbHC/DO2asuEQ3ih8pRxUrX64laF3qcCsY5NkEcwu3Cu35/byB8+PkzzvTG
         P5GA==
X-Forwarded-Encrypted: i=1; AJvYcCWYA3JtH4AxvyIO+oVBKziWkxZmXn8/UVvSm7LHR39zSDJW9/1j28LR2xQzMzrREeDhEg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPuhovg3AnGx572W3ax87BhuDQQmL3OJPB7bA8kYLJG5d8jxoR
	g4xXoBJmZ7zsETOFDLSUniS1Y5hmYzK6jyHLoZOBuR4IcwyF6lPWYm6sR1QlYlNHOho=
X-Gm-Gg: ASbGncvMfc+zG6NMGCOPZwJi2QW2qtB1TxMDa9cMU3tSHx8m8Vz+e1HTFlneye7waPh
	b4tawujeh5B+gCteFClEkansbgp55xCxOBPf6mn1bjgqqXs9L12uCpeJzJzVnhYQTs47XjNFoSb
	UameqV/0GfdLnw5u4ZvenEjoutuiQX1qIfesecZEh5COR3UNJdc1+BHU3Pxm9E/Q3yYBzdgqCqM
	G4VnxYZBJKM4c/hkjdEam6oTj0AUTz8wgHAo4HGy6VA5DfUJN2hpNjZeTA+ZdD/1GVf0m9SpSfM
	q92mxoHMJ6pw0/hWYVpEAjTolF4f0Hu5V38ux8/+OOPwyun79LBO3kmvrXuztJpYh9vvDFgzJHZ
	41PgBY6WztQ1eFAM=
X-Google-Smtp-Source: AGHT+IE1IHc5VP8kfmcFvlumd42kggIZUzh0BzhhNdnpQ5w+5s6AXkfMgZqLrpodiCERuhqWgn3oMQ==
X-Received: by 2002:a17:907:940e:b0:b07:8972:2122 with SMTP id a640c23a62f3a-b24eedb8c32mr282292566b.18.1758275748062;
        Fri, 19 Sep 2025 02:55:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394d79sm76152566b.38.2025.09.19.02.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:55:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: sockmap_redir: Let test
 specify skel's redirect_type
In-Reply-To: <20250905-redir-test-pass-drop-v1-4-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:44 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-4-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:55:46 +0200
Message-ID: <87bjn6u5p9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Preparatory patch before adding SK_PASS/SK_DROP support: allow to
> dynamically switch BPF program's redirect_type. This way, after setting up
> for a redirection, test can make the BPF program skip the actual
> bpf_{sk,msg}_redirect_{map,hash} part and return a specified verdict.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

