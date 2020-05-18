Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F641D7E63
	for <lists+bpf@lfdr.de>; Mon, 18 May 2020 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgERQ0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 May 2020 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgERQ0c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 May 2020 12:26:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A77C061A0C
        for <bpf@vger.kernel.org>; Mon, 18 May 2020 09:26:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 69so3988524otv.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2020 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MYD88ZOp5yuS8ykGn4mDUccZ1GFuDpHoOpb0ThXwQ8I=;
        b=i4XLW+tideJrIioEM9DTZPWuFG/m2wPkixdoxQZtlNUXJbxKPvzUFlB2IKp6naHM33
         i+igikj8AycUICVjiElx0s178Y/D1Oj48kDpA5eiTtZfwAO7B2mcnQG+F6Gnza7Crv6n
         4PMljiVyC4sQKwbPdCqF+GQCmhEgMU6Fn4T5dNGYvPL2ISAGRrwNNHV1wvoYn0Jy8taz
         cFAr7ZQAezQr8wcpBtUua4wdbR9A7FVXuDj1S8dy9VHXY/DOQnMt+zQeBSFc3WoT3aoE
         4sNIoCmzyiS2Fgi0+GmeHfccyHBrkr1elnTDp3MKBTZ9y2rvl3XFocOCWzlm8ZRNL5Aq
         ifEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MYD88ZOp5yuS8ykGn4mDUccZ1GFuDpHoOpb0ThXwQ8I=;
        b=gRJi+e9PbZp3x6xXYfCxz2jZDyoB7BBLP9LyW/HEcrG/yzqAexY1X9qj07ZHuLI6wt
         NSHwUAOPKz5vv9DRISiNMJRBZAGlcCJPtiGtp5K6w7JDeBXd2BGxJFjwvydTID5Prm4q
         lHpCzCcVDCKVkNiTXJcTQlXOkz02vnNsmKVeRM0mqYnd8W1vok4uKqy2dGBrTbEhFi5r
         KmSO7seP//p1ia/PgOpeI8KGwsIefea5cuMt9ONbNJzuVM0JbuGh/C0LFCSqB9MnlOHo
         ngXyJrPT0G8KVyOMEUZ2cV8N8SvTQZP+Hk8niMXG9CRUXO9Pfo46+SVm+SL6eNRIsBL6
         EDLA==
X-Gm-Message-State: AOAM530X/4MJSZh3HLYOZD1bzGbr8FkDk5R5y4NebyJLa6XA7tfwei/u
        kO7JEjhjg92Wzu159h12ObselNel26p909R593ZqEA==
X-Google-Smtp-Source: ABdhPJxky5JHjImbwqS0kRQGV2yPfcq6D1YEhDcn8GeC/rw0Hzi10J//UghDg3BmuaRyVHs6paN0nf2fAQqjM2bXN68=
X-Received: by 2002:a9d:7348:: with SMTP id l8mr6412796otk.44.1589819188482;
 Mon, 18 May 2020 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <uoP8.1589216772739724336.Sdgx@lists.iovisor.org>
 <CAEf4Bzb8uc_L5MRgeNf=6p3TNdPWNnmLV0CYtYx=mXnaZYXR6Q@mail.gmail.com> <CAGgYrAjstp+=eJAwpA4jVQY-9Z-SmySUpim08gEqOv94cfhoUQ@mail.gmail.com>
In-Reply-To: <CAGgYrAjstp+=eJAwpA4jVQY-9Z-SmySUpim08gEqOv94cfhoUQ@mail.gmail.com>
From:   Tristan Mayfield <mayfieldtristan@gmail.com>
Date:   Mon, 18 May 2020 12:26:17 -0400
Message-ID: <CAGgYrAhqXP31DcGLJn+Y_78uq8yv7JL9LdkwQ066QvK5i_iqUQ@mail.gmail.com>
Subject: Fwd: [iovisor-dev] Building BPF programs and kernel persistence
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---------- Forwarded message ---------
From: Tristan Mayfield <mayfieldtristan@gmail.com>
Date: Mon, May 18, 2020 at 12:23 PM
Subject: Re: [iovisor-dev] Building BPF programs and kernel persistence
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: <iovisor-dev@lists.iovisor.org>, <bpf@vger.kernel.org>


Thanks for the reply Andrii.

Managed to get a build working outside of the kernel tree for BPF programs.
The two major things that I learned were that first, the order in
which files are
included in the build command is more important than I previously thought.
The second thing was learning how clang deals with asm differently than gcc=
.
I had to use samples/bpf/asm_goto_workaround.h to fix those errors.
The meat of the makefile is as follows:

CLANGINC :=3D /usr/lib/llvm-10/lib/clang/10.0.0/include
INC_FLAGS :=3D -nostdinc -isystem $(CLANGINC)
EXTRA_FLAGS :=3D -O3 -emit-llvm

linuxhdrs :=3D /usr/src/linux-headers-$(shell uname -r)
LINUXINCLUDE :=3D -include $(linuxhdrs)/include/linux/kconfig.h \
                                -include asm_workaround.h \
                                -I$(linuxhdrs)/arch/x86/include/ \
                                -I$(linuxhdrs)/arch/x86/include/uapi \
                                -I$(linuxhdrs)/arch/x86/include/generated \
                                -I$(linuxhdrs)/arch/x86/include/generated/u=
api \
                                -I$(linuxhdrs)/include \
                                -I$(linuxhdrs)/include/uapi \
                                -I$(linuxhdrs)/include/generated/uapi \

COMPILERFLAGS :=3D -D__KERNEL__ -D__ASM_SYSREG_H \
                                -D__BPF_TRACING__ -D__TARGET_ARCH_$(ARCH) \

# Builds all the targets from corresponding .c files
$(BPFOBJDIR)/%.o:$(BPFSRCDIR)/%.c
        $(CC) $(INC_FLAGS) $(COMPILERFLAGS) \
                $(LINUXINCLUDE) $(LIBBPF_HDRS) \
                $(EXTRA_FLAGS) -c $< -o - | $(LLC) -march=3Dbpf
-filetype obj -o $@

I wanted to include that sample for whatever soul in the future wants
to tread the
same path with similar systems experience levels.
I still get about 100+ warnings when building that are the same as or
similar to:

/usr/src/linux-headers-5.4.0-26-generic/arch/x86/include/asm/atomic.h:194:9=
:
warning: unused variable '__ptr' [-Wunused-variable]
        return arch_cmpxchg(&v->counter, old, new);
                  ^

/usr/src/linux-headers-5.4.0-26-generic/arch/x86/include/asm/msr.h:100:26:
warning: variable 'low' is uninitialized when used here
[-Wuninitialized]
        return EAX_EDX_VAL(val, low, high);
                                                    ^~~

I suspect that these warnings come from my aggressive warning flags during
compilation rather than from actual issues in the kernel.

> Right, pinning map or program doesn't ensure that program is still
> attached to whatever BPF hook you attached to it. As you mentioned,
> XDP, tc, cgroup-bpf programs are persistent. We are actually moving
> towards the model of auto-detachment for those as well. See recent
> activity around bpf_link. The solution with bpf_link to make such
> attachments persistent is through pinning **link** itself, not program
> or map. bpf_link is relatively recent addition, so on older kernels
> you'd have to make sure you still have some process around that would
> keep BPF attachment FD around.


I have been looking at the commits surrounding the pinning of
bpf_link. It looks like it's only
working in kernel 5.7? I did actually go through and attempt to attach
links for kprobes,
tracepoints, and raw_tracepoints in kernel 5.4 but, as you suggested,
it seems unsupported.
I have yet to try on kernel 5.5-5.7 so I'll take a look this week or next.

As I mentioned before, with basic functionality in place here, I'm
interested in working on
some sort of BPF tutorial similar to the XDP tutorial
(https://github.com/xdp-project/xdp-tutorial)
with perhaps a more in-depth look at the technology included as well.

I'm still fuzzy on the relationship between bpf(2) and perf(1). Would
it be correct to say that for
tracepoints, kprobes, and uprobes BPF leverages perf "under the hood"
while for XDP and tc,
this is more like classic BPF in that it's implementation doesn't involve p=
erf?
If that's the case then is the bpf_link object the tool to bridge BPF
and perf? I noticed that when
checking for pinned BPF programs with bpftool in kernel 5.4 that
unless a kprobe, tracepoint,
or uprobe is listed in "bpftool perf list", the program doesn't seem
to be running. Is the use of
perf to load BPF programs potentially a way to make them "headless"
instead of pinning the bpf_link objects?

Regardless, I'm excited to have a more reliable build system than I
have in the past. I think I'll start looking more into CO-RE and
libbpf on kernels 5.5-5.7.

Hope everyone is staying healthy out there,
Tristan

On Thu, May 14, 2020 at 5:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 10:06 AM <mayfieldtristan@gmail.com> wrote:
> >
> >
> > Hi all, hope everyone is staying healthy out there.
>
> Hi! For the future, I think cc'ing bpf@vger.kernel.org would be a good
> idea, there are a lot of folks who are probably not watching iovisor
> mailing list, but could help with issues like this.
>
> >
> > I've been working on building BPF programs, and have run into a few iss=
ues that I think might be clang (vs gcc) based.
> > It seems that either clang isn't the most friendly of compilers when it=
 comes to building Linux-native programs, or my lack of experience makes it=
 seem so.
> > I've been trying to build the simple BPF program below:
> >
> >
> > #include "bpf_helpers.h"
> > #include <linux/bpf.h>
> > #include <linux/version.h>
> > #include <linux/types.h>
> > #include <linux/tcp.h>
> > #include <net/sock.h>
> >
> > struct inet_sock_set_state_args {
> >         long long pad;
> > const void * skaddr;
> > int oldstate;
> > int newstate;
> > u16 sport;
> >   u16 dport;
> > u16 family;
> > u8 protocol;
> > u8 saddr[4];
> > u8 daddr[4];
> > u8 saddr_v6[16];
> > u8 daddr_v6[16];
> > };
> >
> >
> > SEC("tracepoint/sock/inet_sock_set_state")
> > int bpf_prog(struct inet_sock_set_state_args *args) {
> >
> >   struct sock *sk =3D (struct sock *)args->skaddr;
> >   short lport =3D args->sport;
> >
> >   char msg[] =3D "lport: %d\n";
> >   bpf_trace_printk(msg, sizeof(msg), lport);
> >
> >   return 0;
> > }
> >
> > char _license[] SEC("license") =3D "GPL";
> >
> >
> >
> > I've been looking through selftests/bpf/, samples/bpf/, and examples on=
 various blogs and articles.
> > From this, I've come up with the following makefile:
> >
> >
> > ## Build tools
> > LLC :=3D llc
> > CC :=3D clang
> > HOSTCC :=3D clang
> > CLANGINC :=3D /usr/lib/llvm-10/lib/clang/10.0.0/include
> >
> > ## Some useful flags
> > INC_FLAGS :=3D -nostdinc -isystem $(CLANGINC)
> > EXTRA_FLAGS :=3D -O3 -emit-llvm
> >
> > ## Includes
> > linuxhdrs :=3D /usr/src/linux-headers-$(shell uname -r)
> > LINUXINCLUDE :=3D -include $(linuxhdrs)/include/linux/kconfig.h \
> > -include /usr/include/linux/bpf.h \
> > -I$(linuxhdrs)/arch/x86/include/ \
> > -I$(linuxhdrs)/arch/x86/include/uapi \
> > -I$(linuxhdrs)/arch/x86/include/generated \
> > -I$(linuxhdrs)/arch/x86/include/generated/uapi \
> > -I$(linuxhdrs)/include \
> > -I$(linuxhdrs)/include/uapi \
> > -I$(linuxhdrs)/include/generated/uapi \
> > LIBBPF :=3D  -I/home/vagrant/libbpf/src/
> > OBJS :=3D tcptest.bpf.o
> >
> > $(OBJS): %.o:%.c
> > $(CC) $(INC_FLAGS) \
> > -target bpf -D__KERNEL__ -D __ASM_SYSREG_H \
> > -D__BPF_TRACING__ -D__TARGET_ARCH_$(ARCH) \
> > -Wno-unused-value -Wno-pointer-sign \
> > -Wno-compare-distinct-pointer-types \
> > -Wno-gnu-variable-sized-type-not-at-end \
> > -Wno-address-of-packed-member \
> > -Wno-tautological-compare \
> > -Wno-unknown-warning-option \
> > -Wall -v \
> > $(LINUXINCLUDE) $(LIBBPF) \
> > $(EXTRA_FLAGS) -c $< -o - | $(LLC) -march=3Dbpf -filetype obj -o $
> >
> >
> > Unfortunately, I keep running into what seems to be asm errors. I've tr=
ied reorganizing the list of include statements, taking out "-target bpf", =
not including some files, including other files, etc etc.
> > This stackoverflow post suggests that it's a kconfig.h error, but I see=
m to be including the file just fine (https://stackoverflow.com/questions/5=
6975861/error-compiling-ebpf-c-code-out-of-kernel-tree/56990939#56990939).
> > I'm not really sure where to go from here with building BPF programs an=
d including files that have the kernel datatypes. Maybe I'm missing somethi=
ng that's obvious that I'm just ignorant of?
>
> I'd start with actually specifying what compilation errors you run
> into. Also check out
> https://github.com/iovisor/bcc/blob/master/libbpf-tools/Makefile to
> see how BPF programs can be compiled properly outside of kernel tree.
> Though that one pretty much assumes vmlinux.h, which simplifies a
> bunch of compilation issues, probably.
>
> >
> >
> >
> > As additional information, and regarding kernel persistence, I am worki=
ng on a monitoring project that uses BPF programs to continuously monitor t=
he system without the bulky dependencies that BCC includes. I'm concurrentl=
y working on a BTF/CO-RE solution but I'm emphasizing a non-CO-RE approach =
at the moment. I can load and run BPF programs but upon termination of my u=
serspace loader the BPF programs themselves also terminate.
> >
> >
> >
> > I would like to have the BPF program persist in the kernel even after t=
he user space loader has completed its execution. I read in various documen=
tation and in a 2015 LWN article that persistent BPF programs can be create=
d by pinning programs and maps to the BPF vfs so as to keep the fds open. I=
 have attempted pinning the entire BPF object, various programs and various=
 maps, and no matter what I've tried the kernel BPF program terminates when=
 the userspace process terminates. Using bpftool I have verified that the B=
PF files are pinned to the location and that BPF programs themselves all wo=
rk. I know that persistent BPF programs are a part of projects like XDP and=
 tc. Is there a way to do this for a generic BPF loader without having to i=
mplement customized kernel functions?  Below I have included a simplified v=
ersion of my code. In which I outline the basic steps I take to load the co=
mpiled bpf programs and attempt to make persistent instances of them.
>
> Right, pinning map or program doesn't ensure that program is still
> attached to whatever BPF hook you attached to it. As you mentioned,
> XDP, tc, cgroup-bpf programs are persistent. We are actually moving
> towards the model of auto-detachment for those as well. See recent
> activity around bpf_link. The solution with bpf_link to make such
> attachments persistent is through pinning **link** itself, not program
> or map. bpf_link is relatively recent addition, so on older kernels
> you'd have to make sure you still have some process around that would
> keep BPF attachment FD around.
>
>
> >
> >
> >
> > #include <stdio.h>
> >
> > #include <stdlib.h>
> >
> > #include <string.h>
> >
> > #include <errno.h>
> >
> > #include <getopt.h>
> >
> > #include <dirent.h>
> >
> > #include <sys/stat.h>
> >
> > #include <unistd.h>
> >
> > #include <assert.h>
> >
> > #include <linux/version.h>
> >
> >
> >
> > #include "libbpf.h"
> >
> > #include "bpf.h"
> >
> > #include "loader_helpers.h"
> >
> >
> >
> > #include <stdbool.h>
> >
> > #include <fcntl.h>
> >
> > #include <poll.h>
> >
> > #include <linux/perf_event.h>
> >
> > #include <assert.h>
> >
> > #include <sys/syscall.h>
> >
> > #include <sys/ioctl.h>
> >
> > #include <sys/mman.h>
> >
> > #include <time.h>
> >
> > #include <signal.h>
> >
> > #include <linux/ptrace.h>
> >
> >
> >
> > int main(int argc, char **argv) {
> >
> >
> >
> >     struct bpf_object *bpf_obj;
> >
> >     struct bpf_program *bpf_prog;
> >
> >     struct bpf_map *map;
> >
> >     char * license =3D "GPL";
> >
> >     __u32 kernelvers =3D LINUX_VERSION_CODE;
> >
> >     struct bpf_link * link;
> >
> >     int err;
> >
> >     int prog_fd;
> >
> >
> >
> >     bpf_obj =3D bpf_object__open("test_file.bpf.o");
> >
> >
> >
> >     bpf_prog =3D bpf_program__next(NULL, bpf_obj);
> >
> >
> >
> >     err =3D bpf_program__set_tracepoint(bpf_prog);
> >
> >     if(err) {
> >
> >         fprintf(stderr, "ERR couldn't setup program type\n");
> >
> >         return -1;
> >
> >     }
> >
> >     err =3D bpf_program__load(bpf_prog, license, kernelvers);
> >
> >     if(err) {
> >
> >         fprintf(stderr, "ERR couldn't setup program phase\n");
> >
> >         return -1;
> >
> >     }
> >
> >     prog_fd =3D bpf_program__fd(bpf_prog);
> >
> >
> >
> >     link =3D bpf_program__attach_tracepoint(bpf_prog, "syscalls", "sys_=
enter_openat");
> >
> >     if(!link) {
> >
> >         fprintf(stderr, "ERROR ATTACHING TRACEPOINT\n");
> >
> >         return -1;
> >
> >     }
> >
> >
> >
> >     assert(bpf_program__is_tracepoint(bpf_prog));
> >
> >
> >
> > pin:
> >
> >     err =3D bpf_program__pin(bpf_prog, "/sys/fs/bpf/tpprogram");
> >
> >     if(err) {
> >
> >         if(err =3D=3D -17) {
> >
> >             printf("Program exists...trying to unpin and retry!\n");
> >
> >             err =3D bpf_program__unpin(bpf_prog, "/sys/fs/bpf/tpprogram=
");
> >
> >             if(!err) {
> >
> >                 goto pin;
> >
> >            }
> >
> >             printf("The pining already exists but it couldn't be remove=
d...\n");
> >
> >             return -1;
> >
> >         }
> >
> >         printf("We couldn't pin...%d\n", err);
> >
> >         return -1;
> >
> >     }
> >
> >
> >
> >     printf("Program pinned and working...\n");
> >
> >
> >
> >     return 0;
> >
> > }
> >
> >
> >
> >
> > Thanks for having a look and I hope these issues can be cleared up. See=
ms like building is the last major hurdle I have to get rolling with better=
 engineering solutions than manually including structs in my files.
> > Hope everyone stays well!
>
>
> Hope above helped. Please cc bpf@vger.kernel.org (and ideally send
> plain-text emails, kernel mailing lists don't accept HTML emails).
>
> >
> > _._,_._,_
> > ________________________________
> > Links:
> >
> > You receive all messages sent to this group.
> >
> > View/Reply Online (#1847) | Reply To Sender | Reply To Group | Mute Thi=
s Topic | New Topic
> >
> > Your Subscription | Contact Group Owner | Unsubscribe [andrii.nakryiko@=
gmail.com]
> >
> > _._,_._,_
