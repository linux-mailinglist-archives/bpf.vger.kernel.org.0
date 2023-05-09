Return-Path: <bpf+bounces-261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97736FCD45
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 20:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007651C20BE6
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993691951B;
	Tue,  9 May 2023 18:09:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007217FE0
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 18:09:13 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317D1710
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 11:09:11 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4AFB1C1524AC
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1683655751; bh=CnBs7FRLDwgWl0Axsj0GNNJBgnoUExFV65U7ItexGsg=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O9Q+3ldoMsOIc71NU5KQmVzNjwqXcGOoCCRxzdZw2CBuhJn77+/zgQatINajtCyvW
	 qZ4oga0eqx12U0mKHww6xifOKKKuMMV2Pu7nxQCxefeig2e289lngg0DpBVlTSoFr6
	 ckqvskIfKOmqsayilFIYrAtXtQVRtEK7XuYWv5pQ=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 10DCCC151B1B;
 Tue,  9 May 2023 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1683655751; bh=CnBs7FRLDwgWl0Axsj0GNNJBgnoUExFV65U7ItexGsg=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=ZUh58MRsvf2CHv1uUM9KSCWj5v2hrmzFnFUFQi0Yp/cVZM/kFDHDRY3Zrvq7BRp0T
 H5HKVWvfQqIJpxDFDuyqXM3YFQi1iGkdUZkja/HJvKWMP9ZKuz4xfFSs/9cJnycU8s
 jZtETawBRpvaq/whTSAScsHheMbwsRtQXq51tP2k=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CCD0DC151B1B
 for <bpf@ietfa.amsl.com>; Tue,  9 May 2023 11:09:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.845
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l_0uxyZtIC2X for <bpf@ietfa.amsl.com>;
 Tue,  9 May 2023 11:09:06 -0700 (PDT)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0BD67C15171B
 for <bpf@ietf.org>; Tue,  9 May 2023 11:09:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1aaec6f189cso43019165ad.3
 for <bpf@ietf.org>; Tue, 09 May 2023 11:09:06 -0700 (PDT)
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
 b=AdJCvKd6HoWFqJBWYSWFIX7KGgv3tdZxG9V6PY17AlatIYN2lygk1DHTjl9mFcUzWx
 dJXAg3Rfu6TIZrenni0F4vcEEawXdGGl+BEP7DVbg9n9BhlwNBrbyRvhi973Nur81lYT
 k271ekLKbJ/rG7UCV/ZleWxhWfUFez2Rj16Oxx2jfJQg7tT/H8yCwoQQguqPGzaWZmWm
 IgSjNN3dsCe0aDgWBYmnYZVdJR7+CjpHE8J/HPugzFKcEpEKZYKaw4UeZbsqepU/x516
 BKlXKnZGCp5P/P/04dkCEMgnMCS0tO5yBQ+IXG/AdUjcIqxGsoLwPj2E18mJIy2vrPxr
 Bffg==
X-Gm-Message-State: AC+VfDwlzk6lybEsRQQHIw+amvLVVXC2gVwlRVpZVWyH0f3pJVnWDc5s
 5X8o0vdGqeKUyIjnoLTMpm2s7f1ziB/1LA==
X-Google-Smtp-Source: ACHHUZ5BQWB+bKwPh10c/UWh6+WhGHTq0Qg9630jyJ5f+lADKMULNQGvNc6Y0iUJM0aKrQPx5KYJZQ==
X-Received: by 2002:a17:903:2347:b0:1a9:91d7:ba2 with SMTP id
 c7-20020a170903234700b001a991d70ba2mr18564694plh.48.1683655745149; 
 Tue, 09 May 2023 11:09:05 -0700 (PDT)
Received: from mariner-vm.. ([72.28.92.214]) by smtp.gmail.com with ESMTPSA id
 t1-20020a170902a5c100b001a9581ed7casm1908494plq.141.2023.05.09.11.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 11:09:04 -0700 (PDT)
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Date: Tue,  9 May 2023 18:08:45 +0000
Message-Id: <20230509180845.1236-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-B1KSCQK-GXGWSuWdqEiLz-C6-Y>
Subject: [Bpf] [PATCH bpf-next] Shift operations are defined to use a mask
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
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

