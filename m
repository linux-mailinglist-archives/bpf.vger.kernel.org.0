Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E963F55E0
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 04:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhHXCou (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 22:44:50 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37033 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbhHXCou (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 22:44:50 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E6BCF580528;
        Mon, 23 Aug 2021 22:44:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 23 Aug 2021 22:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=uLm2J7/S5b/a19Z88v+3mZDrnM
        xsLeSoPJZlNsL0vnQ=; b=Tg4X575pF1E5q6IOmQRRyOQFvXfMxNjjM6TANMh8Pi
        GyG5tuzWYBTu9htLmmFntv/UPTxGoj0X99M9YSYnfvcKqpCbR3X5neNCcLos0pK1
        ev4BvH6RyKAk1zfRbU2ldfYSwZrkLZHYUJyc5ymrzulYaY5yzn0P76z9PUftim4N
        jJzaOPniIzG239zJ82TQGTMCfRSB7oPIuMJP0OolIXElTspymiXma26aYIVOP2jN
        eE/ZMuq73chHQtb3nPbrHaTRf2l44X4tniWVAPIqXOLHYPTx2t10xINrqzqElTqV
        KdmbCSG8SlaD3JROU11jEJJaTPz38ELeKGJcMZ3waPvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uLm2J7/S5b/a19Z88
        v+3mZDrnMxsLeSoPJZlNsL0vnQ=; b=bSomiLFm+dxjDNKxmkVGMQWX1WmWqpZ62
        A29krZED67AgAYkKHuLf+s2jzsYOb+chTHrSvR6fiQU92TRPB63jA5nFdn2Ks2R6
        hSpma02QhvD/V88s1aPjveQ//+RmG/EUnguYUoy+3q9nYV5vRSmHXJDchloetYWJ
        mbEDZ3nsULUkAjBiGFFbM5nnicbF+Ae+BSb9uJJa7J/SL1CIfDNDkoD5pXDjgUsf
        QwtasJ4S8eS0TpIU69ytBWpU4wCDbnsj+5zbXrCFSS5+A29V8eW6L8Qodh0sBDuL
        JydvzmAehyLpZSmzDyk0kLXFDLdLJ4kxRV1izDPRc3CjcGJlO8c1Q==
X-ME-Sender: <xms:9VwkYZVEqT3ZOil-udiO51spYdCwdOaZrWxVp9NUNsXmYBOmrjkclA>
    <xme:9VwkYZktAgxgb3CkXLadR-_sn-Ioc_uJqc8wH9xs3_c-GeZZ30CMCwlzD-zj_dgzc
    F1Hni6GyvCY01Cgpg>
X-ME-Received: <xmr:9VwkYVY4UcAlNUkolTFYb-onlKYTJQcYp3NyqixQoq8NlC7MDVk_0DXMeqsfcvPmYBw2V3z5qC1MrKRIan9mBXDGpVzunkeD6a5iGjPQVaoY8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenogevohgrshhtrg
    hlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffoggfgsedtkeertder
    tddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepfeegheduleejgeeugeeuvdegueevleeitedufffgvdekleeh
    kedvjeffhfeffeejnecuffhomhgrihhnpehlkhhmlhdrohhrghdpghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugig
    uhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:9VwkYcWsXaN_Tl1jPv9umQ676AWvlc2WrMxruM4a99Hh9cAWOIV4MQ>
    <xmx:9VwkYTlS-w8zsIKnYhyl-Y7bs89Kr5BS8MRuQThyBuH1GEo5yW1kDQ>
    <xmx:9VwkYZfUU1XvwcUVuVD7SsntE-xhWw1928DjbuhYnCGlxUjprbnMkw>
    <xmx:9VwkYcAXJMjsz0P2ipxzAnY2PYexgMRZ_Iqti-LqU-WnJuU2GVkebQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 22:44:04 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/5] bpf: Add bpf_task_pt_regs() helper
Date:   Mon, 23 Aug 2021 19:43:45 -0700
Message-Id: <cover.1629772842.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The motivation behind this helper is to access userspace pt_regs in a
kprobe handler.

uprobe's ctx is the userspace pt_regs. kprobe's ctx is the kernelspace
pt_regs. bpf_task_pt_regs() allows accessing userspace pt_regs in a
kprobe handler. The final case (kernelspace pt_regs in uprobe) is
pretty rare (usermode helper) so I think that can be solved later if
necessary.

More concretely, this helper is useful in doing BPF-based DWARF stack
unwinding. Currently the kernel can only do framepointer based stack
unwinds for userspace code. This is because the DWARF state machines are
too fragile to be computed in kernelspace [0]. The idea behind
DWARF-based stack unwinds w/ BPF is to copy a chunk of the userspace
stack (while in prog context) and send it up to userspace for unwinding
(probably with libunwind) [1]. This would effectively enable profiling
applications with -fomit-frame-pointer using kprobes and uprobes.

[0]: https://lkml.org/lkml/2012/2/10/356
[1]: https://github.com/danobi/bpf-dwarf-walk

Changes from v1:
- Conwolidate BTF_ID decls for task_struct
- Enable bpf_get_current_task_btf() for all prog types
- Enable bpf_task_pt_regs() for all prog types
- Use ASSERT_* macros instead of CHECK

Daniel Xu (5):
  bpf: Add BTF_ID_LIST_GLOBAL_SINGLE macro
  bpf: Consolidate task_struct BTF_ID declarations
  bpf: Extend bpf_base_func_proto helpers with
    bpf_get_current_task_btf()
  bpf: Add bpf_task_pt_regs() helper
  bpf: selftests: Add bpf_task_pt_regs() selftest

 include/linux/btf_ids.h                       |  5 ++
 include/uapi/linux/bpf.h                      |  7 +++
 kernel/bpf/bpf_task_storage.c                 |  6 +--
 kernel/bpf/helpers.c                          |  6 +++
 kernel/bpf/stackmap.c                         |  4 +-
 kernel/bpf/task_iter.c                        | 11 ++---
 kernel/trace/bpf_trace.c                      | 25 ++++++++--
 tools/include/uapi/linux/bpf.h                |  7 +++
 .../selftests/bpf/prog_tests/task_pt_regs.c   | 47 +++++++++++++++++++
 .../selftests/bpf/progs/test_task_pt_regs.c   | 29 ++++++++++++
 10 files changed, 131 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_pt_regs.c

-- 
2.33.0

