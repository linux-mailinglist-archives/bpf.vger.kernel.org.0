Return-Path: <bpf+bounces-78706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57333D18E4A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D810302AE36
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F93392B88;
	Tue, 13 Jan 2026 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NH11nssh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A638F940
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308050; cv=none; b=cHoYogj8743WZvKOS3NFiG91Wl/TnoW86zDhK6UUQ7ckrPRCQxOkAaP1y3bqppi0NH9RIAiYGxQvUiQaUnm+9SxyeOzVWJlzbIjYABYAPAhcXAMDEnDF6rIYG/2WkmbHsm1vlgskfabXIkr69VtGro/VElD9+6Yo8+lIK4mXFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308050; c=relaxed/simple;
	bh=oo3D+KUuyl/yK0+7LdxWePxgnNUD84eN60bLtmw0kwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6NYrQ3U1w/a0n7hddKZgFNis/zo87hJFGrDrrJEp4QpNMo0DlGCnSZDSlA0FcE2Vo/822teKtLc5HW1Y5085mHUNyGvS/eWwTzroxIWe61De4cnL1uwpsMUdhVX2VOZKq/qI7twJEa2MJ09GR56YSvUZuxdfNFzIMNzYlmuteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NH11nssh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so10222966a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768308047; x=1768912847; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oo3D+KUuyl/yK0+7LdxWePxgnNUD84eN60bLtmw0kwY=;
        b=NH11nssh+k22p7s8RSm9iDuub85Z70C/jSb/02d/cC24gF+iNC0atJZYnuw6hFTYxc
         LO0/BAyIwsyQtKerxaS/2Mem0wVTakN218J8wY1ULWaorNuJ7t128P+oOL30wqVkKHXB
         UpyVCScIK6a4+BaKtHXh+0Kn9iolI70z0sLaO9P4DA0FrykDQEDEpD8z3TmV1atUoS0u
         brxMPpw/JHRs9YfmKPdrriMLymOv2eSAxkCBwTeOrQysOJkSoSAZBhGYchvLt1VIQOuE
         Nqhn1+8dMiiolSPDJT+dz0T1yoSsB6MgGn0a9BvU2vwZcA8ugV+EXU6q9GFjLsdVKY7k
         RZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308047; x=1768912847;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oo3D+KUuyl/yK0+7LdxWePxgnNUD84eN60bLtmw0kwY=;
        b=C0gAgMwNqZFuxgxuwTMaYEmRLdXktRbUTEFHSxmldEnLIiXeCIgB93Zg2wgtQ7/SBz
         gz4feWiforL3Uq6QHi5cxFxpu5VnLCKQlWDU4RCtF2z6ovrFbnQKTFMF1wWXCEzZdVbh
         I7jZYUPC06QKlsy1Bl0dmhDh84pH3dYXX3oULasUTBwaYASc598u8b/byFu3kRB210+/
         XrfvzD070BO751KWnICi8O1yHOPoJO5+2tW4LHMhXYJ544bgKEfL28hjxTtq8Val70Hz
         Ai/oc30vE3qUI8llB/UFXuIF9974ZhgVzV5eXkAGeFoN+E9AIduxx5kFTv5JLk2mFJMS
         AiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO2Cg9t8yL8VQ/fRERdwHaqMz9mRMsJEzs96QIETyGPQ8XqpXsZKfKaxpYGkSFjOsGolc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/1zSQ7MtWnaC08u4Dp3iIkkbWccphLULqsWdRRI00lxqcHVP
	BT7hrlZPwPFT8rrPA//GbM93PcKym01SiJute2zxDDQXlAmuVYQ/kpBSW7TrOcRiPQ0=
X-Gm-Gg: AY/fxX51lxeuuHqDr/LkrVkWbWOW/gGZj9nCYKOuqYWspBnv9cFUSbKKsU4t9YjXHn+
	RIHc5l8T9xS243YIFEl65OWfEROq92z/Q2s9wG4ZtVsHWk93wAmWb6yxuD0VznDuhkuCKNXQ6zb
	/hXbbRFlMGXI3AX8DHXpJNPdQKCXUg0EBXP8LY84kl45qdIrEepUYK8mr6BW+CbkLTQRoDmm+VE
	EvQ4m/xF7e5EYkwJE1kVmmgteGt/bn7OVXjkQSurGaMAmB6Yq0BDky5DhSLlnsugy0RzVq7u5/V
	J/7S3nYsHgVN3YrY+awK4nFmRgqiIEY6rCMbDi2bCee8HnGgp2xPwTFQKr7KPI5QJL+0XZq1P95
	YOMWLD8rStuOoQ9H/TPuPnGBAvTmWKSpmnkctVeR8Dxh8PnoiqWSPzrga7oQ0pAudlpMMC7XjXJ
	bQVRRBqmLniUGp
X-Google-Smtp-Source: AGHT+IHoJX3rCd0dhCoGHhRCveaoE/dAFFrqPqKvVA8s0p5/eN32SkcJ5IaE78DU2yIQ1+O6SF/OiA==
X-Received: by 2002:a05:6402:27ca:b0:64c:9e19:9831 with SMTP id 4fb4d7f45d1cf-65097de5b1fmr19532557a12.12.1768308047256;
        Tue, 13 Jan 2026 04:40:47 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:1cb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf65ca0sm19578895a12.24.2026.01.13.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:40:46 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Simon
 Horman <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,
  Pavan Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
  Przemek Kitszel <przemyslaw.kitszel@intel.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,  Tariq Toukan
 <tariqt@nvidia.com>,  Mark Bloch <mbloch@nvidia.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com> (Paolo Abeni's
	message of "Tue, 13 Jan 2026 13:09:45 +0100")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
	<36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
Date: Tue, 13 Jan 2026 13:40:46 +0100
Message-ID: <877btlwur5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13, 2026 at 01:09 PM +01, Paolo Abeni wrote:
> IIRC, at early MPTCP impl time, Eric suggested increasing struct sk_buff
> size as an alternative to the mptcp skb extension, leaving the added
> trailing part uninitialized when the sk_buff is allocated.
>
> If skb extensions usage become so ubicuos they are basically allocated
> for each packet, the total skb extension is kept under strict control
> and remains reasonable (assuming it is :), perhaps we could consider
> revisiting the above mentioned approach?

I've been thinking the same thing. Great to hear that this idea is not
new.

FWIW, in our use cases we'd want to attach metadata to the first packet
of new TCP/QUIC flow, and ocassionally to sampled skbs for tracing.


