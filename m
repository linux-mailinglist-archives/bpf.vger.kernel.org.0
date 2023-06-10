Return-Path: <bpf+bounces-2318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0465C72AC7C
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 17:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DCE1C20A7A
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F10D2EF;
	Sat, 10 Jun 2023 15:07:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAADC15C
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 15:07:47 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13FB3AA5
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-65242634690so2257006b3a.0
        for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1686409665; x=1689001665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+OwDas9lj8b/o3V8lkOk9a6MOfWBvvSjFJASd1oAkw=;
        b=OOATwZuJz1XpIayU6qEWJsTjt3CY+4SMX0O0hFz4qhukDiqKsW+2HfODMVSjDY0PS8
         dM86VQyjvRTSnncMd8NEQ1Y3ajqSyztqwK1L4AHsdyCggJCjMPhoHDYKqNNW/QTmsvkl
         My6SqZzBK775E7qllyKf/D3HPM+CU0UogJlokXdyYcF3DIiOmW498DR8UJaYMOxa4taL
         sO3cymRYwckFon9LanxHS8e9U/hC5GpwfPqq9UwNBxRTStvS4jMi3j+bn53NCB2HcAzM
         zZwpBqsJYUp+qDWJUUO7vVRWb6hTATh/04CW99B7zboxr6WE5Dc4EPBPdzzm3JjPAp3M
         PTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686409665; x=1689001665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+OwDas9lj8b/o3V8lkOk9a6MOfWBvvSjFJASd1oAkw=;
        b=kosLKJXFYASj45xSireA5KlpSLBiALX7ICCuBq3HSZTeU5zWU1gfTP7bnhJlpzfk3T
         /mTDwi0Izmh5+ZWditQR7u+Cf//Zop/UfvdcXuE2G3b1S9KTF3XlZcpwWR8filZ+gayJ
         KZd1eYFWNBDLUB4LSjZFJ/N695DZ2f30pTJ2Wjp0h/bsB37M8YjvdyC8dIIgr4rDgo9X
         uXUfGo1OU06vIfXAYDw7BnDm9G0+r1DL1POhp9abcpnmYvxyxBCoIM++as/lBygkUACE
         dxoF6bv3pjr0KX8xXo4TYfvJlCD2Tb8nE0pWA0Y/2T9AIS4+m+ebr0YAfXqtzsbTJZPS
         lxSA==
X-Gm-Message-State: AC+VfDyljUQGt2/WHnYhPhWf/9n709p2gVana4MbivfXGhU9yNuEtZuo
	eXLHBfSNZTamwLiOTsEuzHtPUg==
X-Google-Smtp-Source: ACHHUZ4r4eCGoy6iuu0IW9XAISMqoeXHH/Fv2bhIfewU3fQ3CD19OKfSes9kinrORhYOGStJ4RF3lw==
X-Received: by 2002:a05:6a00:22c4:b0:646:b165:1b29 with SMTP id f4-20020a056a0022c400b00646b1651b29mr5033723pfj.23.1686409665296;
        Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b0064cb6206463sm4231318pfi.85.2023.06.10.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Date: Sat, 10 Jun 2023 08:07:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yi He <clangllvm@126.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Add a sysctl option to disable bpf offensive helpers.
Message-ID: <20230610080742.5b51a721@hermes.local>
In-Reply-To: <20230610110518.123183-1-clangllvm@126.com>
References: <20230610110518.123183-1-clangllvm@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 10 Jun 2023 11:05:18 +0000
Yi He <clangllvm@126.com> wrote:

> Signed-off-by: fripSide <clangllvm@126.com>

You need to use your legal name not a hacker alias
in DCO since DCO is intended to be a legally binding assertion.

