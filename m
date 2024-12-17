Return-Path: <bpf+bounces-47109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEE9F44B9
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 08:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0162C188D34F
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0BC1D88D0;
	Tue, 17 Dec 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOn8xZRV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C441D5178;
	Tue, 17 Dec 2024 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418816; cv=none; b=ASIcGs1vnONycHp/uDsCOaty8Ma58ooMTglE+7Q+DMayWk3xevpN9b8lgF0IRAnDORzw00wMwFOdmIGpyFW6eo3Y/LOgSRAWCZyyYnrnvse9uPsjlz2oicRIlwgAckiw6wF9hRuK7ELkiBhnG0sYibHiMm9nliZ8UbShu7hsT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418816; c=relaxed/simple;
	bh=O18Qyr6GIow1bTlKSgXTFI5KKI5hRawuXQIFpCK+hW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LTfvcR145YZ4peJn1Vb33agKjaOZ2g0P//jX22CWHculuV4wacjF/RlYAtgql7lOUXirYb/6SkmRm9DpaSxwZrdjPO9N91yaMf4x0NM1LPeq7ONkzMgq1BonmAjFfimuuml93Qa2qzUBwPTK8rr9Mlqz/pIJTNEWbnXv43/wZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOn8xZRV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21631789fcdso38899785ad.1;
        Mon, 16 Dec 2024 23:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734418814; x=1735023614; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O18Qyr6GIow1bTlKSgXTFI5KKI5hRawuXQIFpCK+hW4=;
        b=DOn8xZRVqgLbpGY8FtgLK04+SobZq+lK2WsKEBhoCDW7lP7HFi84c7+VkpulQnTv0A
         BR50jeEQZV9ZAvVLwH0U7lvee/oIHwBzNkeJ0ZCRzxIcVCi3ztzZnGPYQfI6RJfzvqzt
         rg5ZJSVTV6R5aIe04s7/q2tXM65HdNOSuQ8LQ/o/GPP7HemYZlR6lfjgfK7Uymp63CUP
         pTLc/3gpEInENtFXIsc8sRNaThhGLGeRN+Bt0wMZLBPsrrf5hiS2pbcsOQ2p7UlsSRgw
         89Mp5puxgACzpWIIJxa0gRYjfbLeyD+0Nd1n2eME3kd1VnEhmAnk2r786F9Wfz9MfIz5
         O23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734418814; x=1735023614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O18Qyr6GIow1bTlKSgXTFI5KKI5hRawuXQIFpCK+hW4=;
        b=j/5jz1SyIzAIjziIX/AOOec3vRXt8SiYb+MMywQ9GVoMa+/JyzyBRVttV5WojYwIZ9
         aS04E6skWhIRbMy/opL7od/R1zfevPHMcJRh7esFahNJBgTKLOziPOuSunTtuhU5eAKR
         nI4HDDKGKCVw1cdkxkud4yqBBPRRSVIBrLCjrrnPqYQaoQSWx4ceMYZ2SXin7rpwWCv1
         hhLz5dlZfXlRuZHaIeErCsnfCjp02gU/4vpPnzP4kr/3NHeMR9MwDk/MfyL/mZVwEUtp
         MtO9174TeZ78k6nLC82A52wNGax972fmUlBBHzxTDDqUmyw28TSxO9aPgPsR2Ekf1py9
         hoqg==
X-Forwarded-Encrypted: i=1; AJvYcCU9omMG+mh1crvC124mDnmnQ0LLOc7mbGsIJfhnAnSvyqV54u1I7fACwzwA3AYJ8844/aY=@vger.kernel.org, AJvYcCVYbi1M8IyN/RVWln/S2hbXOhubzrTmaDREscAvsW0Pp9gZWze3kFMN4o7qSxwuWeSAJBUmBuZ24w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0lAaleR8dZVxgvwLZddIxjFTQplJDy14vfUuoQE84vihCnou
	IfiBDTNWIktozuflTsUCmDWkF/cVpYbDKEAQQSDTUDY/kMR0AhSmA5SYFQ==
X-Gm-Gg: ASbGncu/tZOoajFzawoFyoR1rHE4NiuwD07w/7b0VcYVIqbLJK2BhoDaU687YTFuNpB
	3DmbxGu0taENGVaYKgynGXY3UVFoOjPSieUkBlabYnGEVRSUD9IKlgSWUPOa73Z9bmKAAkBD3t0
	IPy9E8+X42/lyK/5M/zUHdMnyL2N5vYyjtVJprab2mduZ42+eb2uBubCgWlpFUx+8BNRnCEonq/
	u8BLhTcFdY7Ty/L5b+FwzCcotbqOyt2nrZo/dZoJM/ipH5+/WUR7A==
X-Google-Smtp-Source: AGHT+IFVgLhmEe/BX5wEGw3WLiLMkUzJGoTRHa2hY98hLFbVHXLBbwxH97hfo8bTMa80NCbZ61c1HQ==
X-Received: by 2002:a17:902:da8a:b0:215:3205:58a6 with SMTP id d9443c01a7336-218c92020eemr32974215ad.12.1734418814160;
        Mon, 16 Dec 2024 23:00:14 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e640desm53147745ad.214.2024.12.16.23.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 23:00:13 -0800 (PST)
Message-ID: <1b1b094ce1e0592c6185c292b2a7692c35dc7e56.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 00/10] pahole: shared ELF and faster
 reproducible BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
 mykolal@fb.com, 	bpf@vger.kernel.org
Date: Mon, 16 Dec 2024 23:00:08 -0800
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 22:36 +0000, Ihor Solodrai wrote:

for allyesconfig, with your patch-set I get the following stats:

jobs 1, mem 7080048 Kb, time 97.24 sec
jobs 3, mem 7091360 Kb, time 60.10 sec
jobs 6, mem 7153848 Kb, time 49.73 sec
jobs 12, mem 7264036 Kb, time 54.67 sec

w/o your patch-set, using current pahole 'next', I get out memory both
with and without reproducible_build flag.

The vmlinux size is 7.6G.


