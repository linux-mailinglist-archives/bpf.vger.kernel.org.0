Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02C29EF5A
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgJ2PMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 11:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgJ2PMS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 11:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603984336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yXg8GBRC3KQm8TIwzNWSAA5c5aI10yuXVMvwbMl8jQ=;
        b=PtmgW5uLCeaADTkkTIyMogzuEyBVZHZv9Bl1l69+17gkIqNK/Fdl49Od6Zp26f98jhygwr
        Cz/J75pFC7+LXn9SWditwnS0Fv7dhDpCAiNNUy7LLV/7O92y8VPXjsd0XJVIoTx4jlH8fO
        imQDQdYDiLa3bNQz7Lb9N6bfo+cKEJk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-9OcX4g_jMLicE_qnpM9t6w-1; Thu, 29 Oct 2020 11:12:14 -0400
X-MC-Unique: 9OcX4g_jMLicE_qnpM9t6w-1
Received: by mail-pg1-f197.google.com with SMTP id 33so2324621pgt.9
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 08:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yXg8GBRC3KQm8TIwzNWSAA5c5aI10yuXVMvwbMl8jQ=;
        b=j25nB97HgVDVyQqZijSmSSV/wSqXYduYbd1UDzZSsgi7RAfB2vmMP/GAYEq1iz9gr9
         nCEn1F5qQphO/6gWHvpsSsm0gK481dCTHjU9TKi0vRH4RTeIUuvnpgOQHNfeaw7yz8nS
         pS5ac8q5edMNb/mRLLhHz+SfHWWWpHUT3g/5V+cXG+tUgLrcvgO3RqPlQPSB53c308+7
         e1qzFq96dxP8a7ZrOc/7/9rAoFEBTiVuXfrghnsCldlhLhYwt+fmYmz9dEriMiRBrRMV
         KSqkqnr0XYXzbORnanAEjpOWc4XGEub6vHxvY5Tce3A6i4VOBz6+L3Z3a8hOxFrHkn4V
         h7fw==
X-Gm-Message-State: AOAM530oe0AHt2w4AsHPNSGExzd+7k/dJXp8luEC6ZQoTHSXCtVqd9uA
        vW+p2NKcfH9NM5Tzsyelp1YpX0J+3TxJSy4Aaj+JIkXtaVtOojpYP7sUIaOtrG6SDMWuFaH3e1G
        jsNPrflTN8hQ=
X-Received: by 2002:a17:902:82c8:b029:d5:af76:e447 with SMTP id u8-20020a17090282c8b02900d5af76e447mr4522650plz.42.1603984333260;
        Thu, 29 Oct 2020 08:12:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwraKY2zYjg/36Q/sRro4/67gXgpcUIi2epbNWb6q9PHHSU54xissIzzblfsvoCuCO8XJVZCw==
X-Received: by 2002:a17:902:82c8:b029:d5:af76:e447 with SMTP id u8-20020a17090282c8b02900d5af76e447mr4522624plz.42.1603984333014;
        Thu, 29 Oct 2020 08:12:13 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 3sm3305435pfv.92.2020.10.29.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:12:12 -0700 (PDT)
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
Subject: [PATCHv3 iproute2-next 1/5] configure: add check_libbpf() for later libbpf support
Date:   Thu, 29 Oct 2020 23:11:42 +0800
Message-Id: <20201029151146.3810859-2-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201029151146.3810859-1-haliu@redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
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

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
v3:
Check function bpf_program__section_name() separately and only use it
on higher libbpf version.

v2:
No update
---
 configure | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/configure b/configure
index 307912aa..58a7176e 100755
--- a/configure
+++ b/configure
@@ -240,6 +240,97 @@ check_elf()
     fi
 }
 
+have_libbpf_basic()
+{
+    cat >$TMPDIR/libbpf_test.c <<EOF
+#include <bpf/libbpf.h>
+int main(int argc, char **argv) {
+    bpf_program__set_autoload(NULL, false);
+    bpf_map__ifindex(NULL);
+    bpf_map__set_pin_path(NULL, NULL);
+    bpf_object__open_file(NULL, NULL);
+    return 0;
+}
+EOF
+
+    $CC -o $TMPDIR/libbpf_test $TMPDIR/libbpf_test.c $LIBBPF_CFLAGS $LIBBPF_LDLIBS >/dev/null 2>&1
+    local ret=$?
+
+    rm -f $TMPDIR/libbpf_test.c $TMPDIR/libbpf_test
+    return $ret
+}
+
+have_libbpf_sec_name()
+{
+    cat >$TMPDIR/libbpf_sec_test.c <<EOF
+#include <bpf/libbpf.h>
+int main(int argc, char **argv) {
+    void *ptr;
+    bpf_program__section_name(NULL);
+    return 0;
+}
+EOF
+
+    $CC -o $TMPDIR/libbpf_sec_test $TMPDIR/libbpf_sec_test.c $LIBBPF_CFLAGS $LIBBPF_LDLIBS >/dev/null 2>&1
+    local ret=$?
+
+    rm -f $TMPDIR/libbpf_sec_test.c $TMPDIR/libbpf_sec_test
+    return $ret
+}
+
+check_force_libbpf()
+{
+    # if set FORCE_LIBBPF but no libbpf support, just exist the config
+    # process to make sure we don't build without libbpf.
+    if [ -n "$FORCE_LIBBPF" ]; then
+        echo "FORCE_LIBBPF set, but couldn't find a usable libbpf"
+        exit 1
+    fi
+}
+
+check_libbpf()
+{
+    if ! ${PKG_CONFIG} libbpf --exists && [ -z "$LIBBPF_DIR" ] ; then
+        echo "no"
+        check_force_libbpf
+        return
+    fi
+
+    if [ $(uname -m) == x86_64 ]; then
+        local LIBSUBDIR=lib64
+    else
+        local LIBSUBDIR=lib
+    fi
+
+    if [ -n "$LIBBPF_DIR" ]; then
+        LIBBPF_CFLAGS="-I${LIBBPF_DIR}/include -L${LIBBPF_DIR}/${LIBSUBDIR}"
+        LIBBPF_LDLIBS="${LIBBPF_DIR}/${LIBSUBDIR}/libbpf.a -lz -lelf"
+    else
+        LIBBPF_CFLAGS=$(${PKG_CONFIG} libbpf --cflags)
+        LIBBPF_LDLIBS=$(${PKG_CONFIG} libbpf --libs)
+    fi
+
+    if ! have_libbpf_basic; then
+        echo "no"
+        echo "	libbpf version is too low, please update it to at least 0.1.0"
+        check_force_libbpf
+        return
+    else
+        echo "HAVE_LIBBPF:=y" >>$CONFIG
+        echo 'CFLAGS += -DHAVE_LIBBPF ' $LIBBPF_CFLAGS >> $CONFIG
+        echo 'LDLIBS += ' $LIBBPF_LDLIBS >>$CONFIG
+    fi
+
+    # bpf_program__title() is deprecated since libbpf 0.2.0, use
+    # bpf_program__section_name() instead if we support
+    if have_libbpf_sec_name; then
+        echo "HAVE_LIBBPF_SECTION_NAME:=y" >>$CONFIG
+        echo 'CFLAGS += -DHAVE_LIBBPF_SECTION_NAME ' $LIBBPF_CFLAGS >> $CONFIG
+    fi
+
+    echo "yes"
+}
+
 check_selinux()
 # SELinux is a compile time option in the ss utility
 {
@@ -385,6 +476,9 @@ check_setns
 echo -n "SELinux support: "
 check_selinux
 
+echo -n "libbpf support: "
+check_libbpf
+
 echo -n "ELF support: "
 check_elf
 
-- 
2.25.4

