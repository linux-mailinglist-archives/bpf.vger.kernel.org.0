Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697C4118F91
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 19:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLJSPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 13:15:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727757AbfLJSPb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 13:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576001730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ftqvNo8ypX13fdqkDhRy1P9Zlg2BDYcnsvRebm2MCU=;
        b=gLa2KI3OC/kPvKvWWhzoGux8LnogbeTNc0dQg4EmoNgtOPVRs1mpQTNY0qbq2QvqvNQk3G
        pNDxP1H34h7remTnsIG2JWcqG8YzZpAMNF5B4HfQoGWJs6CgnlGc9JxUPW1SzvuAUQ+K//
        tUJzylaSkvLtZ6SZfd17bzeVOK/TKAw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-0F29RvqZMGCDiKzs5_ICJA-1; Tue, 10 Dec 2019 13:15:27 -0500
Received: by mail-lf1-f70.google.com with SMTP id f22so3332674lfh.4
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 10:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qaJ0iPUZiPGrRKD6KWzbbPQ9tBJQ6ZNwk2N/6zRMJM=;
        b=B+ENGYOik1vy8ZYwUGEZA0v/rzZbpMM9vlapAfwP/2rKisV/j8eZPGT6HFDaj9MVwW
         HvGYKK7Fdk9u0RwXOrwKQkqkjZdoYqHAy3CmOhFwOHASSgm6noL82zdysD2GnbownV5i
         +Kaxm9nlrSSLB232dqNxIPIfkOy4r3b/0Vo41KOR4c6LHX4nZJt9JMgx4oc7tXGnZQVw
         90bS9o5cDACrjT9DUwLC+0CO5XwXocCj9/uYx/2eErVGgdRNkTkhZQLEqct/unP8VFx6
         wuFvo4BHENOogGwNQVRVLMWGvKur+2oEaueZuwsVCsToWk8a22uz9bU1snH+F14LP2D5
         +sqA==
X-Gm-Message-State: APjAAAXLRNTAGW3dhzq7CLe6xwV1xm6s3edsCtSjtjxSxMEosLDcwneV
        Ah3YuMuTjffKgb+fBqGRxssxYPjQKz3e0oNlS/ZSfsqm4WkSmekXa4S0GwQjrRz2DRvxk/fHzBs
        49lZX8JPFOefN
X-Received: by 2002:ac2:4436:: with SMTP id w22mr19862847lfl.185.1576001725608;
        Tue, 10 Dec 2019 10:15:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrZAMkKrVX2Pa/3z0mzalv4YSJ1qSkcLpsPezdGIOVxK4wQI2LAemEsfEq3IDhQEOyoph9fw==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr19862840lfl.185.1576001725439;
        Tue, 10 Dec 2019 10:15:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b63sm1618343lfg.79.2019.12.10.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:15:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE1FA181AC8; Tue, 10 Dec 2019 19:15:23 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf v2] bpftool: Don't crash on missing jited insns or ksyms
Date:   Tue, 10 Dec 2019 19:14:12 +0100
Message-Id: <20191210181412.151226-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: 0F29RvqZMGCDiKzs5_ICJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the kptr_restrict sysctl is set, the kernel can fail to return
jited_ksyms or jited_prog_insns, but still have positive values in
nr_jited_ksyms and jited_prog_len. This causes bpftool to crash when trying
to dump the program because it only checks the len fields not the actual
pointers to the instructions and ksyms.

Fix this by adding the missing checks.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
v2:
  - The sysctl causing this is kptr_restrict, not bpf_jit_harden; update co=
mmit
    msg to get this right (Martin).

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

