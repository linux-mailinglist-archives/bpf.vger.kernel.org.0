Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D0A27CDB4
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgI2MqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 08:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387503AbgI2MqG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 08:46:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601383564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nneNQXug1AmXlFY8BQ86fIMPd4vSghG2g/V1b4Wro3s=;
        b=BzC7CmSjGYdcJLJFa/QoFHm2hp5d+1gE3z50BiXb42ms5NFecYI1W6uR6VJ9M928tj/Gio
        fOa99W49Fn9KZSO8TWq1uMH2CPIKM0vzer87dngdu74snPZUo9WYCAGthXLZ3rjEQZLc/M
        Wzs1IjFpGdVhvWkFWnWgCTtC/q+dF8Y=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68--nnwUkQRMG2FeeFTNcqSrw-1; Tue, 29 Sep 2020 08:46:03 -0400
X-MC-Unique: -nnwUkQRMG2FeeFTNcqSrw-1
Received: by mail-oi1-f199.google.com with SMTP id a143so1562658oib.14
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 05:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nneNQXug1AmXlFY8BQ86fIMPd4vSghG2g/V1b4Wro3s=;
        b=MnBZGJ8CJv0sEuf7HpeEJ04Ejkg/H8xbjcMlTPNMRxcTh86YAUSSyjEVhZdCR1EAjz
         I1KhA8ZyXD6cEamprKQsd8zxheMip/YcuocDWKFvUXa2XKzzlhzxovEu8g2ko8PuFzfJ
         c2YtfCrAAz/Z7ZUSuaRcecdnhpzev0sRkUSSzImfvQxTvVDyjm1cC6hcjCjWjT6WyAx4
         TJFG5uFhwY1IzyWbvLHQko0pSzHIvA+dyKhq66l0ik4p1tIEjxs9pSaDCNGODojVLh4K
         +ryHwFvZa2WKFKwpOyvCteQPFZ1A9FwTkO+2r4Tc0pnBFWEVOpxjs/vJRCSZigfkS4wU
         IEwg==
X-Gm-Message-State: AOAM530/amw9aoO7uALGpOy0JehW0FSYtV5nQH5loeb8shzzSYPNXntL
        ShWYV6kaxHzFOv8AIIcaQpmcLVqzb1T0l9wwil/RA7d9j1OYRVe4bOW7HPttqQzG6CaVqjapbFd
        6/CKuadUbit6v
X-Received: by 2002:a05:6830:2096:: with SMTP id y22mr2664450otq.158.1601383557049;
        Tue, 29 Sep 2020 05:45:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztMDEwLpRQfY2JKWPLy52gemqcQHpYHTXQGIijJbdpay5BjjGBDHOS6X6VPep3e844G60xJw==
X-Received: by 2002:a05:6830:2096:: with SMTP id y22mr2664419otq.158.1601383556699;
        Tue, 29 Sep 2020 05:45:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m14sm2860523oov.37.2020.09.29.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 05:45:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D5E67183C5F; Tue, 29 Sep 2020 14:45:52 +0200 (CEST)
Subject: [PATCH bpf-next v10 3/7] bpf: Fix context type resolving for
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
Date:   Tue, 29 Sep 2020 14:45:52 +0200
Message-ID: <160138355278.48470.17057040257274725638.stgit@toke.dk>
In-Reply-To: <160138354947.48470.11523413403103182788.stgit@toke.dk>
References: <160138354947.48470.11523413403103182788.stgit@toke.dk>
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
index 05816471bac6..4d0ee7839fdb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4582,7 +4582,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 	info->reg_type = PTR_TO_BTF_ID;
 	if (tgt_prog) {
-		ret = btf_translate_to_vmlinux(log, btf, t, tgt_prog->type, arg);
+		enum bpf_prog_type tgt_type;
+
+		if (tgt_prog->type == BPF_PROG_TYPE_EXT)
+			tgt_type = tgt_prog->aux->saved_dst_prog_type;
+		else
+			tgt_type = tgt_prog->type;
+
+		ret = btf_translate_to_vmlinux(log, btf, t, tgt_type, arg);
 		if (ret > 0) {
 			info->btf_id = ret;
 			return true;

