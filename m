Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB43522C0
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 00:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhDAW0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDAW0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 18:26:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD4CC0613E6
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 15:26:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z9so3360493ilb.4
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=yNb3KL7GxvbHzCWeNehYiP2pwa782628YQ6dwvRP7UA=;
        b=Hkk1sXruQyr/SKPjey+bIh6d9vgArlEF0VVFua3WFhT5S9UdvutlKNvxbVwSwWHyjQ
         r0bOGNI2stYbpDb05pSOnR36iAmMXwOw2JRnzFw4e7mXJmMUQrbkpnhIA2M0CGLRZiXH
         fmi+8bU21D+6gKFOckZArWq1wTUwDA7UD1HXk6+UE3/Ofr22MFCta5lggDWc4YwMNiX4
         +BSznFDX4OYyNdvQkkFyeC5Mpnt8XhQVHJTLTf1/BLin0ZQpzdaUHCTYJjw2Wq53qhmN
         kHDFXEawxjTda5OjxDsUYk4iHbVUFaZYgArF/EvQFoHPhuB9n1pExwrpZseUDfrbmRxJ
         6qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=yNb3KL7GxvbHzCWeNehYiP2pwa782628YQ6dwvRP7UA=;
        b=uLOgCC1rdVFHPUnBaPFsSd/qPuvHGb0qGdB33mzOZClPFTNTh20E812+ci7DGq1WQd
         0l0jSNTq1iVl5j5d4Lx7TNO1FXdfLoOAh6oVjMPdTYBxSp+gw4sE0wn12TxJluxRr0TR
         IUsieGtSlarSRMR1aGJ6PLzsWA0tcwX8QtFedrGEq95q+wXSpsxvOKePvIdVdsj/q97n
         QCciR0xZRkC2E610eMEtXeo9BTk4O0jkj2haMbniIKvrsF4qPtcTVSGqo1Ty4Dp6Pmvz
         L1/vWtNJvsvFBFDi5oPAuAEK5kYtXz2jOqQB9IUBBRfh3rtre3wsPKSIc6M4AAr7IVht
         mZ8A==
X-Gm-Message-State: AOAM533x02aSDOgiMgT16gslUgEKhc4cuvwGQVbNUn3gqeI5dgYNZUB2
        toM+uujFEQuFaXsoLCh9t4g=
X-Google-Smtp-Source: ABdhPJwSUwSGI9MfzIfJ+xkqBX3wboYQGscA3KYzUtUiQLacp88wAh4m5eKzgEdXhZ0WKMmuIWKtBg==
X-Received: by 2002:a92:d349:: with SMTP id a9mr7982219ilh.225.1617315968421;
        Thu, 01 Apr 2021 15:26:08 -0700 (PDT)
Received: from [127.0.1.1] ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id q8sm2994790ilv.55.2021.04.01.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:26:08 -0700 (PDT)
Subject: [PATCH bpf-next] bpf,
 selftests: test_maps generating unrecognized data section
From:   John Fastabend <john.fastabend@gmail.com>
To:     ast@fb.com, andrii.nakryiko@gmail.com
Cc:     john.fastabend@gmail.com, bpf@vger.kernel.org
Date:   Thu, 01 Apr 2021 15:25:56 -0700
Message-ID: <161731595664.74613.1603087410166945302.stgit@john-XPS-13-9370>
User-Agent: StGit/0.23-85-g6af9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With a relatively recent clang master branch test_map skips a section,

 libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1

the cause is some pointless strings from bpf_printks in the BPF program
loaded during testing. After just removing the prints to fix above
error Daniel points out the program is a bit pointless and could
be simply the empty program returning SK_PASS.

Here we do just that and return simply SK_PASS. This program is used with
test_maps selftests to test insert/remove of a program into the sockmap
and sockhash maps. Its not testing actual functionality of the TCP sockmap
programs, these are tested from test_sockmap. So we shouldn't lose in
test coverage and fix above warnings. This original test was added before
test_sockmap existed and has been copied around ever since, clean it up
now.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/progs/sockmap_tcp_msg_prog.c     |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c b/tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c
index fdb4bf4408fa..eeaf6e75c9a2 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c
@@ -8,18 +8,6 @@ int _version SEC("version") = 1;
 SEC("sk_msg1")
 int bpf_prog1(struct sk_msg_md *msg)
 {
-	void *data_end = (void *)(long) msg->data_end;
-	void *data = (void *)(long) msg->data;
-
-	char *d;
-
-	if (data + 8 > data_end)
-		return SK_DROP;
-
-	bpf_printk("data length %i\n", (__u64)msg->data_end - (__u64)msg->data);
-	d = (char *)data;
-	bpf_printk("hello sendmsg hook %i %i\n", d[0], d[1]);
-
 	return SK_PASS;
 }
 


