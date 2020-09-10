Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7E2653B1
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgIJVj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:39:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730615AbgIJNKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 09:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599743399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIRSjC4TU6Nemo+ZjQS/Vw28P2tbe5/t6vRROo8Kshk=;
        b=AxIEn1+h1mNtDeJ7cVz6itkN2avXai3wMisFwi1X5jCvyhuMgvVEmbXTkog3P7CAXU91Sj
        C3NcLgJhaXpMyPjnaqIoYUsto/WC0N+/ESS/DnBs7EUPFht/E25VcgDjO60xwFaFWPXZQT
        cqbJHihYYKhRLyDCsZ+PI+9xCPRmWgM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-x4Ow6CVHPAi4U4XYDwjYLg-1; Thu, 10 Sep 2020 09:09:58 -0400
X-MC-Unique: x4Ow6CVHPAi4U4XYDwjYLg-1
Received: by mail-wr1-f71.google.com with SMTP id l9so2222229wrq.20
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 06:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KIRSjC4TU6Nemo+ZjQS/Vw28P2tbe5/t6vRROo8Kshk=;
        b=alZ3UUu4x+sWUy7uGc+OegVi7LI+cjf9nAYQUfWSoP1G5h8WCJzbm1GTczMPwo1dEg
         zqhBfh8+rsMdzvPRWniP8cf4UTmU65y8HGHmvfX8cDmzAoBVxaJk+ec5zvy6Ri7aohOr
         VztADowIusd26va2zJDsSeU1RjYnTqomdYaalgjiJNo8gWt+CJEzqE13EidiPM/hRHOo
         TO0lkLdGidswipctURDi8LtgW28q46pDxiuCTat0WBTWR3nRCZu0Ru0xqcwYBx7QJtzw
         gE216vM6BpBPRptYw6sVtOlAzk7sea761AoTjFVFUBjV3xL7kBkz+h6EL3yZSLvwNqi6
         lH8Q==
X-Gm-Message-State: AOAM532sV0AD+UnDpeGvpzxr4YKlR7HEgqN5fxiY4rIY/5tJZh/bNVMm
        qhVWsPMu8MmTUkw52kiF2SdVLTuy3VmQzdi5Tl9Y5NKWB99T4Z9rV4voMxKAPkto30SxCHMevzG
        q0mCUtYkX+HU7
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr8953114wrt.155.1599743396420;
        Thu, 10 Sep 2020 06:09:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaJQkuAcK5LP0R+Fk0JDjpDlHUxygUj/NTkx3QJ7H6UAmH6M0LuyJkDal5Yj4UIwPPtb109g==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr8953081wrt.155.1599743396088;
        Thu, 10 Sep 2020 06:09:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m1sm3773204wmc.28.2020.09.10.06.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:09:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 083A91829D4; Thu, 10 Sep 2020 15:09:55 +0200 (CEST)
Subject: [PATCH bpf-next v3 5/9] bpf: Fix context type resolving for extension
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
Date:   Thu, 10 Sep 2020 15:09:54 +0200
Message-ID: <159974339494.129227.6914052212273752713.stgit@toke.dk>
In-Reply-To: <159974338947.129227.5610774877906475683.stgit@toke.dk>
References: <159974338947.129227.5610774877906475683.stgit@toke.dk>
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

