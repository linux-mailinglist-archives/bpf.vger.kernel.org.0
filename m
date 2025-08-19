Return-Path: <bpf+bounces-65937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB993B2B5E4
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFB45238AB
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10891DF258;
	Tue, 19 Aug 2025 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG9ailPi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C419ABC6
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566712; cv=none; b=cKn0EP/KM15I0rlI2h5Oelo5lNqUDrnnJFgjWkiLDIbiOe1EgHSH0ZKcJWD9ZBHqQvXsev610Rru9+nZS0EPuv8KA9RunB+Dw2nwvEKVxf8V4mKhShEij/JAa/35qYL6k74ETqF+nY8U5vy5ph+NyycX2g634BeKpfNuqWN+umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566712; c=relaxed/simple;
	bh=6CJJ6glKb09wLnkZzZcn6pAyyu1DbltBRoYOpiLChRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GViiWGbFiULZiV+XeBDO1pluwA87whF9RcCvu56fhG5ISAK+gFQnGj6XjFHX01AnqEdcu5DVvSjZxaDGvkU1lHAUQefjfgp+D40gzd4ESLcMfvrQ67ULO5J93IjzL5twmNXdPF5Hz/Uh413cTuOr2At006O9QHpBMHtgJWZTG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG9ailPi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jKzMHX0lq5LdXuM9uxzOs7TA2ASb/+cUjydn2ohzv+w=;
	b=PG9ailPiqA/qA450DWyD/JGFRTKFfm4u/fpLD8kO086k1YSZ7Bp3bqPSDL5xW+w2SCpc6g
	Bv9+Mp20Q2zo3AnyO61FnwWMKV3cb0iTxD7jR8VcfI/MX1PoV8so+/bz1oBaLGLXTGcL3n
	aK8ehuuUDuBlTXN1ZWNbO9srz9jAmQQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-PKaA9DXgMb2W18P1ryrguA-1; Mon,
 18 Aug 2025 21:25:04 -0400
X-MC-Unique: PKaA9DXgMb2W18P1ryrguA-1
X-Mimecast-MFC-AGG-ID: PKaA9DXgMb2W18P1ryrguA_1755566702
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B49D118004A7;
	Tue, 19 Aug 2025 01:25:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96DB3180028A;
	Tue, 19 Aug 2025 01:24:48 +0000 (UTC)
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
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv5 00/12] kexec: Use BPF lskel to enable kexec to load PE format boot image
Date: Tue, 19 Aug 2025 09:24:16 +0800
Message-ID: <20250819012428.6217-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Cc systemd-devel@lists.freedesktop.org so any UKI expert can comment

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

Benefits
And it abstracts architecture independent part and 
the API is limitted 

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

*** Test result ***
Configured with RHEL kernel debug file, which turns on most of locking,
memory debug option, I have not seen any warning or bug for 1000 times.

Test approach:
-1. compile kernel
-2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
-3. compile kexec-tools from https://github.com/pfliu/kexec-tools/pull/new/pe_bpf

The rest process is the common convention to use kexec.


[1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
[2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
[3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
[4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/

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


*** BLURB HERE ***

Pingfan Liu (12):
  kexec_file: Make kexec_image_load_default global visible
  lib/decompress: Keep decompressor when CONFIG_KEEP_COMPRESSOR
  bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
  bpf: Introduce decompressor kfunc
  kexec: Introduce kexec_pe_image to parse and load PE file
  kexec: Integrate with the introduced bpf kfuncs
  kexec: Introduce a bpf-prog lskel to parse PE file
  kexec: Factor out routine to find a symbol in ELF
  kexec: Integrate bpf light skeleton to load zboot image
  arm64/kexec: Add PE image format support
  tools/kexec: Introduce a bpf-prog to parse zboot image format
  tools/kexec: Add a zboot image building tool

 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/kexec.h               |   1 +
 arch/arm64/kernel/machine_kexec_file.c       |   3 +
 include/linux/bpf.h                          |  42 ++
 include/linux/decompress/mm.h                |   7 +
 include/linux/kexec.h                        |  10 +
 kernel/Kconfig.kexec                         |   9 +
 kernel/Makefile                              |   2 +
 kernel/bpf/Makefile                          |   3 +
 kernel/bpf/helpers.c                         | 230 +++++++++
 kernel/bpf/helpers_carrier.c                 | 215 +++++++++
 kernel/kexec_bpf/Makefile                    |  71 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  67 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 147 ++++++
 kernel/kexec_file.c                          |  88 ++--
 kernel/kexec_pe_image.c                      | 463 +++++++++++++++++++
 lib/Kconfig                                  |   3 +
 lib/decompress.c                             |   6 +-
 tools/kexec/Makefile                         |  90 ++++
 tools/kexec/pe.h                             | 177 +++++++
 tools/kexec/zboot_image_builder.c            | 280 +++++++++++
 tools/kexec/zboot_parser_bpf.c               | 158 +++++++
 22 files changed, 2029 insertions(+), 44 deletions(-)
 create mode 100644 kernel/bpf/helpers_carrier.c
 create mode 100644 kernel/kexec_bpf/Makefile
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
 create mode 100644 kernel/kexec_pe_image.c
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/pe.h
 create mode 100644 tools/kexec/zboot_image_builder.c
 create mode 100644 tools/kexec/zboot_parser_bpf.c


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.49.0


