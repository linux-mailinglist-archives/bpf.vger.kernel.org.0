Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF06F003F
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjD0Exm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 00:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbjD0Exl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:53:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8833C00
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:53:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f6461af24so6124002a12.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682571220; x=1685163220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2R6tt2nl6uT5ZfDXYJpEie2EbfEWDS2pGaF/xPLD3E=;
        b=oO2ahhQHzpLejN2oqfOUx5YxGlzOTQAzpwBJjYatxUhum5kNA0E8AitVGNeCPLhyH9
         N8xje5k9fm/8phV/+90AWWuyixiF6fyU+mIuyioiRfEhxXklhpqJZodU9+9N61weRxkh
         vYVzSLN+JUmbhrh0XEe3yd+oS0EY+wHtr2GhKnov54PMyhTLLzk/Z/SsGE31WZisuCY6
         juGDToOpeqsSsYHmrm0UXhDrFYdcIJsYhn2ryNUi0HTWpCxk5qIeaPc4NkGcmfMwutMa
         NUadfrbV73P1nOzLavxUBB1VqK1exj1mvzQpsO+pGyWemYiMOa5oTxAwNvAW6zNTT/Pg
         OtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682571220; x=1685163220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2R6tt2nl6uT5ZfDXYJpEie2EbfEWDS2pGaF/xPLD3E=;
        b=iwHlSwJ/Qnmh8D13X1g7TvJvFwZo7DALp8v0HfmlZTdp12VD5uXQHznLvTWBDvAzBT
         lrV7HSp65TtcTyT7tCrFCeCVtNM0dgTIoNl8XPfJ5KOhhSNQrT7EeS97EvC1l9ffPpm2
         SMZ1n9SGipacYggkP6wj5dxyJZhg1KLbNh2Whxzwj2kKR43F9GyiTFUfU8DHwLNWjZhi
         7YZp7Ub8Rl7uqKjvYYcRshNXmkFHgzFEnEEX0lohO+9U+SXs6Q9J0sAhuySVrGDDAN7p
         4S0j58Fsm5/h84wPizofYe0v/T8kI1pXNkNg2gPV7MejzjpX9z7dlSLCC0lMvqTW4A9M
         /sJQ==
X-Gm-Message-State: AC+VfDzyUnuIbxNE0V+2OmJKJ0nWMZHN1Y2WoZx+X7IXLYUCZ7UwAxe2
        c/PkLYE/cHbBU/1RZ+MWQok=
X-Google-Smtp-Source: ACHHUZ7zosORMg63/wdC63b4wg7+DzYdMPU9H1c7AE6MTilySdY+LL1056RFSQlQCB38Ep/MqwkBcg==
X-Received: by 2002:a05:6a20:160a:b0:f5:6cb8:105 with SMTP id l10-20020a056a20160a00b000f56cb80105mr349233pzj.45.1682571219832;
        Wed, 26 Apr 2023 21:53:39 -0700 (PDT)
Received: from google.com ([2601:647:6700:7f00:e02a:c35d:6131:2f58])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00174c00b00634b91326a9sm12557653pfc.143.2023.04.26.21.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 21:53:39 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:53:37 -0700
From:   Namhyung Kim <namhyung@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
Message-ID: <ZEn/EOnsH2RP//24@google.com>
References: <20230427001425.563232-1-namhyung@kernel.org>
 <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
 <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
 <CAEf4BzaZhjgPNaNH2yFxjZ-C+ZaSJRg9EWzOCcMOP-CV7kDHBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaZhjgPNaNH2yFxjZ-C+ZaSJRg9EWzOCcMOP-CV7kDHBA@mail.gmail.com>
X-Mutt-References: <CAEf4BzaZhjgPNaNH2yFxjZ-C+ZaSJRg9EWzOCcMOP-CV7kDHBA@mail.gmail.com>
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 09:26:59PM -0700, Andrii Nakryiko wrote:
> On Wed, Apr 26, 2023 at 7:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello Andrii,
> >
> > On Wed, Apr 26, 2023 at 6:19 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Apr 26, 2023 at 5:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I'm having a problem of loading perf lock contention BPF program [1]
> > > > on old kernels.  It has collect_lock_syms() to get the address of each
> > > > CPU's run-queue lock.  The kernel 5.14 changed the name of the field
> > > > so there's bpf_core_field_exists to check the name like below.
> > > >
> > > >         if (bpf_core_field_exists(rq_new->__lock))
> > > >                 lock_addr = (__u64)&rq_new->__lock;
> > > >         else
> > > >                 lock_addr = (__u64)&rq_old->lock;
> > >
> > > I suspect compiler rewrites it to something like
> > >
> > >    lock_addr = (__u64)&rq_old->lock;
> > >    if (bpf_core_field_exists(rq_new->__lock))
> > >         lock_addr = (__u64)&rq_new->__lock;
> > >
> > > so rq_old relocation always happens and ends up being not guarded
> > > properly. You can try adding barrier_var(rq_new) and
> > > barrier_var(rq_old) around if and inside branches, that should
> > > pessimize compiler
> > >
> > > alternatively if you do
> > >
> > > if (bpf_core_field_exists(rq_new->__lock))
> > >     lock_addr = (__u64)&rq_new->__lock;
> > > else if (bpf_core_field_exists(rq_old->lock))
> > >     lock_addr = (__u64)&rq_old->lock;
> > > else
> > >     lock_addr = 0; /* or signal error somehow */
> > >
> > > It might work as well.
> >
> > Thanks a lot for your comment!
> >
> > I've tried the below code but no luck. :(
> 
> Can you post an output of llvm-objdump -d <your.bpf.o> of the program
> (collect_lock_syms?) containing above code (or at least relevant
> portions with some buffer before/after to get a sense of what's going
> on)

Sure.

Here's the full source code:

  SEC("raw_tp/bpf_test_finish")
  int BPF_PROG(collect_lock_syms)
  {
	__u64 lock_addr;
	__u32 lock_flag;

	for (int i = 0; i < MAX_CPUS; i++) {
		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
		struct rq___new *rq_new = (void *)rq;
		struct rq___old *rq_old = (void *)rq;

		if (rq == NULL)
			break;

		barrier_var(rq_old);
		barrier_var(rq_new);

		if (bpf_core_field_exists(rq_old->lock)) {
			barrier_var(rq_old);
			lock_addr = (__u64)&rq_old->lock;
		} else if (bpf_core_field_exists(rq_new->__lock)) {
			barrier_var(rq_new);
			lock_addr = (__u64)&rq_new->__lock;
		} else
			continue;

		lock_flag = LOCK_CLASS_RQLOCK;
		bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
	}
	return 0;
  }

And the disassembly is:

  $ llvm-objdump -d util/bpf_skel/.tmp/lock_contention.bpf.o
  ...
  Disassembly of section raw_tp/bpf_test_finish:
  
  0000000000000000 <collect_lock_syms>:
       0:	b7 06 00 00 00 00 00 00	r6 = 0
       1:	b7 07 00 00 01 00 00 00	r7 = 1
       2:	b7 09 00 00 01 00 00 00	r9 = 1
       3:	b7 08 00 00 00 00 00 00	r8 = 0

  0000000000000020 <LBB3_1>:
       4:	18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r1 = 0 ll
       6:	bf 62 00 00 00 00 00 00	r2 = r6
       7:	85 00 00 00 99 00 00 00	call 153
       8:	15 00 12 00 00 00 00 00	if r0 == 0 goto +18 <LBB3_8>
       9:	bf 01 00 00 00 00 00 00	r1 = r0
      10:	15 07 12 00 00 00 00 00	if r7 == 0 goto +18 <LBB3_4>
      11:	0f 81 00 00 00 00 00 00	r1 += r8

  0000000000000060 <LBB3_6>:
      12:	63 9a f4 ff 00 00 00 00	*(u32 *)(r10 - 12) = r9
      13:	7b 1a f8 ff 00 00 00 00	*(u64 *)(r10 - 8) = r1
      14:	bf a2 00 00 00 00 00 00	r2 = r10
      15:	07 02 00 00 f8 ff ff ff	r2 += -8
      16:	bf a3 00 00 00 00 00 00	r3 = r10
      17:	07 03 00 00 f4 ff ff ff	r3 += -12
      18:	18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r1 = 0 ll
      20:	b7 04 00 00 00 00 00 00	r4 = 0
      21:	85 00 00 00 02 00 00 00	call 2

  00000000000000b0 <LBB3_7>:
      22:	07 06 00 00 01 00 00 00	r6 += 1
      23:	bf 61 00 00 00 00 00 00	r1 = r6
      24:	67 01 00 00 20 00 00 00	r1 <<= 32
      25:	77 01 00 00 20 00 00 00	r1 >>= 32
      26:	55 01 e9 ff 00 04 00 00	if r1 != 1024 goto -23 <LBB3_1>

  00000000000000d8 <LBB3_8>:
      27:	b7 00 00 00 00 00 00 00	r0 = 0
      28:	95 00 00 00 00 00 00 00	exit

  00000000000000e8 <LBB3_4>:
      29:	b7 01 00 00 01 00 00 00	r1 = 1
      30:	15 01 f7 ff 00 00 00 00	if r1 == 0 goto -9 <LBB3_7>
      31:	b7 01 00 00 00 00 00 00	r1 = 0
      32:	0f 10 00 00 00 00 00 00	r0 += r1
      33:	bf 01 00 00 00 00 00 00	r1 = r0
      34:	05 00 e9 ff 00 00 00 00	goto -23 <LBB3_6>

The error message is like this:

  libbpf: prog 'collect_lock_syms': BPF program load failed: Invalid argument
  libbpf: prog 'collect_lock_syms': -- BEGIN PROG LOAD LOG --
  reg type unsupported for arg#0 function collect_lock_syms#380
  0: R1=ctx(off=0,imm=0) R10=fp0
  ; int BPF_PROG(collect_lock_syms)
  0: (b7) r6 = 0                        ; R6_w=0
  1: (b7) r7 = 0                        ; R7_w=0
  2: (b7) r9 = 1                        ; R9_w=1
  3: <invalid CO-RE relocation>
  failed to resolve CO-RE relocation <byte_off> [381] struct rq___old.lock (0:0 @ offset 0)
  processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'collect_lock_syms': failed to load: -22
  libbpf: failed to load object 'lock_contention_bpf'
  libbpf: failed to load BPF skeleton 'lock_contention_bpf': -22
  Failed to load lock-contention BPF skeleton
  lock contention BPF setup failed


Thanks,
Namhyung


