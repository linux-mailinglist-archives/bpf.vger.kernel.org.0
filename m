Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C585102C99
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfKSTa4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 14:30:56 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51855 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfKSTaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 14:30:55 -0500
Received: by mail-pg1-f202.google.com with SMTP id f18so4025905pgh.18
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=KKfy6cGFJzrvbZ+zaVtoIK6lbKkij8Ez+QP+UrABS7jTH6fWRYIOLXrUNxMuEhYho2
         gIJ0Z3z9EY5uAfnR/RT2mxFOPeuEJXtf0gOs2iwNjq7C89kcDwoPU+pkr6Fv7S2kIllI
         cgnJ4vZ95Lh6qUuqJ/b9vUDGOMJMIfF8TbS9XjBvp0KfxklTpcbFSSHiC/EoGqm4VvGT
         xheYmmAUWYh+0a+EgLJGRRBp61JZWwI/gvzpV9x8oFIiT98N8UwQNBptCNGx50kVH004
         1+eZVNTge9RNKalRpnP80Z9HZjoDuuoslzDpFkhj0dZ0CTDwUuoGXV0HxvGcGYxjt6Rv
         G3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+X4EfDiauElJOC7RvUHMTNrf0yIKJ6Yo/r1JySL4OmE=;
        b=jIZHZBV27VP5Qp8oA9wLsoqshM/b66Chfg8U62SW3KicVdkD9ltGyIJQHNyfrdDfot
         gJ6qBO2sv6AsfkajQG2wXucqKqDTLqSG3vVuIee0+9M21KCe0ACbYHXr3SXjmcwmJDqw
         20dC0ofW9MMztZS5NCGXSIoaEA1X7PE8rlOg6+0wOexaP32+qBN/3+SDAcTSzI6eNBzK
         KKbKdRE1cO0zOnWq3nOZfwNP+7Oxad9scPpb+Fh5u749DuZO5SRma11hEYKQY551hdW3
         wL9Hi/ClskEZ4BdVibUzl7jdbaC4cQ+1onq8EBasWYjHc8aBd+NKHYW/U7v9qrOTJnYM
         yRfg==
X-Gm-Message-State: APjAAAXExxXTXOURdLDlzl70jqWyYK+Z6nRjujqXnxQMhkdbuZduL73T
        Q5Jz7H7KtUzIthxJ0t0upfZjN7vrYLbW
X-Google-Smtp-Source: APXvYqzXkr5QL8TzNPUeAu0p3xccRyiDCHLjKy9+fE96m5hofERZicATy3cDVLslLNxJKgSdiDuS1g9cr/Kq
X-Received: by 2002:a63:3587:: with SMTP id c129mr7516833pga.211.1574191853520;
 Tue, 19 Nov 2019 11:30:53 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:30:31 -0800
In-Reply-To: <20191119193036.92831-1-brianvv@google.com>
Message-Id: <20191119193036.92831-5-brianvv@google.com>
Mime-Version: 1.0
References: <20191119193036.92831-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 bpf-next 4/9] bpf: add lookup and updated batch ops to arraymap
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

