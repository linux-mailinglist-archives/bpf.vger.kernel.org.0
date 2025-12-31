Return-Path: <bpf+bounces-77651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC2CECA2A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 23:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D5E3013941
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81F29D269;
	Wed, 31 Dec 2025 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/shwA/Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61F2AE99
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767220541; cv=none; b=Kp3v9PKx33/S1hM7cIHMG7rECKzbUC29DLc2sTdp6rMn+EFzHm7pEyeI6quT0rRp4+aBBsaPw7c7AtTHZEZItztRZdyptz8RQQ1QFrteWYlRIX3G5LnuDIqslHwwUy3GVpLB0gQPuuyLd/Ptt5MeeM+o9fAXs9DN++F55R8e2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767220541; c=relaxed/simple;
	bh=ZCQfxsEBShM0XeI4tQH2bY+UtMhszhhHCXclHMTGLBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUzUXoF9HK3Xkkf8aPLy980c1tZTI2pbqVRA6vs4bRkA7N+nTQ0HS/edlBPMAWF5Rfbt1DX5vTZZnebGGly3goBVAYJ+iKo4LrIJP/X7fA1TJg84PKsjIXtd6aghy/Iaj5k95Z+W/E+TVqx0iS2GD8BSPJ99HjOEf1ngoHCQkW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/shwA/Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a2ea96930cso127509325ad.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 14:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767220539; x=1767825339; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zTKTbtqOTEllTF3v0EV6BgkP1Z02Vqn1tPDHs3fZSRA=;
        b=j/shwA/Q/qnl0mYST1qIjyKfDabXr1k3v5UlcKsBfK1v+wOx0GBgE+zjqSt3gnCWDI
         yANQ8Fh0xknJWQTI2hh2xjYIA2Z398My+LjyyxgWWWQ8NpuXY+Sh87/qk6rhIIRd9clk
         TV7c3p3UzbhLYbD5cSSq3J5RQIgyZL+YvptooRMIGal/+xJVOEYK9A7eIpGCQiKphDLB
         SUcWeNn+iOFXzrgBdPaXVaI4hUtJWSST+bQ6D496t8HoO4XqbmzFt3aHQcUvsdV4jjL/
         /n4/jMyjsiBZgWQlsuLy2dxk3u55sMTE5fIKRyvrzSGxMJNT7bY+Qoj4HnrcAQOlRqYX
         umJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767220539; x=1767825339;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTKTbtqOTEllTF3v0EV6BgkP1Z02Vqn1tPDHs3fZSRA=;
        b=kLF6TfZYZQw6/Lw1GjlzFdZ+6XzmLBL0N9XLkKBxtTlWPmOKAfEGBg25uVAaY8/2Xf
         pgfEhPYUDepOmrfMgWB9Z2TOJ1oPPRUENqvzv5p/oLXBAvgAUWAshS+IS7bWXpPpaNTP
         q+JCN2MySgcIjqyRMaMBUoFN2F6Vs01DlywK3xq8K9VZMonf33BKmB+mhMTdK+18vEmn
         9RonZEHadlsApN2xyfIC8Cfrfo1wpWLDdAkjdCtR2ZMhXtLB971uZsCnL0qUv9nxbnkh
         VWMSTiTx0emlqlr+N7/MS2VwnZP1bXHMvWR1rTZHgLgT8yDFKuELdw9KsHPpvr5/6JGa
         LsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMUGtdeo+UCle3G1bgovJQZNBNJOnqwTw/v7mkb+9sMQDNsBNrdl+FJTzZQX/QYN+G8qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1NqaH3HHXhDNAhfuOjPx7qU6Huvwp+E5awgNpV82nSI4XEgD
	3czhKFpPXWg1O9rlFwh2i2e/zkEB8Dp5fgbgCifzhyJpkmOegPKk3Lia
X-Gm-Gg: AY/fxX6KxtO/kgL27xwmtO3wxw9R9SyDG108yrM4nJ5F7L597dBWRDFw5rgraFAwAV4
	fgIvY7sentwnKAjku9nSJ2xLZ/r3cnUeVLTq2JCnSW+Mig+AT7naVMGfZSiuXpwYgyEOMYJQSJN
	s6MWS/4C4GjiBtduvGoY99xt2eOkKZSBdxGJ26nqDL98NMZ5Wr/6+YXwwGruM+XtW6pMTmOc4T8
	lcwNFyEBluYLLQJJx6q1Lo/wr9KRQjaMu1WMeETBalxsFBq+4zgb77WMe5dekrDp/z+QfUJhBEG
	4eWue/QjwK2X/3TWMjJq0yryDdZd0Cqxm9NeChuZHaHBuHpnG1ZXuA8ZwTfILsZibIEHU50OUpE
	vNEQ//qZyeBg420eGNH6abvYvzzZhMzEPOaEmgxXEkpG46ibxj71gz73yd1apnZ+9QUdS94fmwu
	0eFGjbA0W1
X-Google-Smtp-Source: AGHT+IEFDkZpkh900p4HKOyqhuWUvqs/XJ/+NJs9ZlRzAktrZQXybj7xrdT61JVf8GcQHNU9M8G4ow==
X-Received: by 2002:a17:902:e5ca:b0:29e:bf7b:7f36 with SMTP id d9443c01a7336-2a2f2a41a08mr303014955ad.58.1767220538986;
        Wed, 31 Dec 2025 14:35:38 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66829sm339215465ad.10.2025.12.31.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:35:38 -0800 (PST)
Message-ID: <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song	 <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov
 <a.s.protopopov@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon	 <will@kernel.org>
Date: Wed, 31 Dec 2025 14:35:35 -0800
In-Reply-To: <20251227081033.240336-1-xukuohai@huaweicloud.com>
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-27 at 16:10 +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>=20
> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> ...
> Call trace:
>  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>  bpf_prog_run_pin_on_cpu+0x140/0x464
>  bpf_prog_test_run_syscall+0x274/0x3ac
>  bpf_prog_test_run+0x224/0x2b0
>  __sys_bpf+0x4cc/0x5c8
>  __arm64_sys_bpf+0x7c/0x94
>  invoke_syscall+0x78/0x20c
>  el0_svc_common+0x11c/0x1c0
>  do_el0_svc+0x48/0x58
>  el0_svc+0x54/0x19c
>  el0t_64_sync_handler+0x84/0x12c
>  el0t_64_sync+0x198/0x19c
>=20
> This happens because no BTI instruction is generated by the JIT for
> indirect jump targets.
>=20
> Fix it by emitting BTI instruction for every possible indirect jump
> targets when BTI is enabled. The targets are identified by traversing
> all instruction arrays of jump table type used by the BPF program,
> since indirect jump targets can only be read from instruction arrays
> of jump table type.
>=20
> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
> v3:
> - Get rid of unnecessary enum definition (Yonghong Song, Anton Protopopov=
)
>=20
> v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huaweicl=
oud.com/
> - Exclude instruction arrays not used for indirect jumps (Anton Protopopo=
v)
>=20
> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweic=
loud.com/
> ---

Hi Xu, Anton, Alexei,

Sorry, I'm a bit late to the discussion, ignored this patch-set
because of the "arm64" tag.

What you are fixing here for arm64 will be an issue for x86 with CFI
as well, right?

If that is the case, I think that we should fix this in a "generic"
way from the start. What do you think about the following:
- add a field 'bool indirect_jmp_target' to 'struct bpf_insn_aux_data'
- set this field to true for each jump target inspected by the
  verifier.c:check_indirect_jump()
- use this field in the jit to decide if to emit BTI instruction.

Seems a bit simpler than what is discussed in this patch-set.
Wdyt?

[...]

