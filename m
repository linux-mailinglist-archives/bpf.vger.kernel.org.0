Return-Path: <bpf+bounces-30520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1A8CE96E
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F1282DEB
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F993D388;
	Fri, 24 May 2024 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5BObF1N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE51CAA4
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575011; cv=none; b=BNXMizmLL+f0HllmVOKfPlL4EimWkxMgXey/WuMprvlbmcBlqnv547BdUvpvJLeIp/qCk9o6eJlPPV35/QV0PKnE+mZeFWDUek945hZujDeAwwPLexdrAWvR+dAhRa5YR1M75DTvKwILZ0ZtoS1dS/9djjEZsd9N17vgIqf5WXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575011; c=relaxed/simple;
	bh=ssaZ2ZvQLO2+x5T1AnbVNh8qvDSMflzkHf9RSXN9t7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5PkhxHiUJK4bd1Zy0/fFgbj5pEciJA3EZcShzMWZ+OlE8M/BBFZW8VdIjL7hNRH0M9UyYIEgP7rOnn8YN18kdOYU2leo/N1Ab8vpmTT5AJNOZ0jm/vDGqXhK1xGgbUzcDOwLaFRpbDkppe7HOs+wTfHluZDzDIkRWlcM31KF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5BObF1N; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2bd8417d3c3so2384242a91.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716575008; x=1717179808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAohSQ62YVirLGMyGzfikcZH1eASapmzNWEJeAHAMIA=;
        b=X5BObF1NxsgwRyZUMc93SiZ01l/yY/SpIGfivOLmUMtgGnXEAEmAnCUeLiNET//BMi
         qqSbU5SGf+J8q9N2iXSgxi2sRKPju6PryXUzYYDCmufWVy5t7pIY8AbE886bgQuJHtPu
         CeYpj7kRS9J6WXRzGWAjra2WlpUMLHss7Pfsz4bO5bG/bsU+ZV6FBb6DOMLf9pJVieGJ
         FrTo1uzhk10kwg4shXLqCsjoBocVxddW7EU032pYObwPVaIHxF9RSjConOOjmbz4O4Hm
         Za8kmOm3hfbv3Vil/FpxEnQ7y+1+tHHXO+LFnkbiN18+rsYveImAOfmXjvGdO9jkcIoL
         JfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575008; x=1717179808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAohSQ62YVirLGMyGzfikcZH1eASapmzNWEJeAHAMIA=;
        b=w9QEmi9S2UCMhfINbhgyX7uuQrs74yyLwXZvRjRWqdtNMuZrBu42M+1FUmloJAPJnR
         UpuKp8oOGWI5i3ZN5e16aoPWAUgtl8cu8sUyeZjwBV1VRdnZLSgX+/JbrTYK/TWvVI/M
         2OR976FZuI0RkKS1Oideti0TccAv+FR6eFZLSP6CRaOWkZrU8QkakWMMyrCQvSRboql8
         UUL26SJ507wb+AsYIU00u7kFQRKqAmGMSZ7CxUCeQpxjp5n5/7Da4HwQu5WtSmn5BmzJ
         Mlfw9LM2fCOxSb07ig1KYM7pEncpmM98OZPSDqi6VZK3Iljs5jgr/shQb0IpVhtfNsWU
         HrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4wTcmgvOgkjWXRQuEbZaloFF69Sm9mW3pEHpNxIC9I6U44WFID1zu0AOtEjdxGoByuMV9eUDRr09VR0RJ8fqVCpcE
X-Gm-Message-State: AOJu0Yy+u6/hokcTby6X6i6LKZw05WyOu8ycsjLl/r+GPsLhXd45ZcQr
	Ezyf+jHccEbFWmzsjC+C135Y7XvlKVShzQZ7ZdIxOosOc4LrIZjDNWD7R/CnOhavJw==
X-Google-Smtp-Source: AGHT+IHzDvKhdXYqjAO0NqxWnqhEY3Nbf+Yi1HEclwUlPxnuo1q7VEycBUlP7Lw6z9KNCM7cruACNwc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:ec09:b0:2bd:e2fd:a084 with SMTP id
 98e67ed59e1d1-2bf5f407ca9mr7606a91.6.1716575008161; Fri, 24 May 2024 11:23:28
 -0700 (PDT)
Date: Fri, 24 May 2024 11:23:26 -0700
In-Reply-To: <20240524163619.26001-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524163619.26001-1-daniel@iogearbox.net>
Message-ID: <ZlDa3Wk0djxSd2AW@google.com>
Subject: Re: [PATCH bpf v2 1/4] netkit: Fix setting mac address in l2 mode
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, razor@blackwall.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 05/24, Daniel Borkmann wrote:
> When running Cilium connectivity test suite with netkit in L2 mode, we
> found that it is expected to be able to specify a custom MAC address for
> the devices, in particular, cilium-cni obtains the specified MAC address
> by querying the endpoint and sets the MAC address of the interface inside
> the Pod. Thus, fix the missing support in netkit for L2 mode.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

For the series:

Acked-by: Stanislav Fomichev <sdf@google.com>

