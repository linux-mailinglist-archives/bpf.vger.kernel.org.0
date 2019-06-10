Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC0F3B988
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfFJQea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 12:34:30 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48727 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfFJQea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 12:34:30 -0400
Received: by mail-pf1-f202.google.com with SMTP id u21so4434206pfn.15
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rzQAcgfGN5K6LU4CelXji685pxXu/comsqrtS35LUIQ=;
        b=GbJtMFB5zQ02SKMkJf3EeDILDaUmtvRgmgM/J9VzEv1HLmAo3Ag50o384ggtnLJPOi
         f3K3f6qlTFgq0ff+ABXERnsH5rRt+zMN5WeIZ5OPK2/KytGzbU0XLXkK2zgIOGesFds7
         VNM3GRSRWgOWaEHEMQEdIPIBfmTO48Xk/RTNVPZjDE1sYNsyzJbk2i+DGGGXkn2yhNc0
         BkBr0APNER88c/cs17oLMNin0KQgwYc+vjAU3cKGcFNdN/tLG4wOQBjRmJm/X4IziUqY
         30uAmxOQHTlwf3ewA3ZVOznuKxd2ie0sRiUj8WKGssEkw8mO8Guz/br3Y2RAuwg38GA/
         xYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rzQAcgfGN5K6LU4CelXji685pxXu/comsqrtS35LUIQ=;
        b=ehXwnzmnjUTR1TRbrJ7P9PzW7W4bFg10MdfpDSXm1x0wjXAYHmlc6fzan8gc75ojXY
         8cIXEriSaGL7o/YA3X7L0OhLWP0/Dj1CpJJfwtmxe+sxSrZzvc0O/G0byAhY36/wYx3h
         hWdC2t2s6RH8zYHv7glORLScQNmQcH6DxossCGjZly0MuAE55yXHhKt/tvgvhpdjsAo7
         +quA3+vaQgWTBl33Cve8rK7h7+7THqDNQlxU/4gQ33nTSKZtyUGuE7HVsWDU1NswY0So
         dv2iWMdt5XopdZ2c74x2WarLO6v7hwYSeTgel0jMdWPCVPkEQYjw7qq/siclLhL09Xgg
         Zo4A==
X-Gm-Message-State: APjAAAWRn0pM7LEAG106Jl5CGCXTjUXaGpm3YC6fixuzNqlJYoqo38/E
        TWJmmrKdvJ3qcFr2TyFLASDGyuI=
X-Google-Smtp-Source: APXvYqyrVHjxMYQH10x5Cq3347EgblZ1moc+UbMeTkGUvsDhfcsR4z+HIk1WGDH+4TXcmy9Fx4aHbyA=
X-Received: by 2002:a65:408d:: with SMTP id t13mr16073782pgp.373.1560184468882;
 Mon, 10 Jun 2019 09:34:28 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:34:15 -0700
In-Reply-To: <20190610163421.208126-1-sdf@google.com>
Message-Id: <20190610163421.208126-3-sdf@google.com>
Mime-Version: 1.0
References: <20190610163421.208126-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v4 2/8] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Export new prog type and hook points to the libbpf.

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7c6aef253173..174136aa6906 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -170,6 +170,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 };
 
 enum bpf_attach_type {
@@ -192,6 +193,8 @@ enum bpf_attach_type {
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
+	BPF_CGROUP_GETSOCKOPT,
+	BPF_CGROUP_SETSOCKOPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -3533,4 +3536,15 @@ struct bpf_sysctl {
 				 */
 };
 
+struct bpf_sockopt {
+	__bpf_md_ptr(struct bpf_sock *, sk);
+	__bpf_md_ptr(void *, optval);
+	__bpf_md_ptr(void *, optval_end);
+
+	__s32	level;
+	__s32	optname;
+
+	__u32	optlen;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

