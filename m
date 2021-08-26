Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8425C3F8DBA
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhHZSTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243308AbhHZSTS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 14:19:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBABC061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 11:18:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m28so8735448lfj.6
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Af3Zt5vnN2QYyJv2cZq1oGU32WvOM+obaXa2rDwfiLQ=;
        b=XNdDQXhXQfS0Yw0VtvB8PyT46JiwcoUY7qop/X6hfBGIO3L8QR7MKcM14+rHUPtTN6
         yFpj8vHoWJIFvhJ2PAlet1DYXls9Eu41PRii4qTfPSUNB3Hb669Fosr6blz7cU+kSIiu
         jbvBm1BO2SVTUK//2enBVUEJGK+IeQvylibnJsa7Jwe1GmpyvcrA043m0t9Tm/j8GIOw
         7fbhxlJJlqrJs0dCSZ/KWrrcp23v1JtdE6bYM8o+i7ompV5xiJxTQiPT8fC/GLMz5lJY
         aOVmA5N2HO1BKMP1mMPRDcurmk34h9Tv3+fjI2LRC0h0pf9Zg1yse+Qxd+jQhHDRkyBC
         T3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Af3Zt5vnN2QYyJv2cZq1oGU32WvOM+obaXa2rDwfiLQ=;
        b=pvJ9f923sw9HuKl8l5bNo8ABAcbjOd7cuJxZY1jIN5mP2qtl9z/NE5v35M28MxUYUs
         1/MOPQ8l10LXxMSXGMW/IDSSs50v33TcEs4vfndX/HxjX0XzO3Kmm7haAQveAccMxHvP
         GfAjlifZuRBsnkBUwkozmaTS8QlT187C1wfRmxTyPsxWzVm4pofej7iR+RcK5Ta0TcpO
         mJK4LTEYpXmwRZeHvlsJNyGM6w9xwJgNRs3p2eV5B5UYYXRSGYBT0uBvB7UsgPY1A4NA
         BRwzNXqIfC/mps/FuQYGWlAIXclMvDKXGhGBwip9/wld+5HAd78z6pMnKVdWnV7B6+VY
         mZ4Q==
X-Gm-Message-State: AOAM531KXvvHGJ03n/LvDYB1fdK+bb5WzvKBCbG2cX3G5lBcvfvQp9Zn
        UmLq8NYaDNGrvf43+LzKZ+XLDstX33ofhetk/ak=
X-Google-Smtp-Source: ABdhPJxJMiRA0PpI5QBJLxV4RuKiFawW8vAsZdDXwSYztw25qvlPW1io78IcVxVCq2w9cwPzwS/wsaQnT+jXVF3y87s=
X-Received: by 2002:a05:6512:130f:: with SMTP id x15mr3651875lfu.571.1630001908737;
 Thu, 26 Aug 2021 11:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
In-Reply-To: <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Thu, 26 Aug 2021 11:18:02 -0700
Message-ID: <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reporting back: I tried a select() based approach, (as attached below)
 but unfortunately it doesn't seem to work. During testing,  I am
always getting full timeout errors as the socket never seems to become
ready to read(). My guess is that this has something to do with the
sockets being created through sockpair() , but I am unable to confirm.

On the other hand, the previous patch approach works perfectly fine, I
would still like to request to apply that instead.


diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 5c5979046523..247e8b7a6911 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -949,7 +949,6 @@ static void redir_to_connected(int family, int
sotype, int sock_mapfd,
        int err, n;
        u32 key;
        char b;
-       int retries = 100;

        zero_verdict_count(verd_mapfd);

@@ -1002,15 +1001,12 @@ static void redir_to_connected(int family, int
sotype, int sock_mapfd,
                goto close_peer1;
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);
-again:
+
+       if (poll_read(c0, IO_TIMEOUT_SEC))
+             FAIL_ERRNO("%s: read", log_prefix);
        n = read(c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1571,7 +1567,6 @@ static void unix_redir_to_connected(int sotype,
int sock_mapfd,
        const char *log_prefix = redir_mode_str(mode);
        int c0, c1, p0, p1;
        unsigned int pass;
-       int retries = 100;
        int err, n;
        int sfd[2];
        u32 key;
@@ -1606,15 +1601,11 @@ static void unix_redir_to_connected(int
sotype, int sock_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
+       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
+             FAIL_ERRNO("%s: read", log_prefix);
        n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1748,7 +1739,6 @@ static void udp_redir_to_connected(int family,
int sock_mapfd, int verd_mapfd,
        const char *log_prefix = redir_mode_str(mode);
        int c0, c1, p0, p1;
        unsigned int pass;
-       int retries = 100;
        int err, n;
        u32 key;
        char b;
@@ -1781,15 +1771,11 @@ static void udp_redir_to_connected(int family,
int sock_mapfd, int verd_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
+       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC * 10))
+               FAIL_ERRNO("%s: read", log_prefix);
        n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1841,7 +1827,6 @@ static void inet_unix_redir_to_connected(int
family, int type, int sock_mapfd,
        const char *log_prefix = redir_mode_str(mode);
        int c0, c1, p0, p1;
        unsigned int pass;
-       int retries = 100;
        int err, n;
        int sfd[2];
        u32 key;
@@ -1876,15 +1861,11 @@ static void inet_unix_redir_to_connected(int
family, int type, int sock_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
+       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
+             FAIL_ERRNO("%s: read", log_prefix);
        n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1932,7 +1913,6 @@ static void unix_inet_redir_to_connected(int
family, int type, int sock_mapfd,
        int sfd[2];
        u32 key;
        char b;
-       int retries = 100;

        zero_verdict_count(verd_mapfd);

@@ -1963,15 +1943,11 @@ static void unix_inet_redir_to_connected(int
family, int type, int sock_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
+       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
+             FAIL_ERRNO("%s: read", log_prefix);
        n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);
