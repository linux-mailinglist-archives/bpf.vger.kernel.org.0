Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7362D8FE
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 11:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfE2JXa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 05:23:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40116 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2JXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 May 2019 05:23:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so1043844wmg.5
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9U+wrAiEr/UKakTwYDSrakbnJXg6HSffqH7ItISpWq0=;
        b=r+tBaa7BEvTUeZrUcIgS3/zNpcaDoyeUd1rUHRm1jtETiZv/ScnGxZZcubxncRQUQ2
         SG8U/DzjC4bJVucWcnw7gmOxzOeiwd5SdJa0rqyR5ILNB+Rv5yTs6vMLW9dPV/UsFqiY
         IDpC9Xq1aBEeYLsSrtkmQoN4dFFkULSlC/Cluw5eUZZNXlxOKIbfHKTsbemeec+4kH5p
         CzGdHjPZX2J5j6MWui8h4Ne4ieq1Kf3lauW5OEOFb3Hv5+moGwOnbS3L83kDUvl1VR/I
         Vce8OeMkyNAZ6PKNMbYoX2vu5h7VlcXgDRV/CIhDFD4+AK3XxSUOHrg5pTHq0hpVoW/D
         9HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9U+wrAiEr/UKakTwYDSrakbnJXg6HSffqH7ItISpWq0=;
        b=g5xAkcL3N/rrVWMMNy+DLjqtfph3OIlFdKsTwhwX2w8GvMTR8s/oR3KGyOx2Zb3mqQ
         xQucRVBvGwh44i5A/myCdq2YVMJRa0cEkdyN/bv3Jc7YdamaK/2bdznIl/Y4xO088xFm
         WSzkCavKHwxgzfQGXOKBuv8TJyJ01SvJv6YOS425B8NJVNAbr+ky57CpTBZ3np+PnKJr
         D5x3rBL1aJX//uFoa783IrN+7GDm547cKJcyU9mbfCunaBYujtAVgrtMM/Ek2SISsNgY
         jLKP5IEj2uWILnmiTFUTCyqTE4sIeBRsHDEACXM8RO+ilxvj6KAAyZL1q9spQ0eGsX6M
         sdkA==
X-Gm-Message-State: APjAAAU9RM9GtHwODYcklzddxbLSFwgxNd2EUD52chzzY+v6LmVmF/bR
        gjTpRD3kiLjIJr6toWfep4a7ng==
X-Google-Smtp-Source: APXvYqwi0WWdjUhXKkA7RfVFYHpTxDMjGOPMvqiItKKEw7EcH/18IQAaSU1DdCFIo6cApVNeCSyBJA==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr6531014wmb.112.1559121808511;
        Wed, 29 May 2019 02:23:28 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a4sm20290144wrf.78.2019.05.29.02.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:23:27 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next] libbpf: prevent overwriting of log_level in bpf_object__load_progs()
Date:   Wed, 29 May 2019 10:23:23 +0100
Message-Id: <20190529092323.27477-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are two functions in libbpf that support passing a log_level
parameter for the verifier for loading programs:
bpf_object__load_xattr() and bpf_load_program_xattr(). Both accept an
attribute object containing the log_level, and apply it to the programs
to load.

It turns out that to effectively load the programs, the latter function
eventually relies on the former. This was not taken into account when
adding support for log_level in bpf_object__load_xattr(), and the
log_level passed to bpf_load_program_xattr() later gets overwritten with
a zero value, thus disabling verifier logs for the program in all cases:

bpf_load_program_xattr()             // prog.log_level = N;
 -> bpf_object__load()               // attr.log_level = 0;
     -> bpf_object__load_xattr()     // <pass prog and attr>
         -> bpf_object__load_progs() // prog.log_level = attr.log_level;

Fix this by OR-ing the log_level in bpf_object__load_progs(), instead of
overwriting it.

Fixes: 60276f984998 ("libbpf: add bpf_object__load_xattr() API function to pass log_level")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ca4432f5b067..30cb08e2eb75 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2232,7 +2232,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 	for (i = 0; i < obj->nr_programs; i++) {
 		if (bpf_program__is_function_storage(&obj->programs[i], obj))
 			continue;
-		obj->programs[i].log_level = log_level;
+		obj->programs[i].log_level |= log_level;
 		err = bpf_program__load(&obj->programs[i],
 					obj->license,
 					obj->kern_version);
-- 
2.17.1

