Return-Path: <bpf+bounces-42433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDC9A4417
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 18:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA88B1C21ED7
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3966E2036F2;
	Fri, 18 Oct 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry+tr75b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8951F428A
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270055; cv=none; b=UzDUqWKvuHoljUf6w460+g513Ebu9kPKAZYlYgKMm7gI76TgHpiKnMAf2mbuao99LddaZc+cv+1+U1L26Y1YoEDALlwhxpwMJyqs1dXPMhN/2tQ9nigp13iy0k8/sUeO+Dk3stB+bq7vIlDN4MN76b/Uhb/5iXkS2RoikmOJ4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270055; c=relaxed/simple;
	bh=8XL1lpry57IKuMxJrRdaCrpmoSwvAmJYNiFGroxliGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PN2Ndo0MCO6h57k2WeBKT1XKfgzWVNvAqiiZMXhklnfZpPmi3GsMopOw9jVghLI1r2caFbheWtBrQyxAfQzd1FpUXeQn5ZQJStBbdm5vYD+OFOepCT/2F3OeP34vBY63CtPK53gSiPmfusPhhZReII/99em6u+42iGGD9Ug8kJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry+tr75b; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso2539089b3a.0
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729270053; x=1729874853; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XL1lpry57IKuMxJrRdaCrpmoSwvAmJYNiFGroxliGU=;
        b=Ry+tr75bVA1XSqas+55WYbN/kBfgrAKFedsiQuaz4gCjpDThV7qaRiWX2H24RRfmQ/
         F/NJoCUkIkLVJHe6rKkbNywfSw3xq+XlR31vro1NBd8EM2kKGGDn5HniUbxqzroXC7B/
         4OACTmpI9vvVvJNAIQzwG3SVTWU2NTeJuKRDxbXufxH/2BXi9Qr8KB/EcUjpSc1w22C4
         pK50L6lVAdN1RL2UMyQozaEm7TqW+jtrAMQ7R5pjyUqEwiOasP6tF6d2ChZ6ePg1eRab
         g7tV8BcEXbckIKPzmKRE1eyKW5OwmseWgN7aHWuXy4iZqMFuqkMyEX8G2lUtXpbzhamp
         teMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729270053; x=1729874853;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XL1lpry57IKuMxJrRdaCrpmoSwvAmJYNiFGroxliGU=;
        b=N60IH76j0jEy2yxES/vFvdIE9ZlUh3aZYpuLubqnjR6DlY2VOvi8HvmGaqlmuoWvE7
         3M5uPaW6mJKt9XngCDQCOy4RQkK4nVu0FXjpVAsWK8p5rCKe7H0M3yEjean7XK1UNKG3
         j5m8N/m8Czwzl75v5tX5mJewBDD/MUh/pVl8nIY1G9OF4ol/BOaND2ARJZ3YqQqFwsBB
         XPrct2UoidXDQSVofMo8hKhnRYl9g8zVy80WlYcWoXQvt2K0GoG7ZfSmCoJGZze8tD6j
         qnD6G3HHu8uFZx4JKx5So4ySWKiAK+nDbAoVmMGyZvxxIxp1EPZGlOc2/QLKZg+kLwJr
         VJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCWSUNkb5ByAZ5mssOXgwtFcDgneMgntMsepyBL/TsWqhsegPsGzN/ZekX+fEmwSn/RX1j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwRyICRhQbp0cr4QLX38ZwsZYCMiZUN2j9ZN7Xm2hQHE4Jn4Y
	lqYwgbqN6f1N23dNBIDNczUTTJCXotjMJ6+VW1mBiRl3d0lQBMlR
X-Google-Smtp-Source: AGHT+IGjykvI7Vwp2Xtq9Zrw+6Y6vYI9YIBrXdKo04xuoTF8ZK3Hy7pFHQcfakh9yY1lmkbJfJEmSg==
X-Received: by 2002:a05:6a00:21d5:b0:71e:4dc5:259a with SMTP id d2e1a72fcca58-71ea41ac773mr4791135b3a.7.1729270053274;
        Fri, 18 Oct 2024 09:47:33 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333e939sm1668549b3a.82.2024.10.18.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:47:32 -0700 (PDT)
Message-ID: <c42181ab5af3f78818db2b77a59d4aa7f3b8338f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history
 is too long
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Date: Fri, 18 Oct 2024 09:47:28 -0700
In-Reply-To: <0fd927cd-7fd2-4b15-8a17-15b907771356@iogearbox.net>
References: <20241018020307.1766906-1-eddyz87@gmail.com>
	 <0fd927cd-7fd2-4b15-8a17-15b907771356@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-18 at 13:03 +0200, Daniel Borkmann wrote:

[...]

Hi Daniel,

> Impressive that syzbot was able to generate this, and awesome analysis
> as well as fix.

Thank you for taking a look. I was a bit surprised by syzbot
generating such program as well, but I guess this is an instance of
infinite monkey theorem...

> I guess we should also add :
>=20
> Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com

Yes, we can do that. I was hesitant to add it because original report
was about a bug in mm/slub.c.

> Can we also add a Fixes tag so that this can eventually be picked up
> by stable? bpf tree would be the appropriate target, no?

The fixes tag can be:

Fixes: 2589726d12a1 ("bpf: introduce bounded loops")

But I'm a bit hesitant if this really a bug, maybe just add:

Cc: stable@vger.kernel.org

?

[...]


