Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98886416BE
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 13:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLCMnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 07:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiLCMnA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 07:43:00 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Dec 2022 04:42:57 PST
Received: from mail.eclipso.de (mail.eclipso.de [217.69.254.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21446A1A0
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 04:42:54 -0800 (PST)
X-ESMTP-Authenticated-User: 000A371C
From:   timo.hunziker@eclipso.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eclipso.de; s=mail;
        t=1670071068; bh=lP/iR/9kH0H2mP4iM34RnJp4Hb5MiVEHAyM5XTGyc0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZrIH5Ne3uMkZvT8DMT6l8njPYolVWZqh5oPwwwvnP2dOJ97aVy5qYqlB1s4vHDV+
         JBhqTwrSg6PsH7fh5qqeSf2+Xp8+RXQadRnvmK9a4W+Fpg1SmLdmegpn2o29UYqkFU
         ilkWhXeuhjhvJLes+pTRBbTLZBSZVtSx/Y6DRSZksDegbE/ZhSK67tsaApeRQ+wFjE
         h62+94c+RgnOvx5x4vb8/cRwOCkhZtRgM/SMy1qRIFuaaIWAHO0DODyDBvoQCY4A8P
         qzTf9TQdmWUP02XJgSStEtsIdZqtsIwttjpnSadPmrnOJhN26d7EqWHdmt6IAhWqYf
         26wZOdAvX0PQQ==
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        timo.hunziker@gmx.ch, yhs@fb.com
Subject: [PATCH bpf-next v2] libbpf: parse usdt args without offset on x86 (e.g. 8@(%rsp))
Date:   Sat,  3 Dec 2022 12:37:46 +0000
Message-Id: <20221203123746.2160-1-timo.hunziker@eclipso.ch>
In-Reply-To: <CAEf4BzbzgDfkvEtcQbCE1wZ4YHOTTWwr3rfX3D63RfD08qGj-Q@mail.gmail.com>
References: <CAEf4BzbzgDfkvEtcQbCE1wZ4YHOTTWwr3rfX3D63RfD08qGj-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Timo Hunziker <timo.hunziker@gmx.ch>

Parse USDT arguments like "8@(%rsp)" on x86. These are emmited by
SystemTap. The argument syntax is similar to the existing "memory
dereference case" but the offset left out as it's zero (i.e. read
the value from the address in the register). We treat it the same
as the the "memory dereference case", but set the offset to 0.

I've tested that this fixes the "unrecognized arg #N spec: 8@(%rsp).."
error I've run into when attaching to a probe with such an argument.
Attaching and reading the correct argument values works.

Something similar might be needed for the other supported
architectures.

ref: https://github.com/libbpf/libbpf/issues/559

Signed-off-by: Timo Hunziker <timo.hunziker@gmx.ch>
---

Ugh, you're right. Thanks for catching this. I've changed it to
USDT_ARG_REG_DEREF and double checked that the values in the
arguments are the expected values for my test case.

 tools/lib/bpf/usdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index b8daae265f99..75b411fc2c77 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1233,6 +1233,14 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off = reg_off;
+	} else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", &arg_sz, reg_name, &len) == 2) {
+		/* Memory dereference case without offset, e.g., 8@(%rsp) */
+		arg->arg_type = USDT_ARG_REG_DEREF;
+		arg->val_off = 0;
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
 	} else if (sscanf(arg_str, " %d @ %%%15s %n", &arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type = USDT_ARG_REG;
--
2.36.2

_________________________________________________________________
________________________________________________________
Your E-Mail. Your Cloud. Your Office. eclipso Mail & Cloud. https://www.eclipso.de


