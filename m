Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD90C5757D0
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 00:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiGNWsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 18:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNWsN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 18:48:13 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118A71BD9
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 15:48:13 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id EC679EF7C0F6; Thu, 14 Jul 2022 15:47:57 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, quentin@isovalent.com, andrii@kernel.org,
        ast@kernel.org, Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1] bpf: fix bpf_skb_pull_data documentation
Date:   Thu, 14 Jul 2022 15:47:21 -0700
Message-Id: <20220714224721.2615592-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix documentation for bpf_skb_pull_data() helper for
when flags =3D=3D 0.

Fixes: fa15601ab31e ("bpf: add documentation for eBPF helpers (33-41)")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 3 ++-
 tools/include/uapi/linux/bpf.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 379e68fb866f..a80c1f6bbe25 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2361,7 +2361,8 @@ union bpf_attr {
  * 		Pull in non-linear data in case the *skb* is non-linear and not
  * 		all of *len* are part of the linear section. Make *len* bytes
  * 		from *skb* readable and writable. If a zero value is passed for
- * 		*len*, then the whole length of the *skb* is pulled.
+ *		*len*, then all bytes in the head of the skb will be made readable
+ *		and writable.
  *
  * 		This helper is only needed for reading and writing with direct
  * 		packet access.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 379e68fb866f..a80c1f6bbe25 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2361,7 +2361,8 @@ union bpf_attr {
  * 		Pull in non-linear data in case the *skb* is non-linear and not
  * 		all of *len* are part of the linear section. Make *len* bytes
  * 		from *skb* readable and writable. If a zero value is passed for
- * 		*len*, then the whole length of the *skb* is pulled.
+ *		*len*, then all bytes in the head of the skb will be made readable
+ *		and writable.
  *
  * 		This helper is only needed for reading and writing with direct
  * 		packet access.
--=20
2.30.2

