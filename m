Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8CB73476
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfGXRAc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 13:00:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50571 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfGXRAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 13:00:32 -0400
Received: by mail-pg1-f202.google.com with SMTP id q9so28639416pgv.17
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5PMPzWIi54TuG8trdkiDS7NRHXm1UpJoF4P7uSxvOC8=;
        b=ZkfjP79fQlugj9oRiKGTXzOIt7HG4wTkP4ttxamQ1H2fXL12z0W4v3jLA8+JOLFCLp
         jjPyQhq7+OqufH9UwSObbCma6xYUlYUQKsZqwMCQBdaqV0FpuwytWHLQtRxzYLtZG0Pm
         LhXYjAd1tfD3+Bxxlc1tnZOL9wW5goycfiL9fHsO0ZB30ekAMk/OwtB0REelQqkPZrhr
         50u6TVifj4khG4VGjYuvk7wxY092rWQxzfvnaYqTeHxa/Kkzlc6Y2oPCuxs3IS8uEc1Z
         St/qco1Pet2w8ISFGdtncwLWi888LCfJCh6QfbFEtANjgiidP78hVp2azC2uTx5ipF5P
         LXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5PMPzWIi54TuG8trdkiDS7NRHXm1UpJoF4P7uSxvOC8=;
        b=scpP3wGEZ32kYqBDTIWdBptXMwUBXa1BhZWFzEVfWxUKXozRgjijsGQN9zlY7KO1LA
         D0IlDJAee1QoRxfZHtRs0IOuv5qdyUrJhkjWHxL6q3MDkYngG84FuDWCVxOHYtp1rCMt
         FjYElmMCcYPu+BmEFDV+MTDNrKbWFHUxSwkra3MBw4wkYwMr1EorsC+tv9HkZoJsweRa
         VtdNO/RLAWSDtPPvDe4fGDWoGC0d50atwGKaggtxNGtxoEnOtH3otqDJv40dRF1734af
         l++LiqkDFiGjh5m+BephSofIkxr+1DcQ8EOAb+2xXxmmBD8MdkyYNech/EQsnCRx4o37
         rjOA==
X-Gm-Message-State: APjAAAUg5JjzU/nRv225Stfp2AoBtVo0ZDtQLiJvJXEC4c98tksCoVPS
        IjfErF8lN7KrWpnmY1lWuYiK68w=
X-Google-Smtp-Source: APXvYqxwinw/JzYT/Sfh5yugln/Pl+rujP5HPMle4krOX1orqcd5Sptnnw4VwpGrpVkNsFkFGbyNM64=
X-Received: by 2002:a63:e306:: with SMTP id f6mr80983714pgh.39.1563987630889;
 Wed, 24 Jul 2019 10:00:30 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:00:15 -0700
In-Reply-To: <20190724170018.96659-1-sdf@google.com>
Message-Id: <20190724170018.96659-5-sdf@google.com>
Mime-Version: 1.0
References: <20190724170018.96659-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 4/7] tools/bpf: sync bpf_flow_keys flags
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Export bpf_flow_keys flags to tools/libbpf/selftests.

Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4e455018da65..a0e1c891b56f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3504,6 +3504,10 @@ enum bpf_task_fd_type {
 	BPF_FD_TYPE_URETPROBE,		/* filename + offset */
 };
 
+#define FLOW_DISSECTOR_F_PARSE_1ST_FRAG		(1U << 0)
+#define FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL	(1U << 1)
+#define FLOW_DISSECTOR_F_STOP_AT_ENCAP		(1U << 2)
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
2.22.0.657.g960e92d24f-goog

