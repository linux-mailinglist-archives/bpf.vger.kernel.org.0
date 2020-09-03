Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14C625C3EF
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgICPAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 11:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728826AbgICOFx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Sep 2020 10:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599141948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5uWJk8uRW86VLHHEupzWNTmb59FoNkTg1geubDp8r00=;
        b=AZuvTroMhaY4m0WvHf0jO+HciIHvnDBwtYzrmE2klRf/kbw4sXHr09OGcZAR0MCQ3x66t0
        Y4h+iW3yQrY4KFHZo1OdisauAuil3B/1y4X1+AcpBcmyje9RZZ7cfu/v4+LV+iPGE9AREG
        l+UT0Qj50zGGirRFjdRTzuxEn1nA6bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-nEueuyFyPXOvNM9xTWcAag-1; Thu, 03 Sep 2020 10:05:46 -0400
X-MC-Unique: nEueuyFyPXOvNM9xTWcAag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DA171019629;
        Thu,  3 Sep 2020 14:05:45 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-146.ams2.redhat.com [10.36.112.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE82A811B5;
        Thu,  3 Sep 2020 14:05:43 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>, jolsa@redhat.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH RFC] bpf: update current instruction on patching
Date:   Thu,  3 Sep 2020 17:05:42 +0300
Message-Id: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On code patching it may require to update branch destinations if the
code size changed. bpf_adj_delta_to_imm/off increments offset only
if the patched area is after the branch instruction. But it's
possible, that the patched area itself is a branch instruction and
requires destination update.

The problem was triggered by bpf selftest

test_progs -t global_funcs

on s390, where the very first "call" instruction is patched from
verifier.c:opt_subreg_zext_lo32_rnd_hi32() with zext_patch.

The patch includes current instruction to the condition check.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ed0b3578867c..b0a9a22491a5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -340,7 +340,7 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
 	s32 delta = end_new - end_old;
 	s64 imm = insn->imm;
 
-	if (curr < pos && curr + imm + 1 >= end_old)
+	if (curr <= pos && curr + imm + 1 >= end_old)
 		imm += delta;
 	else if (curr >= end_new && curr + imm + 1 < end_new)
 		imm -= delta;
@@ -358,7 +358,7 @@ static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
 	s32 delta = end_new - end_old;
 	s32 off = insn->off;
 
-	if (curr < pos && curr + off + 1 >= end_old)
+	if (curr <= pos && curr + off + 1 >= end_old)
 		off += delta;
 	else if (curr >= end_new && curr + off + 1 < end_new)
 		off -= delta;
-- 
2.26.2

