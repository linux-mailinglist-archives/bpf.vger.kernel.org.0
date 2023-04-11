Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38806DD669
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDKJR3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKJR2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 05:17:28 -0400
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD9C194;
        Tue, 11 Apr 2023 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681204643;
        bh=ZbpCl+2ZgUHnd9+0Me6gjNslrGQh7vZFQlRigMsJyVM=;
        h=From:To:Cc:Subject:Date;
        b=UykTkiIIrS+4x29TOv8dssKfquzfuTn3gIj3ggm4IqdUMf+oxWHt9R6QM93En1fUQ
         NgKAq8Gb8cYtb0lg2JfVRGARnWC85VgZNj7vs08m0LQRUopSH0R7E02RrT1dm+pUHK
         GPcLCpFp7AF3Ex9Gk3poR8+U/44zlDBoafd9UB4A=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 450BDE4B; Tue, 11 Apr 2023 17:17:16 +0800
X-QQ-mid: xmsmtpt1681204636tu8cf9s6r
Message-ID: <tencent_D5422A55AFF3A307880D06AD42D559739708@qq.com>
X-QQ-XMAILINFO: MBA0Q7b4Uo1hMxwf75/oZLtFjoneMCOVW5xBoUCz5xX3DxltsR/2EYvBHKPsyA
         EbVg7mWm/IvElGfyAB5cqlBFMzSF+Eg7DGItbQ8pCAvQ4uJzUThRRXnImcUeIJtCBrvro4Fv08mZ
         /ab+G9HjT/VVltVz5NQfr01efADV44kQqN1IS3dWWb5UJC7a48Vsm4mzVloIaN+HyuapNVCI+xHP
         d6PiMMmppoOK76EvvhqZZurkuKIhTCug97qGG9DH/mZp0MJ8+xYZeX6BvDGHO3sdTePOLo2Z6lGr
         AN2v2Nxsu52JC4ymenFKetGWuz00PBdtsaaUuF3uED57foc4xp7cHdCWOlfiGa5fdeDeRDtSX7eQ
         zIxLrPKnFN9WSn833oU/sVOcPUigO5zn//XS9pVq/cXT++SgSbBSAERiKwaonsVRP4t6/OGBjUd1
         ijlHobRwU16meta0kxOp4au6OppiC+CIHrQm4LMpph+qwXtfFZL7wxI/I5ce2AAZMZmMkWJXveNh
         M4QDYncgjsBk0ZpwLWq+k3MBSQxb0dPCq72AG3UMV1TJFL3ApWVcuyfkUuMt3SljWsxVsoCFQkeE
         lW+3CJOOAoeKz7bVkG45ot7Qu0iWvjrHGrq52LAJh/2Bj1mFPpLXj0XNc5e40J8jcC3he2D/QB7U
         g0Hn9lwvnl3szPui1z0fZ/ezM8agsTNMs5BzLn2yug1gTtJZGMTR+6Bda3HQwru94esolJnjOqJW
         TGcqH/dM8ETemd/rzScfgpfGYoFtKM7OvHspzNyzFMDWcU5tHBei0nx8hTwoLxhM+nSMvlM9YPAg
         LS+doIms3Mmf9XHF+OFeL2QLQCnZj1Di7XFU3FekQ4Ch1lkYkTN88Sjhav3ETm1K8S0erKV1rXWl
         O7W1elUIadYi47DKZoTRQcfDEgpbluNoFO1eKK24bNwH/D5zRGcqmKbGKoJc+vqEdnfiRc+XLDWW
         mhxYcnXi2+GFMTgxiKPruJu2opFmw6Xyl5P8TTa1w=
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     rongtao@cestc.cn, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] tools/resolve_btfids: Ignore libsubcmd
Date:   Tue, 11 Apr 2023 17:17:14 +0800
X-OQ-MSGID: <20230411091715.148124-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Since commit af03299d8536("tools/resolve_btfids: Install subcmd headers")
introduce subcmd headers directory, we should ignore it.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/bpf/resolve_btfids/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
index 16913fffc985..52d5e9721d92 100644
--- a/tools/bpf/resolve_btfids/.gitignore
+++ b/tools/bpf/resolve_btfids/.gitignore
@@ -1,3 +1,4 @@
 /fixdep
 /resolve_btfids
 /libbpf/
+/libsubcmd/
-- 
2.39.1

