Return-Path: <bpf+bounces-46559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAED9EBAC5
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09CD282C27
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B4226876;
	Tue, 10 Dec 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4fiJBzy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0623ED5E;
	Tue, 10 Dec 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862262; cv=none; b=Ssv/BkLp9Q60P7/6igAGMjluhbrAPhW4nj6fOGU6d84JFW+jXw+K8p2j1fB6mgeafrUQF+7MNCiwG2RA1lMwxradd2FRN5n8knrIr43CNCx7Lh7HzTiGc9XkY5r1QheOfWF5YZRig3pBv5bgeNCIJ9NSnbXmgs5GQvPYN3FK0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862262; c=relaxed/simple;
	bh=o26I2z5gAAukUW6hKWMBVmRT2fVVv6sVnp/xEFVe5K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYTrd0WEFogoPDKDZ384q6jkt9X+jnh8l3u6hQW/1WfjgGXcNXH5fr/3JBkrSY470lXAPVtnP4VtbVal2EDPIJUIuyjSq2bAMsvUmJL5LrWXpqbp26dGn17s/GtmKDu7IWhzxUO4tjKCz80+u8CsqtH/ihMgph4dLn+AbVGXw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4fiJBzy; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3990bbe22cso4949899276.1;
        Tue, 10 Dec 2024 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733862260; x=1734467060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frcii1ArNRsZWVzLO8zXblCCjKWawwc3bMGzmLEy0ac=;
        b=c4fiJBzyRAxobrgjL2kKQjdv4n6utRWR0cfSkx+aAH9GL70y60s08Rm7DzxVgxwsOP
         M3bq+0VLeXJyT8Zz/3TATTC5PYTvHv82D5/+Ufa7KGymTE1NdEmD7jTGlFbDJ+qAwRZM
         WTMOQqMMSItkSZb146udNbw/4/pWJoOAoktuBzPi+0RMzn4m8b4EKbZPH8AllIasNfyI
         0QMDAVwZxsn03Qvh+rYsL1iFiabLOGASr159KYypTZP1AmPB82W+jbr9Gsz4ai3cEu+a
         pMSx+6azd+NzHGXJdifuM6jrxmrHTu8mz+6yb8h9K9McJziR672BL8qc/uiyNSiHhBWl
         ULNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862260; x=1734467060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frcii1ArNRsZWVzLO8zXblCCjKWawwc3bMGzmLEy0ac=;
        b=rdUKDPPBVwbn5pycVNUG4u9O3VtMwKfBfT5gS1CVPs9ZIiEDRMlt/pLemmZ+Vulraz
         QbldMIvv6lBB3Ef4RRaUjcLzclJvIsjnE9dvW2sp1NkVYSXmuba434nrDyMItgEHq9LW
         AWg2yE96Bdo2cZelyAbVcbJ1uCb2NRKYFHoR/Q9TeXTHFHrqfweihLdR/WmoU4osFT0y
         QO5kHutCyanOuY4XFCJNM0MSojkrUaYTCYnp3gfYGBht2H/6f4yS0czH18CruzLDSt0L
         0IvUIcsBnq+bjEiS0Ie3DYVoeF6R0QNjaHzZqyEJE7Vp0mLCB0KEzN+kxCOIFmGQNXi9
         BGMg==
X-Forwarded-Encrypted: i=1; AJvYcCWcNoKJGvG9raemQiyYcctEsdZ9m+gdY5VjJlXwzqqqDZ6sBkIgB5OCQDv70IVp+EN6mdc=@vger.kernel.org, AJvYcCXT1GGPSFMeKYmtShhGzXQiYpf77nM3nSSRo+hfa+vmEAS7vEGaWfus2ulI6c34S5kGMPh2mXCQoZlFm3OeKgpjlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzlKVlgCxIWc4F5MwN05hNn8GYdOyAcMJJevzz0NOosnz1X4+
	DF9HVWajq1UDYwLMA359/5FJiQFLwTMOvR//tGs2MgMjSPJPJLL9zXLE7IUKco+/IPig2WKQIVT
	9glHMmHSTskisTRtYguOzN9zQF14=
X-Gm-Gg: ASbGnctw3CbQMr/oCPV7umhl+9zD1OYpli+NLxJAkv55J+B5qmSD76AxV6hlyxLtzz3
	QilkWN0q5HBhmdcvy1dTHKYj4st/Gy3334G1C
X-Google-Smtp-Source: AGHT+IHmAhv/wWDveKoMRmssBcPYUXWPjdLR1da/NCT9FtilFemg7S8dmKzdDZwiI1F+p4py/TyKx5u1jZxqBg8Y5NQ=
X-Received: by 2002:a05:6902:120d:b0:e39:a780:d104 with SMTP id
 3f1490d57ef6-e3c8e614af9mr609400276.24.1733862260033; Tue, 10 Dec 2024
 12:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206001436.1947528-1-namhyung@kernel.org> <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
 <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com>
 <CAATMXfkk4VHyrzwdKfFiRaQbgPN=-EJ5-gf3n2G6Tq=qTNdTRQ@mail.gmail.com>
 <CAH0uvoiG4pXYip9NWGaLK9V5se3_TcVRvoY-Yj46KfO+GTMw4Q@mail.gmail.com>
 <CAH0uvojjyEm0Ezf6sXXvykzjtD9JxijTCNr=8WGGT_r6Fyu_FQ@mail.gmail.com>
 <Z1NdLbOUBzj91Jut@google.com> <Z1iQPicNahILtvQ7@x1>
In-Reply-To: <Z1iQPicNahILtvQ7@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 10 Dec 2024 12:24:09 -0800
Message-ID: <CAH0uvohPFF1YmnysGQa4wyCLOMjFbJ62LOrnOurkhdhRuPzukQ@mail.gmail.com>
Subject: Re: [BUG] perf trace: failed to load -E2BIG
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Qiao Zhao <qzhao@redhat.com>, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Tue, Dec 10, 2024 at 11:02=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Dec 06, 2024 at 12:23:09PM -0800, Namhyung Kim wrote:
> > Cc-ing bpf list.
>
> > On Fri, Dec 06, 2024 at 11:03:19AM -0800, Howard Chu wrote:
> > > Forgot to mention clang-13 gave unbounded memory access too:
>
> > > ffffffff,var_off=3D(0x0; 0xffffffff))
> > > R9=3Dscalar(id=3D14,smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0xffffffff=
,var_off=3D(0x0;
> > > 0xffffffff))
> > > 90: (85) call bpf_probe_read_user#112
> > > R2 unbounded memory access, use 'var &=3D const' or 'if (var < const)=
'
> > > processed 490 insns (limit 1000000) max_states_per_insn 2 total_state=
s
> > > 23 peak_states 23 mark_read 15
> > > -- END PROG LOAD LOG --
> > > libbpf: prog 'sys_enter': failed to load: -13
> > > libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> > > libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
> > > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > > (was it created?)
> > > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > > (was it created?)
> > > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > > (was it created?)
> > > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > > (was it created?)
> > > Not enough memory to run!
>
> > > Kernel:
>
> > > perf $ uname -r
> > > 6.11.0-061100-generic
> > > On Fri, Dec 6, 2024 at 10:36=E2=80=AFAM Howard Chu <howardchu95@gmail=
.com> wrote:
>
> > > > Apologies. I observed the same issue and tested perf with trace BPF
> > > > skel generated by clang-13 to clang-18, turns out BPF skelw generat=
ed
> > > > by clang version <=3D clang-16 are not loadable, with clang-15 and =
-16
> > > > showing the same error as yours. Additionally, the BPF verifier is
> > > > running longer than usual to process the instructions.
>
>
> Some more datapoints, here it is working, below you'll see a 'perf
> trace' session tracing bpf syscalls (that use libbpf btf pretty printing
> routines, that has to be improved) emitted by a 'perf trace' session

Agree, I don't like the constant malloc / free part of the btf_dump.

> augmenting open* syscalls (i.e. using BPF to get the syscall pointer
> args, namely pathnames), and here is the environment:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ rpm -q clang
> clang-18.1.8-1.fc40.x86_64

This is cool, I'm wondering if you have tried to generate the BPF skel
using clang version <=3D 16 because that's where problems occured.

> root@number:~# uname -a
> Linux number 6.13.0-rc2 #1 SMP PREEMPT_DYNAMIC Mon Dec  9 12:33:35 -03 20=
24 x86_64 GNU/Linux
> root@number:~#
>
> root@number:~# perf trace -e bpf --max-events=3D3 perf trace -e open* -a =
sleep 0.0001 |& head
>      0.000 ( 0.005 ms): :3117755/3117755 bpf(cmd: 36, uattr: (union bpf_a=
ttr){.batch =3D (struct){.in_batch =3D (__u64)42949672960,.out_batch =3D (_=
_u64)18446744073709551448,.keys =3D (__u64)2,.values =3D (__u64)801012880,.=
elem_flags =3D (__u64)140154830285504,.flags =3D (__u64)11424,},(struct){.p=
athname =3D (__u64)42949672960,.bpf_fd =3D (__u32)4294967128,.file_flags =
=3D (__u32)4294967295,.path_fd =3D (__s32)2,},.raw_tracepoint =3D (struct){=
.name =3D (__u64)42949672960,.prog_fd =3D (__u32)4294967128,.cookie =3D (__=
u64)2,},(struct){.btf =3D (__u64)42949672960,.btf_log_buf =3D (__u64)184467=
44073709551448,.btf_size =3D (__u32)2,.btf_log_level =3D (__u32)801012880,}=
,}, size: 8) =3D -1 EOPNOTSUPP (Operation not supported)
>      0.009 ( 0.042 ms): :3117755/3117755 bpf(cmd: PROG_LOAD, uattr: (unio=
n bpf_attr){(struct){.map_type =3D (__u32)1,.key_size =3D (__u32)2,.value_s=
ize =3D (__u32)2233669616,.max_entries =3D (__u32)32767,.map_flags =3D (__u=
32)7334203,},(struct){.map_fd =3D (__u32)1,.key =3D (__u64)140735427057648,=
(union){.value =3D (__u64)7334203,.next_key =3D (__u64)7334203,},},.batch =
=3D (struct){.in_batch =3D (__u64)8589934593,.out_batch =3D (__u64)14073542=
7057648,.keys =3D (__u64)7334203,},(struct){.prog_type =3D (__u32)1,.insn_c=
nt =3D (__u32)2,.insns =3D (__u64)140735427057648,.license =3D (__u64)73342=
03,},(struct){.pathname =3D (__u64)8589934593,.bpf_fd =3D (__u32)2233669616=
,.file_flags =3D (__u32)32767,.path_fd =3D (__s32)7334203,},(struct){(union=
){.target_fd =3D (__u32)1,.target_ifindex =3D (__u32)1,},.attach_bpf_fd =3D=
 (__u32)2,.attach_type =3D (__u32)2233669616,.attach_flags =3D (__u32)32767=
,.replace_bpf_fd =3D (__u32)7334203,},.test =3D (struct){.prog_fd =3D (__u3=
2)1,.retval =3D (__u32)2,.data_size_in =3D (__u32)2233669616,.data_size_out=
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
.flags =3D (__u32)2233669616,.buf_len =3D (__u32)32767,.buf =3D (__u64)7334=
203,},.link_create =3D (struct){(union){.prog_fd =3D (__u32)1,.map_fd =3D (=
__u32)1,},(union){.target_fd =3D (__u32)2,.target_ifindex =3D (__u32)2,},.a=
ttach_type =3D (__u32)2233669616,.flags =3D (__u32)32767,(union){.target_bt=
f_id =3D (__u32)7334203,(struct){.iter_info =3D (__u64)7334203) =3D 10
>      0.054 ( 0.010 ms): :3117755/3117755 bpf(cmd: PROG_LOAD, uattr: (unio=
n bpf_attr){(struct){.map_type =3D (__u32)1,.key_size =3D (__u32)2,.value_s=
ize =3D (__u32)2233670144,.max_entries =3D (__u32)32767,.map_flags =3D (__u=
32)7314455,},(struct){.map_fd =3D (__u32)1,.key =3D (__u64)140735427058176,=
(union){.value =3D (__u64)7314455,.next_key =3D (__u64)7314455,},},.batch =
=3D (struct){.in_batch =3D (__u64)8589934593,.out_batch =3D (__u64)14073542=
7058176,.keys =3D (__u64)7314455,},(struct){.prog_type =3D (__u32)1,.insn_c=
nt =3D (__u32)2,.insns =3D (__u64)140735427058176,.license =3D (__u64)73144=
55,},(struct){.pathname =3D (__u64)8589934593,.bpf_fd =3D (__u32)2233670144=
,.file_flags =3D (__u32)32767,.path_fd =3D (__s32)7314455,},(struct){(union=
){.target_fd =3D (__u32)1,.target_ifindex =3D (__u32)1,},.attach_bpf_fd =3D=
 (__u32)2,.attach_type =3D (__u32)2233670144,.attach_flags =3D (__u32)32767=
,.replace_bpf_fd =3D (__u32)7314455,},.test =3D (struct){.prog_fd =3D (__u3=
2)1,.retval =3D (__u32)2,.data_size_in =3D (__u32)2233670144,.data_size_out=
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
.flags =3D (__u32)2233670144,.buf_len =3D (__u32)32767,.buf =3D (__u64)7314=
455,},.link_create =3D (struct){(union){.prog_fd =3D (__u32)1,.map_fd =3D (=
__u32)1,},(union){.target_fd =3D (__u32)2,.target_ifindex =3D (__u32)2,},.a=
ttach_type =3D (__u32)2233670144,.flags =3D (__u32)32767,(union){.target_bt=
f_id =3D (__u32)7314455,(struct){.iter_info =3D (__u64)7314455) =3D 10
>      0.000 ( 0.007 ms): sleep/3117756 openat(dfd: CWD, filename: "/etc/ld=
.so.cache", flags: RDONLY|CLOEXEC) =3D 3
>      0.022 ( 0.004 ms): sleep/3117756 openat(dfd: CWD, filename: "/lib64/=
libc.so.6", flags: RDONLY|CLOEXEC) =3D 3
>      0.201 ( 0.006 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/li=
b/locale/locale-archive", flags: RDONLY|CLOEXEC) =3D 3
>      0.247 ( 0.004 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/sh=
are/locale/locale.alias", flags: RDONLY|CLOEXEC) =3D 3
>      0.283 ( 0.003 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/sh=
are/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo") =3D -1 ENOENT (No such fi=
le or directory)
>      0.287 ( 0.002 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/sh=
are/locale/en_US.utf8/LC_MESSAGES/coreutils.mo") =3D -1 ENOENT (No such fil=
e or directory)
>      0.290 ( 0.003 ms): sleep/3117756 openat(dfd: CWD, filename: "/usr/sh=
are/locale/en_US/LC_MESSAGES/coreutils.mo") =3D -1 ENOENT (No such file or =
directory)
> root@number:~#
>
> root@number:~# perf trace -e connect
>      0.000 ( 0.020 ms): pool/3112 connect(fd: 7, uservaddr: { .family: LO=
CAL, path: /var/run/.heim }, addrlen: 110) =3D 0
>    665.621 ( 0.029 ms): Chrome_ChildIO/3102157 connect(fd: 26, uservaddr:=
 { .family: INET6, port: 443, addr: 2001:4860:4860::900:0, scope_id: 576716=
9 }, addrlen: 28) =3D 0
>   4422.069 ( 0.024 ms): DNS Res~ver #2/19644 connect(fd: 230, uservaddr: =
{ .family: INET, port: 53, addr: 127.0.0.53 }, addrlen: 16) =3D 0
>   4422.354 ( 0.012 ms): systemd-resolv/1213 connect(fd: 14, uservaddr: { =
.family: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) =3D 0
>   4422.225 ( 0.017 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr=
: { .family: LOCAL, path: /run/systemd/r }, addrlen: 42) =3D 0
>   4422.590 ( 0.010 ms): systemd-resolv/1213 connect(fd: 26, uservaddr: { =
.family: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) =3D 0
>   4422.642 ( 0.003 ms): systemd-resolv/1213 connect(fd: 27, uservaddr: { =
.family: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) =3D 0
>   4457.908 ( 0.014 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr=
: { .family: INET6, port: 0, addr: 2800:3f0:4001:837::900:0, scope_id: 5767=
169 }, addrlen: 28) =3D 0
>   4457.924 ( 0.001 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr=
: { .family: UNSPEC }, addrlen: 16)         =3D 0
>   4457.926 ( 0.004 ms): DNS Res~ver #6/3099285 connect(fd: 227, uservaddr=
: { .family: INET, port: 0, addr: 142.251.128.234 }, addrlen: 16) =3D 0
>   5000.793 ( 0.059 ms): pool/3112 connect(fd: 7, uservaddr: { .family: LO=
CAL, path: /var/run/.heim }, addrlen: 110) =3D 0
> ^Croot@number:~#
>
> I'll try with some other systems and report.

Thanks a lot Arnaldo :)

Thanks,
Howard
>
> - Arnaldo

