Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4C148F59
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbgAXU2Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 15:28:25 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34661 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387548AbgAXU2Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 15:28:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A5A236E18;
        Fri, 24 Jan 2020 15:28:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Jan 2020 15:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=cZM9RcoYSF0kls4q1gOKm1g9a
        6xGHIU+fPnvxOaAwC8=; b=i6eK8noNsWTSoDRDj2kU/LsQtP62hS5kGEWvfXaD/
        +3vBUUkifAQEUnG1LF7AueWOhA4/SK6lWntD9tUkw5xUcAea23BBpcoIeXHx+fiD
        TUUBiYqUIbf8yW5NFt6BMu3Wshb1CZuAj1fT4e4AaO1k9++YSMrOWBjipeT78o2S
        jyxQG2YRR5W68gTRFvJE1/S4aWWlUTNRox0tx90W5fJGmIyVGKN8LLCCyD1P7Zo/
        ZEjwZ0wRdlZ9J9sJ+UgDM6doN4yT0upFVpGOP1Ma07Tz8uT05wAS1GaAzInsw39l
        LdOzS6NBz/oOo0JrdwWUfVj5v8wk9EDS3m+tXrSIBnrww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cZM9Rc
        oYSF0kls4q1gOKm1g9a6xGHIU+fPnvxOaAwC8=; b=c1voMiW8TkLse+plJ2HxN0
        JHl1dgTVLnp5T2BAbneJJaHMsAA34w8vXqDFk6QNQDfEN6a9v25qs3PVRzwfqNt8
        NLpiqfqk9mKFEmvEU901N3b8zrwUIOwDLc+NzwykYszbQjuKtZowVY320rnheHJ7
        nfr87EzwB0krQXf4Q0NDnJ+w+yTVk7t0GYZzmTzwvnyDMgxitQFRgfgGUYXs/ZzB
        0kjKMTBjifP87jByzPgYAr9M9mFPG77uu7hG/Qf53TmimDQ5bw9Ez9R+fMShg+BQ
        iBK4yI93EvN7mGegVK8lEutapMouzklDmFzXFpyABa9oI1eq97KVX7x03svWiNDw
        ==
X-ME-Sender: <xms:ZlMrXn_2Lgk2mFLbRnVCh0omVI54bbK9_GlbYh6NG-POsYi_OoUgnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeduleelrddvtddurdeigedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ZlMrXnZP-nB0ef83akR3XInkh3mwSV46Vjzb2qDeTmDKvln4Uut30w>
    <xmx:ZlMrXu0zg9sbK7N9KhAQOasItR-9aQUP_zMvKMOvZOHuc3Y0r1s6QQ>
    <xmx:ZlMrXqZ57Z9TVDRCjLRViVrorPGhVb4zxjUZOm_fuBSdZrkVMV1g7A>
    <xmx:Z1MrXld0hfIwqu_b7Lf_P2F7jDxuB0IpoIYRTMuD3kr56WyVqXTs2A>
Received: from localhost (prnvpn05.thefacebook.com [199.201.64.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 513743060EDD;
        Fri, 24 Jan 2020 15:28:21 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Fri Jan 24, 2020 at 8:25 AM
Originalfrom: "Martin Lau" <kafai@fb.com>
Original: =?utf-8?q?On_Thu,_Jan_23,_2020_at_06:02:58PM_-0800,_Daniel_Xu_wrote:=0D?=
 =?utf-8?q?=0A>_On_Thu_Jan_23,_2020_at_4:49_PM,_John_Fastabend_wrote:=0D?=
 =?utf-8?q?=0A>_[...]=0D=0A>_>_>___*_function_eBPF_program_intends_to_call?=
 =?utf-8?q?=0D=0A>_>_>_diff_--git_a/kernel/trace/bpf=5Ftrace.c_b/kernel/tr?=
 =?utf-8?q?ace/bpf=5Ftrace.c=0D=0A>_>_>_index_19e793aa441a..24c51272a1f7_1?=
 =?utf-8?q?00644=0D=0A>_>_>_---_a/kernel/trace/bpf=5Ftrace.c=0D=0A>_>_>_++?=
 =?utf-8?q?+_b/kernel/trace/bpf=5Ftrace.c=0D=0A>_>_>_@@_-1028,6_+1028,35_@?=
 =?utf-8?q?@_static_const_struct_bpf=5Ffunc=5Fproto_bpf=5Fperf=5Fprog=5Fre?=
 =?utf-8?q?ad=5Fvalue=5Fproto_=3D_{=0D=0A>_>_>___________.arg3=5Ftype_____?=
 =?utf-8?q?_=3D_ARG=5FCONST=5FSIZE,=0D=0A>_>_>__};=0D=0A>_>_>__=0D=0A>_>_>?=
 =?utf-8?q?_+BPF=5FCALL=5F3(bpf=5Fperf=5Fprog=5Fread=5Fbranches,_struct_bp?=
 =?utf-8?q?f=5Fperf=5Fevent=5Fdata=5Fkern_*,_ctx,=0D=0A>_>_>_+=09___void_*?=
 =?utf-8?q?,_buf,_u32,_size)=0D=0A>_>_>_+{=0D=0A>_>_>_+=09struct_perf=5Fbr?=
 =?utf-8?q?anch=5Fstack_*br=5Fstack_=3D_ctx->data->br=5Fstack;=0D=0A>_>_>_?=
 =?utf-8?q?+=09u32_to=5Fcopy_=3D_0,_to=5Fclear_=3D_size;=0D=0A>_>_>_+=09in?=
 =?utf-8?q?t_err_=3D_-EINVAL;=0D=0A>_>_>_+=0D=0A>_>_>_+=09if_(unlikely(!br?=
 =?utf-8?q?=5Fstack))=0D=0A>_>_>_+=09=09goto_clear;=0D=0A>_>_>_+=0D=0A>_>_?=
 =?utf-8?q?>_+=09to=5Fcopy_=3D_min=5Ft(u32,_br=5Fstack->nr_*_sizeof(struct?=
 =?utf-8?q?_perf=5Fbranch=5Fentry),_size);=0D=0A>_>_>_+=09to=5Fclear_-=3D_?=
 =?utf-8?q?to=5Fcopy;=0D=0A>_>_>_+=0D=0A>_>_>_+=09memcpy(buf,_br=5Fstack->?=
 =?utf-8?q?entries,_to=5Fcopy);=0D=0A>_>_>_+=09err_=3D_to=5Fcopy;=0D=0A>_>?=
 =?utf-8?q?_>_+clear:=0D=0A>_>=0D=0A>_>_=0D=0A>_>_There_appears_to_be_agre?=
 =?utf-8?q?ement_to_clear_the_extra_buffer_on_error_but=0D=0A>_>_what_abou?=
 =?utf-8?q?t=0D=0A>_>_in_the_non-error_case=3F_I_expect_one_usage_pattern_?=
 =?utf-8?q?is_to_submit_a_fairly=0D=0A>_>_large=0D=0A>_>_buffer,_large_eno?=
 =?utf-8?q?ugh_to_handle_worse_case_nr,_in_this_case_we_end_up=0D=0A>_>_ze?=
 =?utf-8?q?ro'ing=0D=0A>_>_memory_even_in_the_succesful_case._Can_we_skip_?=
 =?utf-8?q?the_clear_in_this_case=3F=0D=0A>_>_Maybe=0D=0A>_>_its_not_too_i?=
 =?utf-8?q?mportant_either_way_but_seems_unnecessary.=0D=0AAfter_some_thou?=
 =?utf-8?q?ghts,__I_also_think_clearing_for_non-error_case=0D=0Ais_not_ide?=
 =?utf-8?q?al.__DanielXu,_is_it_the_common_use_case_to_always=0D=0Ahave_a_?=
 =?utf-8?q?large_enough_buf_size_to_capture_the_interested_data=3F=0D=0A?=
 =?utf-8?q?=0D=0A>_>=0D=0A>_>_=0D=0A>_>_>_+=09memset(buf_+_to=5Fcopy,_0,_t?=
 =?utf-8?q?o=5Fclear);=0D=0A>_>_>_+=09return_err;=0D=0A>_>_>_+}=0D=0A>_>?=
 =?utf-8?q?=0D=0A>_=0D=0A>_Given_Yonghong's_suggestion_of_a_flag_argument,?=
 =?utf-8?q?_we_need_to_allow_users=0D=0A>_to_pass_in_a_null_ptr_while_gett?=
 =?utf-8?q?ing_buffer_size._So_I'll_change_the_`buf`=0D=0A>_argument_to_be?=
 =?utf-8?q?_ARG=5FPTR=5FTO=5FMEM=5FOR=5FNULL,_which_requires_the_buffer_be?=
 =?utf-8?q?=0D=0A>_initialized._We_can_skip_zero'ing_out_altogether.=0D=0A?=
 =?utf-8?q?>_=0D=0A>_Although_I_think_the_end_result_is_the_same_--_now_th?=
 =?utf-8?q?e_user_has_to_zero_it=0D=0A>_out._Unfortunately_ARG=5FPTR=5FTO?=
 =?utf-8?q?=5FUNINITIALIZED=5FMEM=5FOR=5FNULL_is_not=0D=0A>_implemented_ye?=
 =?utf-8?q?t.=0D=0AA_"flags"_arg_can_be_added_but_not_used_to_keep_our_opt?=
 =?utf-8?q?ion_open_in_the=0D=0Afuture.__Not_sure_it_has_to_be_implemented?=
 =?utf-8?q?_now_though.=0D=0AI_would_think_whether_there_is_an_immediate_u?=
 =?utf-8?q?secase_to_learn=0D=0Abr=5Fstack->nr_through_an_extra_bpf_helper?=
 =?utf-8?q?_call_in_every_event.=0D=0A=0D=0AWhen_there_is_a_use_case_for_l?=
 =?utf-8?q?earning_br=5Fstack->nr,=0D=0Athere_may_have_multiple_ways_to_do?=
 =?utf-8?q?_it_also,=0D=0Athis_"flags"_arg,_or_another_helper,=0D=0Aor_br?=
 =?utf-8?q?=5Fstack->nr_may_be_read_directly_with_the_help_of_BTF.=0D=0A?=
In-Reply-To: <20200124082501.2uw6rqhou4wc27ht@kafai-mbp.dhcp.thefacebook.com>
Date:   Fri, 24 Jan 2020 12:28:20 -0800
Cc:     "John Fastabend" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Martin Lau" <kafai@fb.com>
Message-Id: <C04AZRSVPEUE.1BAZ20OQOVKLG@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri Jan 24, 2020 at 8:25 AM, Martin Lau wrote:
> On Thu, Jan 23, 2020 at 06:02:58PM -0800, Daniel Xu wrote:
> > On Thu Jan 23, 2020 at 4:49 PM, John Fastabend wrote:
> > [...]
> > > >   * function eBPF program intends to call
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index 19e793aa441a..24c51272a1f7 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -1028,6 +1028,35 @@ static const struct bpf_func_proto bpf_perf_=
prog_read_value_proto =3D {
> > > >           .arg3_type      =3D ARG_CONST_SIZE,
> > > >  };
> > > > =20
> > > > +BPF_CALL_3(bpf_perf_prog_read_branches, struct bpf_perf_event_data=
_kern *, ctx,
> > > > +	   void *, buf, u32, size)
> > > > +{
> > > > +	struct perf_branch_stack *br_stack =3D ctx->data->br_stack;
> > > > +	u32 to_copy =3D 0, to_clear =3D size;
> > > > +	int err =3D -EINVAL;
> > > > +
> > > > +	if (unlikely(!br_stack))
> > > > +		goto clear;
> > > > +
> > > > +	to_copy =3D min_t(u32, br_stack->nr * sizeof(struct perf_branch_e=
ntry), size);
> > > > +	to_clear -=3D to_copy;
> > > > +
> > > > +	memcpy(buf, br_stack->entries, to_copy);
> > > > +	err =3D to_copy;
> > > > +clear:
> > >
> > >=20
> > > There appears to be agreement to clear the extra buffer on error but
> > > what about
> > > in the non-error case? I expect one usage pattern is to submit a fair=
ly
> > > large
> > > buffer, large enough to handle worse case nr, in this case we end up
> > > zero'ing
> > > memory even in the succesful case. Can we skip the clear in this case=
?
> > > Maybe
> > > its not too important either way but seems unnecessary.
> After some thoughts, I also think clearing for non-error case
> is not ideal. DanielXu, is it the common use case to always
> have a large enough buf size to capture the interested data?

Yeah, ideally you want all of the data. But since branch data is already
sampled, it's not too bad to lose some events as long as they're
consistently lost (eg only keep 4 branch entries).

I personally don't have strong opinions about clearing unused buffer on
success. However the internal documentation does say the helper must
fill all the buffer, regardless of success. It seems like from this
conversation there's no functional difference.

>
>=20
> > >
> > >=20
> > > > +	memset(buf + to_copy, 0, to_clear);
> > > > +	return err;
> > > > +}
> > >
> >=20
> > Given Yonghong's suggestion of a flag argument, we need to allow users
> > to pass in a null ptr while getting buffer size. So I'll change the `bu=
f`
> > argument to be ARG_PTR_TO_MEM_OR_NULL, which requires the buffer be
> > initialized. We can skip zero'ing out altogether.
> >=20
> > Although I think the end result is the same -- now the user has to zero=
 it
> > out. Unfortunately ARG_PTR_TO_UNINITIALIZED_MEM_OR_NULL is not
> > implemented yet.
> A "flags" arg can be added but not used to keep our option open in the
> future. Not sure it has to be implemented now though.
> I would think whether there is an immediate usecase to learn
> br_stack->nr through an extra bpf helper call in every event.
>
>=20
> When there is a use case for learning br_stack->nr,
> there may have multiple ways to do it also,
> this "flags" arg, or another helper,
> or br_stack->nr may be read directly with the help of BTF.

I thought about this more and I think one use case could be to figure
out how many branch entries you failed to collect and report it to
userspace for aggregation later. I agree there are multiple ways to do
it, but they would all require another helper call.

Since right now you have to statically define your buffer size, it's
quite easy to lose entries. So for completeness of the API, it would be
good to know how much data you lost.

Doing it via a flag seems fairly natural to me. Another helper seems a
little overkill. BTF could work but it's a less strong API guarantee
than the helper (ie field name changes).
