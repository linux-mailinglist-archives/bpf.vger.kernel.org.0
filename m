Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD4614AA2B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 20:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0TBM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 14:01:12 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39613 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgA0TBM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jan 2020 14:01:12 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6AA482A91;
        Mon, 27 Jan 2020 14:01:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Jan 2020 14:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:from:to
        :cc:subject:message-id; s=fm2; bh=MQp9NLIcyS2oDz1qM49q0G+vgy3iux
        KktMJGEMfic70=; b=fPUOyYdrnlUE3Yfw0OvHN9RRMiLLtTUL+iGbBwZ2JHuoWe
        k0wKUI1AUsm1eIevbr+ixDfJp6unJfQ4Vu5NclsvW2Z0vLa+9IjAFGE53t2gDxcD
        lPALPPmZzIcRgfiaU9+dmhE8B81ne/xZk9Bm4SLcemurwjDDEcauWDSJCP2aEXk+
        PYuzDqEJttwbaMC5BqHoif/cZAAkoPTLpXsDhYpQM7PJLr4ULPxI9f3nEXxr+PWI
        NEosy3mxO8b2Nn/5FHH00aaIs+pWfYE7MC40a5+nf/ZolP9ABntfrsS1ewlOeQh3
        teRxXveoXTIdLCDsx38oYnOOSMcMO2YxGCDY2tXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MQp9NL
        IcyS2oDz1qM49q0G+vgy3iuxKktMJGEMfic70=; b=ybuAWR74URAm2o6GnlJLFX
        9LZrweC3aF/6l0mDR6k6MxouGy1cvbP3xKchsFyeWP5RY4pEGO7h0iVoouW5Ckyv
        YSd4vXftrn4qKnp1Dp9P25hUU+TzBT6xGgrrYOjD4mqXnlqmotRDersiUzTDTFxl
        JmjFimUJ1cYZrPLmHk5P/RVROB+XSryePo3J0iVJJUaN5F4oCSJcp4ABlyYWOeZG
        hQU3p0k+/KXnbB4Gm0PtFBlcEJv9SK3erCm7nPL53mNxz7nXe5ZwCgsHvpGvZZd4
        vej1SDmCmqEpH7I3JcuCfTqPzoUwPzO7gLYVxxCCnUNBocJvxJhyKJeFkJU+IdMQ
        ==
X-ME-Sender: <xms:dTMvXsXdL9WIP02AHxrSWnhDWFmWuop8GTl_tGJRPR2xFVw1UbAzJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpefgtggjfffhvffukfesthhqredttddtjeen
    ucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqeenuc
    fkphepudelledrvddtuddrieegrddufeelnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:djMvXmiMLIsC3RQb-nunLkBpI_Td312HVbQqlYZHfPg7-vlMOBan7g>
    <xmx:djMvXtjXak1mgFYZVItsKfU_y-Mu_g559R8Z1jiokB8b-cQUTcSYYw>
    <xmx:djMvXsEBdNgfpN0pjb6HP_QKgQKbNHwUZcexa66es1UVPd-bBSHGYw>
    <xmx:djMvXjXHayB0l4eDLQegNEruNkIVKAK2MZ7IxTPDRLlT7xauj32ziA>
Received: from localhost (unknown [199.201.64.139])
        by mail.messagingengine.com (Postfix) with ESMTPA id D983D328005D;
        Mon, 27 Jan 2020 14:01:08 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Mon Jan 27, 2020 at 1:26 PM
Originalfrom: "Daniel Borkmann" <daniel@iogearbox.net>
Original: =?utf-8?q?On_1/27/20_12:35_AM,_Daniel_Xu_wrote:
 =0D=0A>_Branch_records_are?=
 =?utf-8?q?_a_CPU_feature_that_can_be_configured_to_record=0D=0A>_certain_?=
 =?utf-8?q?branches_that_are_taken_during_code_execution._This_data_is=0D?=
 =?utf-8?q?=0A>_particularly_interesting_for_profile_guided_optimizations.?=
 =?utf-8?q?_perf_has_had=0D=0A>_branch_record_support_for_a_while_but_the_?=
 =?utf-8?q?data_collection_can_be_a_bit=0D=0A>_coarse_grained.=0D=0A>_=0D?=
 =?utf-8?q?=0A>_We_(Facebook)_have_seen_in_experiments_that_associating_me?=
 =?utf-8?q?tadata_with=0D=0A>_branch_records_can_improve_results_(after_po?=
 =?utf-8?q?stprocessing)._We_generally=0D=0A>_use_bpf=5Fprobe=5Fread=5F*()?=
 =?utf-8?q?_to_get_metadata_out_of_userspace._That's_why_bpf=0D=0A>_suppor?=
 =?utf-8?q?t_for_branch_records_is_useful.=0D=0A>_=0D=0A>_Aside_from_this_?=
 =?utf-8?q?particular_use_case,_having_branch_data_available_to_bpf=0D=0A>?=
 =?utf-8?q?_progs_can_be_useful_to_get_stack_traces_out_of_userspace_appli?=
 =?utf-8?q?cations=0D=0A>_that_omit_frame_pointers.=0D=0A>_=0D=0A>_Signed-?=
 =?utf-8?q?off-by:_Daniel_Xu_<dxu@dxuuu.xyz>=0D=0A>_---=0D=0A>___include/u?=
 =?utf-8?q?api/linux/bpf.h_|_25_+++++++++++++++++++++++-=0D=0A>___kernel/t?=
 =?utf-8?q?race/bpf=5Ftrace.c_|_41_+++++++++++++++++++++++++++++++++++++++?=
 =?utf-8?q?+=0D=0A>___2_files_changed,_65_insertions(+),_1_deletion(-)=0D?=
 =?utf-8?q?=0A>_=0D=0A>_diff_--git_a/include/uapi/linux/bpf.h_b/include/ua?=
 =?utf-8?q?pi/linux/bpf.h=0D=0A>_index_f1d74a2bd234..332aa433d045_100644?=
 =?utf-8?q?=0D=0A>_---_a/include/uapi/linux/bpf.h=0D=0A>_+++_b/include/uap?=
 =?utf-8?q?i/linux/bpf.h=0D=0A>_@@_-2892,6_+2892,25_@@_union_bpf=5Fattr_{?=
 =?utf-8?q?=0D=0A>____*=09=09Obtain_the_64bit_jiffies=0D=0A>____*=09Return?=
 =?utf-8?q?=0D=0A>____*=09=09The_64_bit_jiffies=0D=0A>_+_*=0D=0A>_+_*_int_?=
 =?utf-8?q?bpf=5Fread=5Fbranch=5Frecords(struct_bpf=5Fperf=5Fevent=5Fdata_?=
 =?utf-8?q?*ctx,_void_*buf,_u32_buf=5Fsize,_u64_flags)=0D=0A=0D=0ASmall_ni?=
 =?utf-8?q?t:_s/buf=5Fsize/size/,_so_that_it_matches_with_your_BPF=5FCALL_?=
 =?utf-8?q?below.=0D=0A=0D=0A__+BPF=5FCALL=5F4(bpf=5Fread=5Fbranch=5Frecor?=
 =?utf-8?q?ds,_struct_bpf=5Fperf=5Fevent=5Fdata=5Fkern_*,_ctx,=0D=0A__+=09?=
 =?utf-8?q?___void_*,_buf,_u32,_size,_u64,_flags)=0D=0A=0D=0A>_+_*=09Descr?=
 =?utf-8?q?iption=0D=0A>_+_*=09=09For_an_eBPF_program_attached_to_a_perf_e?=
 =?utf-8?q?vent,_retrieve_the=0D=0A>_+_*=09=09branch_records_(struct_perf?=
 =?utf-8?q?=5Fbranch=5Fentry)_associated_to_*ctx*=0D=0A>_+_*=09=09and_stor?=
 =?utf-8?q?e_it_in=09the_buffer_pointed_by_*buf*_up_to_size=0D=0A>_+_*=09?=
 =?utf-8?q?=09*buf=5Fsize*_bytes.=0D=0A>_+_*=0D=0A>_+_*=09=09The_*flags*_c?=
 =?utf-8?q?an_be_set_to_**BPF=5FF=5FGET=5FBRANCH=5FRECORDS=5FSIZE**_to=0D?=
 =?utf-8?q?=0A>_+_*=09=09instead=09return_the_number_of_bytes_required_to_?=
 =?utf-8?q?store_all_the=0D=0A>_+_*=09=09branch_entries._If_this_flag_is_s?=
 =?utf-8?q?et,_*buf*_may_be_NULL.=0D=0A>_+_*=09Return=0D=0A>_+_*=09=09On_s?=
 =?utf-8?q?uccess,_number_of_bytes_written_to_*buf*._On_error,_a=0D=0A>_+_?=
 =?utf-8?q?*=09=09negative_value.=0D=0A=0D=0AMaybe_pull_the_2nd_paragraph_?=
 =?utf-8?q?from_above_in_here_so_that_it_reflects_the_description=0D=0Aof_?=
 =?utf-8?q?the_return_value_when_flag_is_used_also_for_this_case_in_the_'R?=
 =?utf-8?q?eturn'_description.=0D=0A=0D=0A>_+_*=09=09**-EINVAL**_if_argume?=
 =?utf-8?q?nts_invalid_or_**buf=5Fsize**_not_a_multiple=0D=0A>_+_*=09=09of?=
 =?utf-8?q?_sizeof(struct_perf=5Fbranch=5Fentry).=0D=0A>_+_*=0D=0A>_+_*=09?=
 =?utf-8?q?=09**-ENOENT**_if_architecture_does_not_support_branch_records.?=
 =?utf-8?q?=0D=0A>____*/=0D=0A>___#define_=5F=5FBPF=5FFUNC=5FMAPPER(FN)=09?=
 =?utf-8?q?=09\=0D=0A>___=09FN(unspec),=09=09=09\=0D=0A>_@@_-3012,7_+3031,?=
 =?utf-8?q?8_@@_union_bpf=5Fattr_{=0D=0A>___=09FN(probe=5Fread=5Fkernel=5F?=
 =?utf-8?q?str),=09\=0D=0A>___=09FN(tcp=5Fsend=5Fack),=09=09\=0D=0A>___=09?=
 =?utf-8?q?FN(send=5Fsignal=5Fthread),=09=09\=0D=0A>_-=09FN(jiffies64),=0D?=
 =?utf-8?q?=0A>_+=09FN(jiffies64),=09=09=09\=0D=0A>_+=09FN(read=5Fbranch?=
 =?utf-8?q?=5Frecords),=0D=0A>___=0D=0A>___/*_integer_value_in_'imm'_field?=
 =?utf-8?q?_of_BPF=5FCALL_instruction_selects_which_helper=0D=0A>____*_fun?=
 =?utf-8?q?ction_eBPF_program_intends_to_call=0D=0A>_@@_-3091,6_+3111,9_@@?=
 =?utf-8?q?_enum_bpf=5Ffunc=5Fid_{=0D=0A>___/*_BPF=5FFUNC=5Fsk=5Fstorage?=
 =?utf-8?q?=5Fget_flags_*/=0D=0A>___#define_BPF=5FSK=5FSTORAGE=5FGET=5FF?=
 =?utf-8?q?=5FCREATE=09(1ULL_<<_0)=0D=0A>___=0D=0A>_+/*_BPF=5FFUNC=5Fread?=
 =?utf-8?q?=5Fbranch=5Frecords_flags._*/=0D=0A>_+#define_BPF=5FF=5FGET=5FB?=
 =?utf-8?q?RANCH=5FRECORDS=5FSIZE=09(1ULL_<<_0)=0D=0A>_+=0D=0A>___/*_Mode_?=
 =?utf-8?q?for_BPF=5FFUNC=5Fskb=5Fadjust=5Froom_helper._*/=0D=0A>___enum_b?=
 =?utf-8?q?pf=5Fadj=5Froom=5Fmode_{=0D=0A>___=09BPF=5FADJ=5FROOM=5FNET,=0D?=
 =?utf-8?q?=0A>_diff_--git_a/kernel/trace/bpf=5Ftrace.c_b/kernel/trace/bpf?=
 =?utf-8?q?=5Ftrace.c=0D=0A>_index_19e793aa441a..efd119de95b8_100644=0D=0A?=
 =?utf-8?q?>_---_a/kernel/trace/bpf=5Ftrace.c=0D=0A>_+++_b/kernel/trace/bp?=
 =?utf-8?q?f=5Ftrace.c=0D=0A>_@@_-1028,6_+1028,45_@@_static_const_struct_b?=
 =?utf-8?q?pf=5Ffunc=5Fproto_bpf=5Fperf=5Fprog=5Fread=5Fvalue=5Fproto_=3D_?=
 =?utf-8?q?{=0D=0A>____________.arg3=5Ftype______=3D_ARG=5FCONST=5FSIZE,?=
 =?utf-8?q?=0D=0A>___};=0D=0A>___=0D=0A>_+BPF=5FCALL=5F4(bpf=5Fread=5Fbran?=
 =?utf-8?q?ch=5Frecords,_struct_bpf=5Fperf=5Fevent=5Fdata=5Fkern_*,_ctx,?=
 =?utf-8?q?=0D=0A>_+=09___void_*,_buf,_u32,_size,_u64,_flags)=0D=0A>_+{=0D?=
 =?utf-8?q?=0A>_+#ifndef_CONFIG=5FX86=0D=0A>_+=09return_-ENOENT;=0D=0A>_+#?=
 =?utf-8?q?else=0D=0A>_+=09struct_perf=5Fbranch=5Fstack_*br=5Fstack_=3D_ct?=
 =?utf-8?q?x->data->br=5Fstack;=0D=0A>_+=09u32_br=5Fentry=5Fsize_=3D_sizeo?=
 =?utf-8?q?f(struct_perf=5Fbranch=5Fentry);=0D=0A=0D=0A'static_const_u32_b?=
 =?utf-8?q?r=5Fentry=5Fsize'_if_we_use_it_as_such_below.=0D=0A=0D=0A>_+=09?=
 =?utf-8?q?u32_to=5Fcopy;=0D=0A>_+=0D=0A>_+=09if_(unlikely(flags_&_~BPF=5F?=
 =?utf-8?q?F=5FGET=5FBRANCH=5FRECORDS=5FSIZE))=0D=0A>_+=09=09return_-EINVA?=
 =?utf-8?q?L;=0D=0A>_+=0D=0A>_+=09if_(unlikely(!br=5Fstack))=0D=0A>_+=09?=
 =?utf-8?q?=09return_-EINVAL;=0D=0A=0D=0AWhy_the_ifdef_X86=3F_In_previous_?=
 =?utf-8?q?thread_I_meant_to_change_it_into_since_it's=0D=0Aimplicit:=0D?=
 =?utf-8?q?=0A=0D=0A_________if_(unlikely(!br=5Fstack))=0D=0A_____________?=
 =?utf-8?q?____return_-ENOENT;=0D=0A=0D=0AOr_is_there_any_other_additional?=
 =?utf-8?q?_rationale=3F=0D=0A=0D=0A>_+=09if_(flags_&_BPF=5FF=5FGET=5FBRAN?=
 =?utf-8?q?CH=5FRECORDS=5FSIZE)=0D=0A>_+=09=09return_br=5Fstack->nr_*_br?=
 =?utf-8?q?=5Fentry=5Fsize;=0D=0A>_+=0D=0A>_+=09if_(!buf_||_(size_%_br=5Fe?=
 =?utf-8?q?ntry=5Fsize_!=3D_0))=0D=0A>_+=09=09return_-EINVAL;=0D=0A>_+=0D?=
 =?utf-8?q?=0A>_+=09to=5Fcopy_=3D_min=5Ft(u32,_br=5Fstack->nr_*_br=5Fentry?=
 =?utf-8?q?=5Fsize,_size);=0D=0A>_+=09memcpy(buf,_br=5Fstack->entries,_to?=
 =?utf-8?q?=5Fcopy);=0D=0A>_+=0D=0A>_+=09return_to=5Fcopy;=0D=0A>_+#endif?=
 =?utf-8?q?=0D=0A>_+}=0D=0A>_+=0D=0A>_+static_const_struct_bpf=5Ffunc=5Fpr?=
 =?utf-8?q?oto_bpf=5Fread=5Fbranch=5Frecords=5Fproto_=3D_{=0D=0A>_+=09.fun?=
 =?utf-8?q?c___________=3D_bpf=5Fread=5Fbranch=5Frecords,=0D=0A>_+=09.gpl?=
 =?utf-8?q?=5Fonly_______=3D_true,=0D=0A>_+=09.ret=5Ftype_______=3D_RET=5F?=
 =?utf-8?q?INTEGER,=0D=0A>_+=09.arg1=5Ftype______=3D_ARG=5FPTR=5FTO=5FCTX,?=
 =?utf-8?q?=0D=0A>_+=09.arg2=5Ftype______=3D_ARG=5FPTR=5FTO=5FMEM=5FOR=5FN?=
 =?utf-8?q?ULL,=0D=0A>_+=09.arg3=5Ftype______=3D_ARG=5FCONST=5FSIZE=5FOR?=
 =?utf-8?q?=5FZERO,=0D=0A>_+=09.arg4=5Ftype______=3D_ARG=5FANYTHING,=0D=0A?=
 =?utf-8?q?>_+};=0D=0A>_+=0D=0A>___static_const_struct_bpf=5Ffunc=5Fproto_?=
 =?utf-8?q?*=0D=0A>___pe=5Fprog=5Ffunc=5Fproto(enum_bpf=5Ffunc=5Fid_func?=
 =?utf-8?q?=5Fid,_const_struct_bpf=5Fprog_*prog)=0D=0A>___{=0D=0A>_@@_-104?=
 =?utf-8?q?0,6_+1079,8_@@_pe=5Fprog=5Ffunc=5Fproto(enum_bpf=5Ffunc=5Fid_fu?=
 =?utf-8?q?nc=5Fid,_const_struct_bpf=5Fprog_*prog)=0D=0A>___=09=09return_&?=
 =?utf-8?q?bpf=5Fget=5Fstack=5Fproto=5Ftp;=0D=0A>___=09case_BPF=5FFUNC=5Fp?=
 =?utf-8?q?erf=5Fprog=5Fread=5Fvalue:=0D=0A>___=09=09return_&bpf=5Fperf=5F?=
 =?utf-8?q?prog=5Fread=5Fvalue=5Fproto;=0D=0A>_+=09case_BPF=5FFUNC=5Fread?=
 =?utf-8?q?=5Fbranch=5Frecords:=0D=0A>_+=09=09return_&bpf=5Fread=5Fbranch?=
 =?utf-8?q?=5Frecords=5Fproto;=0D=0A>___=09default:=0D=0A>___=09=09return_?=
 =?utf-8?q?tracing=5Ffunc=5Fproto(func=5Fid,_prog);=0D=0A>___=09}=0D=0A>_?=
 =?utf-8?q?=0D=0A=0D=0A?=
In-Reply-To: <a026ad0c-7d24-09cc-9742-c241d37fbdb0@iogearbox.net>
Date:   Mon, 27 Jan 2020 11:01:08 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <songliubraving@fb.com>, <yhs@fb.com>,
        <andriin@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/2] bpf: Add bpf_read_branch_records()
 helper
Message-Id: <C06T0N0N8TD7.1MBJSGUZDFW0A@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon Jan 27, 2020 at 1:26 PM, Daniel Borkmann wrote:
[...]
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index f1d74a2bd234..332aa433d045 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2892,6 +2892,25 @@ union bpf_attr {
> >    *		Obtain the 64bit jiffies
> >    *	Return
> >    *		The 64 bit jiffies
> > + *
> > + * int bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *=
buf, u32 buf_size, u64 flags)
>
>=20
> Small nit: s/buf_size/size/, so that it matches with your BPF_CALL
> below.

Ok

>=20
> +BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *,
> ctx,
> + void *, buf, u32, size, u64, flags)
>
>=20
> > + *	Description
> > + *		For an eBPF program attached to a perf event, retrieve the
> > + *		branch records (struct perf_branch_entry) associated to *ctx*
> > + *		and store it in	the buffer pointed by *buf* up to size
> > + *		*buf_size* bytes.
> > + *
> > + *		The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
> > + *		instead	return the number of bytes required to store all the
> > + *		branch entries. If this flag is set, *buf* may be NULL.
> > + *	Return
> > + *		On success, number of bytes written to *buf*. On error, a
> > + *		negative value.
>
>=20
> Maybe pull the 2nd paragraph from above in here so that it reflects the
> description
> of the return value when flag is used also for this case in the 'Return'
> description.

Ok.

[...]
> >  =20
> > +BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *,=
 ctx,
> > +	   void *, buf, u32, size, u64, flags)
> > +{
> > +#ifndef CONFIG_X86
> > +	return -ENOENT;
> > +#else
> > +	struct perf_branch_stack *br_stack =3D ctx->data->br_stack;
> > +	u32 br_entry_size =3D sizeof(struct perf_branch_entry);
>
>=20
> 'static const u32 br_entry_size' if we use it as such below.

Ok

>
>=20
> > +	u32 to_copy;
> > +
> > +	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
> > +		return -EINVAL;
> > +
> > +	if (unlikely(!br_stack))
> > +		return -EINVAL;
>
>=20
> Why the ifdef X86? In previous thread I meant to change it into since
> it's
> implicit:
>
>=20
> if (unlikely(!br_stack))
> return -ENOENT;
>
>=20
> Or is there any other additional rationale?

Yeah, so br_stack can be null if the perf_event is misconfigured (branch
record not enabled). So we need to differentiate that from arch not
supporting it.

[...]


Thanks,
Daniel
