Return-Path: <bpf+bounces-56437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8982A973AF
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DB7A7D0B
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8601DB154;
	Tue, 22 Apr 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCdDxSRJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C271A304A;
	Tue, 22 Apr 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343587; cv=none; b=CW9SvBGLz0lAHBoER+Cg5eNbWc/pSsMXY+FjjzBSYRPiuNMZuEfJbmjGKR8OXvnyRj1sFSDgIEHsvMiGQneyma6Nm9qN6lrbUHOqWKYUhMVRZodAcEoaTp16Dbat9CyBw+JUhchzeWXw03rnnqIamidn6ZYvGXuJJE/8WqX04gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343587; c=relaxed/simple;
	bh=3YZFzxOuKJTu8Q1FGxg6Bi9g2E5JnxHXdcJm8VS/K0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL3vGEoXnFCQclDiEeZbiGgg01ULgua5kMAQHFOYM98Hr0dAEDDvOO8nCwhIZVhy1EYNoWxggz3Hd0yjRiFBZwk/vJrKma7IgqDvLRIiL9k9j1MKAF2cg2ItqYdExCZLOQNhcUCj3X0Sy74Y8uwI1Li6yzfYFkM+XieT9t8mr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCdDxSRJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224019ad9edso77710115ad.1;
        Tue, 22 Apr 2025 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745343584; x=1745948384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anhUaw1RW0p1uWHnHVQxnFlleHgiv10T6B9HOPoc5+k=;
        b=RCdDxSRJSr9md71gMVp2kAFb/P4i1ikH0zRR3U7BHn3y9eID2w00J+Ic1jsRFOdseL
         Fdodo/Jsf+Smgn4kWrBe1FfJSG0ZRydjMO6WrgxnEDrTb/eMdyUZ+1GjCfaDZ/1GBBVS
         4emCTL8BqaY9heqak2B0teUurP4CGTNnEQ9GuNugK2yQoYNK+Y/LAD+Ri8Un+bpmQq0U
         x8Ov/gtH9Npw8pOI01cPOh0IA7ik3aOo8nxQM/fwEjB7p9vqoYI29VkmH12C1iHQQWbv
         hRR5cT+dTi6kAm+P9yNGs92SvlGIBlTznSkE0Wd9L9nIe8gX7tQnouBEeuY7qPmdh1Lz
         aCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343584; x=1745948384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anhUaw1RW0p1uWHnHVQxnFlleHgiv10T6B9HOPoc5+k=;
        b=e64JHEnTo8appmYeza7FIAbVhMNQ22ti+Rapj0Sg3PiRDtkEYr49AkjJR8MrEoCZYj
         8CWrAx5iKUjP4NO9zKDhGfK5naoJi6YqC+BUfUrCI3hMUjtkYiANVDTOrr8inCw43kNO
         djAGKcUYExQWzjhPhhuZR4yZxlJneBcuEwgSkTsa57+qJzpN/DI0ionrK5n+okrsYw+g
         wBgscAA5LeODdwejdHcFb88S5+sPSANHln/pTWNdISbn8sL45mK0bktrV/DBNy7lHHdN
         wgEMX7Qwa3VfX3ItZ1UQj/yAO8p3pFrg3C6fyoKgb8iZeUFwnFtwlGpOMsu9yK+F/WmL
         iI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6/DP5YLDvEgNUDzVkx/hdgCY6WhbG7pQipGQHvhjhZttR30x6524zP57pGeZjZVZa/UKnhlyiqOkTx7a+@vger.kernel.org, AJvYcCVlhh5ZZNC1X30554KXUGMASnwZHjIGd/LVX/YXwg0MDNgUX5gDRiUlr9i33Pi6hLEY2dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYUHEDuqdwVNzLtW3wNwRUd5KjYV8TDj8FLnGOizoOxDwxFUj6
	ggbAy3woE5CghG8yElNeeTG/NUGiJeyf6JVDn7BELi0V0a1Jus4=
X-Gm-Gg: ASbGncuwkYWaTTwa/wd3QFHXU4DG0P0fA+VgSOlMgx/XbjK09Iqf+0QaJ9NiKOGpb2U
	Dda/z2mkYGIMiDaPyxC7Mm6rn91ZLiNVkh7TwGSjJ/uO3UNOZJZWWxldzVOT2l5+ZDZ+usme6qM
	pSnZo66ch1Im7soZqO6Dx/wGK4NDF3krC0rz3tpzEB/sZIJsvFcdeQS4xTTc6m4f5nNUK06m72D
	qNNssMTm0WN4cHOSJp0gdeorXaDPc44AelbrTZJ5uHddRlwaWNQnW7kaOZ8nZ/OzphoZaiEchY4
	BDY2wKT5BJ9MugM3JE3VYL5WNe5bClJvW46FDi0N
X-Google-Smtp-Source: AGHT+IHvr3CHGB3eDx2bTmct/OupIJFB9ySp0TkQI8A4cDHpuOWfg/rg1k0f3jpJcDBOwp937CEu/w==
X-Received: by 2002:a17:902:d4cd:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-22c5364235fmr207110085ad.45.1745343584621;
        Tue, 22 Apr 2025 10:39:44 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bdb34fsm88466805ad.31.2025.04.22.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:39:44 -0700 (PDT)
Date: Tue, 22 Apr 2025 10:39:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] xdp: create locked/unlocked instances of xdp
 redirect target setters
Message-ID: <aAfUX_jDZpe4Vx_M@mini-arch>
References: <20250422011643.3509287-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422011643.3509287-1-joshwash@google.com>

On 04/21, Joshua Washington wrote:
> Commit 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with
> netdev->lock") introduces the netdev lock to xdp_set_features_flag().
> The change includes a _locked version of the method, as it is possible
> for a driver to have already acquired the netdev lock before calling
> this helper. However, the same applies to
> xdp_features_(set|clear)_redirect_flags(), which ends up calling the
> unlocked version of xdp_set_features_flags() leading to deadlocks in
> GVE, which grabs the netdev lock as part of its suspend, reset, and
> shutdown processes:
> 
> [  833.265543] WARNING: possible recursive locking detected
> [  833.270949] 6.15.0-rc1 #6 Tainted: G            E
> [  833.276271] --------------------------------------------
> [  833.281681] systemd-shutdow/1 is trying to acquire lock:
> [  833.287090] ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: xdp_set_features_flag+0x29/0x90
> [  833.295470]
> [  833.295470] but task is already holding lock:
> [  833.301400] ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: gve_shutdown+0x44/0x90 [gve]
> [  833.309508]
> [  833.309508] other info that might help us debug this:
> [  833.316130]  Possible unsafe locking scenario:
> [  833.316130]
> [  833.322142]        CPU0
> [  833.324681]        ----
> [  833.327220]   lock(&dev->lock);
> [  833.330455]   lock(&dev->lock);
> [  833.333689]
> [  833.333689]  *** DEADLOCK ***
> [  833.333689]
> [  833.339701]  May be due to missing lock nesting notation
> [  833.339701]
> [  833.346582] 5 locks held by systemd-shutdow/1:
> [  833.351205]  #0: ffffffffa9c89130 (system_transition_mutex){+.+.}-{4:4}, at: __se_sys_reboot+0xe6/0x210
> [  833.360695]  #1: ffff93b399e5c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown+0xb4/0x1f0
> [  833.369144]  #2: ffff949d19a471b8 (&dev->mutex){....}-{4:4}, at: device_shutdown+0xc2/0x1f0
> [  833.377603]  #3: ffffffffa9eca050 (rtnl_mutex){+.+.}-{4:4}, at: gve_shutdown+0x33/0x90 [gve]
> [  833.386138]  #4: ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: gve_shutdown+0x44/0x90 [gve]
> 
> Introduce xdp_features_(set|clear)_redirect_target_locked() versions
> which assume that the netdev lock has already been acquired before
> setting the XDP feature flag and update GVE to use the locked version.
> 
> Cc: bpf@vger.kernel.org
> Fixes: 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with netdev->lock")
> Tested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

