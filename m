Return-Path: <bpf+bounces-74244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C0EC4F2ED
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57DCD4EC6C4
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7240136C5AA;
	Tue, 11 Nov 2025 17:04:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79453115BD
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880681; cv=none; b=jmZy7t2/4Z9S9WYCsrlhY9LEagJEykwp8XwnNgqWgxNbzn09CTRqG8VP6As0smvdtqtByRYQmgceRJcdN0FMeOaaLeGjFnUvUUmhkNw0erY2cBezkOgUAlwdmN7hMVUcBYtKFAYOPQgTeYMCPeNBRaqECYvsz4W6LITyQV1BTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880681; c=relaxed/simple;
	bh=OxYODRbxQBMUVVOcY+3Zb//XqJeaJRWPR9E5F4ZNbNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmsBzUh5qY9jfgL9+SIXLWSSAPKlJXyE1PqJA9CueNLAuHQ76x73b8QAuRUCUH4CCFxV9dvj9O57igCzVmlAWKQpI5NNrVC9DcFFNrvopfWEX1BDQYEonRpPdbna3jQ5M4WX98hGTy56+tn7qvNPt7fvJ41y+/7CFwXiHUQE2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CA2BF14B819E3; Tue, 11 Nov 2025 09:04:24 -0800 (PST)
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
Subject: [PATCH dwarves 0/3] pahole: Replace or add functions with true signatures in btf
Date: Tue, 11 Nov 2025 09:04:24 -0800
Message-ID: <20251111170424.286892-1-yonghong.song@linux.dev>
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
need vmlinux BTF.=20

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
  static int map_create(union bpf_attr *attr, bool uattr__coerce1) { ... =
}
 =20
In the above, uattr__coerce1 corresponds to 'is_kernel' field in sockptr_=
t.
Here, the suffix '__coerce1' refers to the second 64bit value in
sockptr_t. The first 64bit value will be '__coerce0' if that value
is used instead.

To do proper tracing, it would be good for the users to know the
changed signature. With the actual signature, both kprobe and fentry
should work as usual. This can avoid user surprise and improve
developer productivity.

The llvm compiler patch [1] collects true signature and encoded those
functions in dwarf. pahole will process these functions and
replace old signtures with true signatures. Additionally,
new functions (e.g., foo.llvm.<hash>) can be encoded in
vmlinux BTF as well.

Patches 1/2 are refactor patches. Patch 3 has the detailed explanation
in commit message and implements the logic to encode replaced or new
signatures to vmlinux BTF. Please see Patch 3 for details.

  [1] https://github.com/llvm/llvm-project/pull/165310

Yonghong Song (3):
  btf_encoder: Refactor elf_functions__new() with struct btf_encoder as
    argument
  bpf_encoder: Refactor a helper elf_function__check_and_push_sym()
  pahole: Replace or add functions with true signatures in btf

 btf_encoder.c  | 79 +++++++++++++++++++++++++++++++++++---------
 dwarf_loader.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h      |  4 +++
 pahole.c       |  9 +++++
 4 files changed, 165 insertions(+), 16 deletions(-)

--=20
2.47.3


