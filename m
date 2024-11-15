Return-Path: <bpf+bounces-44957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D99CE6F9
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F6E28553A
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39DC1BBBE4;
	Fri, 15 Nov 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWbQ0IHb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A21487CD
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682869; cv=none; b=Cxd19rlgbYkIVLmVx95eCZ/HY1o/IHjFCCVH6q1qjqS+wtfatuKtQjO552/Or0J1RzVdtqaHd7vdOx9ZOuEIJbW3hEqRge0jF24QEFfLXeFKLOLQQMPt2TKBrNWbXLvavZ/Em2PHM/uqY1kjJrmo4VJe/7jYGgG0ONm2CSIVeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682869; c=relaxed/simple;
	bh=c1B9hMCy9b75yUVvQG7MZGzt1wvnf/ZGw2Nn2EfgPvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBxYZKLRyCdzQ1i/j8iqLI4LlJMd59gcVutssjZcJp74V2wKgDYUdLAHBOw+yesgdaTzYfzZqobBrzCqXdC/M9BTLwQRUMSxjSkNUDTeyuHECTl5RCbeQQoQm029nRlznH8UX/MLTSi2lNy2hZmyQnRNAjMkwxveHSJm0efr4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWbQ0IHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731682866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcowlmDIcrkfc110anbi70nMPSXBhumNQnlzRe1HH5Q=;
	b=OWbQ0IHblTEEDOnA27k61aTrQ1fjvbwb0b4ajTEchd9hRZnivTKMMnSc2oPEhMYBOJJa1F
	kZpHD4CJ6xDtk+veHzjC4APLHkEyBscXjp/d4fYAkwt5c0lWWl0Xy54/SPLQ0g9In6vHxC
	fAqMp0rMpoDSk7C7OD5pPykr+oLYMRg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-AXwynD3rNNKbTbJAfkdGFQ-1; Fri, 15 Nov 2024 10:01:04 -0500
X-MC-Unique: AXwynD3rNNKbTbJAfkdGFQ-1
X-Mimecast-MFC-AGG-ID: AXwynD3rNNKbTbJAfkdGFQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43152cd2843so12302685e9.3
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 07:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682863; x=1732287663;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcowlmDIcrkfc110anbi70nMPSXBhumNQnlzRe1HH5Q=;
        b=Umi3ZaED60c94d6A3i7kRCAfQZ44+o4KYqw3YaAQCz9X78qe595NnG3mSmgQuBYIF3
         4ZRzpLID6FqcGUo090jYpxXRFlUFSjqYtGoqI24XW/2BP13f9U7ndyidFlAkyy0hi3iU
         nbJzvAOQ+zu1pgtxI6whA6k10B5sRJg3PT3ujs2tsqke0ZJIZuq/Nlp0rTGeJvMYZ1pU
         s2Z4DopzOFR+UPnrlyvVpT/qNaGRx0hpVAmeQ7wLNt0IuDPs8ehVSnXbu7y09Tz+pnnD
         MelyzetMNXcyW3mB/TzdY4/M1PPlZdXHVo/e9UmpH7pnGBfKO4hY7XnjyRPkkBOFGW2Q
         /U5w==
X-Forwarded-Encrypted: i=1; AJvYcCXE+UjQzcz+b4w3A6tByqzI5m+DakqSGtsuvTmAo7JIXQCHJrLZmlYisTEjYglv2aMhwME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgvc9g+f3tObg3Zua8d8jRYi2Dspui2HfrtJOm+UucnyAWzZq2
	OJXYVSqawa0iMmkgVfYSs7z4A/gGqaUo55HiihJOch2kRK/RofAVKva/fyjYRJyOD6jErxqH/f7
	VnGghw7zPDd1KCovOvI2BxxxlyvRl3Fk8NCqAbvTWNXSavn+orQ==
X-Received: by 2002:a05:600c:a4a:b0:431:588a:4498 with SMTP id 5b1f17b1804b1-432df74cd7bmr25380575e9.14.1731682863228;
        Fri, 15 Nov 2024 07:01:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBCIILcwZAoE1FRnzf8N+LL293YX5zWOyTGhxEZTwe57EXlPhPpIi9dqhnKA/bIyaRtXAMPA==
X-Received: by 2002:a05:600c:a4a:b0:431:588a:4498 with SMTP id 5b1f17b1804b1-432df74cd7bmr25379875e9.14.1731682862693;
        Fri, 15 Nov 2024 07:01:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28bc11sm59106615e9.31.2024.11.15.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:01:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2C8BD164D223; Fri, 15 Nov 2024 16:01:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, jordyzomer@google.com, security@kernel.org
Subject: Re: [PATCH bpf 1/2] xsk: fix OOB map writes when deleting elements
In-Reply-To: <20241115125348.654145-2-maciej.fijalkowski@intel.com>
References: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
 <20241115125348.654145-2-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 15 Nov 2024 16:01:01 +0100
Message-ID: <87zfm0pmmq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Jordy says:
>
> "
> In the xsk_map_delete_elem function an unsigned integer
> (map->max_entries) is compared with a user-controlled signed integer
> (k). Due to implicit type conversion, a large unsigned value for
> map->max_entries can bypass the intended bounds check:
>
> 	if (k >=3D map->max_entries)
> 		return -EINVAL;
>
> This allows k to hold a negative value (between -2147483648 and -2),
> which is then used as an array index in m->xsk_map[k], which results
> in an out-of-bounds access.
>
> 	spin_lock_bh(&m->lock);
> 	map_entry =3D &m->xsk_map[k]; // Out-of-bounds map_entry
> 	old_xs =3D unrcu_pointer(xchg(map_entry, NULL));  // Oob write
> 	if (old_xs)
> 		xsk_map_sock_delete(old_xs, map_entry);
> 	spin_unlock_bh(&m->lock);
>
> The xchg operation can then be used to cause an out-of-bounds write.
> Moreover, the invalid map_entry passed to xsk_map_sock_delete can lead
> to further memory corruption.
> "
>
> It indeed results in following splat:
>
> [76612.897343] BUG: unable to handle page fault for address: ffffc8fc2e46=
1108
> [76612.904330] #PF: supervisor write access in kernel mode
> [76612.909639] #PF: error_code(0x0002) - not-present page
> [76612.914855] PGD 0 P4D 0
> [76612.917431] Oops: Oops: 0002 [#1] PREEMPT SMP
> [76612.921859] CPU: 11 UID: 0 PID: 10318 Comm: a.out Not tainted 6.12.0-r=
c1+ #470
> [76612.929189] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS S=
E5C620.86B.02.01.0008.031920191559 03/19/2019
> [76612.939781] RIP: 0010:xsk_map_delete_elem+0x2d/0x60
> [76612.944738] Code: 00 00 41 54 55 53 48 63 2e 3b 6f 24 73 38 4c 8d a7 f=
8 00 00 00 48 89 fb 4c 89 e7 e8 2d bf 05 00 48 8d b4 eb 00 01 00 00 31 ff <=
48> 87 3e 48 85 ff 74 05 e8 16 ff ff ff 4c 89 e7 e8 3e bc 05 00 31
> [76612.963774] RSP: 0018:ffffc9002e407df8 EFLAGS: 00010246
> [76612.969079] RAX: 0000000000000000 RBX: ffffc9002e461000 RCX: 000000000=
0000000
> [76612.976323] RDX: 0000000000000001 RSI: ffffc8fc2e461108 RDI: 000000000=
0000000
> [76612.983569] RBP: ffffffff80000001 R08: 0000000000000000 R09: 000000000=
0000007
> [76612.990812] R10: ffffc9002e407e18 R11: ffff888108a38858 R12: ffffc9002=
e4610f8
> [76612.998060] R13: ffff888108a38858 R14: 00007ffd1ae0ac78 R15: ffffc9002=
e4610c0
> [76613.005303] FS:  00007f80b6f59740(0000) GS:ffff8897e0ec0000(0000) knlG=
S:0000000000000000
> [76613.013517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [76613.019349] CR2: ffffc8fc2e461108 CR3: 000000011e3ef001 CR4: 000000000=
07726f0
> [76613.026595] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [76613.033841] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [76613.041086] PKRU: 55555554
> [76613.043842] Call Trace:
> [76613.046331]  <TASK>
> [76613.048468]  ? __die+0x20/0x60
> [76613.051581]  ? page_fault_oops+0x15a/0x450
> [76613.055747]  ? search_extable+0x22/0x30
> [76613.059649]  ? search_bpf_extables+0x5f/0x80
> [76613.063988]  ? exc_page_fault+0xa9/0x140
> [76613.067975]  ? asm_exc_page_fault+0x22/0x30
> [76613.072229]  ? xsk_map_delete_elem+0x2d/0x60
> [76613.076573]  ? xsk_map_delete_elem+0x23/0x60
> [76613.080914]  __sys_bpf+0x19b7/0x23c0
> [76613.084555]  __x64_sys_bpf+0x1a/0x20
> [76613.088194]  do_syscall_64+0x37/0xb0
> [76613.091832]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [76613.096962] RIP: 0033:0x7f80b6d1e88d
> [76613.100592] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
> [76613.119631] RSP: 002b:00007ffd1ae0ac68 EFLAGS: 00000206 ORIG_RAX: 0000=
000000000141
> [76613.131330] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f80b=
6d1e88d
> [76613.142632] RDX: 0000000000000098 RSI: 00007ffd1ae0ad20 RDI: 000000000=
0000003
> [76613.153967] RBP: 00007ffd1ae0adc0 R08: 0000000000000000 R09: 000000000=
0000000
> [76613.166030] R10: 00007f80b6f77040 R11: 0000000000000206 R12: 00007ffd1=
ae0aed8
> [76613.177130] R13: 000055ddf42ce1e9 R14: 000055ddf42d0d98 R15: 00007f80b=
6fab040
> [76613.188129]  </TASK>
>
> Fix this by simply changing key type from int to u32.
>
> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE=
_XSKMAP")
> Reported-by: Jordy Zomer <jordyzomer@google.com>
> Suggested-by: Jordy Zomer <jordyzomer@google.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Nice find!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


