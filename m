Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054272B3D5C
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 07:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgKPGxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 01:53:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbgKPGxr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 01:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605509625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkLPf2AEOhVOZlO9cgrNsBmby/+0L7S8jCp57tH6JJY=;
        b=HOjFzCqmojOgsA8g9zBANkShbds6H2C6wnlTwKYMqY6kiFR9KCEerPk+bjhWsBh5FcZunq
        RtyiZUgsdJVvqvRTMDdmPjeRNsDNum8Y4IRCubA3JdQTTmnjiMQdeEXK700Wou99MLyH38
        9YqgPLW4z81cZF80roNY2cOkkspD3U8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-IwwlogHlM7Shwcqi1lUS8g-1; Mon, 16 Nov 2020 01:53:43 -0500
X-MC-Unique: IwwlogHlM7Shwcqi1lUS8g-1
Received: by mail-pg1-f200.google.com with SMTP id p21so1891369pgb.11
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2020 22:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkLPf2AEOhVOZlO9cgrNsBmby/+0L7S8jCp57tH6JJY=;
        b=tQDU+SoWtr6eR2EkE1QNan6UTYZKw/ASJY2LWZU6Ns9XoUkqBXpmLQ9JNERtJJ9TW5
         wQZIgz4EtTMslrLIbXaZdCSwKpx0C1CuB+RiYJWhmXeZfe+HoCpQWr9bz4uSuTx8Uci8
         1dhRQXXJtVZSX6ie6rbpSuhAOQQhgkTzf4PnGXWpwyQfeuvdZIFrqbbNEdNLnDAY9s9Y
         XbCH9cdq1r5J5280OvlyVGfc4qS3hHXQTrrgy7hKZIM9ZYISk8Wr1Hk8B0oMrPNMUmRQ
         UXlMTNcG4EiOqwYeXVGLBkXj1+eV5YrmsnLBB27nDLuUq/qBYYsrACUsn2tJgEIAV6PC
         cVjg==
X-Gm-Message-State: AOAM5336b7K2+56yrJTq/2q83Wia2Q0p6dlsALJ6j9rrZ3DxEnP7Vtwk
        r9uY+SfP7/14TXK7fitqrM55aLvAkl+KWgCO7H00yBynAbyvg1gkgm+m9y2+47T8bKSBqXkoRet
        /9JkvS2nma9c=
X-Received: by 2002:a17:90a:154a:: with SMTP id y10mr13682069pja.6.1605509621707;
        Sun, 15 Nov 2020 22:53:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaXTHSWhZ7qw2lhA9wIHbz+w4JrEy9LaIN4wkBl9Q086mgYWKhCyALJV27chhcvgY1b2ALDg==
X-Received: by 2002:a17:90a:154a:: with SMTP id y10mr13682051pja.6.1605509621493;
        Sun, 15 Nov 2020 22:53:41 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 16sm18645837pjf.36.2020.11.15.22.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:53:40 -0800 (PST)
From:   Hangbin Liu <haliu@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Subject: [PATCHv5 iproute2-next 1/5] configure: add check_libbpf() for later libbpf support
Date:   Mon, 16 Nov 2020 14:53:01 +0800
Message-Id: <20201116065305.1010651-2-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201116065305.1010651-1-haliu@redhat.com>
References: <20201109070802.3638167-1-haliu@redhat.com>
 <20201116065305.1010651-1-haliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a check to see if we have libbpf support. By default the
system libbpf will be used, but static linking against a custom libbpf
version can be achieved by passing libbpf DESTDIR to variable LIBBPF_DIR for
configure.

Add another variable LIBBPF_FORCE to control whether to build iproute2
with libbpf. If set to on, then force to build with libbpf and exit if
not available. If set to off, then force to not build with libbpf.

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
v5:
1) Fix LIBBPF_DIR typo and description, use libbpf DESTDIR as LIBBPF_DIR
   dest.

v4:
1) Remove duplicate LIBBPF_CFLAGS
2) Remove un-needed -L since using static libbpf.a
3) Fix == not supported in dash
4) Extend LIBBPF_FORCE to support on/off, when set to on, stop building when
   there is no libbpf support. If set to off, discard libbpf check.
5) Print libbpf version after checking

v3:
Check function bpf_program__section_name() separately and only use it
on higher libbpf version.

v2:
No update
---
 configure | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/configure b/configure
index 307912aa..290b4c86 100755
--- a/configure
+++ b/configure
@@ -2,6 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # This is not an autoconf generated configure
 #
+# Influential LIBBPF environment variables:
+#   LIBBPF_FORCE={on,off}   on: require link against libbpf;
+#                           off: disable libbpf probing
+#   LIBBPF_DIR              Path to libbpf DESTDIR to use
+
 INCLUDE=${1:-"$PWD/include"}
 
 # Output file which is input to Makefile
@@ -240,6 +245,106 @@ check_elf()
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
+check_force_libbpf_on()
+{
+    # if set LIBBPF_FORCE=on but no libbpf support, just exist the config
+    # process to make sure we don't build without libbpf.
+    if [ "$LIBBPF_FORCE" = on ]; then
+        echo "	LIBBPF_FORCE=on set, but couldn't find a usable libbpf"
+        exit 1
+    fi
+}
+
+check_libbpf()
+{
+    # if set LIBBPF_FORCE=off, disable libbpf entirely
+    if [ "$LIBBPF_FORCE" = off ]; then
+        echo "no"
+        return
+    fi
+
+    if ! ${PKG_CONFIG} libbpf --exists && [ -z "$LIBBPF_DIR" ] ; then
+        echo "no"
+        check_force_libbpf_on
+        return
+    fi
+
+    if [ $(uname -m) = x86_64 ]; then
+        local LIBBPF_LIBDIR="${LIBBPF_DIR}/usr/lib64"
+    else
+        local LIBBPF_LIBDIR="${LIBBPF_DIR}/usr/lib"
+    fi
+
+    if [ -n "$LIBBPF_DIR" ]; then
+        LIBBPF_CFLAGS="-I${LIBBPF_DIR}/usr/include"
+        LIBBPF_LDLIBS="${LIBBPF_LIBDIR}/libbpf.a -lz -lelf"
+        LIBBPF_VERSION=$(PKG_CONFIG_LIBDIR=${LIBBPF_LIBDIR}/pkgconfig ${PKG_CONFIG} libbpf --modversion)
+    else
+        LIBBPF_CFLAGS=$(${PKG_CONFIG} libbpf --cflags)
+        LIBBPF_LDLIBS=$(${PKG_CONFIG} libbpf --libs)
+        LIBBPF_VERSION=$(${PKG_CONFIG} libbpf --modversion)
+    fi
+
+    if ! have_libbpf_basic; then
+        echo "no"
+        echo "	libbpf version $LIBBPF_VERSION is too low, please update it to at least 0.1.0"
+        check_force_libbpf_on
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
+        echo 'CFLAGS += -DHAVE_LIBBPF_SECTION_NAME ' >> $CONFIG
+    fi
+
+    echo "yes"
+    echo "	libbpf version $LIBBPF_VERSION"
+}
+
 check_selinux()
 # SELinux is a compile time option in the ss utility
 {
@@ -385,6 +490,9 @@ check_setns
 echo -n "SELinux support: "
 check_selinux
 
+echo -n "libbpf support: "
+check_libbpf
+
 echo -n "ELF support: "
 check_elf
 
-- 
2.25.4

