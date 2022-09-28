Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B45EE466
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 20:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiI1SbR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiI1SbM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 14:31:12 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054D55095
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 11:31:09 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id f4so1866067uav.3
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=jAzB11fm8T6qNdKl1ZgGe3YjZRpewzIMzPypm59utd8=;
        b=aeGzRO45EQsuWXVpC1Dz8smiToETAk5jNZaF5IW58u2kfvVprvpGZ6VrjF3M078Cnc
         sCEoLsE6C29s1cJlj4S0rI4AJAoNL+1SeB8TBuz2EzUKLkJlMsPqcNr58CZWT5afQccg
         d5sS8DP5SgIXFD1Z7tjWCZ7EC2ZWw5hiaVxLtb0F4X5JEAjQBEHDPrqxSI6Zyk0yz6cj
         138AHHT3U7T4YmprtHyVvJ8bsjr+SKcqOxmxfS35+tIctAn6E/IUctkCbrALsFtPWjpi
         kvJrfz+b7BSocTzYlBfCS7mDvBDiVgvekO8Djurp57xKhb9fLQZMLaY5ZotGaIUNmH00
         8zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jAzB11fm8T6qNdKl1ZgGe3YjZRpewzIMzPypm59utd8=;
        b=V8x6sVaP7Aakipa+K9sQCP1sTjC9LscbhoUTn9SEFWCGAAxU5hYDAVX7ab2KCyoIl0
         0B4GBJ4rSIgeimSfC81TDFMUbHzllyyW3ZNUAst6k88UKpE16n7uo7m3BkKdWpvfFSbl
         KX099sqr1clx6gzym7CIQVtdPLbcSqSQjvOvgGJQ0AmX6lRkruAQo8c7LKn/ZMhxWRjE
         CVEVqd/t2bava2GkREEDMcJt8qdSL8KnErYcR0udYbt3D6XMvYnrU92ZNEIfnCIJazLU
         +kCyZmtfRH/7q7C32HbfNxVJ72nBUxLHIOIfztZvAZX3O0uue+lcqM0LnB0PH2IonWWh
         4OAQ==
X-Gm-Message-State: ACrzQf1lDgHw1Aj52p49xgoNxX4g0Hb3ydrnPyT4vJgBzWj4olB+v4qY
        TD/u7nyWyCdXCF35g9FgzKMxnG01kWoxk7gRSHTYwQalQVZ4rw==
X-Google-Smtp-Source: AMsMyM74pZkAnSst24vlZVFJh1aRCDWFxZx07CMkOlmuEFXRrJWnHo+sTNT1Q2986B5R6MhRmuSCJtp0C6WtjfZ8/1k=
X-Received: by 2002:ab0:2b8a:0:b0:3be:f6f9:a647 with SMTP id
 q10-20020ab02b8a000000b003bef6f9a647mr16004902uar.34.1664389867759; Wed, 28
 Sep 2022 11:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-VjpyJxPNJ0438FbxEWxNbyL7zsCFwrEt6Tzw-vHz0ZQHxmg@mail.gmail.com>
In-Reply-To: <CAP-VjpyJxPNJ0438FbxEWxNbyL7zsCFwrEt6Tzw-vHz0ZQHxmg@mail.gmail.com>
From:   Owayss Kabtoul <owayssk@gmail.com>
Date:   Wed, 28 Sep 2022 20:30:31 +0200
Message-ID: <CAP-Vjpzqw=_t61tyJ7SPCLHresuX7XXv2gyQgO8NW1p5dNsViQ@mail.gmail.com>
Subject: Fwd: bpf syscall failing on aarch64 with "Invalid argument" (Asahi
 Linux on M1)
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello.

I have built libbpf from source (a7c0f7e). When running any of the
provided examples, the bpf syscall fails with "Invalid argument":

```
$ sudo strace ./minimal
[sudo] password for owayss:
execve("./minimal", ["./minimal"], 0xffffff88af60 /* 27 vars */) = 0
brk(NULL)                               = 0xaaab19c54000
faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such
file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=181223, ...},
AT_EMPTY_PATH) = 0
mmap(NULL, 181223, PROT_READ, MAP_PRIVATE, 3, 0) = 0xffff03d24000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\0\0\0\0\0\0\0\0"...,
832) = 832
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=592248, ...},
AT_EMPTY_PATH) = 0
mmap(NULL, 721128, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff03c70000
mmap(0xffff03c70000, 655592, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xffff03c70000
munmap(0xffff03d14000, 49384)           = 0
mprotect(0xffff03d00000, 49152, PROT_NONE) = 0
mmap(0xffff03d0c000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8c000) = 0xffff03d0c000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libelf.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\0\0\0\0\0\0\0\0"...,
832) = 832
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=108656, ...},
AT_EMPTY_PATH) = 0
mmap(NULL, 237592, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff03c34000
mmap(0xffff03c40000, 172056, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xffff03c40000
munmap(0xffff03c34000, 49152)           = 0
munmap(0xffff03c6c000, 8216)            = 0
mprotect(0xffff03c5c000, 49152, PROT_NONE) = 0
mmap(0xffff03c68000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x18000) = 0xffff03c68000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\0\0\0\0\0\0\0\0"...,
832) = 832
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=92048, ...}, AT_EMPTY_PATH) = 0
mmap(NULL, 221200, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xffff03c08000
mmap(0xffff03c10000, 155664, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xffff03c10000
munmap(0xffff03c08000, 32768)           = 0
munmap(0xffff03c38000, 24592)           = 0
mprotect(0xffff03c28000, 49152, PROT_NONE) = 0
mmap(0xffff03c34000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0xffff03c34000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0p}\2\0\0\0\0\0"...,
832) = 832
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=1673696, ...},
AT_EMPTY_PATH) = 0
mmap(NULL, 1842496, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xffff03a4c000
mmap(0xffff03a50000, 1776960, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xffff03a50000
munmap(0xffff03a4c000, 16384)           = 0
munmap(0xffff03c04000, 40256)           = 0
mprotect(0xffff03be0000, 65536, PROT_NONE) = 0
mmap(0xffff03bf0000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x190000) = 0xffff03bf0000
mmap(0xffff03bf8000, 40256, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffff03bf8000
close(3)                                = 0
mmap(NULL, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xffff03d1c000
set_tid_address(0xffff03d1c510)         = 21560
set_robust_list(0xffff03d1c520, 24)     = 0
rseq(0xffff03d1cbe0, 0x20, 0, 0xd428bc00) = 0
mprotect(0xffff03bf0000, 16384, PROT_READ) = 0
mprotect(0xffff03d0c000, 16384, PROT_READ) = 0
mprotect(0xffff03d8c000, 16384, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024,
rlim_max=RLIM64_INFINITY}) = 0
munmap(0xffff03d24000, 181223)          = 0
getrandom("\x9e\xc7\x11\xbd\x76\x65\x6b\x8b", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0xaaab19c54000
brk(0xaaab19c78000)                     = 0xaaab19c78000
write(2, "libbpf: loading object 'minimal_"..., 49libbpf: loading
object 'minimal_bpf' from buffer
) = 49
faccessat(AT_FDCWD, "/proc/version_signature", R_OK) = -1 ENOENT (No
such file or directory)
uname({sysname="Linux", nodename="owayss-mac", ...}) = 0
write(2, "libbpf: elf: section(3) tp/sysca"..., 87libbpf: elf:
section(3) tp/syscalls/sys_enter_write, size 104, link 0, flags 6,
type=1
) = 87
write(2, "libbpf: sec 'tp/syscalls/sys_ent"..., 128libbpf: sec
'tp/syscalls/sys_enter_write': found program 'handle_tp' at insn
offset 0 (0 bytes), code size 13 insns (104 bytes)
) = 128
write(2, "libbpf: elf: section(4) .reltp/s"..., 92libbpf: elf:
section(4) .reltp/syscalls/sys_enter_write, size 32, link 13, flags
40, type=9
) = 92
write(2, "libbpf: elf: section(5) license,"..., 66libbpf: elf:
section(5) license, size 13, link 0, flags 3, type=1
) = 66
write(2, "libbpf: license of minimal_bpf i"..., 47libbpf: license of
minimal_bpf is Dual BSD/GPL
) = 47
write(2, "libbpf: elf: section(6) .bss, si"..., 62libbpf: elf:
section(6) .bss, size 4, link 0, flags 3, type=8
) = 62
write(2, "libbpf: elf: section(7) .rodata,"..., 66libbpf: elf:
section(7) .rodata, size 28, link 0, flags 2, type=1
) = 66
write(2, "libbpf: elf: section(8) .BTF, si"..., 64libbpf: elf:
section(8) .BTF, size 601, link 0, flags 0, type=1
) = 64
write(2, "libbpf: elf: section(10) .BTF.ex"..., 69libbpf: elf:
section(10) .BTF.ext, size 160, link 0, flags 0, type=1
) = 69
write(2, "libbpf: elf: section(13) .symtab"..., 68libbpf: elf:
section(13) .symtab, size 192, link 1, flags 0, type=2
) = 68
write(2, "libbpf: looking for externs amon"..., 47libbpf: looking for
externs among 8 symbols...
) = 47
write(2, "libbpf: collected 0 externs tota"..., 34libbpf: collected 0
externs total
) = 34
write(2, "libbpf: map 'minimal_.bss' (glob"..., 77libbpf: map
'minimal_.bss' (global data): at sec_idx 6, offset 0, flags 400.
) = 77
mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
0) = 0xffff03d50000
write(2, "libbpf: map 0 is \"minimal_.bss\"\n", 32libbpf: map 0 is
"minimal_.bss"
) = 32
write(2, "libbpf: map 'minimal_.rodata' (g"..., 80libbpf: map
'minimal_.rodata' (global data): at sec_idx 7, offset 0, flags 480.
) = 80
mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
0) = 0xffff03d4c000
write(2, "libbpf: map 1 is \"minimal_.rodat"..., 35libbpf: map 1 is
"minimal_.rodata"
) = 35
write(2, "libbpf: sec '.reltp/syscalls/sys"..., 114libbpf: sec
'.reltp/syscalls/sys_enter_write': collecting relocation for
section(3) 'tp/syscalls/sys_enter_write'
) = 114
write(2, "libbpf: sec '.reltp/syscalls/sys"..., 81libbpf: sec
'.reltp/syscalls/sys_enter_write': relo #0: insn #2 against 'my_pid'
) = 81
write(2, "libbpf: prog 'handle_tp': found "..., 83libbpf: prog
'handle_tp': found data map 0 (minimal_.bss, sec 6, off 0) for insn 2
) = 83
write(2, "libbpf: sec '.reltp/syscalls/sys"..., 82libbpf: sec
'.reltp/syscalls/sys_enter_write': relo #1: insn #6 against '.rodata'
) = 82
write(2, "libbpf: prog 'handle_tp': found "..., 86libbpf: prog
'handle_tp': found data map 1 (minimal_.rodata, sec 7, off 0) for insn
6
) = 86
getpid()                                = 21560
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2,
insns=0xffffdfa76b78, license="GPL", log_level=0, log_size=0,
log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0,
prog_name="", prog_ifindex=0,
expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0,
func_info_rec_size=0, func_info=NULL, func_info_cnt=0,
line_info_rec_size=0, line_info=NULL, line_info_cnt=0,
attach_btf_id=0, attach_prog_fd=0}, 116) = 3
close(3)                                = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2,
insns=0xffffdfa76df8, license="GPL", log_level=0, log_size=0,
log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0,
prog_name="", prog_ifindex=0,
expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0,
func_info_rec_size=0, func_info=NULL, func_info_cnt=0,
line_info_rec_size=0, line_info=NULL, line_info_cnt=0,
attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 144) = 3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0\20\0\0\0\20\0\0\0\5\0\0\0\1\0\0\0\0\0\0\1"...,
btf_log_buf=NULL, btf_size=45, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"...,
btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\08\0\0\08\0\0\0\t\0\0\0\0\0\0\0\0\0\0\1"...,
btf_log_buf=NULL, btf_size=89, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0\f\0\0\0\f\0\0\0\7\0\0\0\1\0\0\0\0\0\0\20"...,
btf_log_buf=NULL, btf_size=43, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"...,
btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\5\0\0\0\0\0\0\0\0\0\0\1"...,
btf_log_buf=NULL, btf_size=77, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0(\0\0\0(\0\0\0\5\0\0\0\0\0\0\0\0\0\0\1"...,
btf_log_buf=NULL, btf_size=69, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0\f\0\0\0\f\0\0\0\10\0\0\0\1\0\0\0\0\0\0\23"...,
btf_log_buf=NULL, btf_size=44, btf_log_size=0, btf_log_level=0}, 28) =
3
close(3)                                = 0
bpf(BPF_BTF_LOAD,
{btf="\237\353\1\0\30\0\0\0\0\0\0\0\20\1\0\0\20\1\0\0001\1\0\0\0\0\0\0\0\0\0\2"...,
btf_log_buf=NULL, btf_size=601, btf_log_size=0, btf_log_level=0}, 28)
= 3
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0,
map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) =
4
close(4)                                = 0
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
value_size=32, max_entries=1, map_flags=0, inner_map_fd=0,
map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) =
4
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=5,
insns=0xffffdfa76a60, license="GPL", log_level=0, log_size=0,
log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0,
prog_name="", prog_ifindex=0,
expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0,
func_info_rec_size=0, func_info=NULL, func_info_cnt=0,
line_info_rec_size=0, line_info=NULL, line_info_cnt=0,
attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 144) = 5
close(4)                                = 0
close(5)                                = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2,
insns=0xffffdfa769b8, license="GPL", log_level=0, log_size=0,
log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0,
prog_name="test", prog_ifindex=0,
expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0,
func_info_rec_size=0, func_info=NULL, func_info_cnt=0,
line_info_rec_size=0, line_info=NULL, line_info_cnt=0,
attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 144) = 4
close(4)                                = 0
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0,
map_name="minimal_.bss", map_ifindex=0, btf_fd=3, btf_key_type_id=0,
btf_value_type_id=13, btf_vmlinux_value_type_id=0, map_extra=0}, 72) =
4
write(2, "libbpf: map 'minimal_.bss': crea"..., 55libbpf: map
'minimal_.bss': created successfully, fd=4
) = 55
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=4, key=0xffffdfa76bbc,
value=0xffff03d50000, flags=BPF_ANY}, 144) = 0
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
value_size=28, max_entries=1,
map_flags=BPF_F_RDONLY_PROG|BPF_F_MMAPABLE, inner_map_fd=0,
map_name="minimal_.rodata", map_ifindex=0, btf_fd=3,
btf_key_type_id=0, btf_value_type_id=14, btf_vmlinux_value_type_id=0,
map_extra=0}, 72) = 5
write(2, "libbpf: map 'minimal_.rodata': c"..., 58libbpf: map
'minimal_.rodata': created successfully, fd=5
) = 58
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0xffffdfa76bbc,
value=0xffff03d4c000, flags=BPF_ANY}, 144) = 0
bpf(BPF_MAP_FREEZE, {map_fd=5}, 144)    = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=13,
insns=0xaaab19c55440, license="Dual BSD/GPL", log_level=0, log_size=0,
log_buf=NULL, kern_version=KERNEL_VERSION(6, 0, 0), prog_flags=0,
prog_name="handle_tp", prog_ifindex=0,
expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=3,
func_info_rec_size=8, func_info=0xaaab19c546b0, func_info_cnt=1,
line_info_rec_size=16, line_info=0xaaab19c545f0, line_info_cnt=6,
attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 144) = -1 EINVAL
(Invalid argument)
mmap(NULL, 16793600, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xffff02a4c000
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=13,
insns=0xaaab19c55440, license="Dual BSD/GPL", log_level=1,
log_size=16777215, log_buf="", kern_version=KERNEL_VERSION(6, 0, 0),
prog_flags=0, prog_name="handle_tp", prog_ifindex=0,
expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=3,
func_info_rec_size=8, func_info=0xaaab19c546b0, func_info_cnt=1,
line_info_rec_size=16, line_info=0xaaab19c545f0, line_info_cnt=6,
attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 144) = -1 EINVAL
(Invalid argument)
write(2, "libbpf: prog 'handle_tp': BPF pr"..., 68libbpf: prog
'handle_tp': BPF program load failed: Invalid argument
) = 68
munmap(0xffff02a4c000, 16793600)        = 0
write(2, "libbpf: prog 'handle_tp': failed"..., 46libbpf: prog
'handle_tp': failed to load: -22
) = 46
close(4)                                = 0
close(5)                                = 0
write(2, "libbpf: failed to load object 'm"..., 44libbpf: failed to
load object 'minimal_bpf'
) = 44
write(2, "libbpf: failed to load BPF skele"..., 55libbpf: failed to
load BPF skeleton 'minimal_bpf': -22
) = 55
write(2, "Failed to load and verify BPF sk"..., 39Failed to load and
verify BPF skeleton
) = 39
close(3)                                = 0
munmap(0xffff03d50000, 16384)           = 0
munmap(0xffff03d4c000, 16384)           = 0
exit_group(22)                          = ?
+++ exited with 22 +++

```

My relevant Kernel configuration is:

```
$ cat /proc/config.gz | gunzip | grep -i bpf
CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
# BPF subsystem
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem
CONFIG_CGROUP_BPF=y
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
CONFIG_NET_CLS_BPF=y
CONFIG_NET_ACT_BPF=m
CONFIG_BPF_STREAM_PARSER=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_BPF_LIRC_MODE2=y
```

That is running on a:
```
$ uname -r
6.0.0-rc6-asahi-1-1-ARCH

$ uname -m
aarch64
```


Any pointers on where to look for what might cause this issue?

Owayss.
