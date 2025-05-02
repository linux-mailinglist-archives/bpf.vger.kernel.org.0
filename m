Return-Path: <bpf+bounces-57291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054AAA7B61
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3611B980DF4
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF82080F4;
	Fri,  2 May 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="AZhRR/Ev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D588F9CB
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221484; cv=none; b=jwrnOPfEC9sjZ2P5IdLvMW+iFQ/BoX89dtPwDm7sVqL8nq0CYagKTvsBaKlhJkCzcB9Q0Zlo+tnf5CIJ9aYJKUE2Ku0r3Fy1E/z0sYl5iddB4ZJk5mxBdw86VpGrcrXmGLYyLgbjzmbmELYxQ3rXFbJNBkoPtstcuZeJytLihnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221484; c=relaxed/simple;
	bh=RGXQNtLTkh+xIhPnSkMALdI+GFl4K4fNKdAJQESg89U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqgrqS5GMU/FLXiLdw/0IfF580HKpqGYTq7vX7/k5VN3/B18/XJ/V/3vKEC/Ih1j5j+q1LyTkzfaJMSvdCNzHWGChANWf+P4u5tzRv5U7nqVu1RTE6ZVnPb8IWYNZZmW8hMIi3GkhenvB0QpNDnZSjxbvl7/wemTAkJ6UpYVDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=AZhRR/Ev; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8ff1b051dso5172106d6.1
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746221481; x=1746826281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RGXQNtLTkh+xIhPnSkMALdI+GFl4K4fNKdAJQESg89U=;
        b=AZhRR/EvdELWEyiIf1WuDbs1PudlLz5g2zTy2AsEo9tsQIyeCR8ktX+2ojLbTpR0v2
         TLgq8pNZF4v5uzHGB7dbgXHTfzgSRFtKRfPioDAVwYJtJ54S8z4Skvsxsii+Sq+jh3dP
         IvTow1kg9KTG12+f4fIx2f+I0kngY6pTdOfPCQ3m3LRlhLJhN4RTi3HvfHqr9Kn/LDAd
         bh5Ry0Uc+wnVTHmTt4vnn7RprxMy9POgcwLnOlsAuuTXkzo52xpIlUgqhfQDhhcQTPlM
         hS9ov2tuRNbt6sWwloZvWwBsyBHNDeh6ybf7Onc2l1NRlJkLD9ewkgm157F8DLxVQt1Y
         /21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746221481; x=1746826281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGXQNtLTkh+xIhPnSkMALdI+GFl4K4fNKdAJQESg89U=;
        b=qXxVfT27nVopb7sJseno4GK0qnCBm1a7kbSq2o2aHlmvkqQPOZeuJuUKsX1jkF6F1d
         sF5QqWEWIbdFdj/AtaEMW5lE8yYP6emHDb+4TRjJn3iIx8qS08yEv9Il+VCKL9wCvAH6
         GEadMFekaSSZbu0Vrc9qbJR7KEQ/tsSDaOXl+7TjM77G2SWNWfXoie/iMcndNi8DOvZd
         FZUnXgvM2zAam7TRFHKe1TdDwj//FUvaU5JVkHgkXD3keqTFJQgtmrhMuJ+hpmZWKqzQ
         J3nWHC+B8uuH57IXvxC/C2IhPcCTdxm6a0GKclgxOH324w51tv+4YmdxxS0NmKAEHRvZ
         Z27g==
X-Forwarded-Encrypted: i=1; AJvYcCVIx329fJhCkoBxhK4zdZuqS2Y3/FIMyeaonWlN6vGEO1SkOSqkKJK81z0mfm4tWpa834I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy819OndjVQKV6pc+J5xjuBmzSLZv4MdhSHRE+W+ql0iIjFLd+x
	p0a4qRLeyyCgIUaZ3FxLh1KZhsbQA5vy2N1hRJLPswdQd9W7A5iqB9Cq9x8V0I74B1lM0YwK4k5
	fqjIi55AuopFzSQ2FfWhP8cvQ5eIQqao0cKTUhw==
X-Gm-Gg: ASbGnctbbI2xLqG2l/vCpEgSktFcFSP40N7+CFKLW56Q4DGS88aqr/bOjwTrQh/xLf0
	gB8DJnwxZkPzwTgicWgmbCSZrh4iUppmJsOpkM0w6zatdo9tM9Hhu0tCuH2qThKsmoZQ+OUuvWe
	H2HuVtAz+XGr6NEOg3v/pE6ITzp1NPBr1Aw0HegNXhAcKqlf3yNOD26KY=
X-Google-Smtp-Source: AGHT+IERfHMRWcJQMEva4rkmtn5ehpt9XaNEm3Fv/nxtB2z2K6G25t/gHReTY9xAMlW7M2olUtASjCG9tZusu4eWnO4=
X-Received: by 2002:ad4:5c81:0:b0:6e8:fa58:85fc with SMTP id
 6a1803df08f44-6f5153770c5mr29352856d6.3.1746221481458; Fri, 02 May 2025
 14:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502161528.264630-1-jordan@jrife.io> <20250502161528.264630-5-jordan@jrife.io>
 <77957459-cd64-4d7e-a503-829a1cf892c9@linux.dev>
In-Reply-To: <77957459-cd64-4d7e-a503-829a1cf892c9@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Fri, 2 May 2025 14:31:10 -0700
X-Gm-Features: ATxdqUHL5mMsQfKQeV7aDz9_4D8WLgTmIP7TBLfiWweLEbVP5Zbljy49Y0_yJKo
Message-ID: <CABi4-ojQc-QwOpe_OdMCF4NhAQ5K32HfJt2QVGn8do_vSsudnA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item for
 bpf_udp_iter_state batch items
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I fixed this to "while (cur_sk < iter->end_sk)". Not that matters since the next
patch 5 fixed itself but it is better to keep this patch clean.

Agh, missed this while shifting things around.

Thanks for patching it up!

Jordan

