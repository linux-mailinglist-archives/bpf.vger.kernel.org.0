Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088832CDCDD
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLCR5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 12:57:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgLCR5N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 12:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607018146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7jarjHg35SrM+mxNLirg4qNUTGKmjpxYZq/xySyiUcs=;
        b=M55vwdnkbNkKs7MXZ8tOiVwLoyPSsaq3zklOj507fY2wGokFWMIuFiKM+AHQZ10buldebH
        I7YTg51F3/W5tuVYJcTAAQm8owTSLV5BvoEAX3x7KEqdhCfJHuX+0+qZ1yUtAO+SRBb8c0
        3gmFgB2KEhMk6VQZeVJDb8GKBeXhNao=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-9mNrCtSFPwGsPRsKuL5UeQ-1; Thu, 03 Dec 2020 12:55:44 -0500
X-MC-Unique: 9mNrCtSFPwGsPRsKuL5UeQ-1
Received: by mail-ej1-f71.google.com with SMTP id u15so1070380ejg.17
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 09:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=7jarjHg35SrM+mxNLirg4qNUTGKmjpxYZq/xySyiUcs=;
        b=JNYTfTjDunQ52unlMnGZQIoGGKW34CEIfcBmhlvTObX7CnvFrFVRV88jj1X16n++pF
         f907cTJfxDi2LTAUQkBi9vgKukZ9/3xSNw4mhQ+WSqywG4PMiRYSAm0fOS7I9o86/Auu
         89NMlGTo2cY0dL8aM6dqxi2hkdyYwBqzvH1D0vP6tSGzL40ukg5Mqc6EI2I1TZUA2/x1
         6fONA2B845UGR2TiUdJFLRNcDbiRmCGQDKYdmt7/ZNqb42e/nAx6jtajvc7XREMf0twy
         CEGe2yUdYC3li5oStyOeO5sWtw+85xA54ymyhvdgECIYTDDK7YcCURw5MCdD99ApU3wC
         Qi8A==
X-Gm-Message-State: AOAM5312C5y43r8AGRUeY6oQPLbrMXTFUh5Z/GoN624VjxbYZkr0lHwI
        gBvAmqxo8lD64zp8zy+Yrt+1h4yEYu9YiwBFMtezMvTHTN7W/jK1fv4V79terB78fmwZxn3qyq2
        1sHdpj7g6g4Z5
X-Received: by 2002:a50:af65:: with SMTP id g92mr3914167edd.273.1607018143016;
        Thu, 03 Dec 2020 09:55:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUaXq90Qkkvm2l+8AtC24DhIrfJXwwbkJQCT8hIl6pia+o2mXsbpD5UcD8w+bM5MsMZ/zLkQ==
X-Received: by 2002:a50:af65:: with SMTP id g92mr3914157edd.273.1607018142743;
        Thu, 03 Dec 2020 09:55:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e3sm1339561ejq.96.2020.12.03.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 09:55:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6346181CF8; Thu,  3 Dec 2020 18:55:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Latest libbpf fails to load programs compiled with old LLVM
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Dec 2020 18:55:41 +0100
Message-ID: <87lfeebwpu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii

I noticed that recent libbpf versions fail to load BPF files compiled
with old versions of LLVM. E.g., if I compile xdp-tools with LLVM 7 I
get:

$ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
Loading 1 files on interface 'testns'.
libbpf: loading ../lib/testing/xdp_drop.o
libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=1
libbpf: sec 'prog': failed to find program symbol at offset 0
Couldn't open file '../lib/testing/xdp_drop.o': BPF object format invalid

The 'failed to find program symbol' error seems to have been introduced
with commit c112239272c6 ("libbpf: Parse multi-function sections into
multiple BPF programs").

Looking at the object file in question, indeed it seems to not have any
function symbols defined:

$  llvm-objdump --syms ../lib/testing/xdp_drop.o

../lib/testing/xdp_drop.o:	file format elf64-bpf

SYMBOL TABLE:
0000000000000000 l       .debug_str	0000000000000000 
0000000000000037 l       .debug_str	0000000000000000 
0000000000000042 l       .debug_str	0000000000000000 
0000000000000068 l       .debug_str	0000000000000000 
0000000000000071 l       .debug_str	0000000000000000 
0000000000000076 l       .debug_str	0000000000000000 
000000000000008a l       .debug_str	0000000000000000 
0000000000000097 l       .debug_str	0000000000000000 
00000000000000a3 l       .debug_str	0000000000000000 
00000000000000ac l       .debug_str	0000000000000000 
00000000000000b5 l       .debug_str	0000000000000000 
00000000000000bc l       .debug_str	0000000000000000 
00000000000000c9 l       .debug_str	0000000000000000 
00000000000000d4 l       .debug_str	0000000000000000 
00000000000000dd l       .debug_str	0000000000000000 
00000000000000e1 l       .debug_str	0000000000000000 
00000000000000e5 l       .debug_str	0000000000000000 
00000000000000ea l       .debug_str	0000000000000000 
00000000000000f0 l       .debug_str	0000000000000000 
00000000000000f9 l       .debug_str	0000000000000000 
0000000000000103 l       .debug_str	0000000000000000 
0000000000000113 l       .debug_str	0000000000000000 
0000000000000122 l       .debug_str	0000000000000000 
0000000000000131 l       .debug_str	0000000000000000 
0000000000000000 l    d  prog	0000000000000000 prog
0000000000000000 l    d  .debug_abbrev	0000000000000000 .debug_abbrev
0000000000000000 l    d  .debug_info	0000000000000000 .debug_info
0000000000000000 l    d  .debug_frame	0000000000000000 .debug_frame
0000000000000000 l    d  .debug_line	0000000000000000 .debug_line
0000000000000000 g       license	0000000000000000 _license
0000000000000000 g       prog	0000000000000000 xdp_drop


I assume this is because old LLVM versions simply don't emit that symbol
information?

Anyhow, the patch series that introduced this restructures the program
parsing some, so I wanted to get your input to make sure I don't break
things when fixing this regression. So what's the best way to fix it?
Just assume that the whole section is one program if no symbols are
present, or is the some subtle reason why that would break any of the
other logic for BPF-to-BPF calls?

-Toke

