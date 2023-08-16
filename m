Return-Path: <bpf+bounces-7924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5A77E872
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 20:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F46281B72
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5D1772B;
	Wed, 16 Aug 2023 18:15:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737820E7
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:15:43 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AED2698
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 11:15:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40c72caec5cso39941cf.0
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692209739; x=1692814539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5WHncL+NG8/EGnOvIE/3MtfpypgNb51JThBcIlgM4w=;
        b=ET+Vb8tYv7aoDwFhM7rocg5+RUzuxXqNmOQaNF472bvN+K6+JDNWGRdrJFbKhy4K7A
         2NGPB1IizI62yJfSZaPKIpjZNhLdyfaJ3Jt4/xeahmgIuMnacZLMVXEQUunHAhKVOsHz
         26lJqPfQ3oMUxHCAs+zbGMqcLmlThPJGsN+F4JqSZ0J028ueNQQnar24LXG5N8vmqlFN
         /hc8Plx0V2264fTN5N1OYaOxmV4YRc7wbdiUUD6NRYTLo0lv9/M0xDo7MnRM5zVcB3Lo
         gLHYdlAY1I6zMoqbWcxjvAT5DRbqkFpp0hrkTytNJ7AyAmw/TR7OjP1LJNL1bPB9qmlv
         iL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209739; x=1692814539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5WHncL+NG8/EGnOvIE/3MtfpypgNb51JThBcIlgM4w=;
        b=E6fj7wY29wxSYOS9q/cNq6PSxUJPsZ20EODh0T5YdgQjaceN4Ny3gP9BvBWd/RSyY/
         eMH4YH7SRVYz1hSnALTf9nhKQKLx0tEvI8iL0VrXVP0K7cTyP3a13GXCFml5ruxbLGke
         XpKQgsWaw5NLzStD7fbekupA4XvTPWMh8Vv/eGT8z+k7QmqtJmE2bvGbn8ireb0wpJN7
         414ynFxMjpMPcRBmKjoD8fbQcSVULMkV2BhddBtQ8xlm2klk/HOTP8HChnmKOG3Td3Ba
         HAANZNPQRgu8U76nF7g5+vtWJrXMUS2FsdwySR+xB8pk1DS9AMEa7gnk/l79poxF4opX
         IS4g==
X-Gm-Message-State: AOJu0Yz5zvfjCclrf7vfvjGu+D0OZHcwGngoKUTl3u3b/e5PL3HHFNrF
	KvJ2Pi2wtmhigRcjkmM+Sw+l/z/U1/VUCTce5khQdA==
X-Google-Smtp-Source: AGHT+IEVVX01Dl2MYshWhp3P+Wo6tjf41wb26ZeQ9/oeXmQL18Ncb+xA8iegrsfbk+CSW7AhlMd4GQtPY2lkuHcTlC4=
X-Received: by 2002:a05:622a:f:b0:403:affb:3c03 with SMTP id
 x15-20020a05622a000f00b00403affb3c03mr44357qtw.10.1692209739289; Wed, 16 Aug
 2023 11:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810184853.2860737-1-irogers@google.com> <20230810184853.2860737-3-irogers@google.com>
 <ZNuK1TFwdjyezV3I@kernel.org> <CAP-5=fURf+vv3TA4cRx1MiV3DDp=3wo0g5dBYH43DKtPhNZQsQ@mail.gmail.com>
 <ZNzK70eH3ISoL8r0@kernel.org> <ZNzNh9Myua1xjNuL@kernel.org> <ZNz0bmclvZPg5Y/X@kernel.org>
In-Reply-To: <ZNz0bmclvZPg5Y/X@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Aug 2023 11:15:27 -0700
Message-ID: <CAP-5=fXVB25QzS3vj76DkVuQMGD1OrNq2jWB6vfr45N+j072fQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf trace: Migrate BPF augmentation to use a skeleton
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Fangrui Song <maskray@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>, 
	Wang ShaoBo <bobo.shaobowang@huawei.com>, YueHaibing <yuehaibing@huawei.com>, 
	He Kuang <hekuang@huawei.com>, Brendan Gregg <brendan.d.gregg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 9:08=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 16, 2023 at 10:22:15AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Wed, Aug 16, 2023 at 10:11:11AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Just taking notes about things to work on top of what is in
> > > tmp.perf-tools-next, that will move to perf-tools-next soon:
>
> > > We need to make these libbpf error messages appear only in verbose mo=
de,
> > > and probably have a hint about unprivileged BPF, a quick attempt fail=
ed
> > > after several attempts at getting privileges :-\
>
> > > Probably attaching to tracepoints is off limits to !root even with
> > > /proc/sys/kernel/unprivileged_bpf_disabled set to zero.
>
> > yep, the libbpf sys_bpf call to check if it could load a basic BPF
> > bytecode (prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=3D2) succee=
ds,
> > but then, later we manage to create the maps, etc to then stumble on
>
> > bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_PERCPU_ARRAY, key_size=3D4=
, value_size=3D8272, max_entries=3D1, map_flags=3D0, inner_map_fd=3D0, map_=
name=3D"augmented_args_", map_ifindex=3D0, btf_fd=3D0, btf_key_type_id=3D0,=
 btf_value_type_id=3D0, btf_vmlinux_value_type_id=3D0, map_extra=3D0}, 72) =
=3D 7
> > bpf(BPF_BTF_LOAD, {btf=3D"\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0=
\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=3DNULL, btf_size=3D81, btf_log_=
size=3D0, btf_log_level=3D0}, 32) =3D -1 EPERM (Operation not permitted)
>
> > and:
>
> > bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_TRACEPOINT, insn_cnt=3D2,=
 insns=3D0x1758340, license=3D"GPL", log_level=3D0, log_size=3D0, log_buf=
=3DNULL, kern_version=3DKERNEL_VERSION(6, 4, 7), prog_flags=3D0, prog_name=
=3D"syscall_unaugme", prog_ifindex=3D0, expected_attach_type=3DBPF_CGROUP_I=
NET_INGRESS, prog_btf_fd=3D0, func_info_rec_size=3D0, func_info=3DNULL, fun=
c_info_cnt=3D0, line_info_rec_size=3D0, line_info=3DNULL, line_info_cnt=3D0=
, attach_btf_id=3D0, attach_prog_fd=3D0, fd_array=3DNULL}, 144) =3D -1 EPER=
M (Operation not permitted)
>
> > So 'perf trace' should just not try to load the augmented_raw_syscalls
> > BPF skel for !root.
>
> Not really, I insisted and it is (was?) possible to make it work,
> testing on some other machine and after having to change the permissions
> recursively on tracefs (before a remount with mode=3D755 seemed to
> work?).
>
> I managed to make it work for !root, BPF collecting the pointer args for
> openat, access (perf trace looks for syscall signatures and reuses BPF
> progs for the ones matching one of the explicitely provided)
> clock_namosleep, etc.
>
> (re)Reading Documentation/admin-guide/perf-security.rst and getting it
> into the hints system of 'perf trace' may make this process simpler and
> safer, by using a group, etc. But it is possible, great!
>
> I didn't even had to touch /proc/sys/kernel/unprivileged_bpf_disabled,
> just the capabilities for the perf binary (which is a pretty big window,
> but way smaller than touching /proc/sys/kernel/unprivileged_bpf_disabled)=
.
>
> So now we need to get BUILD_BPF_SKEL=3D1 to be the default but just emit =
a
> warning when what is needed isn't available, just like with other
> features, in that case 'perf trace' continues as today, no pointer arg
> contents collection.
>
> Unfortunately it is too late in the process for v6.6 even, so as soon as
> perf-tools-next becomes perf-tools and we reopen it for v6.7 the first
> patch should be this build BPF skels if what is needed is available.

Thanks Arnaldo! I think targeting this for 6.7 makes sense and thanks
for diving around all the permission issues.

Ian

> I'll also check if we can enable BUILD_BPF_SKEL=3D1 in the distro package=
s
> so that we collect some info from them about possible problems.
>
> What I have is now in perf-tools-next, so should get into linux-next and
> hopefully help in testing it, IIRC there are CIs that enable
> BUILD_BPF_SKEL=3D1.
>
> - Arnaldo
>
> [acme@five ~]$ uname -a
> Linux five 6.2.15-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 11 16:51=
:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> [acme@five ~]$ id
> uid=3D1000(acme) gid=3D1000(acme) groups=3D1000(acme),10(wheel) context=
=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> [acme@five ~]$ perf trace sleep 1
>          ? (         ): sleep/980735  ... [continued]: execve())         =
                                  =3D 0
>      0.031 ( 0.002 ms): sleep/980735 brk()                               =
                                  =3D 0x55c621548000
>      0.039 ( 0.001 ms): sleep/980735 arch_prctl(option: 0x3001, arg2: 0x7=
ffeb8a6a460)                      =3D -1 EINVAL (Invalid argument)
>      0.058 ( 0.006 ms): sleep/980735 access(filename: "/etc/ld.so.preload=
", mode: R)                       =3D -1 ENOENT (No such file or directory)
>      0.068 ( 0.005 ms): sleep/980735 openat(dfd: CWD, filename: "/etc/ld.=
so.cache", flags: RDONLY|CLOEXEC) =3D 3
>      0.074 ( 0.002 ms): sleep/980735 newfstatat(dfd: 3, filename: "", sta=
tbuf: 0x7ffeb8a69680, flag: 4096) =3D 0
>      0.077 ( 0.006 ms): sleep/980735 mmap(len: 54771, prot: READ, flags: =
PRIVATE, fd: 3)                   =3D 0x7f6b95ad9000
>      0.084 ( 0.001 ms): sleep/980735 close(fd: 3)                        =
                                  =3D 0
>      0.094 ( 0.006 ms): sleep/980735 openat(dfd: CWD, filename: "/lib64/l=
ibc.so.6", flags: RDONLY|CLOEXEC) =3D 3
>      0.101 ( 0.002 ms): sleep/980735 read(fd: 3, buf: 0x7ffeb8a697e8, cou=
nt: 832)                          =3D 832
>      0.105 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a693e0, =
count: 784, pos: 64)              =3D 784
>      0.107 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a69380, =
count: 80, pos: 848)              =3D 80
>      0.110 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a69330, =
count: 68, pos: 928)              =3D 68
>      0.113 ( 0.002 ms): sleep/980735 newfstatat(dfd: 3, filename: "", sta=
tbuf: 0x7ffeb8a69680, flag: 4096) =3D 0
>      0.115 ( 0.003 ms): sleep/980735 mmap(len: 8192, prot: READ|WRITE, fl=
ags: PRIVATE|ANONYMOUS)           =3D 0x7f6b95ad7000
>      0.122 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a692d0, =
count: 784, pos: 64)              =3D 784
>      0.126 ( 0.006 ms): sleep/980735 mmap(len: 2104720, prot: READ, flags=
: PRIVATE|DENYWRITE, fd: 3)       =3D 0x7f6b95800000
>      0.133 ( 0.013 ms): sleep/980735 mmap(addr: 0x7f6b95828000, len: 1523=
712, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x28000) =
=3D 0x7f6b95828000
>      0.147 ( 0.008 ms): sleep/980735 mmap(addr: 0x7f6b9599c000, len: 3604=
48, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x19c000) =3D 0=
x7f6b9599c000
>      0.156 ( 0.010 ms): sleep/980735 mmap(addr: 0x7f6b959f4000, len: 2457=
6, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1f3000) =
=3D 0x7f6b959f4000
>      0.171 ( 0.005 ms): sleep/980735 mmap(addr: 0x7f6b959fa000, len: 3214=
4, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) =3D 0x7f6b959fa000
>      0.182 ( 0.001 ms): sleep/980735 close(fd: 3)                        =
                                  =3D 0
>      0.193 ( 0.003 ms): sleep/980735 mmap(len: 12288, prot: READ|WRITE, f=
lags: PRIVATE|ANONYMOUS)          =3D 0x7f6b95ad4000
>      0.199 ( 0.001 ms): sleep/980735 arch_prctl(option: SET_FS, arg2: 0x7=
f6b95ad4740)                      =3D 0
>      0.202 ( 0.001 ms): sleep/980735 set_tid_address(tidptr: 0x7f6b95ad4a=
10)                               =3D 980735 (sleep)
>      0.204 ( 0.001 ms): sleep/980735 set_robust_list(head: 0x7f6b95ad4a20=
, len: 24)                        =3D 0
>      0.206 ( 0.001 ms): sleep/980735 rseq(rseq: 0x7f6b95ad50e0, rseq_len:=
 32, sig: 1392848979)             =3D 0
>      0.277 ( 0.010 ms): sleep/980735 mprotect(start: 0x7f6b959f4000, len:=
 16384, prot: READ)               =3D 0
>      0.306 ( 0.007 ms): sleep/980735 mprotect(start: 0x55c61fa4a000, len:=
 4096, prot: READ)                =3D 0
>      0.320 ( 0.010 ms): sleep/980735 mprotect(start: 0x7f6b95b1c000, len:=
 8192, prot: READ)                =3D 0
>      0.340 ( 0.002 ms): sleep/980735 prlimit64(resource: STACK, old_rlim:=
 0x7ffeb8a6a1c0)                  =3D 0
>      0.349 ( 0.009 ms): sleep/980735 munmap(addr: 0x7f6b95ad9000, len: 54=
771)                              =3D 0
>      0.381 ( 0.002 ms): sleep/980735 getrandom(ubuf: 0x7f6b959ff4d8, len:=
 8, flags: NONBLOCK)              =3D 8
>      0.386 ( 0.001 ms): sleep/980735 brk()                               =
                                  =3D 0x55c621548000
>      0.388 ( 0.006 ms): sleep/980735 brk(brk: 0x55c621569000)            =
                                  =3D 0x55c621569000
>      0.403 ( 0.012 ms): sleep/980735 openat(dfd: CWD, filename: "", flags=
: RDONLY|CLOEXEC)                 =3D 3
>      0.417 ( 0.003 ms): sleep/980735 newfstatat(dfd: 3, filename: "", sta=
tbuf: 0x7f6b959f9b80, flag: 4096) =3D 0
>      0.422 ( 0.008 ms): sleep/980735 mmap(len: 224096080, prot: READ, fla=
gs: PRIVATE, fd: 3)               =3D 0x7f6b88200000
>      0.436 ( 0.002 ms): sleep/980735 close(fd: 3)                        =
                                  =3D 0
>      0.480 (1000.041 ms): sleep/980735 clock_nanosleep(rqtp: { .tv_sec: 1=
, .tv_nsec: 0 }, rmtp: 0x7ffeb8a6a450) =3D 0
>   1000.552 ( 0.003 ms): sleep/980735 close(fd: 1)                        =
                                  =3D 0
>   1000.558 ( 0.002 ms): sleep/980735 close(fd: 2)                        =
                                  =3D 0
>   1000.565 (         ): sleep/980735 exit_group()                        =
                                  =3D ?
> [acme@five ~]$ getcap ~/bin/perf
> /var/home/acme/bin/perf cap_perfmon,cap_bpf=3Dep
> [acme@five ~]$ cat /proc/sys/kernel/unprivileged_bpf_disabled
> 2
> [acme@five ~]$ cat /proc/sys/kernel/perf_event_paranoid
> -1
> [acme@five ~]$

