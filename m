Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E162F975
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 16:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKRPki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbiKRPkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 10:40:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71B15A21
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 07:40:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B430B8244F
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 15:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C064AC433D6;
        Fri, 18 Nov 2022 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668786033;
        bh=/sE9dvVNL4WMRhMC/tbSFEO1XcCXIc/v9kH5tnU3I6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=GO1wY3D6XJdmitZekafqPIme2xctwgAn0tGMI0cz0tgKyRrY0aj2EP/tiuu/W9GQ4
         rLr9NFwqfcsZhDHSwi7kC9q4681dQwOPvIAlMu8wD7X4qvarQMxeNkaFl+XN8YIbaT
         Mh67udlgmVMZnGnmUmgWVyXY9X7V0ixXRKXo09kOUrk7/0MLNEJhLz4gpZ8p1jF2eR
         LMnQwuiPa3SDN5/Ov+J263jHVQZN6De94tkCVZWvODszn/yzfisv/mZqMFT0CZAiGD
         9joWX0UD4D8xLhG4orwo1NlhlNTYmPkNN55FBY+ZBqar4GtKysNVD2qs857tFtD3Ao
         6n7g3aJ63A8/g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf-next 0/2] bpf: Add bpf_vma_build_id_parse kfunc
Date:   Fri, 18 Nov 2022 16:40:26 +0100
Message-Id: <20221118154028.251399-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
first version of this patchset added helper for this functionality,
but based Alexei's feedback [1], changing it to kfunc.

With the current build_id_parse function as kfunc we can't effectively
check buffer size provided by user. Therefore adding new function as
bpf kfunc:

  int bpf_vma_build_id_parse(struct vm_area_struct *vma,
                             unsigned char *build_id,
                             size_t build_id__sz);

that triggers kfunc's verifier check for build_id/build_id__sz buffer
size and calls build_id_parse.

v3 changes:
  - restrict bpf_vma_build_id_parse to bpf_find_vma callback
  - move bpf_vma_build_id_parse to kernel/trace/bpf_trace.c
    and add new tracing_kfunc_set

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAADnVQKyT4Mm4EdTCYK8c070E-BwPZS_FOkWKLJC80riSGmLTg@mail.gmail.com/
---
Jiri Olsa (2):
      bpf: Add bpf_vma_build_id_parse function and kfunc
      selftests/bpf: Add bpf_vma_build_id_parse kfunc test

 include/linux/bpf.h                                             |  4 ++++
 kernel/bpf/verifier.c                                           | 26 ++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c                                        | 31 +++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 189 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
