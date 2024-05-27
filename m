Return-Path: <bpf+bounces-30684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 080838D08F4
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41261B22784
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC1F15A857;
	Mon, 27 May 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmirMGPN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C91E4BF
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828614; cv=none; b=jQagfF+7D0pfPWk8vUNeLDPxrY16Y6tziEfR+VJqVt+/Cj3ECzqOZK2yFhlBggWA7eFZWAMiZ3403FCeLTNb5EoSGcLC7hV4JetUtHGtzlwB1Dd+8Kl/CCZefIsjZl/VbZzff+92XJjn/1DoyFjx0NfHiYGyFWhBeLuUmHzJQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828614; c=relaxed/simple;
	bh=TRVSm/mBd30f1l12udjKeb4f7aiDZost7G8lwJP45oo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Yt8AaJUWjJwEKCp5i6k2PZWtOpyEhwAPN3BYjn7MSSTaPl/6soaI882c+oBxZTmyUg5XgZcpe7PxnprJzYbnlv2gkbwY/0YMwx0MQ1PQpOjpkADHhWyZ/Ft3wQF9wqAlWSl5A6nT4QsCErKrr7wzO5acAWQ72kjYWrPYgyzLpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmirMGPN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f45d6500b4so16739815ad.1
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716828612; x=1717433412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMkeMxxyqUGb3pVpAqws3hMzovA0EZCtRONC+Ru2eN8=;
        b=mmirMGPN6h+rmnoqu/JPqhp2X0p6bWqevTTLbv7tNYUDwciu1bhxll7chbyk3Uh7WY
         mFvTOU6gnyPOF/fSXdTNHhyZ0AAX4XVOnfimOtoKOlYruWsWwFMu5EE26RqvPezAPtA1
         HzNtGBGErYsIDntispn4v+w6V4yQlRPF92bLj3tLmuSDYdQxAzAmkgmb6QXk4hm/97Va
         eMBpA2nzz3a0r6ynSt7cgXmb0cpUhOuwb+aq3Z5rVZEVZcrtJeQb6X6wNe01zi8B41Yr
         rOOndNYJfRIR86u0qd7FxBvn2yEpczDrc+UghuoMAeD9spR3H2w5EqeBO/zB2fmN8CHR
         bRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716828612; x=1717433412;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMkeMxxyqUGb3pVpAqws3hMzovA0EZCtRONC+Ru2eN8=;
        b=xIPtHcOZNUlmpRAQnje8S5Ojq22Fig1u39SoM+23WfPou9G3xh9R/jG9fQzEU1+VWN
         GKkjq69ewbQX43SRfxOeSjSzt2fxNDYRN6lXIyMkZlhBGAkDMhN1nDQ4eSBbSyjtgCdA
         D9gitYAOF+k/ofnOhESrq9/NxubLBSaPXsDlWiqV+O9UwKTrPg+oiFcMI8G0r7186CCH
         oZwJT+Yxi3S6Yh9QkdXK37HenNjnLNo6AicQ9QoMkMLyWffJ0Sfdgqtznd0JgafUq0Kc
         gP2to6FzqKzkXNgnyvuEP9M/gYbYzHlCD1grKpK5tQYI/AM0t7WzBHOLA1vgh41h9WMe
         2pRg==
X-Forwarded-Encrypted: i=1; AJvYcCVkBD+Cnic/Ceyc0rT19mTlm+RubrHvb0Y75nT70HQKxQ91WzxbprQFnDmALYsGgJUpptuCNBOQGDtZ7w9doCipn/cc
X-Gm-Message-State: AOJu0Yy+w8udnd5hlxwQ+IugioIzkINTrlDkg/t6Up2tKtQCOs0MfGyT
	sS9fCPa3Z/ARsYwODdjt/FPfM3ebGG6wHyK0ijWJaPyJtgakq8ie
X-Google-Smtp-Source: AGHT+IEBBotYOwuiJWsDLpxtnLPlwhFZi5v3hxCuWnCPdYSsAlREktE7PdAt4Yd9Pfw51ngKjFZy4A==
X-Received: by 2002:a17:903:2347:b0:1f2:fca9:731c with SMTP id d9443c01a7336-1f4486d51a5mr106311975ad.8.1716828612025;
        Mon, 27 May 2024 09:50:12 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9711bdsm65205555ad.145.2024.05.27.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:50:11 -0700 (PDT)
Date: Mon, 27 May 2024 09:50:10 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com
Message-ID: <6654b9c2b30bf_1c762088d@john.notmuch>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-2-944b372f2101@cloudflare.com>
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
 <20240527-sockmap-verify-deletes-v1-2-944b372f2101@cloudflare.com>
Subject: RE: [PATCH bpf 2/3] Revert "bpf, sockmap: Prevent lock inversion
 deadlock in map delete elem"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> This reverts commit ff91059932401894e6c86341915615c5eb0eca48.
> 
> This check is no longer needed. BPF programs attached to tracepoints are
> now rejected by the verifier when they attempt to delete from a
> sockmap/sockhash maps.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

