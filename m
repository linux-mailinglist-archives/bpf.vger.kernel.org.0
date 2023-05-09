Return-Path: <bpf+bounces-260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73806FCD44
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 20:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0555C1C20C4B
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E01950D;
	Tue,  9 May 2023 18:09:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405EF17FE0
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 18:09:07 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86F10C2
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 11:09:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaff9c93a5so43037785ad.2
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683655745; x=1686247745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSgPsVL1uYatXDU3irtGbEOCXntD3VQ0CCJ7BZVw2+4=;
        b=E76ZgsHV+G0oPZWTFpRjWATgGj/UF3rL/TYhIVgMc+0wCX8po7ZLjRbN8WM03H5xai
         6uaDTfy8MGj2d20T+3G+pYubSNUyl8jLhXkxs6cxf0JgKJJkgPqKPturinslLHgozztx
         eq8gwFs/+/TsGS7hj3Nxtb/f0B3MW3GxxMt6Sdscos90TUAaD6xQS3S4Sk4rGmdh8RNr
         A7uojU3aCDLbeBIuvBw1e6Dk/JfuxIspdAc4JqwenUAgiHMEVvVa62GzN3LkpPfzw1HS
         0Pkys5hnN/3KDT/+LgTAUk4//XxXQzHbG67RbM9kEV4OqSpS+VYMOcuiuOjkOgE7Lzh8
         r1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655745; x=1686247745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSgPsVL1uYatXDU3irtGbEOCXntD3VQ0CCJ7BZVw2+4=;
        b=Tye7seUG+WYg+uqufvllR3/V0V24aHL4VtQRxjB/428A3TbgTDtlY9+yYOO8ppgOfV
         6UWtwJpS9SwHzMo/Rj8Wf4Ec8fs6VX5xJtRw4Dzoz3OEtEYJF0SpNS3jOyD3B5naKUG9
         oPflJK7qJE54049xmqQU2cSL3W18QGjCoHAnDZKvTKgnd7CvfUam2jcefPwGT7RKWKBu
         9CsihlhQjiULD27fGzHCE7huyl/NBdCebzkouqF+zehU0mXMJJ9yxyK7B2ep3isXV4wt
         q+dehPextzHSQxqCnv8+HIMNFeOKXXG9h8VITq04B7vS8za4vAy05uufhTUQXiOpRV8e
         R9Jw==
X-Gm-Message-State: AC+VfDyJqsg+w6QQl1ovR7cNc4HNTk15ef+zr7omf7XUOm+93w3iJzU6
	i5t86hqFVBBIzyjkfz5Vm0QbfEHXbBCW8Q==
X-Google-Smtp-Source: ACHHUZ5BQWB+bKwPh10c/UWh6+WhGHTq0Qg9630jyJ5f+lADKMULNQGvNc6Y0iUJM0aKrQPx5KYJZQ==
X-Received: by 2002:a17:903:2347:b0:1a9:91d7:ba2 with SMTP id c7-20020a170903234700b001a991d70ba2mr18564694plh.48.1683655745149;
        Tue, 09 May 2023 11:09:05 -0700 (PDT)
Received: from mariner-vm.. ([72.28.92.214])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902a5c100b001a9581ed7casm1908494plq.141.2023.05.09.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:09:04 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] Shift operations are defined to use a mask
Date: Tue,  9 May 2023 18:08:45 +0000
Message-Id: <20230509180845.1236-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Thaler <dthaler@microsoft.com>

Update the documentation regarding shift operations to explain the
use of a mask, since otherwise shifting by a value out of range
(like negative) is undefined.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 492980ece1a..6644842cd3e 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -163,13 +163,13 @@ BPF_MUL   0x20   dst \*= src
 BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
 BPF_OR    0x40   dst \|= src
 BPF_AND   0x50   dst &= src
-BPF_LSH   0x60   dst <<= src
-BPF_RSH   0x70   dst >>= src
+BPF_LSH   0x60   dst <<= (src & mask)
+BPF_RSH   0x70   dst >>= (src & mask)
 BPF_NEG   0x80   dst = ~src
 BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
 BPF_XOR   0xa0   dst ^= src
 BPF_MOV   0xb0   dst = src
-BPF_ARSH  0xc0   sign extending shift right
+BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
 BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 ========  =====  ==========================================================
 
@@ -204,6 +204,9 @@ for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
 interpreted as an unsigned 64-bit value. There are no instructions for
 signed division or modulo.
 
+Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
+for 32-bit operations.
+
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.33.4


