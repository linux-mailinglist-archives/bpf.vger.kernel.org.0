Return-Path: <bpf+bounces-55019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEADFA770B1
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 00:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F9E162F27
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172E21B905;
	Mon, 31 Mar 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Vdr8F4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F13232;
	Mon, 31 Mar 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743458586; cv=none; b=WE8NRi0XuuEJEoIstXZf4mAbn69Vp2595ym03c3B1nTzhlPT1vs+kyNHd20qLaNyTw9tnRPXH1F/JBxmohtGvm3nXxJpjfBE2YaaFGkJLKdBV6u8zHvpWoylKLPZZG6wPhgweZnrzwpEA4pEEwvi9MBAo8lEMy2rR22ZhzabO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743458586; c=relaxed/simple;
	bh=5Y1YNe48IJ6eHoWhlzWgmx+Ygr4JwdKwKal+H6jYeM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMyMPD+4OJ6aCAhjAWFZMXKceVVGyc4vVXop/yLEhKpV23vOzm0/ULD5rG9HrhAgVOTiFBXce5ptEqlzysFbbbvMSpxEEqsCtCnYyifS3jJ9+26QmNg4+Rcz0eP8ZoR+jdM4wHgiovLPPZlbUMt5w5XscVRdLzIpqcPisxChVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8Vdr8F4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2260c915749so67699625ad.3;
        Mon, 31 Mar 2025 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743458584; x=1744063384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhy55FXbjuSeWpQNxxQDj3nYTDnqUFwtJ+9Hxlmr8SU=;
        b=X8Vdr8F4n2rhWODvXvK4ItqLWiWEr4Bp/G0U8Tbo8gE1EgxvUmXTZ/Z25lMN2xc7GB
         UD6wWzwH+jFb0sR9PYZxGN42xqVrFn5karV/sj+ORRrPZ5Qv3Z066goss9anfKHdZVa9
         V+MbM27iuPmhB0c1gYERAqxDyWmRdoOLmdqe2kRQfDkX3Q3lIvsReSaqadLkWGHxxL6N
         euNcGtthclliHAfFXy5joSW0k4n6zkvSWlK2MmXkXk+ZF+u43s63IoBEnmnPlI5IOuzd
         hdWw8OkCOwKj1/FqzYu7kWmzY9k/01TCVwrdC80ppgsFMh9CzPq1Eto1EXM/nVxHF58E
         Z91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743458584; x=1744063384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhy55FXbjuSeWpQNxxQDj3nYTDnqUFwtJ+9Hxlmr8SU=;
        b=bHGiTdee6RCixi8pP7d9VRDKNSDqPF6J+8fbYtuxN/F0MI+pl2m8l2Sx2rp2Ogtk/4
         lW7/PZOE/c8pNBAsEKd7lHRjY01M9h9YmBd3B95KaLPyls4ln2+Uv93HDAa3gvnwHIks
         b6e1z5e5krHXs+ApJAxQ1o2HIakfw3guVAsA1j/+5pTZ2XaVsX/Bj4d5amhoJR02IQ9j
         m5vNaf/VSiyOrWI0Ays22KmhXnHi+8OCBJ+hGPBCr/TyhncZNbAil+kv6e5R0ycPKUMe
         dopf/Wubad1emSKiNnXiTnfYgc7GMqSRjR0Vkcy2dCPirXR+L7iOi/xnfavcbKcprlGz
         bZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4CCY8JmMHcjPhx8d41vhFT+vNweT5IsXZNo9vJkPZkf646pbqV0Yl+70Wtks9Lh+c4BTxKW0M@vger.kernel.org, AJvYcCW/ZXeU07sIrromst+j5mmbtIiCRqQURpV4sXQ1jKpzU17+hYjkgdiqwmmIqvwUq5sHcbZaTDDSOqrkwOXv@vger.kernel.org, AJvYcCXye0d2fgIqgFPG4DS1Ky9yN4A0AR2j0B00qDOTVpxSNuwFDQCAsozJA7NZlwNOOo2p5dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0crKybVRN26pTf4K0PgXPJZeuu2YB7ZhQNSdS4jBBp0ORjDB
	D2uYe5y+/gjmHw2tJeNKwWBX8GaeWYwgl2GASx9513BzMg7Ovm0=
X-Gm-Gg: ASbGnctAfuB2k0oQLFJy28EluDyGOW3nTl82mkfzlYk8x8rZf426gizejxKinvUhTVq
	SS4VBEU17fWcnp6f4rl6wmLVYWX5xYPNpetQpyqHFeN6nr2LeoLAPQIX64FDXxHUGQN1LnGvtGr
	nlgaek/MND4kN1EXY9G80PAL7fVPozFBV+/byzdZDJeavwu8Y+t1rdDAS72mYasXq+yrG6f9z/B
	G4ki5XD1BTNlFlDadHdB3aHMzfedYAW3SpxK8uvHWNYq4xHOmFaQfEcmTdY+3H7jDUw1enB38AV
	2z2j14ZGRdsSMXj9BmNr12aqzK5yizxWPLWB9MME0dvt
X-Google-Smtp-Source: AGHT+IG5Ts6GaZrxroHurdYwZP83LnNuGfuRboC/7tFmI7N+BMLA3nuz8cOEWStQneT8WJodLpiGrg==
X-Received: by 2002:a17:902:f643:b0:224:249f:9734 with SMTP id d9443c01a7336-2292f943ec9mr171156555ad.4.1743458584361;
        Mon, 31 Mar 2025 15:03:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1deeaasm74257885ad.177.2025.03.31.15.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 15:03:03 -0700 (PDT)
Date: Mon, 31 Mar 2025 15:03:03 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: correct tx_ring_empty_descs count statistics
Message-ID: <Z-sRF0G43HpGiGwH@mini-arch>
References: <20250329061548.1357925-1-wangliang74@huawei.com>
 <Z-qzLyGKskaqgFh5@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-qzLyGKskaqgFh5@mini-arch>

On 03/31, Stanislav Fomichev wrote:
> On 03/29, Wang Liang wrote:
> > The tx_ring_empty_descs count may be incorrect, when set the XDP_TX_RING
> > option but do not reserve tx ring. Because xsk_poll() try to wakeup the
> > driver by calling xsk_generic_xmit() for non-zero-copy mode. So the
> > tx_ring_empty_descs count increases once the xsk_poll()is called:
> > 
> >   xsk_poll
> >     xsk_generic_xmit
> >       __xsk_generic_xmit
> >         xskq_cons_peek_desc
> >           xskq_cons_read_desc
> >             q->queue_empty_descs++;
> > 
> > To avoid this count error, add check for tx descs before send msg in poll.
> > 
> > Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not support ndo_xsk_wakeup")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Hmm, wait, I stumbled upon xskq_has_descs again and it looks only at
cached prod/cons. How is it supposed to work when the actual tx
descriptor is posted? Is there anything besides xskq_cons_peek_desc from
__xsk_generic_xmit that refreshes cached_prod?

