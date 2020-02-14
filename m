Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82EE15D233
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 07:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgBNGfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 01:35:05 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:37939 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgBNGfE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Feb 2020 01:35:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 746EFB0B;
        Fri, 14 Feb 2020 01:35:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Feb 2020 01:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:from:to
        :cc:subject:message-id; s=fm2; bh=EcBAKpkzUfZmtQUv/xOSmOq1Sve95J
        yK7cR+M/QSPUk=; b=sRAC5GxIt8fI8LBN4fcEoXLAx8RZdwwQYMUSWj0UgYWVQ4
        7iLRiwPmqE8Du8yEET2ho5FFsm9KR5rI9TxKpONdgnUnVB5tHa/nlUk4lsfwirJG
        jHq3m7+aS+hulWtbBcc3SK0JtmswRqT+3N3SZMhqwwo3psvoGZaMVzuMR38BtAnT
        RruQRN8YeM57u0CFD0tMQGhjd64sFMUvlrX2kESmh8CzAfcMqTSNRcIzwG0XcjVw
        LOKu4tJc93k9iiqBrSNfa+tZUZsQC6OwPLALjV6T6OyGcGOYZv7HjK73yfgfs9yP
        aEp20hDa5VGceKZFcpZ3Rg4P/WIS4VtqomWPirGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EcBAKp
        kzUfZmtQUv/xOSmOq1Sve95JyK7cR+M/QSPUk=; b=LExUndLL9dXfESi7Tft11J
        n0HHMBX9iZkz9HYx4FsKeUovZWRh1d3YLYtG8sSO6HkNT790mMV0nwNDk0Ni81+B
        aRGUCnqzp7W0f9OPaos2b+djimjwzaJ1kzEHoHK1mPeR4kOXsbblpOq8lhnh0EBm
        tqmAel3Zl5YKE4BWJd9Q0uL/go+roZQWMYh41dPNSAXDVIv4hLvtjtIyzpDMo/I3
        QkXA1FgtMyLjvUKQNy11nh+wNRiqmjMgN42rlYUznYOBqdYRcWSecSDK/bY7EvJQ
        Oq0xCWOF207O9+vJsVYafp6X4gzAqxwoypz5m0UWqlzrOCPwKWUdwtCAlYtEZLPA
        ==
X-ME-Sender: <xms:lT9GXlCmBH6kRQPTWP7ImMfe7OVaBcDrut-oYsH_rlAo_Pt7TiCApA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffhffvuffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:lT9GXhf5AK-wbrIsflCRCX7viDy4YmeznMo6FKo_R43FJyo0PTChTw>
    <xmx:lT9GXoI2L-AhQKuJinfTKbUtukc-G1hNPyJypKwAdWvY60me3x7zmg>
    <xmx:lT9GXsfsgnhUq3e0huaswN7DLwiqQ0K4Xh9d-jUOjbuTPrazZoWbGw>
    <xmx:lj9GXr45Bj-dDwG4xfCIA1lwrQ-UykhSu6ZtfaNa6-e_8bJ1LsjZJivtoWc>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 093F33280064;
        Fri, 14 Feb 2020 01:34:57 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Original: =?utf-8?q?On_Mon,_Feb_10,_2020_at_12:09_PM_Daniel_Xu_<dxu@dxuuu.xyz>_wrot?=
 =?utf-8?q?e:=0D=0A>=0D=0A>_Branch_records_are_a_CPU_feature_that_can_be_c?=
 =?utf-8?q?onfigured_to_record=0D=0A>_certain_branches_that_are_taken_duri?=
 =?utf-8?q?ng_code_execution._This_data_is=0D=0A>_particularly_interesting?=
 =?utf-8?q?_for_profile_guided_optimizations._perf_has_had=0D=0A>_branch_r?=
 =?utf-8?q?ecord_support_for_a_while_but_the_data_collection_can_be_a_bit?=
 =?utf-8?q?=0D=0A>_coarse_grained.=0D=0A>=0D=0A>_We_(Facebook)_have_seen_i?=
 =?utf-8?q?n_experiments_that_associating_metadata_with=0D=0A>_branch_reco?=
 =?utf-8?q?rds_can_improve_results_(after_postprocessing)._We_generally=0D?=
 =?utf-8?q?=0A>_use_bpf=5Fprobe=5Fread=5F*()_to_get_metadata_out_of_usersp?=
 =?utf-8?q?ace._That's_why_bpf=0D=0A>_support_for_branch_records_is_useful?=
 =?utf-8?q?.=0D=0A>=0D=0A>_Aside_from_this_particular_use_case,_having_bra?=
 =?utf-8?q?nch_data_available_to_bpf=0D=0A>_progs_can_be_useful_to_get_sta?=
 =?utf-8?q?ck_traces_out_of_userspace_applications=0D=0A>_that_omit_frame_?=
 =?utf-8?q?pointers.=0D=0A>=0D=0A>_Signed-off-by:_Daniel_Xu_<dxu@dxuuu.xyz?=
 =?utf-8?q?>=0D=0A>_---=0D=0A=0D=0ALGTM,_one_typo_in_description_of_the_he?=
 =?utf-8?q?lper._bpf-next_is_still_closed,=0D=0Abtw,_but_should_hopefully_?=
 =?utf-8?q?open_soon.=0D=0A=0D=0AAcked-by:_Andrii_Nakryiko_<andriin@fb.com?=
 =?utf-8?q?>=0D=0A=0D=0A>__include/uapi/linux/bpf.h_|_25_+++++++++++++++++?=
 =?utf-8?q?++++++-=0D=0A>__kernel/trace/bpf=5Ftrace.c_|_41_+++++++++++++++?=
 =?utf-8?q?+++++++++++++++++++++++++=0D=0A>__2_files_changed,_65_insertion?=
 =?utf-8?q?s(+),_1_deletion(-)=0D=0A>=0D=0A>_diff_--git_a/include/uapi/lin?=
 =?utf-8?q?ux/bpf.h_b/include/uapi/linux/bpf.h=0D=0A>_index_f1d74a2bd234..?=
 =?utf-8?q?3004470b7269_100644=0D=0A>_---_a/include/uapi/linux/bpf.h=0D=0A?=
 =?utf-8?q?>_+++_b/include/uapi/linux/bpf.h=0D=0A>_@@_-2892,6_+2892,25_@@_?=
 =?utf-8?q?union_bpf=5Fattr_{=0D=0A>___*_____________Obtain_the_64bit_jiff?=
 =?utf-8?q?ies=0D=0A>___*_____Return=0D=0A>___*_____________The_64_bit_jif?=
 =?utf-8?q?fies=0D=0A>_+_*=0D=0A>_+_*_int_bpf=5Fread=5Fbranch=5Frecords(st?=
 =?utf-8?q?ruct_bpf=5Fperf=5Fevent=5Fdata_*ctx,_void_*buf,_u32_size,_u64_f?=
 =?utf-8?q?lags)=0D=0A>_+_*_____Description=0D=0A>_+_*_____________For_an_?=
 =?utf-8?q?eBPF_program_attached_to_a_perf_event,_retrieve_the=0D=0A>_+_*_?=
 =?utf-8?q?____________branch_records_(struct_perf=5Fbranch=5Fentry)_assoc?=
 =?utf-8?q?iated_to_*ctx*=0D=0A>_+_*_____________and_store_it_in_the_buffe?=
 =?utf-8?q?r_pointed_by_*buf*_up_to_size=0D=0A>_+_*_____________*buf=5Fsiz?=
 =?utf-8?q?e*_bytes.=0D=0A>_+_*_____Return=0D=0A>_+_*_____________On_succe?=
 =?utf-8?q?ss,_number_of_bytes_written_to_*buf*._On_error,_a=0D=0A>_+_*___?=
 =?utf-8?q?__________negative_value.=0D=0A>_+_*=0D=0A>_+_*_____________The?=
 =?utf-8?q?_*flags*_can_be_set_to_**BPF=5FF=5FGET=5FBRANCH=5FRECORDS=5FSIZ?=
 =?utf-8?q?E**_to=0D=0A>_+_*_____________instead_return_the_number_of_byte?=
 =?utf-8?q?s_required_to_store_all_the=0D=0A>_+_*_____________branch_entri?=
 =?utf-8?q?es._If_this_flag_is_set,_*buf*_may_be_NULL.=0D=0A>_+_*=0D=0A>_+?=
 =?utf-8?q?_*_____________**-EINVAL**_if_arguments_invalid_or_**buf=5Fsize?=
 =?utf-8?q?**_not_a_multiple=0D=0A=0D=0Abuf=5Fsize_->_size=0D=0A=0D=0A>_+_?=
 =?utf-8?q?*_____________of_sizeof(struct_perf=5Fbranch=5Fentry).=0D=0A>_+?=
 =?utf-8?q?_*=0D=0A>_+_*_____________**-ENOENT**_if_architecture_does_not_?=
 =?utf-8?q?support_branch_records.=0D=0A>___*/=0D=0A=0D=0A[...]=0D=0A?=
In-Reply-To: <CAEf4Bzam8ikJO7atrSS8s-rLJ0jHKNjahcuVEWFh7AAbGTaoGw@mail.gmail.com>
Originaldate: Tue Feb 11, 2020 at 11:23 AM
Originalfrom: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Date:   Thu, 13 Feb 2020 22:34:56 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>,
        "Peter Ziljstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: [PATCH v7 bpf-next RESEND 1/2] bpf: Add
 bpf_read_branch_records() helper
Message-Id: <C0LOF40A2NT4.1N6H8Y7LVZGFF@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue Feb 11, 2020 at 11:23 AM, Andrii Nakryiko wrote:
> On Mon, Feb 10, 2020 at 12:09 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
[...]
> > + * int bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *=
buf, u32 size, u64 flags)
> > + *     Description
> > + *             For an eBPF program attached to a perf event, retrieve =
the
> > + *             branch records (struct perf_branch_entry) associated to=
 *ctx*
> > + *             and store it in the buffer pointed by *buf* up to size
> > + *             *buf_size* bytes.
> > + *     Return
> > + *             On success, number of bytes written to *buf*. On error,=
 a
> > + *             negative value.
> > + *
> > + *             The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SI=
ZE** to
> > + *             instead return the number of bytes required to store al=
l the
> > + *             branch entries. If this flag is set, *buf* may be NULL.
> > + *
> > + *             **-EINVAL** if arguments invalid or **buf_size** not a =
multiple
>
>=20
> buf_size -> size

Whoops, thanks for catching.

[...]
