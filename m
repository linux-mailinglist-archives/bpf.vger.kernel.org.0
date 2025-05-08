Return-Path: <bpf+bounces-57799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9677AB0463
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC627A2E0E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A828A3E1;
	Thu,  8 May 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBFiqAyo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B624B26
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735334; cv=none; b=dxQyAKHirNSUOSV1+jkgrKaMP1cQzz8KbKwokox243w6o1p19mkjiNnp85nhpXho1FWRQDAqKH7Z1pdwrpz0KdmYKDdkG1z67u96Be1DY36cGFInUi94iRqyWzgVYlZrQ4ljh9yht9sx9PP0NaPe3XsLd2jD0ylHt0y2xtvTUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735334; c=relaxed/simple;
	bh=ebO4FaIk9OFxBBB21yqrPWRpUVJ27ZIe6D2F+7hSLh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GpGeATNIKOqNHhsCVAJokLi0mYKzIjgc09uip9jAd7rNZFukIBw1MG/JCoVPfmKtfIYhA9hY/YKr0ulgXFQezxQ1aQ+snbhdveMEC/xt7Pn8U8NuGHaE56f7s0TKSTgphzwdeecNQnSQ3ZnpKXDi7BGv3GsnxEoiLEhuPdJxGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBFiqAyo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30820167b47so1305378a91.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746735332; x=1747340132; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jNZYhjlmXP9BSh2D/su/C5EWEdYTYp0uSlcy0r8crJc=;
        b=XBFiqAyo1KR5BhV7u2xyC38B2F/Gf2P3Jfcb4invxeSPOJM4fuUmy2TruhQfrcejSm
         9RMRO42tqJ2RGT5IC1ELWqX+lpjqZ+iEHO3trlUfojatBIuwP2obllAP0MSiEXgTkLbu
         7/YkHKiiW9YVzS/3hRwW+wqksT7VAvotq/jYEXlwhKs1bn/OPktDst0zDfaxoK2qDfKr
         ewMPhNwIdnhD0gViIVv/VYGzt4YxxFamdM1rwA5ac1lR9h0dC94ZWFykQHSm0IV9dshL
         qZy+hYAAhmz4YnmwCasAvGZPXHzkkx9KboKdK8qgivkCIP0BO/wKysTx/ssmR6cW8U5g
         zHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746735332; x=1747340132;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNZYhjlmXP9BSh2D/su/C5EWEdYTYp0uSlcy0r8crJc=;
        b=QVVw5ss80EiiDjZpEYzXWnFjvcVizLzRe6jjn38ubDiDa7XFvgHLASZ6FQdba0ezZO
         w6W/NlHRj9iAJUuKs4hCt/1YqEolM02COnEhfP45I0SP5BfhlWZO7ET65tZeSrsKQZPf
         WHUa3/djp1O7t8HG+HPzeGm1oh7TdTzOaxKmvFpDk6CPKT090kmerRRv1HCBCkY9HgXw
         GayfhDFQRkmUqH32BtYe0UB0RkoK3bcPMTvMHyulOhNt5TOxnf9NUmiq90y79GXe3VP8
         +wwnggGTIT1j4RYm08TjopfwCUTD2wrVxmtMJwMBP2iXFyPgcqzir/KBHKrYs8Iu4OH2
         /AJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpwFfUUnKypzy5GJnWfEmo2Z99nUCg4cB4tDDo+1PwZqB9DeNXLZFKgVBE9a5o8gIqUjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfG7svFimUoaLFqkBD9okkxejaoHRz+SCKVb6NYsC3/eYMT6l
	+uuvhBEh3W7M5/E3ViLTpHZj/uOZQabotDPTJRiIsr3tq3ZcxftJ
X-Gm-Gg: ASbGncuECamwOu3mf2s2BZ8HGUfNqaHmEoU3SBJYPpD310ROo0cH8793mcJjfqhLzhI
	gikHyB6iWL4h0MMB/h3Tk+8aFuzLLBu5Y38hFIoM4ybHCKeGAw8XELDuV2eaggguZxp9cM3Yl2w
	L3HwAqHIgvKK8Vi2syTowViNg6O82ZmkU8Zag86hkUPJ8G+Wkbtqk74QMFelnM7F12tDUzwY+/B
	4zl0izPBFsk1WQDIa4FZqXIyWfGlRtXa32xPIfTwO1QB/ajssnh0GW17ow8myQ///ChiD19tDnQ
	EAm4ZKgJMdyqI0bJ92tqZAA6uHJz0iRtpGUK
X-Google-Smtp-Source: AGHT+IFm1A71Pd6jdK7KK4pWJqx57kVgUjiU3o41FQbH1s4EccnsYGo/8K4uGTTyvBLGTln3y5BpsQ==
X-Received: by 2002:a17:90b:5104:b0:2fe:93be:7c9d with SMTP id 98e67ed59e1d1-30c3fa0d66emr1033648a91.7.1746735331900;
        Thu, 08 May 2025 13:15:31 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc88a8sm427277a91.3.2025.05.08.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:15:31 -0700 (PDT)
Message-ID: <45fb527a493c7aae4307512cda0ded0efb1dd563.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/11] bpf: Add function to extract program
 source info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 08 May 2025 13:15:29 -0700
In-Reply-To: <20250507171720.1958296-4-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> Prepare a function for use in future patches that can extract the file
> info, line info, and the source line number for a given BPF program
> provided it's program counter.
>=20
> Only the basename of the file path is provided, given it can be
> excessively long in some cases.
>=20
> This will be used in later patches to print source info to the BPF
> stream. The source line number is indicated by the return value, and the
> file and line info are provided through out parameters.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Hi Kumar,

I did a silly test for this function by calling it for every ip in the
program at the and of the program load. See patch at the end of the
email. The goal was to compare its output with output of the `bpftool
prog dump jited`.

Next, I used pyperf600_iter.bpf.o as a guinea pig:

  bpftool prog load <kernel>/tools/testing/selftests/bpf/pyperf600_iter.bpf=
.o /sys/fs/bpf/dbg-prog
  bpftool prog dump jited pinned /sys/fs/bpf/dbg-prog

Overall, the bpftool output looks coherent to what is shown by printk.
However, I see an off-by-one difference, e.g.:

  // bpftool output

  void * get_thread_state(void * tls_base, PidData * pidData):
  bpf_prog_2af5b1ca414a1163_get_thread_state:
  ; static void *get_thread_state(void *tls_base, PidData *pidData)
     0:	endbr64
     ...
  ; bpf_probe_read_user(&key, sizeof(key), (void*)(long)pidData->tls_key_ad=
dr);
    1f:	movl	4(%rsi), %edx
    ...
  ; bpf_probe_read_user(&key, sizeof(key), (void*)(long)pidData->tls_key_ad=
dr);
    29:	movl	$4, %esi
    ...
  ; tls_base + 0x310 + key * 0x10 + 0x08);
    33:	movl	-12(%rbp), %edi
    ...
  ; bpf_probe_read_user(&thread_state, sizeof(thread_state),
    52:	movl	$8, %esi
    ...
  ; return thread_state;
    5f:	movq	-8(%rbp), %rax
    ...
 =20
  // printk

  [  114.506237] func[2] jited_len=3D106
  [  114.506306] ip=3D0, file=3D'(null)', line=3D'(null)', line_num=3D-2
  [  114.506395] ip=3D1, file=3D'pyperf.h', line=3D'static void *get_thread=
_state(void *tls_base, PidData *pidData)', line_num=3D77
  [  114.506571] ip=3D20, file=3D'pyperf.h', line=3D'bpf_probe_read_user(&k=
ey, sizeof(key), (void*)(long)pidData->tls_key_addr);', line_num=3D82
  [  114.506765] ip=3D34, file=3D'pyperf.h', line=3D'tls_base + 0x310 + key=
 * 0x10 + 0x08);', line_num=3D84
  [  114.506919] ip=3D53, file=3D'pyperf.h', line=3D'bpf_probe_read_user(&t=
hread_state, sizeof(thread_state),', line_num=3D83
  [  114.507096] ip=3D60, file=3D'pyperf.h', line=3D'return thread_state;',=
 line_num=3D85
 =20
Note that ip for each printk entry is +1 compared to bpftool output.

Also, there is a BUG splat from KASAN in the end:

  [    2.343160] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [    2.343277] BUG: KASAN: slab-out-of-bounds in bpf_prog_get_file_line (=
kernel/bpf/core.c:3213)=20
  [    2.343397] Read of size 4 at addr ffff88810b5ea810 by task veristat/1=
45
  [    2.343496]=20
  [    2.343542] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-3.fc41 04/01/2014
  [    2.343544] Call Trace:
  ...
  [    2.343592] bpf_prog_get_file_line (kernel/bpf/core.c:3213)=20
  [    2.343598] ?bpf_prog_2af5b1ca414a1163_get_thread_state+0x64/0x6a 85=
=20
  [    2.343602] bpf_prog_load (kernel/bpf/syscall.c:3014)=20
  ...
  [    2.343686]=20
  [    2.346851] Allocated by task 145:
  [    2.346912] kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:6=
8)=20
  [    2.346974] __kasan_kmalloc (mm/kasan/common.c:398)=20
  [    2.347036] __kvmalloc_node_noprof (mm/slub.c:4342 mm/slub.c:5026)=20
  [    2.347117] check_btf_info (kernel/bpf/verifier.c:17908 kernel/bpf/ver=
ifier.c:18120)=20
  [    2.347179] bpf_check (kernel/bpf/verifier.c:24004)=20
  [    2.347240] bpf_prog_load (kernel/bpf/syscall.c:2971)=20
  [    2.347301] __sys_bpf (kernel/bpf/syscall.c:5897)=20
  [    2.347363] __x64_sys_bpf (kernel/bpf/syscall.c:5958 kernel/bpf/syscal=
l.c:5956 kernel/bpf/syscall.c:5956)=20
  [    2.347423] do_syscall_64 (arch/x86/entry/syscall_64.c:0)=20
  [    2.347484] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:=
130)=20
  [    2.347566]=20
  [    2.347607] The buggy address belongs to the object at ffff88810b5ea00=
0
  [    2.347607]  which belongs to the cache kmalloc-4k of size 4096
  [    2.347782] The buggy address is located 0 bytes to the right of
  [    2.347782]  allocated 2064-byte region [ffff88810b5ea000, ffff88810b5=
ea810)

Am I doing something stupid or there is an issue?

--- 8< -------------------------------------------

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4664ab5e8cc7..467ae79f77a1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3188,6 +3188,7 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
=20
+__attribute__((optnone)) // to see line numbers after decode_stacktrace
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const =
char **filep, const char **linep)
 {
        int idx =3D -1, insn_start, insn_end, len;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 64c3393e8270..d1777b8c5558 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3001,6 +3001,23 @@ static int bpf_prog_load(union bpf_attr *attr, bpfpt=
r_t uattr, u32 uattr_size)
        err =3D bpf_prog_new_fd(prog);
        if (err < 0)
                bpf_prog_put(prog);
+       for (int fidx =3D 0; fidx < prog->aux->func_cnt; ++fidx) {
+               struct bpf_prog *fprog =3D prog->aux->func[fidx];
+               int line_num, prev_line_num;
+               const char *filep, *linep;
+
+               prev_line_num =3D -1;
+               printk("func[%d] jited_len=3D%d\n", fidx, fprog->jited_len)=
;
+               for (u32 ip =3D 0; ip < fprog->jited_len; ++ip) {
+                       filep =3D NULL;
+                       linep =3D NULL;
+                       line_num =3D bpf_prog_get_file_line(fprog, (u64)fpr=
og->bpf_func + ip, &filep, &linep);
+                       if (line_num !=3D prev_line_num)
+                               printk("ip=3D%x, file=3D'%s', line=3D'%s', =
line_num=3D%d\n",
+                                      ip, filep, linep, line_num);
+                       prev_line_num =3D line_num;
+               }
+       }
        return err;
------------------------------------------- >8 ---


