Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6A1476E8
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 03:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgAXCK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 21:10:57 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:53065 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729340AbgAXCK5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 21:10:57 -0500
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jan 2020 21:10:56 EST
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6D4AE6BD;
        Thu, 23 Jan 2020 21:03:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 21:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:from:to
        :cc:subject:message-id; s=fm2; bh=OEz4+RCDU6xykSm4CpSsz/bSSvUb6X
        X2MDtraBSSMjA=; b=MJxKOdjwnB4FW56ItQWAVGJnFOVWBnngp1eswClYxcwuMT
        icTntoofCOGcEDXY/Hd8x3A5brWdgU006gX+Ti2QRS0LdD7Z5Z7L8dtR3QTC6GAE
        d6zyWOUJ4af9kwrDBYWL83N15cpyDWXFAUIAUbHy17nrfsv9tN6laNWVK4e9OmKl
        2O2G4QrFcB0A/nuZPLY67UjRVi0SvQPucrNeJxLspgq2YPycPQZZO16CFU/dpdd/
        uiBAt+4CGQOATEe8aWl7wBwoHS5/odbtEkmVzLVLFT9VHHPzmnYh1e2DnVD/KWNt
        yaus5OgFJ++WvBF+NIfavbxJxdmphKUqgIIbpHVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OEz4+R
        CDU6xykSm4CpSsz/bSSvUb6XX2MDtraBSSMjA=; b=Y/78Phx7BNAyIcA2Y4RoNC
        vW1hOPftfapme1boLJbN8BAZ+9+yqmBuEIjjFCA9tx8SWCxQRyPhZTcjat9UXZGq
        vRHXmEPx3L42r4sdafYxtTjZ6THTGSqw/m2g+2XXsfAXARg3J0r1QMg8rukim4FN
        6Kaq+0VDyBDdgAIR1bFN8c2SelTKb85rHz57iCCvQl5MuBPDraVQ5uOFGb+vDj/s
        haQSymjaCdv2fvvbzolNSwU6+05/xM/GIm5I+o2EB60Rn0zT8qUNtKYPM1iGLfjH
        LcwyZTPT16SmXEFbzcpNZXVPZA+h1B+JD7gQnSr6PqMWHxxBMkV2ha8E9KhhQbIQ
        ==
X-ME-Sender: <xms:VFAqXs5y2dL3pjqwKPwod946ujPMDCDlLklheyEj61KNnH3Zk8svMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdefgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffhffvuffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeduleelrddvtddurdeigedrudefheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:VFAqXqlBTauV6qcfau2M3O33pj03WQYdI45sdJTIVWlQApUscoiiWg>
    <xmx:VFAqXvWtnOiaj8wfi5wANHAdlpEbcTqiwouzvmRfybl_lg4A9k2m1g>
    <xmx:VFAqXrQiokBIvdct4W3y7qbePHfhvJEtjDRm7YtVm9_gil6fwx5Mcg>
    <xmx:VlAqXsM51J0WkeKmROLAA0j22NP2MPlB9il-2-rIMWR3CNBN20xznMvE_J8>
Received: from localhost (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 879D53060B1C;
        Thu, 23 Jan 2020 21:02:59 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Thu Jan 23, 2020 at 4:49 PM
Originalfrom: "John Fastabend" <john.fastabend@gmail.com>
Original: =?utf-8?q?Daniel_Xu_wrote:
 =0D=0A>_Branch_records_are_a_CPU_feature_that_c?=
 =?utf-8?q?an_be_configured_to_record=0D=0A>_certain_branches_that_are_tak?=
 =?utf-8?q?en_during_code_execution._This_data_is=0D=0A>_particularly_inte?=
 =?utf-8?q?resting_for_profile_guided_optimizations._perf_has_had=0D=0A>_b?=
 =?utf-8?q?ranch_record_support_for_a_while_but_the_data_collection_can_be?=
 =?utf-8?q?_a_bit=0D=0A>_coarse_grained.=0D=0A>_=0D=0A>_We_(Facebook)_have?=
 =?utf-8?q?_seen_in_experiments_that_associating_metadata_with=0D=0A>_bran?=
 =?utf-8?q?ch_records_can_improve_results_(after_postprocessing)._We_gener?=
 =?utf-8?q?ally=0D=0A>_use_bpf=5Fprobe=5Fread=5F*()_to_get_metadata_out_of?=
 =?utf-8?q?_userspace._That's_why_bpf=0D=0A>_support_for_branch_records_is?=
 =?utf-8?q?_useful.=0D=0A>_=0D=0A>_Aside_from_this_particular_use_case,_ha?=
 =?utf-8?q?ving_branch_data_available_to_bpf=0D=0A>_progs_can_be_useful_to?=
 =?utf-8?q?_get_stack_traces_out_of_userspace_applications=0D=0A>_that_omi?=
 =?utf-8?q?t_frame_pointers.=0D=0A>_=0D=0A>_Signed-off-by:_Daniel_Xu_<dxu@?=
 =?utf-8?q?dxuuu.xyz>=0D=0A>_---=0D=0A>__include/uapi/linux/bpf.h_|_15_+++?=
 =?utf-8?q?+++++++++++-=0D=0A>__kernel/trace/bpf=5Ftrace.c_|_31_++++++++++?=
 =?utf-8?q?+++++++++++++++++++++=0D=0A>__2_files_changed,_45_insertions(+)?=
 =?utf-8?q?,_1_deletion(-)=0D=0A>_=0D=0A=0D=0A[...]=0D=0A=0D=0A>___*_funct?=
 =?utf-8?q?ion_eBPF_program_intends_to_call=0D=0A>_diff_--git_a/kernel/tra?=
 =?utf-8?q?ce/bpf=5Ftrace.c_b/kernel/trace/bpf=5Ftrace.c=0D=0A>_index_19e7?=
 =?utf-8?q?93aa441a..24c51272a1f7_100644=0D=0A>_---_a/kernel/trace/bpf=5Ft?=
 =?utf-8?q?race.c=0D=0A>_+++_b/kernel/trace/bpf=5Ftrace.c=0D=0A>_@@_-1028,?=
 =?utf-8?q?6_+1028,35_@@_static_const_struct_bpf=5Ffunc=5Fproto_bpf=5Fperf?=
 =?utf-8?q?=5Fprog=5Fread=5Fvalue=5Fproto_=3D_{=0D=0A>___________.arg3=5Ft?=
 =?utf-8?q?ype______=3D_ARG=5FCONST=5FSIZE,=0D=0A>__};=0D=0A>__=0D=0A>_+BP?=
 =?utf-8?q?F=5FCALL=5F3(bpf=5Fperf=5Fprog=5Fread=5Fbranches,_struct_bpf=5F?=
 =?utf-8?q?perf=5Fevent=5Fdata=5Fkern_*,_ctx,=0D=0A>_+=09___void_*,_buf,_u?=
 =?utf-8?q?32,_size)=0D=0A>_+{=0D=0A>_+=09struct_perf=5Fbranch=5Fstack_*br?=
 =?utf-8?q?=5Fstack_=3D_ctx->data->br=5Fstack;=0D=0A>_+=09u32_to=5Fcopy_?=
 =?utf-8?q?=3D_0,_to=5Fclear_=3D_size;=0D=0A>_+=09int_err_=3D_-EINVAL;=0D?=
 =?utf-8?q?=0A>_+=0D=0A>_+=09if_(unlikely(!br=5Fstack))=0D=0A>_+=09=09goto?=
 =?utf-8?q?_clear;=0D=0A>_+=0D=0A>_+=09to=5Fcopy_=3D_min=5Ft(u32,_br=5Fsta?=
 =?utf-8?q?ck->nr_*_sizeof(struct_perf=5Fbranch=5Fentry),_size);=0D=0A>_+?=
 =?utf-8?q?=09to=5Fclear_-=3D_to=5Fcopy;=0D=0A>_+=0D=0A>_+=09memcpy(buf,_b?=
 =?utf-8?q?r=5Fstack->entries,_to=5Fcopy);=0D=0A>_+=09err_=3D_to=5Fcopy;?=
 =?utf-8?q?=0D=0A>_+clear:=0D=0A=0D=0AThere_appears_to_be_agreement_to_cle?=
 =?utf-8?q?ar_the_extra_buffer_on_error_but_what_about=0D=0Ain_the_non-err?=
 =?utf-8?q?or_case=3F_I_expect_one_usage_pattern_is_to_submit_a_fairly_lar?=
 =?utf-8?q?ge=0D=0Abuffer,_large_enough_to_handle_worse_case_nr,_in_this_c?=
 =?utf-8?q?ase_we_end_up_zero'ing=0D=0Amemory_even_in_the_succesful_case._?=
 =?utf-8?q?Can_we_skip_the_clear_in_this_case=3F_Maybe=0D=0Aits_not_too_im?=
 =?utf-8?q?portant_either_way_but_seems_unnecessary.=0D=0A=0D=0A>_+=09mems?=
 =?utf-8?q?et(buf_+_to=5Fcopy,_0,_to=5Fclear);=0D=0A>_+=09return_err;=0D?=
 =?utf-8?q?=0A>_+}=0D=0A?=
In-Reply-To: <5e2a3f00a996a_7f9e2ab8c3f9e5c4a6@john-XPS-13-9370.notmuch>
Date:   Thu, 23 Jan 2020 18:02:58 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "John Fastabend" <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <songliubraving@fb.com>,
        <yhs@fb.com>, <andriin@fb.com>
Cc:     "Daniel Xu" <dxu@dxuuu.xyz>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>
Subject: RE: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Message-Id: <C03NHG5CJ6QU.2ZCQR4TKW3ZWN@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Jan 23, 2020 at 4:49 PM, John Fastabend wrote:
[...]
> >   * function eBPF program intends to call
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 19e793aa441a..24c51272a1f7 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1028,6 +1028,35 @@ static const struct bpf_func_proto bpf_perf_prog=
_read_value_proto =3D {
> >           .arg3_type      =3D ARG_CONST_SIZE,
> >  };
> > =20
> > +BPF_CALL_3(bpf_perf_prog_read_branches, struct bpf_perf_event_data_ker=
n *, ctx,
> > +	   void *, buf, u32, size)
> > +{
> > +	struct perf_branch_stack *br_stack =3D ctx->data->br_stack;
> > +	u32 to_copy =3D 0, to_clear =3D size;
> > +	int err =3D -EINVAL;
> > +
> > +	if (unlikely(!br_stack))
> > +		goto clear;
> > +
> > +	to_copy =3D min_t(u32, br_stack->nr * sizeof(struct perf_branch_entry=
), size);
> > +	to_clear -=3D to_copy;
> > +
> > +	memcpy(buf, br_stack->entries, to_copy);
> > +	err =3D to_copy;
> > +clear:
>
>=20
> There appears to be agreement to clear the extra buffer on error but
> what about
> in the non-error case? I expect one usage pattern is to submit a fairly
> large
> buffer, large enough to handle worse case nr, in this case we end up
> zero'ing
> memory even in the succesful case. Can we skip the clear in this case?
> Maybe
> its not too important either way but seems unnecessary.
>
>=20
> > +	memset(buf + to_copy, 0, to_clear);
> > +	return err;
> > +}
>

Given Yonghong's suggestion of a flag argument, we need to allow users
to pass in a null ptr while getting buffer size. So I'll change the `buf`
argument to be ARG_PTR_TO_MEM_OR_NULL, which requires the buffer be
initialized. We can skip zero'ing out altogether.

Although I think the end result is the same -- now the user has to zero it
out. Unfortunately ARG_PTR_TO_UNINITIALIZED_MEM_OR_NULL is not
implemented yet.
