Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426322968D8
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 05:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374950AbgJWDjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Oct 2020 23:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S374886AbgJWDjX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Oct 2020 23:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603424363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3C3SM+mTODeDpoZqXrRuy+dLn2cT9haezbBAbLVhV4=;
        b=ZxW0+OMaAjRRqZpXwm1DTALDm653bAh6eEnLuXZML3DgCxS4xBkec4K0sB5uMBfm2Q1W9R
        XPk070Lv6XKnC3womDZaskktbdIh63JvFoub9oXXVrvrV1O77oisZHfOordMiwGqLn28SD
        BAk1p2YkTFZztzIgbMnuCVodXZFW1fs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-AEXQAsT_PRiSYr47s74jNA-1; Thu, 22 Oct 2020 23:39:21 -0400
X-MC-Unique: AEXQAsT_PRiSYr47s74jNA-1
Received: by mail-pf1-f197.google.com with SMTP id u24so26530pfh.4
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2020 20:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3C3SM+mTODeDpoZqXrRuy+dLn2cT9haezbBAbLVhV4=;
        b=iVLTB6BBB2/65lOASMUyfUJY7Io1k/n7sO4q2+0dJ/bYSuCfA7w1vFTbZzDURzbgPB
         0nfSEBceUonSLaJS4TGCua0wuUZOqZeJg/gps76/WK45RgzHTODXLb5xXPcM9S6hn7gx
         uIMzwx7eCq6L4xZz4ohxgfvTyvp9nrDY6xuc1zmFJDCOHPPH1tgkUTtq6VIvs2WWiIHK
         Fmt7vryb8lsqSyM2/zGkb5hHOrKF8y+nZLpcbC5gJJ9XcNMHkvZjTfoqCyEITPDugAmq
         5v+H/F6qUbTJrGngND6F9zTrVKQUGv5KDeJm/40VR+UkXFoS6iLSVMOInQWyzB4GxAqN
         pxmw==
X-Gm-Message-State: AOAM533UT6p6rDgriYQ3VLDQ3gEv19syZRPBv2Nm+cGbhaCaRQWyxAv9
        t9k4krNlPNNTvUnw2hxpPJH3SdnGvDVKanr6y7CQIJAY/+7w9Bmcd1w1TwBBwHABFW45ZQztqWY
        z/QX1Eo4gBD4=
X-Received: by 2002:a17:902:7102:b029:d3:ef48:e51e with SMTP id a2-20020a1709027102b02900d3ef48e51emr381258pll.72.1603424360479;
        Thu, 22 Oct 2020 20:39:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQDklxYjdiPoiDKucBCtpdVJp7y3DdzO7/hWtma/5zMPURfCb/2pQ1Ulp7RYDQXxssh+BnTA==
X-Received: by 2002:a17:902:7102:b029:d3:ef48:e51e with SMTP id a2-20020a1709027102b02900d3ef48e51emr381242pll.72.1603424360239;
        Thu, 22 Oct 2020 20:39:20 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e23sm185442pfi.191.2020.10.22.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 20:39:19 -0700 (PDT)
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
Subject: [PATCH iproute2-next 1/5] configure: add check_libbpf() for later libbpf support
Date:   Fri, 23 Oct 2020 11:38:51 +0800
Message-Id: <20201023033855.3894509-2-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201023033855.3894509-1-haliu@redhat.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
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

