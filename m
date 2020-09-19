Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911E2270DC9
	for <lists+bpf@lfdr.de>; Sat, 19 Sep 2020 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgISLuc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Sep 2020 07:50:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52522 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726485AbgISLu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Sep 2020 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600516224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIGbpCZmz89BH4RaSE1d8nNgeBGwQPZU+jdCtpvbXO4=;
        b=FS35Z1jf5utz+5WZIwfbsaq6nGxmMPKCv0NGSGUDp39L+STspSrqR+uhPuPdKGJ3sDgyMY
        K93wkYah2VDmZsI6NYCi/PVpCFQ+lkZp/ePcDfWD5/oPsgoUMxPYPL2EcvIDYtBXAi1Cqj
        wGiThEg8SDl79IOJ6Uiz8Nw4EhUEb3w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Y862p7oPNqq2hOMjxXc6Hw-1; Sat, 19 Sep 2020 07:50:22 -0400
X-MC-Unique: Y862p7oPNqq2hOMjxXc6Hw-1
Received: by mail-ej1-f71.google.com with SMTP id lx11so3132248ejb.19
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2020 04:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yIGbpCZmz89BH4RaSE1d8nNgeBGwQPZU+jdCtpvbXO4=;
        b=mqTsn7Rza/2587DXA6aefpdIEsO41vpixwPZofK5Mx6+eizQQQQPeGUIz4ngNlszq9
         HcFA4fvhC+rXYxRygwITYuK1uQh0pEqtW+jYjm6osKJhAxOQ5APUFP3uz5WiWRb325l5
         2PxRA+TlN6+/F4n83kI7Kj4oWB2I3JK9OhcU4oTkyp9j885nmb2gPZKxZuAJqmkY6ITM
         tVpO1xnW/pQLtiKh3GAIq6xCSPtPNh1ar1e7kE348CKmIpyWu7JCE/MovazF5R3bNu/G
         DFDn8DzmlHgSXr0s7eGMwO6Efu4owblYy4hX8d7gQ54CSTotw9mPRoGYwiOPba+n39kp
         MQEw==
X-Gm-Message-State: AOAM532tY34RFF38rJ0eoxIEhsc04BOBsXgA5FmAqTtkFPlm/3oIuSSx
        aMMSnguVbHi0htFHXFv3r9keGVpYYObmSK5+EZZSqg7NXSBPlYW7yoaWvQaunzXgakJX5sBfljD
        Rbn2SYneDi00k
X-Received: by 2002:a05:6402:305a:: with SMTP id bu26mr44288476edb.262.1600516220887;
        Sat, 19 Sep 2020 04:50:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXu9SgA6jH7jgPO8KXy43qt3jSBPXRyN/SoY7gKOTJLwloHGiljhs/6y9bqZtmO4FCVhiZbA==
X-Received: by 2002:a05:6402:305a:: with SMTP id bu26mr44288455edb.262.1600516220495;
        Sat, 19 Sep 2020 04:50:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gc19sm4219857ejb.106.2020.09.19.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 04:50:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A3780183A95; Sat, 19 Sep 2020 13:49:49 +0200 (CEST)
Subject: [PATCH bpf-next v7 06/10] bpf: Fix context type resolving for
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
Date:   Sat, 19 Sep 2020 13:49:49 +0200
Message-ID: <160051618958.58048.6126760401623211021.stgit@toke.dk>
In-Reply-To: <160051618267.58048.2336966160671014012.stgit@toke.dk>
References: <160051618267.58048.2336966160671014012.stgit@toke.dk>
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

