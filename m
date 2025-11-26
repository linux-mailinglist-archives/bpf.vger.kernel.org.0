Return-Path: <bpf+bounces-75523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC7C87B14
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D0A3B2C38
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425532F693F;
	Wed, 26 Nov 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQPKkn1H"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C71487F6
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120573; cv=none; b=Yum1RG6/emUtJR5eB+WWbEhbHGt3VUtsAjVB9ApvFloBF7UowJ56Sv/na+UmK9QQgc/nHl4KdFXVMVJNI5UD22OVHifgpsHNTzE+IZ0DBtvzLwel7LffBbUnetd72AdukRglNU8qqurjr0fuF4LzPvC8qWr9FCezXXsfLSnxJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120573; c=relaxed/simple;
	bh=n2X3JWxlTK8i4PVuAHHUq0gI8A+/6VVcynVURw4yewc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7F0d1lzyL8dxkrh8aPTd7fS754KBDIMaLcDui2qAywWDhbOugaUFyDwVKPS/r2ctjt8Gi+Kdn/Ag4EtMQ/USJeE5Lybpmenfa8yZxLW2JKypHd1Jjux3ZQzhHzx5tIYauI21XQTEg8l0gqduhGYZqIe4nRPCprU6WERBmMh00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQPKkn1H; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764120565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8qheR5XkwoZppy3WCOnzTETWTTsx4anXNEgASd+Wbo4=;
	b=iQPKkn1Has/Q5hxWhJyBd42IjWMHyNAn2LZ5BAWEuPR9qw/aSNLSwpcYO1bIpbbcXiAOhI
	M4S2UqZTxkpUMuyOnf8v6LP9r3lYsNFngBsxI/LhkIjDRV7r0BQdx07KEEGQ/HTf0gzcU/
	AIE+HMU6K/to/gS/yuycxiPcLi5cao0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH bpf-next v1 0/4] resolve_btfids: Support for BTF modifications
Date: Tue, 25 Nov 2025 17:26:52 -0800
Message-ID: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series changes resolve_btfids and kernel build scripts to enable
BTF transformations in resolve_btfids. Main motivation for enhancing
resolve_btfids is to reduce dependency of the kernel build on pahole
capabilities [1] and enable BTF features and optimizations [2][3]
particular to the kernel.

Patches #1-#3 in the series are non-functional refactoring in
resolve_btfids. The last patch (#4) makes significant changes in
resolve_btfids and introduces scripts/gen-btf.sh. Implementation
changes are described in detail in the patch description.

One RFC item in this patchset is the --distilled_base [4] handling.
Before this patchset .BTF.base was generated and added to target
binary by pahole, based on these conditions [5]:
  * pahole version >=1.28
  * the kernel module is out-of-tree (KBUILD_EXTMOD)

Since BTF finalization is now done by resolve_btfids, it requires
btf__distill_base() to happen there. However, in my opinion, it is
unnecessary to add and pass through a --distilled_base flag for
resolve_btfids.

Logically, any split BTF referring to kernel BTF is not very useful
without the .BTF.base, which is why the feature was developed in the
first place. Therefore it makes sense to always emit .BTF.base for all
modules, unconditionally. This is implemented in the series.

However it might be argued that .BTF.base is redundant for in-tree
modules: it takes space the module ELF and triggers unnecessary
btf__relocate() call on load [6]. It can be avoided by special-casing
in-tree module handling in resolve_btfids either with a flag or by
checking env variables. The trade-off is slight performance impact vs
code complexity.

[1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
[2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
[3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/
[4] https://docs.kernel.org/bpf/btf.html#btf-base-section
[5] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/Makefile.btf#n29
[6] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/kernel/bpf/btf.c#n6358

Ihor Solodrai (4):
  resolve_btfids: rename object btf field to btf_path
  resolve_btfids: factor out load_btf()
  resolve_btfids: introduce enum btf_id_kind
  resolve_btfids: change in-place update with raw binary output

 MAINTAINERS                     |   1 +
 scripts/Makefile.modfinal       |   5 +-
 scripts/gen-btf.sh              | 166 ++++++++++++++++++++++
 scripts/link-vmlinux.sh         |  42 +-----
 tools/bpf/resolve_btfids/main.c | 234 +++++++++++++++++++++++---------
 5 files changed, 348 insertions(+), 100 deletions(-)
 create mode 100755 scripts/gen-btf.sh

-- 
2.52.0


