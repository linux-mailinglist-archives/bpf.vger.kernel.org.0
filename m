Return-Path: <bpf+bounces-46790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20A9F0129
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD88162836
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B1944F;
	Fri, 13 Dec 2024 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZFPwaUX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE7610C
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050089; cv=none; b=Bq7vXkHiwje7pFWyGQuOku5MhZWY6eP995tx/dzU0fQXjTCgEGuyrTmePySoC1tORiXaZX2xTp+7/iJ5MLjBDyr4QmOQ8V455snzz9ZeOBWkAsVTnwjCVHSC3vtpQ/RIlMX5AsSXeDxhIN5OhgKADUwyhGKoALMWbnntVV2mxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050089; c=relaxed/simple;
	bh=OmXaGUZjtd212q/xYuznVaVjxGBBx39bJZVEzSEgkYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0w+ZfrvtvIUa0zdsavHSpJHacYtNCzAJcVGXSrhmJQwr8pNCjg5q6Sd1LsTs6me0uu1quKSOItLww+wVEjGVPfMlQp7XoRxdl+PwpXCdb1KmlHGTJhUwr9jkaCps6smhxfTyP20K3a4SodFMbNwlHD1cvX7CR9gaOLiOsT9has=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZFPwaUX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e81257bfso1008137b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734050087; x=1734654887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OmXaGUZjtd212q/xYuznVaVjxGBBx39bJZVEzSEgkYo=;
        b=aZFPwaUXZEv5FaocfAfcQsrg04NOWpfZPMfH3OiNwAgU86R68WjVXtkI+VJqhDURbP
         AMX5QuCnbopRVbYpqtR6j1LBE+HSVR4UJWwUGvp1MtsIQohP8y7R1kRJpdis7YEPPU+A
         d/+H1HHMMvPhoeyqyta1n9/T09659uyCNPM/zOTdx1VhqYw5//DPcxnF9zPYhL+5lyQo
         qLEjyOO6HNC2+RwXtvS34lImYPtBqNehiRQSqYSVL0F2XKnhENHXscFWMXEd9FUSn455
         H3YO2czpoXzjsTAv9whQdJeP41P6ykAEbUICYvt3kmuLJvf4nzAa0uaxlqdBimQg7AgM
         Q+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050087; x=1734654887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmXaGUZjtd212q/xYuznVaVjxGBBx39bJZVEzSEgkYo=;
        b=C9DbYaMi0KBMoulsWCiQi5cftKwihcNXdbrAabg87HzCJ1MnqLm3EcjV5Xa/WTzmwv
         9Zw9FPlR52aPILIKEyPf3ubzVxTvAbO3n45/Ze2Gq7k20x+D0Gdj40UR5U1cNl75Bofa
         oBrW3WODgoUt1jRseX5KO2CYzfCerFLR/vPn+UfpJUaavIghrEglK85YcP1AK75RE1nR
         GTVw6lt3R6G7aG8hDP81buDMwALqjIxb8NTBEWJIWXeEzZiyHurZdyMe+ZPwiLCcu2Jt
         7qJCVFVakGe7uziTwmiAbMjrAKELHYP3pnekQ1y5GOHy8FpyKeLu3tWp1C8FHxa+x/fx
         rsNg==
X-Gm-Message-State: AOJu0Yx2T5CHprhDQ7nnLwWRZZeM1vsBcbaMlUNsJZqBqQVl8NHikxHi
	0ILyQDnFHX4N2luQoZxqpA0TwpopNRX6OhiHnrDbuhJTLGE79wY99VfGfQ==
X-Gm-Gg: ASbGncsRKXNsz5sCPPsPUiu0ySi5vDQmJSXmyTPvxc6do5gIHMAN10WdsGsy7beF52K
	iy+IcbQwGe1ABc1rZPkmZpxxAB5BOgYBYqclYnqBWwRfFNOpy3FJIBjzgI6fSdMlutXadZJCM1a
	LXvBMfuIogzo0h24C9dOWfAWoyw0TujfAGPi4I+auVGAzv0hfXvS8ttXilIJhkRgBk/rWPvjRUB
	w3zsRuBMsaoR5Qb7AeEcQKBZP/926KG46e6r+yOQDmZD/OGzYv/YQ==
X-Google-Smtp-Source: AGHT+IEHtSniTaAaV8LJg95rLo2ogZmMKaBJpxAdmYLRaiPwzW1PwZZTWY/b7sPCa/uRJOFijUgbvw==
X-Received: by 2002:a05:6a21:78a4:b0:1dc:1:3e28 with SMTP id adf61e73a8af0-1e1dfe1043amr907774637.40.1734050086963;
        Thu, 12 Dec 2024 16:34:46 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1cf7e7fsm7613810b3a.22.2024.12.12.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:34:46 -0800 (PST)
Message-ID: <ba6e11fffde0822125c7c943e809842d8a13bbd0.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: make BPF_TARGET_ENDIAN non-recursive
 to speed up *.bpf.o build
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Thu, 12 Dec 2024 16:34:41 -0800
In-Reply-To: <20241213003224.837030-1-eddyz87@gmail.com>
References: <20241213003224.837030-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 16:32 -0800, Eduard Zingerman wrote:

Wrong tree, it should have been 'bpf-next' :(


