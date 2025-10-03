Return-Path: <bpf+bounces-70275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD32BB5E2E
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 06:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE6E24E467B
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 04:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5F19C569;
	Fri,  3 Oct 2025 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOEytGKB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209A8462
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759464502; cv=none; b=Z/GD8aw/uKQ/ah0jFgif0Dumsdc+FGvVK3KxlShU9ySd8Y+kAc1ew7BJC46DXy6H+JitYQ9XjpShMeEmtN8L6U3OkdIvYreAnkeNgDNAgftq0i+k7abYRidOOvzWPVuQTtUUm5FCItJeggTj66hb579kwh3PLWYIAjuHbvIi5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759464502; c=relaxed/simple;
	bh=b8UTn+9EASzChdm62Qv3Al8vi42Bhz20c5CYXegPQRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlxUsjJ3Lh11UvazO7aYqAZQTYzmtw0OxnjNgi1KBgqoqxM0MY5A7f8vTA7aarrKby2t87q2MrklTSe0bxWOWpuMS0ShVesw9Nlkb8VcSw3bhPfCG0M0Gp49A0tsELk+2WPE5DSKa9R3YiUnclBSbCtHXfzvWPf1rQ33KkiTJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOEytGKB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78a9793aa09so2164194b3a.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 21:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759464500; x=1760069300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhJ+6VVwGfFZf1jd0Sg5lEe+K37tdEH6nqwWqT0zirY=;
        b=aOEytGKBG9c0wduJVu3Bv4EO4rcs80+ndZsG38pqUlYD2aYN+Nv6DDprWysVtwJcp/
         b2QuYTGxEYLsIWOpAi+IK+wN5rGi9SkND0QqVulP7+9HxCcuBoOZO5cKY8DxKS+KkKFG
         VNbQhiQo7DcO5rZgukxyoZFKjuRk7xUA2zi7jXTfbzYicff5D2t1ps3EQjIyXUEdQwk1
         jF+LTOeb8wsXozWC5q1G4nS9n1jk96TwZRplt1xMcaHaZJ36BxeFTnwR3ldtxQ+Gmdd0
         iA1nGZ6v6vBeh7xJeLxEFkTcxU7/CTXZucvn1UcD7HlAuchIPY6SbaNAEVVmTb3rDR46
         UYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759464500; x=1760069300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhJ+6VVwGfFZf1jd0Sg5lEe+K37tdEH6nqwWqT0zirY=;
        b=bvQmX34vI1byYEmk/Y9cZBsXMBUvY/nJuw4h+qzRffJkGSL3tRIz0pVyEUPGdlKZR3
         L8QCmsWuj6a8qeo6j1iSzhT3BwX30a9Q5UfYcEsS2uBHju2hF6QEkw/33daRfRa/ZZ8J
         aBWg7OZSI/zk/LA7mO+pNfnYhRX4P9zkTevtyu+kb2HAsPaZRZ4ry7uKVgJsMT0+Nlbc
         9sM9ldlU7HpVgneFf0iOAAXNQ5n/5gvISxA5ZLHJDx4oN0Y2OYBrHNM1j5mBykz5T6cv
         ab2seXjnwTJ/JQxsEkO+EClyJRuCXDfV4qy1xHT5tQFo+xJznB69M31ytm5LE8PqsosD
         TAkw==
X-Forwarded-Encrypted: i=1; AJvYcCUhreM3C1cwBigWU24W/SPI6kP1e25Gn7M0xuJ67Mm1elG+cr5+LXLnNDg3SY5e5wc9Xjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbntBjR7Irf1Y+n60ZThM1Rs61No2IfDfEAroLoBSeyiu3P5o
	7n8N5hAMcfftn6OYibV+Ep2qvpa/ZiT194vecZC4L/o32mFO92s+Ptyy
X-Gm-Gg: ASbGncsceiZrOC9lk2dbcgPtIM7PzZ6KUeseOjiyWEjRtw91WK7WLYwO+rqY1rauM1C
	J1QvyEXi8oALN53nzyDYcxVzXH+9lNWVSPdIyoLx52Wg5hTax076sq5+plBtSnhVe0uT7Iz+oi3
	sPdY99Gkdft74uuha13Hi1FyaKVNlh8GAx9cXtRhPNhGog2omskNQ4lu+OLJ9Hsvcwz4Uo99eKs
	TpYoYWuEbmxIUaH2p8Hb8aFf7MUoIgyr363PAr1bzJU6ZDmr/XnxmJZSDh0eX62WCeryA6vykGo
	PwyhRHlYghVD4CS7cqjIVRflYTYw3au1MNMmXcmlS2xMh8Aau2sauE5PWOJoReddKX4Nm1tvOAS
	3eULIgqCfTmG9WJ4UEydO+9QPmp2h27xcuX2j50eOLTu3
X-Google-Smtp-Source: AGHT+IFlLViM2A6SdjJQjR6hGOzMNBkc078E3B9V3u2/DzpqdwEzzZqxF2hQqrfrgIpGor7I6ihVbA==
X-Received: by 2002:a05:6a20:12d2:b0:2f5:e435:405c with SMTP id adf61e73a8af0-32b61e5492cmr2170290637.15.1759464499812;
        Thu, 02 Oct 2025 21:08:19 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099ad9573sm3264626a12.9.2025.10.02.21.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:08:19 -0700 (PDT)
Message-ID: <cc10f57ca0e61bcee54d2f0e6da7e5df6c36ecd8.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yazhou Tang <yazhoutang@foxmail.com>, yonghong.song@linux.dev, 
	ast@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, 	martin.lau@linux.dev, sdf@fomichev.me,
 shenghaoyuan0928@163.com, song@kernel.org, 	tangyazhou518@outlook.com,
 ziye@zju.edu.cn
Date: Thu, 02 Oct 2025 21:08:16 -0700
In-Reply-To: <tencent_2F76E206702452E76A0A4F9A4C815F4CC008@qq.com>
References: <77da14fed4467c76d6f8f55a620f79988f0fe04d.camel@gmail.com>
	 <tencent_2F76E206702452E76A0A4F9A4C815F4CC008@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 11:12 +0800, Yazhou Tang wrote:

Hi Yazhou,

> As I'm still new to the community, I'm learning to keep up with the
> pace and workflow. Thanks again to everyone involved for your help
> and understanding.

Thank you for identifying and fixing the issue.  Usually there is no
such hurry, and waiting a day or two is not an issue.  If you need any
help with selftests setup, please let me know.

Thanks,
Eduard.

