Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B039B469
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFDH6L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 03:58:11 -0400
Received: from out3.mail.ruhr-uni-bochum.de ([134.147.53.155]:61682 "EHLO
        out3.mail.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229996AbhFDH6L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Jun 2021 03:58:11 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 03:58:10 EDT
Received: from mx3.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by out3.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 4FxFLP1nN0z8SPl
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 09:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rub.de; s=mail-2017;
        t=1622793037; bh=t6trAepAD7Ae8M0DpYq4nMPjqFxF9W/MZyI2E8j/PdQ=;
        h=From:Subject:To:Date:From;
        b=O55UaW+Llj0UWLhpHSy4FrbKWQf2qex/7hc7sA4L4X2INWUJgty2s0DtFbYAgK7hL
         Z25Zkw0+iDyKTi/uJ++heGMLZgEe6GAAipu9L3uPDs9BcM2IpttJAo1G47VljpzkB/
         HBdP9b9LLNsJa41u6pPTZjEC2RMFQ9CdPz/HgMgY=
Received: from out3.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by mx3.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 4FxFLP1BBNz8SPh
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 09:50:37 +0200 (CEST)
X-Envelope-Sender: <Benedict.Schlueter@rub.de>
X-RUB-Notes: Internal origin=IPv6:2a05:3e00:c:1001::8693:2aec
Received: from mail2.mail.ruhr-uni-bochum.de (mail2.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2aec])
        by out3.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTP id 4FxFLP02x3z8SPd
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 09:50:36 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.1 at mx3.mail.ruhr-uni-bochum.de
Received: from [IPv6:2003:de:70d:ea35:d250:99ff:fe8d:a1e1] (p200300de070dea35d25099fffe8da1e1.dip0.t-ipconnect.de [IPv6:2003:de:70d:ea35:d250:99ff:fe8d:a1e1])
        by mail2.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 4FxFLN4fkFzDgyg
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 09:50:36 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.0 at mail2.mail.ruhr-uni-bochum.de
From:   Benedict Schlueter <Benedict.Schlueter@rub.de>
Subject: [PATCH bpf-next] use correct format string specifier for unsigned 32
 bounds
To:     bpf@vger.kernel.org
Message-ID: <92abb6ec-84d9-6210-df13-ea563e0d1fa1@rub.de>
Date:   Fri, 4 Jun 2021 09:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

 From fd076dc5f2bd5ec4e9cb49530e77cf2d3e4f42c2 Mon Sep 17 00:00:00 2001
From: Benedict Schlueter <benedict.schlueter@rub.de>
Date: Wed, 2 Jun 2021 21:42:39 +0200
Subject: [PATCH bpf-next]
  use correct format string specifier for unsigned 32 bounds

when printing an unsigned value, it should be a positive number

verifier log before the patch
([...],s32_max_value=-2,u32_min_value=-16,u32_max_value=-2)

verifier log after the patch
([...],s32_max_value=-2,u32_min_value=4294967280,u32_max_value=4294967294)


Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
---
  kernel/bpf/verifier.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1de4b8c6ee42..ea482ebaeb26 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -690,12 +690,12 @@ static void print_verifier_state(struct 
bpf_verifier_env *env,
                          (int)(reg->s32_max_value));
                  if (reg->u32_min_value != reg->umin_value &&
                      reg->u32_min_value != U32_MIN)
-                    verbose(env, ",u32_min_value=%d",
-                        (int)(reg->u32_min_value));
+                    verbose(env, ",u32_min_value=%u",
+                        (unsigned int)(reg->u32_min_value));
                  if (reg->u32_max_value != reg->umax_value &&
                      reg->u32_max_value != U32_MAX)
-                    verbose(env, ",u32_max_value=%d",
-                        (int)(reg->u32_max_value));
+                    verbose(env, ",u32_max_value=%u",
+                        (unsigned int)(reg->u32_max_value));
              }
              verbose(env, ")");
          }
-- 
2.31.1


