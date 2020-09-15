Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5914426B8BE
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 02:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIPAtq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 20:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34205 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbgIOLlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 07:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600170066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIGbpCZmz89BH4RaSE1d8nNgeBGwQPZU+jdCtpvbXO4=;
        b=CZE+IziBxwwJVyT61k/71HKv42TawrWijLxW3mZ0gmrZrZ0p2WVjbDJCJxWlb6eWR8Vh8I
        dwPMKGLDAKHvcc/+r2PFUgraHwJp/JmbqOnk/OMAyAHQiQOH3QSoOAfTCKp6Y9lyXytr/4
        8764t26UwrE3ybkIJfB7aowU5nfrVOw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-XN_PHujoO36ssgZIBXZOTw-1; Tue, 15 Sep 2020 07:41:05 -0400
X-MC-Unique: XN_PHujoO36ssgZIBXZOTw-1
Received: by mail-ej1-f71.google.com with SMTP id li24so1162096ejb.6
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 04:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yIGbpCZmz89BH4RaSE1d8nNgeBGwQPZU+jdCtpvbXO4=;
        b=BnnowsrDHZAI/Akq3R6YtJm5g2AKyfNC5NgDIvBu23V6GtCp+Nz+ZGBAtblmN2V8XU
         PEWZ/eVtV09gygkpxW3tMORyRHxpn4ZLDnjg4lFhmsRBIcu56WCvrw2Who2dlmZGzzgu
         UHxwOuByFawZEmCrPubz77GNCJPVlGUarj2JVEhk9e0NABMtxnxa4vmjRvLAcLYMlvgE
         5W2LbP4daLwY49/NTJ0/Lh/nyLVRJFTJkx2bvN8zgY6RfhY5c8l1gPHPKNQij884fxo+
         KXFbs/d8XJuzhmYuo7AEGuWmGvU8trvmNwrObo0Wu8xZKE7xyVaD4g9EaMN9Y9xxvKWK
         lQ3w==
X-Gm-Message-State: AOAM530fWDSS+bvAlBrv3faeBidMiRt9JQu9DLGv4CRHnmT9Dw4jE3YH
        1AJMnAfBiNrZYJU23ej9tsxpoSoywPsKqMwa6NKEMvzp/m3SFtG+AC4B556KKJzQ03v2WuC1+rS
        rxApI2LzLLYXy
X-Received: by 2002:a17:906:b813:: with SMTP id dv19mr19312623ejb.70.1600170063846;
        Tue, 15 Sep 2020 04:41:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD2LVB/5/A3KXQLI0EVOwc9cTUvDT+f6CGM+E9vjX+t4XyIxXHSXoAtsmJLV3lW/jJ+Ia9xg==
X-Received: by 2002:a17:906:b813:: with SMTP id dv19mr19312597ejb.70.1600170063617;
        Tue, 15 Sep 2020 04:41:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s7sm9922364ejd.103.2020.09.15.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:41:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7EBCA1829CC; Tue, 15 Sep 2020 13:41:02 +0200 (CEST)
Subject: [PATCH bpf-next v5 5/8] bpf: Fix context type resolving for extension
 programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 15 Sep 2020 13:41:02 +0200
Message-ID: <160017006242.98230.15812695975228745782.stgit@toke.dk>
In-Reply-To: <160017005691.98230.13648200635390228683.stgit@toke.dk>
References: <160017005691.98230.13648200635390228683.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Eelco reported we can't properly access arguments if the tracing
program is attached to extension program.

Having following program:

  SEC("classifier/test_pkt_md_access")
  int test_pkt_md_access(struct __sk_buff *skb)

with its extension:

  SEC("freplace/test_pkt_md_access")
  int test_pkt_md_access_new(struct __sk_buff *skb)

and tracing that extension with:

  SEC("fentry/test_pkt_md_access_new")
  int BPF_PROG(fentry, struct sk_buff *skb)

It's not possible to access skb argument in the fentry program,
with following error from verifier:

  ; int BPF_PROG(fentry, struct sk_buff *skb)
  0: (79) r1 = *(u64 *)(r1 +0)
  invalid bpf_context access off=0 size=8

The problem is that btf_ctx_access gets the context type for the
traced program, which is in this case the extension.

But when we trace extension program, we want to get the context
type of the program that the extension is attached to, so we can
access the argument properly in the trace program.

This version of the patch is tweaked slightly from Jiri's original one,
since the refactoring in the previous patches means we have to get the
target prog type from the new variable in prog->aux instead of directly
from the target prog.

Reported-by: Eelco Chaudron <echaudro@redhat.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/btf.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9228af9917a8..55f7b2ba1cbd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3860,7 +3860,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 	info->reg_type = PTR_TO_BTF_ID;
 	if (tgt_prog) {
-		ret = btf_translate_to_vmlinux(log, btf, t, tgt_prog->type, arg);
+		enum bpf_prog_type tgt_type;
+
+		if (tgt_prog->type == BPF_PROG_TYPE_EXT)
+			tgt_type = tgt_prog->aux->tgt_prog_type;
+		else
+			tgt_type = tgt_prog->type;
+
+		ret = btf_translate_to_vmlinux(log, btf, t, tgt_type, arg);
 		if (ret > 0) {
 			info->btf_id = ret;
 			return true;

