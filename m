Return-Path: <bpf+bounces-35747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCB93D7BA
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40931F23B4D
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775E17D342;
	Fri, 26 Jul 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B0wnUgTg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B117CA06
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015370; cv=none; b=spWDfYb+XgJgwUTkOa4vp9lKfwLTRW1uRRlYtcfdRaDGFeway+PRSEslC7aUd9SgjL/MZCBoU98lyqkUcsWzFTj9j8G4SWqKFXrgIWiALJ1yzY5/+o9mUORiZQpKQJnLEpSSkPcOz4HkNV6oRpXUSLpkhRHkmY6ccLSsd1NSAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015370; c=relaxed/simple;
	bh=P3XyIo3R4arE45x8ffW/mmiyN4CSBGFSQO01bTvWo8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FgwzBgajEf77XMqlb4qO7YTj+3lmKbkOrtf/EQu/B696uinUIOKKKJW0PACwA6qTrJdeb7gbq9udTZTXj+XoOdk+IrdK0tlAPpJhzrrcCo1XRWs2+GRPLPq5YuwqPH0E1Fbr22/CwFz+QYH+Bt+ZXq3KsJTzaZU6imFg+L/BUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B0wnUgTg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9a369055so208627566b.3
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722015367; x=1722620167; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ho3v43VUSeiXA5xt2OR6F6u287xxMm9s+P8qGJiEG2w=;
        b=B0wnUgTgOW2AVpThET/ZEPVIN7EF4O4k3XBoMoGhjmA702g3lEtw/SAsUZVDGLg2/N
         5izsB0iaYIMJ/ysUkg17m7BdPT8fThbvU90k81+amEcJ2DK4P/eX+SwCQ+C8Z1elM4jE
         X9nQHonEj3tqNvUqk3UblsxOaCGZ2bDNM98jurh/Ikl0w+Y3e+bV95ygNFiZ4MWhlmLl
         SZJT7BYFEAu9qZpLel0JMrbBJk/OTb0JO1Fjwq4HeO16amIap58EE1o3QcWs2VUofo12
         QVOY0yy4BBuKJLCLLUKfOfVtsGS+NeancbiawEyhRpM1uzNCkB2LvAlqqLlad+rQSEC2
         cYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015367; x=1722620167;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho3v43VUSeiXA5xt2OR6F6u287xxMm9s+P8qGJiEG2w=;
        b=RGHNpCFlqSyIoKAWFfW+7WjwOaf1iAqb3m0Hm3wO/ANptRd05RmHWDyErhE172DOPv
         biFOQRnFyn+YAxkE2sO7qQf/NTr0vJTLt/x1aOHe4kcNbInDzVnuHSky/oyCc6Auy4LW
         cSFKv1O9J8rm2cqbK2elTU5OWii+vU+uxydkUIwaarUCraVuAYWM696PNtuuhYZEFNdf
         tZZ5hegZYPvJa9WT1LCpDIlJiqBxi6GBSu3ArXISdsQteLctTooz+cfb9fWszIhi3mSj
         XAAPSNlXNfOqPYep+awQZ1a9HTuvuWT4emrZv8An/UkrBgw/KnbJGFd328OFDtxLD75H
         hlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAHY7w3ywxd408WOQoLBsKF8bsh56e5KXTnqoG84SKlmlJDfxMtvnwEGZ58567/P8Uj4GhtZVjXOnFUyfy1QQQe+B9
X-Gm-Message-State: AOJu0YxTaL68cjtSC8ensbntflo4f1Yk9SjoNlneu0TidANki1ew41hP
	o8ktg28YiBzIeqU/D3ZlJM8h1plmyApxVZQ6R1gJG53ZFAyi+LU+qlgcekKgJeI=
X-Google-Smtp-Source: AGHT+IHAAs6rashs3VUJdqFq7L9KZw0J+O+BWPDkdi/7GTQuTGrXRGsfwBjXUcOXij9YKstTeHW0KA==
X-Received: by 2002:a17:906:c142:b0:a77:e48d:bae with SMTP id a640c23a62f3a-a7d3ffe7145mr20773366b.28.1722015367224;
        Fri, 26 Jul 2024 10:36:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadafd9asm198150266b.187.2024.07.26.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:36:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 0/6] selftest/bpf: Various sockmap-related fixes
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
	(Michal Luczaj's message of "Wed, 24 Jul 2024 13:32:36 +0200")
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 26 Jul 2024 19:36:05 +0200
Message-ID: <871q3gkqd6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 24, 2024 at 01:32 PM +02, Michal Luczaj wrote:
> Series takes care of few bugs and missing features with the aim to improve
> the test coverage of sockmap/sockhash.
>
> Last patch is a create_pair() rewrite making use of
> __attribute__((cleanup)) to handle socket fd lifetime.
>
> v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
>   - No declarations in function body (Jakub)
>   - Don't touch output arguments until function succeeds (Jakub)
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

I see this depends on your previous series that got applied onto bpf
tree, but this seems more like bpf-next material considering it's all
tests, and a mix of improvements and fixups.

