Return-Path: <bpf+bounces-27552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4BB8AE911
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C61C21F10
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97B137904;
	Tue, 23 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0yEoq0A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EB135A5C
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881157; cv=none; b=cFB6ofVNRoh/G2Cf3udH7blwTukS5NKRiILeNBPpiF2s/r6PeIU688KfpRsUhYnKowgf0/dlB4su1QrtvjTLceRocTJ4CL48vkj+QLoBy5y7v7tDiEYraxTEEJssffzU59yY4/Qx8HOFeu2+d94eYFTAjHpHgF+1ydpKUcBlel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881157; c=relaxed/simple;
	bh=d9Bm1WhOQdr4Rta0AMWh7LzeJO0HpgVpWy/bbXjQwQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ABwv3IHxOnOkDOVPQ3xKcJ5c4kbicWmNlyf2BLkdWbLPdUTw/lIrPTra0dAy6hLZuufoSr6Ovw7NhpWtms6jWVp80LABXjmB5H1v4vpAbdhXCi/VcgmQ2ULtdobH1x0cbMrs3yFAQJ60RbedTz14EKZguAtXhNOLkohWbX0EpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0yEoq0A; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so11453008276.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713881155; x=1714485955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywoHegdckyc2kc9q8KKYzLqn2Hlpw+/QiT0Zcc0zz+U=;
        b=H0yEoq0APPu5Eur7TnOK5jLzVJUGbT9DO8Dg5wsSPbLsid38hWhCvoWq3MUomjQQoT
         OVHlY/0VfFgwtXRfRG2pdWTeFoYBr5u558iiFqzqa3Zcj+VD64+6CaaOnIgmgtn1gN7J
         JuJT4qVJSjQ0aaUXhUMFYaDJvwvBLwDS0vQZLz8XgNF0O+flLKHYGrcjjRpMshUpa9UO
         7g8IzGMXjh+11UlNkHaNnTxzvPXJtX13xeFuyNB4QIEyQ231FZ2o42m2p4ZNk3VGMUud
         pq0Fp0PqcLBIxDRYc/Zk5Pr0U9M6ph0vG4t8K2ozXCFarnihlrBW9j2DwdS8xveEy+++
         G8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881155; x=1714485955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywoHegdckyc2kc9q8KKYzLqn2Hlpw+/QiT0Zcc0zz+U=;
        b=o0ctJkYdBs94U6RKu+aV4Rzh0wSgOD4tsrDNh0yq65IBXUyintiW/Rhjf001EZDVLI
         BJCJdOr8TwTdD8L3SRUypwBtF/2BblC0Q1sPpRS642LyVaJOb8/LKYSe9DZ6pfZQKce5
         gQiyxDFK6C2W1WNxMdUWTjGZqipjqEPzVmsgrgrAFl/aS1o13TQA57F7Yu6t0lA2X0Vp
         zxWeqn0nWPyHTer8YZZsGxdQdBF5GVkt5gkWl7wSqpql0bfhRLRnE63uNKxxv8bQg52c
         /mg6yRTF+m11YLTnJtrPHzX6FdYRvuS+nwClTK5BNmmqCv+vMHEOfgUWJMc6nzLwAx4+
         tXdw==
X-Forwarded-Encrypted: i=1; AJvYcCU/LQw9EVTuaFQcKML6ovxFF0GX55y6p+oRen7Z1Ehk2vMQkOyGDG6/ouLZZFI4EdWj+kzeD8ujR5l1gyGpGG9fUaGE
X-Gm-Message-State: AOJu0YyUg7lOcOITmIa9JfdA+02nrPD3wQ0ThvwvTcto/CjejHtUg97j
	bB+z5awyHPbaWvO5LnIyT9uCAKHqAaSZbJfd1JLCAVHWVgzVv4EuRpP0b2q4jldx/Zd+wzUSySM
	TVQ==
X-Google-Smtp-Source: AGHT+IHbDuY06ri7HefBWokNt0j4rfiXvA7toVdltviloE4D4hhhUr8Fo45UnsV6yWKsY6PE8yzd9/+srAk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c03:b0:de5:2b18:3b74 with SMTP id
 fs3-20020a0569020c0300b00de52b183b74mr1794704ybb.2.1713881155316; Tue, 23 Apr
 2024 07:05:55 -0700 (PDT)
Date: Tue, 23 Apr 2024 07:05:53 -0700
In-Reply-To: <20240423045548.1324969-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423045548.1324969-1-song@kernel.org>
Message-ID: <ZifAQY9yS4U3oEkT@google.com>
Subject: Re: [PATCH] arch/Kconfig: Move SPECULATION_MITIGATIONS to arch/Kconfig
From: Sean Christopherson <seanjc@google.com>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 22, 2024, Song Liu wrote:
> SPECULATION_MITIGATIONS is currently defined only for x86. As a result,
> IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) is always false for other
> archs. f337a6a21e2f effectively set "mitigations=off" by default on
> non-x86 archs, which is not desired behavior. Jakub observed this
> change when running bpf selftests on s390 and arm64.
> 
> Fix this by moving SPECULATION_MITIGATIONS to arch/Kconfig so that it is
> available in all archs and thus can be used safely in kernel/cpu.c

Yeah, it's a known issue that we've been slow to fix because we've haven't come
to an agreement on exactly what the Kconfig should look like[1], though there's
general consensus to add CPU_MITIGATIONS in common code[2][3].

I'll poke Josh's thread and make sure a fix gets into rc6.

[1] https://lore.kernel.org/all/20240417001507.2264512-2-seanjc@google.com
[2] https://lore.kernel.org/all/20240420000556.2645001-2-seanjc@google.com
[3] https://lore.kernel.org/all/9d3c997264829d0e2b28718222724ae8f9e7d8b4.1713559768.git.jpoimboe@kernel.org

