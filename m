Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD55929D7E5
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbgJ1W1m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 18:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733289AbgJ1W1d (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 18:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603924051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3C3SM+mTODeDpoZqXrRuy+dLn2cT9haezbBAbLVhV4=;
        b=M0QDX0c40fx9XLvhMyS1nM60RvSyg/9MAXcv41EvRmRIF71mAB5DDDhfMNcmDmmLp/3b9e
        yHQAD11vyl2smESUB8tXy7l3QZ7Km8izlKqJXt9rUjU+t0IV3zhT/PU+a65hU7oQDrn4GL
        A5vUfWwd/Fa+eL6Q1Q+2yBfDg0/oI2c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-pIcrX6XWPAKByTth5vXWJw-1; Wed, 28 Oct 2020 09:25:52 -0400
X-MC-Unique: pIcrX6XWPAKByTth5vXWJw-1
Received: by mail-pj1-f72.google.com with SMTP id bp7so2585762pjb.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 06:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3C3SM+mTODeDpoZqXrRuy+dLn2cT9haezbBAbLVhV4=;
        b=hIMKNFIFjtaA57Yn5cWpDYrFsQzoIFyCV7NNFyQK+sdktSG2q6bQUzYp9jhe2V2Ya/
         Cqc1ZMkVRoW3CO3uokwW7/xsBaodIZHWT/zxd/uAT6eauqYhPqxYQawr51tl88qf8SiK
         0WDsrp58oUphk1ImEzsNZjlTFxHy2NAca/U0NfsNK5y6oCnm7bqEOBDxJ45pP8Zcjj41
         UiIFTrwK24hEPKxaKELVNWI2JTDK7DL57UKjVFIl+AtaKrnZoO59GAkwtke2FzOqlnGG
         KCBfCTyPofxuFTQW7fUGZpRzd1flqvqXTvPV8d/SXVPozy5ai5axbpQT+BDTHrbObZR5
         a3/g==
X-Gm-Message-State: AOAM533UorCG7M1ehkgbuJdCNQqDn7PHyGu7pTNg8ZgXbUvp5O12WZL7
        VVkdHmBGTS+kCQIJchyYrFMtNq+NpBuwlt9+OEKfTSKxDNtR3I+JWnQk4wqSijcKyCqBb3hF1LW
        WXnhET2hNn7Q=
X-Received: by 2002:a63:e34e:: with SMTP id o14mr2981916pgj.346.1603891549936;
        Wed, 28 Oct 2020 06:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/PK76b2eGaNlxeNSUA51cw16WWFm9l0JQrjl8/wv7GEAT2h/MGYx3BNITB72kZx5M/I/8XQ==
X-Received: by 2002:a63:e34e:: with SMTP id o14mr2981886pgj.346.1603891549718;
        Wed, 28 Oct 2020 06:25:49 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20sm6055521pfk.199.2020.10.28.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:25:49 -0700 (PDT)
From:   Hangbin Liu <haliu@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Subject: [PATCHv2 iproute2-next 1/5] configure: add check_libbpf() for later libbpf support
Date:   Wed, 28 Oct 2020 21:25:25 +0800
Message-Id: <20201028132529.3763875-2-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201028132529.3763875-1-haliu@redhat.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201028132529.3763875-1-haliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a check to see if we support libbpf. By default the
system libbpf will be used, but static linking against a custom libbpf
version can be achieved by passing LIBBPF_DIR to configure. FORCE_LIBBPF
can be set to force configure to abort if no suitable libbpf is found,
which is useful for automatic packaging that wants to enforce the
dependency.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 configure | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/configure b/configure
index 307912aa..77f475d9 100755
--- a/configure
+++ b/configure
@@ -240,6 +240,51 @@ check_elf()
     fi
 }
 
+check_libbpf()
+{
+    if ${PKG_CONFIG} libbpf --exists || [ -n "$LIBBPF_DIR" ] ; then
+
+        if [ -n "$LIBBPF_DIR" ]; then
+            LIBBPF_CFLAGS="-I${LIBBPF_DIR}/include -L${LIBBPF_DIR}/lib64"
+            LIBBPF_LDLIBS="${LIBBPF_DIR}/lib64/libbpf.a -lz -lelf"
+        else
+            LIBBPF_CFLAGS=$(${PKG_CONFIG} libbpf --cflags)
+            LIBBPF_LDLIBS=$(${PKG_CONFIG} libbpf --libs)
+        fi
+
+        cat >$TMPDIR/libbpftest.c <<EOF
+#include <bpf/libbpf.h>
+int main(int argc, char **argv) {
+    void *ptr;
+    DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, .relaxed_maps = true, .pin_root_path = "/path");
+    (void) bpf_object__open_file("file", &opts);
+    (void) bpf_map__name(ptr);
+    (void) bpf_map__ifindex(ptr);
+    (void) bpf_map__reuse_fd(ptr, 0);
+    (void) bpf_map__pin(ptr, "/path");
+    return 0;
+}
+EOF
+
+        if $CC -o $TMPDIR/libbpftest $TMPDIR/libbpftest.c $LIBBPF_CFLAGS -lbpf 2>&1; then
+            echo "HAVE_LIBBPF:=y" >>$CONFIG
+            echo 'CFLAGS += -DHAVE_LIBBPF ' $LIBBPF_CFLAGS >> $CONFIG
+            echo 'LDLIBS += ' $LIBBPF_LDLIBS >>$CONFIG
+            echo "yes"
+            return 0
+        fi
+    fi
+
+    echo "no"
+
+    # if set FORCE_LIBBPF but no libbpf support, just exist the config
+    # process to make sure we don't build without libbpf.
+    if [ -n "$FORCE_LIBBPF" ]; then
+	    echo "FORCE_LIBBPF set, but couldn't find a usable libbpf"
+	    exit 1
+    fi
+}
+
 check_selinux()
 # SELinux is a compile time option in the ss utility
 {
@@ -385,6 +430,9 @@ check_setns
 echo -n "SELinux support: "
 check_selinux
 
+echo -n "libbpf support: "
+check_libbpf
+
 echo -n "ELF support: "
 check_elf
 
-- 
2.25.4

