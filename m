Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2687E10CC7C
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2019 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfK1QHk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Nov 2019 11:07:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbfK1QHh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Nov 2019 11:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574957255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+labIS8D1zO/EBrfo58WwyeK4b86yr4Ay45+sKAX7XA=;
        b=RmhGCgDvDhoesILDDUU6u0gVGBOfccL/QFDPzcL3el6VnFXSnUog4r9LFjZrSZxpRmR7UQ
        6Yi8anjH1Vn3jMLjmAxEEG/sA3iHEMmm2WUwLUcSBCv046QehvTsT03G0AQpWPl8bcH+H/
        XyOw8fRHhsZvamSy/litDuOfkpTCbd8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-QayNXzXOMpmx6-3-PkwnxA-1; Thu, 28 Nov 2019 11:07:31 -0500
Received: by mail-lj1-f198.google.com with SMTP id n11so5123621lji.9
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2019 08:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7L035tT9zykqVz7rUhyuDfOzoQMwHGJVTJTz8M7cNU=;
        b=iz9vVjmjoNbt5kFDZiE3odbW2786hqNhYV+IiImmtdZ6J2Acv6LwaagP9DUg3WPMvt
         OVOVIwrBwvvVGQoVXPK5m2I54umaQq/I5cP9aSGiCZzgd04+FdURuoi63Gzgvp2Xq2gy
         h3E8iWvRANBu9FcFgzfE4a+BFn+RdIpCwpAD0FoFtrhlGVzuJ/6qRiuge4EkMdd+vZKR
         cg9mVpone85hLie4fok5+XRydxf+oouJ8mzVyb5OnOlW+Clk0vpfqD8qgj4gR0D7Hsgn
         mAxabEmfqIX/O8eSxT37n/LCsMk4JygUSaUSYB3KxASDQy7uP6l3t2cMlbA+QZb1PBie
         COCA==
X-Gm-Message-State: APjAAAU1Yszc++F7tmn56a/jSwbnYkeNl474g1fSgSzWuieTxXP1Zzjw
        3IgSiDYueQrCjzTRiKMyCrs7a++dQZ+lFQAtTRyTIPRG4G4HgwjZGKVtOB1qnfR2rXqZJeBf+VV
        a28j7Ru00uwND
X-Received: by 2002:a2e:94d6:: with SMTP id r22mr34524938ljh.7.1574957250203;
        Thu, 28 Nov 2019 08:07:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJfSZr/Clsrrcc/gC5NElQhCN1vMNa6l6YoOgiWGNNGSFJcqbgQqbvCxN1lg2chuuA5mTwPA==
X-Received: by 2002:a2e:94d6:: with SMTP id r22mr34524914ljh.7.1574957249922;
        Thu, 28 Nov 2019 08:07:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q24sm8877350ljm.76.2019.11.28.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:07:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9229C180339; Thu, 28 Nov 2019 17:07:28 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf v3] bpftool: Allow to link libbpf dynamically
Date:   Thu, 28 Nov 2019 17:07:12 +0100
Message-Id: <20191128160712.1048793-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128145316.1044912-1-toke@redhat.com>
References: 
MIME-Version: 1.0
X-MC-Unique: QayNXzXOMpmx6-3-PkwnxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we support only static linking with kernel's libbpf
(tools/lib/bpf). This patch adds LIBBPF_DYNAMIC compile variable
that triggers libbpf detection and bpf dynamic linking:

  $ make -C tools/bpf/bpftool make LIBBPF_DYNAMIC=3D1

If libbpf is not installed, build (with LIBBPF_DYNAMIC=3D1) stops with:

  $ make -C tools/bpf/bpftool LIBBPF_DYNAMIC=3D1
    Auto-detecting system features:
    ...                        libbfd: [ on  ]
    ...        disassembler-four-args: [ on  ]
    ...                          zlib: [ on  ]
    ...                        libbpf: [ OFF ]

  Makefile:102: *** Error: No libbpf devel library found, please install li=
bbpf-devel or libbpf-dev.

Adding LIBBPF_DIR compile variable to allow linking with
libbpf installed into specific directory:

  $ make -C tools/lib/bpf/ prefix=3D/tmp/libbpf/ install_lib install_header=
s
  $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/tmp/libbpf/

It might be needed to clean build tree first because features
framework does not detect the change properly:

  $ make -C tools/build/feature clean
  $ make -C tools/bpf/bpftool/ clean

Since bpftool uses bits of libbpf that are not exported as public API in
the .so version, we also pass in libbpf.a to the linker, which allows it to
pick up the private functions from the static library without having to
expose them as ABI.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
v3:
  - Keep $(LIBBPF) in $LIBS, and just add -lbpf on top
  - Fix typo in error message
v2:
  - Pass .a file to linker when dynamically linking, so bpftool can use
    private functions from libbpf without exposing them as API.

 tools/bpf/bpftool/Makefile | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 39bc6f0f4f0b..15052dcaa39b 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
+# LIBBPF_DYNAMIC to enable libbpf dynamic linking.
+
 include ../../scripts/Makefile.include
 include ../../scripts/utilities.mak
+include ../../scripts/Makefile.arch
+
+ifeq ($(LP64), 1)
+  libdir_relative =3D lib64
+else
+  libdir_relative =3D lib
+endif
=20
 ifeq ($(srctree),)
 srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
@@ -63,6 +72,19 @@ RM ?=3D rm -f
 FEATURE_USER =3D .bpftool
 FEATURE_TESTS =3D libbfd disassembler-four-args reallocarray zlib
 FEATURE_DISPLAY =3D libbfd disassembler-four-args zlib
+ifdef LIBBPF_DYNAMIC
+  FEATURE_TESTS   +=3D libbpf
+  FEATURE_DISPLAY +=3D libbpf
+
+  # for linking with debug library run:
+  # make LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/opt/libbpf
+  ifdef LIBBPF_DIR
+    LIBBPF_CFLAGS  :=3D -I$(LIBBPF_DIR)/include
+    LIBBPF_LDFLAGS :=3D -L$(LIBBPF_DIR)/$(libdir_relative)
+    FEATURE_CHECK_CFLAGS-libbpf  :=3D $(LIBBPF_CFLAGS)
+    FEATURE_CHECK_LDFLAGS-libbpf :=3D $(LIBBPF_LDFLAGS)
+  endif
+endif
=20
 check_feat :=3D 1
 NON_CHECK_FEAT_TARGETS :=3D clean uninstall doc doc-clean doc-install doc-=
uninstall
@@ -88,6 +110,18 @@ ifeq ($(feature-reallocarray), 0)
 CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
 endif
=20
+ifdef LIBBPF_DYNAMIC
+  ifeq ($(feature-libbpf), 1)
+    # bpftool uses non-exported functions from libbpf, so just add the dyn=
amic
+    # version of libbpf and let the linker figure it out
+    LIBS    :=3D -lbpf $(LIBS)
+    CFLAGS  +=3D $(LIBBPF_CFLAGS)
+    LDFLAGS +=3D $(LIBBPF_LDFLAGS)
+  else
+    dummy :=3D $(error Error: No libbpf devel library found, please instal=
l libbpf-devel or libbpf-dev.)
+  endif
+endif
+
 include $(wildcard $(OUTPUT)*.d)
=20
 all: $(OUTPUT)bpftool
--=20
2.24.0

