Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC1223BB2
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGQMvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 08:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgGQMvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 08:51:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D89C061755
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 05:51:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y2so10306519ioy.3
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mxsFxpuQl4d3VFhZ8FNiTbWIr8t6uAsHNtMT9oTzkM0=;
        b=ygWeONeWfdMUBF+NOaNbhtiCN5teJE1TWzwP1OLmVhnuXFzllRJOzYHnKbHP5kMFN7
         CK85ZWpHskOcWR/5jEWYSHXB3iBtuJfBBUU0z4PapcPqQvP56owiULtk+eM1VjASU7BF
         saXPZYgBP4/O5GXJ9St5ZB6sb6JY+5PCW4opWw+CNoa92pKUnvLlaqz0xiAevbxMNDBN
         ToQUliK6R0PMEbs7kqqWNPVfI7jgBPmguGW3cFx1rTc3g2IprwVnQtnpubeSFr2vpl7V
         2ao7GLmYa9nX+Wx5PXYqadC1SaOR+kUAvs+8Ad4shIb/gzPBPF18boIl7FtIftpt4h6P
         Bwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mxsFxpuQl4d3VFhZ8FNiTbWIr8t6uAsHNtMT9oTzkM0=;
        b=kysOIwW582uP8K8OLUvFYrQthMi8/imNFmZHqow5vog3UBXH/Sz5kPgbdM8qlfYMKZ
         I7ZYku2OxO3J/Qicgv0tYUHcsj3JF7wOSaocMgXUvjJl9hYrgeWofNBmXSE7oSiucg9u
         bTIW2Td5hjf4nYjj73VmgXMA1we4X4Vfae1TZxI6VD2+6CxYQfEEs1AhN9nlzFSp03Gd
         FSvcKCZmObdaIbgWuLTmObM8nWX4A02yv557SpFtR2nvW3NyYs8unkpTww6BH8UwZgE1
         YCaFjglmSfRKqYp6ghfuAMJdBE1bpQakcTGgwgZWc3TVvy83QnFnYHQbL5Cxgu1HGI+8
         JJBA==
X-Gm-Message-State: AOAM530mlWLJm8IJYrJ6Ihn6zSrxMPgSh69YBiRmSr1sP59HfUobry4P
        vspILucpZO5VodNxp2RPS0zspL6RQUoYAJ/yFMNkHw7ThRs=
X-Google-Smtp-Source: ABdhPJyx1EtIhohl/6G9+9laRGF4GdQv1+bAQUy1IFjaq5fRNW5Ym3LCRcDww/2VsyVaEyRpLp4OK6cL/cNzoqoEw1I=
X-Received: by 2002:a6b:b555:: with SMTP id e82mr9239629iof.56.1594990261687;
 Fri, 17 Jul 2020 05:51:01 -0700 (PDT)
MIME-Version: 1.0
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
Date:   Fri, 17 Jul 2020 14:50:50 +0200
Message-ID: <CACXrtpSjWKdW3DUxB6tV3RB1GvxcsHJWXpa5yTYhgyVgQXxxQw@mail.gmail.com>
Subject: bug: BPF program crashing the kernel
To:     bpf@vger.kernel.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm currently experimenting with eBPF programs. I crashed my testing
kernel with a short one of type `BPF_PROG_TYPE_SOCK_OPS` :

=====================================
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

char _license[] SEC("license") = "GPL";

SEC("sockops")
int program(struct bpf_sock_ops *skops)
{
     struct bpf_sock *sk = skops->sk;
    if (!sk) {
        bpf_printk("failed to extract the underlying bpf_sock\n");
        return 0;
    }

    return 0;
}
=====================================

It is loaded and attached to a cgroup2 using the helpers of libbpf .

====================================
#include <stdlib.h>
#include <unistd.h>
#include <sys/resource.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <bpf/libbpf.h>

#include <signal.h>

static void int_exit(int sig)
{
    exit(0);
}

int main(int argc, const char **argv)
{


        int ret, cg_fd;

        cg_fd = open("/tmp/cgroup2/client", O_DIRECTORY, O_RDONLY);
        if  (cg_fd < 0) {
            printf("Failed to get the cgroup fd, quit.\n");
            return 1;
        }

       struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
        if ((ret = setrlimit(RLIMIT_MEMLOCK, &r))) {
            printf("setrlimit %d\n", ret);
            return ret;
        }

        struct bpf_object *object_file =
bpf_object__open_file("prog_kern.o", NULL);
    if (!object_file) {
        printf("Failed to load object file");
        return 1;
    }

    ret = bpf_object__load(object_file);
        if (ret) {
        printf("Failed to load programs from object file %i\n", ret);
        return 1;
    }

        struct bpf_program *prog = bpf_program__next(NULL, object_file);
    if (!prog) {
        printf("Failed to get the BPF program from the object file\n");
        return 1;
    }

    struct bpf_link *bl = bpf_program__attach_cgroup(prog, cg_fd);
        if (!bl) {
        printf("Failed to attach the program to the cgroup\n");
                return 1;
        }

    signal(SIGINT, int_exit);

        while (1) {sleep(1);}

    return 0;
}
======================================

The testing environment is created by the following script :

======================================
#! /bin/bash

cgroups=("client" "server")

base="/tmp"
cgroup_type="cgroup2"
cpath=$base/$cgroup_type

mkdir -p $cpath
mount -t $cgroup_type none $cpath

ip l add veth1 type veth peer name veth2

i=1
for cgroup in ${cgroups[@]}
do
    mkdir -p $cpath/$cgroup

        ns_name=ns_$cgroup
        ns_exec="ip netns exec $ns_name"
        ip netns add $ns_name
        ip l set veth"$i" netns "$ns_name"
        $ns_exec ip l set dev veth"$i" up
        $ns_exec ip a add dev veth"$i" 10.0.1."$i"/24

    ((i++))

done
======================================

The commands I launch are :

======================================
# shell 1
./env.sh && cat /sys/kernel/debug/tracing/trace_pipe

# shell 2
echo $$ >> /tmp/cgroup2/client/cgroup.procs
LD_LIBRARY_PATH=/usr/local/lib64 ip netns exec ns_client ./prog_user &

# shell 3
echo $$ >> /tmp/cgroup2/server/cgroup.procs
ip netns exec ns_server python3 -m http.server &

# shell 2
ip netns exec ns_client curl 10.0.1.2:8000 -o /dev/null
======================================

The kernel in use is the latest bpf-next (sha:
bfdfa51702dec67e9fcd52568b4cf3c7f799db8b) and the .config [1] is
joined. Clang 11.0.0 is used and the compiler flags are :

======================================
LOADER_FLAGS := -lelf -lbpf
LOADER_FLAGS += -DHAVE_ATTR_TEST=0

BPF_FLAGS := -O2 -target bpf

prog_kern.o:
    @clang $(BPF_FLAGS) -c prog_kern.c \
        $(CFLAGS) -o prog_kern.o

prog_user: prog_kern.o
    @clang  $(CFLAGS) $(LOADER_FLAGS) \
        -o prog_user prog_user.c
=====================================

I noticed that adding a `bpf_printk` before the `bpf_sock` extraction
allows to avoid the crash. I also got 2 different call traces :
- First run the non buggy program containing the `bpf_printk`, then
run the buggy program (the same recompiled without the first
`bpf_printk`).

===================================
[   80.420713] BUG: kernel NULL pointer dereference, address: 0000000000000001
[   80.421897] #PF: supervisor read access in kernel mode
[   80.422718] #PF: error_code(0x0000) - not-present page
[   80.423535] PGD 0 P4D 0
[   80.423981] Oops: 0000 [#1] SMP PTI
[   80.424621] CPU: 0 PID: 174 Comm: curl Not tainted 5.8.0-rc4+ #73
[   80.425675] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[   80.427146] RIP: 0010:___bpf_prog_run+0x15e/0x14a0
[   80.427971] Code: 54 cd 00 e8 44 03 ff ff e9 d8 fe ff ff 0f b6 43
01 48 0f bf 4b 02 48 83 c3 08 89 c2 83 e0 0f c0 ea 04 0f b6 d2 49 8b
54 d5 00 <48> 8b 14 0a 49 89 54 c5 00 e9 ad fe ff ff 0f b6 43 01 48 0f
bf 53
[   80.430926] RSP: 0018:ffffbb20c01a3be0 EFLAGS: 00010202
[   80.431744] RAX: 0000000000000001 RBX: ffffbb20c0149050 RCX: 0000000000000000
[   80.432832] RDX: 0000000000000001 RSI: 0000000000000079 RDI: ffffbb20c01a3c50
[   80.433964] RBP: 0000000000000000 R08: 00000000ab975fd4 R09: 53367dbb15c4d95d
[   80.435058] R10: ffffbb20c01a3d88 R11: 0000000000000000 R12: ffffbb20c01a3ca8
[   80.436212] R13: ffffbb20c01a3c50 R14: ffffbb20c01a3d20 R15: ffff99daed8408c0
[   80.437397] FS:  00007efc4b004740(0000) GS:ffff99daef000000(0000)
knlGS:0000000000000000
[   80.438697] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.439640] CR2: 0000000000000001 CR3: 000000002d82e003 CR4: 00000000001606f0
[   80.440715] Call Trace:
[   80.441132]  __bpf_prog_run64+0x3c/0x60
[   80.441731]  ? radix_tree_delete_item+0x69/0xc0
[   80.442438]  ? __ip_dev_find+0x2c/0xe0
[   80.443037]  ? fib_table_lookup+0x210/0x700
[   80.443730]  __cgroup_bpf_run_filter_sock_ops+0x6f/0xf0
[   80.444581]  tcp_connect+0x8d2/0xd90
[   80.445165]  ? kvm_clock_get_cycles+0xd/0x10
[   80.445865]  ? ktime_get_with_offset+0x54/0xc0
[   80.446586]  tcp_v4_connect+0x3d5/0x4e0
[   80.447241]  __inet_stream_connect+0x248/0x390
[   80.447936]  ? release_sock+0x43/0x90
[   80.448506]  ? selinux_netlbl_socket_connect+0x31/0x60
[   80.449340]  inet_stream_connect+0x36/0x50
[   80.450009]  __sys_connect+0x9f/0xd0
[   80.450547]  ? do_fcntl+0x478/0x5a0
[   80.451088]  __x64_sys_connect+0x16/0x20
[   80.451697]  do_syscall_64+0x3e/0x70
[   80.452283]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   80.453096] RIP: 0033:0x7efc4a751741
[   80.453643] Code: Bad RIP value.
[   80.454172] RSP: 002b:00007ffe16bbe528 EFLAGS: 00000246 ORIG_RAX:
000000000000002a
[   80.455470] RAX: ffffffffffffffda RBX: 00005647e04b2bd0 RCX: 00007efc4a751741
[   80.456774] RDX: 0000000000000010 RSI: 00007ffe16bbe6b0 RDI: 0000000000000003
[   80.458023] RBP: 0000000000000000 R08: 00000000000012e8 R09: 0000000000000050
[   80.459225] R10: 00007ffe16be3000 R11: 0000000000000246 R12: 00007ffe16bbe6a0
[   80.460395] R13: 0000000000000001 R14: 00005647e04b4580 R15: 00005647e04b2e30
[   80.461813] Modules linked in:
[   80.462367] CR2: 0000000000000001
[   80.462921] ---[ end trace c6f65e537b55db40 ]---
[   80.463727] RIP: 0010:___bpf_prog_run+0x15e/0x14a0
[   80.464452] Code: 54 cd 00 e8 44 03 ff ff e9 d8 fe ff ff 0f b6 43
01 48 0f bf 4b 02 48 83 c3 08 89 c2 83 e0 0f c0 ea 04 0f b6 d2 49 8b
54 d5 00 <48> 8b 14 0a 49 89 54 c5 00 e9 ad fe ff ff 0f b6 43 01 48 0f
bf 53
[   80.467484] RSP: 0018:ffffbb20c01a3be0 EFLAGS: 00010202
[   80.468325] RAX: 0000000000000001 RBX: ffffbb20c0149050 RCX: 0000000000000000
[   80.469422] RDX: 0000000000000001 RSI: 0000000000000079 RDI: ffffbb20c01a3c50
[   80.470552] RBP: 0000000000000000 R08: 00000000ab975fd4 R09: 53367dbb15c4d95d
[   80.471738] R10: ffffbb20c01a3d88 R11: 0000000000000000 R12: ffffbb20c01a3ca8
[   80.472900] R13: ffffbb20c01a3c50 R14: ffffbb20c01a3d20 R15: ffff99daed8408c0
[   80.473996] FS:  00007efc4b004740(0000) GS:ffff99daef000000(0000)
knlGS:0000000000000000
[   80.475276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.476170] CR2: 0000000000000001 CR3: 000000002d82e003 CR4: 00000000001606f0
========================================

- Directly run the buggy one.

=======================================
[  118.210452] BUG: kernel NULL pointer dereference, address: 0000000000000001
[  118.211626] #PF: supervisor read access in kernel mode
[  118.212495] #PF: error_code(0x0000) - not-present page
[  118.213363] PGD 0 P4D 0
[  118.213808] Oops: 0000 [#1] SMP PTI
[  118.214432] CPU: 0 PID: 172 Comm: curl Not tainted 5.8.0-rc4+ #74
[  118.215498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[  118.217031] RIP: 0010:___bpf_prog_run+0x15e/0x14a0
[  118.217867] Code: 54 cd 00 e8 44 03 ff ff e9 d8 fe ff ff 0f b6 43
01 48 0f bf 4b 02 48 83 c3 08 89 c2 83 e0 0f c0 ea 04 0f b6 d2 49 8b
54 d5 00 <48> 8b 14 0a 49 89 54 c5 00 e9 ad fe ff ff 0f b6 43 01 48 0f
bf 53
[  118.220928] RSP: 0018:ffffb880c01a3be0 EFLAGS: 00010202
[  118.221702] RAX: 0000000000000001 RBX: ffffb880c0149050 RCX: 0000000000000000
[  118.222856] RDX: 0000000000000001 RSI: 0000000000000079 RDI: ffffb880c01a3c50
[  118.224010] RBP: 0000000000000000 R08: 000000007cc579cd R09: 00000000a4037fc1
[  118.225151] R10: ffffb880c01a3d88 R11: 00000000b6b2286f R12: ffffb880c01a3ca8
[  118.226296] R13: ffffb880c01a3c50 R14: ffffb880c01a3d20 R15: ffff9e9a2d8408c0
[  118.227414] FS:  00007f93c2b8b740(0000) GS:ffff9e9a2f000000(0000)
knlGS:0000000000000000
[  118.228707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  118.229596] CR2: 0000000000000001 CR3: 000000002dff8001 CR4: 00000000001606f0
[  118.230764] Call Trace:
[  118.231163]  __bpf_prog_run64+0x3c/0x60
[  118.231805]  ? chacha_block_generic+0x6c/0xb0
[  118.232541]  __cgroup_bpf_run_filter_sock_ops+0x6f/0xf0
[  118.233386]  tcp_connect+0x8d2/0xd90
[  118.233920]  ? __queue_work+0x134/0x3d0
[  118.234510]  tcp_v4_connect+0x3d5/0x4e0
[  118.235107]  __inet_stream_connect+0x248/0x390
[  118.235862]  ? release_sock+0x43/0x90
[  118.236493]  ? selinux_netlbl_socket_connect+0x31/0x60
[  118.237371]  inet_stream_connect+0x36/0x50
[  118.238085]  __sys_connect+0x9f/0xd0
[  118.238733]  ? do_fcntl+0x478/0x5a0
[  118.239341]  __x64_sys_connect+0x16/0x20
[  118.239997]  do_syscall_64+0x3e/0x70
[  118.240585]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  118.241426] RIP: 0033:0x7f93c22d8741
[  118.242010] Code: Bad RIP value.
[  118.242538] RSP: 002b:00007ffc80d6ef38 EFLAGS: 00000246 ORIG_RAX:
000000000000002a
[  118.243754] RAX: ffffffffffffffda RBX: 00005581ee17abd0 RCX: 00007f93c22d8741
[  118.244904] RDX: 0000000000000010 RSI: 00007ffc80d6f0c0 RDI: 0000000000000003
[  118.246027] RBP: 0000000000000000 R08: 000000000000116a R09: 0000000000000076
[  118.247140] R10: 00007ffc80dd5000 R11: 0000000000000246 R12: 00007ffc80d6f0b0
[  118.248352] R13: 0000000000000001 R14: 00005581ee17c580 R15: 00005581ee17ae30
[  118.249517] Modules linked in:
[  118.250017] CR2: 0000000000000001
[  118.250607] ---[ end trace c619b9d05f4cc470 ]---
[  118.251358] RIP: 0010:___bpf_prog_run+0x15e/0x14a0
[  118.252148] Code: 54 cd 00 e8 44 03 ff ff e9 d8 fe ff ff 0f b6 43
01 48 0f bf 4b 02 48 83 c3 08 89 c2 83 e0 0f c0 ea 04 0f b6 d2 49 8b
54 d5 00 <48> 8b 14 0a 49 89 54 c5 00 e9 ad fe ff ff 0f b6 43 01 48 0f
bf 53
[  118.255186] RSP: 0018:ffffb880c01a3be0 EFLAGS: 00010202
[  118.256036] RAX: 0000000000000001 RBX: ffffb880c0149050 RCX: 0000000000000000
[  118.257299] RDX: 0000000000000001 RSI: 0000000000000079 RDI: ffffb880c01a3c50
[  118.258589] RBP: 0000000000000000 R08: 000000007cc579cd R09: 00000000a4037fc1
[  118.259753] R10: ffffb880c01a3d88 R11: 00000000b6b2286f R12: ffffb880c01a3ca8
[  118.260932] R13: ffffb880c01a3c50 R14: ffffb880c01a3d20 R15: ffff9e9a2d8408c0
[  118.262098] FS:  00007f93c2b8b740(0000) GS:ffff9e9a2f000000(0000)
knlGS:0000000000000000
[  118.263378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  118.264344] CR2: 0000000000000001 CR3: 000000002dff8001 CR4: 00000000001606f0
=====================================

Also, I wasn't able to kill the curl process that produced the crash afterwards.

I'm not sure what I can do more to help. Tell me if you need more
information or if I did something wrong.

Nicolas

[1] https://pastebin.com/J03PskHf
