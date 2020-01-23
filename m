Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5AD1473D4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 23:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAWWaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 17:30:05 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37115 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729277AbgAWWaF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 17:30:05 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 529236DA7;
        Thu, 23 Jan 2020 17:30:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 17:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=8OCe30WvshaBm1sTu3I3fp+WO
        HU1CNUX+kVYUw7axmE=; b=kcThdyB2/Bpr+fK13iAEZg7o/CqiwodWl4v7QAAme
        M0FlA9OaHkrPuDkN9cd+8l+BUU7S4UHtfgNEx4P560zVysw+WanbllbBoMtRrwF3
        /1Kqi6VMz7Yqg0qxzp0kA8N39uYjhUcGvduuH+MiilWZsn9l2lz1q1RlcCNf1aL7
        tCGULz+LQRf1iPrCL46GDBY9ZcIZrsHLA8oc8k9wNZR991Sq6BYLacOSd84b6fT9
        czKt8NbKAjNbA40dKlXlVo5QGFpaTOwVU9/5/w+52b52/E+MCu2uPxrxaJ87s9Tz
        mdhEuf06gbjf8dwinNMnt2NTHnSiIY5B9fcz3K4TIPImg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8OCe30
        WvshaBm1sTu3I3fp+WOHU1CNUX+kVYUw7axmE=; b=Zc8tm8E+KpSepF0kOHXUvb
        2HVkj3U+6Ee/WN98wdmCO1zb9BIypapJ4HZAXMlcLI1Q5ZdA6eRo6HRebQbfq7Q6
        AxASYlo8rlbOyP67ycH7XJDY9ypQifW3x1f19HDV6paGKFS9ieBMaSE27PYGtH2K
        73NTxjqc69Rn3Shv3lcBjnmKPGD9ajssSPdpBWYo+mzgZmQ0SULvDE8msjm7AeQw
        Q1o5ACaQNj0fu91y0sDnvhK7eDoHr9mI278ZQq++k5DF2Vy5PJLuKVyUFDF/cauK
        lCqBS0YRJM2ZIqKEcxITbvoW1BU0JlTc3BYkwnf3Ll/3pO9eOZTfQaY3603svnXw
        ==
X-ME-Sender: <xms:ax4qXg_WwomWaJu1cmg7iQg5OWQChWtOCF1OrZVZoh_4dAcWw6rdDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeduleelrddvtddurdeigedrudefheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ax4qXtYX-1TiK_gx2Iz6v2cKToCH4bCD8HJi2Jv1M4vClR7DIsip4g>
    <xmx:ax4qXi2Gix8m17Zs51nVMBX3ScHL5havFZSJE90Lkdv4tpPSlafQyg>
    <xmx:ax4qXtUC670Um6iLiXYhuXNvj6m-6wRR9t9f7FKIKYueS8PtaMTsjQ>
    <xmx:bB4qXnFJ-NF_YNDL69ciZjuqhh7kebsCgc_kBsoVzXiliCEbwYCSHA>
Received: from localhost (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 033D13280060;
        Thu, 23 Jan 2020 17:30:00 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Thu Jan 23, 2020 at 11:23 PM
Originalfrom: "Daniel Borkmann" <daniel@iogearbox.net>
Original: =?utf-8?q?On_1/23/20_9:09_PM,_Daniel_Xu_wrote:
 =0D=0A>_Hi_John,_thanks_for?= =?utf-8?q?_looking.=0D=0A>_
 =0D=0A>_On_Wed_Jan_22,_2020_at_9:39_PM,_John_F?=
 =?utf-8?q?astabend_wrote:
 =0D=0A>_[...]=0D=0A>>>_diff_--git_a/include/uapi?=
 =?utf-8?q?/linux/bpf.h_b/include/uapi/linux/bpf.h=0D=0A>>>_index_033d90a2?=
 =?utf-8?q?282d..7350c5be6158_100644=0D=0A>>>_---_a/include/uapi/linux/bpf?=
 =?utf-8?q?.h=0D=0A>>>_+++_b/include/uapi/linux/bpf.h=0D=0A>>>_@@_-2885,6_?=
 =?utf-8?q?+2885,16_@@_union_bpf=5Fattr_{=0D=0A>>>____*=09=09**-EPERM**_if?=
 =?utf-8?q?_no_permission_to_send_the_*sig*.=0D=0A>>>____*=0D=0A>>>____*?=
 =?utf-8?q?=09=09**-EAGAIN**_if_bpf_program_can_try_again.=0D=0A>>>_+_*=0D?=
 =?utf-8?q?=0A>>>_+_*_int_bpf=5Fperf=5Fprog=5Fread=5Fbranches(struct_bpf?=
 =?utf-8?q?=5Fperf=5Fevent=5Fdata_*ctx,_void_*buf,_u32_buf=5Fsize)=0D=0A>>?=
 =?utf-8?q?>_+_*_=09Description=0D=0A>>>_+_*_=09=09For_en_eBPF_program_att?=
 =?utf-8?q?ached_to_a_perf_event,_retrieve_the=0D=0A>>>_+_*_=09=09branch_r?=
 =?utf-8?q?ecords_(struct_perf=5Fbranch=5Fentry)_associated_to_*ctx*=0D=0A?=
 =?utf-8?q?>>>_+_*_=09=09and_store_it_in=09the_buffer_pointed_by_*buf*_up_?=
 =?utf-8?q?to_size=0D=0A>>>_+_*_=09=09*buf=5Fsize*_bytes.=0D=0A>>=0D=0A>>_?=
 =?utf-8?q?It_seems_extra_bytes_in_buf_will_be_cleared._The_number_of_byte?=
 =?utf-8?q?s=0D=0A>>_copied_is_returned_so_I_don't_see_any_reason_to_clear?=
 =?utf-8?q?_the_extra_bytes_I=0D=0A>>_would=0D=0A>>_just_let_the_BPF_progr?=
 =?utf-8?q?am_do_this_if_they_care._But_it_should_be_noted_in=0D=0A>>_the_?=
 =?utf-8?q?description_at_least.=0D=0A>_=0D=0A>_In_include/linux/bpf.h:=0D?=
 =?utf-8?q?=0A>_=0D=0A>__________/*_the_following_constraints_used_to_prot?=
 =?utf-8?q?otype_bpf=5Fmemcmp()_and_other=0D=0A>___________*_functions_tha?=
 =?utf-8?q?t_access_data_on_eBPF_program_stack=0D=0A>___________*/=0D=0A>_?=
 =?utf-8?q?_________ARG=5FPTR=5FTO=5FUNINIT=5FMEM,__/*_pointer_to_memory_d?=
 =?utf-8?q?oes_not_need_to_be_initialized,=0D=0A>_________________________?=
 =?utf-8?q?__________*_helper_function_must_fill_all_bytes_or_clear=0D=0A>?=
 =?utf-8?q?___________________________________*_them_in_error_case.=0D=0A>?=
 =?utf-8?q?___________________________________*/=0D=0A>_=0D=0A>_I_figured_?=
 =?utf-8?q?it_would_be_good_to_clear_out_the_stack_b/c_this_helper=0D=0A>_?=
 =?utf-8?q?writes_data_on_program_stack.=0D=0A>_=0D=0A>_Also_bpf=5Fperf=5F?=
 =?utf-8?q?prog=5Fread=5Fvalue()_does_something_similar_(fill_zeros_on=0D?=
 =?utf-8?q?=0A>_failure).=0D=0A>_=0D=0A>_[...]=0D=0A>>>_+=09to=5Fcopy_=3D_?=
 =?utf-8?q?min=5Ft(u32,_br=5Fstack->nr_*_sizeof(struct_perf=5Fbranch=5Fent?=
 =?utf-8?q?ry),_size);=0D=0A>>>_+=09to=5Fclear_-=3D_to=5Fcopy;=0D=0A>>>_+?=
 =?utf-8?q?=0D=0A>>>_+=09memcpy(buf,_br=5Fstack->entries,_to=5Fcopy);=0D?=
 =?utf-8?q?=0A>>>_+=09err_=3D_to=5Fcopy;=0D=0A>>>_+clear:=0D=0A>>>_+=09mem?=
 =?utf-8?q?set(buf_+_to=5Fcopy,_0,_to=5Fclear);=0D=0A>>=0D=0A>>=0D=0A>>_He?=
 =?utf-8?q?re,_why_do_this_at_all=3F_If_the_user_cares_they_can_clear_the_?=
 =?utf-8?q?bytes=0D=0A>>_directly_from_the_BPF_program._I_suspect_its_prob?=
 =?utf-8?q?ably_going_to_be=0D=0A>>_wasted_work_in_most_cases._If_its_need?=
 =?utf-8?q?ed_for_some_reason_provide=0D=0A>>_a_comment_with_it.=0D=0A>_?=
 =?utf-8?q?=0D=0A>_Same_concern_as_above,_right=3F=0D=0A=0D=0AYes,_so_we'v?=
 =?utf-8?q?e_been_following_this_practice_for_all_the_BPF_helpers_no_matte?=
 =?utf-8?q?r=0D=0Awhich_program_type._Though_for_tracing_it_may_be_up_to_d?=
 =?utf-8?q?ebate_whether_it_makes=0D=0Astill_sense_given_there's_nothing_t?=
 =?utf-8?q?o_be_leaked_here_since_you_can_read_this_data=0D=0Aanyway_via_p?=
 =?utf-8?q?robe_read_if_you'd_wanted_to._So_we_might_as_well_get_rid_of_th?=
 =?utf-8?q?e=0D=0Aclearing_for_all_tracing_helpers.=0D=0A=0D=0ADifferent_q?=
 =?utf-8?q?uestion_related_to_your_set._It_looks_like_br=5Fstack_is_only_a?=
 =?utf-8?q?vailable=0D=0Aon_x86,_is_that_correct=3F_For_other_archs_this_w?=
 =?utf-8?q?ill_always_bail_out_on_!br=5Fstack=0D=0Atest._Perhaps_we_should?=
 =?utf-8?q?_document_this_fact_so_users_are_not_surprised_why_their=0D=0Ap?=
 =?utf-8?q?rog_using_this_helper_is_not_working_on_!x86._Wdyt=3F=0D=0A=0D?=
 =?utf-8?q?=0AThanks,=0D=0ADaniel=0D=0A=0D=0A?=
In-Reply-To: <297f40e7-667b-63ea-c7d7-6d03a636c4c7@iogearbox.net>
Date:   Thu, 23 Jan 2020 14:30:00 -0800
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Borkmann" <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <songliubraving@fb.com>, <yhs@fb.com>,
        <andriin@fb.com>
Message-Id: <C03IYDPABSU1.1C6OL4DJ7ID1H@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Jan 23, 2020 at 11:23 PM, Daniel Borkmann wrote:
[...]
>=20
> Yes, so we've been following this practice for all the BPF helpers no
> matter
> which program type. Though for tracing it may be up to debate whether it
> makes
> still sense given there's nothing to be leaked here since you can read
> this data
> anyway via probe read if you'd wanted to. So we might as well get rid of
> the
> clearing for all tracing helpers.

Right, that makes sense. Do you want me to leave it in for this patchset
and then remove all of them in a followup patchset?

>=20
> Different question related to your set. It looks like br_stack is only
> available
> on x86, is that correct? For other archs this will always bail out on
> !br_stack
> test. Perhaps we should document this fact so users are not surprised
> why their
> prog using this helper is not working on !x86. Wdyt?

I think perf_event_open() should fail on !x86 if a user tries to configure
it with branch stack collection. So there would not be the opportunity for
the bpf prog to be attached and run. I haven't tested this, though. I'll
look through the code / install a VM and test it.

[...]

Thanks,
Daniel
