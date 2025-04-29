Return-Path: <bpf+bounces-56890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA5FAA014B
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A7C16DC2D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D81027057C;
	Tue, 29 Apr 2025 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiMtYsEp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3D149C7B
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899972; cv=none; b=Bh7iw3IPmU7Zuof2mCfHVQfNnMO3cLesLRzqkXC64rT9wApOBxfynTgp5m5d6IADsQVQSahy4Ppe8xzZcoNya1Q5DDImaI+sWbVXC8FOl4cnPySTsNCLDkmyvOUgsOp+DtJZAFsTZUdz9UZoQECn4jYqG2IaZjp76qHdSwcvA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899972; c=relaxed/simple;
	bh=KzqpQbWyZZtTQ+oKFalLurNHQy9e7zUBF9t2i4koE+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrKNgwcCGRNReu8m72DUFaFgZC21aaDcTk2y5BpbNiKjcFM+y0qyDTSQhmYsGOwNtXfptyxemWuRg7me931E2Yx+6gAO2F89l3iVsy7YH54WWnHftExcZER7dys0oBt4KN/lob30MPLe9GBPGyMTOHwxpRlAcNhVsHYGu4F2Qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iiMtYsEp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745899970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PP3UZCRXo5SRQBH/gKG6K8b23DsH47+kPesgSOGR+84=;
	b=iiMtYsEptw70c5M1RPnYDBiEgCWlTVNri10OOXPK5s40SuIMuVAUTIj9BONoF0Djc5jx7E
	SuVCKi60wpJ6lLhiaLNt/cmoUsku0RNJlHnM83cfUe1UgC0kGNA1jfJO7gZkD9Qm37rgR+
	fdV19tho44eIsD3WmDJtjy8MgLDTEkE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-2UFOZHtXPTevcHI0_Vi3XA-1; Tue,
 29 Apr 2025 00:12:44 -0400
X-MC-Unique: 2UFOZHtXPTevcHI0_Vi3XA-1
X-Mimecast-MFC-AGG-ID: 2UFOZHtXPTevcHI0_Vi3XA_1745899962
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B19C81800264;
	Tue, 29 Apr 2025 04:12:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C4851800352;
	Tue, 29 Apr 2025 04:12:27 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [RFCv2 0/7] kexec: Use BPF lskel to enable kexec to load PE format boot image
Date: Tue, 29 Apr 2025 12:12:07 +0800
Message-ID: <20250429041214.13291-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

*** Review the history ***

Nowadays UEFI PE bootable image is more and more popular on the distribution.
But it is still an open issue to load that kind of image by kexec with IMA enabled

There are several approaches to reslove this issue, but none of them are
accepted in upstream till now.

The summary of those approaches:
  -1. UEFI service emulator for UEFI stub
  -2. PE format parser in kernel

For the first one, I have tried a purgatory-style emulator [1]. But it
confronts the hardware scaling trouble.  For the second one, there are two
choices, one is to implement it inside the kernel, the other is inside the user
space.  Both zboot-format [2] and UKI-format [3] parsers are rejected due to
the concern that the variant format parsers will inflate the kernel code.  And
finally, we have these kinds of parsers in the user space 'kexec-tools'.


*** The approach in this series ***

This approach allows the various PE boot image to be parsed in the bpf-prog,
as a result, the kexec kernel code to remain relatively stable.

To protect against malicious attacks on the BPF loader in user space, it
employs BPF lskel to load and execute BPF programs from within the
kernel.

Each type of PE image contains a dedicated section '.bpf', which stores
the bpf-prog designed to parse the format.  This ensures that the PE's
signature also protects the integrity of the '.bpf' section.


The parsing process operates as a pipeline. The current BPF program
parser attaches to bpf_handle_pefile() and detaches at the end of the
current stage via disarm_bpf_prog(). The results parsed by the current
BPF program are buffered in the kernel through prepare_nested_pe() and
then delivered to the next stage. For each stage of the pipeline, the
BPF bytecode is stored in the '.bpf' section of the PE file. That means
a vmlinuz.efi embeded in UKI format can be handled.


Special thanks to Philipp Rudo, who spent significant time evaluating
the practicality of my solution, and to Viktor Malik, who guided me
toward using BPF light skeleton to prevent malicious attacks from user
space.


*** To do ***
For Poc, this series uses BPF fentry to call the parsing function.
Later, it should implement a dedicated BPF_PROG_TYPE and confine the use
of the newly introduced three kfuncs to the kexec_file_load context



[1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
[2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
[3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
[4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/


RFCv1 -> RFCv2
  - Use bpf kfunc instead of helper
  - Use C source code to generate the light skeleton file

---
Pingfan Liu (7):
  kexec_file: Make kexec_image_load_default global visible
  kexec: Introduce kexec_pe_image to parse and load PE file
  lib/decompress: Keep decompressor when CONFIG_KEXEC_PE_IMAGE
  bpf/kexec: Introduce two bpf kfunc for kexec
  kexec: Introduce a bpf-prog lskel
  kexec: Integrate bpf light skeleton to load zboot image
  arm64/kexec: Add PE image format support

 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/kexec.h               |   1 +
 arch/arm64/kernel/machine_kexec_file.c       |   3 +
 include/linux/decompress/mm.h                |   7 +
 include/linux/kexec.h                        |   2 +
 kernel/Kconfig.kexec                         |   8 +
 kernel/Makefile                              |   2 +
 kernel/kexec_bpf/Makefile                    |  65 ++
 kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  66 ++
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 147 +++++
 kernel/kexec_file.c                          |   2 +-
 kernel/kexec_pe_image.c                      | 611 +++++++++++++++++++
 lib/decompress.c                             |   6 +-
 13 files changed, 917 insertions(+), 4 deletions(-)
 create mode 100644 kernel/kexec_bpf/Makefile
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
 create mode 100644 kernel/kexec_pe_image.c

-- 
2.49.0


