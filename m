Return-Path: <bpf+bounces-55645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5914A83FA4
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672327B7D1C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B93726A1B4;
	Thu, 10 Apr 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb/rRbbo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01F26A1B7
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278937; cv=none; b=XbP+EdcM8EDhjWja02+M6QBw6gNQBJB7+UgHlclFcsDAGZa3TtvLW2kPgaPSP0NgMSUiCDXecJaZcC2svelXLRHmF0dXIgeCdVLBR2eNW9lDKYF6iluWiJhZQMCiCSBIgl2Lt6A5QbjHnc+L7/LARsEYb7OAtYuf4WySgDvOczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278937; c=relaxed/simple;
	bh=i65w8+lGrxYWx7rpHSbpC2JJCKns/es9Qf7+yH/Hrd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SM3D/tAzkfUC+0mvZnDiYU3xPI8nEOf9y3XLXeDi1cq3NVsoT1lTBw/I2e7I+30FioTjfyEBOuKwcUTt8tIXDvTCFdyW2kqo9lauStkWCgywzHFi9NbRQ6vEq3Uq2MiPEHXGc9D8N6tKUY+2rYhKN4IfbE7YPboQNt4NzZtH2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb/rRbbo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744278934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=II82/lgaIjXOphMlPq6hOhd8dnjPIIYTpFuurPbQULs=;
	b=eb/rRbbovACI/nQvpOq+l+54F9LZpn0OIoKvU//XBzngZ9aHUZavWA+yjwYTgnjfhPjq+d
	frW+HnfhYCTreEedf4x9I0WsOYhZkbwklyHlubmHjFLvha+SBQfDFdPh1GofX2vtT3KNn6
	/MZYw2HioXphtt/A1HPRJmeDJi84zV4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-2_HmN8aTPH-c1qsKFvXmJQ-1; Thu,
 10 Apr 2025 05:55:32 -0400
X-MC-Unique: 2_HmN8aTPH-c1qsKFvXmJQ-1
X-Mimecast-MFC-AGG-ID: 2_HmN8aTPH-c1qsKFvXmJQ_1744278930
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C30F9180882E;
	Thu, 10 Apr 2025 09:55:29 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813843001D0E;
	Thu, 10 Apr 2025 09:55:23 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	lmarch2 <2524158037@qq.com>,
	stable@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf v2] libbpf: Fix buffer overflow in bpf_object__init_prog
Date: Thu, 10 Apr 2025 11:55:17 +0200
Message-ID: <20250410095517.141271-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
file such that arbitrary BPF instructions are loaded by libbpf. This can
be done by setting a symbol (BPF program) section offset to a large
(unsigned) number such that <section start + symbol offset> overflows
and points before the section data in the memory.

Consider the situation below where:
- prog_start = sec_start + symbol_offset    <-- size_t overflow here
- prog_end   = prog_start + prog_size

    prog_start        sec_start        prog_end        sec_end
        |                |                 |              |
        v                v                 v              v
    .....................|################################|............

The CVE report in [1] also provides a corrupted BPF ELF which can be
used as a reproducer:

    $ readelf -S crash
    Section Headers:
      [Nr] Name              Type             Address           Offset
           Size              EntSize          Flags  Link  Info  Align
    ...
      [ 2] uretprobe.mu[...] PROGBITS         0000000000000000  00000040
           0000000000000068  0000000000000000  AX       0     0     8

    $ readelf -s crash
    Symbol table '.symtab' contains 8 entries:
       Num:    Value          Size Type    Bind   Vis      Ndx Name
    ...
         6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp

Here, the handle_tp prog has section offset ffffffffffffffb8, i.e. will
point before the actual memory where section 2 is allocated.

This is also reported by AddressSanitizer:

    =================================================================
    ==1232==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7302fe0000 at pc 0x7fc3046e4b77 bp 0x7ffe64677cd0 sp 0x7ffe64677490
    READ of size 104 at 0x7c7302fe0000 thread T0
        #0 0x7fc3046e4b76 in memcpy (/lib64/libasan.so.8+0xe4b76)
        #1 0x00000040df3e in bpf_object__init_prog /src/libbpf/src/libbpf.c:856
        #2 0x00000040df3e in bpf_object__add_programs /src/libbpf/src/libbpf.c:928
        #3 0x00000040df3e in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3930
        #4 0x00000040df3e in bpf_object_open /src/libbpf/src/libbpf.c:8067
        #5 0x00000040f176 in bpf_object__open_file /src/libbpf/src/libbpf.c:8090
        #6 0x000000400c16 in main /poc/poc.c:8
        #7 0x7fc3043d25b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
        #8 0x7fc3043d2667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667)
        #9 0x000000400b34 in _start (/poc/poc+0x400b34)

    0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)
    allocated by thread T0 here:
        #0 0x7fc3046e716b in malloc (/lib64/libasan.so.8+0xe716b)
        #1 0x7fc3045ee600 in __libelf_set_rawdata_wrlock (/lib64/libelf.so.1+0xb600)
        #2 0x7fc3045ef018 in __elf_getdata_rdlock (/lib64/libelf.so.1+0xc018)
        #3 0x00000040642f in elf_sec_data /src/libbpf/src/libbpf.c:3740

The problem here is that currently, libbpf only checks that the program
end is within the section bounds. There used to be a check
`while (sec_off < sec_sz)` in bpf_object__add_programs, however, it was
removed by commit 6245947c1b3c ("libbpf: Allow gaps in BPF program
sections to support overriden weak functions").

Put the above condition back to bpf_object__init_prog to make sure that
the program start is also within the bounds of the section to avoid the
potential buffer overflow.

[1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md

Reported-by: lmarch2 <2524158037@qq.com>
Cc: stable@vger.kernel.org
Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
Signed-off-by: Viktor Malik <vmalik@redhat.com>
Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b85060f07b3..d0ece3c9618e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-		if (sec_off + prog_sz > sec_sz) {
+		if (sec_off >= sec_sz || sec_off + prog_sz > sec_sz) {
 			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
 				sec_name, sec_off);
 			return -LIBBPF_ERRNO__FORMAT;
-- 
2.49.0


