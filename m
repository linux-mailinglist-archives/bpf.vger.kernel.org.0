Return-Path: <bpf+bounces-64097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A8B0E4EB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40631580048
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677EC2853E7;
	Tue, 22 Jul 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS3Sf/lY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A880C02;
	Tue, 22 Jul 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215849; cv=none; b=N77VQHz5FHVeKxZrr26V0NBeWQcxqQOPGjX83KvsaZW1fk6OfIX52pkdpWqNAMdzulbNHwBpPFtldEDG4jh4G9/aV9oxAKdIvAKiCovbwu6JrKr2KGgGFip2p95gjWvwYAzLZEhISLODhUKLSuS0XN0bc+U0UPIf5goedzTu1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215849; c=relaxed/simple;
	bh=1KKR0zsqeIfQLml/wEbITiaoiBtzS5kacdTnXzlcnyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/StNP65ErPVpZSXZs+La9PLKFirCYfzPu6AXZNDeiozv5zF9GORPdjDlQK9nmF9Z99gXRVW3FM3hUXbFydh77x2/cFBtDm0qaWjrOjy7teIfpxWCY0AteRfsF8an2hOZ32N9Pzmx5Fd7R6ccjRaz/hPw5/PgGflL36bcNPHsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS3Sf/lY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74264d1832eso7464702b3a.0;
        Tue, 22 Jul 2025 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753215847; x=1753820647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1KKR0zsqeIfQLml/wEbITiaoiBtzS5kacdTnXzlcnyk=;
        b=PS3Sf/lY1bDZrbOGPTgSYM1adguwe4RLc2ef7cVopJE1FAWGfXhAV+l+AwM4Rx9DPr
         Us0Ce0ustQmWOKQ4e8EQZ/5D73LGEu4HJDLiAm/lfWfsvpwLV+KluvtYv14mbaT4w7AU
         EZfngxWOzbTOnA+uaHCbYX2YpDAKVyyg6OsONR/9OJLEon3MKkWXtwe1XFQkl3jpuaKb
         X7poYiYa6K1Ms1B3Wz2/dQ2LT2nsDWxgqtGYkOCA6HjiEOEp4kLHJE7oP3GxFDAIkgzD
         1nAd6i8HiuXs5LvZOueUwf49AR98uR9ISOmahwJIVpOw/B/QcH6aIw4mZ9pdKFRJhC/y
         DQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753215847; x=1753820647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KKR0zsqeIfQLml/wEbITiaoiBtzS5kacdTnXzlcnyk=;
        b=uLYfGuY1dJ/YOKvHZCdeRjGw1uEJoBKYJk39L1a64NRlvu5AChWs46jRMTxt6aRYva
         bSwoUMHeMo/NK4m9dOcREDyZ/jsRDMwKf8JuvmEzrucjsXP2P/0SjREAU5I/Togu/r+8
         Wqw7pgQlf5kVQ5nCe9kKRlFe0Sd8QmWaZHk5vEXOsyOoj7oUL/74q1aBSV+ZjziBPgO2
         R9f/ISeAcCSajeb+Dc5/xAle3ydi/PKG8XwRfCDzDPB3dCitEZuiwojJKaBb7pAn2++Q
         bQ+6q8kUyE1S0VRQpjyy4+02u9IFlKkfxEwohEs4h6lcNR42Pi2sxJza1COr38ZSRk3V
         IOkw==
X-Forwarded-Encrypted: i=1; AJvYcCWEY6+gTp+f1IdCq7aYrKfVO4g2Bsel5DwCZATSnXkjqD+Ye+HFAXHMmGJq4+GkNOJ+GaEJfuiR@vger.kernel.org, AJvYcCXfYAGHvMiA3Uxmu9Kc8YxZd6b1h4UXJvnWSZUxd4woqqnD5MCjhRZ4I1xFL1pP0FNgdsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GSytMbhr13YiFykNAjiYOppGGB5i7Z96px417aVcqu+u8iBT
	Vk3YzWNoFfngnnHSUw91z4+uYwFmMyCoJNAT4wt96WuBX4eJEOT08LGN
X-Gm-Gg: ASbGnctTAWmaJdF5BaGoMFj21Zjf5NuWIvAgjcRXnLgcG9nnrSVlQ6XyWJkWU63PVct
	7hDWwYAMWbCuywtPPqqso/hrc+mWPlO5zIUJfuaVDMoSB1cYPRz4JYjv1Lqx6WQ++MfyUwZ7q41
	8wfEpZwpvh9ow014kZbcyNCryDoWkvVhxB8hALkJ0UHBISHSRRo0GhofSUMeQC/21gkUtX0PBwU
	ptizP5GTrdcIn5ADPv+di8S+hvf27aCFmb9mZTQ8ktNzGacf+Ymt0P/g7vB/6DyAbWjJh7FJLe8
	hKHryCFV5AsJqd+ZpyJ1fpX9bey8HWU2S+uvtmPO75gJb2wnwCLFIrylbPTPi63D83KWCuGFpbq
	glGi+GX/I9kn138ejjkXF/yjs5r0w
X-Google-Smtp-Source: AGHT+IGIQtkof08qThV7EzwfW8OSM1cUje581jW1yKwRJf1nzuy2S7N7Dq6AJFfj6/vu8pCnyGPF7g==
X-Received: by 2002:a05:6a21:7a45:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-23d4916b297mr258669637.42.1753215846843;
        Tue, 22 Jul 2025 13:24:06 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e01sm8276788b3a.88.2025.07.22.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:24:06 -0700 (PDT)
Message-ID: <7100934f29dd8b4130cb4c4ce3b4c7b57dbc693b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/10] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Tue, 22 Jul 2025 13:24:03 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-6-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-6-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
> Prepare for parametrizing the xdp_context tests. The assert_test_result
> helper doesn't need the whole skeleton. Pass just what it needs.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

