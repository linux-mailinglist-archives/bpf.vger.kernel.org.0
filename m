Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1428F433124
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJSIg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhJSIg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 04:36:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598A2C06161C
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 01:34:45 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z126so3728746oiz.12
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=/H3bg8Xi+VZb3zMLvaWVOvPa4UmPkZdVnraByZe4fnk=;
        b=Xr0IDWtuNmTwBCa4RYzl5++aKbeUokiNo6ZN0D6cdBfpg+i7GRiKgtBZVwkb2Uqm58
         iO1SoX7B7RzChsqBrIJGnbaErvuFCTRBFMyYOE590ECwxw5m/b/0rKzXRzRlMPmbzySU
         PgZPZY4S80UQa4rn4PIF4ml5ElasajLJbafwi1C3iWWiuwqvsX5lA1MHpnDCERekXNqL
         EEW2760gZaVuR3hjdMydmU0t37U8EJixdJeqcdMNNALTYNvlj1A50J30qjK/zrxRKFx7
         1wYTzzx6I4fNgX2grtC3KMytLoz7UWb5JToswTmDg2kBNCr2fUJEL2naU5fchmFsz3A0
         JZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/H3bg8Xi+VZb3zMLvaWVOvPa4UmPkZdVnraByZe4fnk=;
        b=KYT2Xm4PAfHMx6PxkkZkjSmDZ0YNCCxIALO/fMnNSUsoGh7QZqfEQv1xD4P+nR093q
         hVHbk9c8agepGQdBnO0PSMhTYkW0+bM4Dz2c6CCtcmKAH1z7jMAmghE0eV6Q10GNhYvd
         Dk+8P1EgD5TnrstXIpVsfWDqK6mN8c0Ppn6d4oL8O10+e5LgeO79uovPt9oJVCdMpVVW
         lHTEvfFXqWECMdjNoRbfg3GCq5aavW34GJzCR+4chLmkgVpX4OSQaZjySCVJxM8L5e85
         HyrY4PMVZogOssi1rrWMDJYKeLRS+BX4hVdpb6iB2XqT0KdZdmLhAZdfgisOXJalMfrm
         lZAA==
X-Gm-Message-State: AOAM53398viLGtPoY/fLjmKWX0heFTnA4q6oMkzCQPhW4+4U9czzGGcE
        HPwsDFWP9+tO/QtKT6M9hxjkR1b2HWIMgEPOQSn56h6V3eM=
X-Google-Smtp-Source: ABdhPJzWLbSYmnBkmjwIj7zJszPieNN5Hfigd9okiMeiW63o5vPECTiHNwPfzP7/HsQ/Ut0LlgnlU8OZruXQ/jECLLA=
X-Received: by 2002:a05:6808:54e:: with SMTP id i14mr3099496oig.103.1634632484342;
 Tue, 19 Oct 2021 01:34:44 -0700 (PDT)
MIME-Version: 1.0
From:   Pony Sew <poony20115@gmail.com>
Date:   Tue, 19 Oct 2021 16:34:33 +0800
Message-ID: <CAK-59YGy07UCOuLL76XcS20Du0SHCerqe1mBb3S40FYR7_9Caw@mail.gmail.com>
Subject: How to improve CO-RE result on Debian9 and Debian10?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings.
I apologize for my last email. It may be confusing and hard to read.
So I edited some content and hopefully it's easier to understand this
time.
I'm new to BPF CO-RE. And my goal is to have some simple bpf programs
being able to run on both Debian9 and Debian10. This
(https://github.com/sartura/ebpf-core-sample) is the code I'm using.
So far, both worked on Debian11, but both failed on Debian9, and only
'maps' succeeded on Debian10. I'd like to improve this result.

Here are some informations about my Debian 11 amd64 main compilation
environment:

- kernel version : 5.10.0-9-amd64
- Debian clang version 11.0.1-2 x86_64-pc-linux-gnu
- gcc (Debian 10.2.1-6) 10.2.1 20210110
- GNU Make 4.3 Built for x86_64-pc-linux-gnu
- bpftool : v5.10.70 empty feature
- BPF and BTF setup in /boot/config-5.10.0-9-amd64 remains default

This is how I compiled them in steps:

# bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
# clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c hello.bpf.c -o
# hello.bpf.o
# bpftool gen skeleton hello.bpf.o > hello.skel.h
# clang -g -O2 -Wall -I . -c hello.c -o hello.o
# git clone https://github.com/libbpf/libbpf
# cd libbpf/src
# make BUILD_STATIC_ONLY=1 OBJDIR=../build/libbpf DESTDIR=../build
INCLUDEDIR= LIBDIR= UAPIDIR= install
# cd ../../
# clang -Wall -O2 -g hello.o libbpf/build/libbpf.a -lelf -lz -o hello
# clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c maps.bpf.c
-o maps.bpf.o
# bpftool gen skeleton maps.bpf.o > maps.skel.h
# clang -g -O2 -Wall -I . -c maps.c -o maps.o
# clang -Wall -O2 -g maps.o libbpf/build/libbpf.a -lelf -lz -o maps

Neither error nor warning appeared during these compilation steps.
------------------------------------------------------------------------------------------------------------------------
Here are some informations about Debian9:

- kernel : 4.9.0-16-amd64
- BPF setup in /boot/config-4.9.0-16-amd64 remains default

Result of executing 'hello' on Debian9 :
libbpf: kernel doesn't support global data
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -95
failed to load BPF object -95

Result of executing 'maps' on Debian9 :
libbpf: load bpf program failed: Permission denied
libbpf: -- BEGIN DUMP LOG ---
libbpf:
0: (85) call 15
1: (bf) r6 = r0
2: (85) call 14
3: (63) *(u32 *)(r10 -4) = r0
4: (b7) r1 = 0
5: (7b) *(u64 *)(r10 -32) = r1
6: (7b) *(u64 *)(r10 -24) = r1
7: (7b) *(u64 *)(r10 -16) = r1
8: (bf) r2 = r10
9: (07) r2 += -4
10: (bf) r3 = r10
11: (07) r3 += -32
12: (18) r1 = 0xffff9e7738ca0e40
14: (b7) r4 = 1
15: (85) call 2
16: (55) if r0 != 0x0 goto pc+12
 R0=inv,min_value=0,max_value=0 R6=inv R10=fp
17: (bf) r2 = r10
18: (07) r2 += -4
19: (18) r1 = 0xffff9e7738ca0e40
21: (85) call 1
22: (15) if r0 == 0x0 goto pc+6
 R0=map_value(ks=4,vs=24,id=0),min_value=0,max_value=0 R6=inv R10=fp
23: (61) r1 = *(u32 *)(r10 -4)
24: (63) *(u32 *)(r0 +20) = r6
25: (63) *(u32 *)(r0 +16) = r1
26: (bf) r1 = r0
27: (b7) r2 = 16
28: (85) call 16
R1 type=map_value expected=fp

libbpf: -- END LOG --
libbpf: failed to load program 'tracepoint__syscalls__sys_enter_execve'
libbpf: failed to load object 'maps_bpf'
libbpf: failed to load BPF skeleton 'maps_bpf': -4007
failed to load BPF object -4007
--------------------------------------------------------------------------------------------------------------------------
Here are some informations about Debian10:

- kernel : 4.19.0-17-amd64
- BPF setup in /boot/config-4.19.0-17-amd64 remains default

Result of executing 'hello' on Debian10 :
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
version: 1
flags: 0x0
hdr_len: 24
type_off: 0
type_len: 464
str_off: 464
str_len: 423
btf_total_size: 911
[1] PTR (anon) type_id=2
[2] STRUCT trace_event_raw_sys_enter size=64 vlen=4
ent type_id=3 bits_offset=0
id type_id=7 bits_offset=64
args type_id=9 bits_offset=128
__data type_id=12 bits_offset=512
[3] STRUCT trace_entry size=8 vlen=4
type type_id=4 bits_offset=0
flags type_id=5 bits_offset=16
preempt_count type_id=5 bits_offset=24
pid type_id=6 bits_offset=32
[4] INT unsigned short size=2 bits_offset=0 nr_bits=16 encoding=(none)
[5] INT unsigned char size=1 bits_offset=0 nr_bits=8 encoding=(none)
[6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[7] INT long int size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[8] INT long unsigned int size=8 bits_offset=0 nr_bits=64 encoding=(none)
[9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=6
[10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
[11] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[12] ARRAY (anon) type_id=11 index_type_id=10 nr_elems=0
[13] ENUM (anon) size=4 vlen=1
ctx val=1
[14] TYPEDEF tracepoint__syscalls__sys_enter_execve type_id=13
[15] CONST (anon) type_id=11
[16] ARRAY (anon) type_id=15 index_type_id=10 nr_elems=14
[17] INT tracepoint__syscalls__sys_enter_execve.____fmt size=1
bits_offset=0 nr_bits=8 encoding=(none)
[18] ARRAY (anon) type_id=11 index_type_id=10 nr_elems=4
[19] INT LICENSE size=1 bits_offset=0 nr_bits=8 encoding=(none)
[20] STRUCT _rodata size=14 vlen=1
tracepoint__syscalls__sys_enter_execve.____fmt type_id=17
bits_offset=0 Invalid name

libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.
libbpf: kernel doesn't support global data
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -95
failed to load BPF object -95
----------------------------------------------------------------------------------------------------------------------
Overall, 'hello' has common "global data" issue on both Debian9 and
Debian10, and 'maps' has a weird "Permission issue" on Debian9 even if
I execute it with a root permission. I'd like to improve these results
and make them executable on both Debian9 and Debian10.

Sincerely,
Poony.
