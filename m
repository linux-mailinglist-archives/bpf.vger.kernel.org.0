Return-Path: <bpf+bounces-75772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F298BC94B3A
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 05:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61B6B4E155C
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 04:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384A22688C;
	Sun, 30 Nov 2025 04:03:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66446B5
	for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764475434; cv=none; b=ipcrj92diREI0EyHZfv3d6ZnKQxZN90Nr/58CVzpAYd/D71UNFoG/0HMfLZj7ENVcOxnAbaO+iBhyEGkR/jca7JDQ4/qqnGgbIs578BFj9FcJAufPjblal8P8hnamXxSIBPmz56uNrQ+/LsxIFOrNctmST+HubEymN+NKebuWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764475434; c=relaxed/simple;
	bh=Pi+uRRXTqjdCTHs0keobIT+ISn7uebdl8n3ibZHys/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAbThNjxqDxwdBQSBwXFZNGWzz2Sj4Hmg5dgURhTKDNVMlcQECOrZ7ok9aoHSa10QfnXJzLCUEhysiEDFtwE/yXLDFglDqbe33ebmXagUhJMs4wIQs6Aw/MhD+jW84VVSeNbS85lnFlLrUfY1rnvnhkVF5pIS1E44Vaq3Zaps+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3C24115D63B5B; Sat, 29 Nov 2025 20:03:40 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	David Faust <david.faust@oracle.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 0/2] pahole: Replace or add functions with true signatures in btf
Date: Sat, 29 Nov 2025 20:03:40 -0800
Message-ID: <20251130040340.2636458-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current vmlinux BTF encoding is based on the source level signatures.
But the compiler may do some optimization and changed the signature.
If the user tried with source level signature, their initial implementati=
on
may have wrong results and then the user need to check what is the
problem and work around it, e.g. through kprobe since kprobe does not
need vmlinux BTF.

The following is a concrete example for [1].
The original source signature:
  typedef struct {
        union {
                void            *kernel;
                void __user     *user;
        };
        bool            is_kernel : 1;
  } sockptr_t;
  typedef sockptr_t bpfptr_t;
  static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
After compiler optimization, the signature becomes:
  static int map_create(union bpf_attr *attr, bool is_kernel) { ... }

To do proper tracing, it would be good for the users to know the
changed signature. With the actual signature, both kprobe and fentry
should work as usual. This can avoid user surprise and improve
developer productivity.

The llvm compiler patch [1] collects true signature and encoded those
functions in dwarf. pahole will process these functions and
replace old signtures with true signatures. Additionally,
new functions (e.g., foo.llvm.<hash>) can be encoded in
vmlinux BTF as well.

Patches 1 is a refactor change. Patch 2 has the detailed explanation
in commit message and implements the logic to encode replaced or new
signatures to vmlinux BTF. Please see Patch 2 for details.

  [1] https://github.com/llvm/llvm-project/pull/165310

Changelogs:
  v1 -> v2:
   - v1: https://lore.kernel.org/bpf/20251111170424.286892-1-yonghong.son=
g@linux.dev/
   - For functions like <foo>.llvm.<hash>() where the function <foo> is p=
romoted
     to <foo>.llvm.<hash>(). Previous llvm ([1]) allows to have new-signa=
ture dwarf
     entries for both <foo> and <foo>.llvm.<hash> and pahole will generat=
e two
     new functions. Now, llvm will only generate one entry with name <foo=
>.llvm.<hash>
     so pahole will generate one entry for <foo>.llvm.<hash>.
   - Since v2 approach intends to generate functions with name in kallsym=
s,
     removing function suffix is avoided.

Yonghong Song (2):
  btf_encoder: Refactor elf_functions__new() with struct btf_encoder as
    argument
  pahole: Replace or add functions with true signatures in btf

 btf_encoder.c  | 52 +++++++++++++++++++++++++-------
 dwarf_loader.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h      |  4 +++
 pahole.c       |  9 ++++++
 4 files changed, 136 insertions(+), 10 deletions(-)

--=20
2.47.3


