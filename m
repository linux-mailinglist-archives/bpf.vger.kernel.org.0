Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47C398EA4
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 17:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFBPcx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhFBPcx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 11:32:53 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Jun 2021 08:31:09 PDT
Received: from out2.mail.ruhr-uni-bochum.de (out2.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2ae5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1822C061574
        for <bpf@vger.kernel.org>; Wed,  2 Jun 2021 08:31:08 -0700 (PDT)
Received: from mx2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by out2.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 4FwCTh53HVz8SN0
        for <bpf@vger.kernel.org>; Wed,  2 Jun 2021 17:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rub.de; s=mail-2017;
        t=1622647400; bh=6JJsKbiWuGVAhWr4Gp0kDGLjo8wj5mkMuBxzsYn4HkQ=;
        h=To:Cc:From:Subject:Date:From;
        b=guox5IHOUSWH0yums/n3fQhUbAFSmm2gxFO7NEiE52ykK3bpLt9EySOm+dL+3bch7
         FRj/26fAV8SHFQvADPIR4hMLJtYYVJeRBJ8253cHWzlYA+3chAPIJ+4d0X5ey896yq
         DzF7T0Be61bFjhP45GYOBvPS9A03ja/tItGs1iy8=
Received: from out2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by mx2.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 4FwCTh4VTYz8SJ8;
        Wed,  2 Jun 2021 17:23:20 +0200 (CEST)
X-Envelope-Sender: <Benedict.Schlueter@rub.de>
X-RUB-Notes: Internal origin=134.147.42.236
Received: from mail2.mail.ruhr-uni-bochum.de (mail2.mail.ruhr-uni-bochum.de [134.147.42.236])
        by out2.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTP id 4FwCTh2XZ8z8ST0;
        Wed,  2 Jun 2021 17:23:20 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.1 at mx2.mail.ruhr-uni-bochum.de
Received: from [IPv6:2003:de:73f:90c9:d250:99ff:fe8d:a1e1] (p200300de073f90c9d25099fffe8da1e1.dip0.t-ipconnect.de [IPv6:2003:de:73f:90c9:d250:99ff:fe8d:a1e1])
        by mail2.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 4FwCTg6zMHzDh1V;
        Wed,  2 Jun 2021 17:23:19 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.0 at mail2.mail.ruhr-uni-bochum.de
To:     bpf@vger.kernel.org
Cc:     benedict.schlueter@ruhr-uni-bochum.de
From:   Benedict Schlueter <Benedict.Schlueter@rub.de>
Subject: fix u32 printf specifier
Message-ID: <6662597c-13a2-5c6e-df6c-31d18ed34bfd@rub.de>
Date:   Wed, 2 Jun 2021 17:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I assume its clear what this patch does.


 From 9618e4475b812651c3fe481af885757675fc4ae2 Mon Sep 17 00:00:00 2001
From: Benedict Schlueter <benedict.schlueter@rub.de>
Date: Wed, 2 Jun 2021 17:16:13 +0200
Subject: use correct format string specifier for unsigned 32 Bit
  bounds print statements

Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
---
  kernel/bpf/verifier.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1de4b8c6ee42..e107996c7220 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -690,11 +690,11 @@ static void print_verifier_state(struct 
bpf_verifier_env *env,
                          (int)(reg->s32_max_value));
                  if (reg->u32_min_value != reg->umin_value &&
                      reg->u32_min_value != U32_MIN)
-                    verbose(env, ",u32_min_value=%d",
+                    verbose(env, ",u32_min_value=%u",
                          (int)(reg->u32_min_value));
                  if (reg->u32_max_value != reg->umax_value &&
                      reg->u32_max_value != U32_MAX)
-                    verbose(env, ",u32_max_value=%d",
+                    verbose(env, ",u32_max_value=%u",
                          (int)(reg->u32_max_value));
              }
              verbose(env, ")");
-- 
2.31.1


