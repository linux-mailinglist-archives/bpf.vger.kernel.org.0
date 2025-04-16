Return-Path: <bpf+bounces-56031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45BA8B418
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF3B3BAB9C
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F122FF58;
	Wed, 16 Apr 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwrUnGQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7A1DE3C4
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792875; cv=none; b=PRnDZN7T6sBHt0xZKxUyf8el0l1FfEqUA7i10hccwfZL2+qIh7v0xyUi4L3D1Zr8YYNyelGbisVUfjCBcZxTMHw31bJCKhIoKt565mA6scpc7a/QDnKd70q4vMhBLPN0M0Rxa/pIG3rrPgiTDTH8RdvPoBhfdtMWe1SLFRWD+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792875; c=relaxed/simple;
	bh=tc2hX8PRxdigc6zNwsAEORjyvNTK4OQheLNT7V+tNYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCnatzwMyPdH3roSH5DJQt0yEIrH79FVkGHoKwu6okpaej57x64DvGocgbjsJ2rHXa2DsTxBIP5eQ0OOMeAe8UzgtjjabSIJ8OC6cY1sPd6c14//dEAAYfaaNpV/qLYcMyc1xV5cb2Lae9EpQRXkW6P52igLUVa676yoYnpi5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwrUnGQ9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b34a71a1so7544896b3a.0
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744792873; x=1745397673; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tc2hX8PRxdigc6zNwsAEORjyvNTK4OQheLNT7V+tNYM=;
        b=XwrUnGQ9qPC1fe6NVofsEm6GMOGwoSfnhKouOvuVJU0JJz9LmDJRP3oWYgMRHOY3Va
         09RRIPe9yjuvuCocDGD+iU3gGqbbj8/Bi5MF+gap+o+JDethWfMGwxw+V0R05dSHeeJY
         WZU6eO7auM3QQDljH19VYnf3V1O5VWzD/z+DIOfu2xRDYjDb4+k4qOixQPQDApfhyBwr
         KeJ/VKDOI6KmxLnsaDMb+e8DryP5ib4lhKXZDKDxYPr7+qZdEZ3D4ShavtdEzjJfuZ78
         xg+r4f1xxPGIfpg+XNAO8BzgAL5af3IKzzmFQvVo7zX/dQamqY8ysNiPxsBTo9XJiTmG
         B1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744792873; x=1745397673;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc2hX8PRxdigc6zNwsAEORjyvNTK4OQheLNT7V+tNYM=;
        b=kST0jP2L8/QdDancpnL5dTjh7a86b4vOnACXw022AUdFrr63r5lbaUsO4zke1HsD5J
         Yp8nuGyPpmkTx6OKHN8FrKHa7QBG2a1OlIOfhvDEcv7sAoKcLRUuRFurguFbMusoC0xS
         q2Ex6foWmD9ganfGWZzhvMt7QYdm4n4sClZuKY5JIsazW8FGqXUXsS+ynndGFZ+8sw1s
         EZ3nxp7pOTJ0ysZWCBc2slKJVVU+DG63XBX64juXJ0jTtrZuqIBj9ezhF4OZ+DZfNPAS
         FBbQwtFRQ96OLZhaY4BNtKbtSRjQSXDAf+thl0OhFsZM9fvu8opyL7949yY36aFh1GXn
         UdIg==
X-Gm-Message-State: AOJu0Yz7l9bcwcwrOU8nq8fEZppeCSS5hm29SQHdUGlOn6JgauHpLN3k
	0YZtaiz1AZil1Kg1YDEPEwM4BuyPDYwUH3l28GWFKNGS/yZM1PNu
X-Gm-Gg: ASbGncvbn/0cdSb74rTFp02FOb/bcreuzczTWOKu9uaU6/omqfPOtD3VhJimcQaW0C2
	2zKrpOSlp81lE8AqQelNZgXTgdtjudD8+3u2rKr0BwB3TuYXJsnnjUnL4DOoLevNosJ3TFZ5meH
	qNFt07j1YO8chIQKWYvRLTYIpchJCRo7jKw1393UliiHL3d6VEyz06NUqe50+2dyDw9rwCV/evO
	owFea+sMtXaBdnBmhxE4cA+WhmICDSoUKHsZfOzJdcgSz48d/ggaftwGYCJAEqU1Xumai86Aepe
	XDGEe3dtr8d7QmrRnXS2GBPH6rf1MgihEA==
X-Google-Smtp-Source: AGHT+IH3qlfrhR4stwkLTdyPO2N0lygeAZcbBVG0Kt5BNlKhkg7sL13lAT9LP/YmoFw2VfrY+DFR1g==
X-Received: by 2002:a05:6a21:9104:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-203b4013219mr1262197637.42.1744792873130;
        Wed, 16 Apr 2025 01:41:13 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21949cfsm9808718b3a.29.2025.04.16.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:41:12 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 03/13] selftests/bpf: Convert
 dynptr_fail to use vmlinux.h
In-Reply-To: <20250414161443.1146103-4-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:33 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-4-memxor@gmail.com>
Date: Wed, 16 Apr 2025 01:41:09 -0700
Message-ID: <874iyo1ot6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Let's make use of vmlinux.h in dynptr_fail.c. No functional change
> intended, just a drive-by improvement.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

