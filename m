Return-Path: <bpf+bounces-17398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62180CA2B
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706591C209EE
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBEF3C06C;
	Mon, 11 Dec 2023 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BofQDYYu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35422B0
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:49:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so16253405e9.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702298949; x=1702903749; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wn3ngVq8M88X2n2QVS3cUFIVh1y4JEvEM9w/7pqqdNo=;
        b=BofQDYYuYr5xbSRQOI5XhXGaKHZOGKQVMZiuJ3vry5qYMw0TnuskjTNU95kiMH+mCf
         sTIryfno7H3SzCCrxPaqwg3GRXI4R1fgTGTq3hzuplWQuJq9RM2iGm7I6bG4xVdt67bD
         q+YtamqO14nvPf2QpJK4EMJmFstpzVf3M/eZqu+fo+HA2ZjXv8nh0mYjlvPAFBk9ka35
         Oj7bPS/Pl53adurReDYtHqpTiM80esdwbBlQ8tOTvzvpfz9k5gVPCqqVA9usf6rAR7UB
         dePnIWf4gntHdLkkH3KA9r04/iVb1SVRTfSgA+zbiu4lKI2Uj8Jl5cyL+30db7Fps0jG
         eRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702298949; x=1702903749;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wn3ngVq8M88X2n2QVS3cUFIVh1y4JEvEM9w/7pqqdNo=;
        b=ehjQUn6zasj9yAKHTqp5mx8E8xNO93ihdCHkgQGrocieCpM9FTjIsCfzt+uY7S55QI
         OiQbMq3zDA104dLLWvYSc1vF23ehpDmKngZ3Tpmp50LqN2E2u/wk9a4DD7WqPQNJ/kEg
         KsTVV6+JW/QiRR54IE/P2WwkxACyVA9wxJKDMvt+AATFFIdl0kNi09bt+fJw7HP1nAkp
         TZxhc3OGVzOBExq9EKdDLUT6NpeYy+Drb58rgglhXb+iG4RroPIO7y1M+ICL6whGb3e3
         /hiBZ/WXkHMZI4c/QfmQ4eqw6Icqk7qwVhRlZ+yNXDUC21be4UvbZ9bovJDpcsVAzfQ9
         v1jw==
X-Gm-Message-State: AOJu0YynvMUu6HTDn0Caw2ZQvoqNAWx2scp+t5v8uyiJgNbvmmitoVD/
	Stmc8RA6453N9p3usltfquM=
X-Google-Smtp-Source: AGHT+IHpnIN3d77GXSdPWLcxOjLo427lX1bSb17fs+BCJaDdIfxAbdtDPGK0jbPuyWBUqqoFYIma7A==
X-Received: by 2002:a05:600c:25a:b0:40c:3e6e:5466 with SMTP id 26-20020a05600c025a00b0040c3e6e5466mr1776428wmj.182.1702298949331;
        Mon, 11 Dec 2023 04:49:09 -0800 (PST)
Received: from nz.home (host86-154-24-14.range86-154.btcentralplus.com. [86.154.24.14])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm15100409wms.33.2023.12.11.04.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:49:08 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id 49A1913BE6392F; Mon, 11 Dec 2023 12:49:08 +0000 (GMT)
Date: Mon, 11 Dec 2023 12:49:08 +0000
From: Sergei Trofimovich <slyich@gmail.com>
To: bpf@vger.kernel.org
Subject: bpftool fails on 32-bit hosts when -Wa,--compress-debug-sections is
 used
Message-ID: <ZXcFRJVKbKxtEL5t@nz.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi bpf@!

Tl;DR:

BPF programs built with `clang`'s `-g -Wa,--compress-debug-sections`
fail when processed by `bpftool` on section alignment checks as:

    $ cat src/core/bpf/socket_bind/bpf.c
    struct socket_bind_map_t { int value; };
    struct socket_bind_map_t sd_bind_allow __attribute__((section(".maps"), used));

    $ clang-16 -target bpf -fno-stack-protector -c src/core/bpf/socket_bind/bpf.c -o bpf.unstripped.o -g -Wa,--compress-debug-sections
    $ bpftool gen object bpf.o bpf.unstripped.o
    libbpf: ELF section #9 has inconsistent alignment addr=8 != d=4 in bpf.unstripped.o
    Error: failed to link 'bpf.unstripped.o': Invalid argument (22)

This happens only when `bpftool` is a 32-bit ELF binary. 64-bit
`bpftool` seems to work as expected.

More words:

Here is my understanding of the failure. Without the
`-Wa,--compress-debug-sections` option `clang` generates byte-aligned
uncompressed `.debug` sections:

    $ clang -target bpf -fno-stack-protector -c src/core/bpf/socket_bind/bpf.c -o bpf.unstripped.o -g
    $ readelf -SW bpf.unstripped.o
    There are 19 section headers, starting at offset 0x530:
    
    Section Headers:
      [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
      [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
      [ 1] .strtab           STRTAB          0000000000000000 000471 0000b8 00      0   0  1
      [ 2] .text             PROGBITS        0000000000000000 000040 000000 00  AX  0   0  4
      [ 3] .maps             PROGBITS        0000000000000000 000040 000004 00  WA  0   0  4
      [ 4] .debug_abbrev     PROGBITS        0000000000000000 000044 00004c 00      0   0  1
      [ 5] .debug_info       PROGBITS        0000000000000000 000090 00003d 00      0   0  1
      [ 6] .rel.debug_info   REL             0000000000000000 000380 000040 10   I 18   5  8
      [ 7] .debug_str_offsets PROGBITS        0000000000000000 0000cd 000024 00      0   0  1
      [ 8] .rel.debug_str_offsets REL             0000000000000000 0003c0 000070 10   I 18   7  8
      [ 9] .debug_str        PROGBITS        0000000000000000 0000f1 000080 01  MS  0   0  1
      [10] .debug_addr       PROGBITS        0000000000000000 000171 000010 00      0   0  1
      [11] .rel.debug_addr   REL             0000000000000000 000430 000010 10   I 18  10  8
      [12] .BTF              PROGBITS        0000000000000000 000184 000099 00      0   0  4
      [13] .rel.BTF          REL             0000000000000000 000440 000010 10   I 18  12  8
      [14] .debug_line       PROGBITS        0000000000000000 00021d 000043 00      0   0  1
      [15] .rel.debug_line   REL             0000000000000000 000450 000020 10   I 18  14  8
      [16] .debug_line_str   PROGBITS        0000000000000000 000260 000041 01  MS  0   0  1
      [17] .llvm_addrsig     LOOS+0xfff4c03  0000000000000000 000470 000001 00   E 18   0  1
      [18] .symtab           SYMTAB          0000000000000000 0002a8 0000d8 18      1   8  8
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
      L (link order), O (extra OS processing required), G (group), T (TLS),
      C (compressed), x (unknown), o (OS specific), E (exclude),
      D (mbind), p (processor specific)

Note how `.debug_str` has `alignment=1` here. Loading of such a section
has no problems on x86_64 or i686.

But when we add `-Wa,--compress-debug-sections` some debug sections
become aligned 8 bytes (usual `ELF64`) alignment:

    $ clang -target bpf -fno-stack-protector -c src/core/bpf/socket_bind/bpf.c -o bpf.unstripped.o -g -Wa,--compress-debug-sections
    $ LANG=C readelf -SW bpf.unstripped.o
    There are 19 section headers, starting at offset 0x530:

    Section Headers:
      [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
      [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
      [ 1] .strtab           STRTAB          0000000000000000 000471 0000b8 00      0   0  1
      [ 2] .text             PROGBITS        0000000000000000 000040 000000 00  AX  0   0  4
      [ 3] .maps             PROGBITS        0000000000000000 000040 000004 00  WA  0   0  4
      [ 4] .debug_abbrev     PROGBITS        0000000000000000 000044 00004c 00      0   0  1
      [ 5] .debug_info       PROGBITS        0000000000000000 000090 00003d 00      0   0  1
      [ 6] .rel.debug_info   REL             0000000000000000 000380 000040 10   I 18   5  8
      [ 7] .debug_str_offsets PROGBITS        0000000000000000 0000cd 000024 00      0   0  1
      [ 8] .rel.debug_str_offsets REL             0000000000000000 0003c0 000070 10   I 18   7  8
      [ 9] .debug_str        PROGBITS        0000000000000000 0000f1 000086 01 MSC  0   0  8
      [10] .debug_addr       PROGBITS        0000000000000000 000177 000010 00      0   0  1
      [11] .rel.debug_addr   REL             0000000000000000 000430 000010 10   I 18  10  8
      [12] .BTF              PROGBITS        0000000000000000 000188 000099 00      0   0  4
      [13] .rel.BTF          REL             0000000000000000 000440 000010 10   I 18  12  8
      [14] .debug_line       PROGBITS        0000000000000000 000221 000043 00      0   0  1
      [15] .rel.debug_line   REL             0000000000000000 000450 000020 10   I 18  14  8
      [16] .debug_line_str   PROGBITS        0000000000000000 000264 000041 01  MS  0   0  1
      [17] .llvm_addrsig     LOOS+0xfff4c03  0000000000000000 000470 000001 00   E 18   0  1
      [18] .symtab           SYMTAB          0000000000000000 0002a8 0000d8 18      1   8  8
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
      L (link order), O (extra OS processing required), G (group), T (TLS),
      C (compressed), x (unknown), o (OS specific), E (exclude),
      D (mbind), p (processor specific)

Note how `.debug_str` alignment changed from 1-byte to 8-byte alignment.

AFAIU 8-byte alignment of compressed section for `ELF64` files is expected:
compressed sections all have a small header that consistes of a few
64-bit values (compression type, uncompressed size, uncompressed data
alignment).

Thus the binary loads as expected by `x86_64` `bpftool` and fails when
loaded by `i686` `bpftool`.

Should `bpftool` work in this scenario? Or compressed sections are not
supported on 32-bit hosts?

It feels like debugging sections with strings should be easily
decompressable on any host type.

Thanks!

-- 

  Sergei

