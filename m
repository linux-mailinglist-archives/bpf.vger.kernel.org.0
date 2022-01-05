Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82C84850B8
	for <lists+bpf@lfdr.de>; Wed,  5 Jan 2022 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiAEKIz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 5 Jan 2022 05:08:55 -0500
Received: from mail.hs-osnabrueck.de ([131.173.88.34]:60955 "EHLO
        msx.hs-osnabrueck.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiAEKIz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 05:08:55 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 05:08:54 EST
Received: from sea-02.fhos.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 35E22B9_1D56CF3B
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 10:03:31 +0000 (GMT)
Received: from msx.hs-osnabrueck.de (Rockenstein.FHOS.DE [192.168.179.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "msx.hs-osnabrueck.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by sea-02.fhos.de (Sophos Email Appliance) with ESMTPS id 94A352A5E42_1D56CF2F
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 10:03:30 +0000 (GMT)
Received: from ROCKENSTEIN.FHOS.DE (192.168.179.25) by Rockenstein.FHOS.DE
 (192.168.179.25) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 5 Jan
 2022 11:03:30 +0100
Received: from ROCKENSTEIN.FHOS.DE ([fe80::d109:b519:b2eb:52b4]) by
 Rockenstein.FHOS.DE ([fe80::d109:b519:b2eb:52b4%12]) with mapi id
 15.00.1497.026; Wed, 5 Jan 2022 11:03:30 +0100
From:   "Buchberger, Dennis" <dennis.buchberger@hs-osnabrueck.de>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Problem loading eBPF program on Kernel 4.18 (best with CO:RE):
 -EINVAL
Thread-Topic: Problem loading eBPF program on Kernel 4.18 (best with CO:RE):
 -EINVAL
Thread-Index: AQHYAhp5eI29nHop60CO4GOJmoPCtg==
Date:   Wed, 5 Jan 2022 10:03:30 +0000
Message-ID: <1641377010132.82356@hs-osnabrueck.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.179.139]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello :)

I am currently having a problem and hope you can help me: My goal is to develop a BPF-program (see below) on a development machine and then deploy it to another machine to run it there using BPF CO:RE.
But the program does not load; bpf_object__load returns -EINVAL.

Development machine:
- Ubuntu 20.04 LTS
- Linux 5.4.0-90-generic x86_64
- Kernel compiled with CONFIG_DEBUG_INFO_BTF=y, so BTF is available under /sys/kernel/btf/vmlinux
- clang version: 10.0.0-4ubuntu1
- llc version: 10.0.0

Target machine:
- Ubuntu 18.10
- Linux 4.18.0-25-generic x86_64
- clang version: 13.0.0
- llc version: 13.0.0

As the target kernel does not support CONFIG_DEBUG_INFO_BTF, I used pahole -J (v1.22) to create vmlinux file with BTF info embedded there.
Basically, I followed this mails: https://lore.kernel.org/bpf/CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com/

Right now, the bpf program is just a uProbe for a simple test app, which writes some output to the tracing pipe. As Kernel 4.18. does not support global data for bpf programs, I had to remove (comment out) the bpf_trace_printk statements.
On the development machine, it works fine. But on the target machine, loading the program fails: libbpf: load bpf program failed: Invalid argument (full libbpf log see below).
When compiling the programs on the target machine without using CO:RE, I get a similar error (invalid argument, -22).
What could be the problem? I don't think the eBPF program uses anything that is available on Kernel 5.4.0 and not available on the system with Kernel 4.18, does it?

Thanks in advance for your help.
Best
Dennis




============ log ============

sudo ./ebpf 
libbpf: loading main.bpf.o
libbpf: elf: section(3) kprobe/, size 272, link 0, flags 6, type=1
libbpf: sec 'kprobe/': found program 'trace_func_entry' at insn offset 0 (0 bytes), code size 34 insns (272 bytes)
libbpf: elf: section(4) .relkprobe/, size 16, link 24, flags 0, type=9
libbpf: elf: section(5) kretprobe/, size 88, link 0, flags 6, type=1
libbpf: sec 'kretprobe/': found program 'trace_func_exit' at insn offset 0 (0 bytes), code size 11 insns (88 bytes)
libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
libbpf: license of main.bpf.o is GPL
libbpf: elf: section(7) maps, size 20, link 0, flags 3, type=1
libbpf: elf: section(16) .BTF, size 1406, link 0, flags 0, type=1
libbpf: elf: section(18) .BTF.ext, size 460, link 0, flags 0, type=1
libbpf: elf: section(24) .symtab, size 2160, link 1, flags 0, type=2
libbpf: looking for externs among 90 symbols...
libbpf: collected 0 externs total
libbpf: elf: found 1 legacy map definitions (20 bytes) in main.bpf.o
libbpf: map 'stackdata_map' (legacy): at sec_idx 7, offset 0.
libbpf: map 87 is "stackdata_map"
libbpf: sec '.relkprobe/': collecting relocation for section(3) 'kprobe/'
libbpf: sec '.relkprobe/': relo #0: insn #20 against 'stackdata_map'
libbpf: prog 'trace_func_entry': found map 0 (stackdata_map, sec 7, off 0) for insn #20
>> Loading eBPF program
libbpf: loading kernel BTF '/usr/lib/debug/boot/vmlinux-4.18.0-25-generic': 0
libbpf: map:stackdata_map container_name:____btf_map_stackdata_map cannot be found in BTF. Missing BPF_ANNOTATE_KV_PAIR?
libbpf: map 'stackdata_map': created successfully, fd=4
libbpf: sec 'kprobe/': found 2 CO-RE relocations
libbpf: CO-RE relocating [0] struct pt_regs: found target candidate [201] struct pt_regs in [vmlinux]
libbpf: prog 'trace_func_entry': relo #0: kind <byte_off> (0), spec is [2] struct pt_regs.di (0:14 @ offset 112)
libbpf: prog 'trace_func_entry': relo #0: matching candidate #0 [201] struct pt_regs.di (0:14 @ offset 112)
libbpf: prog 'trace_func_entry': relo #0: patched insn #2 (ALU/ALU64) imm 112 -> 112
libbpf: prog 'trace_func_entry': relo #1: kind <byte_off> (0), spec is [2] struct pt_regs.si (0:13 @ offset 104)
libbpf: prog 'trace_func_entry': relo #1: matching candidate #0 [201] struct pt_regs.si (0:13 @ offset 104)
libbpf: prog 'trace_func_entry': relo #1: patched insn #9 (ALU/ALU64) imm 104 -> 104
libbpf: sec 'kretprobe/': found 1 CO-RE relocations
libbpf: prog 'trace_func_exit': relo #0: kind <byte_off> (0), spec is [2] struct pt_regs.ax (0:10 @ offset 80)
libbpf: prog 'trace_func_exit': relo #0: matching candidate #0 [201] struct pt_regs.ax (0:10 @ offset 80)
libbpf: prog 'trace_func_exit': relo #0: patched insn #2 (ALU/ALU64) imm 80 -> 80
libbpf: load bpf program failed: Invalid argument
libbpf: failed to load program 'trace_func_entry'
libbpf: failed to load object 'main.bpf.o'
bpf_object__load: -22



============  BPF Code: ============

// Compiled with:
	// clang -I /home/[...]/DATA/90_lib/libbpf/build/root/usr/include/ -target bpf -S -D __BPF_TRACING__ -D__TARGET_ARCH_x86 -Wall -O2 -emit-llvm -c -g main.bpf.c
	// llc-11 -march=bpf -filetype=obj -o main.bpf.o main.bpf.ll
// __TARGET_ARCH_x86: For x86_64 machines, too. (see bpf_tracing.h)

#include "../91_bin/vmlinux.h"

#include <bpf/bpf_core_read.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

// #include <uapi/linux/bpf.h>  // Conflicts with vmlinux.h
/* flags for both BPF_FUNC_get_stackid and BPF_FUNC_get_stack. */
#define BPF_F_SKIP_FIELD_MASK		0xffULL     // Missing definitions in vmlinux.h
#define BPF_F_USER_STACK		(1ULL << 8)
/* flags used by BPF_FUNC_get_stackid only. */
#define BPF_F_FAST_STACK_CMP		(1ULL << 9)
#define BPF_F_REUSE_STACKID		(1ULL << 10)
/* flags used by BPF_FUNC_get_stack only. */
#define BPF_F_USER_BUILD_ID		(1ULL << 11)

char _license[] SEC("license") = "GPL";

#define MAX_STACK_RAWTP 100
struct stack_trace_t {
	int pid;
	int kern_stack_size;
	int user_stack_size;
	int user_stack_buildid_size;
	__u64 kern_stack[MAX_STACK_RAWTP];
	__u64 user_stack[MAX_STACK_RAWTP];
	struct bpf_stack_build_id user_stack_buildid[MAX_STACK_RAWTP];
};

struct bpf_map_def SEC("maps") stackdata_map = {
	.type = BPF_MAP_TYPE_PERCPU_ARRAY,
	.key_size = sizeof(__u32),
	.value_size = sizeof(struct stack_trace_t),
	.max_entries = 1,
};

SEC("kprobe/")
int trace_func_entry(struct pt_regs *ctx)
{
    u64 pid_tgid = bpf_get_current_pid_tgid();
    u32 pid = pid_tgid;

    {
        // char fmt[] = "Catched function call; PID = : %d.\n";
        // bpf_trace_printk(fmt, sizeof(fmt), pid, sizeof(pid));
    }

    int arg1;
    int arg2;

    arg1 = BPF_CORE_READ(ctx, di);
    arg2 = PT_REGS_PARM2_CORE(ctx);

    {
        // char fmt[] = "  Arg1 = : %u.\n";
        // bpf_trace_printk(fmt, sizeof(fmt), arg1, sizeof(arg1));
    }
    {
        // char fmt[] = "  Arg2 = : %u.\n";
        // bpf_trace_printk(fmt, sizeof(fmt), arg2, sizeof(arg2));
    }

    __u32 key = 0;
    struct stack_trace_t* data;
    data = bpf_map_lookup_elem(&stackdata_map, &key);
	if (!data)
		return 0;

    size_t max_len = MAX_STACK_RAWTP * sizeof(__u64);

    data->user_stack_size = bpf_get_stack(ctx, data->user_stack, max_len, BPF_F_USER_STACK);

    if(data->user_stack_size <= 0)
        return 0;
    
    {
        // char fmt[] = "  Got stack; len = : %u.\n";
        // bpf_trace_printk(fmt, sizeof(fmt), data->user_stack_size, sizeof(data->user_stack_size));
    }

    if(data->user_stack_size > MAX_STACK_RAWTP)
        return 0; // make verifier happy

    // // for(size_t i = 0; i < data->user_stack_size; ++i)
    // #pragma clang loop unroll(full)
    // for(size_t i = 0; i < 20; ++i)
    // {
    //     if(i < data->user_stack_size)
    //     {
    //         u64 stackEntry = data->user_stack[i];
    //         stackEntry += 1;

    //         char val[22];
    //         toHex(stackEntry, val, false);
    //         char fmt[] = "    : %s.\n";
    //         bpf_trace_printk(fmt, sizeof(fmt), val, sizeof(val));
    //     }
    // }

    return 0;
}


SEC("kretprobe/")
int trace_func_exit(struct pt_regs *ctx)
{
    u64 pid_tgid = bpf_get_current_pid_tgid();
    u32 pid = pid_tgid;
 
    {
        // char fmt[] = "Catched function exit; PID = : %d.\n";
        // bpf_trace_printk(fmt, sizeof(fmt), pid, sizeof(pid));
    }

    int ret;
    //bpf_probe_read_user(&key.c, sizeof(key.c), (void *)PT_REGS_PARM1(ctx));
    // arg1 = ctx->di;     // Automatic CO:RE Relocation and rewriting

    // ret = PT_REGS_RET_CORE(ctx);     // Does NOT work - Result is passed using Register eax
    ret = BPF_CORE_READ(ctx, ax);

    {
        // char fmt[] = "    ret = : %u.\n";
        // bpf_trace_printk(fmt, sizeof(fmt), ret, sizeof(ret));
    }

    return 0;
}



============ Loader code ============

// Compiled with 
	// g++ -I /home/[...]/DATA/90_lib/libbpf/build/root/usr/include/ -L../90_lib/libbpf/build/root/usr/lib64 \
	//	-l:libbpf.a \
	//	-o ebpf main.cc -Wl,--copy-dt-needed-entries /home/[...]/DATA/90_lib/libbpf/build/root/usr/lib64/libbpf.a -B static -lelf

#include <iostream>
#include <thread>
#include <chrono>
#include <unistd.h>
#include <fstream>
#include <dirent.h>

#include <linux/bpf.h>
enum bpf_stats_type {           // Should be defined in linux/bpf.h,. but is not (before Kernel 5.8)
	BPF_STATS_RUN_TIME = 0,         // used in libbpf/build/root/usr/include/bpf/bpf.h
};

#include <bpf/bpf.h>
// #include "../91_bin/vmlinux.h"
#include <bpf/libbpf.h>

#include <linux/ptrace.h>
#include <sys/resource.h>

using namespace std;

void bump_memlock_rlimit(void)
{
	struct rlimit rlim_new = {
		.rlim_cur	= RLIM_INFINITY,
		.rlim_max	= RLIM_INFINITY,
	};

	if (setrlimit(RLIMIT_MEMLOCK, &rlim_new)) {
		fprintf(stderr, "Failed to increase RLIMIT_MEMLOCK limit!\n");
		exit(1);
	}
}


int print_libbpf_log(enum libbpf_print_level lvl, const char *fmt, va_list args)
{
    return vfprintf(stderr, fmt, args);
}


int getProcIdByName(string procName)
{
    int pid = -1;

    // Open the /proc directory
    DIR *dp = opendir("/proc");
    if (dp != NULL)
    {
        // Enumerate all entries in directory until process found
        struct dirent *dirp;
        while (pid < 0 && (dirp = readdir(dp)))
        {
            // Skip non-numeric entries
            int id = atoi(dirp->d_name);
            if (id > 0)
            {
                // Read contents of virtual /proc/{pid}/cmdline file
                string cmdPath = string("/proc/") + dirp->d_name + "/cmdline";
                ifstream cmdFile(cmdPath.c_str());
                string cmdLine;
                getline(cmdFile, cmdLine);
                if (!cmdLine.empty())
                {
                    // Keep first cmdline item which contains the program path
                    size_t pos = cmdLine.find('\0');
                    if (pos != string::npos)
                        cmdLine = cmdLine.substr(0, pos);
                    // Keep program name only, removing the path
                    pos = cmdLine.rfind('/');
                    if (pos != string::npos)
                        cmdLine = cmdLine.substr(pos + 1);
                    // Compare against requested process name
                    if (procName == cmdLine)
                        pid = id;
                }
            }
        }
    }
    closedir(dp);
    return pid;
}



int main (int argc, char ** argv)
{
    bump_memlock_rlimit();
    libbpf_set_print(print_libbpf_log); /* set custom log handler */

    int prog_fd ;

    struct bpf_object_open_opts* openOpts = (struct bpf_object_open_opts*) calloc(1, sizeof(bpf_object_open_opts));
    openOpts->sz = sizeof(openOpts);
    openOpts->btf_custom_path = "./vmlinux";           // Custom BTF path - currently ignored? BTF loaded from /sys/kernel/btf/vmlinux or /usr/lib/debug/boot/vmlinux-4.18.0-25-generic
    struct bpf_object* main_bpf_obj = bpf_object__open_file("main.bpf.o", openOpts);

    if(main_bpf_obj == nullptr
    {
        cout << "Error loading bpf object: nullptr" << endl;
        return -1;
    }

    // bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version);       // For kProbes. Where to get the kernel version as u32?
    cout << ">> Loading eBPF program" << endl;
    int ret = bpf_object__load(main_bpf_obj);
    cout << "bpf_object__load: " << ret << endl;

    struct bpf_program * prog = bpf_object__find_program_by_name(main_bpf_obj, "trace_func_entry");
    struct bpf_program * retProbe = bpf_object__find_program_by_name(main_bpf_obj, "trace_func_exit");

    int pid = getProcIdByName("testApp");
    if(pid == -1)
    {
        cout << "Can not find testApp" << endl;
        return 0;
    }
    else
    {
        cout << "Found testApp with PID " << pid << endl;
    }


    cout << "Setting up Link" << endl;
    DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
    uprobe_opts.retprobe = false;
	struct bpf_link *uprobe_link;
    struct bpf_link *uretprobe_link;

    uprobe_link = bpf_program__attach_uprobe_opts(prog,
						      pid /* pid */,
						      "/home/[...]/DATA/Test_uProbe/testApp",
						      0x1209,		// int testApp::calc(int, int) function entry
						      &uprobe_opts);
    
    cout << "Setting up Link retprobe" << endl;

    uretprobe_link = bpf_program__attach_uprobe(retProbe, true,
                            pid,
                            "/home/[...]/DATA/Test_uProbe/testApp",
                            0x1209);


    cout << "Main loop" << endl;
    while(true)
    {
        this_thread::sleep_for(chrono::milliseconds(1000));
    }

    return 0;
}





============ testApp ============

// Compiled with g++ -o testApp testApp.cc

#include <iostream>
#include <chrono>
#include <thread>
#include <string>

using namespace std;

int calc(int a, int b)
{
    return a + b;
}

int main()
{
    int i = 0;

    while(true)
    {
        cout << calc(i, 1) << endl;
        this_thread::sleep_for(chrono::milliseconds(1000));
        ++i;
    }
    return 0;
}
