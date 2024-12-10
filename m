Return-Path: <bpf+bounces-46549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA279EB9C0
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E191A165AB6
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353CA2046B9;
	Tue, 10 Dec 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmiPQaxD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E2194080;
	Tue, 10 Dec 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857348; cv=none; b=HMKeO2nig2En6U1XteeyBMMCmEMau4maBMsA9vRCAFrwlX5xUbeefFGKy5ARlA1VKhWp/qhwRvGE1IXDuImC9NDHDobPYNlVS7yT4JGjfURe7cfuBBEzx8/NotD88UWu3a9FZn2U8c3axVRQY3VE19F+RSmB5Muq62KZEGbeTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857348; c=relaxed/simple;
	bh=UOprArcrHh2FfrqzIm541myIRvLeOJVCB5N7nsptyPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN1iZbSpMRArvx78QCceRaRe6a/u823fdWCDnj5u4NybHbw6cfqTWijNHDZ/JO6mCA4u3EtTbu/D27B/ZaEwOrmKQ1efPw6mAEp+2vcBdkKL6E6A6FDk/yORD5QIO47Eka6RG6SANup5To/UIH9TWk1sQ6/23rWIiTvn4K2qTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmiPQaxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00B2C4CED6;
	Tue, 10 Dec 2024 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733857346;
	bh=UOprArcrHh2FfrqzIm541myIRvLeOJVCB5N7nsptyPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmiPQaxD2L6ddJpHJBBKdVPEN38yS4O5WAgHmsXGWYRFaNUo+biX2Ymgfs0OMoX/z
	 a5vA9T/T5DOxOgB2eCy1LDBQIOJVwe0RM/cyKkjSvlA+3jIGdHeEgUKwR58FtU6huo
	 MM9hbmPJY1pVN6/OvXYuXI+zQoN8TtNiRiXRDq7Tn3RxJp8L3Upfb5Qdw6xOizrjgj
	 usQ6eyqK2uqm6hrLc4K2SNVTPfzS19j7axNPihZ449IEeFwRRREKc9R4LljVThPO4j
	 QUpdwj32ywIC+E77nZvLfhckDdb5sRPMo5nsXPESIfWUtRYkXlmEQB958hxoG5Rfn2
	 0+3EOhHGwiTag==
Date: Tue, 10 Dec 2024 16:02:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Qiao Zhao <qzhao@redhat.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [BUG] perf trace: failed to load -E2BIG
Message-ID: <Z1iQPicNahILtvQ7@x1>
References: <20241206001436.1947528-1-namhyung@kernel.org>
 <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
 <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com>
 <CAATMXfkk4VHyrzwdKfFiRaQbgPN=-EJ5-gf3n2G6Tq=qTNdTRQ@mail.gmail.com>
 <CAH0uvoiG4pXYip9NWGaLK9V5se3_TcVRvoY-Yj46KfO+GTMw4Q@mail.gmail.com>
 <CAH0uvojjyEm0Ezf6sXXvykzjtD9JxijTCNr=8WGGT_r6Fyu_FQ@mail.gmail.com>
 <Z1NdLbOUBzj91Jut@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z1NdLbOUBzj91Jut@google.com>

On Fri, Dec 06, 2024 at 12:23:09PM -0800, Namhyung Kim wrote:
> Cc-ing bpf list.
=20
> On Fri, Dec 06, 2024 at 11:03:19AM -0800, Howard Chu wrote:
> > Forgot to mention clang-13 gave unbounded memory access too:

> > ffffffff,var_off=3D(0x0; 0xffffffff))
> > R9=3Dscalar(id=3D14,smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0xffffffff,v=
ar_off=3D(0x0;
> > 0xffffffff))
> > 90: (85) call bpf_probe_read_user#112
> > R2 unbounded memory access, use 'var &=3D const' or 'if (var < const)'
> > processed 490 insns (limit 1000000) max_states_per_insn 2 total_states
> > 23 peak_states 23 mark_read 15
> > -- END PROG LOAD LOG --
> > libbpf: prog 'sys_enter': failed to load: -13
> > libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> > libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > Not enough memory to run!

> > Kernel:

> > perf $ uname -r
> > 6.11.0-061100-generic
> > On Fri, Dec 6, 2024 at 10:36=E2=80=AFAM Howard Chu <howardchu95@gmail.c=
om> wrote:

> > > Apologies. I observed the same issue and tested perf with trace BPF
> > > skel generated by clang-13 to clang-18, turns out BPF skelw generated
> > > by clang version <=3D clang-16 are not loadable, with clang-15 and -16
> > > showing the same error as yours. Additionally, the BPF verifier is
> > > running longer than usual to process the instructions.


Some more datapoints, here it is working, below you'll see a 'perf
trace' session tracing bpf syscalls (that use libbpf btf pretty printing
routines, that has to be improved) emitted by a 'perf trace' session
augmenting open* syscalls (i.e. using BPF to get the syscall pointer
args, namely pathnames), and here is the environment:

=E2=AC=A2 [acme@toolbox perf-tools-next]$ rpm -q clang
clang-18.1.8-1.fc40.x86_64
root@number:~# uname -a
Linux number 6.13.0-rc2 #1 SMP PREEMPT_DYNAMIC Mon Dec  9 12:33:35 -03 2024=
 x86_64 GNU/Linux
root@number:~#=20

root@number:~# perf trace -e bpf --max-events=3D3 perf trace -e open* -a sl=
eep 0.0001 |& head=20
     0.000 ( 0.005 ms): :3117755/3117755 bpf(cmd: 36, uattr: (union bpf_att=
r){.batch =3D (struct){.in_batch =3D (__u64)42949672960,.out_batch =3D (__u=
64)18446744073709551448,.keys =3D (__u64)2,.values =3D (__u64)801012880,.el=
em_flags =3D (__u64)140154830285504,.flags =3D (__u64)11424,},(struct){.pat=
hname =3D (__u64)42949672960,.bpf_fd =3D (__u32)4294967128,.file_flags =3D =
(__u32)4294967295,.path_fd =3D (__s32)2,},.raw_tracepoint =3D (struct){.nam=
e =3D (__u64)42949672960,.prog_fd =3D (__u32)4294967128,.cookie =3D (__u64)=
2,},(struct){.btf =3D (__u64)42949672960,.btf_log_buf =3D (__u64)1844674407=
3709551448,.btf_size =3D (__u32)2,.btf_log_level =3D (__u32)801012880,},}, =
size: 8) =3D -1 EOPNOTSUPP (Operation not supported)
     0.009 ( 0.042 ms): :3117755/3117755 bpf(cmd: PROG_LOAD, uattr: (union =
bpf_attr){(struct){.map_type =3D (__u32)1,.key_size =3D (__u32)2,.value_siz=
e =3D (__u32)2233669616,.max_entries =3D (__u32)32767,.map_flags =3D (__u32=
)7334203,},(struct){.map_fd =3D (__u32)1,.key =3D (__u64)140735427057648,(u=
nion){.value =3D (__u64)7334203,.next_key =3D (__u64)7334203,},},.batch =3D=
 (struct){.in_batch =3D (__u64)8589934593,.out_batch =3D (__u64)14073542705=
7648,.keys =3D (__u64)7334203,},(struct){.prog_type =3D (__u32)1,.insn_cnt =
=3D (__u32)2,.insns =3D (__u64)140735427057648,.license =3D (__u64)7334203,=
},(struct){.pathname =3D (__u64)8589934593,.bpf_fd =3D (__u32)2233669616,.f=
ile_flags =3D (__u32)32767,.path_fd =3D (__s32)7334203,},(struct){(union){.=
target_fd =3D (__u32)1,.target_ifindex =3D (__u32)1,},.attach_bpf_fd =3D (_=
_u32)2,.attach_type =3D (__u32)2233669616,.attach_flags =3D (__u32)32767,.r=
eplace_bpf_fd =3D (__u32)7334203,},.test =3D (struct){.prog_fd =3D (__u32)1=
,.retval =3D (__u32)2,.data_size_in =3D (__u32)2233669616,.data_size_out =
=3D (__u32)32767,.data_in =3D (__u64)7334203,},(struct){(union){.start_id =
=3D (__u32)1,.prog_id =3D (__u32)1,.map_id =3D (__u32)1,.btf_id =3D (__u32)=
1,.link_id =3D (__u32)1,},.next_id =3D (__u32)2,.open_flags =3D (__u32)2233=
669616,},.info =3D (struct){.bpf_fd =3D (__u32)1,.info_len =3D (__u32)2,.in=
fo =3D (__u64)140735427057648,},.query =3D (struct){(union){.target_fd =3D =
(__u32)1,.target_ifindex =3D (__u32)1,},.attach_type =3D (__u32)2,.query_fl=
ags =3D (__u32)2233669616,.attach_flags =3D (__u32)32767,.prog_ids =3D (__u=
64)7334203,},.raw_tracepoint =3D (struct){.name =3D (__u64)8589934593,.prog=
_fd =3D (__u32)2233669616,.cookie =3D (__u64)7334203,},(struct){.btf =3D (_=
_u64)8589934593,.btf_log_buf =3D (__u64)140735427057648,.btf_size =3D (__u3=
2)7334203,},.task_fd_query =3D (struct){.pid =3D (__u32)1,.fd =3D (__u32)2,=
=2Eflags =3D (__u32)2233669616,.buf_len =3D (__u32)32767,.buf =3D (__u64)73=
34203,},.link_create =3D (struct){(union){.prog_fd =3D (__u32)1,.map_fd =3D=
 (__u32)1,},(union){.target_fd =3D (__u32)2,.target_ifindex =3D (__u32)2,},=
=2Eattach_type =3D (__u32)2233669616,.flags =3D (__u32)32767,(union){.targe=
t_btf_id =3D (__u32)7334203,(struct){.iter_info =3D (__u64)7334203) =3D 10
     0.054 ( 0.010 ms): :3117755/3117755 bpf(cmd: PROG_LOAD, uattr: (union =
bpf_attr){(struct){.map_type =3D (__u32)1,.key_size =3D (__u32)2,.value_siz=
e =3D (__u32)2233670144,.max_entries =3D (__u32)32767,.map_flags =3D (__u32=
)7314455,},(struct){.map_fd =3D (__u32)1,.key =3D (__u64)140735427058176,(u=
nion){.value =3D (__u64)7314455,.next_key =3D (__u64)7314455,},},.batch =3D=
 (struct){.in_batch =3D (__u64)8589934593,.out_batch =3D (__u64)14073542705=
8176,.keys =3D (__u64)7314455,},(struct){.prog_type =3D (__u32)1,.insn_cnt =
=3D (__u32)2,.insns =3D (__u64)140735427058176,.license =3D (__u64)7314455,=
},(struct){.pathname =3D (__u64)8589934593,.bpf_fd =3D (__u32)2233670144,.f=
ile_flags =3D (__u32)32767,.path_fd =3D (__s32)7314455,},(struct){(union){.=
target_fd =3D (__u32)1,.target_ifindex =3D (__u32)1,},.attach_bpf_fd =3D (_=
_u32)2,.attach_type =3D (__u32)2233670144,.attach_flags =3D (__u32)32767,.r=
eplace_bpf_fd =3D (__u32)7314455,},.test =3D (struct){.prog_fd =3D (__u32)1=
,.retval =3D (__u32)2,.data_size_in =3D (__u32)2233670144,.data_size_out =
=3D (__u32)32767,.data_in =3D (__u64)7314455,},(struct){(union){.start_id =
=3D (__u32)1,.prog_id =3D (__u32)1,.map_id =3D (__u32)1,.btf_id =3D (__u32)=
1,.link_id =3D (__u32)1,},.next_id =3D (__u32)2,.open_flags =3D (__u32)2233=
670144,},.info =3D (struct){.bpf_fd =3D (__u32)1,.info_len =3D (__u32)2,.in=
fo =3D (__u64)140735427058176,},.query =3D (struct){(union){.target_fd =3D =
(__u32)1,.target_ifindex =3D (__u32)1,},.attach_type =3D (__u32)2,.query_fl=
ags =3D (__u32)2233670144,.attach_flags =3D (__u32)32767,.prog_ids =3D (__u=
64)7314455,},.raw_tracepoint =3D (struct){.name =3D (__u64)8589934593,.prog=
_fd =3D (__u32)2233670144,.cookie =3D (__u64)7314455,},(struct){.btf =3D (_=
_u64)8589934593,.btf_log_buf =3D (__u64)140735427058176,.btf_size =3D (__u3=
2)7314455,},.task_fd_query =3D (struct){.pid =3D (__u32)1,.fd =3D (__u32)2,=
=2Eflags =3D (__u32)2233670144,.buf_len =3D (__u32)32767,.buf =3D (__u64)73=
14455,},.link_create =3D (struct){(union){.prog_fd =3D (__u32)1,.map_fd =3D=
 (__u32)1,},(union){.target_fd =3D (__u32)2,.target_ifindex =3D (__u32)2,},=
=2Eattach_type =3D (__u32)2233670144,.flags =3D (__u32)32767,(union){.targe=
t_btf_id =3D (__u32)7314455,(struct){.iter_info =3D (__u64)7314455) =3D 10
     0.000 ( 0.007 ms): sleep/3117756 openat(dfd: CWD, filename: "/etc/ld.s=
o.cache", flags: RDONLY|CLOEXEC) =3D 3
     0.022 ( 0.004 ms): sleep/3117756 openat(dfd: CWD, filename: "/lib64/li=
bc.so.6", flags: RDONLY|CLOEXEC) =3D 3
     0.201 ( 0.006 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/lib/=
locale/locale-archive", flags: RDONLY|CLOEXEC) =3D 3
     0.247 ( 0.004 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/shar=
e/locale/locale.alias", flags: RDONLY|CLOEXEC) =3D 3
     0.283 ( 0.003 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/shar=
e/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo") =3D -1 ENOENT (No such file=
 or directory)
     0.287 ( 0.002 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/shar=
e/locale/en_US.utf8/LC_MESSAGES/coreutils.mo") =3D -1 ENOENT (No such file =
or directory)
     0.290 ( 0.003 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/shar=
e/locale/en_US/LC_MESSAGES/coreutils.mo") =3D -1 ENOENT (No such file or di=
rectory)
root@number:~#

root@number:~# perf trace -e connect
     0.000 ( 0.020 ms): pool/3112 connect(fd: 7, uservaddr: { .family: LOCA=
L, path: /var/run/.heim }, addrlen: 110) =3D 0
   665.621 ( 0.029 ms): Chrome_ChildIO/3102157 connect(fd: 26, uservaddr: {=
 .family: INET6, port: 443, addr: 2001:4860:4860::900:0, scope_id: 5767169 =
}, addrlen: 28) =3D 0
  4422.069 ( 0.024 ms): DNS Res~ver #2/19644 connect(fd: 230, uservaddr: { =
=2Efamily: INET, port: 53, addr: 127.0.0.53 }, addrlen: 16) =3D 0
  4422.354 ( 0.012 ms): systemd-resolv/1213 connect(fd: 14, uservaddr: { .f=
amily: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) =3D 0
  4422.225 ( 0.017 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr: =
{ .family: LOCAL, path: /run/systemd/r }, addrlen: 42) =3D 0
  4422.590 ( 0.010 ms): systemd-resolv/1213 connect(fd: 26, uservaddr: { .f=
amily: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) =3D 0
  4422.642 ( 0.003 ms): systemd-resolv/1213 connect(fd: 27, uservaddr: { .f=
amily: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) =3D 0
  4457.908 ( 0.014 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr: =
{ .family: INET6, port: 0, addr: 2800:3f0:4001:837::900:0, scope_id: 576716=
9 }, addrlen: 28) =3D 0
  4457.924 ( 0.001 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr: =
{ .family: UNSPEC }, addrlen: 16)         =3D 0
  4457.926 ( 0.004 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr: =
{ .family: INET, port: 0, addr: 142.251.128.234 }, addrlen: 16) =3D 0
  5000.793 ( 0.059 ms): pool/3112 connect(fd: 7, uservaddr: { .family: LOCA=
L, path: /var/run/.heim }, addrlen: 110) =3D 0
^Croot@number:~#

I'll try with some other systems and report.

- Arnaldo

