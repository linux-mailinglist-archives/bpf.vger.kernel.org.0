Return-Path: <bpf+bounces-72335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA0C0E93B
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93244463819
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7930C626;
	Mon, 27 Oct 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDxLR1S1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D53130C619
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575512; cv=none; b=SiiZ/QktypDNeixAVnyhaPXp92I0R75ys6JIAhW+gK0OpfxZXKOZtX8ZsSOxJjSRwwbtpQwMqFw25i5KMBm2Oefzonmmlcoy7o+lP5ulZNievO+JFaooEMz6EWbVoKS24/9MOnS2I7iJ4vI9fPXIpN7QaZpsTwroSPJww2FSrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575512; c=relaxed/simple;
	bh=5yoCK2fLFx2htBhJqpSHdGHkPxVFQ0/TNvSRi8cTu5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdjTgRnzSFHf32R6nNvKC/yu3Xo0r18CflxEauLl6x8xK9zeW/htXHd9BupIZBvC+V6fpJrjupw+y5sZLAvhHspGjbzti4T34CtOUPWjlnT3om/igEfgiXaqFdIqqqV5HS0LCvWJrODl6lCtVQtNhXaNhIjhdhtxrvOhWSN86Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDxLR1S1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761575509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC2NuXLdnjLHgFfW2yobW9SdnsNBGRycsRCnkqVBmtg=;
	b=VDxLR1S1qMrqnfjiLqVNX5rxQdF2rLA12ZthxYA+A4zB+29/xBbfrLfUFZQBeCfcfOXVAT
	Ke5M8e678GmbirwZI25jzCMM3UQ2AqRMtvF6uomtW59/nfrwZBhHwBgt7GW0HiMvZWKUEJ
	MydUzVx4+WdNVjYJZ1oxbqYtkhTFMHA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-qStH0w4HN-C-DX7IAEmFjQ-1; Mon, 27 Oct 2025 10:31:48 -0400
X-MC-Unique: qStH0w4HN-C-DX7IAEmFjQ-1
X-Mimecast-MFC-AGG-ID: qStH0w4HN-C-DX7IAEmFjQ_1761575507
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4626b2d07bso393597966b.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 07:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575507; x=1762180307;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC2NuXLdnjLHgFfW2yobW9SdnsNBGRycsRCnkqVBmtg=;
        b=VmPiH51QmZiPsRw6J76Iukq8X5oyu7yD5aI0S7XCT7Sd8HBvu/9Z4hPJ4e4syuYAyW
         WuUAk7z0q9zl1XJwn9I+arYgrLXU2D6o3BwCG2rPHBIt3juiLJg3BXFkmgHsdhQoW65y
         YyrM1tcUKswdJgNMdd5mkoHOH1sOZ3TcDLWV3BDWWbUsDNgvUcssN/Y7SvLAWc0lItfK
         qo8TsjA+p2UugGUr5s1h06JtUzKxvYKw5kwkQ172Y4wN+7J03P6pB7TWI11J5oc1z7LG
         Hr0E0tSPdBxnWe0E0O9vFUpke6M0cni0M6OCNA3l/fcIwpDcwHzMEkG1bzTinPiFTZD4
         J7bg==
X-Forwarded-Encrypted: i=1; AJvYcCUBljx/mkA/eZgbYyDTObdc9rCl48nlOd4NSaB6mL8T2aZULGqI6gTZYBaaFuUKZOjU3Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iI+9Reizaxwcck4e4md8MzyJMkO0g04ymrwYt6VSgxXCcOVW
	NgIqTPCq3smUr5+gXfPWsOB2JD2lBnAtCuy217P31O5s50yQQFgy+adWoGcLpncVFw5O0a+dqDA
	FDlH4cvOMTg/N9aJhlC80vJCe7hUSiFYHzcXNZMppO6uBGNbhCAb0Ww==
X-Gm-Gg: ASbGnctqHNYzXq6qZS9saEqU/vu5Xq6n+vYDUW6hvs5QhnQ9fmXAqaAoVoJxMk/LXtH
	TKGRBpJ1xnQJ/Q91yvUETpiBbtRede+mFuJuJoIYlxjD3DgumTdtvQKv98Wccd8WE8oUQJHwuq0
	yMsJT9HOqXzZUFsvtUfLCUMhS7Y9YclSd6XxQi/PWNGClZOPKH92vGnCmt7nFHIfnuR56h5uftz
	tiO1AJu63IVLCGsSQn0S4RXrUBWMcrsMZMN6wFg3R5B9CYi9cZSrgJF+pH+tjTWSSKZEG5ypgVk
	b/2lXrdu15x4u0p4Uc8sdD8cXnSdOJfr/0aqZTeUZJvh6GlaW9rSKQpAJ5sqMLi6NVu6d00F1D0
	tC/druN1hhhE/R36D2mZbtfe+2Q==
X-Received: by 2002:a17:907:7ba8:b0:b3d:200a:bd6e with SMTP id a640c23a62f3a-b6dba5a54e7mr10307966b.47.1761575506850;
        Mon, 27 Oct 2025 07:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu+GLRLPMVOA9xC7zkvI5UmwsYsI28Ty7IQo5OH1Hkudxl2thVOn2YkMHx0f0USc0NQF4l6A==
X-Received: by 2002:a17:907:7ba8:b0:b3d:200a:bd6e with SMTP id a640c23a62f3a-b6dba5a54e7mr10305466b.47.1761575506419;
        Mon, 27 Oct 2025 07:31:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed8fsm782554466b.73.2025.10.27.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:31:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 300D92EAA60; Mon, 27 Oct 2025 15:31:45 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
 lorenzo@kernel.org, kuba@kernel.org, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v4 bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <20251027121318.2679226-3-maciej.fijalkowski@intel.com>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
 <20251027121318.2679226-3-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:31:45 +0100
Message-ID: <87ms5ce7qm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> When skb's headroom is not sufficient for XDP purposes,
> skb_pp_cow_data() returns new skb with requested headroom space. This
> skb was provided by page_pool.
>
> For CONFIG_DEBUG_VM=3Dy and XDP program that uses bpf_xdp_adjust_tail()
> against a skb with frags, and mentioned helper consumed enough amount of
> bytes that in turn released the page, following splat was observed:
>
> [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x11c98b
> [   32.210084] flags: 0x1fffe0000000000(node=3D0|zone=3D1|lastcpupid=3D0x=
7fff)
> [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 00=
00000000000000
> [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 00=
00000000000000
> [   32.220900] page dumped because: page_pool leak
> [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O     =
   6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> [   32.224638] Tainted: [O]=3DOOT_MODULE
> [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   32.224641] Call Trace:
> [   32.224644]  <IRQ>
> [   32.224646]  dump_stack_lvl+0x4b/0x70
> [   32.224653]  bad_page.cold+0xbd/0xe0
> [   32.224657]  __free_frozen_pages+0x838/0x10b0
> [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> [   32.224688]  ? veth_set_channels+0x920/0x920
> [   32.224691]  ? get_stack_info+0x2f/0x80
> [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> [   32.224700]  ? common_startup_64+0x13e/0x148
> [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> [   32.224706]  ? stack_trace_save+0x84/0xa0
> [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> [   32.224716]  ? timerqueue_add+0x217/0x320
> [   32.224719]  veth_poll+0x115/0x5e0
> [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> [   32.224730]  ? update_cfs_group+0x121/0x2c0
> [   32.224733]  __napi_poll+0xa0/0x420
> [   32.224736]  net_rx_action+0x901/0xe90
> [   32.224740]  ? run_backlog_napi+0x50/0x50
> [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> [   32.224749]  handle_softirqs+0x151/0x430
> [   32.224752]  do_softirq+0x3f/0x60
> [   32.224755]  </IRQ>
>
> It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
> when initializing xdp_buff.
>
> Fix this by using new helper xdp_convert_skb_to_buff() that, besides
> init/prepare xdp_buff, will check if page used for linear part of
> xdp_buff comes from page_pool. We assume that linear data and frags will
> have same memory provider as currently XDP API does not provide us a way
> to distinguish it (the mem model is registered for *whole* Rx queue and
> here we speak about single buffer granularity).
>
> Before releasing xdp_buff out of veth via XDP_{TX,REDIRECT}, mem type on
> xdp_rxq associated with xdp_buff is restored to its original model. We
> need to respect previous setting at least until buff is converted to
> frame, as frame carries the mem_type. Add a page_pool variant of
> veth_xdp_get() so that we avoid refcount underflow when draining page
> frag.
>
> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3=
aJw7hE+4E2_iPA@mail.gmail.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


