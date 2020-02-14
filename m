Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E7415D282
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgBNHFQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 02:05:16 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42919 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbgBNHFP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Feb 2020 02:05:15 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E55A1898;
        Fri, 14 Feb 2020 02:05:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 14 Feb 2020 02:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=J/xK9WSxZn6pwBpZ8Sb94hZCh
        NXIWKamVckS3haCEuw=; b=bleUDWSXiN9zrvP4uBkvK+Fo+g9BmfNq23Wp/u6SN
        Y7L0g4zA+TgQ/YqTZdkgEjR331XEjHY0i2N//O686XKNyDd+JRPSg6M2Lo0u3NhF
        LqPbfbFA1yF44tRXci0wx38U9O/6NVR02booXV66zUxjwkpKkP4rPUnbPbUEdmmR
        wPwiCD66teXAsdczDIcC4tOJgl4a5FmXBs4qUJo0CkzC/BKSoGBTOYGLkx7WKkSK
        gDHD8lziFupCKW8ki7dTC0eJCcM69W6hEYJm8EKS2DrcZfs/ro+j3vUeIQq3PH45
        yI5kxc+lZai/rivqk0iuMgemvsF7oABN4J6gjBNIMy3ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=J/xK9W
        SxZn6pwBpZ8Sb94hZChNXIWKamVckS3haCEuw=; b=Utrfj7xCmi2TNgxLurbBVu
        6WOSpLh/5+wnNtCYPW9UQwgVP5WhxZgDiaQEmvmVOl30Po/2tgJA8OKATUOGBPL3
        PzDT9sDH34Q3gbeI5Njr98dbXq6V2vKPwRCGrq/bcD5FVcw8qQum4nUsOt2Pjd/b
        +BmHJF3vyaijFOF0yPNBs22GX05lU23V2l5HVYg0zfS5O5e5RRmewiBqsReQRJY6
        F9mxwe7fI703q8BQC9IjNhA3OI+ZrZlGCPiOy1NSihgl6I9JBHixE2RXIZLGYtb8
        xYHjB1FGPbnNZBdYK9tTwPIUa0e9kmKOB7PHgFbP7WB0gggT+Rvt/fvHxjzjaGvg
        ==
X-ME-Sender: <xms:pUZGXituUua_qG_zcGvTKXTLG6IrkNsNGrUboMDh4IOW4pFPuqF2Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpefgtggjfffuhffvkfesthhqredttddtjeen
    ucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqeenuc
    fkphepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:pUZGXrubWyDfr8oFgdqgFwy0V3r7WA8GQBM0PWXs2mBZHEOjF4sGSQ>
    <xmx:pUZGXtsF2rWq5LHktbTkriFlms2h5C1SLtIxxtiQf57qwavkSGC2tA>
    <xmx:pUZGXiWxhr0s6ZfFDLlHkka9RPrfuGefbIXQdHI9g36CoPiJjvTYaQ>
    <xmx:qUZGXnQlzAGBOvkvAgdrssiEsPRNYLCQj1FQfVMlu4b0IjV79EXWZSV_9TU>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B6473060BD1;
        Fri, 14 Feb 2020 02:05:05 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Tue Feb 11, 2020 at 11:30 AM
Originalfrom: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Original: =?utf-8?q?On_Mon,_Feb_10,_2020_at_12:09_PM_Daniel_Xu_<dxu@dxuuu.xyz>_wrot?=
 =?utf-8?q?e:=0D=0A>=0D=0A>_Add_a_selftest_to_test:=0D=0A>=0D=0A>_*_defaul?=
 =?utf-8?q?t_bpf=5Fread=5Fbranch=5Frecords()_behavior=0D=0A>_*_BPF=5FF=5FG?=
 =?utf-8?q?ET=5FBRANCH=5FRECORDS=5FSIZE_flag_behavior=0D=0A>_*_error_path_?=
 =?utf-8?q?on_non_branch_record_perf_events=0D=0A>_*_using_helper_to_write?=
 =?utf-8?q?_to_stack=0D=0A>_*_using_helper_to_write_to_map=0D=0A>=0D=0A>_O?=
 =?utf-8?q?n_host_with_hardware_counter_support:=0D=0A>=0D=0A>_____#_./tes?=
 =?utf-8?q?t=5Fprogs_-t_perf=5Fbranches=0D=0A>_____#27/1_perf=5Fbranches?=
 =?utf-8?q?=5Fhw:OK=0D=0A>_____#27/2_perf=5Fbranches=5Fno=5Fhw:OK=0D=0A>__?=
 =?utf-8?q?___#27_perf=5Fbranches:OK=0D=0A>_____Summary:_1/2_PASSED,_0_SKI?=
 =?utf-8?q?PPED,_0_FAILED=0D=0A>=0D=0A>_On_host_without_hardware_counter_s?=
 =?utf-8?q?upport_(VM):=0D=0A>=0D=0A>_____#_./test=5Fprogs_-t_perf=5Fbranc?=
 =?utf-8?q?hes=0D=0A>_____#27/1_perf=5Fbranches=5Fhw:OK=0D=0A>_____#27/2_p?=
 =?utf-8?q?erf=5Fbranches=5Fno=5Fhw:OK=0D=0A>_____#27_perf=5Fbranches:OK?=
 =?utf-8?q?=0D=0A>_____Summary:_1/2_PASSED,_1_SKIPPED,_0_FAILED=0D=0A>=0D?=
 =?utf-8?q?=0A>_Also_sync_tools/include/uapi/linux/bpf.h.=0D=0A>=0D=0A>_Si?=
 =?utf-8?q?gned-off-by:_Daniel_Xu_<dxu@dxuuu.xyz>=0D=0A>_---=0D=0A>__tools?=
 =?utf-8?q?/include/uapi/linux/bpf.h________________|__25_++-=0D=0A>__.../?=
 =?utf-8?q?selftests/bpf/prog=5Ftests/perf=5Fbranches.c__|_182_+++++++++++?=
 =?utf-8?q?+++++++=0D=0A>__.../selftests/bpf/progs/test=5Fperf=5Fbranches.?=
 =?utf-8?q?c__|__74_+++++++=0D=0A>__3_files_changed,_280_insertions(+),_1_?=
 =?utf-8?q?deletion(-)=0D=0A>__create_mode_100644_tools/testing/selftests/?=
 =?utf-8?q?bpf/prog=5Ftests/perf=5Fbranches.c=0D=0A>__create_mode_100644_t?=
 =?utf-8?q?ools/testing/selftests/bpf/progs/test=5Fperf=5Fbranches.c=0D=0A?=
 =?utf-8?q?>=0D=0A=0D=0A[...]=0D=0A=0D=0A>_+_______/*_generate_some_branch?=
 =?utf-8?q?es_on_cpu_0_*/=0D=0A>_+_______CPU=5FZERO(&cpu=5Fset);=0D=0A>_+_?=
 =?utf-8?q?______CPU=5FSET(0,_&cpu=5Fset);=0D=0A>_+_______err_=3D_pthread?=
 =?utf-8?q?=5Fsetaffinity=5Fnp(pthread=5Fself(),_sizeof(cpu=5Fset),_&cpu?=
 =?utf-8?q?=5Fset);=0D=0A>_+_______if_(CHECK(err,_"set=5Faffinity",_"cpu_#?=
 =?utf-8?q?0,_err_%d\n",_err))=0D=0A>_+_______________goto_out=5Ffree=5Fpb?=
 =?utf-8?q?;=0D=0A>_+_______/*_spin_the_loop_for_a_while_(random_high_numb?=
 =?utf-8?q?er)_*/=0D=0A>_+_______for_(i_=3D_0;_i_<_1000000;_++i)=0D=0A>_+_?=
 =?utf-8?q?______________++j;=0D=0A>_+=0D=0A=0D=0Atest=5Fperf=5Fbranches?=
 =?utf-8?q?=5F=5Fdetach_here=3F=0D=0A=0D=0A>_+_______/*_read_perf_buffer_*?=
 =?utf-8?q?/=0D=0A>_+_______err_=3D_perf=5Fbuffer=5F=5Fpoll(pb,_500);=0D?=
 =?utf-8?q?=0A>_+_______if_(CHECK(err_<_0,_"perf=5Fbuffer=5F=5Fpoll",_"err?=
 =?utf-8?q?_%d\n",_err))=0D=0A>_+_______________goto_out=5Ffree=5Fpb;=0D?=
 =?utf-8?q?=0A>_+=0D=0A>_+_______if_(CHECK(!ok,_"ok",_"not_ok\n"))=0D=0A>_?=
 =?utf-8?q?+_______________goto_out=5Ffree=5Fpb;=0D=0A>_+=0D=0A=0D=0A[...]?=
 =?utf-8?q?=0D=0A=0D=0A>_diff_--git_a/tools/testing/selftests/bpf/progs/te?=
 =?utf-8?q?st=5Fperf=5Fbranches.c_b/tools/testing/selftests/bpf/progs/test?=
 =?utf-8?q?=5Fperf=5Fbranches.c=0D=0A>_new_file_mode_100644=0D=0A>_index_0?=
 =?utf-8?q?00000000000..60327d512400=0D=0A>_---_/dev/null=0D=0A>_+++_b/too?=
 =?utf-8?q?ls/testing/selftests/bpf/progs/test=5Fperf=5Fbranches.c=0D=0A>_?=
 =?utf-8?q?@@_-0,0_+1,74_@@=0D=0A>_+//_SPDX-License-Identifier:_GPL-2.0=0D?=
 =?utf-8?q?=0A>_+//_Copyright_(c)_2019_Facebook=0D=0A>_+=0D=0A>_+#include_?=
 =?utf-8?q?<stddef.h>=0D=0A>_+#include_<linux/ptrace.h>=0D=0A>_+#include_<?=
 =?utf-8?q?linux/bpf.h>=0D=0A>_+#include_<bpf/bpf=5Fhelpers.h>=0D=0A>_+#in?=
 =?utf-8?q?clude_"bpf=5Ftrace=5Fhelpers.h"=0D=0A>_+=0D=0A>_+struct_fake=5F?=
 =?utf-8?q?perf=5Fbranch=5Fentry_{=0D=0A>_+_______=5F=5Fu64_=5Fa;=0D=0A>_+?=
 =?utf-8?q?_______=5F=5Fu64_=5Fb;=0D=0A>_+_______=5F=5Fu64_=5Fc;=0D=0A>_+}?=
 =?utf-8?q?;=0D=0A>_+=0D=0A>_+struct_output_{=0D=0A>_+_______int_required?=
 =?utf-8?q?=5Fsize;=0D=0A>_+_______int_written=5Fstack;=0D=0A>_+_______int?=
 =?utf-8?q?_written=5Fmap;=0D=0A>_+};=0D=0A>_+=0D=0A>_+struct_{=0D=0A>_+__?=
 =?utf-8?q?_____=5F=5Fuint(type,_BPF=5FMAP=5FTYPE=5FPERF=5FEVENT=5FARRAY);?=
 =?utf-8?q?=0D=0A>_+_______=5F=5Fuint(key=5Fsize,_sizeof(int));=0D=0A>_+__?=
 =?utf-8?q?_____=5F=5Fuint(value=5Fsize,_sizeof(int));=0D=0A>_+}_perf=5Fbu?=
 =?utf-8?q?f=5Fmap_SEC(".maps");=0D=0A>_+=0D=0A>_+typedef_struct_fake=5Fpe?=
 =?utf-8?q?rf=5Fbranch=5Fentry_fpbe=5Ft[30];=0D=0A>_+=0D=0A>_+struct_{=0D?=
 =?utf-8?q?=0A>_+_______=5F=5Fuint(type,_BPF=5FMAP=5FTYPE=5FARRAY);=0D=0A>?=
 =?utf-8?q?_+_______=5F=5Fuint(max=5Fentries,_1);=0D=0A>_+_______=5F=5Ftyp?=
 =?utf-8?q?e(key,_=5F=5Fu32);=0D=0A>_+_______=5F=5Ftype(value,_fpbe=5Ft);?=
 =?utf-8?q?=0D=0A>_+}_scratch=5Fmap_SEC(".maps");=0D=0A=0D=0ACan_you_pleas?=
 =?utf-8?q?e_use_global_variables_instead_of_array_and=0D=0Aperf=5Fevent?=
 =?utf-8?q?=5Farray=3F_Would_make_BPF_side_clearer_and_userspace_simpler.?=
 =?utf-8?q?=0D=0Astruct_output_member_will_just_become_variables.=0D=0A=0D?=
 =?utf-8?q?=0A[...]=0D=0A?=
In-Reply-To: <CAEf4BzZfGXHL36ntjkQsTTEEa9yzqnS=Xs4XCibejpo5AKGpuQ@mail.gmail.com>
Date:   Thu, 13 Feb 2020 23:05:03 -0800
Cc:     "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>,
        "Peter Ziljstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: [PATCH v7 bpf-next RESEND 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Message-Id: <C0LP269G4WO4.1Q4M8CK4K92SU@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue Feb 11, 2020 at 11:30 AM, Andrii Nakryiko wrote:
> On Mon, Feb 10, 2020 at 12:09 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
[...]

>=20
> > +       /* generate some branches on cpu 0 */
> > +       CPU_ZERO(&cpu_set);
> > +       CPU_SET(0, &cpu_set);
> > +       err =3D pthread_setaffinity_np(pthread_self(), sizeof(cpu_set),=
 &cpu_set);
> > +       if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
> > +               goto out_free_pb;
> > +       /* spin the loop for a while (random high number) */
> > +       for (i =3D 0; i < 1000000; ++i)
> > +               ++j;
> > +
>
>=20
> test_perf_branches__detach here?

Yeah, good idea.

[...]

> > +struct fake_perf_branch_entry {
> > +       __u64 _a;
> > +       __u64 _b;
> > +       __u64 _c;
> > +};
> > +
> > +struct output {
> > +       int required_size;
> > +       int written_stack;
> > +       int written_map;
> > +};
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > +       __uint(key_size, sizeof(int));
> > +       __uint(value_size, sizeof(int));
> > +} perf_buf_map SEC(".maps");
> > +
> > +typedef struct fake_perf_branch_entry fpbe_t[30];
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, 1);
> > +       __type(key, __u32);
> > +       __type(value, fpbe_t);
> > +} scratch_map SEC(".maps");
>
>=20
> Can you please use global variables instead of array

If you mean `scratch_map`, sure.

> and perf_event_array?

Do you mean replace the perf ring buffer with global variables? I think
that would limit the number of samples we validate in userspace to a fixed
number. It might be better to validate as many as the system gives us.

Let me know what you think. I might be overthinking it.

> Would make BPF side clearer and userspace simpler.
> struct output member will just become variables.


Thanks,
Daniel
