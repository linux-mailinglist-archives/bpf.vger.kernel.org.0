Return-Path: <bpf+bounces-61012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7BDADF9BA
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 01:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC793B2B28
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA873281365;
	Wed, 18 Jun 2025 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOZZtNPq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FA20A5EA;
	Wed, 18 Jun 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288968; cv=none; b=pTazZyROtVKNjNvpbtmptkj/rjp2jze7RLU4nwbUtTtn2BQR7yIalsnLCqpiSlxZmoDEMQ4HkKpmAwwbjVOxdPMek9ke5Dzfh2ZNtaDU99FabSPESQSBpSEzu+wTc5DSd30F6Qt11HRth0o1vrYZI5eEkviAxuVxbGSoBr8YbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288968; c=relaxed/simple;
	bh=2Jh8N/RnNelfFY1DTUN7BBE/Ny8GXBQN1Ajac0ILru0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYmbKHQnodNaYFPb+8Q3gH9EsqYXhQvN1/Q6sL7DLlK/Hh0PcGzdDArH1Nf01E7jbb2PNEMbYKVT0fWvl1hfs5mFusLqjzRTbKM6lAZxYa5Ad9vdl4YL8PH8TRVyqaIok6TBgEljZYzrLG+GoXPkIYxG/FTLxX48LRwzFuinWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOZZtNPq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e378ba4fso200524b3a.1;
        Wed, 18 Jun 2025 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750288966; x=1750893766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0g7L7ZDMeHK1pkRh2Qw8KR1qnyspxCM85YKsIf0ab8=;
        b=jOZZtNPqYWyaUZoa7bhrHUdpMRXrjyD+pMcxrCEm3h33v+C3kdTrkJxwL0ezv1Sqkj
         3NmtZ5sII82GtM+ThnNuuFH838LnTtbw4cHwVxfVZrLVsJd/rcINYP5mtf5peLueauD7
         u5JuTtcAAzS/Wn5+DyZ0N4e2NBI9ZYEm/fidWxSM2PkTHqNZESvrc5umSUG+ZOaKruvT
         DaNGcS5L2uqwAH3N8Cl403L3diGOGKAUDN55GftHeB3n6LGlm6tSE2r/+gB9LpyPBwLN
         S+ZZqvut1gpAo9I2gn+wuxlB607FUXOy+Cbic1+vrJUrpfx1m9HQKeRZv3byB3gcYyBm
         X+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750288966; x=1750893766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0g7L7ZDMeHK1pkRh2Qw8KR1qnyspxCM85YKsIf0ab8=;
        b=Z3NgmbkFkmNHCP+IXgqX0pqhFfQ8Sa1Jw/l6gCK1GDKfrqCG0E25ZwDIOzyf+uJRs7
         hhChyRnvnkg93FOz1xPmBKFf0QJY17opla8ZSUTDMBn5cV9yqUfKuO63wlRHi2HWm9rt
         ggUPOjXX/sRS+7cu7N4bP1uIXb7vNMWF9LtYKm2v/Pcaq+Ns+VtAzjTVAaLnvZMdtvrB
         EgHANCnd81iIF6JVF092j4uAIJliVBD/ldNVupnDB9jzh4CdO6lz+RAsaMk0WHiD51gC
         7Xi6LBQF5wmtPa5dTkPRtVvQg1gZioXFk3HmlzencaQcaO0lazwKgPCZjZ2/AH/BthAZ
         oKyw==
X-Forwarded-Encrypted: i=1; AJvYcCWgD6oNkiDz8rvSdS7QD7M0jlbntd632jiomjOxfq/XowqNZe6J3Bp6b8O1zjZkPkV91i9WTJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypcCK0wdK0Lk7CQFZrOssNKPe+W15gQBxtBS0qm3jxz3BekKWW
	JwzW/m9icdf68DcNle1ZAbKSJ3hFzpQYfo1mZf+6XvQtQuRHMZwOuhAZIXuI
X-Gm-Gg: ASbGncsyUJkjfBmZ5v9dA1XcdDjxx/hde8N5ULObYxqIkk62wVY/+izeRpXh5bAz4x8
	aF2Z867adqyUaSgbOv/pMruFVxN73B9aP8REcyi/0Go+ozE0XRLBGoxmoj3EclyUFDDYReDl3Z2
	bZkkVhrSTEIy1484kk2AAcJKxT9h237cHYRnXayCZhHBrvCaFGG4RUsRBhsjVDIVxwGyltqSgeK
	A74fpO0CN6a0I3N2QBWHPObHMAxTFN2rgTbzUmsXbTsBKbQpAuGuqn9QNhJqazfFnePHwqnwsUQ
	B6tIbY0dEdk9npsD4DSfagF/072Qw7V+KidJUpPPQvSO/t/FOm8rP7H9fxvbbd3bVwI8T141yZv
	b/i5Bgo9nHO8cCB/l1s00iL8arCvojH1i8A==
X-Google-Smtp-Source: AGHT+IFFKv7n8oUGaqWSXMHbW26xg9YHvVSs6wlrPC5Qx6zyN7T5lwhw7Z3xEDcXi7UCUcpd7JXKSg==
X-Received: by 2002:a05:6a20:729f:b0:21a:3d97:e93a with SMTP id adf61e73a8af0-21fbd5d9253mr28824725637.42.1750288966081;
        Wed, 18 Jun 2025 16:22:46 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe16806casm9854241a12.50.2025.06.18.16.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 16:22:45 -0700 (PDT)
Date: Wed, 18 Jun 2025 16:22:44 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	martin.lau@linux.dev, a.s.protopopov@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH bpf v2] bpf: lru: adjust free target to avoid global
 table starvation
Message-ID: <aFNKRMETc0nh82LK@mini-arch>
References: <20250618215803.3587312-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618215803.3587312-1-willemdebruijn.kernel@gmail.com>

On 06/18, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
> map is full, due to percpu reservations and force shrink before
> neighbor stealing. Once a CPU is unable to borrow from the global map,
> it will once steal one elem from a neighbor and after that each time
> flush this one element to the global list and immediately recycle it.
> 
> Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
> with 79 CPUs. CPU 79 will observe this behavior even while its
> neighbors hold 78 * 127 + 1 * 15 == 9921 free elements (99%).
> 
> CPUs need not be active concurrently. The issue can appear with
> affinity migration, e.g., irqbalance. Each CPU can reserve and then
> hold onto its 128 elements indefinitely.
> 
> Avoid global list exhaustion by limiting aggregate percpu caches to
> half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count.
> This change has no effect on sufficiently large tables.
> 
> Similar to LOCAL_NR_SCANS and lru->nr_scans, introduce a map variable
> lru->free_target. The extra field fits in a hole in struct bpf_lru.
> The cacheline is already warm where read in the hot path. The field is
> only accessed with the lru lock held.
> 
> Tested-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

