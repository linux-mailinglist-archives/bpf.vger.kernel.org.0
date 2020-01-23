Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC3147269
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 21:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAWUJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 15:09:56 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49851 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726376AbgAWUJ4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 15:09:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E1396FE2;
        Thu, 23 Jan 2020 15:09:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 15:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:to:cc
        :subject:from:message-id; s=fm2; bh=Fx6i6i8fPfhX39tz6aS3wW1fdye2
        94FSopveLvGaxL8=; b=DIKyFurK+14DPG8oAvWmayIZP7goo70E6P87LOG1JI6d
        K9f9NbqxLOYTADNxwBALyOJRmWwww19GaRvP1Uoxj0hI3qxJ5pg14+hu8giYJX82
        ECJCaHYyDYcjpxpIUBevyYJGTXS5six9lwrLN+XlsNQaGk4QhcJI/G28DKlMN+3c
        EBYVLdA/30Hg2ZYaX4SS7oAEFTj+iL31z70nfaB56xjM7/ZC1GBbF4YaPCwwnJz2
        tSEn0tAoW77PT/cA6IaGyx1NLz169hOCxoxdHpadgcDLwer+OhTMrOiUanOzK05Y
        95atFsruDUo1O9f+/dv8HE7tRSsUtjN4XAP0FU4HOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Fx6i6i
        8fPfhX39tz6aS3wW1fdye294FSopveLvGaxL8=; b=yPnTQpoJX+16o4kNvlnX2N
        aq4qgKUgWamUbEQdQ9UJErHyK2H1oYzBvQbeYIvHsGIaSKQ39oFOhSBJZm9yBBtm
        UIg++ej5SJXJHqbIU6TdC2mZdjpC7NiNJ4O1cpTm+96//ROEbXwJSxxbaJEGmbJt
        pgHxXKBIjQuJSEjd9Ta74sWQhXX3tAYtzo8rCVYksKQ1TcRz10jEa7H/r3Iq+kRG
        9rA4G/w3oqBV6++KgqSbQlj0nn+vStJQT6pFXyP5UjTZvISKo3j+XfqS5kzi8Jk5
        eN6ocBi6q1RTcLNjEN+yEQMDrXPl5evtQD+5yCAxlt02eo07dAv0nHo4yl+QbqFA
        ==
X-ME-Sender: <xms:kf0pXhN-v-H3WFpHMDfYK8_cbM15SqTXhIhycPGoGRrUTe-dYdcr2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffvffuhffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeduleelrddvtddurdeigedrudefheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:kf0pXriP4zNB9tZbsXKgPmu1nMvjqXNi3cqoU0nBp9dC9w7FfS597g>
    <xmx:kf0pXv6LTrOObV4OiKHYcU2NvIJfTln1GtA_qn-oEk_TYngRulH0Ew>
    <xmx:kf0pXqcuE_Dq8fn364vkbV0jfnVpOlj_jlohNtZuLZFBhWh_FSJDGA>
    <xmx:kv0pXuhJpcqm1_4fEK9AjdfSxshuNRmrX8Q7qdddxwhENq69UQ4I7A>
Received: from localhost (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 942B43060AC0;
        Thu, 23 Jan 2020 15:09:52 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5e293189e298d_1bc42ab516c865b8a1@john-XPS-13-9370.notmuch>
Originaldate: Wed Jan 22, 2020 at 9:39 PM
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
 =?utf-8?q?dxuuu.xyz>=0D=0A>_---=0D=0A>__include/uapi/linux/bpf.h_|_13_+++?=
 =?utf-8?q?+++++++++-=0D=0A>__kernel/trace/bpf=5Ftrace.c_|_31_++++++++++++?=
 =?utf-8?q?+++++++++++++++++++=0D=0A>__2_files_changed,_43_insertions(+),_?=
 =?utf-8?q?1_deletion(-)=0D=0A>_=0D=0A>_diff_--git_a/include/uapi/linux/bp?=
 =?utf-8?q?f.h_b/include/uapi/linux/bpf.h=0D=0A>_index_033d90a2282d..7350c?=
 =?utf-8?q?5be6158_100644=0D=0A>_---_a/include/uapi/linux/bpf.h=0D=0A>_+++?=
 =?utf-8?q?_b/include/uapi/linux/bpf.h=0D=0A>_@@_-2885,6_+2885,16_@@_union?=
 =?utf-8?q?_bpf=5Fattr_{=0D=0A>___*=09=09**-EPERM**_if_no_permission_to_se?=
 =?utf-8?q?nd_the_*sig*.=0D=0A>___*=0D=0A>___*=09=09**-EAGAIN**_if_bpf_pro?=
 =?utf-8?q?gram_can_try_again.=0D=0A>_+_*=0D=0A>_+_*_int_bpf=5Fperf=5Fprog?=
 =?utf-8?q?=5Fread=5Fbranches(struct_bpf=5Fperf=5Fevent=5Fdata_*ctx,_void_?=
 =?utf-8?q?*buf,_u32_buf=5Fsize)=0D=0A>_+_*_=09Description=0D=0A>_+_*_=09?=
 =?utf-8?q?=09For_en_eBPF_program_attached_to_a_perf_event,_retrieve_the?=
 =?utf-8?q?=0D=0A>_+_*_=09=09branch_records_(struct_perf=5Fbranch=5Fentry)?=
 =?utf-8?q?_associated_to_*ctx*=0D=0A>_+_*_=09=09and_store_it_in=09the_buf?=
 =?utf-8?q?fer_pointed_by_*buf*_up_to_size=0D=0A>_+_*_=09=09*buf=5Fsize*_b?=
 =?utf-8?q?ytes.=0D=0A=0D=0AIt_seems_extra_bytes_in_buf_will_be_cleared._T?=
 =?utf-8?q?he_number_of_bytes=0D=0Acopied_is_returned_so_I_don't_see_any_r?=
 =?utf-8?q?eason_to_clear_the_extra_bytes_I_would=0D=0Ajust_let_the_BPF_pr?=
 =?utf-8?q?ogram_do_this_if_they_care._But_it_should_be_noted_in=0D=0Athe_?=
 =?utf-8?q?description_at_least.=0D=0A=0D=0A>_+_*_=09Return=0D=0A>_+_*=09?=
 =?utf-8?q?=09On_success,_number_of_bytes_written_to_*buf*._On_error,_a=0D?=
 =?utf-8?q?=0A>_+_*=09=09negative_value.=0D=0A>___*/=0D=0A>__#define_=5F?=
 =?utf-8?q?=5FBPF=5FFUNC=5FMAPPER(FN)=09=09\=0D=0A>__=09FN(unspec),=09=09?=
 =?utf-8?q?=09\=0D=0A>_@@_-3004,7_+3014,8_@@_union_bpf=5Fattr_{=0D=0A>__?=
 =?utf-8?q?=09FN(probe=5Fread=5Fuser=5Fstr),=09\=0D=0A>__=09FN(probe=5Frea?=
 =?utf-8?q?d=5Fkernel=5Fstr),=09\=0D=0A>__=09FN(tcp=5Fsend=5Fack),=09=09\?=
 =?utf-8?q?=0D=0A>_-=09FN(send=5Fsignal=5Fthread),=0D=0A>_+=09FN(send=5Fsi?=
 =?utf-8?q?gnal=5Fthread),=09=09\=0D=0A>_+=09FN(perf=5Fprog=5Fread=5Fbranc?=
 =?utf-8?q?hes),=0D=0A>__=0D=0A>__/*_integer_value_in_'imm'_field_of_BPF?=
 =?utf-8?q?=5FCALL_instruction_selects_which_helper=0D=0A>___*_function_eB?=
 =?utf-8?q?PF_program_intends_to_call=0D=0A>_diff_--git_a/kernel/trace/bpf?=
 =?utf-8?q?=5Ftrace.c_b/kernel/trace/bpf=5Ftrace.c=0D=0A>_index_19e793aa44?=
 =?utf-8?q?1a..24c51272a1f7_100644=0D=0A>_---_a/kernel/trace/bpf=5Ftrace.c?=
 =?utf-8?q?=0D=0A>_+++_b/kernel/trace/bpf=5Ftrace.c=0D=0A>_@@_-1028,6_+102?=
 =?utf-8?q?8,35_@@_static_const_struct_bpf=5Ffunc=5Fproto_bpf=5Fperf=5Fpro?=
 =?utf-8?q?g=5Fread=5Fvalue=5Fproto_=3D_{=0D=0A>___________.arg3=5Ftype___?=
 =?utf-8?q?___=3D_ARG=5FCONST=5FSIZE,=0D=0A>__};=0D=0A>__=0D=0A>_+BPF=5FCA?=
 =?utf-8?q?LL=5F3(bpf=5Fperf=5Fprog=5Fread=5Fbranches,_struct_bpf=5Fperf?=
 =?utf-8?q?=5Fevent=5Fdata=5Fkern_*,_ctx,=0D=0A>_+=09___void_*,_buf,_u32,_?=
 =?utf-8?q?size)=0D=0A>_+{=0D=0A>_+=09struct_perf=5Fbranch=5Fstack_*br=5Fs?=
 =?utf-8?q?tack_=3D_ctx->data->br=5Fstack;=0D=0A>_+=09u32_to=5Fcopy_=3D_0,?=
 =?utf-8?q?_to=5Fclear_=3D_size;=0D=0A>_+=09int_err_=3D_-EINVAL;=0D=0A>_+?=
 =?utf-8?q?=0D=0A>_+=09if_(unlikely(!br=5Fstack))=0D=0A>_+=09=09goto_clear?=
 =?utf-8?q?;=0D=0A>_+=0D=0A>_+=09to=5Fcopy_=3D_min=5Ft(u32,_br=5Fstack->nr?=
 =?utf-8?q?_*_sizeof(struct_perf=5Fbranch=5Fentry),_size);=0D=0A>_+=09to?=
 =?utf-8?q?=5Fclear_-=3D_to=5Fcopy;=0D=0A>_+=0D=0A>_+=09memcpy(buf,_br=5Fs?=
 =?utf-8?q?tack->entries,_to=5Fcopy);=0D=0A>_+=09err_=3D_to=5Fcopy;=0D=0A>?=
 =?utf-8?q?_+clear:=0D=0A>_+=09memset(buf_+_to=5Fcopy,_0,_to=5Fclear);=0D?=
 =?utf-8?q?=0A=0D=0AHere,_why_do_this_at_all=3F_If_the_user_cares_they_can?=
 =?utf-8?q?_clear_the_bytes=0D=0Adirectly_from_the_BPF_program._I_suspect_?=
 =?utf-8?q?its_probably_going_to_be=0D=0Awasted_work_in_most_cases._If_its?=
 =?utf-8?q?_needed_for_some_reason_provide_=0D=0Aa_comment_with_it.=0D=0A?=
 =?utf-8?q?=0D=0A>_+=09return_err;=0D=0A>_+}=0D=0A=0D=0A[...]=0D=0A?=
Date:   Thu, 23 Jan 2020 12:09:51 -0800
To:     "John Fastabend" <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <songliubraving@fb.com>,
        <yhs@fb.com>, <andriin@fb.com>
Cc:     "Daniel Xu" <dxu@dxuuu.xyz>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>
Subject: RE: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Message-Id: <C03FZ2ZXKIY9.21PQ3FP3MQYU7@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi John, thanks for looking.

On Wed Jan 22, 2020 at 9:39 PM, John Fastabend wrote:
[...]
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 033d90a2282d..7350c5be6158 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2885,6 +2885,16 @@ union bpf_attr {
> >   *		**-EPERM** if no permission to send the *sig*.
> >   *
> >   *		**-EAGAIN** if bpf program can try again.
> > + *
> > + * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, vo=
id *buf, u32 buf_size)
> > + * 	Description
> > + * 		For en eBPF program attached to a perf event, retrieve the
> > + * 		branch records (struct perf_branch_entry) associated to *ctx*
> > + * 		and store it in	the buffer pointed by *buf* up to size
> > + * 		*buf_size* bytes.
>
>=20
> It seems extra bytes in buf will be cleared. The number of bytes
> copied is returned so I don't see any reason to clear the extra bytes I
> would
> just let the BPF program do this if they care. But it should be noted in
> the description at least.

In include/linux/bpf.h:

        /* the following constraints used to prototype bpf_memcmp() and oth=
er
         * functions that access data on eBPF program stack
         */
        ARG_PTR_TO_UNINIT_MEM,  /* pointer to memory does not need to be in=
itialized,
                                 * helper function must fill all bytes or c=
lear
                                 * them in error case.
                                 */

I figured it would be good to clear out the stack b/c this helper
writes data on program stack.

Also bpf_perf_prog_read_value() does something similar (fill zeros on
failure).

[...]
> > +	to_copy =3D min_t(u32, br_stack->nr * sizeof(struct perf_branch_entry=
), size);
> > +	to_clear -=3D to_copy;
> > +
> > +	memcpy(buf, br_stack->entries, to_copy);
> > +	err =3D to_copy;
> > +clear:
> > +	memset(buf + to_copy, 0, to_clear);
>
>=20
> Here, why do this at all? If the user cares they can clear the bytes
> directly from the BPF program. I suspect its probably going to be
> wasted work in most cases. If its needed for some reason provide
> a comment with it.

Same concern as above, right?

I can send a V3 with updated uapi/linux/bpf.h description (and a rebase).

Thanks,
Daniel
