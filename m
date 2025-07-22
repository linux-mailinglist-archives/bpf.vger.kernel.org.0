Return-Path: <bpf+bounces-64103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925EB0E50A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703A47A7CB7
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AFD285047;
	Tue, 22 Jul 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTrBjjKT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CF4C92
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216807; cv=none; b=kIJttYeA5jS10r1VBW3Y1MlPDQ/rcFgN4wPvPLkg921mSTbwmzyX+49rEPxiQ+v9HmNYvUfJurHuiH8NsnCqeCnQZsHIAH1jj8mSuWbRCLQbWW19fXrEJzNq5g/uu7Yq5xqw8LxOVqRMt/LH4UVdEJ+EGEx2gPWRwYJJ6Q0K6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216807; c=relaxed/simple;
	bh=2p89ZmbFQAv/8fefdq75yxL5xEbPHJVca772vJgu3/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIbnxLNtruQ2pFBuFDvv/ALH5ashQm6vKKmbjLkY5fmsYsv93Ia44tqm4c41QwEY4yIDvj/rc6DcxRMtfmwG6Rl8jmPN4aEmncr7oDO6cc6PRxUIHGiG9LZ/vdd8NqWCSaZktgoE4mQ0WRyqRzK6fm7MAPOl3jKXpD6Y+y+rhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTrBjjKT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235f9e87f78so56326795ad.2
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753216805; x=1753821605; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wXyplxZqqCGKWi9bRS6ZzaF8g5KCpaN7u7lmH83eJyg=;
        b=lTrBjjKTFPlOXkksrIVuDQQf6cNiv9jokc3sMMO0r7GZ64f3pG7zT5in4Q0G2E62Hf
         s8A1URG4BiYT4eFB/mi219zIRYNR2E2WzHa8EbWH9nK+pGYl0mJPDyMhtsHGRVNnMXjR
         QQ+VbLH841ANbWVWEuwJGRa3zJnxMb8TNTyqU3i1yOn4DfBqnHqTrXzybRAiTAA9Iaji
         gWs+0tq/DNlWe/Ef8q9oVrSNNo629bs2r2L+4k5VCdmQsZ+dsNl2Ms5r4XEWAUW9NhJ0
         x+kC7aWtGwEu4+QOwdVJN2Wp3PeA3fuM3v3fkF8rwALv6edT/TKaTp+ZgkM8hKX1dcNO
         I8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216805; x=1753821605;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXyplxZqqCGKWi9bRS6ZzaF8g5KCpaN7u7lmH83eJyg=;
        b=M1FolQ+sHUZGv5ZeWp5t20wrNiXiF2SfhOQY3CwNq6AJTfRx45D7jFO7yAgmkbRjnl
         zcb/I7B9K02T/IT/AylO1vY9CA1hC4qaB9jNt7xh93RPuipHQfUTWBG0/CDTe9f42xmX
         vfkmXVM8jbeIDifwnDAaZs8MuN7gCrgoCFufNpERoPigYk7pebRVG6FbQeWrGnFhWzoj
         KGrpREAQXwi25y+IQBfbycHpQ9ELdLABKFiPAvio7Ju3LApqciF8YkTa3op7QQQy5O9l
         vR6cTB8kYeBW1clV2rqIBjAuqZsZm6pmOgDkn2wvfdhMbICGwzjjs4sFfp4LgVtetp8s
         QkFw==
X-Forwarded-Encrypted: i=1; AJvYcCUtnn3ObrybolTSyqHVCxE/d5u7td4/bA3To6O6q03Aq3qYaSnjvQ+s0dBfLcGp4GLp6FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsUZ1wis9wuZHbE3VOa0pPNxdxMwtYNg65S8pR8W5tKX3N7+Q
	blV/IOMw5ijb6MW+V03YltTFLQhYkXaHvUwklGAGATcqlxCBOFrEvcNH
X-Gm-Gg: ASbGncs2qAIvDIRMIe1U5ldLEk31DDAP0PRxhlemDjnyyE6ThJ9BcPnhXss6HJ/2btG
	c376OSGxJM1ZuUxGveBOmOLGgwOeuo2uMFnhf+OM7b0EQd3Vz8rCVIabnaNnKUihazO5xviW6tX
	5wba/7+hVOjoDndzGlxyR6YSHkx3rYkKsviVr3If2MbILzXY5PY9Th+X/fUwtDizXVyGBvRK7tt
	t67yyBKJcvaozizwJX+q0nzX+wfx4dHR1QOcEcJBDIu2LLXyJuFlB0/Z4j2OIQ1OyUIGn6rAY0j
	bDSAiZfmj0kydnmgT+SuP3KIZWMSb+MiBt9V5ns/Jh8t6jZwaCjDXGljQPIocIi7VO49fQi2R7r
	sfy116vY54qxaEMItuwr8rQaAr3Hc
X-Google-Smtp-Source: AGHT+IFnoi9yncZgPD/LiFpO84+kwUkOHkjfTeRl5HlDpqtCGwHZrsVuetaOcQD2zwcl6EprMv+3UA==
X-Received: by 2002:a17:903:2984:b0:23d:d9ae:3b56 with SMTP id d9443c01a7336-23f98142833mr5460765ad.22.1753216805005;
        Tue, 22 Jul 2025 13:40:05 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2cfasm82248775ad.30.2025.07.22.13.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:40:04 -0700 (PDT)
Message-ID: <a5edd1e43ec75a026e19b687fb4f21efe5ebaa88.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject narrower access to pointer
 ctx fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Date: Tue, 22 Jul 2025 13:40:03 -0700
In-Reply-To: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
References: 
	<3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 16:32 +0200, Paul Chaignon wrote:
> The following BPF program, simplified from a syzkaller repro, causes a
> kernel warning:
>=20
>     r0 =3D *(u8 *)(r1 + 169);
>     exit;
>=20
> With pointer field sk being at offset 168 in __sk_buff. This access is
> detected as a narrower read in bpf_skb_is_valid_access because it
> doesn't match offsetof(struct __sk_buff, sk). It is therefore allowed
> and later proceeds to bpf_convert_ctx_access. At that point,
> target_size is null and the verifier errors with a kernel warning and:
>=20
>     verifier bug: error during ctx access conversion(1)
>=20
> This patch fixes that to return a proper "invalid bpf_context access
> off=3DX size=3DY" error on the load instruction.
>=20
> The same issue affects multiple other fields in context structures that
> allow narrow access. Some other non-affected fields (for sk_msg,
> sk_lookup, and sockopt) were also changed to use bpf_ctx_range_ptr for
> consistency.
>=20
> Note this syzkaller crash was reported in [1], which used to be about a
> different bug, fixed in commit fce7bd8e385a ("bpf/verifier: Handle
> BPF_LOAD_ACQ instructions in insn_def_regno()"). Because syzbot somehow
> confused the two bugs, the new crash and repro didn't get reported to
> the mailing list.
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3D0ef84a7bdf5301d4cbec [1]
> Fixes: f96da09473b52 ("bpf: simplify narrower ctx access")
> Fixes: 0df1a55afa832 ("bpf: Warn on internal verifier errors")
> Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
> Changes in v2:
>   - Use bpf_ctx_range{,_ptr} for a few other fields, for consistency,
>     as suggested by Eduard and John.
>   - Fix accesses to skb_hwtstamp, reported by Eduard.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

