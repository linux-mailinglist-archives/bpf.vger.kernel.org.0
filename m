Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA10D496E15
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 22:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiAVVJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Jan 2022 16:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiAVVJ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Jan 2022 16:09:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C84C06173B;
        Sat, 22 Jan 2022 13:09:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 025DBB80AE6;
        Sat, 22 Jan 2022 21:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63436C004E1;
        Sat, 22 Jan 2022 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642885762;
        bh=txFGDt7T+/NgV1BUt0eUzgszxjHToV44EmD+kDDqnLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4Lr3g9aebzzsU9JlJyQYVbPcaIUA/bDPTaDtksF0R+4pNhGOy8t5P3eY36+de5Mv
         ioor3LmhImFeEvbN6c91PxrNlACfDvs8DvtfLSCXu7yFXwJGElyCNQ6Mc3R1LuxSpO
         Yhk1NnCxy1g0OZs2X0GNJT+H6Svj8Jwllo+BdibdMwljllZr0fjq+op8m/OFAIUox7
         Z+h4ganNB0xMHSgnJyOjRUH8XNxksJzuiJYY+Z1Pkhs82hthSMi0rWiFgKPvfQgW7u
         OLeIRu7MvvApbheX5VL2oNkWWB0Mhy7vEWbr5rb6wkI1ZN2VaTEz2l/Lmd4gnGGS+m
         XeGEKqYxM6E8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03BB540C99; Sat, 22 Jan 2022 18:07:19 -0300 (-03)
Date:   Sat, 22 Jan 2022 18:07:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH bpf-next v4 0/2] perf: stop using deprecated bpf APIs
Message-ID: <YexyB2VvjpCgVJdH@kernel.org>
References: <20220119230636.1752684-1-christylee@fb.com>
 <CAEf4BzbODQmEH+wuFsEPFdtRoZ1Y-vDJKAKkBLsUDBLoQOmrvg@mail.gmail.com>
 <YexirjnVa7KpvrP9@kernel.org>
 <YexrYDEeoAdcqoDE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YexrYDEeoAdcqoDE@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, Jan 22, 2022 at 05:38:56PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jan 22, 2022 at 05:01:50PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jan 20, 2022 at 02:58:29PM -0800, Andrii Nakryiko escreveu:
> > > On Wed, Jan 19, 2022 at 3:09 PM Christy Lee <christylee@fb.com> wrote:
> > > >
> > > > libbpf's bpf_load_program() and bpf__object_next() APIs are deprecated.
> > > > remove perf's usage of these deprecated functions. After this patch
> > > > set, the only remaining libbpf deprecated APIs in perf would be
> > > > bpf_program__set_prep() and bpf_program__nth_fd().
> > > >
> > > 
> > > Arnaldo, do you want to take this through perf tree or should we apply
> > > this to bpf-next? If the latter, can you give your ack as well?
> > > Thanks!
> > 
> > I'd love to be able to test it with the containers, after I push the
> > current batch to Linus.
> 
> I just looked at it, simple enough, applied.

I take that back, it breaks a BPF test case in 'perf test'

[root@quaco ~]# perf test 42
 42: BPF filter                                                      :
 42.1: Basic BPF filtering                                           : Ok
 42.2: BPF pinning                                                   : FAILED!
 42.3: BPF prologue generation                                       : FAILED!
[root@quaco ~]#

And it leaves the test probe in place:

[root@quaco ~]# perf probe -l
  perf_bpf_probe:func  (on do_epoll_wait@fs/eventpoll.c)
[root@quaco ~]#

So I have to remove it manually:

[root@quaco ~]# perf probe -d perf_bpf_probe:func
Removed event: perf_bpf_probe:func
[root@quaco ~]#

Then revert this patch and try again, back working:

[root@quaco ~]# perf test 42
 42: BPF filter                                                      :
 42.1: Basic BPF filtering                                           : Ok
 42.2: BPF pinning                                                   : Ok
 42.3: BPF prologue generation                                       : Ok
[root@quaco ~]#


With the patch, you can get a verbose output, I'll continue this later
if noone fixes it before:

[root@quaco ~]# perf test -v 42
 42: BPF filter                                                      :
 42.1: Basic BPF filtering                                           :
--- start ---
test child forked, pid 1344304
Kernel build dir is set to /lib/modules/5.15.7-200.fc35.x86_64/build
set env: KBUILD_DIR=/lib/modules/5.15.7-200.fc35.x86_64/build
unset env: KBUILD_OPTS
include option is set to -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: NR_CPUS=8
set env: LINUX_VERSION_CODE=0x50f07
set env: CLANG_EXEC=/usr/lib64/ccache/clang
set env: CLANG_OPTIONS=-xc -g
set env: KERNEL_INC_OPTIONS=-nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: PERF_BPF_INC_OPTIONS=-I/home/acme/lib/perf/include/bpf
set env: WORKING_DIR=/lib/modules/5.15.7-200.fc35.x86_64/build
set env: CLANG_SOURCE=-
llvm compiling command template: echo '// SPDX-License-Identifier: GPL-2.0
/*
 * bpf-script-example.c
 * Test basic LLVM building
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC("maps") flip_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

SEC("func=do_epoll_wait")
int bpf_func__SyS_epoll_pwait(void *ctx)
{
	int ind =0;
	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
	int new_flag;
	if (!flag)
		return 0;
	/* flip flag and store back */
	new_flag = !*flag;
	bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	return new_flag;
}
char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE
llvm compiling command : echo '// SPDX-License-Identifier: GPL-2.0
/*
 * bpf-script-example.c
 * Test basic LLVM building
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt=-DLINUX_VERSION_CODE=0x40200 into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC(maps) flip_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

SEC(func=do_epoll_wait)
int bpf_func__SyS_epoll_pwait(void *ctx)
{
	int ind =0;
	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
	int new_flag;
	if (!flag)
		return 0;
	/* flip flag and store back */
	new_flag = !*flag;
	bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	return new_flag;
}
char _license[] SEC(license) = GPL;
int _version SEC(version) = LINUX_VERSION_CODE;
' | /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=8 -DLINUX_VERSION_CODE=0x50f07 -xc -g -I/home/acme/lib/perf/include/bpf -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/5.15.7-200.fc35.x86_64/build -c - -target bpf  -O2 -o - 
libbpf: loading object '[basic_bpf_test]' from buffer
libbpf: elf: section(3) func=do_epoll_wait, size 192, link 0, flags 6, type=1
libbpf: sec 'func=do_epoll_wait': found program 'bpf_func__SyS_epoll_pwait' at insn offset 0 (0 bytes), code size 24 insns (192 bytes)
libbpf: elf: section(4) .relfunc=do_epoll_wait, size 32, link 22, flags 0, type=9
libbpf: elf: section(5) maps, size 16, link 0, flags 3, type=1
libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
libbpf: license of [basic_bpf_test] is GPL
libbpf: elf: section(7) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of [basic_bpf_test] is 50f07
libbpf: elf: section(13) .BTF, size 575, link 0, flags 0, type=1
libbpf: elf: section(15) .BTF.ext, size 256, link 0, flags 0, type=1
libbpf: elf: section(22) .symtab, size 336, link 1, flags 0, type=2
libbpf: looking for externs among 14 symbols...
libbpf: collected 0 externs total
libbpf: elf: found 1 legacy map definitions (16 bytes) in [basic_bpf_test]
libbpf: map 'flip_table' (legacy): at sec_idx 5, offset 0.
libbpf: map 11 is "flip_table"
libbpf: prog 'bpf_func__SyS_epoll_pwait': unrecognized ELF section name 'func=do_epoll_wait'
libbpf: sec '.relfunc=do_epoll_wait': collecting relocation for section(3) 'func=do_epoll_wait'
libbpf: sec '.relfunc=do_epoll_wait': relo #0: insn #4 against 'flip_table'
libbpf: prog 'bpf_func__SyS_epoll_pwait': found map 0 (flip_table, sec 5, off 0) for insn #4
libbpf: sec '.relfunc=do_epoll_wait': relo #1: insn #17 against 'flip_table'
libbpf: prog 'bpf_func__SyS_epoll_pwait': found map 0 (flip_table, sec 5, off 0) for insn #17
bpf: config program 'func=do_epoll_wait'
symbol:do_epoll_wait file:(null) line:0 offset:0 return:0 lazy:(null)
bpf: config 'func=do_epoll_wait' is ok
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
Using /usr/lib/debug/lib/modules/5.15.7-200.fc35.x86_64/vmlinux for symbols
Open Debuginfo file: /usr/lib/debug/.build-id/cb/36dde59d9c2c72bf9dbb845549e6073181579d.debug
Try to find probe point from debuginfo.
Matched function: do_epoll_wait [3917119]
Probe point found: do_epoll_wait+0
Found 1 probe_trace_events.
Opening /sys/kernel/tracing//kprobe_events write=1
Opening /sys/kernel/tracing//README write=0
Writing event: p:perf_bpf_probe/func _text+3829568
libbpf: map:flip_table container_name:____btf_map_flip_table cannot be found in BTF. Missing BPF_ANNOTATE_KV_PAIR?
libbpf: map 'flip_table': created successfully, fd=4
add bpf event perf_bpf_probe:func and attach bpf program 5
adding perf_bpf_probe:func
adding perf_bpf_probe:func to 0x2f5f630
Using CPUID GenuineIntel-6-8E-A
mmap size 1052672B
test child finished with 0
---- end ----
BPF filter subtest 1: Ok
 42.2: BPF pinning                                                   :
--- start ---
test child forked, pid 1344478
Kernel build dir is set to /lib/modules/5.15.7-200.fc35.x86_64/build
set env: KBUILD_DIR=/lib/modules/5.15.7-200.fc35.x86_64/build
unset env: KBUILD_OPTS
include option is set to -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: NR_CPUS=8
set env: LINUX_VERSION_CODE=0x50f07
set env: CLANG_EXEC=/usr/lib64/ccache/clang
set env: CLANG_OPTIONS=-xc -g
set env: KERNEL_INC_OPTIONS=-nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: PERF_BPF_INC_OPTIONS=-I/home/acme/lib/perf/include/bpf
set env: WORKING_DIR=/lib/modules/5.15.7-200.fc35.x86_64/build
set env: CLANG_SOURCE=-
llvm compiling command template: echo '// SPDX-License-Identifier: GPL-2.0
/*
 * bpf-script-example.c
 * Test basic LLVM building
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC("maps") flip_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

SEC("func=do_epoll_wait")
int bpf_func__SyS_epoll_pwait(void *ctx)
{
	int ind =0;
	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
	int new_flag;
	if (!flag)
		return 0;
	/* flip flag and store back */
	new_flag = !*flag;
	bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	return new_flag;
}
char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE
llvm compiling command : echo '// SPDX-License-Identifier: GPL-2.0
/*
 * bpf-script-example.c
 * Test basic LLVM building
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt=-DLINUX_VERSION_CODE=0x40200 into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC(maps) flip_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

SEC(func=do_epoll_wait)
int bpf_func__SyS_epoll_pwait(void *ctx)
{
	int ind =0;
	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
	int new_flag;
	if (!flag)
		return 0;
	/* flip flag and store back */
	new_flag = !*flag;
	bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	return new_flag;
}
char _license[] SEC(license) = GPL;
int _version SEC(version) = LINUX_VERSION_CODE;
' | /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=8 -DLINUX_VERSION_CODE=0x50f07 -xc -g -I/home/acme/lib/perf/include/bpf -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/5.15.7-200.fc35.x86_64/build -c - -target bpf  -O2 -o - 
libbpf: loading object '[bpf_pinning]' from buffer
libbpf: elf: section(3) func=do_epoll_wait, size 192, link 0, flags 6, type=1
libbpf: sec 'func=do_epoll_wait': found program 'bpf_func__SyS_epoll_pwait' at insn offset 0 (0 bytes), code size 24 insns (192 bytes)
libbpf: elf: section(4) .relfunc=do_epoll_wait, size 32, link 22, flags 0, type=9
libbpf: elf: section(5) maps, size 16, link 0, flags 3, type=1
libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
libbpf: license of [bpf_pinning] is GPL
libbpf: elf: section(7) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of [bpf_pinning] is 50f07
libbpf: elf: section(13) .BTF, size 575, link 0, flags 0, type=1
libbpf: elf: section(15) .BTF.ext, size 256, link 0, flags 0, type=1
libbpf: elf: section(22) .symtab, size 336, link 1, flags 0, type=2
libbpf: looking for externs among 14 symbols...
libbpf: collected 0 externs total
libbpf: elf: found 1 legacy map definitions (16 bytes) in [bpf_pinning]
libbpf: map 'flip_table' (legacy): at sec_idx 5, offset 0.
libbpf: map 11 is "flip_table"
libbpf: prog 'bpf_func__SyS_epoll_pwait': unrecognized ELF section name 'func=do_epoll_wait'
libbpf: sec '.relfunc=do_epoll_wait': collecting relocation for section(3) 'func=do_epoll_wait'
libbpf: sec '.relfunc=do_epoll_wait': relo #0: insn #4 against 'flip_table'
libbpf: prog 'bpf_func__SyS_epoll_pwait': found map 0 (flip_table, sec 5, off 0) for insn #4
libbpf: sec '.relfunc=do_epoll_wait': relo #1: insn #17 against 'flip_table'
libbpf: prog 'bpf_func__SyS_epoll_pwait': found map 0 (flip_table, sec 5, off 0) for insn #17
bpf: config program 'func=do_epoll_wait'
symbol:do_epoll_wait file:(null) line:0 offset:0 return:0 lazy:(null)
bpf: config 'func=do_epoll_wait' is ok
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
Using /usr/lib/debug/lib/modules/5.15.7-200.fc35.x86_64/vmlinux for symbols
Open Debuginfo file: /usr/lib/debug/.build-id/cb/36dde59d9c2c72bf9dbb845549e6073181579d.debug
Try to find probe point from debuginfo.
Matched function: do_epoll_wait [3917119]
Probe point found: do_epoll_wait+0
Found 1 probe_trace_events.
Opening /sys/kernel/tracing//kprobe_events write=1
Parsing probe_events: p:perf_bpf_probe/func _text+3829568
Group:perf_bpf_probe Event:func probe:p
Error: event "func" already exists.
 Hint: Remove existing event by 'perf probe -d'
       or force duplicates by 'perf probe -f'
       or set 'force=yes' in BPF source.
bpf_probe: failed to apply perf probe events
Failed to add events selected by BPF
test child finished with -1
---- end ----
BPF filter subtest 2: FAILED!
 42.3: BPF prologue generation                                       :
--- start ---
test child forked, pid 1344652
Kernel build dir is set to /lib/modules/5.15.7-200.fc35.x86_64/build
set env: KBUILD_DIR=/lib/modules/5.15.7-200.fc35.x86_64/build
unset env: KBUILD_OPTS
include option is set to -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: NR_CPUS=8
set env: LINUX_VERSION_CODE=0x50f07
set env: CLANG_EXEC=/usr/lib64/ccache/clang
set env: CLANG_OPTIONS=-xc -g
set env: KERNEL_INC_OPTIONS=-nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: PERF_BPF_INC_OPTIONS=-I/home/acme/lib/perf/include/bpf
set env: WORKING_DIR=/lib/modules/5.15.7-200.fc35.x86_64/build
set env: CLANG_SOURCE=-
llvm compiling command template: echo '// SPDX-License-Identifier: GPL-2.0
/*
 * bpf-script-test-prologue.c
 * Test BPF prologue
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
#endif
#define SEC(NAME) __attribute__((section(NAME), used))

#include <uapi/linux/fs.h>

/*
 * If CONFIG_PROFILE_ALL_BRANCHES is selected,
 * 'if' is redefined after include kernel header.
 * Recover 'if' for BPF object code.
 */
#ifdef if
# undef if
#endif

#define FMODE_READ		0x1
#define FMODE_WRITE		0x2

static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
	(void *) 6;

SEC("func=null_lseek file->f_mode offset orig")
int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
			 unsigned long offset, unsigned long orig)
{
	fmode_t f_mode = (fmode_t)_f_mode;

	if (err)
		return 0;
	if (f_mode & FMODE_WRITE)
		return 0;
	if (offset & 1)
		return 0;
	if (orig == SEEK_CUR)
		return 0;
	return 1;
}

char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE
llvm compiling command : 
libbpf: loading object '[bpf_prologue_test]' from buffer
libbpf: elf: section(3) func=null_lseek file->f_mode offset orig, size 112, link 0, flags 6, type=1
libbpf: sec 'func=null_lseek file->f_mode offset orig': found program 'bpf_func__null_lseek' at insn offset 0 (0 bytes), code size 14 insns (112 bytes)
libbpf: elf: section(4) license, size 4, link 0, flags 3, type=1
libbpf: license of [bpf_prologue_test] is GPL
libbpf: elf: section(5) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of [bpf_prologue_test] is 50f07
libbpf: elf: section(11) .BTF, size 488, link 0, flags 0, type=1
libbpf: elf: section(13) .BTF.ext, size 144, link 0, flags 0, type=1
libbpf: elf: section(20) .symtab, size 312, link 1, flags 0, type=2
libbpf: looking for externs among 13 symbols...
libbpf: collected 0 externs total
libbpf: prog 'bpf_func__null_lseek': unrecognized ELF section name 'func=null_lseek file->f_mode offset orig'
bpf: config program 'func=null_lseek file->f_mode offset orig'
symbol:null_lseek file:(null) line:0 offset:0 return:0 lazy:(null)
parsing arg: file->f_mode into file, f_mode(1)
parsing arg: offset into offset
parsing arg: orig into orig
bpf: config 'func=null_lseek file->f_mode offset orig' is ok
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
Using /usr/lib/debug/lib/modules/5.15.7-200.fc35.x86_64/vmlinux for symbols
Open Debuginfo file: /usr/lib/debug/.build-id/cb/36dde59d9c2c72bf9dbb845549e6073181579d.debug
Try to find probe point from debuginfo.
Opening /sys/kernel/tracing//README write=0
Matched function: null_lseek [763cb6b]
Probe point found: null_lseek+0
Searching 'file' variable in context.
Converting variable file into trace event.
converting f_mode in file
f_mode type is unsigned int.
Searching 'offset' variable in context.
Converting variable offset into trace event.
offset type is long long int.
Searching 'orig' variable in context.
Converting variable orig into trace event.
orig type is int.
Found 1 probe_trace_events.
Opening /sys/kernel/tracing//kprobe_events write=1
Parsing probe_events: p:perf_bpf_probe/func _text+3829568
Group:perf_bpf_probe Event:func probe:p
Error: event "func" already exists.
 Hint: Remove existing event by 'perf probe -d'
       or force duplicates by 'perf probe -f'
       or set 'force=yes' in BPF source.
bpf_probe: failed to apply perf probe events
Failed to add events selected by BPF
test child finished with -1
---- end ----
BPF filter subtest 3: FAILED!
[root@quaco ~]# 


