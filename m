Return-Path: <bpf+bounces-55639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83EA83C8B
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC78189E00E
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7820E70E;
	Thu, 10 Apr 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPeLUG/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686671E98FB
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272993; cv=none; b=Fub7K8UmQ6fXVLblm2rN2Gc+jFGPz4SPbfc5ms4Z9vZi7bmPGFxOuC6HL7fXkYcjgtvnAnmyOa7ni3WuKrGsvs2ZzdEkHcSDgndHZiTFt1AN4NZuPNNALIjhLUj5M0RQd94gZyMx086iVhBDg5tPLQsRjVOwH9PoVPnIbXoYgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272993; c=relaxed/simple;
	bh=7CmYkxx6rt0G4QMbALwTqCMAh/ACJX3SZ8HUGLB3kFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnD6ZsYWCZcoSy3ADRbbYgeQJivT2WA3q2KqMAS9QXekQtqCAdPnYQPgNqOod+SyJUhCFPKthPx4dfiI61gF30HcYgH8jwHaw7wzFG5KXNbuVHAKkk0L3CHxlqls+ez1ltuw84RUdh1o6jpIBpLgVTr0lgu6w41DQBtV3IJ1NAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPeLUG/u; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-399749152b4so178866f8f.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744272989; x=1744877789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rrqz5rkfOLr6XUt3+MxTFJmjLPocpjQbDQvqiurqBY=;
        b=UPeLUG/uI/10bskEu/C47kKk5KbsfA9AvLdQPGFstPGFX6iDEVytyR6GskPIyyyv/H
         81Kx7BnyigCvtbbLzGMNb6E0n14ADGGFyLIjD3Vyr5Vqd0mWD2SkwCxcORl3RJBsiW+S
         5q+0b/8B6HhaA61ZR8JaIZUTcig1rSk1PDjlpSqcMyXKhACfY1mgn5szC+dxB30sqYZF
         ydm0nqLHH96X9u4dvo3PdWtMefz6lZeMlD1SjJfMKk+z0I8m71XCePMUDbmtk7Jr42UE
         b4lxOg9nDPl+Bxz8k5dxM+ErUcupASLxGME3XZ4LyPMdDVHJFkGyym2VZwAnh4JCL3RI
         XNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744272989; x=1744877789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rrqz5rkfOLr6XUt3+MxTFJmjLPocpjQbDQvqiurqBY=;
        b=I/ZSrv/ccAWh4Rpwwko/jVVVBciJ0eboXZxdAuQNrjHRvKB6z9b1+bT3UnCGSSHQWh
         dZ1HnVzPwVEhfVE6XrkHQu2vpqj7WfLRL16Newmoc8Hdsw5NmVICJF1io8tbQm24+sEP
         jg1KPPND0g1XLZYfBp0734lNC1RQ2BngT1h42JnmMD+seNM4t3308fk8FCYh2MUH3iBY
         geFSAVMaOYk/In8gc3wKQ3HTj20bJGXjaceuM4m8ZedQ04a6f7Z0Xh4WpVnhDUviNzLt
         OeU617PQEmWOE1scf2nxHowBhtPNR4NjmbmYnavY6khwhRLUbfcOs9obySg9fbVjbgy6
         JPcQ==
X-Gm-Message-State: AOJu0YwVu2wq1aJcgKBkrhlZdY3VhY47Q4Uc4osu7M2hu0qA4vDYskIZ
	wdSYTEI6PzL995k7d6ggMgp+s0JZ3DxjvgDNw5xThP8tsfOyqvm8rWU04E7frvs=
X-Gm-Gg: ASbGnctsfVhhFIoPmDkytGEshFvGnDRL0X8STzNy3EOy51DQH0V7MD1WJHt1mLpIMs2
	1jF0V41Dtg+ZJMjaSQ4BRXa3a+hGhbRR3Iwhwgq3IjOy9urX0BNXZW7pqKyo8zaH/BO2qSKn7Ll
	dv56g39okph4JFYkQ2AH5mCQpGtchhmtPfwzi2ku+CWkFodX4hNvPS83ZiZ33FM7EK1p9nYtm04
	cIMpnWXHdmUyTfxShiEHamOs6xwe8XfBusZoWpPvKMpLPwyCt1kkPwZyy1zoQ4Hmc/8PFm/adg8
	AvKBGvTxWpYu8emhO/PkBXpPIEvCks8FWXY=
X-Google-Smtp-Source: AGHT+IEvKKW9icy/pe8XSxok/8wLYDgiOyDoHRTCOxr30RPCWYWhe03HsnHx1wObXNUXdugb3/xWHw==
X-Received: by 2002:a05:6000:4022:b0:390:d796:b946 with SMTP id ffacd0b85a97d-39d8f4dcebfmr1303895f8f.44.1744272989521;
        Thu, 10 Apr 2025 01:16:29 -0700 (PDT)
Received: from u94a ([2401:e180:8d6c:a9cc:a5be:1621:ded:f4b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d465d7sm2651714b3a.47.2025.04.10.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:16:28 -0700 (PDT)
Date: Thu, 10 Apr 2025 16:16:01 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf] libbpf: Fix buffer overflow in bpf_object__init_prog
Message-ID: <b5yyvqbzff6pf4lyducvu7m3aw4wskoakz2l75aedte5lubtvd@327tjmlssvbk>
References: <20250410073407.131211-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410073407.131211-1-vmalik@redhat.com>

I was about to sent my fix, just to realize I got beaten by half and
hour+ even with my 6 hour timezone advantage :)

On Thu, Apr 10, 2025 at 09:34:07AM +0200, Viktor Malik wrote:
> As reported by CVE-2025-29481 (link below), it is possible to corrupt a
> BPF ELF file such that arbitrary BPF instructions are loaded by libbpf.
> This can be done by setting a symbol (BPF program) section offset to a
> sufficiently large (unsigned) number such <section_start+symbol_offset>
> overflows and points before the section.
> 
> Consider the situation below where:
> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
> - prog_end   = prog_start + prog_size
> 
>     prog_start        sec_start        prog_end        sec_end
>         |                |                 |              |
>         v                v                 v              v
>     .....................|################################|............
> 
> Currently, libbpf only checks that prog_end is within the section
> bounds. Add a check that prog_start is also within the bounds to avoid
> the potential buffer overflow.

I would add

Reported-by: lmarch2 <2524158037@qq.com>
Cc: stable@vger.kernel.org
Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")

There used to be a 'while (sec_off < sec_sz)' check that would prevent
this issue, but with commit 6245947c1b3c that was removed.

---

Nit: it would be nice if some concrete values from the reproducer is
included

  Section Headers:
    [Nr] Name              				Type            Address          	Off    	Size   	ES Flg Lk Inf Al
    ...
    [ 2] uretprobe.multi.snter_write 		PROGBITS        0000000000000000 	000040 	000068 	00  AX  0   0  8

  Symbol table '.symtab' contains 8 entries:
     Num:    Value          Size Type    Bind   Vis      Ndx Name
       ...
       6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp

As well as AddressSanitizer output:

  libbpf: loading object from crash-04573b0232eeaed1b2cd9f10e4fadc122c560e7a
  libbpf: elf: section(2) uretprobe.multi.snter_write, size 104, link 0, flags 6, type=1
  libbpf: sec 'uretprobe.multi.snter_write': found program 'handle_tp' at insn offset 0 (0 bytes), code size 13 insns (104 bytes)
  libbpf: sec 'uretprobe.multi.snter_write': found program 'handle_tp' at insn offset 2305843009213693943 (18446744073709551544 bytes), code size 13 insns (104 bytes)
  =================================================================
  ==169293==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c1fc6be0000 at pc 0x7f6fc831f877 bp 0x7ffc89800a30 sp 0x7ffc898001f0
  READ of size 104 at 0x7c1fc6be0000 thread T0
      #0 0x7f6fc831f876 in memcpy (/lib64/libasan.so.8+0x11f876) (BuildId: 7a83eb8b5639d83795773bfac12481d6f3243469)
      #1 0x00000040fcbf in bpf_object__init_prog ./tools/lib/bpf/libbpf.c:856
      #2 0x00000040fcbf in bpf_object__add_programs ./tools/lib/bpf/libbpf.c:928
      #3 0x00000040fcbf in bpf_object__elf_collect ./tools/lib/bpf/libbpf.c:3930
      #4 0x00000040fcbf in bpf_object_open ./tools/lib/bpf/libbpf.c:8067
      #5 0x000000411b83 in bpf_object__open_file ./tools/lib/bpf/libbpf.c:8090
      #6 0x000000403966 in main (../poc/libbpf/poc+0x403966) (BuildId: 9d80b3f3edc46b2a3684427aad5fe2bcda2b5ea4)
      ...

> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

Code-wise LGTM

Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

