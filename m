Return-Path: <bpf+bounces-59195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C0AC72F4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911A9167777
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9A21FF41;
	Wed, 28 May 2025 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RXrXPq/L"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8868A1DFFC;
	Wed, 28 May 2025 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469050; cv=none; b=TRxWE3Ic8s3t4y0jjsbAWfeoOd/WSg9FUtrQqwFBUWF+oOsTtMjp4T4CkaHknXiluj2Qc57+dpF4LHErHXk9przM2s1VGx6UGnB3tlw5xLrNHz+ofakIKSLwtc0pIRTl9BtTfXf6egwsjSxzjGwq9ixq2g4PlhXeB/iT/NrIXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469050; c=relaxed/simple;
	bh=YcT1GjnH1ix3Hf2n1JVSjZ7SLshS6F8OF/fMw8ktYXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SpfBQtR2GvFxnk52RvHpBIWXAM9DzA7ARJcvRYdbEs1dUXIebwf3oe10fFkV11o1NVcdp4MnyKjKcj9wdl5qvSWFwmqDALOHCbZubrUeWvDjCP9OgFyf7oUvf+Fl2JzeB0dzGAdIRQ2txTOsKYRIfzfSw/Kj59ciFI9BHWVYOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RXrXPq/L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B517207860F;
	Wed, 28 May 2025 14:50:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B517207860F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748469048;
	bh=HjZx60XrcN96ZNYCOO5IXgNhQ4tLOgnr0P8/yA+GqsQ=;
	h=From:To:Subject:Date:From;
	b=RXrXPq/LIr/YPpS9qtiEXzftGS13aDvZ6G3sJ0hTbiPtM/8HxKhsksnK1x77FtQwK
	 9getRppvdRl8jsCMh9YXVMbmakvBCgtsijEctcAagbzu4TP/z4/oiH14XEpBdp/B91
	 5j+ScvIY3eWE9vCjQA7QWO/Yx53ew7OFFBPInzRw=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	bboscaccy@linux.microsoft.com,
	jarkko@kernel.org,
	zeffron@riotgames.com,
	xiyou.wangcong@gmail.com,
	kysrinivasan@gmail.com,
	code@tyhicks.com,
	linux-security-module@vger.kernel.org,
	roberto.sassu@huawei.com,
	James.Bottomley@hansenpartnership.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Quentin Monnet <qmo@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Matteo Croce <teknoraver@meta.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH 0/3] BPF signature verification
Date: Wed, 28 May 2025 14:49:02 -0700
Message-ID: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As suggested or mandated by KP Singh
https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/,
this patchset proposes and implements an alternative hash-chain
algorithm for signature verification of BPF programs.

This design diverges in two key ways:

1. Signature Strategy

Two different signature strategies are
implemented. One verifies only the signature of the loader program in
the kernel, as described in the link above. The other verifies the
program’s maps in-kernel via a hash chain.  The original design
required loader programs to be “self-aborting” and embedded the
terminal hash verification logic as metaprogramming code generation
routines inside libbpf. While this patchset supports that scheme, it
is considered undesirable in certain environments due to the potential
for supply-chain attack vectors and the lack of visibility for the LSM
subsystem.  Additionally, it is impossible to verify the code
performing the signature verification, as it is uniquely regenerated
for every program.

2. Timing of Signature Check

This patchset moves the signature check to a point before
security_bpf_prog_load is invoked, due to an unresolved discussion
here:
https://lore.kernel.org/linux-security-module/CAHC9VhTj3=ZXgrYMNA+G64zsOyZO+78uDs1g=kh91=GR5KypYg@mail.gmail.com/
This change allows the LSM subsystem to be informed of the signature
verification result—if it occurred—and the method used, all without
introducing a new hook. It improves visibility and auditability,
reducing the “trust me, friend” aspect of the original design.


Blaise Boscaccy (3):
  bpf: Add bpf_check_signature
  bpf: Support light-skeleton signatures in autogenerated code
  bpftool: Allow signing of light-skeleton programs

 include/linux/bpf.h            |   2 +
 include/linux/verification.h   |   1 +
 include/uapi/linux/bpf.h       |   4 +
 kernel/bpf/arraymap.c          |  11 +-
 kernel/bpf/syscall.c           | 123 +++++++++++++++++++-
 tools/bpf/bpftool/Makefile     |   4 +-
 tools/bpf/bpftool/common.c     | 204 +++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/gen.c        |  66 ++++++++++-
 tools/bpf/bpftool/main.c       |  24 +++-
 tools/bpf/bpftool/main.h       |  23 ++++
 tools/include/uapi/linux/bpf.h |   4 +
 tools/lib/bpf/libbpf.h         |   4 +
 tools/lib/bpf/skel_internal.h  |  28 ++++-
 13 files changed, 491 insertions(+), 7 deletions(-)

-- 
2.48.1


