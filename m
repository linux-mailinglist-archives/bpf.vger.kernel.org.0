Return-Path: <bpf+bounces-59261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982C9AC7710
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27D0A24649
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EC32222A8;
	Thu, 29 May 2025 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXAsQ+4T"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BEEEAA
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492326; cv=none; b=K++Ew20qjcbq2Ext1av+0fGKMm30gM7fUmGoZ76WaditrlAx5I/UimDROrBtfo8cKdqt36oNlNLucLL7DuZo4im9NLlTOJSllSI9IYivGdXgm/PvZZbk5iFMUVZMWVbmfyP9Qq26+xDnwnspbvO+NBpheMYjmR3nFTX7q8HfLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492326; c=relaxed/simple;
	bh=qyQyqMBbzB66c/nbAYLQvdWtp2C2R8INNSMw9j7Ff88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/jakIMO++BmjChrbDRCfIiqIeMyIiSn7rKpvkpwtxrVguktcPXVRoPxb43CUratm5zTcYeuVgki5CSa8Gzx63Urk1bBdKsvIeMMmdyKGK49ng3pHmPWBNufs/ShMOH1g2Afte9a69GO6Xoq4eY6VhSZ/C0iJ55pWdBXrqHHHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXAsQ+4T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sSl/heG3ufjgsborJhX+SF5WLI1daNohNqz1kbS1LE0=;
	b=WXAsQ+4TcWbgvfCKh7MHiZqkL8fRYWTpXkNJ4OcX4OjC9ILq1FEfU4UyikVH+FRrjkQMsw
	U13sMWz+zhUT4Wjx+UGfQHF/FGEA76L0ZUq3Ou/jDAav4wNp3IBQxPyzzqFX5VuYKIs1Yc
	Uz+aIe+6kqUbTmjXAc9TH+707nGs7Ho=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-M4jiSS7UMd2KNPJnKaXhrQ-1; Thu,
 29 May 2025 00:18:40 -0400
X-MC-Unique: M4jiSS7UMd2KNPJnKaXhrQ-1
X-Mimecast-MFC-AGG-ID: M4jiSS7UMd2KNPJnKaXhrQ_1748492317
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 428FE180045B;
	Thu, 29 May 2025 04:18:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 057CB180047F;
	Thu, 29 May 2025 04:18:23 +0000 (UTC)
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
	bpf@vger.kernel.org
Subject: [PATCHv3 0/9] kexec: Use BPF lskel to enable kexec to load PE format boot image
Date: Thu, 29 May 2025 12:17:35 +0800
Message-ID: <20250529041744.16458-1-piliu@redhat.com>
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



[1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
[2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
[3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
[4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/


RFCv2 -> v3
  - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepable
  - use listener and publisher model to implement bpf_copy_to_kernel()
  - keep each introduced kfunc under the control of memcg

RFCv1 -> RFCv2
  - Use bpf kfunc instead of helper
  - Use C source code to generate the light skeleton file


Pingfan Liu (9):
  kexec_file: Make kexec_image_load_default global visible
  lib/decompress: Keep decompressor when CONFIG_KEXEC_PE_IMAGE
  bpf: Introduce bpf_copy_to_kernel() to buffer the content from
    bpf-prog
  bpf: Introduce decompressor kfunc
  kexec: Introduce kexec_pe_image to parse and load PE file
  kexec: Integrate with the introduced bpf kfuncs
  kexec: Introduce a bpf-prog lskel to parse PE file
  kexec: Integrate bpf light skeleton to load zboot image
  arm64/kexec: Add PE image format support

 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/kexec.h               |   1 +
 arch/arm64/kernel/machine_kexec_file.c       |   3 +
 include/linux/bpf.h                          |  23 +
 include/linux/decompress/mm.h                |   7 +
 include/linux/kexec.h                        |   2 +
 kernel/Kconfig.kexec                         |   8 +
 kernel/Makefile                              |   2 +
 kernel/bpf/Makefile                          |   2 +-
 kernel/bpf/helpers.c                         | 112 +++++
 kernel/bpf/helpers_carrier.c                 | 194 ++++++++
 kernel/kexec_bpf/Makefile                    |  65 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  65 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 147 ++++++
 kernel/kexec_file.c                          |   2 +-
 kernel/kexec_pe_image.c                      | 487 +++++++++++++++++++
 lib/decompress.c                             |   6 +-
 17 files changed, 1122 insertions(+), 5 deletions(-)
 create mode 100644 kernel/bpf/helpers_carrier.c
 create mode 100644 kernel/kexec_bpf/Makefile
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
 create mode 100644 kernel/kexec_pe_image.c

-- 
2.49.0


