Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30721010E7
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 02:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKSBoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 20:44:25 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:40202 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfKSBoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:25 -0500
Received: by mail-yb1-f202.google.com with SMTP id p4so14909308ybp.7
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 17:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=XuRXY+Uojn4XMwzMfwawiXvnYay5fnux5+uJeb3ziZ3R5w/vbNhsqKzQ/EKcdHNva/
         bTVABpEbKe34fuMWa+rwVkf9oUB+ETllNbUdUuEV0kMV27/I5J46qEvTfjgr3geFNG+s
         VuSKrsE9MCPhH2N0/LwdjCjUe+e+7kT1wnb7rWBqjNaQZyzKPXI8ZtCdQjtjJ4NT+QVx
         GGYs8he60Apg56auefYNhlsWUk/3YYn80LCHN2SQIEPH+cUJtaYM/Gi894vrfxz39I65
         SfD/FmVf683ut0qb6rCIBdLpkfRwi72MeVlTL7TmwAh1xuxqQFLA90nnUry9c6MB5Zpy
         j0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=t9mIGCkIkot5YIbFV+vqkzoIIw234SX5bOamFZ9F7eVr23kTCOy9v71IfMxISqpVWD
         +M+NTwql+1fzpNtgjd3EHj3yByU+EJEDC5TqUaKsSdzdK0EWS9pU77ZTVuWJ5odDaFO4
         XsUvhxawCwDV/rcWonVq3Fyt5rkXBcz5Xjp+LARx9cV1UjdvP4M7yElF45KPmEeXOUe/
         hPHOCIF8qSxFdJZ5T8tsNSr5MrZiBQ9WmFFDzhzxqshuOiyA/jouyfKyvqb+xY9p6t77
         6MVUGDRdtkFatXoa9FufeAF8PQMAem1aLAgEjh3wDVsvrSGUDv1FhmhVVTozb+69A3AK
         UASw==
X-Gm-Message-State: APjAAAVbMebxeMl8QQgBfAq9Bivg8DCprHORy/s6FC5pW66MU/oKMTrZ
        cKS3zcnGwuHZxqfi21gbRd9Q7xz+7o3R
X-Google-Smtp-Source: APXvYqyTrKX/xD95yspop64YmtLkkWhLlkti3RyghsE1x1RjvOga6zkHUJod3Kf+PT0x/rL4hhHXbqUl7AWp
X-Received: by 2002:a81:36c9:: with SMTP id d192mr10218854ywa.304.1574127863941;
 Mon, 18 Nov 2019 17:44:23 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:52 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-5-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 4/9] bpf: add lookup and updated batch ops to arraymap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the generic batch ops functionality to bpf arraymap, note that
since deletion is not a valid operation for arraymap, only batch and
lookup are added.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1c65ce0098a95..680d4e99ef583 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -457,6 +457,8 @@ const struct bpf_map_ops array_map_ops = {
 	.map_direct_value_meta = array_map_direct_value_meta,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-- 
2.24.0.432.g9d3f5f5b63-goog

