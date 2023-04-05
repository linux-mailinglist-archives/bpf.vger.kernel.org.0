Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E0A6D84EA
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDER2m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjDER2k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:28:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0BE61B6
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:28:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso3169849a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k28+fkbDF3ePrE1qAtXcOCcK5oSCZprAPj5YxxoP0g=;
        b=DvWmOaMbE+ipeiaLLTeNQoSgmJ47CoaU65uiHUUGuLmb8oT3/skiGNtJTxZK33fxxD
         DEy6gGqZkuhc4B57M2DpjqWVyXOl5FtoJ1skUhb6xeJMP//BRzwQ6XfpF/NPUVX8nbRw
         c2o1PHvgIxuw4PbH1spUjpGbht9ow8dmVasEKKyKsGXE6M1lwqC/yXR7abY9f0N/finw
         mBuoSYc3XIKLi6kVHU9raPR8189Lzg96wxImbfF0USSfnSTWIXfgz9Uki1ykAvy1QioP
         9dTbEdgYly5SAKsWzGZrg0a6RjLZb50CRmofEHr8HowQlbja8cSNGS4WqckKb4uO+nDw
         jO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k28+fkbDF3ePrE1qAtXcOCcK5oSCZprAPj5YxxoP0g=;
        b=cy4uI9DQgcGKyMeTRJvGBYcRoXJ5kjJ4sKp3xjZ0IXIhtxcinGwwaMSXxPPrKPg0+c
         48CxLTUdkgtJOozGORvX08vxCbxy25xj9bhK7ED9Mp/wbu4YwRkNNZ8+gPsAiuIaVoWg
         +LhkWMmcb7DtoJO2ixPNBqifLamqy/lbiewOyxBLgHCXHbwMFZnqj0fSQG35KFTTiX5T
         BXt0+Y3k5Cyq5eO/YbaDootot/cwuRMC7FEYMJt/kxIPoH4GWJZT09avSp1ZGUNg3OIg
         948fMbpoaFfWn+hVOA0pZc7THJw6+IFM7KOmVnfmFEUenpA+FNyJGlId4cQ5QduCA57C
         jEsg==
X-Gm-Message-State: AAQBX9eb69Cpz4HUCTAg0T72+OE/3/b+H8A/LAe+p0cCf1qRpF7CFV+i
        EMCq70kxbq7M4JKtcGUyunf/9a/wG7U56kn6sFwWPg==
X-Google-Smtp-Source: AKy350YuCeH7obUWK8QTvR6g/NNiBk7Vgomu0NE3sOovjP2ZwHxlS8js31cAJChZ+n4Qx/eSPqji713UZJEFZynvfTs=
X-Received: by 2002:a50:9e09:0:b0:4fb:7ccf:337a with SMTP id
 z9-20020a509e09000000b004fb7ccf337amr1510116ede.3.1680715708198; Wed, 05 Apr
 2023 10:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:28:17 +0100
Message-ID: <CAN+4W8hptrrVjQ+-=otz_FPb2uL4E4bgzNRzp3pOh4=hWgeA+A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/19] BPF verifier rotating log
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> This turned into a pretty sizable patch set with lots of arithmetics, but
> hopefully the set of features added to verifier log in this patch set are=
 both
> useful for BPF users and are self-contained and isolated enough to not ca=
use
> troubles going forward.

Hi Andrii,

Thanks for pushing this forward, this will make all of the log
handling so much nicer. Sorry it took a while to review, but it's
quite a chunky series as you point out yourself :) Maybe it makes
sense to pull out some of the acked bits (moving code around, etc.)
into a separate patch set?

I'll send out individual reviews shortly, but wanted to put my my main
proposal here. It's only compile tested, but it's hopefully clearer
than my words. Note that I didn't fix up whitespace to make the diff
smaller. It should apply on top of your branch.

From 162afa86d109954a4951d052513580849bd5cc54 Mon Sep 17 00:00:00 2001
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 5 Apr 2023 18:24:42 +0100
Subject: [PATCH] bpf: simplify log nul termination and FIXED mode

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 kernel/bpf/log.c | 105 ++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index ab8149448724..b6b59047a594 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -54,45 +54,13 @@ static void bpf_vlog_update_len_max(struct
bpf_verifier_log *log, u32 add_len)
         log->len_max =3D len;
 }

-void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
-               va_list args)
+static void bpf_vlog_emit(struct bpf_verifier_log *log, const char
*kbuf, u32 n)
 {
     u64 cur_pos;
-    u32 new_n, n;
-
-    n =3D vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
-
-    WARN_ONCE(n >=3D BPF_VERIFIER_TMP_LOG_SIZE - 1,
-          "verifier log line truncated - local buffer too short\n");
-
-    if (log->level =3D=3D BPF_LOG_KERNEL) {
-        bool newline =3D n > 0 && log->kbuf[n - 1] =3D=3D '\n';
-
-        pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
-        return;
-    }
-
-    n +=3D 1; /* include terminating zero */
-    bpf_vlog_update_len_max(log, n);
-
-    if (log->level & BPF_LOG_FIXED) {
-        /* check if we have at least something to put into user buf */
-        new_n =3D 0;
-        if (log->end_pos + 1 < log->len_total) {
-            new_n =3D min_t(u32, log->len_total - log->end_pos, n);
-            log->kbuf[new_n - 1] =3D '\0';
-        }
-        cur_pos =3D log->end_pos;
-        log->end_pos +=3D n - 1; /* don't count terminating '\0' */
-
-        if (log->ubuf && new_n &&
-            copy_to_user(log->ubuf + cur_pos, log->kbuf, new_n))
-            goto fail;
-    } else {
         u64 new_end, new_start;
         u32 buf_start, buf_end, new_n;

-        log->kbuf[n - 1] =3D '\0';
+    bpf_vlog_update_len_max(log, n);

         new_end =3D log->end_pos + n;
         if (new_end - log->start_pos >=3D log->len_total)
@@ -101,7 +69,7 @@ void bpf_verifier_vlog(struct bpf_verifier_log
*log, const char *fmt,
             new_start =3D log->start_pos;

         log->start_pos =3D new_start;
-        log->end_pos =3D new_end - 1; /* don't count terminating '\0' */
+        log->end_pos =3D new_end;

         if (!log->ubuf)
             return;
@@ -126,35 +94,60 @@ void bpf_verifier_vlog(struct bpf_verifier_log
*log, const char *fmt,
         if (buf_start < buf_end) {
             /* message fits within contiguous chunk of ubuf */
             if (copy_to_user(log->ubuf + buf_start,
-                     log->kbuf + n - new_n,
+                     kbuf + n - new_n,
                      buf_end - buf_start))
                 goto fail;
         } else {
             /* message wraps around the end of ubuf, copy in two chunks */
             if (copy_to_user(log->ubuf + buf_start,
-                     log->kbuf + n - new_n,
+                     kbuf + n - new_n,
                      log->len_total - buf_start))
                 goto fail;
             if (copy_to_user(log->ubuf,
-                     log->kbuf + n - buf_end,
+                     kbuf + n - buf_end,
                      buf_end))
                 goto fail;
         }
-    }
-
     return;
 fail:
     log->ubuf =3D NULL;
 }

-void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
+static u32 bpf_vlog_available(const struct bpf_verifier_log *log)
 {
-    char zero =3D 0;
-    u32 pos;
+    return log->len_total - (log->end_pos - log->start_pos);
+}
+
+void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
+               va_list args)
+{
+    /* NB: contrary to vsnprintf n can't be larger than sizeof(log->kbuf) =
*/
+    u32 n =3D vscnprintf(log->kbuf, sizeof(log->kbuf), fmt, args);
+
+    if (log->level =3D=3D BPF_LOG_KERNEL) {
+        bool newline =3D n > 0 && log->kbuf[n - 1] =3D=3D '\n';
+
+        pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
+        return;
+    }

+    if (log->level & BPF_LOG_FIXED) {
+        bpf_vlog_update_len_max(log, n);
+        /* avoid rotation by never emitting more than what's unused */
+        n =3D min_t(u32, n, bpf_vlog_available(log));
+    }
+
+    bpf_vlog_emit(log, log->kbuf, n);
+}
+
+void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
+{
     if (!bpf_verifier_log_needed(log) || log->level =3D=3D BPF_LOG_KERNEL)
         return;

+    if (WARN_ON_ONCE(new_pos > log->end_pos))
+        return;
+
     /* if position to which we reset is beyond current log window,
      * then we didn't preserve any useful content and should adjust
      * start_pos to end up with an empty log (start_pos =3D=3D end_pos)
@@ -162,17 +155,6 @@ void bpf_vlog_reset(struct bpf_verifier_log *log,
u64 new_pos)
     log->end_pos =3D new_pos;
     if (log->end_pos < log->start_pos)
         log->start_pos =3D log->end_pos;
-
-    if (!log->ubuf)
-        return;
-
-    if (log->level & BPF_LOG_FIXED)
-        pos =3D log->end_pos + 1;
-    else
-        div_u64_rem(new_pos, log->len_total, &pos);
-
-    if (pos < log->len_total && put_user(zero, log->ubuf + pos))
-        log->ubuf =3D NULL;
 }

 static void bpf_vlog_reverse_kbuf(char *buf, int len)
@@ -228,6 +210,7 @@ static bool bpf_vlog_truncated(const struct
bpf_verifier_log *log)

 int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual)
 {
+    char zero =3D 0;
     u32 sublen;
     int err;

@@ -237,8 +220,20 @@ int bpf_vlog_finalize(struct bpf_verifier_log
*log, u32 *log_size_actual)

     if (!log->ubuf)
         goto skip_log_rotate;
+
+    if (log->level & BPF_LOG_FIXED) {
+        bpf_vlog_update_len_max(log, 1);
+
+        /* terminate by (potentially) overwriting the last byte */
+        if (put_user(zero, log->ubuf + min_t(u32, log->end_pos,
log->len_total-1))
+            return -EFAULT;
+    } else {
+        /* terminate by (potentially) rotating out the first byte */
+        bpf_vlog_emit(log, &zero, 1);
+    }
+
     /* If we never truncated log, there is nothing to move around. */
-    if ((log->level & BPF_LOG_FIXED) || log->start_pos =3D=3D 0)
+    if (log->start_pos =3D=3D 0)
         goto skip_log_rotate;

     /* Otherwise we need to rotate log contents to make it start from the
--=20
2.39.2
