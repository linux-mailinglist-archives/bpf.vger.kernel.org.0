Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6386927936F
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgIYVZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 17:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729636AbgIYVZM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Sep 2020 17:25:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601069110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xdjze0+H0wQC0BCSe+88MMo64OYING8Jcj/dCM8lzrg=;
        b=XCo4khqCDqUtGloVJUNRlcIVI8l4JnKQCx+NhRA6jfY5kkDwMlne+pvzrmC0VCqT06KQW+
        gKYDgfiJpJRqhKiwmunkGyw30dLoYz74xy1Td0zo0znm0ZaVHvjhVOrTn2lm2lXmgXOgvS
        i0xVzrJh0+Ztt04reMfeStUdSvSIzw4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-1_id5fUWOzinSY4cn1mCeg-1; Fri, 25 Sep 2020 17:25:08 -0400
X-MC-Unique: 1_id5fUWOzinSY4cn1mCeg-1
Received: by mail-wr1-f72.google.com with SMTP id b7so1582586wrn.6
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 14:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Xdjze0+H0wQC0BCSe+88MMo64OYING8Jcj/dCM8lzrg=;
        b=R/I7OoE2wnPKsQ+iIQW2i20z1lrMt4Vm6+E5cuZe0NftTFJliF0JxWmzaqrUrs9dCg
         tR1on/AM7v1d2u80vR+mbNFkpTQMlkEaj/iHze7lcuzHdIXpCSjNeV8j4nc4TzT4xdrm
         oOQpnAJRQRmeR/mJ4KxU9mjTu17BNQnYzpNvxLWbSvYz1WAQcv3DzK4FxjjlPVao8tdC
         14ntzxF7+j4mpo26/PTxlvZWPQO9+zG2ELelcsvmOWY/ArlKQ8knqEBs7C116o4tSb4q
         5Z21zzTEuLZiUIYBzI8n75J6RRyvZVd6GwjUxWHdEFia81jhTZ9SEbJwT1m1yWlHDKOa
         qYgw==
X-Gm-Message-State: AOAM533lItfV8PJ9oXi/XlU+ioORinEzF+evAkyOu60weJFaWTGTJOQS
        YVm9GgVX02AdeirI3WCG7DTctt+K1EiGpeXtgsOsl1J/YgqsssdX3uCTzpptD3+Iq6d/mRvzb4L
        Ggrc5GtpMHLpd
X-Received: by 2002:a1c:23c9:: with SMTP id j192mr543416wmj.6.1601069107256;
        Fri, 25 Sep 2020 14:25:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTE6eSafLE/wLFeOCFGZbFLV7X+JAfR+vtVrBbMfmjnnDiUVxHjooj/WEA5NjC41jFkhS5HQ==
X-Received: by 2002:a1c:23c9:: with SMTP id j192mr543386wmj.6.1601069106826;
        Fri, 25 Sep 2020 14:25:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w7sm4120891wrm.92.2020.09.25.14.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:25:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E921C183C5B; Fri, 25 Sep 2020 23:25:05 +0200 (CEST)
Subject: [PATCH bpf-next v9 06/11] bpf: Fix context type resolving for
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
Date:   Fri, 25 Sep 2020 23:25:05 +0200
Message-ID: <160106910591.27725.1499697900366462609.stgit@toke.dk>
In-Reply-To: <160106909952.27725.8383447127582216829.stgit@toke.dk>
References: <160106909952.27725.8383447127582216829.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/btf.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index faf57c6f8804..7fd4757a573d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3860,7 +3860,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 	info->reg_type = PTR_TO_BTF_ID;
 	if (dst_prog) {
-		ret = btf_translate_to_vmlinux(log, btf, t, dst_prog->type, arg);
+		enum bpf_prog_type dst_type;
+
+		if (dst_prog->type == BPF_PROG_TYPE_EXT)
+			dst_type = dst_prog->aux->saved_dst_prog_type;
+		else
+			dst_type = dst_prog->type;
+
+		ret = btf_translate_to_vmlinux(log, btf, t, dst_type, arg);
 		if (ret > 0) {
 			info->btf_id = ret;
 			return true;

