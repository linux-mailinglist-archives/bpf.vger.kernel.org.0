Return-Path: <bpf+bounces-63970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE2FB0CE9F
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAF05457EF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 00:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77669A47;
	Tue, 22 Jul 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdaJGFw1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2F372
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753143080; cv=none; b=L9HvkxQWTbMjF8iK6LtqgZwYSm3PMFF56xTkeOPmPj5Cb1muhf0zke1T3DIKRr3lG6Uuawk60NK12zVHR/3sWaJmYfgGou47oEe3aNBHnJzd3GgObm4JQF00zcUSECGfEruyiEy5G6ntqxr+YMYArZ6yqEjW3JpIbXpVeWSBTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753143080; c=relaxed/simple;
	bh=wdYgp+pAFx7VkzkF6hpd+NLftHwMjvx9YlZNNGr7XNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JtMLygYsGaCYfJJTWe0ujD9lHF7EyZNP4FabSk9k2RwTuX8UNg0G/YUxJMK9Uf3/saOYZq9tiER9EP5I/mTzz3LBjv52RkhBNU/zWZu1wty5+87PDpdpLu0xLztHtaNik66gwxA/ffduEkDOGNpPwencncIs9x2jE/68tCl5mc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdaJGFw1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fba9f962so4270308b3a.0
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 17:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753143077; x=1753747877; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wdYgp+pAFx7VkzkF6hpd+NLftHwMjvx9YlZNNGr7XNM=;
        b=jdaJGFw1DKWnEbPdUa1jim4ZJbYdq+5L41Z0NQcu8rr/zvgo6dWFY7mNi1U5M7F01J
         RRZt7BUNNo6WLXC3z035AXXZFGZHK6q7u7wIhcJSgQ7vtctkUkBjGi6cLvcivE+pycvy
         XlXWWewCPKNxjvhza/s5uAonJHJ6RuPa/EExKT4JNThavJPx45v7k9J1VPOpMEs8jogp
         1G254Ls2VAtEvAvpyWb8PCZ+CP0IpgT7G1up4cT7XvJBAIfCLMb1zh7Ri5tOuuRnHEqp
         BvctBEwVApsPxGkbfK8mtIY3b6sZaEscR0Zugs9Ifouttz6nB+QeDVsDDWFxAWrAjV15
         tYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753143077; x=1753747877;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdYgp+pAFx7VkzkF6hpd+NLftHwMjvx9YlZNNGr7XNM=;
        b=ovn4/6Y5tVfR8FQB5+kvFvJatKA3qtCaF6vf0j5Gf43Z/F6nAJR73/ZRmGjjPcLeGi
         b1WsqEYViqgRPhnDXJBeeNFcwwV4/x/JEb1VOFiJKm2oBIOc9x0fEZrsRD0ynB6iHM5L
         Lnh6UPAV/HhVLTQuJL67LzcT+gigIp0IX8ZlCYV0l00uPrwnz7Pt4s4UJd7YXNIAl9Tq
         jF75GwPj1KQeZMtgeeJwcYoF43F2iH3uaJCJxn6f24G4Y1QWZQahRa4kMm0JPDCSCWNX
         GKyGr6H1uIkR15FVCwBd2CSBTh+zCkPae2Y0c0cWfl1fzt2neNriZLW9gNu4uxs26yTc
         /PCw==
X-Forwarded-Encrypted: i=1; AJvYcCUcnb80caEAoz77XMX7z9Qr0KL7cwE6O1N7TPlVj9MSCCI8go0BKT+IhUvQkj1CdzSQbE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0ZNIYiYij/Rx1MDSkcDxpSOGkvcIQQGGHd9OPnwnf07ewmZ1
	bdEmponjHHPtsBL/j/mtfdT79loToi06pyGm/rla2GcFjJnzmNMgiw4F99pJBw2+rtg=
X-Gm-Gg: ASbGnctm9h1TCCFQsBGY/PRO7cEI3D7p88oORW8SkglzMBUbR50wSXE814lOl0slNj7
	j9QgADjEbEfKyzXuhdT5QVmH9mJcXYlUdkpPGiD3I0NIV3gb0uSwGnXosBE2/1zzzwG+QZDW4w6
	uZlawm8sVKaBUVSoSMvCib4ZFwHLNXsvWEhec6tUlp7VvTUiyymznL7clqAQDWagI3DUpjqyty3
	31H5pjujBQPdsisT6yuK2KTfMVGTdkUkMa9+I9FOiCcUHFm+Xn0Y8VDhTA8Z37QGAzUU9MHajvt
	rR1AiNA5tzJiK5tGOne0a6xDIglDaiYSd2Q4HaXf/sW2uXvzUTrFKo5a9i/46e1kTZzb8wOcn+M
	goJjwPGjEhrCW00AjXikrC8kByb8p
X-Google-Smtp-Source: AGHT+IF6b6a0XwrY7lVZ61+sXgCLk2cz48x5DwE+H58jgOaxrn5RvdFdXbaIMV7uejewZg7uwTFocQ==
X-Received: by 2002:a05:6a00:1817:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-75ed156d03bmr1705677b3a.6.1753143076748;
        Mon, 21 Jul 2025 17:11:16 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e3a99sm5943055b3a.4.2025.07.21.17.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 17:11:16 -0700 (PDT)
Message-ID: <2aa67d27f60af32824e35c4f7c5da956534a4825.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test invalid narrower ctx
 load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>
Date: Mon, 21 Jul 2025 17:11:14 -0700
In-Reply-To: <3d518d4e6c90c3338eea8786291ee3102181ab57.1753099618.git.paul.chaignon@gmail.com>
References: 
	<e900f2e8c188460284127fe1403728c10c1eb8f4.1753099618.git.paul.chaignon@gmail.com>
	 <3d518d4e6c90c3338eea8786291ee3102181ab57.1753099618.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 15:02 +0200, Paul Chaignon wrote:
> This patch adds two selftests to cover invalid narrower loads on the
> context. These used to cause kernel warning before the previous patch.
> To trigger the warning, the load had to be aligned, to read an affected
> pointer field (ex., skb->sk), and not starting at the beginning of the
> pointer field. The new selftests show two such loads of 1B and 4B sizes.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Since we hit a bug here, I think it would be nice to have a test case
for each buggy field if that could be done in a terse way.
Wrapping `invalid_narrow_skb_sk_load` here in a macro and stamping a
few instances seem to be sufficient.

[...]

