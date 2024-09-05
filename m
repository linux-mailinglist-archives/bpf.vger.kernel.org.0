Return-Path: <bpf+bounces-39028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2E96DDB4
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 17:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0ACB218A7
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6019CD12;
	Thu,  5 Sep 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATZQHOqH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2D19E7C8
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549325; cv=none; b=KSGz55u5a7yUTZg7iM3gC+lKD1/wJZ+dREaAMCEb/bns65lFU/SvPNK7+SfsNtF0zWWqcY+gkhjgcapCTYHH2gZ7SzQK1fWj4wNwc4WWKOr3ug2NhsG4drXkZK7BaLkTA7OXQqB1gAN3ID6PohDhQjuKXvpHb+h/L6UIeqXRza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549325; c=relaxed/simple;
	bh=kgZ/GTub4zIltFQ1rhyiNWllR4zVjukH/mFfLyKjdRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mNf8ryhLQe/TsZrRUXvcWfpcUWvuzhlaGJlnZ6HYtaWOdmcdlP3lw+iCh9haj3VbMqlR0VWPUzBu3VDrBDKnFhcKd+puCI1q9snDWK2VhezMn65GkKpWXw1dM9Uft8WdmwDyvQw8LW5Wno8J9fmbt3YhY8aZ4S/umn05CjcpZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATZQHOqH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725549322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+D2JO1Sv9f8w08j0F5oUb3DOiEjMuvKMZg9/vPICL4=;
	b=ATZQHOqHeYtx1J5LGPiqmIZtsGbTBt4RaG7bFamVUJZZgr4VBA9vFkAQobc1Vz6QG4OYsm
	SfDhHQionIimJDC+QsDfZ2Vw4C7zm9qepvCD0hJIrbOIPGKuwUhe6+FcD1mDsq7ZLdWQ8A
	SW7ZkvlXmjl/NDd50FHLuhGx4WyiZ+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-0ZSAzYBUOOeWzRua5whKXQ-1; Thu, 05 Sep 2024 11:15:20 -0400
X-MC-Unique: 0ZSAzYBUOOeWzRua5whKXQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bbff6a0aeso8031345e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 08:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549319; x=1726154119;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+D2JO1Sv9f8w08j0F5oUb3DOiEjMuvKMZg9/vPICL4=;
        b=S/kcUbDHlTKbnq8q4hfNM0sKuGMi9jmFyUgKpxken2CgcDmbdGFqzvffg162a4hLSy
         VAgPGvDrqafCaK8G7PQV5jGNWKdC69jEfGuqbLuTwxONUYW9fvjp0rrpWNzrHsYDQpvt
         0yTnGeHSkaI8zW8lD7UfVTdboXGTprS1jmrr6WXl8sH3d/MalCA/M6Ya2a6XdOafAu8M
         VKPixWt13WPKGsM6CtjMXHg7eqYOvuXSwFntaCTyA70laSjoTmaoK8Yu6aXBFXKmrggI
         4YLnWu9hdKEBt6VRHfchq74vi4A9hYieSpCQXDJ7fr9aFjZu+auSiWCBwxBixupyZXXh
         iROw==
X-Forwarded-Encrypted: i=1; AJvYcCWiGiwd2s+GjhA5JyicCPWliyhb+7cB55Vchz/Ni0QUj9908bRGCGX40wUW0M8Of/Khx2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZ7E4Mr0jyXA3tvsLot0DzPau4jDO+ADWLEQIn23lyNpNjolr
	op1UPoe1lYNEAKu8c0rAMTwDq5HFkRN/4BfsJDi/BpG/0RDxsFo4EVkBm0dBZuxjkrZsUD3vS9l
	2P6Pypuc9v9UqbvXZHCpPmgPp3+W8RtjwqCFOhG2MDTsexGHDXw==
X-Received: by 2002:a05:600c:1551:b0:428:ea8e:b48a with SMTP id 5b1f17b1804b1-42c8de5f5c3mr55668295e9.8.1725549319542;
        Thu, 05 Sep 2024 08:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWRHAKPVHbKmoNXax7xz3y2d2HCbxy3sWP40uZC9KUiev+f+LtA/r6ifkOGXbJC4EQRRtssw==
X-Received: by 2002:a05:600c:1551:b0:428:ea8e:b48a with SMTP id 5b1f17b1804b1-42c8de5f5c3mr55668015e9.8.1725549318927;
        Thu, 05 Sep 2024 08:15:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642594dsm276098465e9.47.2024.09.05.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:15:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B748314AE908; Thu, 05 Sep 2024 17:15:17 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
 <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH net] bpf: devmap: provide rxq after redirect
In-Reply-To: <20240905-devel-koalo-fix-ingress-ifindex-v1-1-d12a0d74c29c@linutronix.de>
References: <20240905-devel-koalo-fix-ingress-ifindex-v1-1-d12a0d74c29c@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Sep 2024 17:15:17 +0200
Message-ID: <87bk12i12y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Kauer <florian.kauer@linutronix.de> writes:

> rxq contains a pointer to the device from where
> the redirect happened. Currently, the BPF program
> that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
> does not have it set.
>
> This is particularly bad since accessing ingress_ifindex, e.g.
>
> SEC("xdp")
> int prog(struct xdp_md *pkt)
> {
>         return bpf_redirect_map(&dev_redirect_map, 0, 0);
> }
>
> SEC("xdp/devmap")
> int prog_after_redirect(struct xdp_md *pkt)
> {
>         bpf_printk("ifindex %i", pkt->ingress_ifindex);
>         return XDP_PASS;
> }
>
> depends on access to rxq, so a NULL pointer gets dereferenced:
>
> <1>[  574.475170] BUG: kernel NULL pointer dereference, address: 00000000=
00000000
> <1>[  574.475188] #PF: supervisor read access in kernel mode
> <1>[  574.475194] #PF: error_code(0x0000) - not-present page
> <6>[  574.475199] PGD 0 P4D 0
> <4>[  574.475207] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> <4>[  574.475217] CPU: 4 UID: 0 PID: 217 Comm: kworker/4:1 Not tainted 6.=
11.0-rc5-reduced-00859-g780801200300 #23
> <4>[  574.475226] Hardware name: Intel(R) Client Systems NUC13ANHi7/NUC13=
ANBi7, BIOS ANRPL357.0026.2023.0314.1458 03/14/2023
> <4>[  574.475231] Workqueue: mld mld_ifc_work
> <4>[  574.475247] RIP: 0010:bpf_prog_5e13354d9cf5018a_prog_after_redirect=
+0x17/0x3c
> <4>[  574.475257] Code: cc cc cc cc cc cc cc 80 00 00 00 cc cc cc cc cc c=
c cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 57 2=
0 <48> 8b 52 00 8b 92 e0 00 00 00 48 bf f8 a6 d5 c4 5d a0 ff ff be 0b
> <4>[  574.475263] RSP: 0018:ffffa62440280c98 EFLAGS: 00010206
> <4>[  574.475269] RAX: ffffa62440280cd8 RBX: 0000000000000001 RCX: 000000=
0000000000
> <4>[  574.475274] RDX: 0000000000000000 RSI: ffffa62440549048 RDI: ffffa6=
2440280ce0
> <4>[  574.475278] RBP: ffffa62440280c98 R08: 0000000000000002 R09: 000000=
0000000001
> <4>[  574.475281] R10: ffffa05dc8b98000 R11: ffffa05f577fca40 R12: ffffa0=
5dcab24000
> <4>[  574.475285] R13: ffffa62440280ce0 R14: ffffa62440549048 R15: ffffa6=
2440549000
> <4>[  574.475289] FS:  0000000000000000(0000) GS:ffffa05f4f700000(0000) k=
nlGS:0000000000000000
> <4>[  574.475294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  574.475298] CR2: 0000000000000000 CR3: 000000025522e000 CR4: 000000=
0000f50ef0
> <4>[  574.475303] PKRU: 55555554
> <4>[  574.475306] Call Trace:
> <4>[  574.475313]  <IRQ>
> <4>[  574.475318]  ? __die+0x23/0x70
> <4>[  574.475329]  ? page_fault_oops+0x180/0x4c0
> <4>[  574.475339]  ? skb_pp_cow_data+0x34c/0x490
> <4>[  574.475346]  ? kmem_cache_free+0x257/0x280
> <4>[  574.475357]  ? exc_page_fault+0x67/0x150
> <4>[  574.475368]  ? asm_exc_page_fault+0x26/0x30
> <4>[  574.475381]  ? bpf_prog_5e13354d9cf5018a_prog_after_redirect+0x17/0=
x3c
> <4>[  574.475386]  bq_xmit_all+0x158/0x420
> <4>[  574.475397]  __dev_flush+0x30/0x90
> <4>[  574.475407]  veth_poll+0x216/0x250 [veth]
> <4>[  574.475421]  __napi_poll+0x28/0x1c0
> <4>[  574.475430]  net_rx_action+0x32d/0x3a0
> <4>[  574.475441]  handle_softirqs+0xcb/0x2c0
> <4>[  574.475451]  do_softirq+0x40/0x60
> <4>[  574.475458]  </IRQ>
> <4>[  574.475461]  <TASK>
> <4>[  574.475464]  __local_bh_enable_ip+0x66/0x70
> <4>[  574.475471]  __dev_queue_xmit+0x268/0xe40
> <4>[  574.475480]  ? selinux_ip_postroute+0x213/0x420
> <4>[  574.475491]  ? alloc_skb_with_frags+0x4a/0x1d0
> <4>[  574.475502]  ip6_finish_output2+0x2be/0x640
> <4>[  574.475512]  ? nf_hook_slow+0x42/0xf0
> <4>[  574.475521]  ip6_finish_output+0x194/0x300
> <4>[  574.475529]  ? __pfx_ip6_finish_output+0x10/0x10
> <4>[  574.475538]  mld_sendpack+0x17c/0x240
> <4>[  574.475548]  mld_ifc_work+0x192/0x410
> <4>[  574.475557]  process_one_work+0x15d/0x380
> <4>[  574.475566]  worker_thread+0x29d/0x3a0
> <4>[  574.475573]  ? __pfx_worker_thread+0x10/0x10
> <4>[  574.475580]  ? __pfx_worker_thread+0x10/0x10
> <4>[  574.475587]  kthread+0xcd/0x100
> <4>[  574.475597]  ? __pfx_kthread+0x10/0x10
> <4>[  574.475606]  ret_from_fork+0x31/0x50
> <4>[  574.475615]  ? __pfx_kthread+0x10/0x10
> <4>[  574.475623]  ret_from_fork_asm+0x1a/0x30
> <4>[  574.475635]  </TASK>
> <4>[  574.475637] Modules linked in: veth br_netfilter bridge stp llc iwl=
mvm x86_pkg_temp_thermal iwlwifi efivarfs nvme nvme_core
> <4>[  574.475662] CR2: 0000000000000000
> <4>[  574.475668] ---[ end trace 0000000000000000 ]---

Yikes! I wonder how that has gone unnoticed this long. Could you please
add a selftest for this so it doesn't happen again?

> Therefore, provide it to the program by setting rxq properly.
>
> Fixes: fbee97feed9b ("bpf: Add support to attach bpf program to a devmap =
entry")

I think the fixes tag is wrong; the original commit was fine because the
xdp_buff was still the one initialised by the driver. So this should be:

Fixes: cb261b594b41 ("bpf: Run devmap xdp_prog on flush instead of bulk enq=
ueue")

Other than that, though, the patch LGTM:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


