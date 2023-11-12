Return-Path: <bpf+bounces-14946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F57E9233
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 20:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BA91C208C6
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524D168D2;
	Sun, 12 Nov 2023 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuCktuL7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E5168BD
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 19:14:51 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB42583
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 11:14:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0737dcb26so4444863276.3
        for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699816489; x=1700421289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8u8Zu/4Nclk+G3sJJf3mP2PcsPtSmnzmZX9K/gDNJ8Y=;
        b=WuCktuL7LVuu+aQ50oe6iRyta+2KfHdOaIZpTPqep8Z2H7I9CLlbfm15HQ0zjVvSwr
         D7cOnyFOgAmydcJEEwROZrMheLqfqa9paF/PzZbPpKwuShi9aMBc7laNhudj9QtjvnF7
         E7qUWNv9yJPNE2M82KnzCEl3tGQU0iNGg2/vak0+itwXww546BEVLTiyBGxpy2LK0FGW
         SIroUQkkP1SD5w677hqzbWtPgCMXNMJiYcZPgfeJTtEbixIT6TkZBXkbA7B3R+aQdBpo
         1BC+19GGH1/oKbqJ/s+KV4EKMqn72BmapKivfAVWhayymehasMVjqGkKbKJsCJUw8QF0
         gdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699816489; x=1700421289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8u8Zu/4Nclk+G3sJJf3mP2PcsPtSmnzmZX9K/gDNJ8Y=;
        b=u/+mnKkiw3PNV2L6NIvWq0j5K6PVwM8MU1foi4MajoSgwEQ5jfvHQj2EFnLkJws/4F
         i/dJ6qAOzoeeKs0scm29v6Hy+WB7SHibqrctmrt7tsihsuutCRxskRt0crOTU2FFj9Tp
         2N2LMaUeQf/sVBHBN6va7uT9q7/NUZilSe77advYiCqsZ1zqvB7Tuv4WLcGmITZQ2i9g
         rsdesYOZmN8M0iBTcNeCj3lZf15TF9uc83GZakBahl4sxLmO7ZDsNCtC4RP9hnIPz/Cj
         1HH9pXr4ozeIMDEB3rvTbRfkHi870BnBLHXvN0AlBI8xMr7U0SUSYco8ME9Cm5Ha94Wf
         WHpg==
X-Gm-Message-State: AOJu0YxEqC1uFAo7wZYLP38od4FBkvXrvBDmTG12opwtyJbKJhtT4Jca
	S7vwGqAgtfXTJ0o+KQmTD3xzpEs=
X-Google-Smtp-Source: AGHT+IEsdrSkurmFg7TNhtoBzQzZs8huZFDWlP65Cvd430M+9iQXF6DmgEgkEv6nV0lbQoiDoQEWfIE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:7644:0:b0:da3:a4ae:1525 with SMTP id
 r65-20020a257644000000b00da3a4ae1525mr122969ybc.5.1699816489316; Sun, 12 Nov
 2023 11:14:49 -0800 (PST)
Date: Sun, 12 Nov 2023 11:14:47 -0800
In-Reply-To: <20231110175150.87803-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110175150.87803-1-puranjay12@gmail.com>
Message-ID: <ZVEkJ9waaH9X11GR@google.com>
Subject: Re: [PATCH bpf] bpf/tests: Remove test for MOVSX32 with offset=32
From: Stanislav Fomichev <sdf@google.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On 11/10, Puranjay Mohan wrote:
> MOVSX32 only supports sign extending 8-bit and 16-bit operands into 32
> bit operands. The "ALU_MOVSX | BPF_W" test tries to sign extend a 32 bit
> operand into a 32 bit operand which is equivalent to a normal BPF_MOV.
> 
> Remove this test as it tries to run an invalid instruction.
> 
> Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com

Acked-by: Stanislav Fomichev <sdf@google.com>

(based on the fact that emit_movsx_reg doesn't handle 32 bit case under !is64)

