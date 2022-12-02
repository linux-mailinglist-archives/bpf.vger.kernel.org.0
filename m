Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC264097C
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiLBPjI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiLBPjH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 10:39:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A609BE6B3;
        Fri,  2 Dec 2022 07:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.ch; s=s31663417;
        t=1669995523; bh=ldG0fzm6Qem0Pfa6GXvE+somhuAXUV/Lz5s/EE/u7EU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FwbQ27KZcoVQ67aMcSqdAPD+8ALJiPA+vNIE2krhZB0EuucO6VfV7+wVGMkq0Oq2M
         Y9esfsDr91p3srfVAQ0/3eYQ5q98qsfnbrWJ0HsGPKvnGruvcLFq1ZEqN6nlgv97OM
         2pDTzcDdpD5eLvbKl9Odlt5ccqVW7znk4ZLSyfFR4KNTh9VI85kNZMnBmnQLbCVFWh
         qp+A65OmvVhRktZ9mEXvsF0ug3naIJ8iJ7jxHs3Xl5Jaq96joqyLuvAT9eC6dKQQ5s
         +MbIvrYuU9rK0jNpsGwVgmFLeirudl6IzxesHH6a8dlnvej2RoYrNpE49pu9hOLVSP
         s2hvlEGy/d4SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x1c6.fritz.box ([185.76.96.75]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1ofYxe2J61-00muzS; Fri, 02
 Dec 2022 16:38:43 +0100
From:   Timo Hunziker <timo.hunziker@gmx.ch>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@google.com, linux-kernel@vger.kernel.org,
        Timo Hunziker <timo.hunziker@gmx.ch>
Subject: [PATCH bpf-next] libbpf: parse usdt args without offset on x86 (e.g. 8@(%rsp))
Date:   Fri,  2 Dec 2022 16:38:16 +0100
Message-Id: <20221202153816.1180450-1-timo.hunziker@gmx.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iHEIR/r7nBpuEQBqpUIq+/Y5by8Fmo14yoHvLmB2k7rtJJNeMIx
 glfIQ9h8LYddQqnoX/WTe9YZ6H+lQxxKrpgBoEa/GfneQK2Nw+bgm8ZUIWUwQzY/YKfgDe+
 2xD2GdG8HahVd+pDY/PFDjFQA1MaFFzoNmsfiRVZoCzl1s5Vf3ijw5sc87w4iThmngEDX2p
 3HUwG1a1ol5DZ3nU/z3gA==
UI-OutboundReport: notjunk:1;M01:P0:8shPd3u1qR0=;z5Myn1tE+QAb72nrUcKTqW+liYq
 ucRGQlRe4QaHCQWXCLKUWMGqqBVfYn+Da96FO+hQjozzgJvDEPx3LVDCXjBfygnNxp4xMsr8x
 YXiX89jApej6HZl+DRvlA5DCU8S1YjiTavDyR+qb4luWGp5MQ8lnXMSUZkIe7YRRdSKqoHn5+
 AWizaJGDkgQWvuvAXwdCMAxDJWkT9tWwieLl31D6S61HjmgT62p511edlT7z9YGSqDB5Zvpju
 S2xoUdTK8y4Z78u0Na1R7Jf2/zC87rQJRqwjT8XM1AVsH/pLN9ayUpgZj8dX/o/aMLiSEbzsV
 LabclslBOgHGzOwfLD9vpjuqyBPA99TriD/U5/ZoEImO60Qmpn+YUA2G0MmWogaumkGvY1uKq
 cjBGNbO4wlgUq27ThNcEw5JJXx4dKHTsKoFRG7AD50TIZUm5gZt3DJBwanOAvwK0tENYTj328
 cNAa5akFBeu9jaCpvRAcbmGqcnIDuN1kxpH1d3futiRZvHkoJrof9J3Y2puvQKJRj6kXS4zLh
 V0+WehPmuy+vx2YZ+2PITZ0GQ9JNQAuNlckRwAfzTGntQV3QdFV3A+XnXeRYYqPfaY0jQIDQA
 MjZEuv32wFgUbWqqYdIsU+E8W1Q1hBQYMtM0Hf7JW+FX13+eXRV7h0wgb7opdpv+kxJr6eKG8
 b4Pfhnjpm3j2erLK6aB7DlckqI6GSEdsgtCVAZ2Jgu28xaDGYZwl4ybiSn4gicuesP1mReBXE
 VWQLElGkiNzXDKzOLWMroPEE7ZzdleQ5NZhxwvBTP8w+tW5o4VGSQMCYs3VhwKeba1Nujn3gg
 X/QgFZVv4veyIwGSqDiqsa1Gr4JvfW8e4+x9IlBTugeCH4ldFpQf1AbuVc90hKoF4g7CP46ut
 tbkKcYlrUuskNHM5F4HmtdJnLt7EfWismnAj+9OKvoSSobFfl2j73qkfQcEjplEhxfrz54mA1
 WbPgnJX98ljEa233twKCCxforig=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Parse USDT arguments like "8@(%rsp)" on x86. These are emmited by
systemtap. The syntax is a mixture between the "memory dereference
case" and the "register read case" as the offset is zero but the
register is wrapped in parentheses. We treat them the same as the
the "register read case".

I've tested that this fixes the "unrecognized arg #N spec: 8@(%rsp).."
error I've run into when attaching to a probe with such an argument.
Attaching and reading the arguments works.

Something similar might be needed for the other supported
architectures.

ref: https://github.com/libbpf/libbpf/issues/559

Signed-off-by: Timo Hunziker <timo.hunziker@gmx.ch>
=2D--
 tools/lib/bpf/usdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index b8daae265f99..5e7ec7ad8ad7 100644
=2D-- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1233,6 +1233,14 @@ static int parse_usdt_arg(const char *arg_str, int =
arg_num, struct usdt_arg_spec
 		if (reg_off < 0)
 			return reg_off;
 		arg->reg_off =3D reg_off;
+	} else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", &arg_sz, reg_name, =
&len) =3D=3D 2) {
+		/* Register read case with parentheses, e.g., 8@(%rsp) */
+		arg->arg_type =3D USDT_ARG_REG;
+		arg->val_off =3D 0;
+		reg_off =3D calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off =3D reg_off;
 	} else if (sscanf(arg_str, " %d @ %%%15s %n", &arg_sz, reg_name, &len) =
=3D=3D 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type =3D USDT_ARG_REG;
=2D-
2.36.2

