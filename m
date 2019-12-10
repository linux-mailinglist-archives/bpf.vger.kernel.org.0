Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1EB118ADF
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJObK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 09:31:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30774 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfLJObK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 09:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575988268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=huNWTawb+BzW4Y59E1UWx3k52jbIXd0hQSz50hy5O4I=;
        b=hoyCv7NsCrTizX0u+4QQRtdYXcg+2JWvEPRfo13PXNChhtPCLwAut1G7PPZlJrQuCQdzsK
        7+qRxepaRCY8kgiKjTpMkXK/ZxaGp87w3h6+8x/DhUxV4Xw7QH3BtmGUduWLvP43IWR1Sh
        yBRftG8f15HbXxbZ4Q0vYUgbL1hE9lA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-EYRjm9HYNomENAZv8-9efw-1; Tue, 10 Dec 2019 09:31:05 -0500
Received: by mail-lj1-f200.google.com with SMTP id j22so3647185lja.20
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 06:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iog97vb7UE8EJV6SLzpptV2/d5Gnn074vofpjb5er8U=;
        b=XaJmVVYiAI4o0YBHNTX1LwS03gMr7Cfzs3iiBZ40rpejei6Z8OqWfxaaIAWDr+kPq7
         BOTdHBwH9+1G/QySoNhUFJw83gY5goRE5302mSmyURzc6EdpAraJR5tnpx39rMKkPan8
         UYtZuy59E9ACfrEJV2lW7ZKDuBbVX8JjMz/+9CqMKGc/eGjucpShw0pDxGz1octjq5Gg
         Y7f0FI7gLQnMOnNesrnpzraKj9NBlFH6KoY246w+6/oUjKYOwMywMy8TN+ISJCE6NiF2
         Y1x+VIUm2dSn0BFiREG4MkOp/M9j1ifX25Wx9rsaKsWEPocAJLKskqCvWPz7FPKdjcqv
         +YZg==
X-Gm-Message-State: APjAAAXqWv7rZ8G+2Rq0izVoVRfSI8LCKj5/8lM4r8lD1YeICcpvDiHt
        mDN5KFnthMggZpqAR/rF8iZT+Gkyu0pthWRQSKdALrkj2n59jZrr1eiK2VWeVRMfZdey+b/eO4R
        e5m1J1Q+tzlXD
X-Received: by 2002:ac2:5287:: with SMTP id q7mr11942102lfm.66.1575988264149;
        Tue, 10 Dec 2019 06:31:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVqsvLkTJ2noEGSfdHt3lybF4HPTE2NrQeBlidKwZ8pjcwGqiRTy0mkQRgWp+fWlQNIq+R9A==
X-Received: by 2002:ac2:5287:: with SMTP id q7mr11942091lfm.66.1575988263997;
        Tue, 10 Dec 2019 06:31:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e20sm1850036ljl.59.2019.12.10.06.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:31:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 76651181AC8; Tue, 10 Dec 2019 15:31:01 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf] bpftool: Don't crash on missing jited insns or ksyms
Date:   Tue, 10 Dec 2019 15:30:47 +0100
Message-Id: <20191210143047.142347-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: EYRjm9HYNomENAZv8-9efw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When JIT hardening is turned on, the kernel can fail to return jited_ksyms
or jited_prog_insns, but still have positive values in nr_jited_ksyms and
jited_prog_len. This causes bpftool to crash when trying to dump the
program because it only checks the len fields not the actual pointers to
the instructions and ksyms.

Fix this by adding the missing checks.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c          | 2 +-
 tools/bpf/bpftool/xlated_dumper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 4535c863d2cd..2ce9c5ba1934 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -493,7 +493,7 @@ static int do_dump(int argc, char **argv)
=20
 =09info =3D &info_linear->info;
 =09if (mode =3D=3D DUMP_JITED) {
-=09=09if (info->jited_prog_len =3D=3D 0) {
+=09=09if (info->jited_prog_len =3D=3D 0 || !info->jited_prog_insns) {
 =09=09=09p_info("no instructions returned");
 =09=09=09goto err_free;
 =09=09}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_d=
umper.c
index 494d7ae3614d..5b91ee65a080 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -174,7 +174,7 @@ static const char *print_call(void *private_data,
 =09struct kernel_sym *sym;
=20
 =09if (insn->src_reg =3D=3D BPF_PSEUDO_CALL &&
-=09    (__u32) insn->imm < dd->nr_jited_ksyms)
+=09    (__u32) insn->imm < dd->nr_jited_ksyms && dd->jited_ksyms)
 =09=09address =3D dd->jited_ksyms[insn->imm];
=20
 =09sym =3D kernel_syms_search(dd, address);
--=20
2.24.0

