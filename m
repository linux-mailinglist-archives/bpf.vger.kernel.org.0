Return-Path: <bpf+bounces-68727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D0B8284C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 03:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4B1BC68CD
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227C212542;
	Thu, 18 Sep 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1+qNLob"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD12AD02
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159345; cv=none; b=eulkqgm1bHSDxyCNZ7Ps8j+Qv6R25FHK/E0Cpg/MRAT2yFzgSyCIgJhZgTyekFyH2dTwJzI8A0fgaFLyOQWv7xVHuMgB97EiEdmW4/Jzszi7C60vAbeKb7qN2p/jSfeAFgJyZrnMMbytBLzKiCEhqbEjYe/xC1XoMUqdKEVGPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159345; c=relaxed/simple;
	bh=+BiQxHR0sMw4bws4vjX8Lfg+EOXrjNiNQa43pQ3EtzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT/Kftp5GVImzpingDXhU8g6VYp90fCogKDjR0VJ0otX8aSU4KIEUCBvv5C2JszfmDIEwkoL+Dd6sBArIMxDUwABg43Z1It+a+zQ6slfpuHnoQx9xdw/yU2lHLgscugakmEoorVYM8VcxnB1LGWeSK42/4ASckSCiJ4QHe+6FZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1+qNLob; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so186009f8f.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758159342; x=1758764142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSybrBC/rdjcGvf0hq1MDZt6KEULdTINBoTYLblrYYg=;
        b=L1+qNLobN8DOGr2pWeToVBhzYU8BXLCRZc2IBMKqh9BjKVBKxRIxkpdNH9j7weGWic
         +YlPkeYZooMbO/wGfEtoIlUcq+v0lgOh5v/euwchhdyehGoE1GLQ68qimJ4nsldtd2Il
         /I1g6ALWDZUSX8s0vQx4GtrHW6I5mqT5VEHoA/NrXvb+LemgE2Du/dSxwv1tYSin4Crw
         77ubuNZ+IxqVfkBR0RXR6mqGF68Sh7FU2/Pskr+1PdRXlZjfUEn68XE7aDskVK4yWGKR
         r6qpDyrQ1ipQeGXD3O/SC73/xCT838pxcw+ACeTrPdmDLvN+oy5fTZ0d/0SqlixgEW/m
         llbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758159342; x=1758764142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSybrBC/rdjcGvf0hq1MDZt6KEULdTINBoTYLblrYYg=;
        b=FDq7Ldo8Qx3M3Hjqujvq7OUE49rmT8h85AYfDUgQ/S71YHVJNgNY/MboVGNqytmc6L
         4xQFGU769mmBUmvpW7G7JDn42WQdQ34cRW4+hqQqPDSUD98B87QFiWgYZz625NcTSmuU
         tpWM6HRaPQ6LXOX6PvgvWmid/PH+bsaKeuJvL6LZm7kwdiJiZA+TYxRrdzphQIq7sLh9
         4Aoe6NyxKGkWnApRPDSqFS3/KQUOKT/JMWJOdjIsvM1fi9aSRqQVYdyN3DvZBw9Xaf3Q
         zQcAVvq6aki8SpKqOiTOXLvVVuUIV74RNFJE8nEi/z5+PuA4LzWOHT5S6jEVR5zQYKJd
         GcrA==
X-Forwarded-Encrypted: i=1; AJvYcCXDBWt4STcTT5+0zYE2IpwfuzfVecsWfVuvCXZrP/UwNKf77Zv0NmVH8yzAChgDXfVN6gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENkNQgFWigIwSqguRqo19Og28yz94zr9LBBeBWeQbmQGV/thA
	cPRYwO85TPB2XucWXiBNTBK8pH8aXkvzCj7jNzEKGVRMKd9xAn5Ak3p+SLEGxAL8XUWlBZ0nh4v
	LdJQtDJEHXax1fDPy4b6guFLfGAQdJSg=
X-Gm-Gg: ASbGncsdvVRXqEi9y5oDir6FiaOQ6wSeV3VqfGRbS4bS9F40DZVkfv45WPiRsZSUHkP
	OIC+P435FAKtib76/QqQK/yHSNwtWI3DfJ73gG3czhM3AmOo4xlW8MHg4HkdUIvpq72Hl5jtmOd
	zojQtrebtAWb8I2Y5EO2hE2rjgk10Qb2PSL6RnezqOMlyuRMItahHQ/DtvshVSMZfGjukkbLhRr
	tE6U9Oi/LAba2EucKPaRN+UhyUO31isAp3jzyWAJID/laD4Ww06Z0s=
X-Google-Smtp-Source: AGHT+IEu2CSf6uFy1XDB7wSMpRY9tqj2E1uL03q0kizrn+SLovOhtJzQ6hHo1byBciJJbu5wiZfX/++DUF6fjLbG8J4=
X-Received: by 2002:a5d:588b:0:b0:3e9:3b91:e846 with SMTP id
 ffacd0b85a97d-3ecdf9bec6cmr3766053f8f.10.1758159342417; Wed, 17 Sep 2025
 18:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909163223.864120-1-chen.dylane@linux.dev> <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 18:35:31 -0700
X-Gm-Features: AS18NWCYK9OkDnZL4vr7j5GLCRXvtVevLFVckSHebrLSGTAV60VgXcmxFFLoPlc
Message-ID: <CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> P.S. It seems like a good idea to switch STACKMAP to open addressing
> instead of the current kind-of-bucket-chain-but-not-really
> implementation. It's fixed size and pre-allocated already, so open
> addressing seems like a great approach here, IMO.

That makes sense. It won't have backward compat issues.
Just more reliable stack_id.

Fixed value_size is another footgun there.
Especially for collecting user stack traces.
We can switch the whole stackmap to bpf_mem_alloc()
or wait for kmalloc_nolock().
But it's probably a diminishing return.

bpf_get_stack() also isn't great with a copy into
perf_callchain_entry, then 2nd copy into on stack/percpu buf/ringbuf,
and 3rd copy of correct size into ringbuf (optional).

Also, I just realized we have another nasty race there.
In the past bpf progs were run in preempt disabled context,
but we forgot to adjust bpf_get_stack[id]() helpers when everything
switched to migrate disable.

The return value from get_perf_callchain() may be reused
if another task preempts and requests the stack.
We have partially incorrect comment in __bpf_get_stack() too:
        if (may_fault)
                rcu_read_lock(); /* need RCU for perf's callchain below */

rcu can be preemptable. so rcu_read_lock() makes
trace =3D get_perf_callchain(...)
accessible, but that per-cpu trace buffer can be overwritten.
It's not an issue for CONFIG_PREEMPT_NONE=3Dy, but that doesn't
give much comfort.

Modern day bpf api would probably be
- get_callchain_entry()/put() kfuncs to expose low level mechanism
with safe acq/rel of temp buffer.
- then another kfuncs to perf_callchain_kernel/user into that buffer.

and with bpf_mem_alloc and hash kfuncs the bpf prog can
implement either bpf_get_stack() equivalent or much better
bpf_get_stackid() with variable length stack traces and so on.

