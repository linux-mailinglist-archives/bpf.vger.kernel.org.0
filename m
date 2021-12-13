Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE9473767
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhLMWW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 17:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbhLMWW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 17:22:28 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A75C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 14:22:27 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 131so41802691ybc.7
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 14:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOWsbJkGi5I0FeRSfy/7CYLTQfYfVpKociBwq5gcQio=;
        b=jWyw/3iqhrm0zZg23tS99fCQmyzXWygmBp8fDLh4J7UWpPlIFDap1hM4iEVbpf7Fgz
         UCqaAAbaqK181NMV3Ias/4njskRbAPc0WOs0NA9W/FydAwj5H7Xiuh1H46OhCTTgXqai
         8p0Aro1YrTIL1mrM9wTnT744ac8sKCjjICJ/iheFfhfz5JKvcUnfVI+LWPk+9HK6sF56
         /Th1Tw3leG8mPnQMc/jOZ8ZUCoIsB7FMlyMibh3FZ8WaWNCBGR1bP2xytURnzbPF/hCJ
         /tKLf+yaoLTVSxXEk5HZEBA4qFMegA9Nu3x+i0ltuT5S1RsxhlhYVm8879wni9kYUWaP
         dUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOWsbJkGi5I0FeRSfy/7CYLTQfYfVpKociBwq5gcQio=;
        b=nmXKYFxzLIG/TWQer4eWAMr7muH/Wg/M0tvC4/oFu6z68LlFzeLoCgA55cayf0T7Ed
         M1YZgMnlxZHX67EXG/ZJe5nP1V0bu/W/CgS2CD9tpb7qh1lgucSKV4JAlQ71Fp6FFqFi
         l7D/JUaR29Q4dzGIOcxBqes0n3YAJzB6OKYA/zbFfsqaJ0YlY5GKEYUb2yWokSFMPiVG
         jEvrC215mbbJPsrmZKcNv6EM691DSn0x9ggwuRjhlAZOFccIciwhVuypwTze8NBt9mFa
         ytRa9lTBvMLfku/eOENGMo0dnwe3HlyWaZ8TtNb37c1WV8PlTqLv2C73l7xaxvY17gjd
         dfrg==
X-Gm-Message-State: AOAM5339ehus5B1LHzvzKsq1UIAo5xCmYnxo9h7sxb4OAsqwdnld0EEY
        ivcAxPN5pRpfFXZ4kanfwKL39fnUDlFtPYjGHus=
X-Google-Smtp-Source: ABdhPJxyvZvDuQ1bynpoMKA1pjLakKUEfsMDqMtE2MDsU0UzAfFedIlouQyIXhxnBXPXj2tYiub5iky5b1LvZKKjD6E=
X-Received: by 2002:a25:e406:: with SMTP id b6mr1508854ybh.529.1639434147029;
 Mon, 13 Dec 2021 14:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20211211003608.2764928-1-kuifeng@fb.com> <20211211003608.2764928-2-kuifeng@fb.com>
 <CAEf4BzZsJkMnD167H9SpV9HywNsNm=rSEhqdhzPCAtaWwemycw@mail.gmail.com>
In-Reply-To: <CAEf4BzZsJkMnD167H9SpV9HywNsNm=rSEhqdhzPCAtaWwemycw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Dec 2021 14:22:15 -0800
Message-ID: <CAEf4BzYvZOB5ZaSm=Ye5Y8JX2oew3h4UvrKmSoKMo5tPKb1AFw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] selftests/bpf: Stop using
 bpf_object__find_program_by_title API.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 13, 2021 at 2:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 10, 2021 at 4:36 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > bpf_object__find_program_by_title is going to be deprecated.  Replace
> > all use cases in tools/testing/selftests/bpf with
> > bpf_object__find_program_by_name.
> >
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
>
> seems like these changes are breaking one selftest. Here's partial
> failure, please take a look and fix.

Actually, it seems BPF CI is back up, so you can see full logs at [0] as well.

  [0] https://github.com/kernel-patches/bpf/runs/4510836943?check_suite_focus=true

>
> #48/3 fexit_bpf2bpf/func_replace:FAIL
> test_fexit_bpf2bpf_common:PASS:tgt_prog_load 0 nsec
> test_fexit_bpf2bpf_common:PASS:tgt_fd_get_info 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_ptr 0 nsec
> test_fexit_bpf2bpf_common:PASS:prog_ptr 0 nsec
> test_fexit_bpf2bpf_common:PASS:obj_open 0 nsec
> test_fexit_bpf2bpf_common:PASS:set_attach_target 0 nsec
> test_fexit_bpf2bpf_common:PASS:obj_load 0 nsec
> test_fexit_bpf2bpf_common:PASS:new_do_bind 0 nsec
> test_fexit_bpf2bpf_common:PASS:attach_trace 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_fd_get_info 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_attach_type 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_tgt_obj_id 0 nsec
> test_fexit_bpf2bpf_common:FAIL:link_tgt_btf_id unexpected
> link_tgt_btf_id: actual 11 != expected -2
> #48/4 fexit_bpf2bpf/func_replace_verify:FAIL
> test_fexit_bpf2bpf_common:PASS:tgt_prog_load 0 nsec
> test_fexit_bpf2bpf_common:PASS:tgt_fd_get_info 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_ptr 0 nsec
> test_fexit_bpf2bpf_common:PASS:prog_ptr 0 nsec
> test_fexit_bpf2bpf_common:PASS:obj_open 0 nsec
> test_fexit_bpf2bpf_common:PASS:set_attach_target 0 nsec
> test_fexit_bpf2bpf_common:PASS:obj_load 0 nsec
> test_fexit_bpf2bpf_common:PASS:freplace_cls_redirect_test 0 nsec
> test_fexit_bpf2bpf_common:PASS:attach_trace 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_fd_get_info 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_attach_type 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_tgt_obj_id 0 nsec
> test_fexit_bpf2bpf_common:FAIL:link_tgt_btf_id unexpected
> link_tgt_btf_id: actual 28 != expected -2
> #48/5 fexit_bpf2bpf/func_sockmap_update:FAIL
> test_obj_load_failure_common:PASS:tgt_prog_load 0 nsec
> test_obj_load_failure_common:PASS:obj_open 0 nsec
> test_obj_load_failure_common:PASS:set_attach_target 0 nsec
> libbpf: prog 'new_connect_v4_prog': BPF program load failed: Invalid argument
> libbpf: prog 'new_connect_v4_prog': -- BEGIN PROG LOAD LOG --
> Validating new_connect_v4_prog() func#0...
> ; return 255;
> 0: (b4) w0 = 255
> 1: (95) exit
> At program exit the register R0 has value (0xff; 0x0) should have been
> in (0x0; 0x1)
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: failed to load program 'new_connect_v4_prog'
> libbpf: failed to load object './freplace_connect_v4_prog.o'
> test_obj_load_failure_common:PASS:bpf_obj_load should fail 0 nsec
> #48/6 fexit_bpf2bpf/func_replace_return_code:OK
> test_obj_load_failure_common:PASS:tgt_prog_load 0 nsec
> test_obj_load_failure_common:PASS:obj_open 0 nsec
> test_obj_load_failure_common:PASS:set_attach_target 0 nsec
> libbpf: prog 'new_handle_kprobe': BPF program load failed: Invalid argument
> libbpf: prog 'new_handle_kprobe': -- BEGIN PROG LOAD LOG --
> Cannot replace static functions
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: failed to load program 'new_handle_kprobe'
> libbpf: failed to load object './freplace_attach_probe.o'
> test_obj_load_failure_common:PASS:bpf_obj_load should fail 0 nsec
> #48/7 fexit_bpf2bpf/func_map_prog_compatibility:OK
> test_fexit_bpf2bpf_common:PASS:tgt_prog_load 0 nsec
> test_fexit_bpf2bpf_common:PASS:tgt_fd_get_info 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_ptr 0 nsec
> test_fexit_bpf2bpf_common:PASS:prog_ptr 0 nsec
> test_fexit_bpf2bpf_common:PASS:obj_open 0 nsec
> test_fexit_bpf2bpf_common:PASS:set_attach_target 0 nsec
> test_fexit_bpf2bpf_common:PASS:obj_load 0 nsec
> test_fexit_bpf2bpf_common:PASS:security_new_get_constant 0 nsec
> test_fexit_bpf2bpf_common:PASS:attach_trace 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_fd_get_info 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_attach_type 0 nsec
> test_fexit_bpf2bpf_common:PASS:link_tgt_obj_id 0 nsec
> test_fexit_bpf2bpf_common:FAIL:link_tgt_btf_id unexpected
> link_tgt_btf_id: actual 19 != expected -2
> test_second_attach:PASS:find_prog 0 nsec
> test_second_attach:PASS:second_prog_load 0 nsec
> test_second_attach:PASS:second_link 0 nsec
> test_second_attach:PASS:ipv6 885 nsec
> check_data_map:PASS:alloc_memory 0 nsec
> check_data_map:PASS:find_data_map 0 nsec
> check_data_map:PASS:get_result 0 nsec
> check_data_map:PASS:result 0 nsec
> check_data_map:PASS:reset_result 0 nsec
> test_fexit_bpf2bpf_common:PASS:prog_run 0 nsec
> test_fexit_bpf2bpf_common:PASS:prog_run_ret 0 nsec
> check_data_map:PASS:alloc_memory 0 nsec
> check_data_map:PASS:find_data_map 0 nsec
> check_data_map:PASS:get_result 0 nsec
> check_data_map:PASS:result 0 nsec
> #48/8 fexit_bpf2bpf/func_replace_multi:FAIL
> test_fmod_ret_freplace:PASS:tgt_prog_load 0 nsec
> test_fmod_ret_freplace:PASS:freplace_obj_open 0 nsec
> test_fmod_ret_freplace:PASS:freplace__set_attach_target 0 nsec
> test_fmod_ret_freplace:PASS:freplace_obj_load 0 nsec
> test_fmod_ret_freplace:PASS:freplace_attach_trace 0 nsec
> test_fmod_ret_freplace:PASS:fmod_obj_open 0 nsec
> test_fmod_ret_freplace:PASS:fmod_ret_set_attach_target 0 nsec
> libbpf: prog 'fmod_ret_test': BPF program load failed: Invalid argument
> libbpf: prog 'fmod_ret_test': -- BEGIN PROG LOAD LOG --
> can't modify return codes of BPF programs
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: failed to load program 'fmod_ret_test'
> libbpf: failed to load object './fmod_ret_freplace.o'
> test_fmod_ret_freplace:PASS:fmod_obj_load 0 nsec
> #48/9 fexit_bpf2bpf/fmod_ret_freplace:OK
> Summary: 0/3 PASSED, 0 SKIPPED, 1 FAILED
>
>
> >  .../selftests/bpf/prog_tests/bpf_obj_id.c     |  4 +-
> >  .../bpf/prog_tests/connect_force_port.c       | 18 ++---
> >  .../selftests/bpf/prog_tests/core_reloc.c     | 79 +++++++++++++------
> >  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 46 +++++------
> >  .../bpf/prog_tests/get_stack_raw_tp.c         |  4 +-
> >  .../bpf/prog_tests/sockopt_inherit.c          | 15 ++--
> >  .../selftests/bpf/prog_tests/stacktrace_map.c |  4 +-
> >  .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  4 +-
> >  .../selftests/bpf/prog_tests/test_overhead.c  | 20 ++---
> >  .../bpf/prog_tests/trampoline_count.c         |  6 +-
> >  10 files changed, 112 insertions(+), 88 deletions(-)
> >
>
> [...]
