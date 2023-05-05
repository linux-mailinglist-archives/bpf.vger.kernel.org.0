Return-Path: <bpf+bounces-130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAB26F8739
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FC2281063
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE0C2FD;
	Fri,  5 May 2023 17:05:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9F5383
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 17:05:01 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DCC150D7
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 10:04:59 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef36d814a5so1124571cf.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683306298; x=1685898298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgoEapUNJvuyfd4DwwXAMo4uOf8CXt5FW3QPdsUK8nE=;
        b=MiaSnrkHiHpcxV1e6B26xqBpyzkwLjb3mcVNIvf3uuw0TOS4RtItdYqybvrILef774
         rh3sIhhSnlmc2QqicdMDUcTsGEDJPJ7oeLTsx6vD2IDjvqkf/RTAqC3KGcz6UUYwuQxl
         dnr0+WtF4iRA98jb5Yi+tFG/yS5mq8MnAkv55NkS1rdBHiRIHdcK9XBung+m7NMzRs3+
         SC/UOeuO5SzozZMAr3YUpmiYHH/KIbVVCnFzj4F6baMJVySL/2ezdErPZDmxx5YQ1xdE
         vFkdkxa3GE3Fqmy6X4th7a7Wjux0K4y+EL2KBI2GHtYR5CdEb409sZtiKk6a8TgixeNZ
         fXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683306298; x=1685898298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgoEapUNJvuyfd4DwwXAMo4uOf8CXt5FW3QPdsUK8nE=;
        b=Oqu+tPqj8Ps6BNzeBLmp50WxWG8O5V5K/zuVHOPITG6xLtH746q0FinrkJHEsE8jqu
         d+b+NWh2Ply7K7aDXVDdeRzzPaKgy23WUwv5yKWEpbZjsx88fNakiXRURXaWgUrY3xCn
         7YGTcheytL9MakKMYQhiV4XbxoA+wCGUeV/m9GNSnUG3xuRRMfKJWG7evVpSLHZouZwM
         PZ7yWm960ok+fpsov6sdVDkHeJyR5w6SNlws6XW3Bl8KUf/wnPLdcca9F/W39Hzp7x39
         0+mIVo0NQKhliUcfVS0uhouit5BGpmfBZzpLEple7Om5qsTMzrY7IyskD+gzTNze2dXm
         2kRg==
X-Gm-Message-State: AC+VfDyEPbptRnzCHgFC1D0qlkZB5Y9ePW4tJH9A5ESaFbC9B/sXPYUS
	TqEI07QJrJpa1/Tk51znXhi/he5yy9R8jbYmKVb6OA==
X-Google-Smtp-Source: ACHHUZ4J6SP+2DGfrcIrQ85qvVGLzRSmvw3R2+RiEI3AOTOkwmXfDvPBog3kDU176Ncc7eIoNdbctGvoJP29nQLVhTs=
X-Received: by 2002:ac8:5a8e:0:b0:3ef:3361:75d5 with SMTP id
 c14-20020ac85a8e000000b003ef336175d5mr280648qtc.11.1683306298062; Fri, 05 May
 2023 10:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org> <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org> <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org> <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava> <ZFUFmxDU/6Z/JEsi@kernel.org> <ZFU1PJrn8YtHIqno@kernel.org>
In-Reply-To: <ZFU1PJrn8YtHIqno@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 May 2023 10:04:47 -0700
Message-ID: <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Roman Lozko <lozko.roma@gmail.com>, Stephane Eranian <eranian@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yang Jihong <yangjihong1@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 9:56=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > That with the preserve_access_index isn't needed, we need just the
> > fields that we access in the tools, right?
>
> I'm now doing build test this in many distro containers, without the two
> reverts, i.e. BPF skels continue as opt-out as in my pull request, to
> test build and also for the functionality tests on the tools using such
> bpf skels, see below, no touching of vmlinux nor BTF data during the
> build.
>
> - Arnaldo
>
> From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 4 May 2023 19:03:51 -0300
> Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated from =
BTF,
>  use subset of used structs + CO-RE
>
> Linus reported a build break due to using a vmlinux without a BTF elf
> section to generate the vmlinux.h header with bpftool for use in the BPF
> tools in tools/perf/util/bpf_skel/*.bpf.c.
>
> Instead add a vmlinux.h file with the structs needed with the fields the
> tools need, marking the structs with __attribute__((preserve_access_index=
)),
> so that libbpf's CO-RE code can fixup the struct field offsets.
>
> In some cases the vmlinux.h file that was being generated by bpftool
> from the kernel BTF information was not needed at all, just including
> linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> types were not being used.
>
> To keep te patch small, include those UAPI headers from the trimmed down
> vmlinux.h file, that then provides the tools with just the structs and
> the subset of its fields needed for them.
>
> Testing it:
>
>   # perf lock contention -b find / > /dev/null
>   ^C contended   total wait     max wait     avg wait         type   call=
er
>
>            7     53.59 us     10.86 us      7.66 us     rwlock:R   start_=
this_handle+0xa0
>            2     30.35 us     21.99 us     15.17 us      rwsem:R   iterat=
e_dir+0x52
>            1      9.04 us      9.04 us      9.04 us     rwlock:W   start_=
this_handle+0x291
>            1      8.73 us      8.73 us      8.73 us     spinlock   raw_sp=
in_rq_lock_nested+0x1e
>   #
>   # perf lock contention -abl find / > /dev/null
>   ^C contended   total wait     max wait     avg wait            address =
  symbol
>
>            1    262.96 ms    262.96 ms    262.96 ms   ffff8e67502d0170   =
 (mutex)
>           12    244.24 us     39.91 us     20.35 us   ffff8e6af56f8070   =
mmap_lock (rwsem)
>            7     30.28 us      6.85 us      4.33 us   ffff8e6c865f1d40   =
rq_lock (spinlock)
>            3      7.42 us      4.03 us      2.47 us   ffff8e6c864b1d40   =
rq_lock (spinlock)
>            2      3.72 us      2.19 us      1.86 us   ffff8e6c86571d40   =
rq_lock (spinlock)
>            1      2.42 us      2.42 us      2.42 us   ffff8e6c86471d40   =
rq_lock (spinlock)
>            4      2.11 us       559 ns       527 ns   ffffffff9a146c80   =
rcu_state (spinlock)
>            3      1.45 us       818 ns       482 ns   ffff8e674ae8384c   =
 (rwlock)
>            1       870 ns       870 ns       870 ns   ffff8e68456ee060   =
 (rwlock)
>            1       663 ns       663 ns       663 ns   ffff8e6c864f1d40   =
rq_lock (spinlock)
>            1       573 ns       573 ns       573 ns   ffff8e6c86531d40   =
rq_lock (spinlock)
>            1       472 ns       472 ns       472 ns   ffff8e6c86431740   =
 (spinlock)
>            1       397 ns       397 ns       397 ns   ffff8e67413a4f04   =
 (spinlock)
>   #
>   # perf test offcpu
>   95: perf record offcpu profiling tests                              : O=
k
>   #
>   # perf kwork latency --use-bpf
>   Starting trace, Hit <Ctrl+C> to stop and report
>   ^C
>     Kwork Name                     | Cpu  | Avg delay     | Count     | M=
ax delay     | Max delay start     | Max delay end       |
>    ----------------------------------------------------------------------=
----------------------------------------------------------
>     (w)flush_memcg_stats_dwork     | 0000 |   1056.212 ms |         2 |  =
 2112.345 ms |     550113.229573 s |     550115.341919 s |
>     (w)toggle_allocation_gate      | 0000 |     10.144 ms |        62 |  =
  416.389 ms |     550113.453518 s |     550113.869907 s |
>     (w)0xffff8e6748e28080          | 0002 |      0.623 ms |         1 |  =
    0.623 ms |     550110.989841 s |     550110.990464 s |
>     (w)vmstat_shepherd             | 0000 |      0.586 ms |        10 |  =
    2.828 ms |     550111.971536 s |     550111.974364 s |
>     (w)vmstat_update               | 0007 |      0.363 ms |         5 |  =
    1.634 ms |     550113.222520 s |     550113.224154 s |
>     (w)vmstat_update               | 0000 |      0.324 ms |        10 |  =
    2.827 ms |     550111.971526 s |     550111.974354 s |
>     (w)0xffff8e674c5f4a58          | 0002 |      0.102 ms |         5 |  =
    0.134 ms |     550110.989839 s |     550110.989972 s |
>     (w)psi_avgs_work               | 0001 |      0.086 ms |         3 |  =
    0.107 ms |     550114.957852 s |     550114.957959 s |
>     (w)psi_avgs_work               | 0000 |      0.079 ms |         5 |  =
    0.100 ms |     550118.605668 s |     550118.605768 s |
>     (w)kfree_rcu_monitor           | 0006 |      0.079 ms |         1 |  =
    0.079 ms |     550110.925821 s |     550110.925900 s |
>     (w)psi_avgs_work               | 0004 |      0.079 ms |         1 |  =
    0.079 ms |     550109.581835 s |     550109.581914 s |
>     (w)psi_avgs_work               | 0001 |      0.078 ms |         1 |  =
    0.078 ms |     550109.197809 s |     550109.197887 s |
>     (w)psi_avgs_work               | 0002 |      0.077 ms |         5 |  =
    0.086 ms |     550110.669819 s |     550110.669905 s |
>   <SNIP>
>   # strace -e bpf -o perf-stat-bpf-counters.output perf stat -e cycles --=
bpf-counters sleep 1
>
>    Performance counter stats for 'sleep 1':
>
>            6,197,983      cycles
>
>          1.003922848 seconds time elapsed
>
>          0.000000000 seconds user
>          0.002032000 seconds sys
>
>   # head -7 perf-stat-bpf-counters.output
>   bpf(BPF_OBJ_GET, {pathname=3D"/sys/fs/bpf/perf_attr_map", bpf_fd=3D0, f=
ile_flags=3D0}, 16) =3D 3
>   bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D3, info_len=3D88, info=3D=
0x7ffcead64990}}, 16) =3D 0
>   bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3D3, key=3D0x24129e0, value=3D0x7ffcea=
d65a48, flags=3DBPF_ANY}, 32) =3D 0
>   bpf(BPF_LINK_GET_FD_BY_ID, {link_id=3D1252}, 12) =3D -1 ENOENT (No such=
 file or directory)
>   bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=
=3D2, insns=3D0x7ffcead65780, license=3D"GPL", log_level=3D0, log_size=3D0,=
 log_buf=3DNULL, kern_version=3DKERNEL_VERSION(0, 0, 0), prog_flags=3D0, pr=
og_name=3D"", prog_ifindex=3D0, expected_attach_type=3DBPF_CGROUP_INET_INGR=
ESS, prog_btf_fd=3D0, func_info_rec_size=3D0, func_info=3DNULL, func_info_c=
nt=3D0, line_info_rec_size=3D0, line_info=3DNULL, line_info_cnt=3D0, attach=
_btf_id=3D0, attach_prog_fd=3D0}, 116) =3D 4
>   bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=
=3D2, insns=3D0x7ffcead65920, license=3D"GPL", log_level=3D0, log_size=3D0,=
 log_buf=3DNULL, kern_version=3DKERNEL_VERSION(0, 0, 0), prog_flags=3D0, pr=
og_name=3D"", prog_ifindex=3D0, expected_attach_type=3DBPF_CGROUP_INET_INGR=
ESS, prog_btf_fd=3D0, func_info_rec_size=3D0, func_info=3DNULL, func_info_c=
nt=3D0, line_info_rec_size=3D0, line_info=3DNULL, line_info_cnt=3D0, attach=
_btf_id=3D0, attach_prog_fd=3D0, fd_array=3DNULL}, 128) =3D 4
>   bpf(BPF_BTF_LOAD, {btf=3D"\237\353\1\0\30\0\0\0\0\0\0\0\20\0\0\0\20\0\0=
\0\5\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=3DNULL, btf_size=3D45, btf_log_=
size=3D0, btf_log_level=3D0}, 28) =3D 4
>   #
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.perf            |  20 +---
>  tools/perf/util/bpf_skel/.gitignore |   1 -
>  tools/perf/util/bpf_skel/vmlinux.h  | 173 ++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+), 20 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/vmlinux.h
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 48aba186ceb50792..61c33d100b2bcc90 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1063,25 +1063,7 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
>         $(Q)CFLAGS=3D $(MAKE) -C ../bpf/bpftool \
>                 OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
>
> -VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                          =
 \
> -                    $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> -                    ../../vmlinux                                      \
> -                    /sys/kernel/btf/vmlinux                            \
> -                    /boot/vmlinux-$(shell uname -r)
> -VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
> -
> -$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> -ifeq ($(VMLINUX_H),)
> -       $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || \
> -       (echo "Failure to generate vmlinux.h needed for the recommended B=
PF skeleton support." && \
> -       echo "To disable this use the build option NO_BPF_SKEL=3D1." && \
> -       echo "Alternatively point at a pre-generated vmlinux.h with VMLIN=
UX_H=3D<path>." && \
> -       false)
> -else
> -       $(Q)cp "$(VMLINUX_H)" $@
> -endif

Perhaps we can define VMLINUX_H in the Makefile.config to be
tools/perf/util/bpf_skel/vmlinux.h, then someone can clear it like:
make -C tools/perf VMLINIX_H=3D
to trigger generation, etc. Such thoughts may be better kept for 6.5 :-)

Thanks,
Ian

> -$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vml=
inux.h | $(SKEL_TMP_OUT)
> +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OU=
T)
>         $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INC=
LUDE) \
>           -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g=
 $@
>
> diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_sk=
el/.gitignore
> index cd01455e1b53c3d9..7a1c832825de8445 100644
> --- a/tools/perf/util/bpf_skel/.gitignore
> +++ b/tools/perf/util/bpf_skel/.gitignore
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  .tmp
>  *.skel.h
> -vmlinux.h
> diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_ske=
l/vmlinux.h
> new file mode 100644
> index 0000000000000000..449b1ea91fc48143
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/vmlinux.h
> @@ -0,0 +1,173 @@
> +#ifndef __VMLINUX_H
> +#define __VMLINUX_H
> +
> +#include <linux/bpf.h>
> +#include <linux/types.h>
> +#include <linux/perf_event.h>
> +#include <stdbool.h>
> +
> +// non-UAPI kernel data structures, used in the .bpf.c BPF tool componen=
t.
> +
> +// Just the fields used in these tools preserving the access index so th=
at
> +// libbpf can fixup offsets with the ones used in the kernel when loadin=
g the
> +// BPF bytecode, if they differ from what is used here.
> +
> +typedef __u8 u8;
> +typedef __u32 u32;
> +typedef __u64 u64;
> +typedef __s64 s64;
> +
> +typedef int pid_t;
> +
> +enum cgroup_subsys_id {
> +       perf_event_cgrp_id  =3D 8,
> +};
> +
> +enum {
> +       HI_SOFTIRQ =3D 0,
> +       TIMER_SOFTIRQ,
> +       NET_TX_SOFTIRQ,
> +       NET_RX_SOFTIRQ,
> +       BLOCK_SOFTIRQ,
> +       IRQ_POLL_SOFTIRQ,
> +       TASKLET_SOFTIRQ,
> +       SCHED_SOFTIRQ,
> +       HRTIMER_SOFTIRQ,
> +       RCU_SOFTIRQ,    /* Preferable RCU should always be the last softi=
rq */
> +
> +       NR_SOFTIRQS
> +};
> +
> +typedef struct {
> +       s64     counter;
> +} __attribute__((preserve_access_index)) atomic64_t;
> +
> +typedef atomic64_t atomic_long_t;
> +
> +struct raw_spinlock {
> +       int rawlock;
> +} __attribute__((preserve_access_index));
> +
> +typedef struct raw_spinlock raw_spinlock_t;
> +
> +typedef struct {
> +       struct raw_spinlock rlock;
> +} __attribute__((preserve_access_index)) spinlock_t;
> +
> +struct sighand_struct {
> +       spinlock_t siglock;
> +} __attribute__((preserve_access_index));
> +
> +struct rw_semaphore {
> +       atomic_long_t owner;
> +} __attribute__((preserve_access_index));
> +
> +struct mutex {
> +       atomic_long_t owner;
> +} __attribute__((preserve_access_index));
> +
> +struct kernfs_node {
> +       u64 id;
> +} __attribute__((preserve_access_index));
> +
> +struct cgroup {
> +       struct kernfs_node *kn;
> +       int                level;
> +}  __attribute__((preserve_access_index));
> +
> +struct cgroup_subsys_state {
> +       struct cgroup *cgroup;
> +} __attribute__((preserve_access_index));
> +
> +struct css_set {
> +       struct cgroup_subsys_state *subsys[13];
> +       struct cgroup *dfl_cgrp;
> +} __attribute__((preserve_access_index));
> +
> +struct mm_struct {
> +       struct rw_semaphore mmap_lock;
> +} __attribute__((preserve_access_index));
> +
> +struct task_struct {
> +       unsigned int          flags;
> +       struct mm_struct      *mm;
> +       pid_t                 pid;
> +       pid_t                 tgid;
> +       char                  comm[16];
> +       struct sighand_struct *sighand;
> +       struct css_set        *cgroups;
> +} __attribute__((preserve_access_index));
> +
> +struct trace_entry {
> +       short unsigned int type;
> +       unsigned char      flags;
> +       unsigned char      preempt_count;
> +       int                pid;
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_irq_handler_entry {
> +       struct trace_entry ent;
> +       int                irq;
> +       u32                __data_loc_name;
> +       char               __data[];
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_irq_handler_exit {
> +       struct trace_entry ent;
> +       int                irq;
> +       int                ret;
> +       char               __data[];
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_softirq {
> +       struct trace_entry ent;
> +       unsigned int       vec;
> +       char               __data[];
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_workqueue_execute_start {
> +       struct trace_entry ent;
> +       void               *work;
> +       void               *function;
> +       char               __data[];
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_workqueue_execute_end {
> +       struct trace_entry ent;
> +       void               *work;
> +       void               *function;
> +       char              __data[];
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_workqueue_activate_work {
> +       struct trace_entry ent;
> +       void               *work;
> +       char               __data[];
> +} __attribute__((preserve_access_index));
> +
> +struct perf_sample_data {
> +       u64                      addr;
> +       u64                      period;
> +       union perf_sample_weight weight;
> +       u64                      txn;
> +       union perf_mem_data_src  data_src;
> +       u64                      ip;
> +       struct {
> +               u32              pid;
> +               u32              tid;
> +       } tid_entry;
> +       u64                      time;
> +       u64                      id;
> +       struct {
> +               u32              cpu;
> +       } cpu_entry;
> +       u64                      phys_addr;
> +       u64                      data_page_size;
> +       u64                      code_page_size;
> +} __attribute__((__aligned__(64))) __attribute__((preserve_access_index)=
);
> +
> +struct bpf_perf_event_data_kern {
> +       struct perf_sample_data *data;
> +       struct perf_event       *event;
> +} __attribute__((preserve_access_index));
> +#endif // __VMLINUX_H
> --
> 2.39.2
>

