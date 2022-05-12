Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3354525300
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353169AbiELQvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348145AbiELQu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 12:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BAC2BB02
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 09:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD8B62025
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 16:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C43C34116;
        Thu, 12 May 2022 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374256;
        bh=LHQlmjIB4q1jyQ4/vqOaPco7Q/3wSphQdQJwNbquCkM=;
        h=From:To:Cc:Subject:Date:From;
        b=cRtRag3c0HSn3bujHjjLnEUmiB9Cf9tPCHeQqJr/yhacCUDP7fzlh5aoDs5zUSPlw
         7CViSyxOpwvISdDlq11LNIYAO98zJmp+VZy3B3QXPFYZYT6Q/IG5UF7fn1GHyna7LX
         lg+ejfL+33sOGez4yri7vZgrU09KRkMogGuoDgqyl+HT8hME//o3mdblJB90WjV3t6
         bRWty7AZdpP86xDjNDoMffNrzo/C7LBl0ycFqtThrnnzVedQCUWrxkGcXgYONNzcnq
         DBBqQzdkS/hA5wOJ5Uadf7K9WHFrmxibhzhqOp0+eGZR9PmFnF+8bhJ2vR92rN8yJm
         FtVuNsPQEFAjA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/2] Add bpf_getxattr
Date:   Thu, 12 May 2022 16:50:49 +0000
Message-Id: <20220512165051.224772-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Foundation for building more complex security policies using the
BPF LSM as presented in LSF/MM/BPF:

 http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf

KP Singh (2):
  bpf: Implement bpf_getxattr helper
  bpf/selftests: Add a selftest for bpf_getxattr

 include/uapi/linux/bpf.h                      |  8 +++
 kernel/trace/bpf_trace.c                      | 26 +++++++++
 scripts/bpf_doc.py                            |  5 ++
 tools/include/uapi/linux/bpf.h                |  8 +++
 .../testing/selftests/bpf/prog_tests/xattr.c  | 58 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/xattr.c     | 34 +++++++++++
 6 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/xattr.c

-- 
2.36.0.550.gb090851708-goog

