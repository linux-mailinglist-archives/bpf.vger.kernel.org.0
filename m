Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08C48B21
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2019 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFQSBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jun 2019 14:01:18 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:38650 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFQSBR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 14:01:17 -0400
Received: by mail-yw1-f74.google.com with SMTP id p76so12953275ywg.5
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U184OPt6PLUipr5CRRliK9xhGJgLNV6CYr7jB9LM2eg=;
        b=cIa5vInokoz5ShMinNVzCNRjnTQx9MNiflzS4JTAfb3OC43jYw5dsE0PCJCZeH1PJC
         I/tiAbdRG2zoicSuaFyFdBn5DG+tU3TBRzDYGbxT79ZYx5MqKCq4HnxLGx3IUAwcXrG2
         4JF9esyxDQdzZKf37iJ0sr/dtYUr4OQ7TKgrn8vOWTJMH/r4PuGyEGGrBQaeHhSl34H3
         TVRm6hXjDo9m25Ko24OK+O91tLS1BXG+PSfqUS4DbUh8OhrW+/IRCLtx58sjwoJAsDFR
         nRjyNcSzinrvM00ztTwklEGC5SkSSGTwkX3Q/ijIdWlvEO1yoyFzxk217NOqccVu7dv6
         NK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U184OPt6PLUipr5CRRliK9xhGJgLNV6CYr7jB9LM2eg=;
        b=RBdJgeFRfWOw3sv+zWQhWJ5Yq+zl77+bAqaZLVzmdDUSfLEt1aVDF2ld/0vm1zDo/j
         OIpa1iir5DRbVtVYHr8i218/MaJ+z11Re16Hxk9OU/uu4gHhnb6UZNrMDyzCrQkwotzE
         XaKiztXdSom4BPsyX7R67d6Y9M+wSiDfxG2DvcNymkcI4FqmhwtdrLxClxOVyqEiP5+d
         F8GBvqKBouaU6F6RzkWyK+uvcxZPQtz9kElO+1XsBVugjXHjJRU/rpq26S1nPPWcoM6V
         7JXYHGcAn7vs1H1kAebYiijoJvwmAVf0HKcw3LepNeXDUpuQ+IkA+M4xF4l3iO5NDp+r
         5dtg==
X-Gm-Message-State: APjAAAWS6ctVW1vId1e87Si2z1Ru/MIg8Y4cV2ZQxSf81+WmL6DHn9dl
        Wwhzh5NE512F9aE30LUrVFrSlYI=
X-Google-Smtp-Source: APXvYqz4nftkEQUPmxowXiWBQ0IroOAfxnPY22p3cFBiugN1245bx5zIivMEnckIFLErD+caCJ2iJbE=
X-Received: by 2002:a81:98cc:: with SMTP id p195mr7453338ywg.155.1560794476785;
 Mon, 17 Jun 2019 11:01:16 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:01:02 -0700
In-Reply-To: <20190617180109.34950-1-sdf@google.com>
Message-Id: <20190617180109.34950-3-sdf@google.com>
Mime-Version: 1.0
References: <20190617180109.34950-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v6 2/9] bpf: sync bpf.h to tools/
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
index d0a23476f887..5dc906f1db02 100644
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
 
@@ -3539,4 +3542,15 @@ struct bpf_sysctl {
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
2.22.0.410.gd8fdbe21b5-goog

