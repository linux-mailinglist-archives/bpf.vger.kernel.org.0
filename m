Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F425246D4
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350936AbiELHXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbiELHWw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:22:52 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11D50E0F
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:subject:mime-version:
   content-transfer-encoding;
  bh=lCQWLaOt9+OgO4Rxpzj2ZafoSvz5gbNP2BnbALB+1fs=;
  b=WJYONESbwEyu2VO9P5kkyp3sKr8HcI1yX4854Fkku7JoDDZxgBp5/T4O
   XhM+TvI7bxTBlMwBlUCkCRN8mosiV40S9wj5EThg7wBC0cIJMeS04ci9q
   j2DR8UtWeSwYEfmLLDw6Iaa7CvYGmtWK85MjwYlT1s/OXpm9N+WmtUhOE
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=shenghao.yuan@inria.fr; spf=None smtp.helo=postmaster@zcs-store4.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of shenghao.yuan@inria.fr is inclined to not designate
  128.93.142.31 as permitted sender) identity=mailfrom;
  client-ip=128.93.142.31;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="shenghao.yuan@inria.fr";
  x-sender="shenghao.yuan@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@zcs-store4.inria.fr) identity=helo;
  client-ip=128.93.142.31;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="shenghao.yuan@inria.fr";
  x-sender="postmaster@zcs-store4.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.91,219,1647298800"; 
   d="scan'208";a="35877073"
X-MGA-submission: =?us-ascii?q?MDE0LqlhR7+zPamASJLx+fHk03r+OnBn1so3K+?=
 =?us-ascii?q?CBMkHpT4Xnps0/RgnjN+HCiAUL0iNhrmaJzqvTPhHz14ynB4OFIrVvY1?=
 =?us-ascii?q?54Co0H7FnCaNMvOKuvF2OecyUgiKAOXRXvFni44FJCts2QDfe6akraEg?=
 =?us-ascii?q?EGR4JjcK6KLsRuTa5eEeUacg=3D=3D?=
Received: from zcs-store4.inria.fr ([128.93.142.31])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2022 09:22:48 +0200
Date:   Thu, 12 May 2022 09:22:48 +0200 (CEST)
From:   Shenghao Yuan <shenghao.yuan@inria.fr>
To:     bpf@vger.kernel.org
Message-ID: <271219135.7057261.1652340168554.JavaMail.zimbra@inria.fr>
Subject: Questions: JIT ARM32
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.254.242.109]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - GC84 (Linux)/8.8.15_GA_4257)
Thread-Index: zB8AvIJjLNzG1kkevFShCizs5T9a4w==
Thread-Topic: Questions: JIT ARM32
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello all, 

I am a beginner to learn the eBPF jit compiler (and also a Linux beginner), I have two questions when I read the eBPF-JIT ARM32 source code (I am using bootlin [1] and this eBPF document [2]), could you please give me some suggestions? 

1. mov instructions: I don't understand why it has a condition `imm == 1` [2] 
```c 
case BPF_ALU | BPF_MOV | BPF_K: 
case BPF_ALU | BPF_MOV | BPF_X: 
case BPF_ALU64 | BPF_MOV | BPF_K: 
case BPF_ALU64 | BPF_MOV | BPF_X: 
switch (BPF_SRC(code)) { 
case BPF_X: 
if (imm == 1) { // I don't understand here 
/* Special mov32 for zext */ 
emit_a32_mov_i(dst_hi, 0, ctx); 
break; 
} 
emit_a32_mov_r64(is64, dst, src, ctx); 
``` 
2. alu32 instructions, why jit arm32 doesn't call/trigger alu32 operations [4] 
```c 
if (is64) { 
const s8 *rs; 

rs = arm_bpf_get_reg64(src, tmp2, ctx); 

/* ALU operation */ 
emit_alu_r(rd[1], rs[1], true, false, op, ctx); 
emit_alu_r(rd[0], rs[0], true, true, op, ctx); 
} else { 
s8 rs; 

rs = arm_bpf_get_reg32(src_lo, tmp2[1], ctx); 

/* ALU operation */ 
emit_alu_r(rd[1], rs, true, false, op, ctx); //here it also set is64 as true? 
if (!ctx->prog->aux->verifier_zext) 
emit_a32_mov_i(rd[0], 0, ctx); 
} 
``` 

[1] https://elixir.bootlin.com/linux/v5.18-rc6/source
[2] https://github.com/iovisor/bpf-docs/blob/master/eBPF.md
[3] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/arm/net/bpf_jit_32.c#L1399 
[4] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/arm/net/bpf_jit_32.c#L754

Best wishes, 
----------------------- ----------------------- ------------ 
Shenghao YUAN 

TEA (Time, Events and Architectures) team 

Inria Rennes 

Tel: (+33) 0749504117
