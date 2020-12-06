Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680BA2D065C
	for <lists+bpf@lfdr.de>; Sun,  6 Dec 2020 18:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLFRhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Dec 2020 12:37:21 -0500
Received: from [83.220.44.62] ([83.220.44.62]:40476 "EHLO beacon.altlinux.org"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbgLFRhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Dec 2020 12:37:21 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2020 12:37:19 EST
Received: by beacon.altlinux.org (Postfix, from userid 950)
        id 293DB481DFB; Sun,  6 Dec 2020 20:26:56 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] dwarves: Fix compilation on 32-bit architectures
Date:   Sun,  6 Dec 2020 20:26:17 +0300
Message-Id: <20201206172617.9751-1-vt@altlinux.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace `%lx' for addr (uint64_t) with PRIx64. `%ld' for seek_bytes
(off_t) is replaced with PRIx64 too, likewise in other places it's
printed.

Fixes these error messages on i586 and arm-32:

  btf_encoder.c:445:52: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'uint64_t'
  btf_encoder.c:687:54: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uint64_t'
  btf_encoder.c:695:71: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uint64_t'
  btf_encoder.c:708:88: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uint64_t'
  pahole.c:1872:20: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'off_t'

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Cc: bpf@vger.kernel.org
Cc: dwarves@vger.kernel.org
---
 btf_encoder.c | 8 ++++----
 pahole.c      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c40f059..feb1023 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -442,7 +442,7 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
 	}
 
 	if (btf_elf__verbose)
-		printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
+		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
 
 	if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
 		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
@@ -684,7 +684,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
 
 		if (btf_elf__verbose) {
-			printf("Variable '%s' from CU '%s' at address 0x%lx encoded\n",
+			printf("Variable '%s' from CU '%s' at address 0x%" PRIx64 " encoded\n",
 			       name, cu->name, addr);
 		}
 
@@ -692,7 +692,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		id = btf_elf__add_var_type(btfe, type, name, linkage);
 		if (id < 0) {
 			err = -1;
-			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%lx\n",
+			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%" PRIx64 "\n",
 			        name, addr);
 			break;
 		}
@@ -705,7 +705,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo, id, offset, size);
 		if (id < 0) {
 			err = -1;
-			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%lx\n",
+			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
 			        name, addr);
 			break;
 		}
diff --git a/pahole.c b/pahole.c
index fe8d2cd..4a34ba5 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1869,7 +1869,7 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 
 		// Since we're reading stdin, we need to account for what we already read
 		if (seek_bytes < total_read_bytes) {
-			fprintf(stderr, "pahole: can't go back in stdin, already read %" PRIu64 " bytes, can't go to position %ld\n",
+			fprintf(stderr, "pahole: can't go back in stdin, already read %" PRIu64 " bytes, can't go to position %#" PRIx64 "\n",
 					total_read_bytes, seek_bytes);
 			return -ENOMEM;
 		}
-- 
2.25.4

