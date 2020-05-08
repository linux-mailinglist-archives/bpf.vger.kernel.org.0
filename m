Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3CA1CB17B
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHONL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHONK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 May 2020 10:13:10 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235E8C05BD43
        for <bpf@vger.kernel.org>; Fri,  8 May 2020 07:13:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k110so1559707otc.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XTff14NCqmKGIkdxKiYVS4d8328EwQmZuz4Tb3TFbL4=;
        b=Pq54pojI0QKwhpUqm4Xc8wTRSZqd7feNLZOD0L9/mFOrX2g4QJdjzcU0OkGm5tc8VU
         VdX71L/TRc4HUXvU1Lzxppaxs2ERu7Bkck1s+gxojPYBPk/heCLzBZ5zp/1gipoF91nn
         ZCPzasvR+91z5BKkn0v5ii+WviyUlcvxTHjIXuX3QgCfJ++FJd4Vz1F4MIiyrXuNbabC
         VFNy2jhJQrMmxTQz7uq3dcSVI0EJ6t8XIU6XGn411E+UVC7x8STFhewu4fXxMGcCECh0
         EWxk/heovJanxTgREK5kW4GCd41xvRaufDzsQqNjAYgtqP3dSMJquzx4oY8jaCsOxoc7
         s4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XTff14NCqmKGIkdxKiYVS4d8328EwQmZuz4Tb3TFbL4=;
        b=thMOCN6ykKRIbk2TIdPxa0AffR2IfxMY99Tm5fq9kyS1vTRYYUlq6watVqmGLGF/gV
         dQ7AVfEcH/ngQi3R9sPxy2F7YckSBCF/BiD0eKNgRSvy6R2W/RRxYMNzlwQb1hDiXfl5
         5h9UXv4hwz6XUSra5fSu5oVkK0I8plmts0uK8Z8EAOGXbUKXQ8YMDCzytEu/gIZtUwIo
         RdOzHgOnlSNhvmN9gj5OJnrtmxzLecZI30ZTnqRtml1boHrevYpFWE2qNZLUmmX/q2QX
         4O7AnMtKtPug9SBpzlzGe50X10U1rYL3Pr7XJrd8rHd2DMNIh+OE/VvCXR0BGaGFRMOs
         N7wQ==
X-Gm-Message-State: AGi0PuZVZa5KejFhcGUlg8SOliWxJX5SdXs/f4v0KgFc3ng69GArGK/h
        B7c3hWeoKjdsZS2xBt98NrXtDu3R2MekMoo9rgs=
X-Google-Smtp-Source: APiQypKg8fEwlqsR4fZ06Abl1laeuJSZxRkeBdBih7a5G9xWuSB/wnr9a33bjqquYRTLgAf0+bTjDLqTrj8nu0ogMhA=
X-Received: by 2002:a05:6830:22f8:: with SMTP id t24mr2287248otc.148.1588947188392;
 Fri, 08 May 2020 07:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <CACZqfqC038WbB-iO86xsvpSehgRLaua_uObbOSJgxfx5DnV5Ww@mail.gmail.com>
In-Reply-To: <CACZqfqC038WbB-iO86xsvpSehgRLaua_uObbOSJgxfx5DnV5Ww@mail.gmail.com>
From:   Josh Soref <jsoref@gmail.com>
Date:   Fri, 8 May 2020 10:12:56 -0400
Message-ID: <CACZqfqDijnE9s-Vw8nao9gJ4ewF5oc+YO5_-XOEhDB_OvDRdWw@mail.gmail.com>
Subject: Re: spelling fix for bpf_perf_prog_read_value optval doc
To:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oops, there are in fact two other less important typos in that file.

These were found while cleaning up sysdig.

I tend to maintain individual commits for individual changes.
I expect that the eventual changes would be squashed and the commit
message reworded, I'm not attached to any of the particulars.
Individual commits makes it easier for me to drop things when people
disagree (especially when I make changes to entire modules as opposed
to individual files).
e.g. If someone wants to defend the use of the archaic British English
advertize (Gmail objected so strenuously to that word that it replaced
it here!...).

At some point, I'll send something for a module, but I'm trying to
avoid that for the time being (and hoping someone will volunteer to
help me make contribute such changes).

From 6c7cbf37a36ef7e4cf1c8a74983840541b23c238 Mon Sep 17 00:00:00 2001
From: Josh Soref <jsoref@users.noreply.github.com>
Date: Thu, 7 May 2020 18:09:12 -0400
Subject: [PATCH 1/3] spelling: optval

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f9b7fdd951e48..f705495cbe0e3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1771,7 +1771,7 @@ union bpf_attr {
  * which the option resides and the name *optname* of the option
  * must be specified, see **getsockopt(2)** for more information.
  * The retrieved value is stored in the structure pointed by
- * *opval* and of length *optlen*.
+ * *optval* and of length *optlen*.
  *
  * This helper actually implements a subset of **getsockopt()**.
  * It supports the following *level*\ s:

From e1f6f30c9038b4d1313f3b286c5e60d523afff1b Mon Sep 17 00:00:00 2001
From: Josh Soref <jsoref@users.noreply.github.com>
Date: Fri, 8 May 2020 10:03:53 -0400
Subject: [PATCH 2/3] spelling: advertised

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f705495cbe0e3..df5a0cf2ee4aa 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3695,7 +3695,7 @@ enum {
  BPF_SOCK_OPS_TIMEOUT_INIT, /* Should return SYN-RTO value to use or
  * -1 if default value should be used
  */
- BPF_SOCK_OPS_RWND_INIT, /* Should return initial advertized
+ BPF_SOCK_OPS_RWND_INIT, /* Should return initial advertised
  * window (in packets) or -1 if default
  * value should be used
  */

From 775ce59fb3a8e14817adb7764ffce02987a3c25a Mon Sep 17 00:00:00 2001
From: Josh Soref <jsoref@users.noreply.github.com>
Date: Fri, 8 May 2020 10:04:51 -0400
Subject: [PATCH 3/3] spelling: verdict

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index df5a0cf2ee4aa..8ad84678714b4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2119,7 +2119,7 @@ union bpf_attr {
  * Description
  * This helper is used in programs implementing policies at the
  * skb socket level. If the sk_buff *skb* is allowed to pass (i.e.
- * if the verdeict eBPF program returns **SK_PASS**), redirect it
+ * if the verdict eBPF program returns **SK_PASS**), redirect it
  * to the socket referenced by *map* (of type
  * **BPF_MAP_TYPE_SOCKHASH**) using hash *key*. Both ingress and
  * egress interfaces can be used for redirection. The

In case of whitespace damage, please see:
https://github.com/torvalds/linux/compare/master...jsoref:spelling-bpf.patch
