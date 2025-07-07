Return-Path: <bpf+bounces-62481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA74AFA8C0
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 03:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066EC18985FE
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D613633F;
	Mon,  7 Jul 2025 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cshbx4sj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA87E9
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751850634; cv=none; b=jGatus8ImCJyF8Al/G7z837yDSV1kdGzXUgib4jyKnKi0PndLxSKa0u/uP96jTPTCcz/lc2u/Mkt446aQdj+Q5NUB8ndyO1U8Ol6BYP93E0z6ctCEsjvrhGF84jm14002RTfQohiA9TWB8qdgesha7uQxAL60rLrEL8Sps4WGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751850634; c=relaxed/simple;
	bh=WoxsdiX13FhG+jfJNmbXOLgIknOkGaGkimZkfoaTF1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srV4uCCqjmaeEbypeTqxCJVh+u/nK18F5xdKmBX7Eqb4Ol3sMZBOKnyNcqLdU3IN3wTZ8wXxEknJGzrf1gwFrZgP/PoqiHHFjccPMExEnSXkZcRUZU+vbLVEAPaqAATmo1g6u/uBtWJvld3cSzCU9GdxfQgvKrf2UQlOuJM81sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cshbx4sj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-236377f00a1so21377245ad.3
        for <bpf@vger.kernel.org>; Sun, 06 Jul 2025 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751850633; x=1752455433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9AIAKACib/W/7Bg2agm7lO1sSn2H56aSotscjkml18E=;
        b=Cshbx4sjjiWFNmd1MUhv2OyKRX0G9wPJ2Wm/IjOGQK3Aqq/OoPTsLkp2mDUZvmFZHD
         yfK27LK1WiZhfYZVxXkRYFA5WYaLwKiZpyqvg6wUGEKgsEmhqywW0EuQRICIG5dCqpMQ
         0XwG0o17zPs3zdNelvAT/pOkSj4K3wRDqCaYAfVagH8dEM0lPVlWMzE4QYkluJt+n+aG
         ixYXQUDQvvUCbsm2lXhap9ysGs2QngK0O4FVNIhwW9zpOMxxRzKzX8h4lx3//dlE9k6s
         zlRntIW53jLJz/PZqXn/uIJjXUjPuteLsBIsHRPKr5SgSyhLRWvzryfke4WYBQBfxdee
         7B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751850633; x=1752455433;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AIAKACib/W/7Bg2agm7lO1sSn2H56aSotscjkml18E=;
        b=GmSoFfMGJMhShFQ49UJoFHJInIcwN/c/tgoipfRcIOTm0UTNXPebs00geg0UKxKOz6
         HmtFScooGCI2zq1xkYhm3ciOqhTv0P8DvQsgc22EwfXQ32MqRS17hlX3wQ7gaxZrBNUB
         ebuLm1ou5Xbr7aLxyaa0D2P5MIkcqc2oR5pt5YfQaDHpWMGDSdOruYLjYZmbzc4alkum
         wmYaGJWI6vqGShlm/wbPx3gucksUzX3bhblBTxnb7E58ZT8ussK9nU4rH9PbKA57fWXl
         wMGUD4P/Z/Qv+VC2RQBNIryhWJnhmJTKaYsczN+HIfB5WnBvFalxIKF0hqvJ+S9A5w3v
         05bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTdf+pBaj+47R+HQ6gva4BmlXZeD9RgINRjl++1g9KyZN6scEkmxIZojCLNc2D+hSg6XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mB8dQqpXe364fy30/BXtXJ/TcLeeMh2xi0YNOXqC6Erdlr2e
	xgTnN+bxXS6/mgFzOn1RJNHTRcsivweg6Eljgf5wGl5hWgibyw/nqpeWMgjOlA==
X-Gm-Gg: ASbGncvJ3c1pGhK1VmIdyOPRWRqVC5D0N/HBXo0h3md+ocCPJC3TYakVAE7J00CfvUj
	uRVxSJvf2kfySQEkTfRXw5QimLWjf+qF1WVl1bgww8zKiE4qlhexWmy2TpPTVyvIfWT1OKhea/K
	TnrPBoyknCjQeJsV14yjWrug3BkJG7yf7x+zgHikU7RBLR7Nt+RtBM5TTkj1UUbfVQb8GXADrXQ
	Mq8SEZ7ddM/kjzo5zbQVcH/48EAUO2l+lWYoQho6m4mFaYrz4BhqL+T5STNCmpY/AgsA3AKZwdm
	Bs9GE1aFDh1xF4pjqYJZmLktgYo55rj/aBp1/kU3GvfI2gA4lRBkzjnTqQ==
X-Google-Smtp-Source: AGHT+IGgFfwzVXsjapYkXTJHLlnA1MsjsJluZ30YB6aDCdoN2ZIEw3qWOqv86aZUuw9kkbrYrIO7jg==
X-Received: by 2002:a17:903:1209:b0:234:d7b2:2aa9 with SMTP id d9443c01a7336-23c91009078mr117389185ad.29.1751850632321;
        Sun, 06 Jul 2025 18:10:32 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845801b2sm70484725ad.169.2025.07.06.18.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 18:10:31 -0700 (PDT)
Message-ID: <e36a9cee7bd2cdda3560c8b278ac2591632da3d1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix bounds for
 bpf_prog_get_file_line linfo loop
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Sun, 06 Jul 2025 18:10:29 -0700
In-Reply-To: <20250705053035.3020320-2-memxor@gmail.com>
References: <20250705053035.3020320-1-memxor@gmail.com>
	 <20250705053035.3020320-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 22:30 -0700, Kumar Kartikeya Dwivedi wrote:
> We may overrun the bounds because linfo and jited_linfo are already
> advanced to prog->aux->linfo_idx, hence we must only iterate the
> remaining elements until we reach prog->aux->nr_linfo. Adjust the
> nr_linfo calculation to fix this. Reported in [0].
>=20
>   [0]: https://lore.kernel.org/bpf/f3527af3b0620ce36e299e97e7532d2555018d=
e2.camel@gmail.com
>=20
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 0e521efaf363 ("bpf: Add function to extract program source info")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Nit: It would be nice to extend progs/stream.c, so that e.g.
     cond_break exhaustion is reported from a subprogram.
     I checked it locally and everything works as expected.

