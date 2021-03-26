Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7929834A53E
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZKDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 06:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhCZKDc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 06:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616753010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AqbkoNQ8XoV32TJQbt2vnYtr9D9KJMnunF7xga9JKcE=;
        b=DQBVCCcoVTdgOZBVEkGh5nU5EEjC6wagiAbAI5g230sQQSIGoogFBhugHH9kB9Xr3h9kLB
        ZgU8p1rOEQ+YhUC/JfzffAD74mVGFLyFf39/ivXiTgpesSkvuWlLKvCWKZL5xmWGl5Ux/d
        yQ6+kI5f9Ccrk7c0GMXshxSVJF37Avs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-6X5yPobHO9m6gJb0NrTZcg-1; Fri, 26 Mar 2021 06:03:28 -0400
X-MC-Unique: 6X5yPobHO9m6gJb0NrTZcg-1
Received: by mail-ej1-f71.google.com with SMTP id h14so3878002ejg.7
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 03:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqbkoNQ8XoV32TJQbt2vnYtr9D9KJMnunF7xga9JKcE=;
        b=iAdvc5/zfDjMyCYHK11s2c4P9rKL80IIHULw9cycKbZ8H96IEsyFqikzUU2Wc5Ncdw
         ournA8efHK4ddK/rQfElgBSrp/4nZLdDgj89ncP0R9M6coarUaIaBsxbZ487tFTTKFP1
         X865VoZXo7E+x3oEOYhZBp9szK4y5kT3ubcvwOW2NnUPqSPbvxHX5R74GFKWWXIkSbLi
         2QWZ6+X1tke9M+zdcVGAx933JH0D/wespn/lI8tccWytW4VqtMKRwfpTnkl0CrJxUJ6n
         jnwlx/0OJjAUQBBvQ/b0NIDsrv2nw/AmeRb6DV0RW7opn+awikgWEmPc5G7khyHTyOYT
         0baw==
X-Gm-Message-State: AOAM5336MRITTN8h8M88aE+x0bVQMC/n9+Y8ipwGm5dk1VbPT8eubJDF
        JBRrCpcJp2XT4I8Tve1v+B3AvjFC00zWCMvU21yo7Uu18EYhq89R0y9RHwxRjfxpTQaXlINiST6
        413zU5QbFADe4
X-Received: by 2002:a17:906:495a:: with SMTP id f26mr14025450ejt.271.1616753007170;
        Fri, 26 Mar 2021 03:03:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJhgy8ubAo4D3bF1qJvgBXod5/y0iR6kIN45MclrY380CjRxzFYjZIQ+0veKTNTIh10Qo7tw==
X-Received: by 2002:a17:906:495a:: with SMTP id f26mr14025408ejt.271.1616753006772;
        Fri, 26 Mar 2021 03:03:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 90sm3943863edf.31.2021.03.26.03.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:03:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4E1221801A3; Fri, 26 Mar 2021 11:03:25 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Clark Williams <williams@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf: enforce that struct_ops programs be GPL-only
Date:   Fri, 26 Mar 2021 11:03:13 +0100
Message-Id: <20210326100314.121853-1-toke@redhat.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the introduction of the struct_ops program type, it became possible to
implement kernel functionality in BPF, making it viable to use BPF in place
of a regular kernel module for these particular operations.

Thus far, the only user of this mechanism is for implementing TCP
congestion control algorithms. These are clearly marked as GPL-only when
implemented as modules (as seen by the use of EXPORT_SYMBOL_GPL for
tcp_register_congestion_control()), so it seems like an oversight that this
was not carried over to BPF implementations. Since this is the only user
of the struct_ops mechanism, just enforcing GPL-only for the struct_ops
program type seems like the simplest way to fix this.

v3: No change
v2: Move check to the top of check_struct_ops_btf_id().

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 44e4ec1640f1..3a738724a380 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12158,6 +12158,11 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	u32 btf_id, member_idx;
 	const char *mname;
 
+	if (!prog->gpl_compatible) {
+		verbose(env, "struct ops programs must have a GPL compatible license\n");
+		return -EINVAL;
+	}
+
 	btf_id = prog->aux->attach_btf_id;
 	st_ops = bpf_struct_ops_find(btf_id);
 	if (!st_ops) {
-- 
2.31.0

