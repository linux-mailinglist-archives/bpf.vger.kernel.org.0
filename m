Return-Path: <bpf+bounces-64964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DAB1943B
	for <lists+bpf@lfdr.de>; Sun,  3 Aug 2025 16:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F77C173485
	for <lists+bpf@lfdr.de>; Sun,  3 Aug 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9F25A341;
	Sun,  3 Aug 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZep9+fB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E559367
	for <bpf@vger.kernel.org>; Sun,  3 Aug 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754231137; cv=none; b=BohUHGhVZExIoOxK77r9vcozNNmhr9JDhsjyL7RqpSI1yYkhk3K5f12lXEp2oz3p8UnA4MpRlvlO+RYKH1PJuqKz9mc0CkIE8XEG+Ppx513umumPPW0bVyodowI4nc9q2zGu9Z5X8+mnOJ7IuJ+FATQd/IzOstmA12LAL9fDwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754231137; c=relaxed/simple;
	bh=BzUzBYrqt6uBbSOk1GvCt3/hnlQqwGOQKHSjGrkcR8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtSXOB1axYCtxpcu1LQFNl2fJd9O/x5ZO/6Re/Gi/3t6dAKJtxkXfiPoSeoks1Y6UAiyz0bVl3b49vZyhobB4wi1REgQDBu4UDvD8vRYUJQrgThdjQbBCymcr1PPTAbCNeYgDZEnDagDeNrBy1oC0EJfEj44MaHuorUKoayI6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZep9+fB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B5BC4AF09
	for <bpf@vger.kernel.org>; Sun,  3 Aug 2025 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754231136;
	bh=BzUzBYrqt6uBbSOk1GvCt3/hnlQqwGOQKHSjGrkcR8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NZep9+fBwTzDPs9D1LcUuc+4nNPHg22yqTBPpl5Fn3h617r4jBC6LtyzCDJTGV/cx
	 fzi1V7Yewr/UN/+UWWIL5cy1Cxj/np8JfVBkxp0WZiLX8yz+0fpLZXHoS218Y4Qoao
	 atgcWUJSLSV+aXimWzkBH1Tow0NJXA7jr4mJfvUKxshVesBZ/c7eAL+M9BDv82ldT9
	 OR1EAG5DCd/3E5MegRd0zBjNvy/Jmj/8T+cxFa1DN3OAMmeS7hoCze+BaEw4tZpyQP
	 czeUl83sp8vaCeRdjY6tfioqqFv4CP5zt5/zAWDqlXnAx/rrtXwVVXmCU/my1jbs/K
	 3fIpHykR59Nbw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso4875757a12.3
        for <bpf@vger.kernel.org>; Sun, 03 Aug 2025 07:25:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV88v2gcYP+BI9iMoXz4fB77kVfsHmZroZ19Tu+jxPDlE5+Rmi+OcaQL5lz4sAcLmBA1JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQphP5h/Ji9A9ijMwtf9q4brbyhuCkwnkmwxOMq9yvOyaOq8F
	EyJL5dm9t1jLfyRbCPb6ewqp8eAvv0cmXGirfWTIbgziqLY/OmNSYdoo6EkPnl38uCtoQhHG1HI
	4YV4cdXzqm8JDN6UPNL5fxbtpVzsdwR0=
X-Google-Smtp-Source: AGHT+IHzf1O6LKF6dCajtEKmJnqF5LE/94DzjVNMUdO0q15TrKv8TufdM4VNVa3qIZA4QlGiV6cd0SaH4BxzFh6AOnM=
X-Received: by 2002:a05:6402:1255:b0:615:5b45:2ea2 with SMTP id
 4fb4d7f45d1cf-615e6ed02e2mr4651219a12.8.1754231135194; Sun, 03 Aug 2025
 07:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731075046.851694-1-jianghaoran@kylinos.cn>
In-Reply-To: <20250731075046.851694-1-jianghaoran@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 3 Aug 2025 22:25:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Z0TTKaspNCwr8U0pDJ37dMyWV1JmNUSfBhvY33QK6sw@mail.gmail.com>
X-Gm-Features: Ac12FXzfUO44jm8NdYr2VkTC8OVeSVgHpyADbRYY1uHuR6QM-A7hbuDC6zt9pAE
Message-ID: <CAAhV-H4Z0TTKaspNCwr8U0pDJ37dMyWV1JmNUSfBhvY33QK6sw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Fix two tailcall-related issues
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	hengqi.chen@gmail.com, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Haoran,

I think the first patch should be backported to stable branches and
the second depends on trampoline, right?

Huacai

On Thu, Jul 31, 2025 at 3:51=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.c=
n> wrote:
>
> v5:
> 1,The format and comments have been modified.
>
> v4:
> 1,There is a conflict when merging these two patches on the basis of the =
trampoline series patches, resolve the conflict issue.
>
> v3:
> 1,In the prepare_bpf_tail_call_cnt function, emit_tailcall_jmp is replace=
d with emit_cond_jmp.
> 2,Fix the issue where test cases using fentry/fexit fail.
>
> Test after merging these two patches and the following trampoline series =
patches.
> https://lore.kernel.org/loongarch/CAK3+h2zirm6cV2tAbd38RSYSF3=3DB1qZ+9jm_=
GZPsAPrMtaozmg@mail.gmail.com/T/#mf1f1c9f965d5229c6d2dce3b1ca8bc9a5d70520d
>
> ./test_progs -a tailcalls
> #413/1   tailcalls/tailcall_1:OK
> #413/2   tailcalls/tailcall_2:OK
> #413/3   tailcalls/tailcall_3:OK
> #413/4   tailcalls/tailcall_4:OK
> #413/5   tailcalls/tailcall_5:OK
> #413/6   tailcalls/tailcall_6:OK
> #413/7   tailcalls/tailcall_bpf2bpf_1:OK
> #413/8   tailcalls/tailcall_bpf2bpf_2:OK
> #413/9   tailcalls/tailcall_bpf2bpf_3:OK
> #413/10  tailcalls/tailcall_bpf2bpf_4:OK
> #413/11  tailcalls/tailcall_bpf2bpf_5:OK
> #413/12  tailcalls/tailcall_bpf2bpf_6:OK
> #413/13  tailcalls/tailcall_bpf2bpf_fentry:OK
> #413/14  tailcalls/tailcall_bpf2bpf_fexit:OK
> #413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
> #413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
> #413/17  tailcalls/tailcall_poke:OK
> #413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> #413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
> #413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
> #413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
> #413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
> #413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> #413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> #413/25  tailcalls/tailcall_freplace:OK
> #413/26  tailcalls/tailcall_bpf2bpf_freplace:OK
> #413/27  tailcalls/tailcall_failure:OK
> #413/28  tailcalls/reject_tail_call_spin_lock:OK
> #413/29  tailcalls/reject_tail_call_rcu_lock:OK
> #413/30  tailcalls/reject_tail_call_preempt_lock:OK
> #413/31  tailcalls/reject_tail_call_ref:OK
> #413     tailcalls:OK
> Summary: 1/31 PASSED, 0 SKIPPED, 0 FAILED
>
>
> v2:
> 1,Add a Fixes tag.
> 2,Ctx as the first parameter of emit_bpf_tail_call.
> 3,Define jmp_offset as a macro in emit_bpf_tail_call.
>
> After merging these two patches, the test results are as follows:
>
> ./test_progs --allow=3Dtailcalls
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> #413/1   tailcalls/tailcall_1:OK
> #413/2   tailcalls/tailcall_2:OK
> #413/3   tailcalls/tailcall_3:OK
> #413/4   tailcalls/tailcall_4:OK
> #413/5   tailcalls/tailcall_5:OK
> #413/6   tailcalls/tailcall_6:OK
> #413/7   tailcalls/tailcall_bpf2bpf_1:OK
> #413/8   tailcalls/tailcall_bpf2bpf_2:OK
> #413/9   tailcalls/tailcall_bpf2bpf_3:OK
> #413/10  tailcalls/tailcall_bpf2bpf_4:OK
> #413/11  tailcalls/tailcall_bpf2bpf_5:OK
> #413/12  tailcalls/tailcall_bpf2bpf_6:OK
> test_tailcall_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_count:PASS:find fentry prog 0 nsec
> test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_count:FAIL:attach_trace unexpected error: -524
> #413/13  tailcalls/tailcall_bpf2bpf_fentry:FAIL
> test_tailcall_count:PASS:open fexit_obj file 0 nsec
> test_tailcall_count:PASS:find fexit prog 0 nsec
> test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_count:PASS:load fexit_obj 0 nsec
> libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> test_tailcall_count:FAIL:attach_trace unexpected error: -524
> #413/14  tailcalls/tailcall_bpf2bpf_fexit:FAIL
> test_tailcall_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_count:PASS:find fentry prog 0 nsec
> test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_count:FAIL:attach_trace unexpected error: -524
> #413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:FAIL
> test_tailcall_bpf2bpf_fentry_entry:PASS:load tgt_obj 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map fd 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog fd 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:update jmp_table 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:open fentry_obj file 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find fentry prog 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:set_attach_target classifier_0 0 =
nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_bpf2bpf_fentry_entry:FAIL:attach_trace unexpected error: -5=
24
> #413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:FAIL
> #413/17  tailcalls/tailcall_poke:OK
> #413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> #413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:FAIL
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> test_tailcall_hierarchy_count:PASS:open fexit_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fexit prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_hierarchy_count:PASS:load fexit_obj 0 nsec
> libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> #413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:FAIL
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> #413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:FAIL
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target entry 0 nsec
> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> #413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:FAIL
> #413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> #413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> test_tailcall_freplace:PASS:tailcall_freplace__open 0 nsec
> test_tailcall_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> test_tailcall_freplace:PASS:set_attach_target 0 nsec
> test_tailcall_freplace:PASS:tailcall_freplace__load 0 nsec
> test_tailcall_freplace:PASS:update jmp_table failure 0 nsec
> libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
> test_tailcall_freplace:FAIL:attach_freplace unexpected error: -524
> #413/25  tailcalls/tailcall_freplace:FAIL
> test_tailcall_bpf2bpf_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__open 0 nsec
> test_tailcall_bpf2bpf_freplace:PASS:set_attach_target 0 nsec
> test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__load 0 nsec
> libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
> test_tailcall_bpf2bpf_freplace:FAIL:attach_freplace unexpected error: -52=
4
> #413/26  tailcalls/tailcall_bpf2bpf_freplace:FAIL
> #413/27  tailcalls/tailcall_failure:OK
> #413/28  tailcalls/reject_tail_call_spin_lock:OK
> #413/29  tailcalls/reject_tail_call_rcu_lock:OK
> #413/30  tailcalls/reject_tail_call_preempt_lock:OK
> #413/31  tailcalls/reject_tail_call_ref:OK
> #413     tailcalls:FAIL
>
> All error logs:
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> test_tailcall_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_count:PASS:find fentry prog 0 nsec
> test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_count:FAIL:attach_trace unexpected error: -524
> #413/13  tailcalls/tailcall_bpf2bpf_fentry:FAIL
> test_tailcall_count:PASS:open fexit_obj file 0 nsec
> test_tailcall_count:PASS:find fexit prog 0 nsec
> test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_count:PASS:load fexit_obj 0 nsec
> libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> test_tailcall_count:FAIL:attach_trace unexpected error: -524
> #413/14  tailcalls/tailcall_bpf2bpf_fexit:FAIL
> test_tailcall_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_count:PASS:find fentry prog 0 nsec
> test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_count:FAIL:attach_trace unexpected error: -524
> #413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:FAIL
> test_tailcall_bpf2bpf_fentry_entry:PASS:load tgt_obj 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map fd 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog fd 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:update jmp_table 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:open fentry_obj file 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:find fentry prog 0 nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:set_attach_target classifier_0 0 =
nsec
> test_tailcall_bpf2bpf_fentry_entry:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_bpf2bpf_fentry_entry:FAIL:attach_trace unexpected error: -5=
24
> #413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:FAIL
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> #413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:FAIL
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> test_tailcall_hierarchy_count:PASS:open fexit_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fexit prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_hierarchy_count:PASS:load fexit_obj 0 nsec
> libbpf: prog 'fexit': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> #413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:FAIL
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> #413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:FAIL
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target entry 0 nsec
> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> libbpf: prog 'fentry': failed to attach: -ENOTSUPP
> test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> #413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:FAIL
> test_tailcall_freplace:PASS:tailcall_freplace__open 0 nsec
> test_tailcall_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> test_tailcall_freplace:PASS:set_attach_target 0 nsec
> test_tailcall_freplace:PASS:tailcall_freplace__load 0 nsec
> test_tailcall_freplace:PASS:update jmp_table failure 0 nsec
> libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
> test_tailcall_freplace:FAIL:attach_freplace unexpected error: -524
> #413/25  tailcalls/tailcall_freplace:FAIL
> test_tailcall_bpf2bpf_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
> test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__open 0 nsec
> test_tailcall_bpf2bpf_freplace:PASS:set_attach_target 0 nsec
> test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__load 0 nsec
> libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
> test_tailcall_bpf2bpf_freplace:FAIL:attach_freplace unexpected error: -52=
4
> #413/26  tailcalls/tailcall_bpf2bpf_freplace:FAIL
> #413     tailcalls:FAIL
> Summary: 0/21 PASSED, 0 SKIPPED, 1 FAILED
>
> v1:
> 1,Fix the jmp_offset calculation error in the emit_bpf_tail_call function=
.
> 2,Fix the issue that MAX_TAIL_CALL_CNT limit bypass in hybrid tailcall an=
d BPF-to-BPF call
>
> After applying this patch, testing results are as follows:
>
> ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_1
> 413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> 413     tailcalls:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_2
> 413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> 413     tailcalls:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_3
> 413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> 413     tailcalls:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Haoran Jiang (2):
>   LoongArch: BPF: Fix jump offset calculation in tailcall
>   LoongArch: BPF: Fix tailcall hierarchy
>
>  arch/loongarch/net/bpf_jit.c | 171 ++++++++++++++++++++++-------------
>  1 file changed, 110 insertions(+), 61 deletions(-)
>
> --
> 2.43.0
>
>

