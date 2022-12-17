Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEC64F80E
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 08:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiLQHLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 02:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQHLI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 02:11:08 -0500
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F12DAB9
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 23:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1671261062;
        bh=qNPme23sRfuoZh5wT71WmCg74RkrBQR8L1HFucUJqQg=;
        h=From:To:Cc:Subject:Date;
        b=Q8QDCf2M/stLXgnJru0UsoMuAq+MRfVgHmwKs5CGvwdfWMhSNbktyjU4dGgmauJML
         8VBr3aFfgeCIj9PYEgrXLtlXYX0cCHcm0r3jHY2bVMsgdMoznCkaMYqYoqjBwJbVcI
         muMcw0UveizChdxA9/VRyHoMN0vKso475khEFF54=
Received: from rtoax.. ([111.199.188.149])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id DCB7CC9; Sat, 17 Dec 2022 15:03:28 +0800
X-QQ-mid: xmsmtpt1671260608t8uzpjr6z
Message-ID: <tencent_3D7B0D368482B2602EC7559A5E1546171009@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yne7jDl1XJl/TzZjZik7sj8e1EHqrLVkaLp4DVV33nWJ6iwpCMpUh
         azceIv7JFW8GnKjG3GeU/09D0/P47r43xawCn9CVCqwOy3SaZ4LJtZCFTyyHPI/LijsQikeOHwWs
         AYnMLcNl+UkrzaaDThXSh3bxQVXbwnlNrSfQsGLfKIIl4nKjI/J2Ja12/RIqn10jnjpjOpPmTiMP
         WG/wLgLxB3el4y87Rx0yPRImgDYm3hIJuoj9UpD5ZIyh8896T1Go479yovAElJsKDE4reGigHQSV
         M+VhAorZoYuh3am1j+wVHYLkLnmAKAo8y5kl0MgQRz26lr7eZfQ1RuiVK+Gr4Qt8/qpe6FCIdyaU
         K7S/SRSesAEvCk9lCu7gFSBJpkjgiQSS43trnyEHDh6aK7tpHF4MtMOep+jHwXati8mlspBbl9rw
         UQLBePJvflbZ7Wi/hafU+4gFD9fh1u2WetzoQBdXiGSVgKBharQy4OEXkDtnQHzS+AU4H6AFfb9A
         GnBkCt6XCT0i61pdjXAyQrqu0pEOHPDw5wblLHRZ5NhmyjN3F9id8FznvVdG2/Kbr0NmbkuBQvLL
         EgLlci8v3ONPa7Fvx/PdPAKg4cz6/EZd8T0dPFfZZTkjCy7QQCHGPi78VOo2yg4Py7qLMNuebRZ/
         10r55qnz+SA8dAtno09cK4meNvy3sSfzSm5G0as+XtZRTR4Ybv0hVigOO7KvfB0fRRZaYBUdHv+S
         vZzn29h8LNp/JgnXIu6JHR9yWcTQe7znhxVnnI2q3SVo5+bCofKbvYh6Or6eT3s7qqftbwbVb27i
         hyR1QpNW9EJUZEvoI+cWeGlGtSoz+/x4FjNqnzj0chR3rY7JoV7Q7d13q/08Bpkn0E0XgmB38Xdu
         sBVpyLBAagW/rQ3vd9Pmj/UfwkPj7x0whVdhuQstzx3bDoxbtEd2mGEfC0tfBFEVnnzeifKsSEvQ
         Cdq0QHk1bU5kToBdBcakwEJhPEhQXNGTKUIUA+nStgCA8kPtJ00w==
From:   Rong Tao <rtoax@foxmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, Rong Tao <rongtao@cestc.cn>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:BPF [MISC])
Subject: [PATCH] kbuild: Fix compilation error
Date:   Sat, 17 Dec 2022 15:03:18 +0800
X-OQ-MSGID: <20221217070319.18331-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

In the absence of a CONFIG_FUNCTION_ALIGNMENT defined, -falign-functions=
will be given a null value, which results in a compilation error, as
follows:

    $ make -C samples/bpf/
    ...
    CC      /home/sdb/Git/linux/samples/bpf/syscall_nrs.s
    gcc: error: missing argument to ‘-falign-functions=’
    make[2]: *** [scripts/Makefile.build:118: /home/sdb/Git/linux/samples
        /bpf/syscall_nrs.s] Error 1
    make[1]: *** [Makefile:1996: /home/sdb/Git/linux/samples/bpf] Error 2
    make[1]: Leaving directory '/home/sdb/Git/linux'
    make: *** [Makefile:269: all] Error 2

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 6aa709df6bde..57cce4c8f8a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1006,9 +1006,11 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
+ifdef CONFIG_FUNCTION_ALIGNMENT
 ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
 KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
+endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc
-- 
2.38.1

