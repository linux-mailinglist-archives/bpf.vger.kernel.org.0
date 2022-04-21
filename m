Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8850A1BF
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388814AbiDUOKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387503AbiDUOKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 819F12AC5
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=prVzIo1GwtCwuoe6EtlDofBh6VTrEATes2v0MdzWadE=;
        b=jVAN5glE1Bk/RrR1yWZk8oqyvwKNtTD23NcJUEBhtMLyG/gsq8ee/aoRky45bxXAZBWq0F
        Wknu8yNqUlPffw24TuIQgg9T0OSTg/NunVO2MePyHy/iDdaZa+RTxgbKCFCYuw1QhUpIDz
        wbpvpFi+Mpcz798Q4KplNjRU2gC89CY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-Yg_QxmqEPFStLVmqi_BH3g-1; Thu, 21 Apr 2022 10:07:46 -0400
X-MC-Unique: Yg_QxmqEPFStLVmqi_BH3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA518185A7B2;
        Thu, 21 Apr 2022 14:07:45 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F79540EC002;
        Thu, 21 Apr 2022 14:07:43 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices (new attempt)
Date:   Thu, 21 Apr 2022 16:07:33 +0200
Message-Id: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

so after the reviews from v3, and some discussion with Alexei, I am
back with a new version of HID-BPF.

This version is not complete (thus the RFC), but I'd like to share
it now to get initial feedback, in case I am too far from the actual
goal.

FTR, the goal is to provide some changes in the core verifier/btf so
that we can plug in HID-BPF independently from BPF core. This way we can
extend it without having to care about bpf-next.

The things I am not entirely sure are:
- do we need only fentry/fexit/fmod_ret BPF program types or should
  programs that modify the data stream use a different kind?
- patch 3/7 is probably not the correct approach (see comments in the
  patch itself)

We are missing quite a few bits here:
- selftests for patches 1 to 4
- add the ability to attach a program to a struct device, and run that
  program only for that struct device
- when running through bpf_prog_test_run_opts, how can we ensure we are
  talking to the correct device? (I have a feeling this is linked to the
  previous point)
- how can we reconnect the device when a report descriptor fixup BPF
  program is loaded (would it make sense to allow some notifications on
  when a BPF program is attached/detached to a device, and which
  function have been traced?)

Cheers,
Benjamin

Benjamin Tissoires (7):
  bpf/btf: also allow kfunc in tracing programs
  bpf/verifier: allow kfunc to return an allocated mem
  error-inject: add new type that carries if the function is non
    sleepable
  btf: Add a new kfunc set which allows to mark a function to be
    sleepable
  HID: initial BPF new way implementation
  samples/bpf: add new hid_mouse example
  selftests/bpf: add tests for the HID-bpf initial implementation

 drivers/hid/hid-core.c                       | 115 +++++
 include/asm-generic/error-injection.h        |   1 +
 include/linux/btf.h                          |   8 +
 include/linux/hid_bpf.h                      |  29 ++
 kernel/bpf/btf.c                             |  50 +-
 kernel/bpf/verifier.c                        |  76 ++-
 lib/error-inject.c                           |   2 +
 samples/bpf/.gitignore                       |   1 +
 samples/bpf/Makefile                         |  23 +
 samples/bpf/hid_mouse.bpf.c                  |  59 +++
 samples/bpf/hid_mouse.c                      | 131 +++++
 tools/testing/selftests/bpf/config           |   3 +
 tools/testing/selftests/bpf/prog_tests/hid.c | 482 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/hid.c      |  32 ++
 14 files changed, 987 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/hid_bpf.h
 create mode 100644 samples/bpf/hid_mouse.bpf.c
 create mode 100644 samples/bpf/hid_mouse.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/hid.c
 create mode 100644 tools/testing/selftests/bpf/progs/hid.c

-- 
2.35.1

