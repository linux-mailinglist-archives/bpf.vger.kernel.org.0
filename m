Return-Path: <bpf+bounces-79402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9CD39CC3
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D9793006F60
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D1258ED4;
	Mon, 19 Jan 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEPxUQ7U"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AC242D7B
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793119; cv=none; b=qJlzXYxZYfTBrKrcJNXaoQB/ptZAAZw+WCLANRmAVbTIBeKu8487TIhE5WWfiixpH4i+q54GOQao1OqSo45ztkFf/nZhUIs0g1ap4+M23zBdh2lyzkh7U0kKcAWB6jb3Dv7nzG3jf29W/MuvWDgWghNiVOkoAsD2u3TpGK17gtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793119; c=relaxed/simple;
	bh=hCZF0wKPgNDaVHXzS3dt599S8fZwA7Qz2+bALuByy2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GePf/oqJuWSQ7MsHkRt/BLde+x5iauPeqwFrSIi1Yx7xlG80JybS7mefF5JZyWUm3UijBE3hQRSr2k0CPwQWl6WL60fikn9sjdxB1rUJqv8fcyhHk/x3RzyHDiNS2KQu1MPkvCor45t24MqJ2KEvvFoK0+lZeDveIUiMODmOaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEPxUQ7U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f5A/GhRm8rD5sGJTCb3wTrUXwIXIvfdpvCb1mqaSL9A=;
	b=iEPxUQ7UjTsNMhovb8gK0F7inc5irVbY/J5Qc9hhB573CkxHazN8er++SAopPG9sn9GgQX
	9U9C6TpN/NEp5Z19KagxS8MBgWvuhLZ5sjqdeXT89YENHPMojCXzq08tOd9RdYnqZViD7D
	wJ5Ag+zNtMGHSGDb37hsiWJvzp/plKY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-aSivv7DWOAukni8gtH-oig-1; Sun,
 18 Jan 2026 22:25:15 -0500
X-MC-Unique: aSivv7DWOAukni8gtH-oig-1
X-Mimecast-MFC-AGG-ID: aSivv7DWOAukni8gtH-oig_1768793113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3C9C180047F;
	Mon, 19 Jan 2026 03:25:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0F511955F22;
	Mon, 19 Jan 2026 03:24:58 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 00/13] kexec: Use BPF lskel to enable kexec to load PE format boot image
Date: Mon, 19 Jan 2026 11:24:11 +0800
Message-ID: <20260119032424.10781-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


*** The history ***

Nowadays, UEFI PE bootable images are becoming increasingly popular
among distributions. Currently, we have several kinds of image format
parsers in user space (kexec-tools). However, this approach breaks the
integrity protection of the images. To address this integrity protection
concern, several approaches have been proposed to resolve this issue,
but none of them have been accepted upstream yet.

The summary of those approaches:
  -1. UEFI service emulator for UEFI stub
  -2. PE format parser in kernel
  -3. Signing the arm64/boot/Image


For the first approach, I tried a purgatory-style emulator [1], but it
encounters hardware scaling issues. For the second approach, both
zboot-format [2] and UKI-format [3] parsers were rejected due to
concerns that variant format parsers would bloat the kernel code.
Additionally, for example in arm64, both UKI and zboot format parsers
would need to be introduced and chained together to handle image
loading. For the third approach, I attempted [4], but since zboot or UKI
images already have signatures, upstream maintainers dislike the
additional signature on the Image. Moreover, for secure boot UKI, this
method cannot use signatures to protect the initramfs.


*** The approach in this series ***

This series introduces an approach that allows image formats to be
parsed by BPF programs. As a result, the kexec kernel code can remain
relatively stable without introducing new parsers for different
architectures.  This approach introduces a dedicated '.bpf' section in
the PE file, which stores BPF bytecode. The integrity of all
components -- kernel, initramfs, cmdline, and even the BPF bytecode
itself is protected by the PE file's signature.  After signature
verification, the BPF bytecode is loaded and executed from within the
kernel using BPF lskel. Therefore, the bytecode itself is protected from
malicious attacks on the BPF loader in user space.  

When a .bpf section is extracted from the current image file, its
bytecode is attached to the kexec kernel function
kexec_image_parser_anchor(). After the bytecode parses the image, the
next-stage image is prepared, and the bytecode in the new .bpf section
can be attached to kexec_image_parser_anchor(). In this way, nested
image format issues (e.g., zboot image within UKI on arm64) can be
resolved.  (Theoretically not yet tested.)


*** Thanks ***
I would like to thank Philipp Rudo, whose insights inspired this
approach and who dedicated significant time to evaluating its
practicality. I am also grateful to Viktor Malik for his guidance on
using BPF light skeleton to prevent malicious attacks from user space.


*** Test approach ***
-1. compile kernel
-2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
-3. compile kexec-tools from https://github.com/pfliu/kexec-tools/tree/pe_bpf

The rest test process is the common convention to use kexec.


[1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
[2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
[3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
[4]: https://lore.kernel.org/linux-efi/20230921133703.39042-1-kernelfans@gmail.com/


*** Changes ***
v5 -> v6
  - Re-organize the layers in kexec_file_load into two layers: format-parsing and kernel boot protocol handling.
  - Simplify the bpf kfunc interface.
  - rebased onto Linux 6.19-rc2

v4 -> v5
  - rebased onto Linux 6.17-rc2
  - [1/12], use a separate CONFIG_KEEP_COMPRESSOR to decide the section
    of decompressor method
  - [10/12], add Catalin's acked-by (Thanks Catalin!)

v3 -> v4
  - Use dynamic allocator in decompression ([4/12])
  - Fix issue caused by Identical Code Folding ([5/12])
  - Integrate the image generator tool in the kernel tree ([11,12/12])
  - Address the issue according to Philipp's comments in v3 reviewing.
    Thanks Philipp!

RFCv2 -> v3
  - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepable
  - use listener and publisher model to implement bpf_copy_to_kernel()
  - keep each introduced kfunc under the control of memcg

RFCv1 -> RFCv2
  - Use bpf kfunc instead of helper
  - Use C source code to generate the light skeleton file


---
Pingfan Liu (13):
  bpf: Introduce kfuncs to parser buffer content
  kexec_file: Move signature validation ahead
  kexec_file: Introduce routines to parse PE file
  kexec_file: Use bpf-prog to decompose image
  lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
  kexec_file: Implement decompress method for parser
  kexec_file: Implement copy method for parser
  kexec_file: Introduce a bpf-prog lskel to parse PE file
  kexec_file: Factor out routine to find a symbol in ELF
  kexec_file: Integrate bpf light skeleton to load image with bpf-prog
  arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
  tools/kexec: Introduce a bpf-prog to parse zboot image format
  tools/kexec: Add a zboot image building tool

 arch/arm64/Kconfig                           |   1 +
 include/linux/bpf.h                          |  19 +
 include/linux/decompress/mm.h                |   8 +
 kernel/Kconfig.kexec                         |   8 +
 kernel/Makefile                              |   2 +
 kernel/bpf/Makefile                          |   3 +
 kernel/bpf/bpf_buffer_parser.c               | 170 +++++++
 kernel/kexec_bpf/Makefile                    |  70 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  12 +
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 130 ++++++
 kernel/kexec_bpf/template.c                  |  68 +++
 kernel/kexec_bpf_loader.c                    | 439 +++++++++++++++++++
 kernel/kexec_file.c                          | 106 +++--
 kernel/kexec_internal.h                      |   5 +
 kernel/kexec_uefi_app.c                      |  81 ++++
 lib/Kconfig                                  |   6 +
 lib/decompress.c                             |   6 +-
 tools/kexec/Makefile                         |  91 ++++
 tools/kexec/pe.h                             | 177 ++++++++
 tools/kexec/template.c                       |  68 +++
 tools/kexec/zboot_image_builder.c            | 278 ++++++++++++
 tools/kexec/zboot_parser_bpf.c               | 114 +++++
 22 files changed, 1813 insertions(+), 49 deletions(-)
 create mode 100644 kernel/bpf/bpf_buffer_parser.c
 create mode 100644 kernel/kexec_bpf/Makefile
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
 create mode 100644 kernel/kexec_bpf/template.c
 create mode 100644 kernel/kexec_bpf_loader.c
 create mode 100644 kernel/kexec_uefi_app.c
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/pe.h
 create mode 100644 tools/kexec/template.c
 create mode 100644 tools/kexec/zboot_image_builder.c
 create mode 100644 tools/kexec/zboot_parser_bpf.c

-- 
2.49.0


