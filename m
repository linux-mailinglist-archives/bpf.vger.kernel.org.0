Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB057C993
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 13:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGULIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiGULIo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 07:08:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73583216
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 04:08:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c22so836631wmr.2
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 04:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPyCtgRVoTmDWTFs8MG+ONwpKPH6awHCi/PQRJcKghc=;
        b=I/3+0MJaNbhmdRRKbged2pha3lCMwVT7UWPaN4vm1L978xZE/XS+fr3pR/HIWns0wX
         m5bS8zEIVKQxMleS8bg/hVrez7ZJWbnGUXCtA8/XrSlQmFfmsNLddFeS2+xQwQCMqe4a
         k3SnpoW3fauN+1mXSHi/9cOPWOqhRIRRfP9bJBZksNdjJ91H9pG8AeaLxG+Ynv5cxUEF
         WbbuZhSfnleoEqjvx3r9x9fzHXWz1jOuZJV2M2HslmykiWCbB+c4lw+JK5VrRytwUKCw
         mu8Bjt5c9hBGrnZLSW9yLbaXNyGcilA7IkKHsYBhatimmtcDPkZlnvrJnQMT3VoDPwgE
         bPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPyCtgRVoTmDWTFs8MG+ONwpKPH6awHCi/PQRJcKghc=;
        b=L95H3HCyjHhkB+izI9jmg+tQQkC98VqBLELVmOvA4ZzKtDYacWOzQAzFplcaDiuUpT
         VdlAU8hmNSsjcYKa5JPQAgCedKUzCYd8eQVFdgp2RPpO711Yxg8tBzFzISFrkvKJh3P3
         /SOSi3zMRrNXTGTzGa3OxrgNTljPvi6fikynEBfDPasJZxvR6/YHx2wj+YInth4WwWo6
         yuSJuXW7m8F1ly6jdaurQnUQoEebRbmLT01ar2HZd98nDsYzIkQwHdw/2IgJ5gmZzr4H
         7Vev4m/K+PpA1iqeNkUxogvtnENXn8yQzKSb2V/kIvoUzcb8OFbp0NF/WWEQA9e0Whad
         8uiA==
X-Gm-Message-State: AJIora8RjnmL8frVmG1BPX+7/JATue+HUKpV+EXvmgYHjfApHzTs2znH
        G35OCFpsuCzrn2AgPJXf/W1Bwi0rfiE=
X-Google-Smtp-Source: AGRyM1sYMwOrYK0W0cQbyHe3rrbyH1QvhcZsvt/ScJ2BvY7BnMCx7Yg4TLDy+Cw6pAhi4fwGnep4tg==
X-Received: by 2002:a7b:c310:0:b0:38c:f07a:e10d with SMTP id k16-20020a7bc310000000b0038cf07ae10dmr8062668wmj.110.1658401721201;
        Thu, 21 Jul 2022 04:08:41 -0700 (PDT)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id bg42-20020a05600c3caa00b003a31b79dc0esm16071297wmb.1.2022.07.21.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 04:08:40 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH] bpf_doc.py: Use SPDX-License-Identifier
Date:   Thu, 21 Jul 2022 13:08:22 +0200
Message-Id: <20220721110821.8240-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; h=from:subject; bh=D2bXBH70rABY7dFAtaVoCs3uQytdOaoEirmUK69/psA=; b=owEBbQKS/ZANAwAKAZ6MGvu+/9syAcsmYgBi2TOYjL2ilxnko+h0dRNAQ1S/uVY4c+5e4LsQoVbQ myAAaOOJAjMEAAEKAB0WIQTqOofwpOugMORd8kCejBr7vv/bMgUCYtkzmAAKCRCejBr7vv/bMoPYD/ 400KGjGVghO1IkOX+YgFCWJiRrOA2dDERmrC5YFZqqrOrNBIFjKhmmNk/pdSzAwWOFXECWaOKzwhLt I3qB//0zlM8GxQK/vx/Q6UFT0OjBaH15glZzJrJbNeYb+6rX1EQPVjBgY5sPQ+tZpKNX8lqfXMPyiv R2d6WbKaIC509xP0S2mezyOnUttrJ5OKvuhITlQpjwS8tqyI6qgHquhHbpV8+dMUe0Ji7z98hHo+nk z3vAW83DcxQsu1+WqSuOmKQdrh2xyRNLHSa77cdI2gavOezJaTui4ABCXt1EvEDLEMiDMf2qP49Dog aHM7nBUb8rK1xkJuqBCI7gQ/+yXR+g3vWiWIyqf8TcBLOBRNJeU0LQQRQsM9D9raZL4nC1TY1rCa9V 4Y1uycgUUf69ybn5dYmolGxqXdbyQPIE4VOkA5/DoOT6ZvcW2xvFRpxgABYPoZlom3iGZWW+U/UiT3 Ep7kd0nbImyQPy+CllifCEGM9eXcaddxoLGQad7aVZPREO5p/hEJMG4GCmIpQI4HR40Mdc8R31zRop zOhFcqmP9TCMlpDxXnuOTnwNINkUmfbYuRGFvIgFzmmRLEaL0tfY/T50roz1VFyR3BhlGBVxMs01Af m5MNyIygrg7273PHRlIY4JiA/cZEgTPc4pmgRxS8RHu1Vu7hr7T+Qg6qhQJA==
X-Developer-Key: i=alx.manpages@gmail.com; a=openpgp; fpr=A9348594CE31283A826FBDD8D57633D441E25BB5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The Linux man-pages project now uses SPDX tags,
instead of the full license text.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 scripts/bpf_doc.py | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 096625242475..74df2955737a 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -333,27 +333,7 @@ class PrinterRST(Printer):
 .. Copyright (C) All BPF authors and contributors from 2014 to present.
 .. See git log include/uapi/linux/bpf.h in kernel tree for details.
 .. 
-.. %%%LICENSE_START(VERBATIM)
-.. Permission is granted to make and distribute verbatim copies of this
-.. manual provided the copyright notice and this permission notice are
-.. preserved on all copies.
-.. 
-.. Permission is granted to copy and distribute modified versions of this
-.. manual under the conditions for verbatim copying, provided that the
-.. entire resulting derived work is distributed under the terms of a
-.. permission notice identical to this one.
-.. 
-.. Since the Linux kernel and libraries are constantly changing, this
-.. manual page may be incorrect or out-of-date.  The author(s) assume no
-.. responsibility for errors or omissions, or for damages resulting from
-.. the use of the information contained herein.  The author(s) may not
-.. have taken the same level of care in the production of this manual,
-.. which is licensed free of charge, as they might when working
-.. professionally.
-.. 
-.. Formatted or processed versions of this manual, if unaccompanied by
-.. the source, must acknowledge the copyright and authors of this work.
-.. %%%LICENSE_END
+.. SPDX-License-Identifier:  Linux-man-pages-copyleft
 .. 
 .. Please do not edit this file. It was generated from the documentation
 .. located in file include/uapi/linux/bpf.h of the Linux kernel sources
-- 
2.36.1

