Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBD5EE84
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGCV3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 17:29:11 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46455 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCV3K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 17:29:10 -0400
Received: by mail-pf1-f201.google.com with SMTP id g21so2237791pfb.13
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CgE+VohwMcJGdxE48xVXINshCDvVZZROM0YSvSs/nZc=;
        b=Oz++jnhL9NjxRAUFQ8xHj/kjaK5SYRAIfeHKqAeE0yluWI/88f2cYSC7wQHjNVymxO
         3Wjfz6kfoYpsg+fumv7AOx8bo16cERcUEQKrvY5ENOP264eKDUIOaj9sT8g0rNA4hol1
         uPCAKOWqe4fU8/sbdiYx9MrvNXJCCCUUbooCzN5oyUB17L3lkTMpZseuWV49X85VkiYE
         ATtjOuiydvF2MSCWeMwW/cJJAua7hpAw2tQJ/g5mi88FszMX6R9VASiBGM6LKPQBiCfd
         4XdQ2XBBJb3sApBJtcVg3GGkAucWTsF49QEp6gf2ZFv4odnHraxYcVEYJ1uLxSGORK/r
         tiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CgE+VohwMcJGdxE48xVXINshCDvVZZROM0YSvSs/nZc=;
        b=raW0BH7Oq6g4Z1vUAukX/tSP4kn5259lUToae/5crHTBUpDg9jCprc5Tf30mSgRpQG
         jHpCkbbW2etdJOm4efbe88NWtjFLKTLGgwBUJjkMLY+QBEHIXu2SnkPjyb87lHX4G8ZP
         rv2316Yt6Hj6YY3tPyUSw5Zm8ZpcecmaglMEwzKZe0dP7TM7x4frl7fLJLoA3r3j0nW5
         STMFP+zv/g5bZ1dMfRgTstr8+lyH983WWkeu/Gd0l0Zaf4Vl+GjprK7xHuhHCYVZilY1
         k3z06WVLgGBsgnogy0oTofhGhlkVjEdslO2zmRAIA+f9vhlscqAUFc8STC/TNC6dhIqB
         MANQ==
X-Gm-Message-State: APjAAAWpseLxd3vUYXlXISNUqW8vY4t1OY/GnRK/SjBDT2K1d/oU/krI
        Acn/e8E4/orgX+Mv/bMDoSRNFMY=
X-Google-Smtp-Source: APXvYqzuzzu2Mg63kpyc077g1axsioM4rPPlggjndgv/G6aX/yVsXzoTH86t3Xi2Cxe1r8YNOAXJq/I=
X-Received: by 2002:a63:1226:: with SMTP id h38mr38749013pgl.196.1562189349900;
 Wed, 03 Jul 2019 14:29:09 -0700 (PDT)
Date:   Wed,  3 Jul 2019 14:29:07 -0700
Message-Id: <20190703212907.189141-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next] selftests/bpf: fix test_align liveliness expectations
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 2589726d12a1 ("bpf: introduce bounded loops") caused a change
in the way some registers liveliness is reported in the test_align.
Add missing "_w" to a couple of tests. Note, there are no offset
changes!

Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_align.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_align.c b/tools/testing/selftests/bpf/test_align.c
index 3c789d03b629..0262f7b374f9 100644
--- a/tools/testing/selftests/bpf/test_align.c
+++ b/tools/testing/selftests/bpf/test_align.c
@@ -180,7 +180,7 @@ static struct bpf_align_test tests[] = {
 		},
 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 		.matches = {
-			{7, "R0=pkt(id=0,off=8,r=8,imm=0)"},
+			{7, "R0_w=pkt(id=0,off=8,r=8,imm=0)"},
 			{7, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
 			{8, "R3_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
 			{9, "R3_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
@@ -315,7 +315,7 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{8, "R2=pkt(id=0,off=0,r=8,imm=0)"},
+			{8, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
 			{8, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Offset is added to packet pointer R5, resulting in
 			 * known fixed offset, and variable offset from R6.
@@ -405,7 +405,7 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{8, "R2=pkt(id=0,off=0,r=8,imm=0)"},
+			{8, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
 			{8, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Adding 14 makes R6 be (4n+2) */
 			{9, "R6_w=inv(id=0,umin_value=14,umax_value=1034,var_off=(0x2; 0x7fc))"},
@@ -473,12 +473,12 @@ static struct bpf_align_test tests[] = {
 			/* (4n) + 14 == (4n+2).  We blow our bounds, because
 			 * the add could overflow.
 			 */
-			{7, "R5=inv(id=0,var_off=(0x2; 0xfffffffffffffffc))"},
+			{7, "R5_w=inv(id=0,var_off=(0x2; 0xfffffffffffffffc))"},
 			/* Checked s>=0 */
 			{9, "R5=inv(id=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc))"},
 			/* packet pointer + nonnegative (4n+2) */
 			{11, "R6_w=pkt(id=1,off=0,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc))"},
-			{13, "R4=pkt(id=1,off=4,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc))"},
+			{13, "R4_w=pkt(id=1,off=4,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc))"},
 			/* NET_IP_ALIGN + (4n+2) == (4n), alignment is fine.
 			 * We checked the bounds, but it might have been able
 			 * to overflow if the packet pointer started in the
@@ -486,7 +486,7 @@ static struct bpf_align_test tests[] = {
 			 * So we did not get a 'range' on R6, and the access
 			 * attempt will fail.
 			 */
-			{15, "R6=pkt(id=1,off=0,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc))"},
+			{15, "R6_w=pkt(id=1,off=0,r=0,umin_value=2,umax_value=9223372036854775806,var_off=(0x2; 0x7ffffffffffffffc))"},
 		}
 	},
 	{
@@ -521,7 +521,7 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{7, "R2=pkt(id=0,off=0,r=8,imm=0)"},
+			{7, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
 			{9, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Adding 14 makes R6 be (4n+2) */
 			{10, "R6_w=inv(id=0,umin_value=14,umax_value=1034,var_off=(0x2; 0x7fc))"},
@@ -574,7 +574,7 @@ static struct bpf_align_test tests[] = {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{7, "R2=pkt(id=0,off=0,r=8,imm=0)"},
+			{7, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
 			{10, "R6_w=inv(id=0,umax_value=60,var_off=(0x0; 0x3c))"},
 			/* Adding 14 makes R6 be (4n+2) */
 			{11, "R6_w=inv(id=0,umin_value=14,umax_value=74,var_off=(0x2; 0x7c))"},
-- 
2.22.0.410.gd8fdbe21b5-goog

