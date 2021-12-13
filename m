Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18BE4737AE
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhLMWhr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 17:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237073AbhLMWhr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 17:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639435066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wyjNbCiXn2veKmH5jJDy7Fh6VMZ3II96nIEpj/NLsGk=;
        b=cQDIiOtd9bz8tAhbFi3ceekrl1cxMNOqcOVIDOPBXbeTcSCa+vqx6/K0/udGDhI5R6y4R5
        BLo/iwq80aL2q9nmrUKn6UwrVu3uwJ3wj9YWg5gRAiZ68wFVbnIsv/35sxW3iZ59+M3nEH
        ZM6N6sRFO6QbgHSJREIA2ObLmzpCH1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-whYSzrMQNjm8hCwC3QLeIg-1; Mon, 13 Dec 2021 17:37:43 -0500
X-MC-Unique: whYSzrMQNjm8hCwC3QLeIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60F3681CCB6;
        Mon, 13 Dec 2021 22:37:41 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6127045D8B;
        Mon, 13 Dec 2021 22:37:40 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     naveen.n.rao@linux.vnet.ibm.com, bpf@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>
Subject: PPC jit and pseudo_btf_id
Date:   Tue, 14 Dec 2021 00:37:38 +0200
Message-ID: <xunylf0o872l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I get kernel oops on my setup due to unresolved pseudo_btf_id for
ld_imm64 (see 4976b718c355 ("bpf: Introduce pseudo_btf_id")) for
example for `test_progs -t for_each/hash_map` where callback
address is passed to a bpf helper:


[  425.853991] kernel tried to execute user page (100000014) - exploit attempt? (uid: 0)
[  425.854173] BUG: Unable to handle kernel instruction fetch
[  425.854255] Faulting instruction address: 0x100000014
[  425.854339] Oops: Kernel access of bad area, sig: 11 [#1]
[  425.854423] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[  425.854529] Modules linked in: tun bpf_testmod(OE) nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables libcrc32c nfnetlink nvram virtio_balloon vmx_crypto ext4 mbcache jbd2 sr_mod cdrom sg bochs_drm drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm virtio_net net_failover virtio_blk drm_panel_orientation_quirks failover virtio_scsi
[  425.855276] CPU: 31 PID: 8935 Comm: test_progs Tainted: G           OE    --------- ---  5.14.0+ #7
[  425.855419] NIP:  0000000100000014 LR: c000000000385554 CTR: 0000000100000016
[  425.855539] REGS: c000000022e8b740 TRAP: 0400   Tainted: G           OE    --------- ---   (5.14.0+)
[  425.855681] MSR:  8000000040009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24482844  XER: 20000000
[  425.855816] CFAR: c000000000385550 IRQMASK: 0 
[  425.855816] GPR00: c000000000381b20 c000000022e8b9e0 c000000002a45f00 c0000000248fa800 
[  425.855816] GPR04: c00000007cead8b0 c00000007cead8b8 c000000022e8ba80 0000000000000000 
[  425.855816] GPR08: 0000000000000000 0000000000000000 c00000002269acc0 0000000000000000 
[  425.855816] GPR12: 0000000100000016 c00000003ffca300 0000000000000000 0000000000000000 
[  425.855816] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000001 
[  425.855816] GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000022e8bbb0 
[  425.855816] GPR24: c000000022e8bbb4 0000000000000000 0000000000000008 c000000022e8ba80 
[  425.855816] GPR28: c0000000248fa800 0000000100000016 c00000007cead880 0000000000000001 
[  425.856853] NIP [0000000100000014] 0x100000014
[  425.856937] LR [c000000000385554] bpf_for_each_hash_elem+0x134/0x220
[  425.857047] Call Trace:
[  425.857089] [c000000022e8b9e0] [8000000000000106] 0x8000000000000106 (unreliable)
[  425.857215] [c000000022e8ba40] [c000000000381b20] bpf_for_each_map_elem+0x30/0x50
[  425.857340] [c000000022e8ba60] [c008000001cddb8c] bpf_prog_458e9855eab74599_F+0x68/0x24dc
[  425.857464] [c000000022e8bad0] [c000000000c46a9c] bpf_test_run+0x2bc/0x440
[  425.857573] [c000000022e8bb90] [c000000000c47cbc] bpf_prog_test_run_skb+0x3fc/0x790
[  425.857698] [c000000022e8bc30] [c000000000363178] __sys_bpf+0xfd8/0x2690
[  425.857805] [c000000022e8bd90] [c0000000003648dc] sys_bpf+0x2c/0x40
[  425.857910] [c000000022e8bdb0] [c000000000030c9c] system_call_exception+0x15c/0x300
[  425.858034] [c000000022e8be10] [c00000000000c6cc] system_call_common+0xec/0x250
[  425.858160] --- interrupt: c00 at 0x7fff7e751ea4

The simple patch fixes it for me:

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 90ce75f0f1e2..554c26480387 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -201,8 +201,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		 */
 		bpf_jit_fixup_subprog_calls(fp, code_base, &cgctx, addrs);
 
-		/* There is no need to perform the usual passes. */
-		goto skip_codegen_passes;
+		/* Due to pseudo_btf_id resolving, regenerate */
 	}
 
 	/* Code generation passes 1-2 */
@@ -222,7 +221,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 				proglen - (cgctx.idx * 4), cgctx.seen);
 	}
 
-skip_codegen_passes:
 	if (bpf_jit_enable > 1)
 		/*
 		 * Note that we output the base address of the code_base



Do I miss something?
Thanks!

-- 
WBR,
Yauheni Kaliuta

