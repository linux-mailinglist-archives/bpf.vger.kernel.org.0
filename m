Return-Path: <bpf+bounces-63640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B97B09235
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B181C474F7
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAD2FCFE9;
	Thu, 17 Jul 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YwxRb+Pa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB212F6FAD
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770995; cv=none; b=AqimYupW/R1yoQXh27VykCO7CpDnUOsxvpPfynsQK331vmyt1kIZY2FC1zEvVxmsDZx+Qb3pEEiOhZQykOyA0jM/IXQ9bxN7d4gd1AqioR/RZ3t8aH3jwA6tLszL80WyknfODkdheRg25FCdANt7wnAJ7LzCGOTazTQtfFtXrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770995; c=relaxed/simple;
	bh=9cgB3TOPwSr1wE07CMGkQYwcs0YPQweBj451ZDmkDaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JK3EaTa14KCDVF1bsSWR/erT1e/tsju0NXRDCQMafX5TNAU7E8j5nOF1BIOMgBUudHTvBNwyjd3cbtAcH8BZWtrxFAeGljwqwjFDejVC7i0FMNk0RZ6R/zefqScNYq/il9ZQXkE6TcVM+3wBY3UJ9+DFSap9hPmCKO8CZqGAz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=YwxRb+Pa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45629703011so9444305e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1752770992; x=1753375792; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PpESPaqCYrYa+aak5AktG6n/gTSddz3EZjY1kdqmFI=;
        b=YwxRb+PaZXkIWkP4OIh6TyZN34R6jt0qR7vJ/E2OJmNCi/wNpyZpO2tbaaWvgvXlcD
         2ryWBvVM/tuEmudJFeIDPDP65Qcckt8O0eL6mkNnue2ikd9eUjxufQpdWEkkQnxeUMkB
         LmgZ+y+2dTw8oKJ3yg1bYT5KHLFx5CJXzm7PKw2djStmtrckNQH5E9ITTu6PC0jm2cQx
         oiGLWP39wdgLF1JaqwNUopWaoVFklATqLDwYhLzcKGhhw+5wHOS01jiYnsBwDoXXXlRh
         oazG6bGujHWW5GpjlqVxlmG4Phm0FyciLC4jKME6OfdhEFLufIdb5dulGlCe7tVao2eq
         ug5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770992; x=1753375792;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PpESPaqCYrYa+aak5AktG6n/gTSddz3EZjY1kdqmFI=;
        b=dI5TayHjzYVf/aB/2AyJD8gP7lOpMzL361wLXuO6VZ8OvGWXa08pvP1aFIeybQv0SM
         lnIDNuY4v06GEWIGrHOC/pi6prVmxzPoqPkuYkNm5HTqVo2MzI0uTi2iFPzF/iyIvZ5M
         KIJotnag5nkZTjHSutelIlOv6DcFf23+vTYwNaThMr5f5gcVwRAWW1s8LVJz57dSTcss
         9BkSW4SIwvCUqD52xmgtY17gsUbcbfKrv0G16qTlKqUDauE06f2U+IlZV4M0GVh0uMCr
         seSi7IzbrbBQscf5K/DypVl5fzFDchz0eK84j9N7P8rK70GXK4aLLvyw33gaX78RZg4C
         DGOw==
X-Gm-Message-State: AOJu0YxtAvRC3eZaGP8PBGW+ctivzHqQPjl6x9jA53fQpA5sTuR5HIMS
	CRArY14Ko0DxzzuQ8Vl54MwEm4cTeT4b4INTR8JR0y+eV+ScdBhr0hOKu2RQ9Mz4j4Q=
X-Gm-Gg: ASbGncszA9/mAHlXgF+4CLv72VsPHIwYbVR8SB2ThSArvyw/g2F1G2PcsBkK1Jj9C43
	+nY1ZNNkJsLrdxrcLd+O+8SuteHPoTV+ID3HSK81Cr2trY5IOQStyaRjo8WkWhdVeMBv0UUZ8Bz
	sPcq8tjtHe6JJUYnbd368PeNUEXtzHaNEh8/vfvkkYHlRLPQ0NAU8GvU2vOKUnrzRlmtx7XX29w
	F6CCXI0vWpBgT/9kWJNSPR+Sz2S/+NiVJm78ng59CyR6JtJEhhloms4zSQnlj8BJwtR07hINmKV
	5ZsU4yh9tPZCcikuUR6MbwU/nIE+qeAK2WtufJZyNmnEb1vZp3sM2B00T8x5P//MKcm2h2+KbCl
	HbmLCJC89lr4SSCQfvgvS
X-Google-Smtp-Source: AGHT+IFea0sOpyAUvZX8LvcnZK2X3TTge5McpyLZVoR/3HTrDRjXOPydKYiIP05qHr4Lz8tUaV+gsw==
X-Received: by 2002:a05:600c:8b85:b0:456:2347:3f01 with SMTP id 5b1f17b1804b1-456355c60d3mr33071495e9.20.1752770991748;
        Thu, 17 Jul 2025 09:49:51 -0700 (PDT)
Received: from [172.16.82.34] ([167.98.39.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd15bfsm21433409f8f.19.2025.07.17.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:49:51 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 17 Jul 2025 17:49:49 +0100
Subject: [PATCH bpf] btf: fix virt_to_phys warning on arm64 when mmapping
 vmlinux
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vmlinux-mmap-pa-symbol-v1-1-970be6681158@isovalent.com>
X-B4-Tracking: v=1; b=H4sIAKwpeWgC/x3MTQqDMBBA4avIrDswpoSAVyld5GeiAyaGhIoi3
 r3B5bd474LGVbjBNFxQeZcmW+4YXwP4xeaZUUI3KFKazGhwT6vk34Ep2YLFYjuT21akoLUP5N7
 KE/S4VI5yPOMPuBLhe99/oiA/Mm0AAAA=
X-Change-ID: 20250717-vmlinux-mmap-pa-symbol-0d55cd0b32c0
To: Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

Breno Leitao reports that arm64 emits the following warning:

    [   58.896157] virt_to_phys used for non-linear address: 000000009fea9737
      (__start_BTF+0x0/0x685530)
    [   23.988669] WARNING: CPU: 25 PID: 1442 at arch/arm64/mm/physaddr.c:15
      __virt_to_phys (arch/arm64/mm/physaddr.c:?)

        ...

    [   24.075371] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
    [   24.080276] Hardware name: Quanta S7GM 20S7GCU0010/S7G MB (CG1), BIOS 3D22
      07/03/2024
    [   24.088295] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
    [   24.098440] pc : __virt_to_phys (arch/arm64/mm/physaddr.c:?)
    [   24.105398] lr : __virt_to_phys (arch/arm64/mm/physaddr.c:?)

	...

    [   24.197257] Call trace:
    [   24.199761] __virt_to_phys (arch/arm64/mm/physaddr.c:?) (P)
    [   24.206883] btf_sysfs_vmlinux_mmap (kernel/bpf/sysfs_btf.c:27)
    [   24.214264] sysfs_kf_bin_mmap (fs/sysfs/file.c:179)
    [   24.218536] kernfs_fop_mmap (fs/kernfs/file.c:462)
    [   24.222461] mmap_region (./include/linux/fs.h:? mm/internal.h:167
       mm/vma.c:2405 mm/vma.c:2467 mm/vma.c:2622 mm/vma.c:2692)

It seems that the memory layout on arm64 maps the kernel image in vmalloc space
which is different than x86. This makes virt_to_phys emit the warning.

Fix this by translating the address using __pa_symbol as suggested by
Breno instead.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/bpf/g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb/
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Tested-by: Breno Leitao <leitao@debian>
Fixes: a539e2a6d51d ("btf: Allow mmap of vmlinux btf")
---
 kernel/bpf/sysfs_btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 941d0d2427e3a2d27e8f1cff7b6424d0d41817c1..8e61dc555415aafd9e8f80a3408b668fd5057cb3 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -21,7 +21,7 @@ static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
 {
 	unsigned long pages = PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
 	size_t vm_size = vma->vm_end - vma->vm_start;
-	phys_addr_t addr = virt_to_phys(__start_BTF);
+	phys_addr_t addr = __pa_symbol(__start_BTF);
 	unsigned long pfn = addr >> PAGE_SHIFT;
 
 	if (attr->private != __start_BTF || !PAGE_ALIGNED(addr))

---
base-commit: af90e85307241ec495c2de85854cd2e35a4df16b
change-id: 20250717-vmlinux-mmap-pa-symbol-0d55cd0b32c0

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


