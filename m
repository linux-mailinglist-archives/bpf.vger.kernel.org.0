Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99C0376DF
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfFFOgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 10:36:07 -0400
Received: from www62.your-server.de ([213.133.104.62]:33388 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfFFOgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 10:36:06 -0400
Received: from [178.197.249.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYtUr-0004A3-4d; Thu, 06 Jun 2019 16:36:05 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     kafai@fb.com, rdna@fb.com, m@lambda.lt, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 2/4] bpf: sync tooling uapi header
Date:   Thu,  6 Jun 2019 16:35:15 +0200
Message-Id: <20190606143517.25710-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190606143517.25710-1-daniel@iogearbox.net>
References: <20190606143517.25710-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25472/Thu Jun  6 10:09:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync BPF uapi header in order to pull in BPF_CGROUP_UDP{4,6}_RECVMSG
attach types. This is done and preferred as an extra patch in order
to ease sync of libbpf.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63e0cf66f01a..e4114a7e4451 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -192,6 +192,8 @@ enum bpf_attach_type {
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
+	BPF_CGROUP_UDP4_RECVMSG,
+	BPF_CGROUP_UDP6_RECVMSG,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.17.1

