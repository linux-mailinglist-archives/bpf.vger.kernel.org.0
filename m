Return-Path: <bpf+bounces-53691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A5A58891
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 22:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D9188D632
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6223A21D5A8;
	Sun,  9 Mar 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6iKx+2U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946118D63E;
	Sun,  9 Mar 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741556492; cv=none; b=JFqYNKEAAjuJK5j8IWtosjSU1KqQR3zKExXEYiaOd4yTme66SyDS+Jc2gJ5SLIx8B/sIe3mbuRmmF41WIR23O5h31KfqMwkk7ewSQIp2/XSeWDWLKH7kmkFHpzJSUfc3IDu0oC6OKf9wGXTcjH3SDovbchHMFmRTsnzVYxWdtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741556492; c=relaxed/simple;
	bh=o6UQx+iI1PxTENsRf9cgQ8A+OE5diXM4UlOZmRfCA1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fStfIqNwtsdtDHU/9DVsD/b2ZI5kSy47dXSy2Kc8fV/+37FVbiMkMVcIOy4+cgGmOcM5tSidYm/g0C4oyMSE/BdQP79hoP5pNjyPGp/3qGyE9Juo7qLP/Q7NSMPw9RqLmPPG1I7mZTXf0vgb0h1MmqYkJ7CiDtTRSBuYsS7tDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6iKx+2U; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso5114546a91.3;
        Sun, 09 Mar 2025 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741556491; x=1742161291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c07eWjLH6j3+OrGpuD9gkIMCjymcRYECIhrm80A0D6I=;
        b=J6iKx+2UilsEnYVtgzVQACcdvCe+oB63Jpv0XtACjk9awwZAH6JpfXvCLG29QFoXD9
         Dafx+76tdnuJkzsyBqpZzFWd3lSTXShyZtLZdV+SklKixg1jBmHlPrFGluDxwfTXZUyq
         Q7KgVAGkOBou2hh5NDyl1jADruVK6LRulSUzMcAnoL+22dEI82aIsTn3fJhWlsmi4CwM
         nprEedpDwLyyeuxG0tCbgyRvZnoSPDx+VpvlNKYWZPfU5hIlZ7R+c+B0K8YQwaHC8Hz5
         17ebnfL66ZU5hvicy5124OYRUu9YVp9R+x0VRFfa9SVqQH13LeJYtT+mG2h/UtEqxW9A
         SvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741556491; x=1742161291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c07eWjLH6j3+OrGpuD9gkIMCjymcRYECIhrm80A0D6I=;
        b=UbzbtCSskmjtU2nXvTHs18bvN1sVkgcN/sareVS2kVv30pgdrdRW4yjT99Uzktfnyz
         r6qiQADfjcak7ox7rtDkZmfC2fJTybaUMW29VL3nMyA4LoU9GF8ao54J5ZYuahDO/HhD
         ah/TkWiyZHONhvpOMnhw5glUEoVuUepqUDsUt4XCauxBpKpsrM4eOuCxxwaQOB/ACzPW
         8vvDrKHRyotFPabsNx4FgqxTG1khsKCd94QWh0wBNTv5IOv1mHh3Ep1FFdmcdfK/Eaau
         7xHxOkhGlzUGLw282lQ5P5BFukCwoA99pPCbQveD0nCS4j54sKiYq/WbbgWVUiTBspik
         OzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE9O3cb9Gm0Uh5Guijku/onj4goXjzb1CGmDQchnA99TMbwafrapLduFWguzdu2DJOQXOAwpKq@vger.kernel.org, AJvYcCVtofK+dpxWKJcJxSebsM4gJhmWmub4ROhQKNeI/tQ1G1H7DyZPkB97qFCW1SSJWvyIzx8b2jiJxL+koslg@vger.kernel.org, AJvYcCWO8mmx71I7A67dyQ9oEjsd4gy8im3qDGUxu1Kx5Fgqo2CG/+M7uF7pSEI01byefNVlXLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywufkp27OeJSG+yd1vyc/PNmjdTiVcl73FOlVH4rg+wSgE31Hjf
	B8XNES8cebyubxM1g3LJ0p5UJcm0aYdmyF+2NSPVfEo0xNicr6s=
X-Gm-Gg: ASbGnctLZ/52LHFkdqe5O0F48d0Lm+dXcj2cG1di8V1q3Rf76Oy/QXa+HsxRCMWdLRC
	mq5s6Sqf3+7RwbyNKxsdmqrjajmxhH0FOPDr8ocXpsDueFiO7TS3Lp6ol223qjf1gby75egunN0
	EX5P7LdOROa1Z9tINjR0zGpEaTT+wCOmYPF096B11u+CIQfOUr/wRx5pj6wTWgzsKleFKWLRdfe
	MudynP8dfLM/d1MZ3HN6KblKij6bYfKna0OyVGFTJRaz2HQMxc2D7p/+2BDktpYzU+TIOHpTkQI
	+37ZvQCA+TfYDqKCbrg46xW13J5mBMy/sOml9hQ3taO2
X-Google-Smtp-Source: AGHT+IHu78uYiSH+bwtlIde6inedLIW7x7+YBpWiI/hMJk0BQEDe0T0GX93FOwKSWTp6N2wK/jVDvw==
X-Received: by 2002:a17:90a:e7ce:b0:2ff:58a4:9db3 with SMTP id 98e67ed59e1d1-2ff7cf25652mr18095392a91.35.1741556490672;
        Sun, 09 Mar 2025 14:41:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410aba9e2sm64098895ad.255.2025.03.09.14.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 14:41:30 -0700 (PDT)
Date: Sun, 9 Mar 2025 14:41:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kohei Enju <kohei.enju@gmail.com>
Subject: Re: [PATCH net-next v1] dev: remove netdev_lock() and
 netdev_lock_ops() in register_netdevice().
Message-ID: <Z84LCSOcT89TXNt0@mini-arch>
References: <20250308203835.60633-2-enjuk@amazon.com>
 <20250308131813.4f8c8f0d@kernel.org>
 <Z8zHpf6JPfjkC_Sv@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8zHpf6JPfjkC_Sv@mini-arch>

On 03/08, Stanislav Fomichev wrote:
> On 03/08, Jakub Kicinski wrote:
> > On Sun, 9 Mar 2025 05:37:18 +0900 Kohei Enju wrote:
> > > Both netdev_lock() and netdev_lock_ops() are called before
> > > list_netdevice() in register_netdevice().
> > > No other context can access the struct net_device, so we don't need these
> > > locks in this context.
> 
> That's technically true, but it will set off a bunch of lockdep
> warnings :-(
Let me drop it for now from the nipa because it does complain about it:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/24641/67-nl-netdev-py/stderr

---
pw-bot: cr

