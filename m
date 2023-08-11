Return-Path: <bpf+bounces-7602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0F779740
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 20:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04251C21748
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F63219F3;
	Fri, 11 Aug 2023 18:46:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616C8468;
	Fri, 11 Aug 2023 18:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5951C433C7;
	Fri, 11 Aug 2023 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691779607;
	bh=nDDxGEV4teeqKODzITrojrRa6y1Se5dQWQloauuO9uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKzDemCRFW9rclhVY3pUXg56W7JyHbhDaCsz6RR7hKrNW9cV95eaUX+Qi1IPWsb2a
	 q7pmV5xjautFa+Osnq1/rOxNWZywOxn33uAJJIl9RaP+9U6fEAIjHuIqBjJEHcyrjO
	 QxZhJAD6Guxz3USxB6ipTJ8y3HMwSb+ksXexVFVvKo6dxfw3vwG8ane2B/m06BSpgt
	 NjcO0/qtLVGX6cOeYLrdrruJ1gW3N59zRmu+i+c7SJHVVoR7rdoRdXwqyJN8QWm4N4
	 kYskhLbMfgcoRQBSRQ4T0aVYrk55dFqydE2sz3ztG+Nc71ULhrdE2Ax9cgU2EdyiVt
	 2rqkh/d3znUcA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 237A2404DF; Fri, 11 Aug 2023 15:46:44 -0300 (-03)
Date: Fri, 11 Aug 2023 15:46:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
	Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v1 2/4] perf trace: Migrate BPF augmentation to use a
 skeleton
Message-ID: <ZNaCFFGmvlZB3XeE@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230810184853.2860737-3-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Thu, Aug 10, 2023 at 11:48:51AM -0700, Ian Rogers escreveu:
> Previously a BPF event of augmented_raw_syscalls.c could be used to
> enable augmentation of syscalls by perf trace. As BPF events are no
> longer supported, switch to using a BPF skeleton which when attached
> explicitly opens the sysenter and sysexit tracepoints.
>=20
> The dump map is removed as debugging wasn't supported by the
> augmentation and bpf_printk can be used when necessary.
>=20
> Remove tools/perf/examples/bpf/augmented_raw_syscalls.c so that the
> rename/migration to a BPF skeleton captures that this was the source.

So, there is a problem where the augmented_raw_syscalls connect/sendto
handlers are being rejected by the verifier, the way you did it makes it
to print the verifier output and then continue without augmentation,
unsure if this is a good default, opinions?

[root@quaco ~]# perf trace -e open*
libbpf: prog 'sys_enter_connect': BPF program load failed: Permission denied
libbpf: prog 'sys_enter_connect': -- BEGIN PROG LOAD LOG --
reg type unsupported for arg#0 function sys_enter_connect#59
0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
; int sys_enter_connect(struct syscall_enter_args *args)
0: (bf) r6 =3D r1                       ; R1=3Dctx(off=3D0,imm=3D0) R6_w=3D=
ctx(off=3D0,imm=3D0)
1: (b7) r1 =3D 0                        ; R1_w=3D0
; int key =3D 0;
2: (63) *(u32 *)(r10 -4) =3D r1         ; R1_w=3D0 R10=3Dfp0 fp-8=3D0000????
3: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
;
4: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
; return bpf_map_lookup_elem(&augmented_args_tmp, &key);
5: (18) r1 =3D 0xffff8de5ae1d4600       ; R1_w=3Dmap_ptr(off=3D0,ks=3D4,vs=
=3D8272,imm=3D0)
7: (85) call bpf_map_lookup_elem#1    ; R0_w=3Dmap_value_or_null(id=3D1,off=
=3D0,ks=3D4,vs=3D8272,imm=3D0)
8: (bf) r7 =3D r0                       ; R0_w=3Dmap_value_or_null(id=3D1,o=
ff=3D0,ks=3D4,vs=3D8272,imm=3D0) R7_w=3Dmap_value_or_null(id=3D1,off=3D0,ks=
=3D4,vs=3D8272,imm=3D0)
9: (b7) r0 =3D 1                        ; R0_w=3D1
; if (augmented_args =3D=3D NULL)
10: (15) if r7 =3D=3D 0x0 goto pc+25      ; R7_w=3Dmap_value(off=3D0,ks=3D4=
,vs=3D8272,imm=3D0)
; unsigned int socklen =3D args->args[2];
11: (79) r1 =3D *(u64 *)(r6 +32)        ; R1_w=3Dscalar() R6_w=3Dctx(off=3D=
0,imm=3D0)
;
12: (bf) r2 =3D r1                      ; R1_w=3Dscalar(id=3D2) R2_w=3Dscal=
ar(id=3D2)
13: (67) r2 <<=3D 32                    ; R2_w=3Dscalar(smax=3D922337203255=
9808512,umax=3D18446744069414584320,var_off=3D(0x0; 0xffffffff00000000),s32=
_min=3D0,s32_max=3D0,u32_max=3D0)
14: (77) r2 >>=3D 32                    ; R2_w=3Dscalar(umax=3D4294967295,v=
ar_off=3D(0x0; 0xffffffff))
15: (b7) r8 =3D 128                     ; R8=3D128
; if (socklen > sizeof(augmented_args->saddr))
16: (25) if r2 > 0x80 goto pc+1       ; R2=3Dscalar(umax=3D128,var_off=3D(0=
x0; 0xff))
17: (bf) r8 =3D r1                      ; R1=3Dscalar(id=3D2) R8_w=3Dscalar=
(id=3D2)
; const void *sockaddr_arg =3D (const void *)args->args[1];
18: (79) r3 =3D *(u64 *)(r6 +24)        ; R3_w=3Dscalar() R6=3Dctx(off=3D0,=
imm=3D0)
; bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
19: (bf) r1 =3D r7                      ; R1_w=3Dmap_value(off=3D0,ks=3D4,v=
s=3D8272,imm=3D0) R7=3Dmap_value(off=3D0,ks=3D4,vs=3D8272,imm=3D0)
20: (07) r1 +=3D 64                     ; R1_w=3Dmap_value(off=3D64,ks=3D4,=
vs=3D8272,imm=3D0)
; bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
21: (bf) r2 =3D r8                      ; R2_w=3Dscalar(id=3D2) R8_w=3Dscal=
ar(id=3D2)
22: (85) call bpf_probe_read#4
R2 min value is negative, either use unsigned or 'var &=3D const'
processed 22 insns (limit 1000000) max_states_per_insn 0 total_states 1 pea=
k_states 1 mark_read 1
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter_connect': failed to load: -13
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
     0.000 systemd-oomd/959 openat(dfd: CWD, filename: 0xc0a2a2bd, flags: R=
DONLY|CLOEXEC) =3D 12
    86.339 thermald/1234 openat(dfd: CWD, filename: 0xac000ba0)  =3D 13
    87.008 thermald/1234 openat(dfd: CWD, filename: 0xac000eb0)  =3D 13
    87.270 thermald/1234 openat(dfd: CWD, filename: 0xac000b70)  =3D 13
    89.657 thermald/1234 openat(dfd: CWD, filename: 0xac000eb0)  =3D 13
^C

If I comment out the connect and sendto it doesn't build anymore,
whereas before it would continue with the other handlers:

  CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_sysca=
lls.bpf.o
  GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/augmented_raw_syscalls.s=
kel.h
  CC      /tmp/build/perf-tools-next/builtin-trace.o
builtin-trace.c: In function =E2=80=98cmd_trace=E2=80=99:
builtin-trace.c:4873:63: error: =E2=80=98struct <anonymous>=E2=80=99 has no=
 member named =E2=80=98sys_enter_connect=E2=80=99; did you mean =E2=80=98sy=
s_enter_openat=E2=80=99?
 4873 |                 bpf_program__set_autoattach(trace.skel->progs.sys_e=
nter_connect,
      |                                                               ^~~~~=
~~~~~~~~~~~~
      |                                                               sys_e=
nter_openat
builtin-trace.c:4875:63: error: =E2=80=98struct <anonymous>=E2=80=99 has no=
 member named =E2=80=98sys_enter_sendto=E2=80=99; did you mean =E2=80=98sys=
_enter_openat=E2=80=99?
 4875 |                 bpf_program__set_autoattach(trace.skel->progs.sys_e=
nter_sendto,
      |                                                               ^~~~~=
~~~~~~~~~~~
      |                                                               sys_e=
nter_openat
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:97:=
 /tmp/build/perf-tools-next/builtin-trace.o] Error 1
make[2]: *** [Makefile.perf:662: /tmp/build/perf-tools-next/perf-in.o] Erro=
r 2
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
[acme@quaco perf-tools-next]$

=1A

I.e. no need for explicitely referring to those, I think in the past it
was just looking if it was there and if so, attaching, I'll try to fix
this.

If I remove the explicit references in builtin-trace.c:

[root@quaco ~]# perf trace -e open* --max-events=3D10
     0.000 thermald/1234 openat(dfd: CWD, filename: "/sys/class/powercap/in=
tel-rapl/intel-rapl:0/intel-rapl:0:2/energy_uj") =3D 13
     0.236 thermald/1234 openat(dfd: CWD, filename: "/sys/class/powercap/in=
tel-rapl/intel-rapl:0/energy_uj") =3D 13
     0.334 thermald/1234 openat(dfd: CWD, filename: "/sys/class/thermal/the=
rmal_zone2/temp") =3D 13
     9.092 systemd-oomd/959 openat(dfd: CWD, filename: "/proc/meminfo", fla=
gs: RDONLY|CLOEXEC) =3D 12
   259.212 systemd-oomd/959 openat(dfd: CWD, filename: "/proc/meminfo", fla=
gs: RDONLY|CLOEXEC) =3D 12
   497.464 gpm/1049 openat(dfd: CWD, filename: "/dev/tty0") =3D 4
   509.044 systemd-oomd/959 openat(dfd: CWD, filename: "/proc/meminfo", fla=
gs: RDONLY|CLOEXEC) =3D 12
   509.559 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user=
=2Eslice/user-1000.slice/user@1000.service/session.slice/memory.pressure", =
flags: RDONLY|CLOEXEC) =3D 12
   509.917 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user=
=2Eslice/user-1000.slice/user@1000.service/session.slice/memory.current", f=
lags: RDONLY|CLOEXEC) =3D 12
   510.111 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user=
=2Eslice/user-1000.slice/user@1000.service/session.slice/memory.min", flags=
: RDONLY|CLOEXEC) =3D 12
[root@quaco ~]#

Cool!

Some inception:

[root@quaco ~]# perf trace -e perf_event_open perf stat -e cycles,instructi=
ons,cache-misses sleep 1
     0.000 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size:=
 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), sample_type: IDENTIFIER, read_f=
ormat: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enab=
le_on_exec: 1, exclude_guest: 1 }, pid: 232297 (perf), cpu: -1, group_fd: -=
1, flags: FD_CLOEXEC) =3D 3
     0.063 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size:=
 136, config: 0x1 (PERF_COUNT_HW_INSTRUCTIONS), sample_type: IDENTIFIER, re=
ad_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, =
enable_on_exec: 1, exclude_guest: 1 }, pid: 232297 (perf), cpu: -1, group_f=
d: -1, flags: FD_CLOEXEC) =3D 4
     0.070 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size:=
 136, config: 0x3 (PERF_COUNT_HW_CACHE_MISSES), sample_type: IDENTIFIER, re=
ad_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, =
enable_on_exec: 1, exclude_guest: 1 }, pid: 232297 (perf), cpu: -1, group_f=
d: -1, flags: FD_CLOEXEC) =3D 5

 Performance counter stats for 'sleep 1':

         2,669,464      cycles
         1,842,319      instructions                     #    0.69  insn pe=
r cycle
            27,716      cache-misses

       1.001948592 seconds time elapsed

       0.000000000 seconds user
       0.001657000 seconds sys


[root@quaco ~]#

I'm putting what I have in the tmp.perf-tools-next branch, will continue
later today.

- Arnaldo

