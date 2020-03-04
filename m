Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742831798CF
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgCDTTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:19:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDTTF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id r7so3894531wro.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=FE5efpYRwoF7VVTPXIG28AriU/JlAE3lJtKyUjEtXvjYIKn4CTF1F8sA/xwVRw7/Ja
         ZGoPiWq0rU9dhtjilYW3yxsFLNJ2FSZsUN9mawMbbAqDAYSfXLgdKXYW7JOlDqLHKyiF
         nEpGRY+LiTH44lDXfBDzT0XKESedJkyr3VfSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=dEk2Aq4JwJn/2MwK8sapDTHI3uT8u+cJK0o5HSpK80BfI285oZkqfeFIwOumKyqAR4
         Xu97NI6SSRKTEUJ5Zd6rySK2pTN72tptQNrfPu/YYrjSZbNEmHhMmPOpDKhr+4YCyOiM
         wx8faf+92C1/GK8nQMpoC+X8YhC+hOlesJSkhS7L8NcCS24fS1OBa4KlUByqdauLOUr+
         wjTBOQQHQAuEkH+hpCtwC9TMs4JmIPEWwPGQruPzvgp/1hpV6SfQtZS4epz2Hlv6iawd
         tjvpeNM1z3XktLg8hBcE+QS3pQGXZ5VBJUwUhjFHXec8DgeaVpQfs4wXwpY9dBjZRoYg
         9ECQ==
X-Gm-Message-State: ANhLgQ37jOzoTwEF7UaMswYFroMAkDaASwOrBJXQ4dAquzy8Utbble27
        g8xMLPDVTtqrU+auzwlqstNpuA==
X-Google-Smtp-Source: ADFU+vvid5xxJMg8IBmdx1lMpOT5FCqtAp9hZz0BwM3M7ATWDojbEADvNTiFjxbb4CrCBf8z0L7W+w==
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr5541348wrv.83.1583349543923;
        Wed, 04 Mar 2020 11:19:03 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:19:03 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 20:18:51 +0100
Message-Id: <20200304191853.1529-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f8c4042e5855..223be01dc466 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6288,6 +6288,10 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_FENTRY,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("fmod_ret/", TRACING,
+		.expected_attach_type = BPF_MODIFY_RETURN,
+		.is_attach_btf = true,
+		.attach_fn = attach_trace),
 	SEC_DEF("fexit/", TRACING,
 		.expected_attach_type = BPF_TRACE_FEXIT,
 		.is_attach_btf = true,
-- 
2.20.1

