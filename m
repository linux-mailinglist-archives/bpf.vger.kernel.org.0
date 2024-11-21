Return-Path: <bpf+bounces-45330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A899D479B
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 07:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0201F22ED6
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF51AA78C;
	Thu, 21 Nov 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXA6k6Bq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD270801;
	Thu, 21 Nov 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732170717; cv=none; b=cRmyYtXEPwIXdz0uv6kIAf+wB6M8m4yf2KwY3b7pMLNPygxR36Ly7cDO+hIvacmm83bG4O1q3AVndXXiromrEA5CW45e2jfzyuWcU+gwQkRfciPr85bkAzB5Timsn7XjfdUa3kRzwcdzyI4kObG5Ig/es9LvmgFWPrvL3dhpAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732170717; c=relaxed/simple;
	bh=7kkeGJoEGJO54se1DJTeClNJ3Ue76J84pIkqrraKadE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kS2jQDYIktXA+mBpBa9g02cbcmvb2gsLia4rjrDafjQWsC3vxi1PteWrWBeXaPNpkVIEYRerKxoSjivvLYe9rXCA4iR48bQ8CLHdERA2yhVnhGtUQhGKrxb3huOXeUQUv9NUWMTmEybHsclA2pCDghGp+2bngd95HNG17kFH9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXA6k6Bq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea1c455d0eso481223a91.2;
        Wed, 20 Nov 2024 22:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732170715; x=1732775515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/clsaX5ZjM/ZI0eFz6PXem6IdlBhs+vKBh9/WBzPJ4=;
        b=kXA6k6BqdNXLMz3phvtwlFAJ00sZbRzWL4FboLxIHpxQC1oUmUsGjvrGOSFaM4apPy
         WgtFOAjKwyTGJbBJS5U34F3s7We32iXJbKFYw6VG2K7LM4f6dgiJ6YSS4LBsO5byvhc8
         oFepS9N83DinUlZYGfoG9jFgrnA7jXzT1WOlMjicXV7ASzcvKhnAJ/T0AYmsiBXBEPGn
         pfnXvTluwS2BVgpM9X5TH2GH1sUQ02V6n9Oc/9tY5X3FTkbQyMEtSCswyWv/lrQi8LjB
         Bsg5mN55GttAd1y1z2Py62bdXWoRNQ7xfJHtQ9w5pY7gDbneQFANZZLG4R3ONPqQhuY7
         1tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732170715; x=1732775515;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w/clsaX5ZjM/ZI0eFz6PXem6IdlBhs+vKBh9/WBzPJ4=;
        b=LTrYW6Tm3gXLycLB3aBwqSVMmhgV+nPz0BPzFU/r8I/6bSFR8vKWgmRaIjW/lpe5g2
         bdingJ7HJenqcPzws5yLSxFMR6wIX5ZHMZX4de90dKIVpRQpAoJjq9U0dMb5qAh2oswH
         QCN1ERfDLc+g0If33wACwY8dj6FFWq++qyc7nijLjJSUtzXP1Qc+grBbXbmX95h+eofC
         sbqFGNaV944XEv41buHfzBHDqvcalDjLYyjVT8S1I4d/D2XHIUmNDeUklrpUwKxWSdRV
         ZOhv+FbSvJ6irbD7DPIth07XaJeXqOH9HtC/6sX+ysYm1F/eOZz6Pm63b3xe5Hjd+Rl6
         9LSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDYQxQYrE+5sHnzINkmy6j+lLN4SX+WMnuxvGqCQUwxA35MKf0Fi6Pr0IYTcdW7SPfggM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwR/37yHpO3NOf9AeQ9WTmfudtOZDMO3B03QN0qtEBgIgQmGl
	KS8FXSjuPjGtGkWCheTmeyw30c8KgdRT67oSGzcBpo6paEFZ6MUQ
X-Google-Smtp-Source: AGHT+IFCfh9qS8dIY5fM6QsCR/BwPVQbNr7zxFeVVthkW7hVKfZ01VwDTCODxtqdRhKkMhZcFaaQjA==
X-Received: by 2002:a17:90b:1651:b0:2ea:853b:276d with SMTP id 98e67ed59e1d1-2eaca737dfdmr7397338a91.17.1732170714625;
        Wed, 20 Nov 2024 22:31:54 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2128788fc41sm6093475ad.5.2024.11.20.22.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:31:54 -0800 (PST)
Date: Wed, 20 Nov 2024 22:31:52 -0800
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
Message-ID: <673ed3d8c25bb_157a20824@john.notmuch>
In-Reply-To: <87wmh4pmm7.fsf@toke.dk>
References: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
 <20241115125348.654145-3-maciej.fijalkowski@intel.com>
 <87wmh4pmm7.fsf@toke.dk>
Subject: Re: [PATCH bpf 2/2] bpf: fix OOB devmap writes when deleting elements
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

> > Jordy reported issue against XSKMAP which also applies to DEVMAP - th=
e
> > index used for accessing map entry, due to being a signed integer,
> > causes the OOB writes. Fix is simple as changing the type from int to=

> > u32, however, when compared to XSKMAP case, one more thing needs to b=
e
> > addressed.
> >
> > When map is released from system via dev_map_free(), we iterate throu=
gh
> > all of the entries and an iterator variable is also an int, which
> > implies OOB accesses. Again, change it to be u32.
> >
> > Example splat below:
> >
> > [  160.724676] BUG: unable to handle page fault for address: ffffc8fc=
2c001000
> > [  160.731662] #PF: supervisor read access in kernel mode
> > [  160.736876] #PF: error_code(0x0000) - not-present page
> > [  160.742095] PGD 0 P4D 0
> > [  160.744678] Oops: Oops: 0000 [#1] PREEMPT SMP
> > [  160.749106] CPU: 1 UID: 0 PID: 520 Comm: kworker/u145:12 Not taint=
ed 6.12.0-rc1+ #487
> > [  160.757050] Hardware name: Intel Corporation S2600WFT/S2600WFT, BI=
OS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > [  160.767642] Workqueue: events_unbound bpf_map_free_deferred
> > [  160.773308] RIP: 0010:dev_map_free+0x77/0x170
> > [  160.777735] Code: 00 e8 fd 91 ed ff e8 b8 73 ed ff 41 83 7d 18 19 =
74 6e 41 8b 45 24 49 8b bd f8 00 00 00 31 db 85 c0 74 48 48 63 c3 48 8d 0=
4 c7 <48> 8b 28 48 85 ed 74 30 48 8b 7d 18 48 85 ff 74 05 e8 b3 52 fa ff
> > [  160.796777] RSP: 0018:ffffc9000ee1fe38 EFLAGS: 00010202
> > [  160.802086] RAX: ffffc8fc2c001000 RBX: 0000000080000000 RCX: 00000=
00000000024
> > [  160.809331] RDX: 0000000000000000 RSI: 0000000000000024 RDI: ffffc=
9002c001000
> > [  160.816576] RBP: 0000000000000000 R08: 0000000000000023 R09: 00000=
00000000001
> > [  160.823823] R10: 0000000000000001 R11: 00000000000ee6b2 R12: dead0=
00000000122
> > [  160.831066] R13: ffff88810c928e00 R14: ffff8881002df405 R15: 00000=
00000000000
> > [  160.838310] FS:  0000000000000000(0000) GS:ffff8897e0c40000(0000) =
knlGS:0000000000000000
> > [  160.846528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  160.852357] CR2: ffffc8fc2c001000 CR3: 0000000005c32006 CR4: 00000=
000007726f0
> > [  160.859604] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > [  160.866847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > [  160.874092] PKRU: 55555554
> > [  160.876847] Call Trace:
> > [  160.879338]  <TASK>
> > [  160.881477]  ? __die+0x20/0x60
> > [  160.884586]  ? page_fault_oops+0x15a/0x450
> > [  160.888746]  ? search_extable+0x22/0x30
> > [  160.892647]  ? search_bpf_extables+0x5f/0x80
> > [  160.896988]  ? exc_page_fault+0xa9/0x140
> > [  160.900973]  ? asm_exc_page_fault+0x22/0x30
> > [  160.905232]  ? dev_map_free+0x77/0x170
> > [  160.909043]  ? dev_map_free+0x58/0x170
> > [  160.912857]  bpf_map_free_deferred+0x51/0x90
> > [  160.917196]  process_one_work+0x142/0x370
> > [  160.921272]  worker_thread+0x29e/0x3b0
> > [  160.925082]  ? rescuer_thread+0x4b0/0x4b0
> > [  160.929157]  kthread+0xd4/0x110
> > [  160.932355]  ? kthread_park+0x80/0x80
> > [  160.936079]  ret_from_fork+0x2d/0x50
> > [  160.943396]  ? kthread_park+0x80/0x80
> > [  160.950803]  ret_from_fork_asm+0x11/0x20
> > [  160.958482]  </TASK>
> >
> > Fixes: 546ac1ffb70d ("bpf: add devmap, a map for storing net device r=
eferences")
> > Reported-by: Jordy Zomer <jordyzomer@google.com>
> > Suggested-by: Jordy Zomer <jordyzomer@google.com>
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Also think its worth sending this with cc stable.

Acked-by: John Fastabend <john.fastabend@gmail.com>
> =

> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> =




