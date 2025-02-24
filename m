Return-Path: <bpf+bounces-52457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93361A43025
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7731E189EAF6
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4F20B1FA;
	Mon, 24 Feb 2025 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALDr1FWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3682054E7;
	Mon, 24 Feb 2025 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436213; cv=none; b=tw955Mt8NmwkRYe2+KqV0vOc3KxeIZeBU0gZkMYib6WVKQ07iXHVE0FoFAHojr9q1Z7wQoR1FzDuD9YjZ74C7soaPxO56QQQa7AlYS4UcGpVvtdKb+CC8MF5DFbPKvmBRP9/YXzUlsmugTDp+r5fF+oISgFSoSQ40xCOv2GZbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436213; c=relaxed/simple;
	bh=EBRZfjLcwg5g2rsoSMmRqbsYdSeJMfXkKTCLAauJNJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXlYo+3VWnHp4HWfSDQhlhIgd7PfdsCKOqixHwW/J6BG6P4AHLeq70zzDV4vVUrO81I7knsdtokh5ZG3+PnvcoYiYq6T28k3pgMl0uquzYxbP8LD9oNVIcoH0GF+rRP8CsdKRnZhmQWGzr+J479MAHK/e83mSdbDY19a9eLu+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALDr1FWS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d398bea9so78500525ad.3;
        Mon, 24 Feb 2025 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740436211; x=1741041011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Me2tClMPt10g2IbqRw63NkEwXox0kTNxKyczDkCN+Y=;
        b=ALDr1FWSwzNPx25YKPUPh6lWHjNEy//M98/2ftHtYDEPhJxUrYVlaHR3PoPbRubQmd
         QhoLAliczh35GvXTAbpYRi6b877nH8bjawZPsuShz+OaaOep4VYnAJddufWHBntfx4Vm
         KxJCdEQ8OJHF81Fp+Hebkorjkfk6wmradOnD/DcnSJbndE4US/hHbqAwntMhmRJh5J6l
         9F4LXkg2rw3YBD76k2D/5cq0jXAIOeOX59xGDQNPCmZ3rRBS9QFiAhaSI9m9STU8o0SP
         VkoiAkgOGRYxMZAswLz2wpFusSOm+rNodpt9n538JcK7NKSgdZBbEJRb3T7DiQRR7fVm
         Yp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740436211; x=1741041011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Me2tClMPt10g2IbqRw63NkEwXox0kTNxKyczDkCN+Y=;
        b=lcQ+sHa1mqm2Zb8wcazwW3ADx2xwrmpfB5XOUfkkssJ45xpX57GBXjDU9klc2D0TvJ
         J6bVdvrwhtBnlkEC0Gz71PnW9pBJj+WDvokKuWgjtCkZwtRwrmwwjRDoJYMOzKyMGj0U
         +jHPQLcgOfYGHeMgCNr2QMjLSmmksz+XBgr1AspmkjVb8k4D1y/DggrhnCgVQy7OFQ6i
         BEFfnE6fOudtNG6FnxykDH3XFuSuIuac8U//zfk8OWSaQHj+hqkjc91zNuR8ykzFcvLT
         rZgdY8BlrVQ0qUSRyKfNduJ1Gc5z0gR4r97Ojxi7d96ECnYeLS1qSYCecnYWa2TAZOWr
         672Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKrgAjNK7cJjM3vyDR+o3XsEm+2gB/Osf6FRFp29yen7F6B3Yy5gjYPRLL7flutfpF/0PCsyMvaqBHlXc=@vger.kernel.org, AJvYcCW4EQQrzcImDgNXT0C/zmDLLKrgl4gxxxDUeuH/SGRfohhKFWr/tFK1S9RjJGzICHwHTcvI2X8Q@vger.kernel.org, AJvYcCWwUessm6H77O27EoOes5mH6IF/35urqtSy2GjJUz8e0ot8vj4K9vFycY7yUIDQVyTgbxw=@vger.kernel.org, AJvYcCXBaJIOCDHKV4p7KwXaoEiwa25JdGddbJuudriTImnzut5rQCy6Lx6MzVpGsH32yP4wkZ5FxervgYRwfEA=@vger.kernel.org, AJvYcCXdvd7ZpG//htgS2ZQiKodSSeVlZzBCuj1KCxNcWAE25Fxzb2iwVYWL5BtoxRtGSkkJBvc1besTDeGXc9Ic@vger.kernel.org, AJvYcCXeRb9tfKeqhtvMxMDgyazFkJY+onzJJUMeeQlVCSW7Z2NDAipRKuVe2R9LfDLyAA8t+EWlb74I0Aq4Xxk2sos=@vger.kernel.org, AJvYcCXowpaAjkzGdWdzbCAuR+5e2X6QxLC4MQnEatK5nvX0ebo2IZ6b0VIIuCJC5oxXa8nTwozPVPh9FFt7pWB0@vger.kernel.org
X-Gm-Message-State: AOJu0Yykdhq1zMJVbAictdxsnkefoSJHCPcRnd28Scm/j132ggNzq8Lq
	XO6mLvmUNHxu+iQF6JKi772ow9DrZN0VCzGJ6Oj1s528hTGezdP8
X-Gm-Gg: ASbGnct8AgQmehe2sEf6a6gvJoQMLM5t5FvniL5qXGisPYvWEi/qeFoHQpbggulhepr
	z/tUkSOLIh/wnwT3dua0EooAvmrzqalDO5aU/KEokyd+8quWZZnnOzchyUTSlWNKeOZxqpdeXpB
	dluSKbFbM9Iz6LHLQ+dfTIEMXmGJgz0MUbKITxeQiOWQlGANcjhUDaaMFL1CJCZPJYRkzBMq9HD
	r54QXs7jHCYiGdjfowGW9BHz8yEdKBGCziYVqOULRCygOkGLQYpoNdNtXaJlVnCc+fNp3lWmQ5O
	AIjGxx1JMLoO4yeoIO/G3NpV9MPIJY9rMLejBVByvlI0xP3Bbg==
X-Google-Smtp-Source: AGHT+IHSWZzc6ZuJ7NuejlOnvhXRMbFaz5+ejvmVe/JbcFGg9XTfI3FePFDJqFfvVera5WJ+OS97IQ==
X-Received: by 2002:a17:902:e542:b0:220:ff3f:6cc0 with SMTP id d9443c01a7336-221a1191974mr248692865ad.38.1740436210908;
        Mon, 24 Feb 2025 14:30:10 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092fc9sm1130585ad.126.2025.02.24.14.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 14:30:10 -0800 (PST)
Date: Mon, 24 Feb 2025 17:30:08 -0500
From: Yury Norov <yury.norov@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
	tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, mingo@kernel.org,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 03/17] x86: Replace open-coded parity calculation with
 parity8()
Message-ID: <Z7zy8AOpAo4JQu8W@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-4-visitorckw@gmail.com>
 <d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com>
 <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>
 <Z7zv-c4A76jeMAKf@thinkpad>
 <68F1ED19-B0C2-4E78-B504-2F7C040ACC0A@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68F1ED19-B0C2-4E78-B504-2F7C040ACC0A@zytor.com>

On Mon, Feb 24, 2025 at 02:21:13PM -0800, H. Peter Anvin wrote:
> On February 24, 2025 2:17:29 PM PST, Yury Norov <yury.norov@gmail.com> wrote:
> >On Mon, Feb 24, 2025 at 01:55:28PM -0800, H. Peter Anvin wrote:
> >> On 2/24/25 07:24, Uros Bizjak wrote:
> >> > 
> >> > 
> >> > On 23. 02. 25 17:42, Kuan-Wei Chiu wrote:
> >> > > Refactor parity calculations to use the standard parity8() helper. This
> >> > > change eliminates redundant implementations and improves code
> >> > > efficiency.
> >> > 
> >> > The patch improves parity assembly code in bootflag.o from:
> >> > 
> >> >    58:    89 de                    mov    %ebx,%esi
> >> >    5a:    b9 08 00 00 00           mov    $0x8,%ecx
> >> >    5f:    31 d2                    xor    %edx,%edx
> >> >    61:    89 f0                    mov    %esi,%eax
> >> >    63:    89 d7                    mov    %edx,%edi
> >> >    65:    40 d0 ee                 shr    %sil
> >> >    68:    83 e0 01                 and    $0x1,%eax
> >> >    6b:    31 c2                    xor    %eax,%edx
> >> >    6d:    83 e9 01                 sub    $0x1,%ecx
> >> >    70:    75 ef                    jne    61 <sbf_init+0x51>
> >> >    72:    39 c7                    cmp    %eax,%edi
> >> >    74:    74 7f                    je     f5 <sbf_init+0xe5>
> >> >    76:
> >> > 
> >> > to:
> >> > 
> >> >    54:    89 d8                    mov    %ebx,%eax
> >> >    56:    ba 96 69 00 00           mov    $0x6996,%edx
> >> >    5b:    c0 e8 04                 shr    $0x4,%al
> >> >    5e:    31 d8                    xor    %ebx,%eax
> >> >    60:    83 e0 0f                 and    $0xf,%eax
> >> >    63:    0f a3 c2                 bt     %eax,%edx
> >> >    66:    73 64                    jae    cc <sbf_init+0xbc>
> >> >    68:
> >> > 
> >> > which is faster and smaller (-10 bytes) code.
> >> > 
> >> 
> >> Of course, on x86, parity8() and parity16() can be implemented very simply:
> >> 
> >> (Also, the parity functions really ought to return bool, and be flagged
> >> __attribute_const__.)
> >
> >There was a discussion regarding return type when parity8() was added.
> >The integer type was taken over bool with a sort of consideration that
> >bool should be returned as an answer to some question, like parity_odd().
> >
> >To me it's not a big deal. We can switch to boolean and describe in
> >comment what the 'true' means for the parity() function.
> 
> Bool is really the single-bit type, and gives the compiler more information. You could argue that the function really should be called parity_odd*() in general, but that's kind of excessive IMO.

Yes, I could, but I will not. :) I also feel like bool looks more
natural here.

