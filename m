Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B346147707
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 03:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgAXCzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 21:55:47 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42747 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730486AbgAXCzp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 21:55:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id F3ADE6DF;
        Thu, 23 Jan 2020 21:55:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 21:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=8KvXRfgyt/iAa39KQDQu2IPIR
        o+jPaA8e8YdSenhf/c=; b=vBYyoNYSgkcffYCRUVkpCsRtCWVD4kHjiyjWxTHmq
        kvzTdFxbIMO1Sb50ZzSkXLFIG7TOqyVjV2sp5CDoHBbv9YEYixj14RvSNoHNN1PX
        d1I2pNJI50ZNQmxDN2gRPuFPjYarfYvlnECMwANrVXtYmcBfxkuRndxJ9rXxM0Qa
        WyY9huAcdHqPlVOfvwj/rTxW/dGFVqVlOWrW5td8+lJNmUT7L3zKdhOoWfuSdWta
        3GMaKJeVEt+guJstAVxkL/Zs6NP6J9Vg8lOszhHZp5PnmkBnS41oshcc0nBCWxa5
        wsR84MDAlaS8fMX543x2/CdN3RThR09FOfCuKL3MOmNSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8KvXRf
        gyt/iAa39KQDQu2IPIRo+jPaA8e8YdSenhf/c=; b=ykWzSQ1put4dAEgnYdQAPT
        cB4/cSSvmHq1sgwQLoWMXjPrsxH8gwF3T99MC2n+DlwDtd4wHBYQVXbAgL9n+sVd
        Ch2NjMe5U3d+QJRiSX05pvdjuC440YBLFMJzzhkER2E7JVsqtGRXgxouU53MTVfl
        5/BSt7X/8GjUGyP/67Om+emS7yQnO0mPchOwxzjOHz9dEoIVOrW1UivPUNfWqm3H
        tJGpgbPjP6XVtWadRgE+w3021wnFj7h7OTRywuUr67dhykwPp2MYW+pykaNy/ZgP
        fkyAfiJzWEV8N0J4g0vOCu16bWLjRMN02x2b6roZMLuFpai+4Rlzu2W211eUaIOQ
        ==
X-ME-Sender: <xms:rlwqXo-A_-CFO5L7FSwaoOZKPAgZMYNx8XfToOso51wL-ZxtvI7pow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdefgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeduleelrddvtddurdeigedrudefheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:rlwqXoDMRRWtb2B5eWsYVHLJ01zTOeZQ6HjFqiDsnP1o-KObcrKZKQ>
    <xmx:rlwqXgqCOJRAj7fQEazrMrkISxdNfyIUJI0LQ6vIGGmrXPHTGGN4Tg>
    <xmx:rlwqXih_PtYrNk7G1phxsijTQz2kPXBFXatnYQoGJC6mKhDiG51CWg>
    <xmx:rlwqXm7BRERLT6sxKkd3yKs5U-mghJOuYfdUvmssgslC9jebJULFhLaZHrg>
Received: from localhost (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id B6FAA3060AF2;
        Thu, 23 Jan 2020 21:55:40 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Thu Jan 23, 2020 at 11:20 PM
Originalfrom: "Martin Lau" <kafai@fb.com>
Original: =?utf-8?q?On_Thu,_Jan_23,_2020_at_01:23:12PM_-0800,_Daniel_Xu_wrote:=0D?=
 =?utf-8?q?=0A>_Signed-off-by:_Daniel_Xu_<dxu@dxuuu.xyz>=0D=0APlease_put_s?=
 =?utf-8?q?ome_details_to_avoid_empty_commit_message.=0D=0ASame_for_patch_?=
 =?utf-8?q?2.=0D=0A=0D=0A>_---=0D=0A>__.../selftests/bpf/prog=5Ftests/perf?=
 =?utf-8?q?=5Fbranches.c__|_106_++++++++++++++++++=0D=0A>__.../selftests/b?=
 =?utf-8?q?pf/progs/test=5Fperf=5Fbranches.c__|__39_+++++++=0D=0A>__2_file?=
 =?utf-8?q?s_changed,_145_insertions(+)=0D=0A>__create_mode_100644_tools/t?=
 =?utf-8?q?esting/selftests/bpf/prog=5Ftests/perf=5Fbranches.c=0D=0A>__cre?=
 =?utf-8?q?ate_mode_100644_tools/testing/selftests/bpf/progs/test=5Fperf?=
 =?utf-8?q?=5Fbranches.c=0D=0A>_=0D=0A>_diff_--git_a/tools/testing/selftes?=
 =?utf-8?q?ts/bpf/prog=5Ftests/perf=5Fbranches.c_b/tools/testing/selftests?=
 =?utf-8?q?/bpf/prog=5Ftests/perf=5Fbranches.c=0D=0A>_new_file_mode_100644?=
 =?utf-8?q?=0D=0A>_index_000000000000..f8d7356a6507=0D=0A>_---_/dev/null?=
 =?utf-8?q?=0D=0A>_+++_b/tools/testing/selftests/bpf/prog=5Ftests/perf=5Fb?=
 =?utf-8?q?ranches.c=0D=0A>_@@_-0,0_+1,106_@@=0D=0A>_+//_SPDX-License-Iden?=
 =?utf-8?q?tifier:_GPL-2.0=0D=0A>_+#define_=5FGNU=5FSOURCE=0D=0A>_+#includ?=
 =?utf-8?q?e_<pthread.h>=0D=0A>_+#include_<sched.h>=0D=0A>_+#include_<sys/?=
 =?utf-8?q?socket.h>=0D=0A>_+#include_<test=5Fprogs.h>=0D=0A>_+#include_"b?=
 =?utf-8?q?pf/libbpf=5Finternal.h"=0D=0A>_+=0D=0A>_+static_void_on=5Fsampl?=
 =?utf-8?q?e(void_*ctx,_int_cpu,_void_*data,_=5F=5Fu32_size)=0D=0A>_+{=0D?=
 =?utf-8?q?=0A>_+=09int_pbe=5Fsize_=3D_sizeof(struct_perf=5Fbranch=5Fentry?=
 =?utf-8?q?);=0D=0A>_+=09int_ret_=3D_*(int_*)data,_duration_=3D_0;=0D=0A>_?=
 =?utf-8?q?+=0D=0A>_+=09//_It's_hard_to_validate_the_contents_of_the_branc?=
 =?utf-8?q?h_entries_b/c_it=0D=0A>_+=09//_would_require_some_kind_of_disas?=
 =?utf-8?q?sembler_and_also_encoding_the=0D=0A>_+=09//_valid_jump_instruct?=
 =?utf-8?q?ions_for_supported_architectures._So_just_check=0D=0A>_+=09//_t?=
 =?utf-8?q?he_easy_stuff_for_now.=0D=0A/*_..._*/_comment_style=0D=0A=0D=0A?=
 =?utf-8?q?>_+=09CHECK(ret_<_0,_"read=5Fbranches",_"err_%d\n",_ret);=0D=0A?=
 =?utf-8?q?>_+=09CHECK(ret_%_pbe=5Fsize_!=3D_0,_"read=5Fbranches",=0D=0A>_?=
 =?utf-8?q?+=09______"bytes_written=3D%d_not_multiple_of_struct_size=3D%d\?=
 =?utf-8?q?n",=0D=0A>_+=09______ret,_pbe=5Fsize);=0D=0A>_+=0D=0A>_+=09*(in?=
 =?utf-8?q?t_*)ctx_=3D_1;=0D=0A>_+}=0D=0A>_+=0D=0A>_+void_test=5Fperf=5Fbr?=
 =?utf-8?q?anches(void)=0D=0A>_+{=0D=0A>_+=09int_err,_prog=5Ffd,_i,_pfd_?=
 =?utf-8?q?=3D_-1,_duration_=3D_0,_ok_=3D_0;=0D=0A>_+=09const_char_*file_?=
 =?utf-8?q?=3D_"./test=5Fperf=5Fbranches.o";=0D=0A>_+=09const_char_*prog?=
 =?utf-8?q?=5Fname_=3D_"perf=5Fevent";=0D=0A>_+=09struct_perf=5Fbuffer=5Fo?=
 =?utf-8?q?pts_pb=5Fopts_=3D_{};=0D=0A>_+=09struct_perf=5Fevent=5Fattr_att?=
 =?utf-8?q?r_=3D_{};=0D=0A>_+=09struct_bpf=5Fmap_*perf=5Fbuf=5Fmap;=0D=0A>?=
 =?utf-8?q?_+=09struct_bpf=5Fprogram_*prog;=0D=0A>_+=09struct_bpf=5Fobject?=
 =?utf-8?q?_*obj;=0D=0A>_+=09struct_perf=5Fbuffer_*pb;=0D=0A>_+=09struct_b?=
 =?utf-8?q?pf=5Flink_*link;=0D=0A>_+=09volatile_int_j_=3D_0;=0D=0A>_+=09cp?=
 =?utf-8?q?u=5Fset=5Ft_cpu=5Fset;=0D=0A>_+=0D=0A>_+=09/*_load_program_*/?=
 =?utf-8?q?=0D=0A>_+=09err_=3D_bpf=5Fprog=5Fload(file,_BPF=5FPROG=5FTYPE?=
 =?utf-8?q?=5FPERF=5FEVENT,_&obj,_&prog=5Ffd);=0D=0A>_+=09if_(CHECK(err,_"?=
 =?utf-8?q?obj=5Fload",_"err_%d_errno_%d\n",_err,_errno))_{=0D=0A>_+=09=09?=
 =?utf-8?q?obj_=3D_NULL;=0D=0A>_+=09=09goto_out=5Fclose;=0D=0A>_+=09}=0D?=
 =?utf-8?q?=0A>_+=0D=0A>_+=09prog_=3D_bpf=5Fobject=5F=5Ffind=5Fprogram=5Fb?=
 =?utf-8?q?y=5Ftitle(obj,_prog=5Fname);=0D=0A>_+=09if_(CHECK(!prog,_"find?=
 =?utf-8?q?=5Fprobe",_"prog_'%s'_not_found\n",_prog=5Fname))=0D=0A>_+=09?=
 =?utf-8?q?=09goto_out=5Fclose;=0D=0A>_+=0D=0A>_+=09/*_load_map_*/=0D=0A>_?=
 =?utf-8?q?+=09perf=5Fbuf=5Fmap_=3D_bpf=5Fobject=5F=5Ffind=5Fmap=5Fby=5Fna?=
 =?utf-8?q?me(obj,_"perf=5Fbuf=5Fmap");=0D=0A>_+=09if_(CHECK(!perf=5Fbuf?=
 =?utf-8?q?=5Fmap,_"find=5Fperf=5Fbuf=5Fmap",_"not_found\n"))=0D=0A>_+=09?=
 =?utf-8?q?=09goto_out=5Fclose;=0D=0AUsing_skel_may_be_able_to_cut_some_li?=
 =?utf-8?q?nes.=0D=0A=0D=0A>_+=0D=0A>_+=09/*_create_perf_event_*/=0D=0A>_+?=
 =?utf-8?q?=09attr.size_=3D_sizeof(attr);=0D=0A>_+=09attr.type_=3D_PERF=5F?=
 =?utf-8?q?TYPE=5FHARDWARE;=0D=0A>_+=09attr.config_=3D_PERF=5FCOUNT=5FHW?=
 =?utf-8?q?=5FCPU=5FCYCLES;=0D=0A>_+=09attr.freq_=3D_1;=0D=0A>_+=09attr.sa?=
 =?utf-8?q?mple=5Ffreq_=3D_4000;=0D=0A>_+=09attr.sample=5Ftype_=3D_PERF=5F?=
 =?utf-8?q?SAMPLE=5FBRANCH=5FSTACK;=0D=0A>_+=09attr.branch=5Fsample=5Ftype?=
 =?utf-8?q?_=3D_PERF=5FSAMPLE=5FBRANCH=5FUSER_|_PERF=5FSAMPLE=5FBRANCH=5FA?=
 =?utf-8?q?NY;=0D=0A>_+=09pfd_=3D_syscall(=5F=5FNR=5Fperf=5Fevent=5Fopen,_?=
 =?utf-8?q?&attr,_-1,_0,_-1,_PERF=5FFLAG=5FFD=5FCLOEXEC);=0D=0A>_+=09if_(C?=
 =?utf-8?q?HECK(pfd_<_0,_"perf=5Fevent=5Fopen",_"err_%d\n",_pfd))=0D=0A>_+?=
 =?utf-8?q?=09=09goto_out=5Fclose;=0D=0A>_+=0D=0A>_+=09/*_attach_perf=5Fev?=
 =?utf-8?q?ent_*/=0D=0A>_+=09link_=3D_bpf=5Fprogram=5F=5Fattach=5Fperf=5Fe?=
 =?utf-8?q?vent(prog,_pfd);=0D=0A>_+=09if_(CHECK(IS=5FERR(link),_"attach?=
 =?utf-8?q?=5Fperf=5Fevent",_"err_%ld\n",_PTR=5FERR(link)))=0D=0A>_+=09=09?=
 =?utf-8?q?goto_out=5Fclose=5Fperf;=0D=0A>_+=0D=0A>_+=09/*_set_up_perf_buf?=
 =?utf-8?q?fer_*/=0D=0A>_+=09pb=5Fopts.sample=5Fcb_=3D_on=5Fsample;=0D=0A>?=
 =?utf-8?q?_+=09pb=5Fopts.ctx_=3D_&ok;=0D=0A>_+=09pb_=3D_perf=5Fbuffer=5F?=
 =?utf-8?q?=5Fnew(bpf=5Fmap=5F=5Ffd(perf=5Fbuf=5Fmap),_1,_&pb=5Fopts);=0D?=
 =?utf-8?q?=0A>_+=09if_(CHECK(IS=5FERR(pb),_"perf=5Fbuf=5F=5Fnew",_"err_%l?=
 =?utf-8?q?d\n",_PTR=5FERR(pb)))=0D=0A>_+=09=09goto_out=5Fdetach;=0D=0A>_+?=
 =?utf-8?q?=0D=0A>_+=09/*_generate_some_branches_on_cpu_0_*/=0D=0A>_+=09CP?=
 =?utf-8?q?U=5FZERO(&cpu=5Fset);=0D=0A>_+=09CPU=5FSET(0,_&cpu=5Fset);=0D?=
 =?utf-8?q?=0A>_+=09err_=3D_pthread=5Fsetaffinity=5Fnp(pthread=5Fself(),_s?=
 =?utf-8?q?izeof(cpu=5Fset),_&cpu=5Fset);=0D=0A>_+=09if_(err_&&_CHECK(err,?=
 =?utf-8?q?_"set=5Faffinity",_"cpu_#0,_err_%d\n",_err))=0D=0A'err_&&'_seem?=
 =?utf-8?q?s_unnecessary.=0D=0A=0D=0A>_+=09=09goto_out=5Ffree=5Fpb;=0D=0A>?=
 =?utf-8?q?_+=09for_(i_=3D_0;_i_<_1000000;_++i)=0D=0AMay_be_some_comments_?=
 =?utf-8?q?on_1000000=3F=0D=0A=0D=0A>_+=09=09++j;=0D=0A>_+=0D=0A>_+=09/*_r?=
 =?utf-8?q?ead_perf_buffer_*/=0D=0A>_+=09err_=3D_perf=5Fbuffer=5F=5Fpoll(p?=
 =?utf-8?q?b,_500);=0D=0A>_+=09if_(CHECK(err_<_0,_"perf=5Fbuffer=5F=5Fpoll?=
 =?utf-8?q?",_"err_%d\n",_err))=0D=0A>_+=09=09goto_out=5Ffree=5Fpb;=0D=0A>?=
 =?utf-8?q?_+=0D=0A>_+=09if_(CHECK(!ok,_"ok",_"not_ok\n"))=0D=0A>_+=09=09g?=
 =?utf-8?q?oto_out=5Ffree=5Fpb;=0D=0A>_+=0D=0A>_+out=5Ffree=5Fpb:=0D=0A>_+?=
 =?utf-8?q?=09perf=5Fbuffer=5F=5Ffree(pb);=0D=0A>_+out=5Fdetach:=0D=0A>_+?=
 =?utf-8?q?=09bpf=5Flink=5F=5Fdestroy(link);=0D=0A>_+out=5Fclose=5Fperf:?=
 =?utf-8?q?=0D=0A>_+=09close(pfd);=0D=0A>_+out=5Fclose:=0D=0A>_+=09bpf=5Fo?=
 =?utf-8?q?bject=5F=5Fclose(obj);=0D=0A>_+}=0D=0A>_diff_--git_a/tools/test?=
 =?utf-8?q?ing/selftests/bpf/progs/test=5Fperf=5Fbranches.c_b/tools/testin?=
 =?utf-8?q?g/selftests/bpf/progs/test=5Fperf=5Fbranches.c=0D=0A>_new_file_?=
 =?utf-8?q?mode_100644=0D=0A>_index_000000000000..d818079c7778=0D=0A>_---_?=
 =?utf-8?q?/dev/null=0D=0A>_+++_b/tools/testing/selftests/bpf/progs/test?=
 =?utf-8?q?=5Fperf=5Fbranches.c=0D=0A>_@@_-0,0_+1,39_@@=0D=0A>_+//_SPDX-Li?=
 =?utf-8?q?cense-Identifier:_GPL-2.0=0D=0A>_+//_Copyright_(c)_2019_Faceboo?=
 =?utf-8?q?k=0D=0A>_+=0D=0A>_+#include_<linux/ptrace.h>=0D=0A>_+#include_<?=
 =?utf-8?q?linux/bpf.h>=0D=0A>_+#include_<bpf/bpf=5Fhelpers.h>=0D=0A>_+#in?=
 =?utf-8?q?clude_"bpf=5Ftrace=5Fhelpers.h"=0D=0A>_+=0D=0A>_+struct_{=0D=0A?=
 =?utf-8?q?>_+=09=5F=5Fuint(type,_BPF=5FMAP=5FTYPE=5FPERF=5FEVENT=5FARRAY)?=
 =?utf-8?q?;=0D=0A>_+=09=5F=5Fuint(key=5Fsize,_sizeof(int));=0D=0A>_+=09?=
 =?utf-8?q?=5F=5Fuint(value=5Fsize,_sizeof(int));=0D=0A>_+}_perf=5Fbuf=5Fm?=
 =?utf-8?q?ap_SEC(".maps");=0D=0A>_+=0D=0A>_+struct_fake=5Fperf=5Fbranch?=
 =?utf-8?q?=5Fentry_{=0D=0A>_+=09=5F=5Fu64_=5Fa;=0D=0A>_+=09=5F=5Fu64_=5Fb?=
 =?utf-8?q?;=0D=0A>_+=09=5F=5Fu64_=5Fc;=0D=0A>_+};=0D=0A>_+=0D=0A>_+SEC("p?=
 =?utf-8?q?erf=5Fevent")=0D=0A>_+int_perf=5Fbranches(void_*ctx)=0D=0A>_+{?=
 =?utf-8?q?=0D=0A>_+=09int_ret;=0D=0A>_+=09struct_fake=5Fperf=5Fbranch=5Fe?=
 =?utf-8?q?ntry_entries[4];=0D=0ATry_to_keep_the_reverse_xmas_tree.=0D=0A?=
 =?utf-8?q?=0D=0A>_+=0D=0A>_+=09ret_=3D_bpf=5Fperf=5Fprog=5Fread=5Fbranche?=
 =?utf-8?q?s(ctx,=0D=0A>_+=09=09=09=09=09__entries,=0D=0A>_+=09=09=09=09?=
 =?utf-8?q?=09__sizeof(entries));=0D=0A>_+=09/*_ignore_spurious_events_*/?=
 =?utf-8?q?=0D=0A>_+=09if_(!ret)=0D=0ACheck_for_-ve_also=3F=0D=0A=0D=0A>_+?=
 =?utf-8?q?=09=09return_1;=0D=0A>_+=0D=0A>_+=09bpf=5Fperf=5Fevent=5Foutput?=
 =?utf-8?q?(ctx,_&perf=5Fbuf=5Fmap,_BPF=5FF=5FCURRENT=5FCPU,=0D=0A>_+=09?=
 =?utf-8?q?=09=09______&ret,_sizeof(ret));=0D=0A>_+=09return_0;=0D=0A>_+}?=
 =?utf-8?q?=0D=0A>_+=0D=0A>_+char_=5Flicense[]_SEC("license")_=3D_"GPL";?=
 =?utf-8?q?=0D=0A>_--_=0D=0A>_2.21.1=0D=0A>_=0D=0A?=
In-Reply-To: <20200123232040.dqsswmoltc3rlqhm@kafai-mbp.dhcp.thefacebook.com>
Date:   Thu, 23 Jan 2020 18:55:39 -0800
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add
 bpf_perf_prog_read_branches() selftest
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Martin Lau" <kafai@fb.com>
Message-Id: <C03OLSCKAFRL.39222EWVHYB6F@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Jan 23, 2020 at 11:20 PM, Martin Lau wrote:
> On Thu, Jan 23, 2020 at 01:23:12PM -0800, Daniel Xu wrote:
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Please put some details to avoid empty commit message.
> Same for patch 2.

Ok.
>
>=20
> > ---
> >  .../selftests/bpf/prog_tests/perf_branches.c  | 106 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_perf_branches.c  |  39 +++++++
> >  2 files changed, 145 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branche=
s.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branche=
s.c
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/t=
ools/testing/selftests/bpf/prog_tests/perf_branches.c
> > new file mode 100644
> > index 000000000000..f8d7356a6507
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> > @@ -0,0 +1,106 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +#include <pthread.h>
> > +#include <sched.h>
> > +#include <sys/socket.h>
> > +#include <test_progs.h>
> > +#include "bpf/libbpf_internal.h"
> > +
> > +static void on_sample(void *ctx, int cpu, void *data, __u32 size)
> > +{
> > +	int pbe_size =3D sizeof(struct perf_branch_entry);
> > +	int ret =3D *(int *)data, duration =3D 0;
> > +
> > +	// It's hard to validate the contents of the branch entries b/c it
> > +	// would require some kind of disassembler and also encoding the
> > +	// valid jump instructions for supported architectures. So just check
> > +	// the easy stuff for now.
> /* ... */ comment style

Whoops, sorry.

>
>=20
> > +	CHECK(ret < 0, "read_branches", "err %d\n", ret);
> > +	CHECK(ret % pbe_size !=3D 0, "read_branches",
> > +	      "bytes written=3D%d not multiple of struct size=3D%d\n",
> > +	      ret, pbe_size);
> > +
> > +	*(int *)ctx =3D 1;
> > +}
> > +
> > +void test_perf_branches(void)
> > +{
> > +	int err, prog_fd, i, pfd =3D -1, duration =3D 0, ok =3D 0;
> > +	const char *file =3D "./test_perf_branches.o";
> > +	const char *prog_name =3D "perf_event";
> > +	struct perf_buffer_opts pb_opts =3D {};
> > +	struct perf_event_attr attr =3D {};
> > +	struct bpf_map *perf_buf_map;
> > +	struct bpf_program *prog;
> > +	struct bpf_object *obj;
> > +	struct perf_buffer *pb;
> > +	struct bpf_link *link;
> > +	volatile int j =3D 0;
> > +	cpu_set_t cpu_set;
> > +
> > +	/* load program */
> > +	err =3D bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd)=
;
> > +	if (CHECK(err, "obj_load", "err %d errno %d\n", err, errno)) {
> > +		obj =3D NULL;
> > +		goto out_close;
> > +	}
> > +
> > +	prog =3D bpf_object__find_program_by_title(obj, prog_name);
> > +	if (CHECK(!prog, "find_probe", "prog '%s' not found\n", prog_name))
> > +		goto out_close;
> > +
> > +	/* load map */
> > +	perf_buf_map =3D bpf_object__find_map_by_name(obj, "perf_buf_map");
> > +	if (CHECK(!perf_buf_map, "find_perf_buf_map", "not found\n"))
> > +		goto out_close;
> Using skel may be able to cut some lines.

Ok, will take a look.

>
>=20
> > +
> > +	/* create perf event */
> > +	attr.size =3D sizeof(attr);
> > +	attr.type =3D PERF_TYPE_HARDWARE;
> > +	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> > +	attr.freq =3D 1;
> > +	attr.sample_freq =3D 4000;
> > +	attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
> > +	attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRA=
NCH_ANY;
> > +	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_=
CLOEXEC);
> > +	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
> > +		goto out_close;
> > +
> > +	/* attach perf_event */
> > +	link =3D bpf_program__attach_perf_event(prog, pfd);
> > +	if (CHECK(IS_ERR(link), "attach_perf_event", "err %ld\n", PTR_ERR(lin=
k)))
> > +		goto out_close_perf;
> > +
> > +	/* set up perf buffer */
> > +	pb_opts.sample_cb =3D on_sample;
> > +	pb_opts.ctx =3D &ok;
> > +	pb =3D perf_buffer__new(bpf_map__fd(perf_buf_map), 1, &pb_opts);
> > +	if (CHECK(IS_ERR(pb), "perf_buf__new", "err %ld\n", PTR_ERR(pb)))
> > +		goto out_detach;
> > +
> > +	/* generate some branches on cpu 0 */
> > +	CPU_ZERO(&cpu_set);
> > +	CPU_SET(0, &cpu_set);
> > +	err =3D pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_=
set);
> > +	if (err && CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
> 'err &&' seems unnecessary.

Will remove.

>
>=20
> > +		goto out_free_pb;
> > +	for (i =3D 0; i < 1000000; ++i)
> May be some comments on 1000000?
>
>=20
> > +		++j;
> > +
> > +	/* read perf buffer */
> > +	err =3D perf_buffer__poll(pb, 500);
> > +	if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
> > +		goto out_free_pb;
> > +
> > +	if (CHECK(!ok, "ok", "not ok\n"))
> > +		goto out_free_pb;
> > +
> > +out_free_pb:
> > +	perf_buffer__free(pb);
> > +out_detach:
> > +	bpf_link__destroy(link);
> > +out_close_perf:
> > +	close(pfd);
> > +out_close:
> > +	bpf_object__close(obj);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/t=
ools/testing/selftests/bpf/progs/test_perf_branches.c
> > new file mode 100644
> > index 000000000000..d818079c7778
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2019 Facebook
> > +
> > +#include <linux/ptrace.h>
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_trace_helpers.h"
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > +	__uint(key_size, sizeof(int));
> > +	__uint(value_size, sizeof(int));
> > +} perf_buf_map SEC(".maps");
> > +
> > +struct fake_perf_branch_entry {
> > +	__u64 _a;
> > +	__u64 _b;
> > +	__u64 _c;
> > +};
> > +
> > +SEC("perf_event")
> > +int perf_branches(void *ctx)
> > +{
> > +	int ret;
> > +	struct fake_perf_branch_entry entries[4];
> Try to keep the reverse xmas tree.
>
>=20
> > +
> > +	ret =3D bpf_perf_prog_read_branches(ctx,
> > +					  entries,
> > +					  sizeof(entries));
> > +	/* ignore spurious events */
> > +	if (!ret)
> Check for -ve also?

Assuming that means negative, no. Sometimes there aren't any branch
events stored. That's ok and we want to ignore that. If there's an error
(negative), we should pass that up to the selftest in userspace and fail
the test.

>
>=20
> > +		return 1;
> > +
> > +	bpf_perf_event_output(ctx, &perf_buf_map, BPF_F_CURRENT_CPU,
> > +			      &ret, sizeof(ret));
> > +	return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --=20
> > 2.21.1
> >=20
>
>=20
>
>=20

