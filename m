Return-Path: <bpf+bounces-44958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E89CEA96
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0E3B32FCA
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2211D4333;
	Fri, 15 Nov 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUC9xSKf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A871B6CEB
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682889; cv=none; b=emcKDL1PSWlW0HgLJLD3SnwhHkuUHPb2EtKSWrnq1CsbO5ROfsRdRri3nQ0Ow1EgGV9eBbKilwXCrE3ekt0LGgnh5V8Q+Mt4GH8tHsK8q9RMiNYpNryZ+JRAl0bsVte8m9WDukDD5gCwcmDB4JXqXgZ9+MGxPA9O8bwjUyhnSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682889; c=relaxed/simple;
	bh=4+wPdWcf1Zk14i7rQciPleQc/xgg17XNWPwGwBr67HM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAmYqqbkKLSh1vJ+exn0JbM9KsttURpkbyj45ReoTeheOhkxCPrvQW47jt/r78vDM5J84ig/B6G5mM4Cq4YmpLV6Rm/iFdbh4Ggs/oUwfS478rQv85jLx3iNoINUOGTjwV4YDcaC5j8NYv8SHGQ46hNmhI4+yRN1MbuZN9wy0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUC9xSKf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731682887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHUBGiiFcOHg/PutvfT3htJMFkefnO57swkf+fvIRUE=;
	b=fUC9xSKfA0vj8nCeSucylQOLZOp1gbLLaZbkiwFOhc1AIy1bnpquItXUvfnd9tCOEBbFou
	qtbxqzMS0/DK7mXVdxZwFFgJl5kt36mEmKrjJOQ1r5gMMPU4yLVeha/BD7kKkzFTGh0vQ7
	eQvmp5sQ/HBT9J2GSwWbWuc/gpFDCcE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-yZmOqh37N_aSKiSqCSQVmg-1; Fri, 15 Nov 2024 10:01:25 -0500
X-MC-Unique: yZmOqh37N_aSKiSqCSQVmg-1
X-Mimecast-MFC-AGG-ID: yZmOqh37N_aSKiSqCSQVmg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso14421415e9.3
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 07:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682884; x=1732287684;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHUBGiiFcOHg/PutvfT3htJMFkefnO57swkf+fvIRUE=;
        b=mMizHWGBA1xmjXACfF1PLdVcykp3mh3pig9OlDieMygt7qCKr6IQp0vX6S6rHXgMuH
         av2FXnEZH9WqATuVrhMntr1lJeIpsi0eD6kY+1aJVBDgNTauaKPHfSrjnlWpdsTX4Evo
         sZrfkCAsRRNcOkWWMkLbLzgT4fO85ROfNLbDFSip7qsQYc3XZ5fx1rOqCvy5GiytQoPY
         4m2WRLUh20Y9VLkDobarPOti40AddHqxnK9PMRr/BHMlQfh4FvPdXT7elIEX09iNsSkR
         VsXJCp46ZzvhQTkrNytTY/8h3XydndEcL78fceeWKcdwtdXqq5IA6HLVn1Fk/DbDzq1N
         HbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVprqvx02YyBSQxZcgykX3NxUHiq0QjBCUCSi74J+w5/2Ec9iGHhnSH5BjeGprJoBEqYxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeiDGE5ZwS4dSvNbdLBKUJnM4Ic63pkiaLl2Lvx6XHL5a0xIHA
	yczhqsIehEN8MzYyu5iNZVLYrNR5ZbyptBb1h2frc/8NNruWmP6lbvHqW6hW5yh+z7kJnA8QLT2
	KYMEVjBqSg0cRRiRt/S/60aBisCvsCtP93Yl8hVTARzfDEV9aEA==
X-Received: by 2002:a05:600c:1553:b0:431:4fa0:2e0b with SMTP id 5b1f17b1804b1-432df78fd66mr20191875e9.28.1731682884353;
        Fri, 15 Nov 2024 07:01:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCeVARQgK8ePyFnDk6zxe0RJeUF456/Aex6zRm1UWyWfokhEeX0+DtvT5b/SYZmCaC+f9qgg==
X-Received: by 2002:a05:600c:1553:b0:431:4fa0:2e0b with SMTP id 5b1f17b1804b1-432df78fd66mr20189735e9.28.1731682881885;
        Fri, 15 Nov 2024 07:01:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm59116345e9.35.2024.11.15.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:01:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 43BB6164D225; Fri, 15 Nov 2024 16:01:20 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, jordyzomer@google.com, security@kernel.org
Subject: Re: [PATCH bpf 2/2] bpf: fix OOB devmap writes when deleting elements
In-Reply-To: <20241115125348.654145-3-maciej.fijalkowski@intel.com>
References: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
 <20241115125348.654145-3-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 15 Nov 2024 16:01:20 +0100
Message-ID: <87wmh4pmm7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Jordy reported issue against XSKMAP which also applies to DEVMAP - the
> index used for accessing map entry, due to being a signed integer,
> causes the OOB writes. Fix is simple as changing the type from int to
> u32, however, when compared to XSKMAP case, one more thing needs to be
> addressed.
>
> When map is released from system via dev_map_free(), we iterate through
> all of the entries and an iterator variable is also an int, which
> implies OOB accesses. Again, change it to be u32.
>
> Example splat below:
>
> [  160.724676] BUG: unable to handle page fault for address: ffffc8fc2c00=
1000
> [  160.731662] #PF: supervisor read access in kernel mode
> [  160.736876] #PF: error_code(0x0000) - not-present page
> [  160.742095] PGD 0 P4D 0
> [  160.744678] Oops: Oops: 0000 [#1] PREEMPT SMP
> [  160.749106] CPU: 1 UID: 0 PID: 520 Comm: kworker/u145:12 Not tainted 6=
.12.0-rc1+ #487
> [  160.757050] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS S=
E5C620.86B.02.01.0008.031920191559 03/19/2019
> [  160.767642] Workqueue: events_unbound bpf_map_free_deferred
> [  160.773308] RIP: 0010:dev_map_free+0x77/0x170
> [  160.777735] Code: 00 e8 fd 91 ed ff e8 b8 73 ed ff 41 83 7d 18 19 74 6=
e 41 8b 45 24 49 8b bd f8 00 00 00 31 db 85 c0 74 48 48 63 c3 48 8d 04 c7 <=
48> 8b 28 48 85 ed 74 30 48 8b 7d 18 48 85 ff 74 05 e8 b3 52 fa ff
> [  160.796777] RSP: 0018:ffffc9000ee1fe38 EFLAGS: 00010202
> [  160.802086] RAX: ffffc8fc2c001000 RBX: 0000000080000000 RCX: 000000000=
0000024
> [  160.809331] RDX: 0000000000000000 RSI: 0000000000000024 RDI: ffffc9002=
c001000
> [  160.816576] RBP: 0000000000000000 R08: 0000000000000023 R09: 000000000=
0000001
> [  160.823823] R10: 0000000000000001 R11: 00000000000ee6b2 R12: dead00000=
0000122
> [  160.831066] R13: ffff88810c928e00 R14: ffff8881002df405 R15: 000000000=
0000000
> [  160.838310] FS:  0000000000000000(0000) GS:ffff8897e0c40000(0000) knlG=
S:0000000000000000
> [  160.846528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  160.852357] CR2: ffffc8fc2c001000 CR3: 0000000005c32006 CR4: 000000000=
07726f0
> [  160.859604] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  160.866847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  160.874092] PKRU: 55555554
> [  160.876847] Call Trace:
> [  160.879338]  <TASK>
> [  160.881477]  ? __die+0x20/0x60
> [  160.884586]  ? page_fault_oops+0x15a/0x450
> [  160.888746]  ? search_extable+0x22/0x30
> [  160.892647]  ? search_bpf_extables+0x5f/0x80
> [  160.896988]  ? exc_page_fault+0xa9/0x140
> [  160.900973]  ? asm_exc_page_fault+0x22/0x30
> [  160.905232]  ? dev_map_free+0x77/0x170
> [  160.909043]  ? dev_map_free+0x58/0x170
> [  160.912857]  bpf_map_free_deferred+0x51/0x90
> [  160.917196]  process_one_work+0x142/0x370
> [  160.921272]  worker_thread+0x29e/0x3b0
> [  160.925082]  ? rescuer_thread+0x4b0/0x4b0
> [  160.929157]  kthread+0xd4/0x110
> [  160.932355]  ? kthread_park+0x80/0x80
> [  160.936079]  ret_from_fork+0x2d/0x50
> [  160.943396]  ? kthread_park+0x80/0x80
> [  160.950803]  ret_from_fork_asm+0x11/0x20
> [  160.958482]  </TASK>
>
> Fixes: 546ac1ffb70d ("bpf: add devmap, a map for storing net device refer=
ences")
> Reported-by: Jordy Zomer <jordyzomer@google.com>
> Suggested-by: Jordy Zomer <jordyzomer@google.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


