Return-Path: <bpf+bounces-15645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018977F47E3
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339201C20AEC
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765356446;
	Wed, 22 Nov 2023 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="3eGNhZDH"
X-Original-To: bpf@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5AA197;
	Wed, 22 Nov 2023 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yoYSoNhdAF3uXBwTO4gK9Bk/r0jln6+8mWgf09zTa3g=; b=3eGNhZDHZUrMK6QDA4zcwmBBhC
	cAIannDpqj1mmS6JDkxwCHToW3wTS0egVE8MSQOAORkExFzL/aGpsEYyEn2+8EYU6XxY8herW9Lsr
	LirO4R3WDSJ5QFb3sjtSZMPXmkZTLp7oPEf4vFJD2zp1moX64Wdz+lIOzMi6cizZAJdA3HhZIk8q/
	Zx8cKTjdV4mYV4eqsu5vqE8RuqwktQk01Eh21BaQyu0ibpoqLEWcSzNg3hDWHT3VgdS8Wcnw2Msmp
	VAUPUyoQ4UqkXddjMiLgtcf5uuxsPC31h4+85DwclL9hiCT6gcG6g3dIYI4h8X3R5QQKRY7QYN/F6
	oERHm3ZA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1r5nPU-004MK7-JZ; Wed, 22 Nov 2023 13:36:57 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1r5nPU-00000001DZJ-30xf;
	Wed, 22 Nov 2023 13:36:56 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] bpf: add __printf() to for printf fmt strings
Date: Wed, 22 Nov 2023 13:36:56 +0000
Message-Id: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The btf_seq_show() and btf_snprintf_show() take a printk format
string so add a __printf() to these two functions. This fixes the
following extended warnings:

kernel/bpf/btf.c:7094:29: error: function ‘btf_seq_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
kernel/bpf/btf.c:7131:9: error: function ‘btf_snprintf_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..46c2e87c383d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7088,8 +7088,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
 	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
 }
 
-static void btf_seq_show(struct btf_show *show, const char *fmt,
-			 va_list args)
+static __printf(2,0) void btf_seq_show(struct btf_show *show, const char *fmt,
+				       va_list args)
 {
 	seq_vprintf((struct seq_file *)show->target, fmt, args);
 }
@@ -7122,7 +7122,7 @@ struct btf_show_snprintf {
 	int len;		/* length we would have written */
 };
 
-static void btf_snprintf_show(struct btf_show *show, const char *fmt,
+static __printf(2,0) void btf_snprintf_show(struct btf_show *show, const char *fmt,
 			      va_list args)
 {
 	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
-- 
2.37.2.352.g3c44437643


