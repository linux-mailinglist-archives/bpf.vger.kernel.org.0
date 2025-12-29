Return-Path: <bpf+bounces-77469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAADCE66A9
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 11:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75E4300760C
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA10C28314C;
	Mon, 29 Dec 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SdE274Y5"
X-Original-To: bpf@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0D1EFF93
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767005951; cv=none; b=BjvAJHhSjAAhNiQTQrrhbEIL8sAzD/yVIakIdjDrK9KydmZEXL5ECRS53lzSEGWe6jtXcMHpjZGb1i8ZHC8LmeYkp6qE4BJtH9r0r604zApiu6WVUwTowayM4saWDDxgxoNKW71pJCTPUs7Jvbz4DvzuiQWSINl+SmorT+8bRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767005951; c=relaxed/simple;
	bh=t06lyiSmcHJLKw7mZh5b4OzPk7QHgGznHAR+6qCyihA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 References; b=plP7s820qEo7ymmSoc4yi2+y8cC8Gd+3K8nD8YbXzLNwU3RMb2Wcp2TWG19cfemH+RaME8rCmbq/tvgu+zhxdQfUriGvnGmqxLEX8Y0ePCWzlWj8sI2F/CzhuNiunrR7hM45CfaRihpgLqyCr8lHtvG0y4kjxD2fG3eevYI9O+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SdE274Y5; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251229105900epoutp0442096e1fc2823d64618502e7c90ed005~Fqop1MNxI2766827668epoutp04f
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 10:59:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251229105900epoutp0442096e1fc2823d64618502e7c90ed005~Fqop1MNxI2766827668epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767005940;
	bh=359yQ6XbAw6WRUjKppsMEJqR1osu72NIkC7C9Pwse1A=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SdE274Y5Bd+0rXsfcEkSGFnu8o0Ul3NcbnN95uxhOBHH3jmHZg+165HtjVhIS/V56
	 d0rFo+4Q+Pcrz8RxKjaCQkYKRmy7iM/SY6wMbN5vpfimPgGyZuOq76XbWFs3VZDHtK
	 Vy56zNjM1hgztHdD9b+PvYFPmTF/OEizYEX+PFgc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20251229105900epcas2p4c2ff5e3733867193a7bfca2b2e8876ee~Fqoplg3l50418004180epcas2p46;
	Mon, 29 Dec 2025 10:59:00 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.212]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dftWR6C4vz6B9m5; Mon, 29 Dec
	2025 10:58:59 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20251229105858epcas2p26c433715e7955d20072e72964e83c3e7~FqooRMj7h2169121691epcas2p23;
	Mon, 29 Dec 2025 10:58:58 +0000 (GMT)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251229105858epsmtip2fefb80a8148940daf5672c3bd8f32845~FqooOs5XO2776727767epsmtip2h;
	Mon, 29 Dec 2025 10:58:58 +0000 (GMT)
Date: Mon, 29 Dec 2025 20:05:47 +0900
From: Jeongho Choi <jh1012.choi@samsung.com>
To: bpf@vger.kernel.org, kasan-dev@googlegroups.com
Cc: jh1012.choi@samsung.com, joonki.min@samsung.com, hajun.sung@samsung.com
Subject: [QUESTION] KASAN: invalid-access in bpf_patch_insn_data+0x22c/0x2f0
Message-ID: <20251229110431.GA2243991@tiffany>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CMS-MailID: 20251229105858epcas2p26c433715e7955d20072e72964e83c3e7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----V_Ee6mLygYIcFboi0QdK.jy0CXpDH3EB3hR9DzJVup49CurE=_1d105d_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251229105858epcas2p26c433715e7955d20072e72964e83c3e7
References: <CGME20251229105858epcas2p26c433715e7955d20072e72964e83c3e7@epcas2p2.samsung.com>

------V_Ee6mLygYIcFboi0QdK.jy0CXpDH3EB3hR9DzJVup49CurE=_1d105d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello
I'm jeongho Choi from samsung System LSI.
I'm developing kernel BSP for exynos SoC.

I'm asking a question because I've recently been experiencing 
issues after enable SW KASAN in Android17 kernel 6.18 environment.

Context:
 - Kernel version: v6.18
 - Architecture: ARM64

Question:
When SW tag KASAN is enabled, we got kernel crash from bpf/verifier.
I found that it occurred only from 6.18, not 6.12 LTS we're working on.

After some tests, I found that the device is booted when 2 commits are reverted.

bpf: potential double-free of env->insn_aux_data
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b13448dd64e27752fad252cec7da1a50ab9f0b6f

bpf: use realloc in bpf_patch_insn_data
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77620d1267392b1a34bfc437d2adea3006f95865

==================================================================
[   79.419177] [4:     netbpfload:  825] BUG: KASAN: invalid-access in bpf_patch_insn_data+0x22c/0x2f0
[   79.419415] [4:     netbpfload:  825] Write of size 27896 at addr 25ffffc08e6314d0 by task netbpfload/825
[   79.419984] [4:     netbpfload:  825] Pointer tag: [25], memory tag: [fa]
[   79.425193] [4:     netbpfload:  825] 
[   79.427365] [4:     netbpfload:  825] CPU: 4 UID: 0 PID: 825 Comm: netbpfload Tainted: G           OE       6.18.0-rc6-android17-0-gd28deb424356-4k #1 PREEMPT  92293e52a7788dc6ec1b9dff6625aaee925f3475
[   79.427374] [4:     netbpfload:  825] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   79.427378] [4:     netbpfload:  825] Hardware name: Samsung ERD9965 board based on S5E9965 (DT)
[   79.427382] [4:     netbpfload:  825] Call trace:
[   79.427385] [4:     netbpfload:  825]  show_stack+0x18/0x28 (C)
[   79.427394] [4:     netbpfload:  825]  __dump_stack+0x28/0x3c
[   79.427401] [4:     netbpfload:  825]  dump_stack_lvl+0x7c/0xa8
[   79.427407] [4:     netbpfload:  825]  print_address_description+0x7c/0x20c
[   79.427414] [4:     netbpfload:  825]  print_report+0x70/0x8c
[   79.427421] [4:     netbpfload:  825]  kasan_report+0xb4/0x114
[   79.427427] [4:     netbpfload:  825]  kasan_check_range+0x94/0xa0
[   79.427432] [4:     netbpfload:  825]  __asan_memmove+0x54/0x88
[   79.427437] [4:     netbpfload:  825]  bpf_patch_insn_data+0x22c/0x2f0
[   79.427442] [4:     netbpfload:  825]  bpf_check+0x2b44/0x8c34
[   79.427449] [4:     netbpfload:  825]  bpf_prog_load+0x8dc/0x990
[   79.427453] [4:     netbpfload:  825]  __sys_bpf+0x300/0x4c8
[   79.427458] [4:     netbpfload:  825]  __arm64_sys_bpf+0x48/0x64
[   79.427465] [4:     netbpfload:  825]  invoke_syscall+0x6c/0x13c
[   79.427471] [4:     netbpfload:  825]  el0_svc_common+0xf8/0x138
[   79.427478] [4:     netbpfload:  825]  do_el0_svc+0x30/0x40
[   79.427484] [4:     netbpfload:  825]  el0_svc+0x38/0x8c
[   79.427491] [4:     netbpfload:  825]  el0t_64_sync_handler+0x68/0xdc
[   79.427497] [4:     netbpfload:  825]  el0t_64_sync+0x1b8/0x1bc
[   79.427502] [4:     netbpfload:  825] 
[   79.545586] [4:     netbpfload:  825] The buggy address belongs to a 8-page vmalloc region starting at 0x25ffffc08e631000 allocated at bpf_patch_insn_data+0x8c/0x2f0
[   79.558777] [4:     netbpfload:  825] The buggy address belongs to the physical page:
[   79.565029] [4:     netbpfload:  825] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8b308b
[   79.573710] [4:     netbpfload:  825] memcg:c6ffff882d1d6402
[   79.577791] [4:     netbpfload:  825] flags: 0x6f80000000000000(zone=1|kasantag=0xbe)
[   79.584042] [4:     netbpfload:  825] raw: 6f80000000000000 0000000000000000 dead000000000122 0000000000000000
[   79.592460] [4:     netbpfload:  825] raw: 0000000000000000 0000000000000000 00000001ffffffff c6ffff882d1d6402
[   79.600877] [4:     netbpfload:  825] page dumped because: kasan: bad access detected
[   79.607126] [4:     netbpfload:  825] 
[   79.609296] [4:     netbpfload:  825] Memory state around the buggy address:
[   79.614766] [4:     netbpfload:  825]  ffffffc08e637f00: 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
[   79.622665] [4:     netbpfload:  825]  ffffffc08e638000: 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
[   79.630562] [4:     netbpfload:  825] >ffffffc08e638100: 25 25 25 25 25 25 25 fa fa fa fa fa fa fe fe fe
[   79.638463] [4:     netbpfload:  825]                                         ^
[   79.644190] [4:     netbpfload:  825]  ffffffc08e638200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[   79.652089] [4:     netbpfload:  825]  ffffffc08e638300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[   79.659987] [4:     netbpfload:  825] ==================================================================

I have a question about the above phenomenon.
Thanks,
Jeongho Choi

------V_Ee6mLygYIcFboi0QdK.jy0CXpDH3EB3hR9DzJVup49CurE=_1d105d_
Content-Type: text/plain; charset="utf-8"


------V_Ee6mLygYIcFboi0QdK.jy0CXpDH3EB3hR9DzJVup49CurE=_1d105d_--

