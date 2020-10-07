Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5028556F
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 02:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJGA11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGA11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 20:27:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F58C061755
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 17:27:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f21so546958wml.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 17:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=stw1ZFNUAmnjmaF+od5+r3TkD+FcXLwgbCpF9orza5M=;
        b=C+GhloHmf/BUvKpDmTqKqxLFty3ukzn8iygfvb5QOAYUhYqqO9ZKP8MXlmaznOAIlL
         PXmX3ScX7204U95DBDPsnBy+L1QSMExQDvhn4TBOfRR1SAugJ+hL0dTveW32x8DZ6Twz
         XV5Uh/IAqC5JFethrs+Pl2cCb+e8NVcwWJN8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=stw1ZFNUAmnjmaF+od5+r3TkD+FcXLwgbCpF9orza5M=;
        b=KBcer5N0wTRNQqKE8Zh3T2Dc+Mm6aCU1CpO4BDcVZN3liMC5VgqJmiBiPj7O3ZhiTo
         cYecMaFylHAKDkIdJ+9ajmrnvCg9LJVCmysy/y2BLW6a/N8Vyf4TaEWkp8uaaggNhblz
         ialpJn2FhMdWfNFDP+Su8KkkSaej5YsqH9B5wLpqJxnLR6JqVv02sBR7khSw3pKebtbF
         nXRLjLLckBReQ2k4XKiZkKTRsh1qw3CqoAkxOhd6mN+w8Bhe3Dsm/8A0ewMN86bz2f6m
         GRmJ0XuFE/m/6V1oTSbAxgsfTpuGqyXj6+7/CqLradcnzml201QToX0kX1jMxvH4tiOq
         EvJw==
X-Gm-Message-State: AOAM531pwsRFE3PYI8JzkHmD3PQnQCcBHYS8M+tGubfse2/upkrUFJeR
        DHRnA69feG8hz8h9qV0YIW4ZhH7Y1S1yAUI53ft+JweMhnn1FA==
X-Google-Smtp-Source: ABdhPJzSQ7O55PbHyL96fLLmETc012OWfrAW4TyptRWcblE5n075LOE4GWuq/c7t9xeX6Ys2SUohmbBRv/eGXi1rhzk=
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr387798wmb.131.1602030445575;
 Tue, 06 Oct 2020 17:27:25 -0700 (PDT)
MIME-Version: 1.0
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 7 Oct 2020 02:27:15 +0200
Message-ID: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
Subject: Failure in test_local_storage at bpf-next
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I noticed that test_local_storage is broken due to a BTF error at
bpf-next [67ed375530e2 ("samples: bpf: Driver interrupt statistics in
xdpsock")]

./test_progs -t test_local_storage
libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
libbpf: failed to perform CO-RE relocations: -22
libbpf: failed to load object 'local_storage'
libbpf: failed to load BPF skeleton 'local_storage': -22
test_test_local_storage:FAIL:skel_load lsm skeleton failed

by changing it to use vmlinux.h with:

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/>
index 0758ba229ae0..95fad5aca6af 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -4,9 +4,8 @@
  * Copyright 2020 Google LLC.
  */

+#include "vmlinux.h"
 #include <errno.h>
-#include <linux/bpf.h>
-#include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>

@@ -36,23 +35,6 @@ struct {
        __type(value, struct dummy_storage);
 } sk_storage_map SEC(".maps");

-/* TODO Use vmlinux.h once BTF pruning for embedded types is fixed.
- */
-struct sock {} __attribute__((preserve_access_index));
-struct sockaddr {} __attribute__((preserve_access_index));
-struct socket {
-       struct sock *sk;
-} __attribute__((preserve_access_index));
-
-struct inode {} __attribute__((preserve_access_index));
-struct dentry {
-       struct inode *d_inode;
-} __attribute__((preserve_access_index));
-struct file {
-       struct inode *f_inode;
-} __attribute__((preserve_access_index));
-
-
 SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {

I get a very similar error:

root@kpsingh:~# ./test_progs -t test_local_storage
libbpf: prog 'socket_post_create': relo #0: parsing [83] struct socket + 0:4.1 2
libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
libbpf: failed to perform CO-RE relocations: -22
libbpf: failed to load object 'local_storage'
libbpf: failed to load BPF skeleton 'local_storage': -22
test_test_local_storage:FAIL:skel_load lsm skeleton failed
#106 test_local_storage:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

clang --version
clang version 12.0.0 (https://github.com/llvm/llvm-project.git
6c7d713cf5d9bb188f1e73452a256386f0288bf7)
Target: x86_64-unknown-linux-gnu
Thread model: posix

pahole --version
v1.18

This error goes away if I comment out the lsm/socket_post_create or
the lsm/socket_bind which makes me think that something in
bpf_core_apply_relo does not like two programs in the same object
having the same BTF type in its signature (but this just a guess, I
did not investigate more).  I was wondering if anyone has any ideas
what could be going on here.

PS: While working on task local storage, I noted that some of the
checks in this test were buggy and will send a patch to fix them as
well.

- KP
