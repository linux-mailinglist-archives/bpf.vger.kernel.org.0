Return-Path: <bpf+bounces-45329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797289D4781
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 07:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3540F283C90
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682314C59C;
	Thu, 21 Nov 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNtyY3rk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED613C3D6;
	Thu, 21 Nov 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732170531; cv=none; b=AB7/Gx2IV3cms/YvFL4mpbw19SdZO7yFfV8eFD1b5cMjwIn3zbVdmkExg/jYNqrpnrnoOs4iFwEGpdVgK57TbEmRsnJhOZZVmVf4lJRz2/u+feSbvwRv+bcD6VkgQ7VJz6dKTchq/OrB5TCDuDRSVD4nxic8oxwTuanst3NkTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732170531; c=relaxed/simple;
	bh=FkAJO3ug3NVjoX8qnSIJcO5dj2DnDivh2IIy9Imo9Ho=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Jn4mMTCW0Z5XrQYj48blixkGl7Hrw+ldceUs0ZCFCR/N53HAHn7+BAvUksMM+EFJCMHiCkYshnnrGJ/XUf8vX7K3sTBEMqPZUA80e1aJt2rb0vy2EKx7keTyFtyUcYxg4au7zlnGETbcOCkBfWTCX42DRA1g11orF2cmykEhlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNtyY3rk; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e607556c83so304065b6e.1;
        Wed, 20 Nov 2024 22:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732170529; x=1732775329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2doOLxq3VkXE1BFIylMDZ7wlPakzC1S8bUDdW2vZO4=;
        b=TNtyY3rk5/Umx3WPmHMh6RmF1hK/fTjHytb4iFS6+hqvw8Dm8SliQrM8afLfhILDvw
         GXOE4HPkxx5OrlWCg7Gi0AAQzVX0ZeWI+SdA4tDZfZjNzS/Xy3qWlUMD3Q3QLUu7ne2b
         vfkeaqcSc9fUpcJMIngvXUm0IYsdouZwKs+p+k2aLiqoVVcgdcPV5YZra5QGpdPR8/uC
         0aLWLNLeRBIG+hWVjHeriVqwCTJ2IbRSHBbawr8F4Wnhch7CFV9Itok1g1JwW6xu+NUw
         +Aaa4NULPZgBYyTtbL0oFDEsgMzUAJZBS0/VsoCjQ6NSRfZFelz0Oz53y5rZeg+VHEBU
         T+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732170529; x=1732775329;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u2doOLxq3VkXE1BFIylMDZ7wlPakzC1S8bUDdW2vZO4=;
        b=u9KN25eAlVG/IWjnM75Kq7ozrtsVeBpkv4HeQdV+GE3tYunAQeW12CY+F0k/Wc2HDs
         rlLCZRgH1ZZ02bXnSSEb0wAHVGNZ8/+HjRS+nxgpb1EbTVwRylve2iYNikiOJL3gfasV
         PXx1aTWiOpvh6lnsZy0FgG1ibK0b5jg/WWivHEd4CnD9Arz4z2Borj/49clkDZRCEPl9
         NZpyt1mWHB2DuS4aSNUPocFlTHGmNjkdHxM/1RwrE07D5yN257hJvGvboRx+/WT58doW
         2Q6rEOZwLreKuauxAxXeeFI5+yxo+qW8Q9Fkj12dujnp8IYcPoY66RLp2vddKwmtx39w
         olFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoM7yH0onsxD9pcZN1vCvBnWoYbswcMpDL6anjEthSVRBGuPrRdVNdUWxWOyvhNgXzd1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvw0O67Sn1OWq5afK+K9IcT/52UxNXKAdm2uz2yzc4/l3rCAVy
	Su3n6ZfK772xmpHzgAROkyzm7Z5zeR5ShRoRtUOad+EqRtLdcQI2
X-Gm-Gg: ASbGncs+r2RZyidfgZrVY8nZx4lIUvGv8we4E3lFSvM+9LiIfgo05dnarsHk1fByJKF
	+0MyZzVsm1maou1XhwpI9m6KDPhBN9DS++LDfmGJ8n5BS4HfjJQYqdRpBlQMPa9e/OhtYgKwmZF
	Ji1SUcbnxa6Iu9IQtfsZ7YLuMFBDZNIGPnr5wYSnza7jP5O77HDpZQ1FagiV2euHS7a1AbkCmrq
	4RowKjleQQk1MOWFKXt+hHwEeUYjWzTvxRkkQHgU6G/gd8ANCE=
X-Google-Smtp-Source: AGHT+IGsD1UI/Y8QtCYDOEQdOBjBflMqBFuxoCLJfWC3BcfkClKeH2XzVH7pi3pOz+FwI7cF6wJCsA==
X-Received: by 2002:a05:6808:2020:b0:3e6:134e:3b90 with SMTP id 5614622812f47-3e7eb7a0751mr6394914b6e.30.1732170528969;
        Wed, 20 Nov 2024 22:28:48 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb65821adsm581495a12.57.2024.11.20.22.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:28:48 -0800 (PST)
Date: Wed, 20 Nov 2024 22:28:47 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org
Cc: netdev@vger.kernel.org, 
 magnus.karlsson@intel.com, 
 bjorn@kernel.org, 
 maciej.fijalkowski@intel.com, 
 jordyzomer@google.com, 
 security@kernel.org
Message-ID: <673ed31f658e4_157a20845@john.notmuch>
In-Reply-To: <87zfm0pmmq.fsf@toke.dk>
References: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
 <20241115125348.654145-2-maciej.fijalkowski@intel.com>
 <87zfm0pmmq.fsf@toke.dk>
Subject: Re: [PATCH bpf 1/2] xsk: fix OOB map writes when deleting elements
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> =

> > Jordy says:
> >
> > "
> > In the xsk_map_delete_elem function an unsigned integer
> > (map->max_entries) is compared with a user-controlled signed integer
> > (k). Due to implicit type conversion, a large unsigned value for
> > map->max_entries can bypass the intended bounds check:
> >
> > 	if (k >=3D map->max_entries)
> > 		return -EINVAL;
> >
> > This allows k to hold a negative value (between -2147483648 and -2),
> > which is then used as an array index in m->xsk_map[k], which results
> > in an out-of-bounds access.
> >
> > 	spin_lock_bh(&m->lock);
> > 	map_entry =3D &m->xsk_map[k]; // Out-of-bounds map_entry
> > 	old_xs =3D unrcu_pointer(xchg(map_entry, NULL));  // Oob write
> > 	if (old_xs)
> > 		xsk_map_sock_delete(old_xs, map_entry);
> > 	spin_unlock_bh(&m->lock);
> >
> > The xchg operation can then be used to cause an out-of-bounds write.
> > Moreover, the invalid map_entry passed to xsk_map_sock_delete can lea=
d
> > to further memory corruption.
> > "
> >
> > It indeed results in following splat:
> >
> > [76612.897343] BUG: unable to handle page fault for address: ffffc8fc=
2e461108
> > [76612.904330] #PF: supervisor write access in kernel mode
> > [76612.909639] #PF: error_code(0x0002) - not-present page
> > [76612.914855] PGD 0 P4D 0
> > [76612.917431] Oops: Oops: 0002 [#1] PREEMPT SMP
> > [76612.921859] CPU: 11 UID: 0 PID: 10318 Comm: a.out Not tainted 6.12=
.0-rc1+ #470
> > [76612.929189] Hardware name: Intel Corporation S2600WFT/S2600WFT, BI=
OS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > [76612.939781] RIP: 0010:xsk_map_delete_elem+0x2d/0x60
> > [76612.944738] Code: 00 00 41 54 55 53 48 63 2e 3b 6f 24 73 38 4c 8d =
a7 f8 00 00 00 48 89 fb 4c 89 e7 e8 2d bf 05 00 48 8d b4 eb 00 01 00 00 3=
1 ff <48> 87 3e 48 85 ff 74 05 e8 16 ff ff ff 4c 89 e7 e8 3e bc 05 00 31
> > [76612.963774] RSP: 0018:ffffc9002e407df8 EFLAGS: 00010246
> > [76612.969079] RAX: 0000000000000000 RBX: ffffc9002e461000 RCX: 00000=
00000000000
> > [76612.976323] RDX: 0000000000000001 RSI: ffffc8fc2e461108 RDI: 00000=
00000000000
> > [76612.983569] RBP: ffffffff80000001 R08: 0000000000000000 R09: 00000=
00000000007
> > [76612.990812] R10: ffffc9002e407e18 R11: ffff888108a38858 R12: ffffc=
9002e4610f8
> > [76612.998060] R13: ffff888108a38858 R14: 00007ffd1ae0ac78 R15: ffffc=
9002e4610c0
> > [76613.005303] FS:  00007f80b6f59740(0000) GS:ffff8897e0ec0000(0000) =
knlGS:0000000000000000
> > [76613.013517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [76613.019349] CR2: ffffc8fc2e461108 CR3: 000000011e3ef001 CR4: 00000=
000007726f0
> > [76613.026595] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > [76613.033841] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > [76613.041086] PKRU: 55555554
> > [76613.043842] Call Trace:
> > [76613.046331]  <TASK>
> > [76613.048468]  ? __die+0x20/0x60
> > [76613.051581]  ? page_fault_oops+0x15a/0x450
> > [76613.055747]  ? search_extable+0x22/0x30
> > [76613.059649]  ? search_bpf_extables+0x5f/0x80
> > [76613.063988]  ? exc_page_fault+0xa9/0x140
> > [76613.067975]  ? asm_exc_page_fault+0x22/0x30
> > [76613.072229]  ? xsk_map_delete_elem+0x2d/0x60
> > [76613.076573]  ? xsk_map_delete_elem+0x23/0x60
> > [76613.080914]  __sys_bpf+0x19b7/0x23c0
> > [76613.084555]  __x64_sys_bpf+0x1a/0x20
> > [76613.088194]  do_syscall_64+0x37/0xb0
> > [76613.091832]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > [76613.096962] RIP: 0033:0x7f80b6d1e88d
> > [76613.100592] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e =
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
> > [76613.119631] RSP: 002b:00007ffd1ae0ac68 EFLAGS: 00000206 ORIG_RAX: =
0000000000000141
> > [76613.131330] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007=
f80b6d1e88d
> > [76613.142632] RDX: 0000000000000098 RSI: 00007ffd1ae0ad20 RDI: 00000=
00000000003
> > [76613.153967] RBP: 00007ffd1ae0adc0 R08: 0000000000000000 R09: 00000=
00000000000
> > [76613.166030] R10: 00007f80b6f77040 R11: 0000000000000206 R12: 00007=
ffd1ae0aed8
> > [76613.177130] R13: 000055ddf42ce1e9 R14: 000055ddf42d0d98 R15: 00007=
f80b6fab040
> > [76613.188129]  </TASK>
> >
> > Fix this by simply changing key type from int to u32.
> >
> > Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_=
TYPE_XSKMAP")
> > Reported-by: Jordy Zomer <jordyzomer@google.com>
> > Suggested-by: Jordy Zomer <jordyzomer@google.com>
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> =

> Nice find!

Agree nice fix. Can you resend with cc stable so it gets correctly
applied if you haven't already. Thanks

Acked-by: John Fastabend <john.fastabend@gmail.com>

> =

> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> =

> =




