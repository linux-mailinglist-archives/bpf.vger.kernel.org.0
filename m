Return-Path: <bpf+bounces-12454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E27CC8DD
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEBFB21215
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352A9CA50;
	Tue, 17 Oct 2023 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PRGB0A4e"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13859CA61;
	Tue, 17 Oct 2023 16:30:24 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24889F7;
	Tue, 17 Oct 2023 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697560223; x=1729096223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nhGsRjdf/+8DRd3402CH1F8gtVqbu/IHtlDEiqBWqdE=;
  b=PRGB0A4exFtwDidEuaKLwVDaShoLdQSVC7wLrwp5aNBsmXLE9oQe6mql
   s/TOQ/PQQR8/AVWhGntlPP77+QIzRetC1U3yM6jjoglzOyt/lgEGtItep
   vTlqU/CFA9hHFIcR/jnwoEsAULh+TbP8/ht9b07mTtRAHsdneotOki0gu
   0=;
X-IronPort-AV: E=Sophos;i="6.03,232,1694736000"; 
   d="scan'208";a="678260187"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:30:15 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id 75E76824B7;
	Tue, 17 Oct 2023 16:30:09 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:22838]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.209:2525] with esmtp (Farcaster)
 id 86d4c900-5632-4f88-87b6-efd043245543; Tue, 17 Oct 2023 16:30:08 +0000 (UTC)
X-Farcaster-Flow-ID: 86d4c900-5632-4f88-87b6-efd043245543
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 16:30:05 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 16:30:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 11/11] selftest: bpf: Test BPF_SOCK_OPS_(GEN|CHECK)_SYNCOOKIE_CB.
Date: Tue, 17 Oct 2023 09:29:54 -0700
Message-ID: <20231017162954.18403-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <84d1ab6f-339f-c3f1-4dc3-69043a889b65@linux.dev>
References: <84d1ab6f-339f-c3f1-4dc3-69043a889b65@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.38]
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Mon, 16 Oct 2023 22:50:44 -0700
> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> > This patch adds a test for BPF_SOCK_OPS_(GEN|CHECK)_SYNCOOKIE_CB hooks.
> > 
> > BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook generates a hash using SipHash from
> > based on 4-tuple.  The hash is split into ISN and TS.  MSS, ECN, SACK,
> > and WScale are encoded into the lower 8-bits of ISN.
> > 
> >    ISN:
> >      MSB                                   LSB
> >      | 31 ... 8 | 7 6 | 5   | 4    | 3 2 1 0 |
> >      | Hash_1   | MSS | ECN | SACK | WScale  |
> > 
> >    TS:
> >      MSB                LSB
> >      | 31 ... 8 | 7 ... 0 |
> >      | Random   | Hash_2  |
> > 
> > BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB hook re-calculates the hash and validates
> > the cookie.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > Currently, the validator is incomplete...
> > 
> > If this line is changed
> > 
> >      skops->replylong[0] = msstab[3];
> > 
> > to
> >      skops->replylong[0] = msstab[mssind];
> > 
> > , we will get the error below during make:
> > 
> >      GEN-SKEL [test_progs] test_tcp_syncookie.skel.h
> >    ...
> >    Error: failed to open BPF object file: No such file or directory
> 
> I cannot reprod. Does it have error earlier than this? GEN-SKEL is probably 
> running this (make V=1 can tell):
> 
> tools/testing/selftests/bpf/tools/sbin/bpftool gen skeleton 
> tools/testing/selftests/bpf/test_tcp_syncookie.bpf.linked3.o name 
> test_tcp_syncookie > tools/testing/selftests/bpf/test_tcp_syncookie.skel.h
> 
> Add a "-d" to bpftool for more debug output: bpftool -d gen skeleton....

Somehow .rodata was 0 bytes while generating skeleton, and after
removing `static` from `msstab[]`, it compiled successfully.

Thank you!

---8<---
$ tools/testing/selftests/bpf/tools/sbin/bpftool -d gen skeleton tools/testing/selftests/bpf/test_tcp_syncookie.bpf.linked3.o name test_tcp_syncookie > tools/testing/selftests/bpf/test_tcp_syncookie.skel.h
libbpf: loading object 'test_tcp_syncookie' from buffer
libbpf: elf: section(2) .symtab, size 432, link 1, flags 0, type=2
libbpf: elf: section(3) .text, size 2888, link 0, flags 6, type=1
libbpf: sec '.text': found program 'cookie_hash' at insn offset 0 (0 bytes), code size 361 insns (2888 bytes)
libbpf: elf: section(4) sockops, size 864, link 0, flags 6, type=1
libbpf: sec 'sockops': found program 'syncookie' at insn offset 0 (0 bytes), code size 108 insns (864 bytes)
libbpf: elf: section(5) license, size 4, link 0, flags 3, type=1
libbpf: license of test_tcp_syncookie is GPL
libbpf: elf: section(6) .maps, size 32, link 0, flags 3, type=1
libbpf: elf: section(7) .rodata.cst8, size 8, link 0, flags 12, type=1
libbpf: elf: section(8) .relsockops, size 48, link 2, flags 40, type=9
libbpf: elf: section(9) .BTF, size 3891, link 0, flags 0, type=1
libbpf: elf: section(10) .BTF.ext, size 2648, link 0, flags 0, type=1
libbpf: looking for externs among 18 symbols...
libbpf: collected 0 externs total
libbpf: sec '.rodata': failed to determine size from ELF: size 0, err -2
Error: failed to open BPF object file: No such file or directory
---8<---

---8<---
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_syncookie.c
index 5d1fc928602b..19307567cc4c 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_syncookie.c
@@ -63,7 +63,7 @@ static __u32 cookie_hash(struct bpf_sock_ops *skops)
 			    &test_key_siphash);
 }
 
-static const __u16 msstab[] = {
+const __u16 msstab[] = {
 	536,
 	1300,
 	1440,
@@ -137,7 +137,7 @@ static int check_syncookie(struct bpf_sock_ops *skops)
 		return CG_ERR;
 
 	/* msstab[mssind]; does not compile ... */
-	skops->replylong[0] = msstab[3];
+	skops->replylong[0] = msstab[mssind];
 	skops->replylong[1] = skops->args[0] & (BPF_SYNCOOKIE_ECN |
 						BPF_SYNCOOKIE_SACK |
 						BPF_SYNCOOKIE_WSCALE_MASK);
---8<---


> 
> 
> I cannot compile the patch in my environment as-is also:
> 
> In file included from progs/test_tcp_syncookie.c:6:
> In file included from 
> /data/users/kafai/fb-kernel/linux/tools/include/uapi/linux/tcp.h:22:
> In file included from /usr/include/asm/byteorder.h:5:
> In file included from /usr/include/linux/byteorder/little_endian.h:13:
> /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inline'
>    136 | static __always_inline unsigned long __swab(const unsigned long y)
> 
> I have to add a "#include <linux/stddef.h>".

Will add it in v2.


> 
> 
> >      GEN-SKEL [test_progs-no_alu32] test_tcp_syncookie.skel.h
> >    make: *** [Makefile:603: /home/ec2-user/kernel/bpf_syncookie/tools/testing/selftests/bpf/test_tcp_syncookie.skel.h] Error 254
> >    make: *** Deleting file '/home/ec2-user/kernel/bpf_syncookie/tools/testing/selftests/bpf/test_tcp_syncookie.skel.h'
> >    make: *** Waiting for unfinished jobs....

