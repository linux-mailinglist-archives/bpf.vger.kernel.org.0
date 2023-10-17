Return-Path: <bpf+bounces-12483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189827CCE15
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9592DB211DD
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFDF2D02B;
	Tue, 17 Oct 2023 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="o+CuH5m+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="bIK6eGer";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VtU6Hrdg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F6D2D798
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 20:30:33 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACDF92
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:30:32 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3BB74C180DE6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697574632; bh=pZcN2biFPQMtBxLn5GbrH+wvIOBG+ctFbYAk9dWfuLE=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o+CuH5m+sJ11u/qwQqdrQLTJavoU5Ebm9jcXCBErOdTZXImVz1kSfcp6SGNDc8f8c
	 qzC+l2RiQnhapl2ALV/M+GQbiVDA693hbmmconPwebpmTjPbrc2zY/ehR3ubZq93QH
	 g5dE0+DbKtJSo6dTQq0E151ByouGgSEVGzqyJDXE=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 03AF5C15154E;
 Tue, 17 Oct 2023 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1697574632; bh=pZcN2biFPQMtBxLn5GbrH+wvIOBG+ctFbYAk9dWfuLE=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=bIK6eGertFjZRMBdC9O/i2fCPpV++X0wHSZK9bJ2/c9gSA5/EeWw/n1Dl7WhY0axA
 IhrD0G+N7mbRgnWEuPueiP7x4ABh21IPHfKxJuw91g9DjrT49hLsvSUCJ+VGjqihN5
 l7HWmU0q1JveXs3SWjN+M9IH24RTHvxZb9TRm+qM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F3802C15154E
 for <bpf@ietfa.amsl.com>; Tue, 17 Oct 2023 13:30:30 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.856
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gp1A7KpagFQP for <bpf@ietfa.amsl.com>;
 Tue, 17 Oct 2023 13:30:26 -0700 (PDT)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 613DEC14CF1C
 for <bpf@ietf.org>; Tue, 17 Oct 2023 13:30:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c888b3a25aso39483985ad.0
 for <bpf@ietf.org>; Tue, 17 Oct 2023 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1697574626; x=1698179426; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ehV8iSxnyOyDyf4C9sEgcF0r6K+laBQfqTpRwsFcRM=;
 b=VtU6HrdgM9HlRP185xyYg1r+/yh0wK3Lonn7c9ctSRjsM+NteJy/0SynaIQhy9FDoV
 ShwlVu9lFeRn/Lq3tgYYZJHMC/KxaMAxCAZ02w+UnejAfP6LO/Z6LIbaxZwWE2FIhHCZ
 9bIW5KomApHaqS9LRE/k6Ye/Cjkt27kwYQYHSZs/px/eD6drnnF7lYGYBE9i0jEIa5fh
 Mcd7pM2mw/S1eVgdguKkGsc6m6M8MteuFYMrcD+RaJ/+MJRkoUJAZfOJPFltDTVYTXC+
 DS15xqmLle6X+vRuLryte7tCRK85e7+5LVimbcgXUGZiGrJJZkam/xwh5vKBwpUXBwvs
 1f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574626; x=1698179426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ehV8iSxnyOyDyf4C9sEgcF0r6K+laBQfqTpRwsFcRM=;
 b=DGpccoRRDe8qMtZD+cDbQEAhB7EfOOGhS6WPVyC01xTFbZNCyi1iuVtjTjKmTKHx84
 KShr8UbwOR47+7khSb+o3K1BROtZ188OKXVx7nUy6Jgrh7BAKFJ7Cy3QhfAPTqYUxrik
 38R6ynNGvWNMhGi8jQtpZi1JTcGlL7uYU2+FpcZtxZnthEYrGROlNB+A6tEKTtK8TxH1
 vrujm6ipPBbTpEsvDPsPaRHFvbAH7mX1TFR7lsXcxpS38LRc0aDzhfiapYDxDV+iVkam
 3i4QeDYMlvNoI6oK5ziQIBYLi5T8+yUHMWCBvF9IKs9Th4gWa8mrxhbdX227Jhgrngiu
 ffHQ==
X-Gm-Message-State: AOJu0YxA8Id9PUKC5KDQhS4d/zfbHoQzGrkt3gD5OsAnpo1fg/3z0+rf
 jFYw0Ll1gMVBacLMXQkRbBc=
X-Google-Smtp-Source: AGHT+IGf/fg4e1bxpRgEyW5b8Xnh8EkRAbGDpjqfn79l6U8cm4qjbhI7m49xH29W9Hlil3B4Jm+YvQ==
X-Received: by 2002:a17:90a:53a1:b0:27d:19ef:fa2c with SMTP id
 y30-20020a17090a53a100b0027d19effa2cmr3089584pjh.14.1697574625613; 
 Tue, 17 Oct 2023 13:30:25 -0700 (PDT)
Received: from mariner-vm.. (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 pj1-20020a17090b4f4100b0027d0c3507fcsm6719993pjb.9.2023.10.17.13.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:30:25 -0700 (PDT)
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Date: Tue, 17 Oct 2023 20:30:20 +0000
Message-Id: <20231017203020.1500-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/RhmSY-BWJJR864gNbN705DUXRbs>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Define signed modulo as using truncated division
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

There's different mathematical definitions (truncated, floored,
rounded, etc.) and different languages have chosen different
definitions [0][1].  E.g., languages/libraries that follow Knuth
use a different mathematical definition than C uses.  This
patch specifies which definition BPF uses, as verified by
Eduard [2] and others.

[0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
[1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
[2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce5290.camel@gmail.com/

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index c5d53a6e8c7..245b6defc29 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
 is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
 interpreted as a 64-bit signed value.
 
+Note that there are varying definitions of the signed modulo operation
+when the dividend or divisor are negative, where implementations often
+vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
+etc. This specification requires that signed modulo use truncated division
+(where -13 % 3 == -1) as implemented in C, Go, etc.:
+
+   a % n = a - n * trunc(a / n)
+
 The ``BPF_MOVSX`` instruction does a move operation with sign extension.
 ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
 bit operands, and zeroes the remaining upper 32 bits.
-- 
2.33.4

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

