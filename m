Return-Path: <bpf+bounces-64974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB65B19A0C
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 04:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0691893346
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 02:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F721F30AD;
	Mon,  4 Aug 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfxVhzY1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9DD2E36EB
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754273120; cv=none; b=Cv6lEOv92ma8KoMsqRPyCRYv+77/DShhevosXve1cQnmiLfOBGZIDJXpvQ3L9whirDobQyPdq0DTnc1LEiquTqZcQYkUr8UDXMvsh0ENvyboP5XXAujJR5ANnUgcJ/QgRtUnRfQCt0cXPYRQDsCfy+gKwClRaBIdsMCTwM3Z3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754273120; c=relaxed/simple;
	bh=mV5Lb4RNAVCVLzeyVnV8V/pok6ISozE+CVP7uTegxYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWXJ0f7xsSI+mnOQU2HENYjouAzIot9ZX/DR39clDE93ogaxY++Cnj9UPc8thC+/guteH4qMtwFycec1mTuSEvmEhjwg762yJfu46jwWYdUbc9SkvcUgfWZq1aeFrudoC4M3hhfB+HCa7Yitl81qS6Z9Qtavqfh3v9VLxOdYktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfxVhzY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE11C4CEF4
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 02:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754273120;
	bh=mV5Lb4RNAVCVLzeyVnV8V/pok6ISozE+CVP7uTegxYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qfxVhzY1MmfFxae6Mc70CHeoGlmMooeLtwFX4mOLLNvNQ4iGhZMPcWS64Fqd/E4hV
	 k80kvrx09V4q206XRHBSM1w9PhXs9orMtdLnP/VqilsKgADC/6+nOE0KATDreZ+aBi
	 WPhphjJP7OGD5LDVVMDGQiBcMVw9wTmS18FZkRDikZ8pnX9b9Y0JnX4eEU/YroWu7q
	 Q9FdESQtTjrh2UhUZI2OeuVBtNE+NCzWQcdjjcxTbJdbk3B9ek6/K6t2EEceD42QpT
	 pM8vhzTtDB8A84AM293AyyMvZ7HMx9CWVTVD99Y/GZCNXajQvp5jiU2nadPuR+XhAX
	 Qd05TzJ8Ct7ng==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso5047494a12.1
        for <bpf@vger.kernel.org>; Sun, 03 Aug 2025 19:05:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5n9365XR1sWjiP1ILKw96K8/pWVFnCSJCF/qCdkhhmKfwYzs116to8fZabpr4JAW1LVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBK3OVCtC/JEBmmahkaxo+cHVHxzs+T7iE6aImGHT3diDO7tmQ
	RYNaZ7WLsmnk16Jm9opEX/NcV8FDAx4nqlaL7o8C4AMgwaPST3UUKV/nQQYGGtPKu0kDeFE9hgk
	XLuNIth4TXk1n0jzgDGKzDki+REMSixo=
X-Google-Smtp-Source: AGHT+IEPCR8Y60ycMcYv/86HSOU73AJITz63Wc37bkblopkQFrQ1lsQmDfyNouRYunbj1ayku+iIPPuKH/gtjx8LIfA=
X-Received: by 2002:a05:6402:5210:b0:615:860d:7da8 with SMTP id
 4fb4d7f45d1cf-615e6f10de3mr7002742a12.14.1754273118438; Sun, 03 Aug 2025
 19:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731075046.851694-1-jianghaoran@kylinos.cn>
 <CAAhV-H4Z0TTKaspNCwr8U0pDJ37dMyWV1JmNUSfBhvY33QK6sw@mail.gmail.com> <3cb9bca1b9bd12321a59cab2d670ed53cd042362.camel@kylinos.cn>
In-Reply-To: <3cb9bca1b9bd12321a59cab2d670ed53cd042362.camel@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 4 Aug 2025 10:05:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6C=Ob_GJjn9B_hUgs7Cyxwu0SFjhPKc1PEXYg8Dz-pFA@mail.gmail.com>
X-Gm-Features: Ac12FXzssvPa0Bvc0304qgqbi0JbxBxPY7QT84MxJwPnrZfDK-WP2CHsj0VuTPo
Message-ID: <CAAhV-H6C=Ob_GJjn9B_hUgs7Cyxwu0SFjhPKc1PEXYg8Dz-pFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Fix two tailcall-related issues
To: jianghaoran <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	hengqi.chen@gmail.com, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 9:35=E2=80=AFAM jianghaoran <jianghaoran@kylinos.cn>=
 wrote:
>
>
>
>
>
> =E5=9C=A8 2025-08-03=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 22:25 +0800=EF=
=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > Hi, Haoran,
> >
> > I think the first patch should be backported to stable branches
> > and
> > the second depends on trampoline, right?
> >
> > Huacai
> >
>
> That's the case.
OK, applied.

Huacai
> >
> > On Thu, Jul 31, 2025 at 3:51=E2=80=AFPM Haoran Jiang <
> jianghaoran@kylinos.cn> > wrote:
> > >
> > > v5:
> > > 1,The format and comments have been modified.
> > >
> > > v4:
> > > 1,There is a conflict when merging these two patches on the basis of =
the trampoline series patches, resolve the conflict issue.
> > >
> > > v3:
> > > 1,In the prepare_bpf_tail_call_cnt function, emit_tailcall_jmp is rep=
laced with emit_cond_jmp.
> > > 2,Fix the issue where test cases using fentry/fexit fail.
> > >
> > > Test after merging these two patches and the following trampoline ser=
ies patches.
> https://lore.kernel.org/loongarch/CAK3+h2zirm6cV2tAbd38RSYSF3=3DB1qZ+9jm_=
GZPsAPrMtaozmg@mail.gmail.com/T/#mf1f1c9f965d5229c6d2dce3b1ca8bc9a5d70520d>=
 >
> > >
> > > ./test_progs -a tailcalls
> > > #413/1   tailcalls/tailcall_1:OK
> > > #413/2   tailcalls/tailcall_2:OK
> > > #413/3   tailcalls/tailcall_3:OK
> > > #413/4   tailcalls/tailcall_4:OK
> > > #413/5   tailcalls/tailcall_5:OK
> > > #413/6   tailcalls/tailcall_6:OK
> > > #413/7   tailcalls/tailcall_bpf2bpf_1:OK
> > > #413/8   tailcalls/tailcall_bpf2bpf_2:OK
> > > #413/9   tailcalls/tailcall_bpf2bpf_3:OK
> > > #413/10  tailcalls/tailcall_bpf2bpf_4:OK
> > > #413/11  tailcalls/tailcall_bpf2bpf_5:OK
> > > #413/12  tailcalls/tailcall_bpf2bpf_6:OK
> > > #413/13  tailcalls/tailcall_bpf2bpf_fentry:OK
> > > #413/14  tailcalls/tailcall_bpf2bpf_fexit:OK
> > > #413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
> > > #413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
> > > #413/17  tailcalls/tailcall_poke:OK
> > > #413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> > > #413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
> > > #413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
> > > #413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
> > > #413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
> > > #413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> > > #413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> > > #413/25  tailcalls/tailcall_freplace:OK
> > > #413/26  tailcalls/tailcall_bpf2bpf_freplace:OK
> > > #413/27  tailcalls/tailcall_failure:OK
> > > #413/28  tailcalls/reject_tail_call_spin_lock:OK
> > > #413/29  tailcalls/reject_tail_call_rcu_lock:OK
> > > #413/30  tailcalls/reject_tail_call_preempt_lock:OK
> > > #413/31  tailcalls/reject_tail_call_ref:OK
> > > #413     tailcalls:OK
> > > Summary: 1/31 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > >
> > > v2:
> > > 1,Add a Fixes tag.
> > > 2,Ctx as the first parameter of emit_bpf_tail_call.
> > > 3,Define jmp_offset as a macro in emit_bpf_tail_call.
> > >
> > > After merging these two patches, the test results are as follows:
> > >
> > > ./test_progs --allow=3Dtailcalls
> > > tester_init:PASS:tester_log_buf 0 nsec
> > > process_subtest:PASS:obj_open_mem 0 nsec
> > > process_subtest:PASS:specs_alloc 0 nsec
> > > #413/1   tailcalls/tailcall_1:OK
> > > #413/2   tailcalls/tailcall_2:OK
> > > #413/3   tailcalls/tailcall_3:OK
> > > #413/4   tailcalls/tailcall_4:OK
> > > #413/5   tailcalls/tailcall_5:OK
> > > #413/6   tailcalls/tailcall_6:OK
> > > #413/7   tailcalls/tailcall_bpf2bpf_1:OK
> > > #413/8   tailcalls/tailcall_bpf2bpf_2:OK
> > > #413/9   tailcalls/tailcall_bpf2bpf_3:OK
> > > #413/10  tailcalls/tailcall_bpf2bpf_4:OK
> > > #413/11  tailcalls/tailcall_bpf2bpf_5:OK
> > > #413/12  tailcalls/tailcall_bpf2bpf_6:OK
> > > test_tailcall_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> > > test_tailcall_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_count:FAIL:attach_trace unexpected error: -524
> > > #413/13  tailcalls/tailcall_bpf2bpf_fentry:FAIL
> > > test_tailcall_count:PASS:open fexit_obj file 0 nsec
> > > test_tailcall_count:PASS:find fexit prog 0 nsec
> > > test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> > > test_tailcall_count:PASS:load fexit_obj 0 nsec
> > > libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> > > test_tailcall_count:FAIL:attach_trace unexpected error: -524
> > > #413/14  tailcalls/tailcall_bpf2bpf_fexit:FAIL
> > > test_tailcall_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> > > test_tailcall_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_count:FAIL:attach_trace unexpected error: -524
> > > #413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:FAIL
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:load tgt_obj 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map fd 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog fd 0 n=
sec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:update jmp_table 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find fentry prog 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:set_attach_target classifier_=
0 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_bpf2bpf_fentry_entry:FAIL:attach_trace unexpected error=
: -524
> > > #413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:FAIL
> > > #413/17  tailcalls/tailcall_poke:OK
> > > #413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 n=
sec
> > > test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > #413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:FAIL
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fexit_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fexit prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 n=
sec
> > > test_tailcall_hierarchy_count:PASS:load fexit_obj 0 nsec
> > > libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > #413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:FAIL
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 n=
sec
> > > test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > #413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:FAIL
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target entry 0 nsec
> > > test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > tester_init:PASS:tester_log_buf 0 nsec
> > > process_subtest:PASS:obj_open_mem 0 nsec
> > > process_subtest:PASS:specs_alloc 0 nsec
> > > #413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:FAIL
> > > #413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> > > #413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> > > test_tailcall_freplace:PASS:tailcall_freplace__open 0 nsec
> > > test_tailcall_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> > > test_tailcall_freplace:PASS:set_attach_target 0 nsec
> > > test_tailcall_freplace:PASS:tailcall_freplace__load 0 nsec
> > > test_tailcall_freplace:PASS:update jmp_table failure 0 nsec
> > > libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUP=
P
> > > test_tailcall_freplace:FAIL:attach_freplace unexpected error: -524
> > > #413/25  tailcalls/tailcall_freplace:FAIL
> > > test_tailcall_bpf2bpf_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> > > test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__open 0 nsec
> > > test_tailcall_bpf2bpf_freplace:PASS:set_attach_target 0 nsec
> > > test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__load 0 nsec
> > > libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUP=
P
> > > test_tailcall_bpf2bpf_freplace:FAIL:attach_freplace unexpected error:=
 -524
> > > #413/26  tailcalls/tailcall_bpf2bpf_freplace:FAIL
> > > #413/27  tailcalls/tailcall_failure:OK
> > > #413/28  tailcalls/reject_tail_call_spin_lock:OK
> > > #413/29  tailcalls/reject_tail_call_rcu_lock:OK
> > > #413/30  tailcalls/reject_tail_call_preempt_lock:OK
> > > #413/31  tailcalls/reject_tail_call_ref:OK
> > > #413     tailcalls:FAIL
> > >
> > > All error logs:
> > > tester_init:PASS:tester_log_buf 0 nsec
> > > process_subtest:PASS:obj_open_mem 0 nsec
> > > process_subtest:PASS:specs_alloc 0 nsec
> > > test_tailcall_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> > > test_tailcall_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_count:FAIL:attach_trace unexpected error: -524
> > > #413/13  tailcalls/tailcall_bpf2bpf_fentry:FAIL
> > > test_tailcall_count:PASS:open fexit_obj file 0 nsec
> > > test_tailcall_count:PASS:find fexit prog 0 nsec
> > > test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> > > test_tailcall_count:PASS:load fexit_obj 0 nsec
> > > libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> > > test_tailcall_count:FAIL:attach_trace unexpected error: -524
> > > #413/14  tailcalls/tailcall_bpf2bpf_fexit:FAIL
> > > test_tailcall_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> > > test_tailcall_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_count:FAIL:attach_trace unexpected error: -524
> > > #413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:FAIL
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:load tgt_obj 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map fd 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog fd 0 n=
sec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:update jmp_table 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:find fentry prog 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:set_attach_target classifier_=
0 0 nsec
> > > test_tailcall_bpf2bpf_fentry_entry:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_bpf2bpf_fentry_entry:FAIL:attach_trace unexpected error=
: -524
> > > #413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:FAIL
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 n=
sec
> > > test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > #413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:FAIL
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fexit_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fexit prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 n=
sec
> > > test_tailcall_hierarchy_count:PASS:load fexit_obj 0 nsec
> > > libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > #413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:FAIL
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 n=
sec
> > > test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > #413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:FAIL
> > > test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> > > test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> > > test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> > > test_tailcall_hierarchy_count:PASS:set_attach_target entry 0 nsec
> > > test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> > > libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> > > test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -52=
4
> > > tester_init:PASS:tester_log_buf 0 nsec
> > > process_subtest:PASS:obj_open_mem 0 nsec
> > > process_subtest:PASS:specs_alloc 0 nsec
> > > #413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:FAIL
> > > test_tailcall_freplace:PASS:tailcall_freplace__open 0 nsec
> > > test_tailcall_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> > > test_tailcall_freplace:PASS:set_attach_target 0 nsec
> > > test_tailcall_freplace:PASS:tailcall_freplace__load 0 nsec
> > > test_tailcall_freplace:PASS:update jmp_table failure 0 nsec
> > > libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUP=
P
> > > test_tailcall_freplace:FAIL:attach_freplace unexpected error: -524
> > > #413/25  tailcalls/tailcall_freplace:FAIL
> > > test_tailcall_bpf2bpf_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> > > test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__open 0 nsec
> > > test_tailcall_bpf2bpf_freplace:PASS:set_attach_target 0 nsec
> > > test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__load 0 nsec
> > > libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUP=
P
> > > test_tailcall_bpf2bpf_freplace:FAIL:attach_freplace unexpected error:=
 -524
> > > #413/26  tailcalls/tailcall_bpf2bpf_freplace:FAIL
> > > #413     tailcalls:FAIL
> > > Summary: 0/21 PASSED, 0 SKIPPED, 1 FAILED
> > >
> > > v1:
> > > 1,Fix the jmp_offset calculation error in the emit_bpf_tail_call func=
tion.
> > > 2,Fix the issue that MAX_TAIL_CALL_CNT limit bypass in hybrid tailcal=
l and BPF-to-BPF call
> > >
> > > After applying this patch, testing results are as follows:
> > >
> > > ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_1
> > > 413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> > > 413     tailcalls:OK
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_2
> > > 413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> > > 413     tailcalls:OK
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_3
> > > 413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> > > 413     tailcalls:OK
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Haoran Jiang (2):
> > >   LoongArch: BPF: Fix jump offset calculation in tailcall
> > >   LoongArch: BPF: Fix tailcall hierarchy
> > >
> > >  arch/loongarch/net/bpf_jit.c | 171 ++++++++++++++++++++++-----------=
--
> > >  1 file changed, 110 insertions(+), 61 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> > >
>
>

