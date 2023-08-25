Return-Path: <bpf+bounces-8684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7EA788F60
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9D628178E
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3219380;
	Fri, 25 Aug 2023 19:50:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C736322B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:50:13 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181702708
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:49:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso19174041fa.3
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692992987; x=1693597787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnEq+QAFMDWJdfRL6SvpHExJ+XohmGPH8a8o2WYRdhI=;
        b=corRmrPnMht4WuUYWTBWqZoA8BYpeIBZq7VxdtTHER4r5Ddn4d6tqnDII8io26TTd+
         +8w7h6O0D7JVOjUWVTaExA/jaPaUQLPuGUwglRw1MEKiYMrFa46UOUnFLPF7iRA1s5vr
         k3cICSDKSFP5k3hi/7UPW4sYQn9dDlnHYGxctCVG4FhlQzvhTWOv1d5ePIrZ8PypSEdg
         l7SFcoaccKfgtoXE4oTiyMlgSpJpnVfpCkk7Jy+w6BEVt+womyfUoi2p9JA+lzrTl7W8
         kz07Zw21P+/Zl6M7euJG2/JHgar1Bhy4WtmQWsnnJ57EHZVrr8/8ZvUQ3KgWU3qyX7xY
         Xs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692992987; x=1693597787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnEq+QAFMDWJdfRL6SvpHExJ+XohmGPH8a8o2WYRdhI=;
        b=bgxixF277bfXXUiyL2HaolFaOrCDvH4xg4zO3uPQnCqutF22ieQrUcYVIVjhujmWHm
         Nqd0gaDOzN/l5jUOP63/Gsn0YmrPFTQaO9it80dA6HbwWzV9Xznm+Cs2qE3QUdl64vfs
         O7is8Df2ePTSdDWgf8NAUMH+a0NewTOgavShfg0mFxgeHhYZbapYKm1pQC+G/gFe1VAI
         KWmf+4OQVgx0ZNAJEIWsneZc1u95zrXiZ7WDQJriIwZdnB7nMKkRTZNtebz3/kvwJjVq
         1Of1uvdRzLewdpdBAoL6JMN4OBax++HAg8VQ1T4jdI6PCFA4AHzE26xGS4arFeQxMrEd
         OyHg==
X-Gm-Message-State: AOJu0YxvCnKXiaP7fpBQe+epq5zcQWnW5g++Zxr7bR2Q0PzLWgDkZIWw
	vRUonEyn5q/hImKzYC7Vxw0nYh1DZifCPtafLSc=
X-Google-Smtp-Source: AGHT+IF/TMYxmq84SS3+CbMwx1j3YhZQmeH8M+oLp5x/c7VP/NkPiuykELxfZ/E1fHFXCkYvQzvrl8ho1R50EHcmsHg=
X-Received: by 2002:a2e:9153:0:b0:2bc:bef0:8612 with SMTP id
 q19-20020a2e9153000000b002bcbef08612mr12503755ljg.23.1692992987040; Fri, 25
 Aug 2023 12:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev> <CAADnVQ+sthRd1CHtCNo=AKN7mXZEMkA5fS6zh-Ncbh8uC3FERQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+sthRd1CHtCNo=AKN7mXZEMkA5fS6zh-Ncbh8uC3FERQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Aug 2023 12:49:35 -0700
Message-ID: <CAADnVQLg=hXhrjw6KW2xyHb7HOEFwn3+9qHFX3SpHQNeY2=qLg@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
To: Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 11:53=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 25, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> >
> > On 8/25/23 3:32 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> > > I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> > > selftests on bpf-next 9e3b47abeb8f.
> > >
> > > I'm able to reproduce the hang by multiple runs of:
> > >   | ./test_progs -a link_api -a linked_list
> > > I'm currently investigating that.
> > >
> > > But! Sometimes (every blue moon) I get a warn_on_once hit:
> > >   | ------------[ cut here ]------------
> > >   | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342 bpf_mem_ref=
ill+0x1fc/0x206
> > >   | Modules linked in: bpf_testmod(OE)
> > >   | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           OE    =
N 6.5.0-rc5-01743-gdcb152bb8328 #2
> > >   | Hardware name: riscv-virtio,qemu (DT)
> > >   | epc : bpf_mem_refill+0x1fc/0x206
> > >   |  ra : irq_work_single+0x68/0x70
> > >   | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001be2=
0
> > >   |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 000000000004660=
0
> > >   |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff2000000001be7=
0
> > >   |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef4b00=
0
> > >   |  a2 : 000000000000003f a3 : ffffffff80008250 a4 : 000000000000006=
0
> > >   |  a5 : 0000000000000080 a6 : 0000000000000000 a7 : 000000000073504=
9
> > >   |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 000000000000100=
0
> > >   |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d6bd3=
0
> > >   |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 000000000000fff=
f
> > >   |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 000000000000000=
0
> > >   |  t5 : ff6000008fd28278 t6 : 0000000000040000
> > >   | status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000=
000000003
> > >   | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
> > >   | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
> > >   | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
> > >   | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
> > >   | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
> > >   | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
> > >   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> > >   | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
> > >   | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
> > >   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> > >   | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
> > >   | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
> > >   | [<ffffffff812b6904>] do_irq+0x66/0x98
> > >   | ---[ end trace 0000000000000000 ]---
> > >
> > > Code:
> > >   | static void free_bulk(struct bpf_mem_cache *c)
> > >   | {
> > >   |   struct bpf_mem_cache *tgt =3D c->tgt;
> > >   |   struct llist_node *llnode, *t;
> > >   |   unsigned long flags;
> > >   |   int cnt;
> > >   |
> > >   |   WARN_ON_ONCE(tgt->unit_size !=3D c->unit_size);
> > >   | ...
> > >
> > > I'm not well versed in the memory allocator; Before I dive into it --
> > > has anyone else hit it? Ideas on why the warn_on_once is hit?
> >
> > Maybe take a look at the patch
> >    822fb26bdb55  bpf: Add a hint to allocated objects.
> >
> > In the above patch, we have
> >
> > +       /*
> > +        * Remember bpf_mem_cache that allocated this object.
> > +        * The hint is not accurate.
> > +        */
> > +       c->tgt =3D *(struct bpf_mem_cache **)llnode;
> >
> > I suspect that the warning may be related to the above.
> > I tried the above ./test_progs command line (running multiple
> > at the same time) and didn't trigger the issue.
>
> Interesting. Thanks for the report.
> I wasn't able to repo the warn either, but I can confirm that linked_list
> test is super slow on the kernel with debugs on and may appear to "hang",
> since it doesn't respond to key press for many seconds.
>
> time ./test_progs -a linked_list
> Summary: 1/132 PASSED, 0 SKIPPED, 0 FAILED
>
> real    0m35.897s
> user    0m1.860s
> sys    0m32.105s
>
> That's not normal.
>
> Kumar, Dave,
>
> do you have any suggestions?

Andrii,

this issue seems to be a scalability issue with libbpf.
The perf report looks like:

    9.89%  test_progs       [kernel.kallsyms]   [k] __lock_acquire
    7.70%  test_progs       [kernel.kallsyms]   [k] check_preemption_disabl=
ed
    2.61%  test_progs       [kernel.kallsyms]   [k] asm_exc_page_fault
    2.32%  test_progs       [kernel.kallsyms]   [k] rcu_is_watching
    2.30%  test_progs       [kernel.kallsyms]   [k] memcpy_orig
    2.26%  test_progs       test_progs          [.] btf_find_by_name_kind
    2.18%  test_progs       libc-2.28.so        [.] __strcmp_avx2
    2.14%  test_progs       [kernel.kallsyms]   [k] lock_acquire
    2.10%  test_progs       [kernel.kallsyms]   [k] mark_lock.part.48
    2.07%  test_progs       test_progs          [.] btf_kind
    2.05%  test_progs       [kernel.kallsyms]   [k] clear_page_erms
    1.89%  test_progs       test_progs          [.] btf_type_by_id
    1.83%  test_progs       [kernel.kallsyms]   [k] lock_is_held_type
    1.75%  test_progs       [kernel.kallsyms]   [k] lock_release
    1.31%  test_progs       [kernel.kallsyms]   [k] unwind_next_frame
    1.29%  test_progs       test_progs          [.] btf__type_by_id
    1.28%  test_progs       [kernel.kallsyms]   [k] rep_movs_alternative
    1.09%  test_progs       [kernel.kallsyms]   [k] __orc_find
    1.06%  swapper          [kernel.kallsyms]   [k] __lock_acquire
    1.02%  test_progs       test_progs          [.] btf_type_size
    0.84%  test_progs       test_progs          [.] btf_parse_type_sec
    0.78%  test_progs       [kernel.kallsyms]   [k] __create_object
    0.76%  test_progs       [kernel.kallsyms]   [k] __lookup_object
    0.75%  test_progs       test_progs          [.] btf__str_by_offset

The top 5 functions coming from kernel due to libbpf
reading /sys/kernel/btf/vmlinux
Then libbpf proceeded to do a search in btf.

Don't know whether libbpf is doing too many unnecessary reads on vmlinux bt=
f
or what is actually happening, but something isn't right.
This test shouldn't be causing libbpf to be the main consumer of cpu.
Not sure whether other tests are similarly affected.
This is what I've debugged so far.

