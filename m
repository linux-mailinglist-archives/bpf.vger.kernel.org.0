Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C01BB439
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 04:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1C4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Apr 2020 22:56:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:54922 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgD1C4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 22:56:41 -0400
IronPort-SDR: NxoRsRyjAjCJKGOk4yQm2LojCKUFVlguzKRDYLv76L5AK6bVJTe8bmNP18DtVMkwpVLJV2Xxal
 aGQWaYn+p0Aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 19:56:41 -0700
IronPort-SDR: /CjUpfq88qsjfYricz7EKIsoRAFHyfLra3pLAUc/36jBGiYXNOYqX325UgeAGpirXmkjsVTEC7
 scpLw5tRpcdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; 
   d="scan'208";a="281994846"
Received: from yananliu-mobl1.ccr.corp.intel.com (HELO [10.255.30.78]) ([10.255.30.78])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2020 19:56:39 -0700
To:     yhs@fb.com, ast@fb.com, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
From:   Ma Xinjian <max.xinjian@intel.com>
Subject: Re: [PATCH bpf-next v2] [tools/bpf] workaround a verifier failure for
 test_progs
Cc:     "Li, Philip" <philip.li@intel.com>
Message-ID: <4c14c01e-be39-817b-ca8c-200690ac4caf@intel.com>
Date:   Tue, 28 Apr 2020 10:56:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong.

During our team's test, we find a similar issue. when run test_sysctl of 
bpf, we met error:

```

libbpf: -- END LOG --
libbpf: failed to load program 'cgroup/sysctl'
libbpf: failed to load object './test_sysctl_prog.o'
(test_sysctl.c:1490: errno: Permission denied) >>> Loading program 
(./test_sysctl_prog.o) error.

```

Testing env: "Debian GNU/Linux 9 (stretch)"

kernel: 5.6 5.7-rc1 5.7-rc2 5.7-rc3

clang/llvm version: v11.0.0.

we have tested a log of commits, following commits are part of them

drwxrwxr-x 2 root root  1 Apr 28 07:01 
f30416fdde922eaa655934e050026930fefbd260
drwxrwxr-x 2 root root  2 Apr 26 11:38 
10bc12588dac532fad044b2851dde8e7b9121e88
drwxrwxr-x 2 root root  1 Apr 26 07:01 
969e7edd88ceb4791eb1cac22828290f0ae30b3d
drwxrwxr-x 2 root root  1 Apr 23 13:51 
bbf386f02b05db017fda66875cc5edef70779244
drwxrwxr-x 2 root root  1 Apr 22 10:01 
2de52422acf04662b45599f77c14ce1b2cec2b81
drwxrwxr-x 2 root root  1 Apr 21 07:07 
a9b137f9ffba8cb25dfd7dd1fb613e8aac121b37
drwxrwxr-x 2 root root  1 Apr 17 07:01 
40d139c620f83509fe18acbff5ec358298e99def

drwxrwxr-x 2 root root  1 Apr 16 07:02 
bee6c234ed28ae7349cb83afa322dfd8394590ee


And I have tested, If I add following patch like you did, test_sysctl pass:

diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c 
b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
index 2d0b0b82a78a..8e3da8d2e7c9 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
@@ -45,7 +45,10 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
         unsigned long tcp_mem[3] = {0, 0, 0};
         char value[MAX_VALUE_STR_LEN];
         unsigned char i, off = 0;
-       int ret;
+      /* a workaround to prevent compiler from generating
+      * codes verifier cannot handle yet.
+      */
+      volatile int ret;

         if (ctx->write)
                 return 0;

root@vm-snb-15 
/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-6a8b55ed4056ea5559ebe4f6a4b247f627870d4c/tools/testing/selftests/bpf# 
./test_sysctl

...

  Summary: 40 PASSED, 0 FAILED

-- 
Best Regards.
Ma Xinjian

