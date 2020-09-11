Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74194265D40
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgIKKAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 06:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgIKJ7Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Sep 2020 05:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599818364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIRSjC4TU6Nemo+ZjQS/Vw28P2tbe5/t6vRROo8Kshk=;
        b=Shre3U2HbTXs2CX3oISEUhBZ2KCjqLZ/E4IpwsC55/CCscTZ6/17X98PILxfTV67Okk8V+
        aUCSt/oT/5vqnGYxOiY0chDRp1rvMJHmvNCbUe/dMdZ//jmcu8LDFCqXI5BOhHA/og/cN9
        Dzlmh21Nx0ftHMJJNowb8vgfXo0aKUU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-MnlErBmNNQ2WkutRHVsIng-1; Fri, 11 Sep 2020 05:59:22 -0400
X-MC-Unique: MnlErBmNNQ2WkutRHVsIng-1
Received: by mail-wm1-f72.google.com with SMTP id m25so764697wmi.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KIRSjC4TU6Nemo+ZjQS/Vw28P2tbe5/t6vRROo8Kshk=;
        b=Er3UZ9cwZpZ5BuA70Vgr0wlACPNOdnh4mqxIxQ5TH6LQx2xwku1OPjrSmHWUYl2Si8
         4qS70t7OybzNOVH8pZ/wTNcKTilPuyn0FdCN9x6ZBV4zBRaNa/gxlSwl5eWQjF/DGa0L
         MCzhm94DN1Kmxwepk2hYSjyvKJo6W7CP1t+MRugc8sLRLI7/RtWYrdWjyTLytOipNBaN
         aSyPCW25RMu7c02Tlx/RZOZSBklu8wuXR/0e5k2TIg3qf7AfBHtOKdDMwqxx3Kw7jnqM
         w+KsUfmEvSUKpsRVNdEXNtjSP7gMhhKvKesOAhCj69d613ezq/jzJ/ovE3qDMwU80s6o
         j0wA==
X-Gm-Message-State: AOAM53324pOSFuoWam1VVgy2D5cFQ/5jds3/uTvuSeO8wBgojpqAjKXU
        5vd1o7acJTh++stY/9/sR/nJ4w6Rk14BJS4nl4i7wdlsXDy6D5npICaoPBUA33+jNh+ZOd7CdcF
        F2yWfMzIyCryF
X-Received: by 2002:a5d:444e:: with SMTP id x14mr1179364wrr.235.1599818361528;
        Fri, 11 Sep 2020 02:59:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXFe5sOlpcXBuYc8QNoYUXthqLI0LwcWdDNJAXBo7Sa9+hblhHZIa4uIt/QDRHhvwVqfv1KQ==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr1179348wrr.235.1599818361267;
        Fri, 11 Sep 2020 02:59:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j135sm3553673wmj.20.2020.09.11.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:59:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 462481829D4; Fri, 11 Sep 2020 11:59:20 +0200 (CEST)
Subject: [PATCH RESEND bpf-next v3 5/9] bpf: Fix context type resolving for
 extension programs
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
Date:   Fri, 11 Sep 2020 11:59:20 +0200
Message-ID: <159981836017.134722.18148440504559677823.stgit@toke.dk>
In-Reply-To: <159981835466.134722.8652987144251743467.stgit@toke.dk>
References: <159981835466.134722.8652987144251743467.stgit@toke.dk>
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
index e10f13f8251c..1a48253ba168 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3863,7 +3863,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
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

