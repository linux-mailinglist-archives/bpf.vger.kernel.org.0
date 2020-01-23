Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3F1474C8
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 00:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgAWX1N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 18:27:13 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46999 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729085AbgAWX1M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 18:27:12 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 48C436D13;
        Thu, 23 Jan 2020 18:27:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 18:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:to:cc
        :subject:from:message-id; s=fm2; bh=0GqAkm5ezho0B6CcFPY2d1B41XPY
        zh1sDEru06fmUlM=; b=B5PhqknGfx4GYdziP5wfPyLXkWciEQd82NdSTPUnGyF1
        ihpadWchfYu15hf6IKKTLKHWbiZoYyZ/onnGCby0hrhxP0ijnx7IiPycG0ozSx98
        HMz6z3y0hVTCUeCZpgdKqyF1zdzLb7dILKtYP6e0aipVgThbKb0aITWVVpfmX+tw
        a7Invgv1JpNJ/W/mAvxygQwah1qK07DSxXIuLbacRn9xLGdZePL+zwH5KiGqYcm2
        le28bLIhD4v0EZA8FE/bM5xlGvf1sTrQccDBJjHB/hjCBC/yBMI78OE29wNEcXr6
        CgK1OdO8/8lBM4Qc5pe/2gYcntIRU14SJ06bsIrLLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0GqAkm
        5ezho0B6CcFPY2d1B41XPYzh1sDEru06fmUlM=; b=e9kAiVNGnb5s1u58jUYl+P
        2jA/GuIh/rKzqlPGUPXYyAH808u1cvgkfE6uXBbyXZVCozeExGDnh+jrqeWgYPeE
        4OwLjKAF16Sbyks6YByNDGbpFKZAzmpEXI5DJVafG0npM4SG7dOQ2g7p6MBH8OXQ
        7RgmHmm8ddFb41zcf2yTwlHpSjk/yARratk3Qd06v6Wdi59Ix2P07bo7IgsBpQkS
        xovAAhs2qG5flUW5dkUE83evsD/KgqQ3MY3XlKmclikhxH7P5VEe5TQJsWn9kzu5
        TWCPsa5n5jKKRmmeQ9gbCYkyKQTrdNjPzY0Obgk5ETuIceuUvKTjUgieBvlrMb9w
        ==
X-ME-Sender: <xms:zSsqXlFrUDDBYI1sXllZOiV1fQHG-ThTxRbTPIUk8Exs1PKUT-OPMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdefgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffvffuhffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeduleelrddvtddurdeigedrudefheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:zSsqXpOexAJszEh65AK2ZrGw35CrnT40BB8uheCfVyvTx4_8LdKJhw>
    <xmx:zSsqXngiKmPl1DdNos7rKac4Fq6afN1HnCqX31Kxxc6VNPOne4sfLg>
    <xmx:zSsqXgGGzRXxPy3rUM8kphodQyKKNsGRca6sXnqLTqA1kupLNepbQw>
    <xmx:zysqXq1mk7_TvvhNgZ-ReCwsMTFD-6PtIYv_oIaZ3eKd92BONmpaBg>
Received: from localhost (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 262883060B64;
        Thu, 23 Jan 2020 18:27:08 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Thu Jan 23, 2020 at 11:44 PM
Originalfrom: "Daniel Borkmann" <daniel@iogearbox.net>
Original: =?utf-8?q?On_1/23/20_11:30_PM,_Daniel_Xu_wrote:
 =0D=0A>_On_Thu_Jan_23,_202?=
 =?utf-8?q?0_at_11:23_PM,_Daniel_Borkmann_wrote:=0D=0A>_[...]=0D=0A>>=0D?=
 =?utf-8?q?=0A>>_Yes,_so_we've_been_following_this_practice_for_all_the_BP?=
 =?utf-8?q?F_helpers_no=0D=0A>>_matter=0D=0A>>_which_program_type._Though_?=
 =?utf-8?q?for_tracing_it_may_be_up_to_debate_whether_it=0D=0A>>_makes=0D?=
 =?utf-8?q?=0A>>_still_sense_given_there's_nothing_to_be_leaked_here_since?=
 =?utf-8?q?_you_can_read=0D=0A>>_this_data=0D=0A>>_anyway_via_probe_read_i?=
 =?utf-8?q?f_you'd_wanted_to._So_we_might_as_well_get_rid_of=0D=0A>>_the?=
 =?utf-8?q?=0D=0A>>_clearing_for_all_tracing_helpers.=0D=0A>_=0D=0A>_Right?=
 =?utf-8?q?,_that_makes_sense._Do_you_want_me_to_leave_it_in_for_this_patc?=
 =?utf-8?q?hset=0D=0A>_and_then_remove_all_of_them_in_a_followup_patchset?=
 =?utf-8?q?=3F=0D=0A=0D=0ALets_leave_it_in_and_in_a_different_set,_we_can_?=
 =?utf-8?q?clean_this_up_for_all_tracing=0D=0Arelated_helpers_at_once.=0D?=
 =?utf-8?q?=0A=0D=0A>>_Different_question_related_to_your_set._It_looks_li?=
 =?utf-8?q?ke_br=5Fstack_is_only=0D=0A>>_available=0D=0A>>_on_x86,_is_that?=
 =?utf-8?q?_correct=3F_For_other_archs_this_will_always_bail_out_on=0D=0A>?=
 =?utf-8?q?>_!br=5Fstack=0D=0A>>_test._Perhaps_we_should_document_this_fac?=
 =?utf-8?q?t_so_users_are_not_surprised=0D=0A>>_why_their=0D=0A>>_prog_usi?=
 =?utf-8?q?ng_this_helper_is_not_working_on_!x86._Wdyt=3F=0D=0A>_=0D=0A>_I?=
 =?utf-8?q?_think_perf=5Fevent=5Fopen()_should_fail_on_!x86_if_a_user_trie?=
 =?utf-8?q?s_to_configure=0D=0A>_it_with_branch_stack_collection._So_there?=
 =?utf-8?q?_would_not_be_the_opportunity_for=0D=0A>_the_bpf_prog_to_be_att?=
 =?utf-8?q?ached_and_run._I_haven't_tested_this,_though._I'll=0D=0A>_look_?=
 =?utf-8?q?through_the_code_/_install_a_VM_and_test_it.=0D=0A=0D=0AAs_far_?=
 =?utf-8?q?as_I_can_see_the_prog_would_still_be_attachable_and_runnable,_j?=
 =?utf-8?q?ust_that=0D=0Athe_helper_always_will_return_-EINVAL_on_these_ar?=
 =?utf-8?q?chs._Maybe_error_code_should_be=0D=0Achanged_into_-ENOENT_to_av?=
 =?utf-8?q?oid_confusion_wrt_whether_user_provided_some_invalid=0D=0Ainput?=
 =?utf-8?q?_args._Should_this_actually_bail_out_with_-EINVAL_if_size_is_no?=
 =?utf-8?q?t_a_multiple=0D=0Aof_sizeof(struct_perf=5Fbranch=5Fentry)_as_ot?=
 =?utf-8?q?herwise_we'd_end_up_copying_half_broken=0D=0Abranch_entry_infor?=
 =?utf-8?q?mation=3F=0D=0A=0D=0AThanks,=0D=0ADaniel=0D=0A?=
In-Reply-To: <9341443f-b29a-e92e-0e12-7990927b4e33@iogearbox.net>
Date:   Thu, 23 Jan 2020 15:27:07 -0800
To:     "Daniel Borkmann" <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <songliubraving@fb.com>, <yhs@fb.com>,
        <andriin@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Message-Id: <C03K644SLHQ9.1FOCEKF12GEJE@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Jan 23, 2020 at 11:44 PM, Daniel Borkmann wrote:
[...]
> >> Different question related to your set. It looks like br_stack is only
> >> available
> >> on x86, is that correct? For other archs this will always bail out on
> >> !br_stack
> >> test. Perhaps we should document this fact so users are not surprised
> >> why their
> >> prog using this helper is not working on !x86. Wdyt?
> >=20
> > I think perf_event_open() should fail on !x86 if a user tries to config=
ure
> > it with branch stack collection. So there would not be the opportunity =
for
> > the bpf prog to be attached and run. I haven't tested this, though. I'l=
l
> > look through the code / install a VM and test it.
>
>=20
> As far as I can see the prog would still be attachable and runnable,
> just that
> the helper always will return -EINVAL on these archs. Maybe error code
> should be
> changed into -ENOENT to avoid confusion wrt whether user provided some
> invalid
> input args.=20

Ok, will add.

> Should this actually bail out with -EINVAL if size is not a
> multiple
> of sizeof(struct perf_branch_entry) as otherwise we'd end up copying
> half broken
> branch entry information?

Sure, makes sense.
>
>=20
> Thanks,
> Daniel
>
>=20
>
>=20

