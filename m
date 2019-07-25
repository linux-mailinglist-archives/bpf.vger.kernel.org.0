Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61FD75AF5
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2019 00:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfGYWwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jul 2019 18:52:45 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44462 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGYWwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 18:52:45 -0400
Received: by mail-pg1-f201.google.com with SMTP id a21so31592143pgh.11
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2019 15:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DgAXQIdA0ZhiJ+xsheYT6VV9/xgThvpc7H+hWpWWals=;
        b=Z+b/bGhRGPiEr7jhNeoEliqMlHbZtMWeT6oR9aAmNAfg3zihXrHrIG0e2I8bdrRR4z
         mJughnLma8eXEITUZPgDD4EIF/ZbdBuKQaAWn5HFgjxpVU/WTjI7En3/vqrQ2imEsRzi
         DYFwCPQXIFD+ltMPHODkscT7xGTqBm1rnInUxOqkmHZSw0/8qXa4DTRz8bAGyTLPgwMW
         JOCM1/EByu3hI2/Nt+sBN0qX/npziImmxt9H0o+BgPoQqvkfnojUDI8gJWUFsGBWJxVV
         kTJIqlsqV5UshEzLs9vi8eUSrfl6UiYtuiuPrCQGlUTJw89gNgLTTwtte4x4yjfBqrS3
         1z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DgAXQIdA0ZhiJ+xsheYT6VV9/xgThvpc7H+hWpWWals=;
        b=tB3iF4uA5dchvgxGEq6kd7H19SH7lQc0Eh4ODlLpQfvtCAoobxk+EcvZL6exvU0Ua6
         NYe5TEEGMf10EzlkNPsgA0FqCKEQZC1J93Ovqnm0FPZNC3xmCsFWwqQMCA+RiAX5AbQi
         VGdpfhhoyHlNeYBr8jMC+rhb3GgrxUqKB14xf1em9HERGXXAWzS1SrPFuH8I/zikvnxl
         QVEt+IMXidr+hwx3XgBcg1nVWK6lANZN9YBH+vg4R8ezWPJkY2pR9X0ZGSKO0kV7ZZ62
         ugLueNGIoeuxedUowwb3hgHxTa5Ci6lWFdXaa1I280c7ZFm5MORnF/jVQMBvrl1+cC3f
         t+MA==
X-Gm-Message-State: APjAAAWQSAA1J30aZsDJXUT0qa6PPrscNWMjMMb38C4RKwDzxzN5cjmB
        /I6LRQGdLSYJmI7eXKj0qxSeJzs=
X-Google-Smtp-Source: APXvYqywSlusS3kT7pdugZP6FYyE64YryoLfEc2VX+H5iycxuT1/zBr3TIiXIPi4jVFlf3CLM2yjoEU=
X-Received: by 2002:a65:44cb:: with SMTP id g11mr42780890pgs.288.1564095164486;
 Thu, 25 Jul 2019 15:52:44 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:52:28 -0700
In-Reply-To: <20190725225231.195090-1-sdf@google.com>
Message-Id: <20190725225231.195090-5-sdf@google.com>
Mime-Version: 1.0
References: <20190725225231.195090-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next v3 4/7] tools/bpf: sync bpf_flow_keys flags
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Export bpf_flow_keys flags to tools/libbpf/selftests.

Acked-by: Petar Penkov <ppenkov@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4e455018da65..2e4b0848d795 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3504,6 +3504,10 @@ enum bpf_task_fd_type {
 	BPF_FD_TYPE_URETPROBE,		/* filename + offset */
 };
 
+#define BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG		(1U << 0)
+#define BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL		(1U << 1)
+#define BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP		(1U << 2)
+
 struct bpf_flow_keys {
 	__u16	nhoff;
 	__u16	thoff;
@@ -3525,6 +3529,7 @@ struct bpf_flow_keys {
 			__u32	ipv6_dst[4];	/* in6_addr; network order */
 		};
 	};
+	__u32	flags;
 };
 
 struct bpf_func_info {
-- 
2.22.0.709.g102302147b-goog

