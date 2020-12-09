Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7302D4C41
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 21:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgLIUyo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgLIUyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 15:54:36 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70BC0613CF;
        Wed,  9 Dec 2020 12:53:55 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id t13so2492039ybq.7;
        Wed, 09 Dec 2020 12:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sIdtAqgo/qYzQQgMr74Yx6K7gOdyN5rs5fdPHporako=;
        b=pa7B1ypTUnL+HVbXCZlmy4SArRz+7F/m7IcmS+gu6U0/E9G3OSLe2bnbHfB4DlB+F5
         y7e88ATM+Hb/ppsG6FHe/ocUU/S7KeJbVRPjQSh6johPGZYx44Ab63tT4zIwlxRujIVL
         ZXmsBdaS8kKm8aqSHaDot1xPIdci/r2ELfmAFI+McgwdbMMQC/vY8sPB+YNL6TPyDggu
         cW8HfCt6KUUL4qH93PXqK7r1aLaYCo9/a+ISFEEaln+zpk93SaQbhzWtKmILFCMcv7zR
         2n1Gka7dySsuy3LCJHUihdlLn8L3SZXhjlD36aIqSTXAEasBSMgyejLq1qrOpSMrmKWI
         lnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sIdtAqgo/qYzQQgMr74Yx6K7gOdyN5rs5fdPHporako=;
        b=pPPf0sgPBha5FfS7V24DWzofxKeumezd/5+9grIc+g+0rUiuj/8gSPSLagUXfP4HIN
         GttgY2budP4HawWwlQ+EMrM+BnVwh1t4gjZNaotgRzF6YYAg64BIlTKqjZs1p1QKqFpv
         6b1qdm1KUMHh6nFoO19NA6tWqrET6YFSKFyG063J5+B1HVkaEZBurgl3VwpISzu9Mgyh
         +Mc6Eam9D5phXSYmTxqmqs+x/Izle0l+IAUBFUotU/Q+b+q2mmt10E/gsCarnrrzq0nw
         EPRqbHjkUQVd8Y1I9aQhSx+PGcRPIg2n9j2e430fV6URxIQCI0QeigCshzwK6gWy1N3y
         wxCw==
X-Gm-Message-State: AOAM5320be/BD4xwiXtfxSWMCPjsAjae2WzYiiRqOe9LPfkd9zxiqvGn
        1rYnPSjx6+w++K4dld9RVf2AkY/5GG/890BG9c8jnDlOVvnM6A==
X-Google-Smtp-Source: ABdhPJzRXpI3JJHy6JgWfq6aHZ0AA/xxcQ0vLFSWRMhEzpM9Cg3U2Lpfqh6FpMgbfounjpTNKsn7212MhbL+zvRLvTw=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr6339865ybe.403.1607547234901;
 Wed, 09 Dec 2020 12:53:54 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Dec 2020 12:53:44 -0800
Message-ID: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
Subject: Per-CPU variables in modules and pahole
To:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm working on supporting per-CPU symbols in BPF/libbpf, and the
prerequisite for that is BTF data for .data..percpu data section and
variables inside that.

Turns out, pahole doesn't currently emit any BTF information for such
variables in kernel modules. And the reason why is quite confusing and
I can't figure it out myself, so was hoping someone else might be able
to help.

To repro, you can take latest bpf-next tree and add this to
bpf_testmod/bpf_testmod.c inside selftests/bpf:

$ git diff bpf_testmod/bpf_testmod.c
      diff --git
a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 2df19d73ca49..b2086b798019 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -3,6 +3,7 @@
 #include <linux/error-injection.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/percpu-defs.h>
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
 #include "bpf_testmod.h"
@@ -10,6 +11,10 @@
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"

+DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy1) = -1;
+DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
+DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy2) = -1;
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
                      struct bin_attribute *bin_attr,

1. So the very first issue (that I'm going to ignore for now) is that
if I just added bpf_testmod_ksym_percpu, it would get addr == 0 and
would be ignored by the current pahole logic. So we need to fix that
for modules. Adding dummy1 and dummy2 takes care of this for now,
bpf_testmod_ksym_percpu has offset 4.

2. Second issue is more interesting. Somehow, when pahole iterates
over DWARF variables, the address of bpf_testmod_ksym_percpu is
reported as 0x10e74, not 4. Which totally confuses pahole because
according to ELF symbols, bpf_testmod_ksym_percpu symbol has value 4.
I tracked this down to dwarf_getlocation() returning 10e74 as number
field in expr.

But this seems wrong, because when looking at DWARF:

$ readelf -wi bpf_testmod.ko | grep bpf_testmod_ksym_percpu -B1 -A6
 <1><fbc5>: Abbrev Number: 97 (DW_TAG_variable)
    <fbc6>   DW_AT_name        : (indirect string, offset: 0x4afb):
bpf_testmod_ksym_percpu
    <fbca>   DW_AT_decl_file   : 5
    <fbcb>   DW_AT_decl_line   : 15
    <fbcc>   DW_AT_decl_column : 1
    <fbcd>   DW_AT_type        : <0xce>
    <fbd1>   DW_AT_external    : 1
    <fbd1>   DW_AT_location    : 9 byte block: 3 4 0 0 0 0 0 0 0
 (DW_OP_addr: 4)

You can see that addr is actually 4.

And ELF symbols agree:

$ readelf -a bpf_testmod.ko | grep bpf_testmod_ksym_percpu
   102: 0000000000000004     4 OBJECT  GLOBAL DEFAULT   33
bpf_testmod_ksym_percpu


I also can't seem to match 0x10e74 to anything in bpf_testmod.ko, no
section or anything like that.

So, help! Is this just a libdw bug? If yes, why don't we see it
anywhere else? If not, what am I missing and how can we make pahole
emit BTF data for variables in modules?

Thanks!


-- Andrii
