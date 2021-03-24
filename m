Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF8347997
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 14:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhCXN2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 09:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233395AbhCXN21 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Mar 2021 09:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616592506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OFLJJHqiTZbB4vPnTVk+0D9ylmzqlcoz2MkXRaTJcPs=;
        b=YYXhYB/BU8odxY1jHDAVHLeL4v5REBPhPpObnFUVUUUj7f0nNqSCJ6C1Us/fT1m3+JpoaN
        N3fpgLxpDSOyoNueoelWvF+bFnKLWtUeDjohuWZRorhjHxs++0Qyb+rAN4ELdj+JUTlrc0
        RB21msU4lUDRAvrQ2ZN11C4kFsRaSlo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-EbzlQuyAM3OpcI5VTrN7ig-1; Wed, 24 Mar 2021 09:28:24 -0400
X-MC-Unique: EbzlQuyAM3OpcI5VTrN7ig-1
Received: by mail-wr1-f72.google.com with SMTP id x9so1074374wro.9
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 06:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFLJJHqiTZbB4vPnTVk+0D9ylmzqlcoz2MkXRaTJcPs=;
        b=LumLWQZmx4ylYUw/MHGuQ22G5swEdaqJawRHKLBaAIxVWphQA3fMR98y2ocZNdvxPt
         +Vxv3vFZYxRlXqetqJxNeGIctjaJmlzeeOwRKBBeeDUYqoT1OxkvHZmfds6mBveKP+AG
         KO7ZSr6CBP9L+pjV4wPdOkt0YOtpdMuljCk5fEs8kF2nsxCNgBx71ryn77tu+CugM9AA
         Gt3qWJHpuaaboiu/dVxyNHogKYQYFlquyucQgO7ARxC+f3+tMvOp9VIEMjQoX1Q61ENZ
         tjrXyH14QW5VbGBnwF1RNfccgq6H0wNbnaz0s6Sq1FevRPI/2s/iG0nLjj2In2ImvoqZ
         8mpg==
X-Gm-Message-State: AOAM531Xl69MgQHfmallGzhqVg3fI4B3Tj+42aXK6ZxdBtHfdAUmjfA9
        9EvqJhlHwf8aUV81zuNg+A4pjxQ0fEx9NV4rYcl/g+wDxPXcOLNxARrf+88T28j9F2BH+di836K
        BZYbTWBwiYD2oFgqa3ZxQq38fmvNO
X-Received: by 2002:a05:600c:4a22:: with SMTP id c34mr2994711wmp.79.1616592502646;
        Wed, 24 Mar 2021 06:28:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVPXtLC0JmRl+ngRimo21UCo1fHv0wN/M5SW9CyHmHP3ASf/zcbRdOA7rtXpU0S4y5DtbVlDuLk4e9ufsqJD4=
X-Received: by 2002:a05:600c:4a22:: with SMTP id c34mr2994692wmp.79.1616592502457;
 Wed, 24 Mar 2021 06:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <xunyim6b5k1b.fsf@redhat.com> <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 24 Mar 2021 15:28:06 +0200
Message-ID: <CANoWswkYXaFzuxCDF02=yDp2Fdk6RYb9OdiVNiwp97v-XLV0rQ@mail.gmail.com>
Subject: Re: bpf selftests and page size
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

On Tue, Mar 2, 2021 at 7:08 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 1, 2021 at 1:02 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > Hi!
> >
> > Bunch of bpf selftests actually depends of page size and has it
> > hardcoded to 4K. That causes failures if page shift is configured
> > to values other than 12. It looks as a known issue since for the
> > userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
> > the correct way to export it to bpf programs?
> >
>
> Given PAGE_SIZE and PAGE_SHIFT are just #defines, the only way seems
> to be to pass it from the user-space as a read-only variable.
>

I could not find a good example to attach to cgroup. Here is the
draft, could you point me to right direction?

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index d5b44b135c00..7932236a021e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "cgroup_helpers.h"
-
 #include <linux/tcp.h>
+#include "sockopt_sk.skel.h"

 #ifndef SOL_TCP
 #define SOL_TCP IPPROTO_TCP
@@ -191,60 +191,33 @@ static int getsetsockopt(void)
     return -1;
 }

-static int prog_attach(struct bpf_object *obj, int cgroup_fd, const
char *title)
-{
-    enum bpf_attach_type attach_type;
-    enum bpf_prog_type prog_type;
-    struct bpf_program *prog;
-    int err;
-
-    err = libbpf_prog_type_by_name(title, &prog_type, &attach_type);
-    if (err) {
-        log_err("Failed to deduct types for %s BPF program", title);
-        return -1;
-    }
-
-    prog = bpf_object__find_program_by_title(obj, title);
-    if (!prog) {
-        log_err("Failed to find %s BPF program", title);
-        return -1;
-    }
-
-    err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
-                  attach_type, 0);
-    if (err) {
-        log_err("Failed to attach %s BPF program", title);
-        return -1;
-    }
-
-    return 0;
-}
-
 static void run_test(int cgroup_fd)
 {
-    struct bpf_prog_load_attr attr = {
-        .file = "./sockopt_sk.o",
-    };
-    struct bpf_object *obj;
-    int ignored;
+    struct sockopt_sk *skel;
+    int prog_fd;
+    int duration = 0;
     int err;

-    err = bpf_prog_load_xattr(&attr, &obj, &ignored);
-    if (CHECK_FAIL(err))
-        return;
+    skel = sockopt_sk__open_and_load();
+    if (CHECK(!skel, "skel_load", "sockopt_sk skeleton failed\n"))
+        goto cleanup;
+
+    skel->bss->page_size = getpagesize();

-    err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
-    if (CHECK_FAIL(err))
-        goto close_bpf_object;
+    prog_fd = bpf_program__fd(skel->progs._getsockopt);
+    err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_GETSOCKOPT, 0);
+    if (CHECK(err, "attach", "getsockopt attach failed: %d\n", err))
+        goto cleanup;

-    err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt");
-    if (CHECK_FAIL(err))
-        goto close_bpf_object;
+    prog_fd = bpf_program__fd(skel->progs._setsockopt);
+    err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SETSOCKOPT, 0);
+    if (CHECK(err, "attach", "setsockopt attach failed: %d\n", err))
+        goto cleanup;

     CHECK_FAIL(getsetsockopt());

-close_bpf_object:
-    bpf_object__close(obj);
+cleanup:
+    sockopt_sk__destroy(skel);
 }

 void test_sockopt_sk(void)
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c
b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index d3597f81e6e9..f8b051589681 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -8,9 +8,7 @@
 char _license[] SEC("license") = "GPL";
 __u32 _version SEC("version") = 1;

-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
+int page_size; /* userspace should set it */

 #ifndef SOL_TCP
 #define SOL_TCP IPPROTO_TCP
@@ -41,7 +39,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
          * let next BPF program in the cgroup chain or kernel
          * handle it.
          */
-        ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
+        ctx->optlen = 0; /* bypass optval>page_size */
         return 1;
     }

@@ -86,11 +84,11 @@ int _getsockopt(struct bpf_sockopt *ctx)
         optval[0] = 0x55;
         ctx->optlen = 1;

-        /* Userspace buffer is PAGE_SIZE * 2, but BPF
-         * program can only see the first PAGE_SIZE
+        /* Userspace buffer is page_size * 2, but BPF
+         * program can only see the first page_size
          * bytes of data.
          */
-        if (optval_end - optval != PAGE_SIZE)
+        if (optval_end - optval != page_size)
             return 0; /* EPERM, unexpected data size */

         return 1;
@@ -131,7 +129,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
          * let next BPF program in the cgroup chain or kernel
          * handle it.
          */
-        ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
+        ctx->optlen = 0; /* bypass optval>page_size */
         return 1;
     }

@@ -160,8 +158,8 @@ int _setsockopt(struct bpf_sockopt *ctx)
     }

     if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
-        /* Original optlen is larger than PAGE_SIZE. */
-        if (ctx->optlen != PAGE_SIZE * 2)
+        /* Original optlen is larger than page_size. */
+        if (ctx->optlen != page_size * 2)
             return 0; /* EPERM, unexpected data size */

         if (optval + 1 > optval_end)
@@ -171,11 +169,11 @@ int _setsockopt(struct bpf_sockopt *ctx)
         optval[0] = 0;
         ctx->optlen = 1;

-        /* Usepace buffer is PAGE_SIZE * 2, but BPF
-         * program can only see the first PAGE_SIZE
+        /* Usepace buffer is page_size * 2, but BPF
+         * program can only see the first page_size
          * bytes of data.
          */
-        if (optval_end - optval != PAGE_SIZE)
+        if (optval_end - optval != page_size)
             return 0; /* EPERM, unexpected data size */

         return 1;


-- 
WBR, Yauheni

