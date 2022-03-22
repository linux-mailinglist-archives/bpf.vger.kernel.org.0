Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E744E37F3
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 05:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiCVEd4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 00:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiCVEd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 00:33:56 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61920F79
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 21:32:27 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9so10942757ilu.9
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 21:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hJD2VDFF7zEUYUshq0yajgfKbegjSOLftiIqXiquNY=;
        b=mTkF4Jzb/OcWa3rXCVcBIqd7uvUxqBU0vf2CE2if0FhL6blRw23Q5n5+SgPtBVemqi
         CI42XQ/4TRwYKfewneyLjfBO2+DQU4GaHBdEWy8GUw/msXtQTnX4MiOkcm20uw/6UoRW
         tOPZ1KD8F1qIhwRENzbC7ODHv9v6l/rsy76x08bXgf8cmw/koGJ7yLy4UpM+9R0dR4rr
         wCkBX3pucgzD9IUT2rYyHE60L1kIiq0Gg/U5X3xECXw5Y9fP1ZFfGwAtZre94zA+STDU
         Bjo6ZX21CXb+ROis+R+u1L7P6qDp9p4COOi2Y0BKiFaji6fBtN2O5kgS0STHpcjX4uDO
         zk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hJD2VDFF7zEUYUshq0yajgfKbegjSOLftiIqXiquNY=;
        b=Bj+3BHpUOFitb0MdrEBEexXaBcoF5iFN10nvlpGkZ6PWJNL9+XD2unO4TH1hf9FjUT
         bR9YNXsGRLnNk5mXn1iPmeYnWPfjfipYqsc3uDcBERxDmIF937bMtp3MmwwAfhSh1fVc
         5nKrj3yeh+mRDdOd5yDeIO3WRg/pyxMBAQZjWnQd84rcouV47/kezfISZmeSM/tPa8NS
         P/fhfzSM2qiGl6M2xBcluACoWBeQOIm1QTng+wz5tZyVD6XUeN8pyFkfPyeOUBttlD4j
         Qoq3A6WWR1b9BwXz1qTn8aNnHiFa9L1cwI+zJqZWIcPuOr18AVWq8yA3RXnwLCIh2xXt
         kP5A==
X-Gm-Message-State: AOAM531XK84bTe0Ac3A4LdXabTfsgdRAkVXFQXl0bWyLur6T6qSTYC77
        TF92b5GgLJ2+b7Itg0B4y2gK0Xo4i4EUFDEAVsg=
X-Google-Smtp-Source: ABdhPJw+sKDhNi02TESF3leb8VFJsBSKw2pWNW9Xe4wyk2FURE4xtbYWBmez7REQCjx6ssiEUkYNJGFgi6UgcaIOvu4=
X-Received: by 2002:a92:c568:0:b0:2c8:8dd:e8bf with SMTP id
 b8-20020a92c568000000b002c808dde8bfmr7041934ilj.98.1647923546963; Mon, 21 Mar
 2022 21:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-4-kuifeng@fb.com>
 <20220318191332.7qsztafrjyu7bjtc@ast-mbp> <CAEf4BzZF02Jn3PP8LJ7oF55ogPOePt0Wt8+Dtmj5fN0r7PfU0w@mail.gmail.com>
 <CAADnVQKo2xiOYrUG_Mb9OTAO_Sa7uahkYL-UEbu02GD=Sr8BJA@mail.gmail.com>
In-Reply-To: <CAADnVQKo2xiOYrUG_Mb9OTAO_Sa7uahkYL-UEbu02GD=Sr8BJA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 21:32:15 -0700
Message-ID: <CAEf4BzbL0SBN_1MG4r3boErrz73DRMK5v_6mEjHgMMXgix_b9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 21, 2022 at 6:15 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 21, 2022 at 4:24 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > I remember I brought this up earlier, but I forgot the outcome. What
> > if don't touch BPF_RAW_TRACEPOINT_OPEN and instead allow to create all
> > the same links through more universal BPF_LINK_CREATE command. And
> > only there we add bpf_cookie? There are few advantages:
> >
> > 1. We can separate raw_tracepoint and trampoline-based programs more
> > cleanly in UAPI (it will be two separate structs: link_create.raw_tp
> > with raw tracepoint name vs link_create.trampoline, or whatever the
> > name, with cookie and stuff). Remember that raw_tp won't support
> > bpf_cookie for now, so it would be another advantage not to promise
> > cookie in UAPI.
>
> What would it look like?
> Technically link_create has prog_fd and perf_event.bpf_cookie
> already.
>
>         case BPF_PROG_TYPE_TRACING:
>                 ret = tracing_bpf_link_attach(attr, uattr, prog);
> would just gain a few more checks for prog->expected_attach_type ?
>
> Then link_create cmd will be equivalent to raw_tp_open.
> With and without bpf_cookie.
> ?

Yes, except I'd leave perf_event for perf_event-based attachments
(kprobe, uprobe, tracepoint) and would define a separate substruct for
trampoline-based programs. Something like this (I only compile-tested
it, of course). I've also simplified prog_type/expected_attach_type
logic a bit because it felt like a total maze to me and I was getting
lost all the time. Gmail will probably corrupt all the whitespaces,
sorry about that in advance.

Seems like we could already attach BPF_PROG_TYPE_EXT both through
RAW_TRACEPOINT_OPEN and LINK_CREATE, I didn't realize that. The
"patch" below leaves raw_tp handling
(BPF_PROG_TYPE_TRACING+BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT,
and BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) in RAW_TRACEPOINT_OPEN. If
we want to completely unify all the bpf_link creations under
LINK_CREATE, see extra small "patch" at the very bottom.

P.S. While looking at this, I also realized that we should probably
enforce zeros after all those kprobe_multi, trampoline, perf_event,
etc sections (depending on specific program type). We missed that
initially and don't enforce it right now (I don't think anyone sane
would rely on this, so probably best to fix this soon-ish).

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d14b10b85e51..5692d4381e3b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1489,6 +1489,9 @@ union bpf_attr {
                 __aligned_u64    addrs;
                 __aligned_u64    cookies;
             } kprobe_multi;
+            struct {
+                __u64        cookie;
+            } trampoline;
         };
     } link_create;

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cdaa1152436a..819f30952cc4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2704,7 +2704,7 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {

 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
                    int tgt_prog_fd,
-                   u32 btf_id)
+                   u32 btf_id, u64 cookie)
 {
     struct bpf_link_primer link_primer;
     struct bpf_prog *tgt_prog = NULL;
@@ -2840,7 +2840,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
     if (err)
         goto out_unlock;

-    err = bpf_trampoline_link_prog(prog, tr);
+    err = bpf_trampoline_link_prog(prog, tr /* , cookie */);
     if (err) {
         bpf_link_cleanup(&link_primer);
         link = NULL;
@@ -3065,7 +3065,7 @@ static int bpf_raw_tracepoint_open(const union
bpf_attr *attr)
             tp_name = prog->aux->attach_func_name;
             break;
         }
-        err = bpf_tracing_prog_attach(prog, 0, 0);
+        err = bpf_tracing_prog_attach(prog, 0, 0, 0);
         if (err >= 0)
             return err;
         goto out_put_prog;
@@ -3189,7 +3189,12 @@ attach_type_to_prog_type(enum bpf_attach_type
attach_type)
     case BPF_CGROUP_SETSOCKOPT:
         return BPF_PROG_TYPE_CGROUP_SOCKOPT;
     case BPF_TRACE_ITER:
+    case BPF_TRACE_FENTRY:
+    case BPF_TRACE_FEXIT:
+    case BPF_MODIFY_RETURN:
         return BPF_PROG_TYPE_TRACING;
+    case BPF_LSM_MAC:
+        return BPF_PROG_TYPE_LSM;
     case BPF_SK_LOOKUP:
         return BPF_PROG_TYPE_SK_LOOKUP;
     case BPF_XDP:
@@ -4246,21 +4251,6 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
     return err;
 }

-static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
-                   struct bpf_prog *prog)
-{
-    if (attr->link_create.attach_type != prog->expected_attach_type)
-        return -EINVAL;
-
-    if (prog->expected_attach_type == BPF_TRACE_ITER)
-        return bpf_iter_link_attach(attr, uattr, prog);
-    else if (prog->type == BPF_PROG_TYPE_EXT)
-        return bpf_tracing_prog_attach(prog,
-                           attr->link_create.target_fd,
-                           attr->link_create.target_btf_id);
-    return -EINVAL;
-}
-
 #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -4282,15 +4272,13 @@ static int link_create(union bpf_attr *attr,
bpfptr_t uattr)

     switch (prog->type) {
     case BPF_PROG_TYPE_EXT:
-        ret = tracing_bpf_link_attach(attr, uattr, prog);
-        goto out;
+        break;
     case BPF_PROG_TYPE_PERF_EVENT:
     case BPF_PROG_TYPE_TRACEPOINT:
         if (attr->link_create.attach_type != BPF_PERF_EVENT) {
             ret = -EINVAL;
             goto out;
         }
-        ptype = prog->type;
         break;
     case BPF_PROG_TYPE_KPROBE:
         if (attr->link_create.attach_type != BPF_PERF_EVENT &&
@@ -4298,7 +4286,6 @@ static int link_create(union bpf_attr *attr,
bpfptr_t uattr)
             ret = -EINVAL;
             goto out;
         }
-        ptype = prog->type;
         break;
     default:
         ptype = attach_type_to_prog_type(attr->link_create.attach_type);
@@ -4309,7 +4296,7 @@ static int link_create(union bpf_attr *attr,
bpfptr_t uattr)
         break;
     }

-    switch (ptype) {
+    switch (prog->type) {
     case BPF_PROG_TYPE_CGROUP_SKB:
     case BPF_PROG_TYPE_CGROUP_SOCK:
     case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
@@ -4319,8 +4306,25 @@ static int link_create(union bpf_attr *attr,
bpfptr_t uattr)
     case BPF_PROG_TYPE_CGROUP_SOCKOPT:
         ret = cgroup_bpf_link_attach(attr, prog);
         break;
+    case BPF_PROG_TYPE_EXT:
+        ret = bpf_tracing_prog_attach(prog,
+                          attr->link_create.target_fd,
+                          attr->link_create.target_btf_id,
+                          attr->link_create.trampoline.cookie);
+        break;
+    case BPF_PROG_TYPE_LSM:
     case BPF_PROG_TYPE_TRACING:
-        ret = tracing_bpf_link_attach(attr, uattr, prog);
+        if (attr->link_create.attach_type != prog->expected_attach_type) {
+            ret = -EINVAL;
+            goto out;
+        }
+        if (prog->expected_attach_type == BPF_TRACE_ITER)
+            ret = bpf_iter_link_attach(attr, uattr, prog);
+        else
+            ret = bpf_tracing_prog_attach(prog,
+                              attr->link_create.target_fd,
+                              attr->link_create.target_btf_id,
+                              attr->link_create.trampoline.cookie);
         break;
     case BPF_PROG_TYPE_FLOW_DISSECTOR:
     case BPF_PROG_TYPE_SK_LOOKUP:



And then for moving raw_tp-related attachments into LINK_CREATE, I'd
add this to UAPI and wire everything in kernel/bpf/syscall.c
accordingly:

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5692d4381e3b..a85403f89569 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1492,6 +1492,9 @@ union bpf_attr {
                        struct {
                                __u64           cookie;
                        } trampoline;
+                       struct {
+                               __aligned_u64   name;
+                       } raw_tp;
                };
        } link_create;
