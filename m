Return-Path: <bpf+bounces-7069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97402770D6B
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519C328225F
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97A1FA9;
	Sat,  5 Aug 2023 03:09:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052B1FA5
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 03:09:56 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCA10D2
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 20:09:36 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A3AE4C151995
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691204974; bh=7EkmS6/ub/XhdXH5MQkhcvLvpY1JJxS2ib6VYJDlZq0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fpgMt/24tG4ycwEk5mgKfktDLb6r16b+m6572pNAhVAOGwiOjhfGiC4LGrTjXubKJ
	 mDMnuDO5FHUCQFwzehDGkvHKBXrs4gBteKinPGOtg+0ZlzKT0+bM+6YNR9bRbqNCXf
	 RpOXvzyH068N7Tw4rK75t4934vMyjjg2YakbBv5w=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Aug  4 20:09:34 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 766ACC14CE5E;
	Fri,  4 Aug 2023 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691204974; bh=7EkmS6/ub/XhdXH5MQkhcvLvpY1JJxS2ib6VYJDlZq0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fpgMt/24tG4ycwEk5mgKfktDLb6r16b+m6572pNAhVAOGwiOjhfGiC4LGrTjXubKJ
	 mDMnuDO5FHUCQFwzehDGkvHKBXrs4gBteKinPGOtg+0ZlzKT0+bM+6YNR9bRbqNCXf
	 RpOXvzyH068N7Tw4rK75t4934vMyjjg2YakbBv5w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3ADD6C151067
 for <bpf@ietfa.amsl.com>; Fri,  4 Aug 2023 20:09:33 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2jZExPaOFXj for <bpf@ietfa.amsl.com>;
 Fri,  4 Aug 2023 20:09:31 -0700 (PDT)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 03198C14CE39
 for <bpf@ietf.org>; Fri,  4 Aug 2023 20:09:30 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-63cfa3e564eso16311166d6.0
 for <bpf@ietf.org>; Fri, 04 Aug 2023 20:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691204970; x=1691809770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amt6f6/FgCcgvOgQNxpLD0P8oG8ReutuJ8nyhf1LrBE=;
 b=tXHlw2yJ+8k/V/OAWXj9OHXpcPCetNaBoqcYqfOE+b5I+3DrpWxH99dEzEF3lZ1I5P
 qnksgKijML7LccpwMcByUPu1KhgHlUJHDf2VbTCjOYZRAKG+yfSyNqalv/Vhsm6ABJE6
 PjNBHkhTQ9dCHgynl0aBkafnBq0bnvBkGbiphVGnrzFa243UIGoCTK6vrnuyfwPkYSIs
 4drIkkqyo365+kibMB1X469/CfzlCYMQYuZv1rJ9VhU6a1hbk0QmlREgvGk+P1dYFpMe
 0UTUygxfJiLjgu9LgxsVYSuCqUXM6O2nW0bi6ZPop+N8MlHgOHdTYh2JjOATPMkkCA8T
 nwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691204970; x=1691809770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amt6f6/FgCcgvOgQNxpLD0P8oG8ReutuJ8nyhf1LrBE=;
 b=A/zFRJlckiSTP/cI3CDYatiou9i8nFa3nGSQRhfHwM65PS8IjulBStfWfScoD1pXgU
 uAImcSBor5Tw+jD8pNwtwOGXQCcj8XXX93zLLppP3oSK3PrjTIb5NENGlfkaozOapGe/
 pHnq3lEXBQ2QJCtyCJSoXcYq3MWTQg0Qg/D87aZ54K/RSz516XG4NYnjS7/CMTI5x52c
 Q635vhXgX1OTx8s8BglVgvXoDpicw10EMl36dTo63pv/UGA3eS5EBQT+97y1sgABJb5P
 EaKR7EVdLQOSEstNWoCmhqKx1imwP0TkZ61vgJRB9SnZwnz9M/VCD+IfH8Hv7Wv6ydy0
 J8Xw==
X-Gm-Message-State: AOJu0Yxpxp6wmA5Tad2XboJXQlfxiDceSHi29ECJI1elhLwYYtAX9iyI
 nwJ3iiKw1FKnL4NBD1NB3FUJEg==
X-Google-Smtp-Source: AGHT+IE1pg65MnSF3gWfkSMHnSrm5658vv5iU6p7qtqY4H7dqd90NDxjyNxtzlak+tyFqnZSS8HZGQ==
X-Received: by 2002:ad4:4506:0:b0:62d:fe06:3e17 with SMTP id
 k6-20020ad44506000000b0062dfe063e17mr3611044qvu.22.1691204969880; 
 Fri, 04 Aug 2023 20:09:29 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a0cf594000000b0063cbb29731dsm1124501qvm.66.2023.08.04.20.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 20:09:29 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Fri,  4 Aug 2023 23:09:19 -0400
Message-ID: <20230805030921.52035-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230805030921.52035-1-hawkinsw@obs.cr>
References: <20230805030921.52035-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/wknog1OhjGsWyNSOF19NlOiLynI>
Subject: [Bpf] [PATCH v3 2/2] bpf,
 docs: Fix small typo and define semantics of sign extension
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index fe296f35e5a7..6f3b34ef7b7c 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -73,6 +73,27 @@ Functions
   format and returns the equivalent number with the same bit width but
   opposite endianness.
 
+
+Definitions
+-----------
+
+.. glossary::
+
+  Sign Extend
+    To `sign extend an` ``X`` `-bit number, A, to a` ``Y`` `-bit number, B  ,` means to
+
+    #. Copy all ``X`` bits from `A` to the lower ``X`` bits of `B`.
+    #. Set the value of the remaining ``Y`` - ``X`` bits of `B` to the value of
+       the  most-significant bit of `A`.
+
+.. admonition:: Example
+
+  Sign extend an 8-bit number ``A`` to a 16-bit number ``B`` on a big-endian platform:
+  ::
+
+    A:          10000110
+    B: 11111111 10000110
+
 Registers and calling convention
 ================================
 
@@ -263,17 +284,17 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 Note that most instructions have instruction offset of 0. Only three instructions
 (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
 
-The devision and modulo operations support both unsigned and signed flavors.
+The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
-'imm' is first sign extended from 32 to 64 bits, and then interpreted as
-a 64-bit unsigned value.
+'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit unsigned value.
 
 For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
-is first sign extended from 32 to 64 bits, and then interpreted as a
-64-bit signed value.
+is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit signed value.
 
 The ``BPF_MOVSX`` instruction does a move operation with sign extension.
 ``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
-- 
2.41.0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

