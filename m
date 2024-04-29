Return-Path: <bpf+bounces-28145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093AD8B6264
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76252851C0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4FE13B2BB;
	Mon, 29 Apr 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afsYIGHa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9013AD18;
	Mon, 29 Apr 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419250; cv=none; b=Trnu7ONxDAjJRLoh0ViGQV1ZAd+fWlcSQePT/RDZjp0NFQTnoMhFIspdJOmtbOVQAKK2NYzOwHUyu5Eze936bNl1yGus/NXicqlPUzNwtBxzJt1KTEkG2IWLto5urkGkODSd44PpSeWNq/Qc5/K0QLNCcX9NwozEn9CVBtYgD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419250; c=relaxed/simple;
	bh=McXUGND7rY/HSoTPGppNAYwB5+KhvoruwItaeISKGmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tp9gLrVqZ9mO6fYnjOHEworB2x+XuDTyMtb7ffnpIwY4eF9deHK8Zm+dnjJ8+TE88MTlnN1gUMzPT4YJ1/Jbb8KqLhO1fPlqn3GQnrzpW4aoLAYUkW5pYlrsK/npY5EHu9jVp2Cce0Bfh0HChJWIZoOZgjwheyolJIqBGnFErVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afsYIGHa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f30f69a958so4240709b3a.1;
        Mon, 29 Apr 2024 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419248; x=1715024048; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P/ETvIubls5lkG2kiipXJPsrK/Cz1sQ0+LIwN9oyV5c=;
        b=afsYIGHaE7wiMa9Qi2hR/75bIhFe/qQrxs8pWLsgL7/4TKuQqL+8owNzAJenyNenrq
         KiEl83Q1G5sinfAP2oPK9rzpdWQeU7iuJxINzSXr7e+FUDG0VpmT7kYW50Zfh6zAuMnc
         wcU6HfR7owzQlAqvUI9YbAQY6DDkIokIn3axiSfBdYE2SVhHC1GV+ftAW+E1GJB/qWsD
         EI/ArnQe/Fqm65ZZgELZhl+LhbNNigXPa8I+8eFW61xBNNV3/gBxKRwToCv60y6kRsPk
         MpjR0mAM/EC7I8fkK7qleZ5gaiq2r5ZMabfvJ80MNh2pJyiH1DYns0xv6dagu1KTIJ2e
         z24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419248; x=1715024048;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/ETvIubls5lkG2kiipXJPsrK/Cz1sQ0+LIwN9oyV5c=;
        b=EaoWAaoSdhTGeLJSg9IPKF7sf4f0mrYWVfwLMV/KwR6dHuhfCPbFvD9beWyqGUCyb1
         DSWdThXA6xcivh8AW4sPWjig3I4pBpNc6qXXqlGolT17crXkLul1uttS7o+Md8aTk3HC
         gH4N5WLCcp0MrsiyADyjYFI2ZWs/GOnQ7OrPYJSV/NXtTwx7QSvTygpnPPtdCm6LuYZv
         EflwFXRkPcx5smcJshntoafiP+gGN5hqvi1W+IWyPupyCmuhTB/5dy5zEGu8TanfYfo7
         yw8+p4ZZOGhLTXMZhWn5ZHCyJhXzEia0zUv8CoBO4XNeEVxk4yQpcyAqESqSUwPKWzoY
         ye8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5eLGt0fb7FRSrr4nkx51g5yRuQIwrix4TTYmvmJtM2KgEvtGU//NHeLlOOx70PKpXUjOBGlHwkxxdebh1AGteZ/DQOtMW89S5Zo2puKXvlsMl9J+4HeQ4ynxQ
X-Gm-Message-State: AOJu0YxDlfcB4nqPcu4dVGQsdbSTTUwv3W0IGyCyUgYMC3ROmjMmreYU
	LqhCo6nRPjOolzJSzFoMh59soPHmAYeL8tVdIWIrflR0N5Zwm2jK
X-Google-Smtp-Source: AGHT+IHDVjpOBw7hNL59nRLdXPcHFqEJzigAkFbUYN4ap7zTuJscvCf2QSSxBCJzu4W0BW11PnkTWg==
X-Received: by 2002:a05:6a20:a124:b0:1ac:663f:9efd with SMTP id q36-20020a056a20a12400b001ac663f9efdmr697341pzk.19.1714419248072;
        Mon, 29 Apr 2024 12:34:08 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id kf12-20020a17090305cc00b001e43a00ee07sm20749714plb.211.2024.04.29.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:34:07 -0700 (PDT)
Message-ID: <7c5553d33d0796a22ffa3d4c7e1791e7f033d43d.camel@gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  haoluo@google.com,
 jolsa@kernel.org,  syzbot+838346b979830606c854@syzkaller.appspotmail.com
Date: Mon, 29 Apr 2024 12:34:06 -0700
In-Reply-To: <20240426231621.2716876-2-sdf@google.com>
References: <20240426231621.2716876-1-sdf@google.com>
	 <20240426231621.2716876-2-sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 16:16 -0700, Stanislav Fomichev wrote:
> bpf_prog_attach uses attach_type_to_prog_type to enforce proper
> attach type for BPF_PROG_TYPE_CGROUP_SKB. link_create uses
> bpf_prog_get and relies on bpf_prog_attach_check_attach_type
> to properly verify prog_type <> attach_type association.
>=20
> Add missing attach_type enforcement for the link_create case.
> Otherwise, it's currently possible to attach cgroup_skb prog
> types to other cgroup hooks.
>=20
> Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program at=
tachment")
> Link: https://lore.kernel.org/bpf/0000000000004792a90615a1dde0@google.com=
/
> Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---

I've spent some time comparing:
- syscall.c:bpf_prog_attach()
- syscall.c:link_create()
- syscall.c:bpf_prog_attach_check_attach_type()
- syscall.c:attach_type_to_prog_type()
- verifier.c:check_return_code()

And it looks like BPF_PROG_TYPE_CGROUP_SKB is the only thing with
missing attach type checks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(The interplay between the above functions seems a bit messy,
 but I don't have good suggestions for refactoring at the moment.
 It appears that bpf_prog_attach_check_attach_type() could be simplified
 if prog->enforce_expected_attach_type would be set more aggressively and

	if (prog->enforce_expected_attach_type &&
	    prog->expected_attach_type !=3D attach_type)
		return -EINVAL;

 moved as a top-level check outside of the switch.
 Also BPF_PROG_TYPE_SCHED_CLS case could be removed as it is handled
 by default branch. But these are larger changes).

