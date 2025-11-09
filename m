Return-Path: <bpf+bounces-74015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E74CC44376
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039333A5F9A
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF804305940;
	Sun,  9 Nov 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyDgFGIc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91593054DF
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708172; cv=none; b=MiDOqWu26L+Gi+60UcVmWxmp2SisJMEoMbOrkxzZkKy/50ZYUCGdAeMLO7MEQfIBfvmzuR8kHmpwzgCX7MLDIDXpnv2qUxOSzeC422EW6toUWluh7jfMGuQ6X6+qx5eQ94rV69HdQNNTtfE2EC4wzQA1cE5Z/sy4ceaHq1uTpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708172; c=relaxed/simple;
	bh=tcMa9Zw1uo6re3t7J6k5xMCtS24puX6kJimoOAX0Nyg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ppKm5A0Er2rcoIJWwZaloB51yHIg7IWS+Q2T6bjISoH7VzLMnXwJPNVF8yj1cpqTiD5hu3p/GQufonTKUvYluSYYHdv09ff6VXwDS/1Zl4VdGgw6GBX0OHA6aqmRxnxvc2v1kQijZ442oU+/0jx81Gc7wFp/b7ouUI5jyuYZcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyDgFGIc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4edacc41dc5so6484381cf.0
        for <bpf@vger.kernel.org>; Sun, 09 Nov 2025 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762708170; x=1763312970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u1+K0g1kisuVhXH2www13EHKjob5bBEGObVSxmXLLn0=;
        b=YyDgFGIc9w64SJZopCtqmx/y3jhRpMLY6N0o1+82U+rIJERs2mATVYXdPMuUSse9oF
         x1VcyVqOqyQHe9QHVSvlQxgSzQTYx/6Y/aHbKqSH2tvWUXUmV8MehDJCsy6C/aYQ0DzJ
         36o4YbtF7rgcMpG+xEkd9EP2N+6SHMpGLrW0Hb9pAXuh8JUiXWa/pnJ+CAB6upw4Im0X
         vJ1E79okgTuOB341vcjU3TYR29UNnCRWbg0sBg1v/xtpD9cyF8WE4wPeMqyh3kACWHJb
         amTwykAhHE1nB3AV5/Qy5sQTDqEDCMPBZw7fgfeLdtWM91w2scio2HdLUbgBb+NrKMxG
         jJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762708170; x=1763312970;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1+K0g1kisuVhXH2www13EHKjob5bBEGObVSxmXLLn0=;
        b=l/mCGg2KlSygPpLCUnN9t8V7vsE3HV4afT11svyp5G6nfJSRz1Opu9K7hcWyC8k+UF
         vdngPFm8tYkdvqv5xWnmdl47E4uQtquSzN1mI0gZGHKG1B8sTQDFgqRy8VQqL9uh6h+h
         46DfbncAY4wLQpTv+PIuYZJ+3IJehhACR70eRtn2iyv01vNaFpxziIzj6W+FABa/mwVv
         kGJz+Xc1JoCy26TtIo/rQ0pRF1PbkyXpLUqShFYx+c4yW2ngTPmFsxjNfYoaLtc6CL1k
         W/33xbKvQxd+UcXU71vRAAUltG4Ljr/m227YHzjnoLla0GB5avHYPvqtLlZ9VjfbYsd/
         1dMQ==
X-Gm-Message-State: AOJu0YywvDVddz9KTwanQUKC0ZfB+NeoPvh6gbSg1un8LOQW6K74u6qu
	UJiaHOaIQ1yTm8wM5FQd2TGzhhSUrJgiG1s3hHWoXxNq2CJ5lg2cRtA/Q37rM+pDY6fDznHAyla
	kwwehQypmtxIQSKs60gZigu2dAdERZwW3q+B8
X-Gm-Gg: ASbGncsMLVwgzPIZ4qje7SGE6k1ttn3TCuhzeFp/mN4hDOrlQ3LDIVm1ICSFzMqI3tS
	f3tzqP0R5AHfdB9irUfRTeYdq2PQ1tdxG8boAQhUYgpA2xazMLuNnGjBjCSwaWwxmL6MwRVFUCE
	CY/G0m9jcUp0rKFzUK9aPeck63GGUpFHybS30N0KRqUGDdZo5QSM/k0VV4HBBzPsBs170pSSuOm
	DUDwCFb5HHahsw++ud0d5B2Dzhj/xwfq7Ie4wMJkf+1KhmzevcSPuW2fZy1DGP9HNxfhPo=
X-Google-Smtp-Source: AGHT+IFp/muYBK/4H0/lTP3YcMg1BILdlTDTxSEcsQA6qPNeY2Fi+2hBbLgoY2sqC52AZFW+/3vcx9xW+p/HsXzVh28=
X-Received: by 2002:a05:622a:1914:b0:4ec:f18f:f7c7 with SMTP id
 d75a77b69052e-4eda4e74ec3mr78296501cf.12.1762708169677; Sun, 09 Nov 2025
 09:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 9 Nov 2025 09:09:18 -0800
X-Gm-Features: AWmQ_bnMC9OrIUtU-tHUgY1Uxs92RlkRQqZ44n5DhjvoRMddgCD3DtHs_XFlqco
Message-ID: <CAK3+h2yuppeOisqT+G6pf9zsP7sTbbbgKWpMe6s5TL6fZ-coWg@mail.gmail.com>
Subject: [BPF selftests]:bpf_arena_common.h: error: conflicting types for 'bpf_arena_alloc_pages'
To: bpf <bpf@vger.kernel.org>
Cc: ast <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry if this is a known issue,  but I could not find it.  my build environment:

[root@fedora linux-loongson]# pahole --version
v1.30
[root@fedora linux-loongson]# clang --version
clang version 21.1.5
Target: loongarch64-redhat-linux
Thread model: posix
InstalledDir: /usr/bin

[root@fedora linux-loongson]# bpftool version
bpftool v7.6.0
using libbpf v1.6
features: llvm, skeletons

I got errors below while building bpf selftests with bpf-next branch,
I had to comment out the bpf_arena_alloc_pages,
bpf_arena_reserve_pages, bpf_arena_free_pages in
tools/include/vmlinux.h, then progs/stream.c build succeeded. It looks
like these functions in tools/include/vmlinux.h generated by bpftool
are not the same as in bpf_arena_common.h. is there something wrong in
my build environment?


In file included from progs/stream.c:8:
/usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:47:15:
error:
      conflicting types for 'bpf_arena_alloc_pages'
   47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena
*addr, __u32 page_cnt,
      |               ^
/usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlinux.h:180401:14:
note:
      previous declaration is here
 180401 | extern void *bpf_arena_alloc_pages(void *p__map, void
*addr__ign, u32 page_cnt, int node_i...
        |              ^
In file included from progs/stream.c:8:
/usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:49:5:
error:
      conflicting types for 'bpf_arena_reserve_pages'
   49 | int bpf_arena_reserve_pages(void *map, void __arena *addr,
__u32 page_cnt) __ksym __weak;
      |     ^
/usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlinux.h:180403:12:
note:
      previous declaration is here
 180403 | extern int bpf_arena_reserve_pages(void *p__map, void
*ptr__ign, u32 page_cnt) __weak __ksym;
        |            ^
In file included from progs/stream.c:8:
/usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:50:6:
error:
      conflicting types for 'bpf_arena_free_pages'
   50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u32
page_cnt) __ksym __weak;
      |      ^
/usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlinux.h:180402:13:
note:
      previous declaration is here
 180402 | extern void bpf_arena_free_pages(void *p__map, void
*ptr__ign, u32 page_cnt) __weak __ksym;
        |             ^
3 errors generated.

Vincent

