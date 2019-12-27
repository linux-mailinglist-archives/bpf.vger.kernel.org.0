Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347B412B4D0
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2019 14:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfL0NVu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Dec 2019 08:21:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:40716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfL0NVt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Dec 2019 08:21:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89819B215;
        Fri, 27 Dec 2019 13:21:47 +0000 (UTC)
From:   mrostecki@opensuse.org
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Rostecki <mrostecki@opensuse.org>
Subject: [PATCH bpf-next 0/2] bpftool/libbpf: Add probe for large INSN limit
Date:   Fri, 27 Dec 2019 11:53:44 +0100
Message-Id: <20191227105346.867-1-mrostecki@opensuse.org>
X-Mailer: git-send-email 2.16.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Michal Rostecki <mrostecki@opensuse.org>

This series implements a new BPF feature probe which checks for the
commit c04c0d2b968a ("bpf: increase complexity limit and maximum program
size"), which increases the maximum program size to 1M. It's based on
the similar check in Cilium, althogh Cilium is already aiming to use
bpftool checks and eventually drop all its custom checks.

Examples of outputs:

# bpftool feature probe
[...]
Scanning miscellaneous eBPF features...
Large complexity limit and maximum program size (1M) is available

# bpftool feature probe macros
[...]
/*** eBPF misc features ***/
#define HAVE_HAVE_LARGE_INSN_LIMIT

# bpftool feature probe -j | jq '.["misc"]'
{
  "have_large_insn_limit": true
}

Michal Rostecki (2):
  libbpf: Add probe for large INSN limit
  bpftool: Add misc secion and probe for large INSN limit

 tools/bpf/bpftool/feature.c   | 18 ++++++++++++++++++
 tools/lib/bpf/libbpf.h        |  1 +
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 23 +++++++++++++++++++++++
 4 files changed, 43 insertions(+)

-- 
2.16.4

