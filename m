Return-Path: <bpf+bounces-36915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2520294F5EF
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A0D1F23EDD
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3018953E;
	Mon, 12 Aug 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng3EA7Fp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F22189506
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484335; cv=none; b=MubjuPJ761VEm015OBJ41rjLek3J2o8h+ppz+6EJctRdrfD5Qj5cJ5LrThbflv2i9gFYsuHESzD58yx2HEPE9migAvloF6s1sjxuP/55SJxfRVz5u0MZa09LQ0r2bofqzVdq3qoK8C+rnXkStIY6zjer063n87rYKVXWlx/+Nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484335; c=relaxed/simple;
	bh=WSGAo1yK0rp9M5tgD2hj3aeI9iXAf7f7BJqgii81f5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jb98jPzW90wDOxoLUvNhv54jZK+stxm33TB51J0MTnMjs0TBhoq7FYPNhEFR1LRepaxAwCC4TKhWMCSTSJwL/y8BjgUgrVXByCmzNFOSQ6ihv3QIpenwjZOBCe0iGA37C0U8H9r43fJMNU+PbYD7U2ShVZTr4XusWgkE+FZ09Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng3EA7Fp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso4181292b3a.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723484333; x=1724089133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ui/n2LFerTFGLt2w2N7xELqYKYzCT6/TiXy8FRtS2YA=;
        b=ng3EA7FpkQURvRtjIz7OX8uJ1SlieEKrDeUXLlkgpcKpHccP5thyudoKDPtY/1UF/b
         YXRihOTUE1JIWcwXYmZ4bNNQFle9av146yxwN3llsrJTrLkeOo2Bg6GJRkLSGncEtolr
         xfCQ/Ul1Egl8IIi9TyzNWgwh/5XN2vt5mR4fZyArU1MdJfwW41f3sO7P/TWGC2wUifpB
         Rt/sSMUwtg5uISvdsVoVEUT332NQqj0ji/Vg6dVFfF2wp+JJi2og6hzdG9GJHOFe+AxK
         3jCH/ePjq2Hudl7RfbqLUdPOteIakjMNy6o3zDvXOCuKgfomAQzoetdmp0cnbNHvJR1g
         c2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484333; x=1724089133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ui/n2LFerTFGLt2w2N7xELqYKYzCT6/TiXy8FRtS2YA=;
        b=qiqgx72xwLsM3HhFBuOyKtyEa3BuFQgVwMy4J3LN3doIOibm5a8BTrFiILbA4oz2rZ
         mVRY0KtigCO7X/IWcla55bn1D2EegAcQaQ6nPPANd6BO4McnYQl4QCAFcG0HNclYU7A2
         blyUkrRwBh5Ib5XsP5BXXZp+5qMpZCfM560sh9GMkJdAanD7rnTxZ2uvQlQUqPPcVNoY
         qTT8+fy8hEBR0ofTZ+kq1ONNX5duPUZCP857mu3KzhlIeetLVPhnQaKtRO1i+y5wgg5u
         LWjFtWmKPNpd8U3BPSUPLODgmsbI+azxnMXkJABJmyaIXpFwKNyhyIa3QRb2MrKfS1dM
         EZjw==
X-Forwarded-Encrypted: i=1; AJvYcCXbAX/RB5ZXUpfd4sQBmuM3HrYsDlaaUMjFJyJs6Wwa3XlJkyz2kuhAxcGLgA6NJvt5a8gmZIrF2KZRjwo3MRcZvA+r
X-Gm-Message-State: AOJu0YxqV5fo6Ymwn58nLxbNDVD/gtl3G8lXdhBQLczwXkqRM1lyrJQW
	WqZ0eutYkOgMRJAAWfq2SKe4DqQ4d7KQYJ+IqlLE4FhVC1txBwa6
X-Google-Smtp-Source: AGHT+IF0y7H3VJ+e1Y6b2JElLkOJZBxXy3fiJrji6OFAZVXbLzQ+SVhv7d4NrfG6IGeqxsqJKZpzoA==
X-Received: by 2002:a05:6a20:2d07:b0:1c3:ce0f:bfb2 with SMTP id adf61e73a8af0-1c8d74b0e15mr1319432637.23.1723484332918;
        Mon, 12 Aug 2024 10:38:52 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cae3sm4425024a12.62.2024.08.12.10.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:38:52 -0700 (PDT)
Message-ID: <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Daniel Hodges
 <hodgesd@meta.com>
Date: Mon, 12 Aug 2024 10:38:47 -0700
In-Reply-To: <20240812052106.3980303-1-yonghong.song@linux.dev>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-11 at 22:21 -0700, Yonghong Song wrote:
> Daniel Hodges reported a kernel verifier crash when playing with sched-ex=
t.
> The crash dump looks like below:
>=20
>   [   65.874474] BUG: kernel NULL pointer dereference, address: 000000000=
0000088
>   [   65.888406] #PF: supervisor read access in kernel mode
>   [   65.898682] #PF: error_code(0x0000) - not-present page
>   [   65.908957] PGD 0 P4D 0
>   [   65.914020] Oops: 0000 [#1] SMP
>   [   65.920300] CPU: 19 PID: 9364 Comm: scx_layered Kdump: loaded Tainte=
d: G S          E      6.9.5-g93cea04637ea-dirty #7
>   [   65.941874] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/Delta La=
ke-Class1, BIOS F0E_3A19 04/27/2023
>   [   65.960664] RIP: 0010:states_equal+0x3ee/0x770
>   [   65.969559] Code: 33 85 ed 89 e8 41 0f 48 c7 83 e0 f8 89 e9 29 c1 48=
 63 c1 4c 89 e9 48 c1 e1 07 49 8d 14 08 0f
>                  b6 54 10 78 49 03 8a 58 05 00 00 <3a> 54 08 78 0f 85 60 =
03 00 00 49 c1 e5 07 43 8b 44 28 70 83 e0 03
>   [   66.007120] RSP: 0018:ffffc9000ebeb8b8 EFLAGS: 00010202
>   [   66.017570] RAX: 0000000000000000 RBX: ffff888149719680 RCX: 0000000=
000000010
>   [   66.031843] RDX: 0000000000000000 RSI: ffff88907f4e0c08 RDI: ffff888=
1572f0000
>   [   66.046115] RBP: 0000000000000000 R08: ffff8883d5014000 R09: fffffff=
f83065d50
>   [   66.060386] R10: ffff8881bf9a1800 R11: 0000000000000002 R12: 0000000=
000000000
>   [   66.074659] R13: 0000000000000000 R14: ffff888149719a40 R15: 0000000=
000000007
>   [   66.088932] FS:  00007f5d5da96800(0000) GS:ffff88907f4c0000(0000) kn=
lGS:0000000000000000
>   [   66.105114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   66.116606] CR2: 0000000000000088 CR3: 0000000388261001 CR4: 0000000=
0007706f0
>   [   66.130873] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
>   [   66.145145] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
>   [   66.159416] PKRU: 55555554
>   [   66.164823] Call Trace:
>   [   66.169709]  <TASK>
>   [   66.173906]  ? __die_body+0x66/0xb0
>   [   66.180890]  ? page_fault_oops+0x370/0x3d0
>   [   66.189082]  ? console_unlock+0xb5/0x140
>   [   66.196926]  ? exc_page_fault+0x4f/0xb0
>   [   66.204597]  ? asm_exc_page_fault+0x22/0x30
>   [   66.212974]  ? states_equal+0x3ee/0x770
>   [   66.220643]  ? states_equal+0x529/0x770
>   [   66.228312]  do_check+0x60f/0x5240
>   [   66.235114]  do_check_common+0x388/0x840
>   [   66.242960]  do_check_subprogs+0x101/0x150
>   [   66.251150]  bpf_check+0x5d5/0x4b60
>   [   66.258134]  ? __mod_memcg_state+0x79/0x110
>   [   66.266506]  ? pcpu_alloc+0x892/0xba0
>   [   66.273829]  bpf_prog_load+0x5bb/0x660
>   [   66.281324]  ? bpf_prog_bind_map+0x1e1/0x290
>   [   66.289862]  __sys_bpf+0x29d/0x3a0
>   [   66.296664]  __x64_sys_bpf+0x18/0x20
>   [   66.303811]  do_syscall_64+0x6a/0x140
>   [   66.311133]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>=20
> Forther investigation shows that the crash is due to invalid memory acces=
s in stacksafe().
> More specifically, it is the following code:
>=20
>     if (exact !=3D NOT_EXACT &&
>         old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
>         cur->stack[spi].slot_type[i % BPF_REG_SIZE])
>             return false;
>=20
> If cur->allocated_stack is 0, cur->stack will be a ZERO_SIZE_PTR. If this=
 happens,
> cur->stack[spi].slot_type[i % BPF_REG_SIZE] will crash the kernel as the =
memory
> address is illegal. This is exactly what happened in the above crash dump=
.
> If cur->allocated_stack is not 0, the above code could trigger array out-=
of-bound
> access.
>=20
> The patch added a condition 'i < cur->allocated_stack' to ensure
> cur->stack[spi].slot_type[i % BPF_REG_SIZE] memory access always legal.
>=20
> Fixes: 2793a8b015f7 ("bpf: exact states comparison for iterator convergen=
ce checks")
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Reported-by: Daniel Hodges <hodgesd@meta.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

My bad, for some reason I thought that 'if (i >=3D cur->allocated_stack) re=
turn false;'
check below would be sufficient. (Which is obviously not true, sigh...).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


[...]

