Return-Path: <bpf+bounces-8763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14877899BE
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 00:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7551C20852
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAB1095C;
	Sat, 26 Aug 2023 22:49:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18129B0
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 22:49:54 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBA21AD
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:49:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so2996608a12.2
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693090191; x=1693694991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BReja5Ys9Ox/TZxHeYd8pbFB+CvxHd5lyy4LKpzkMVM=;
        b=hn1Z9z+jPwivtss8U0ZNdlGcuFBkagcAKjwEKatNgC/EjzgECoeltoPAW7SDs9zDfy
         dvV1/9MQizxVammJKW7LemZ2zw5S+ym2etkh+48kLkJK14d4Wtnwi1Wtrx2RY+D0tklv
         h1wP/O6vb6mx0ShfnNG5gxgDg1+STZaZvHsEBtmSrlycsOkO1bX60KfpRGuSve408bBV
         +BuCsJaB9RNXZUP1X9pzcxXvdHy+y0NNsKFlfy4S15ixE8rh/9n2Itq+/+ibirJHox3u
         4b4FWzpAtp+M8CYzuPHjQmyUWJcCJXbpoRDK8NefhsPxe0/gIbhwG4kVaoCzFd/LSZhL
         WuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693090191; x=1693694991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BReja5Ys9Ox/TZxHeYd8pbFB+CvxHd5lyy4LKpzkMVM=;
        b=YKSSumeqsbmWZ+ijoAFPXN+1Yc30cNmgqFrCDk/kBSAu99equSodi7zIw28kwjM0lI
         Lm8C97FNV8Q7t2LqObBAPc8t5YAPTXqkAV/3AQJUiEkYp4dKkg9BwvnIHK4dburdtauf
         HTNGyYtY2V/SSunh11tBPPKZqEffjiwRXZkJVREs5pnnxcKEjHPGIZxzjy//SrIrIgYu
         0Uw11k4kJEYrT5Cpm3kPxEnuSyIUJ+DiC4dZO0CjC/WkBvK7aR0fNzGMfM+O3h8jE3Qb
         ypFi7S7rlJhoA4UQ0dei6ZouShbfDj6M7Po2fJF4/FoWevVDikSqOPeLxq490l7QTWr2
         76vw==
X-Gm-Message-State: AOJu0Yz44CJxS1gpN+iFGNvSI8scPwTFOE+6ToURvRIdgJsmf2POz967
	jMzSyZSy7yG4IP+pXZuNPotwVhKyfayKOxTv6dk=
X-Google-Smtp-Source: AGHT+IHzCT1b0US5qDHcZAYLewkie72Gk9ZwIU+T3h5856yQDZCXVG2mLm8r5GKA26rLQVt2nwSfhxYwcU0HTBT3DK0=
X-Received: by 2002:aa7:cf09:0:b0:52a:1d54:2533 with SMTP id
 a9-20020aa7cf09000000b0052a1d542533mr10494363edy.9.1693090191211; Sat, 26 Aug
 2023 15:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev> <CAADnVQ+sthRd1CHtCNo=AKN7mXZEMkA5fS6zh-Ncbh8uC3FERQ@mail.gmail.com>
 <CAADnVQLg=hXhrjw6KW2xyHb7HOEFwn3+9qHFX3SpHQNeY2=qLg@mail.gmail.com> <CAEf4BzYNwGZbfLBeSWBhK5a3cSGOH6UBZBEVw6Y5=v7imP4pnQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYNwGZbfLBeSWBhK5a3cSGOH6UBZBEVw6Y5=v7imP4pnQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 27 Aug 2023 04:19:11 +0530
Message-ID: <CAP01T77eZx-y_gT1mOKdd=xPG4+PrSHPOF3qy-KRe2KGQcEO8A@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Dave Marchevsky <davemarchevsky@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 26 Aug 2023 at 03:01, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Fri, Aug 25, 2023 at 12:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Aug 25, 2023 at 11:53=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Aug 25, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> > > >
> > > >
> > > >
> > > > On 8/25/23 3:32 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> > > > > I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> > > > > selftests on bpf-next 9e3b47abeb8f.
> > > > >
> > > > > I'm able to reproduce the hang by multiple runs of:
> > > > >   | ./test_progs -a link_api -a linked_list
> > > > > I'm currently investigating that.
> > > > >
> > > > > But! Sometimes (every blue moon) I get a warn_on_once hit:
> > > > >   | ------------[ cut here ]------------
> > > > >   | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342 bpf_mem=
_refill+0x1fc/0x206
> > > > >   | Modules linked in: bpf_testmod(OE)
> > > > >   | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           OE=
    N 6.5.0-rc5-01743-gdcb152bb8328 #2
> > > > >   | Hardware name: riscv-virtio,qemu (DT)
> > > > >   | epc : bpf_mem_refill+0x1fc/0x206
> > > > >   |  ra : irq_work_single+0x68/0x70
> > > > >   | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff200000000=
1be20
> > > > >   |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 00000000000=
46600
> > > > >   |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff200000000=
1be70
> > > > >   |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef=
4b000
> > > > >   |  a2 : 000000000000003f a3 : ffffffff80008250 a4 : 00000000000=
00060
> > > > >   |  a5 : 0000000000000080 a6 : 0000000000000000 a7 : 00000000007=
35049
> > > > >   |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 00000000000=
01000
> > > > >   |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d=
6bd30
> > > > >   |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 00000000000=
0ffff
> > > > >   |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 00000000000=
00000
> > > > >   |  t5 : ff6000008fd28278 t6 : 0000000000040000
> > > > >   | status: 0000000200000100 badaddr: 0000000000000000 cause: 000=
0000000000003
> > > > >   | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
> > > > >   | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
> > > > >   | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
> > > > >   | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
> > > > >   | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
> > > > >   | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
> > > > >   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> > > > >   | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
> > > > >   | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
> > > > >   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> > > > >   | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
> > > > >   | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
> > > > >   | [<ffffffff812b6904>] do_irq+0x66/0x98
> > > > >   | ---[ end trace 0000000000000000 ]---
> > > > >
> > > > > Code:
> > > > >   | static void free_bulk(struct bpf_mem_cache *c)
> > > > >   | {
> > > > >   |   struct bpf_mem_cache *tgt =3D c->tgt;
> > > > >   |   struct llist_node *llnode, *t;
> > > > >   |   unsigned long flags;
> > > > >   |   int cnt;
> > > > >   |
> > > > >   |   WARN_ON_ONCE(tgt->unit_size !=3D c->unit_size);
> > > > >   | ...
> > > > >
> > > > > I'm not well versed in the memory allocator; Before I dive into i=
t --
> > > > > has anyone else hit it? Ideas on why the warn_on_once is hit?
> > > >
> > > > Maybe take a look at the patch
> > > >    822fb26bdb55  bpf: Add a hint to allocated objects.
> > > >
> > > > In the above patch, we have
> > > >
> > > > +       /*
> > > > +        * Remember bpf_mem_cache that allocated this object.
> > > > +        * The hint is not accurate.
> > > > +        */
> > > > +       c->tgt =3D *(struct bpf_mem_cache **)llnode;
> > > >
> > > > I suspect that the warning may be related to the above.
> > > > I tried the above ./test_progs command line (running multiple
> > > > at the same time) and didn't trigger the issue.
> > >
> > > Interesting. Thanks for the report.
> > > I wasn't able to repo the warn either, but I can confirm that linked_=
list
> > > test is super slow on the kernel with debugs on and may appear to "ha=
ng",
> > > since it doesn't respond to key press for many seconds.
> > >
> > > time ./test_progs -a linked_list
> > > Summary: 1/132 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > real    0m35.897s
> > > user    0m1.860s
> > > sys    0m32.105s
> > >
> > > That's not normal.
> > >
> > > Kumar, Dave,
> > >
> > > do you have any suggestions?
> >
> > Andrii,
> >
> > this issue seems to be a scalability issue with libbpf.
> > The perf report looks like:
> >
> >     9.89%  test_progs       [kernel.kallsyms]   [k] __lock_acquire
> >     7.70%  test_progs       [kernel.kallsyms]   [k] check_preemption_di=
sabled
> >     2.61%  test_progs       [kernel.kallsyms]   [k] asm_exc_page_fault
> >     2.32%  test_progs       [kernel.kallsyms]   [k] rcu_is_watching
> >     2.30%  test_progs       [kernel.kallsyms]   [k] memcpy_orig
> >     2.26%  test_progs       test_progs          [.] btf_find_by_name_ki=
nd
> >     2.18%  test_progs       libc-2.28.so        [.] __strcmp_avx2
> >     2.14%  test_progs       [kernel.kallsyms]   [k] lock_acquire
> >     2.10%  test_progs       [kernel.kallsyms]   [k] mark_lock.part.48
> >     2.07%  test_progs       test_progs          [.] btf_kind
> >     2.05%  test_progs       [kernel.kallsyms]   [k] clear_page_erms
> >     1.89%  test_progs       test_progs          [.] btf_type_by_id
> >     1.83%  test_progs       [kernel.kallsyms]   [k] lock_is_held_type
> >     1.75%  test_progs       [kernel.kallsyms]   [k] lock_release
> >     1.31%  test_progs       [kernel.kallsyms]   [k] unwind_next_frame
> >     1.29%  test_progs       test_progs          [.] btf__type_by_id
> >     1.28%  test_progs       [kernel.kallsyms]   [k] rep_movs_alternativ=
e
> >     1.09%  test_progs       [kernel.kallsyms]   [k] __orc_find
> >     1.06%  swapper          [kernel.kallsyms]   [k] __lock_acquire
> >     1.02%  test_progs       test_progs          [.] btf_type_size
> >     0.84%  test_progs       test_progs          [.] btf_parse_type_sec
> >     0.78%  test_progs       [kernel.kallsyms]   [k] __create_object
> >     0.76%  test_progs       [kernel.kallsyms]   [k] __lookup_object
> >     0.75%  test_progs       test_progs          [.] btf__str_by_offset
> >
> > The top 5 functions coming from kernel due to libbpf
> > reading /sys/kernel/btf/vmlinux
> > Then libbpf proceeded to do a search in btf.
>
> This test loads 132 skeletons/BPF objects sequentially. Each BPF
> object load should cause exactly one /sys/kernel/btf/vmlinux load. Do
> you see multiple vmlinux reads per BPF object?
>
> We then do a linear search for each ksym, so depending on the amount
> of ksyms, that can scale badly. But linked_list.bpf.o and
> linked_list_fail.bpf.o have only a few ksyms:
>
> [72] DATASEC '.ksyms' size=3D0 vlen=3D6
>         type_id=3D33 offset=3D0 size=3D0 (FUNC 'bpf_obj_new_impl')
>         type_id=3D37 offset=3D0 size=3D0 (FUNC 'bpf_list_pop_front')
>         type_id=3D39 offset=3D0 size=3D0 (FUNC 'bpf_obj_drop_impl')
>         type_id=3D41 offset=3D0 size=3D0 (FUNC 'bpf_list_pop_back')
>         type_id=3D43 offset=3D0 size=3D0 (FUNC 'bpf_list_push_front_impl'=
)
>         type_id=3D51 offset=3D0 size=3D0 (FUNC 'bpf_list_push_back_impl')
>
> We can improve this part by either pre-building hashmap index for BTF
> types or sorting all ksyms and then doing one linear pass over vmlinux
> BTF, binary searching. But so far it wasn't a big bottleneck in
> practice.
>
> And running this linked_list test on production kernel, it's not that
> slow, considering how much work it's doing:
>
> sudo ./test_progs -a linked_list  1.54s user 0.58s system 97% cpu 2.178 t=
otal
>
>
> Also, we are building sefltests+libbpf in debug mode. So I have worse
> news, with my BTF validation patch applied, this test becomes
> extremely slow, because all those 100+ vmlinux BTF parsings are now
> also doing a bunch of validation, and none of the added small static
> functions are inlined in debug mode. I need to look into this a bit
> more and see if I can mitigate this without switching all selftests to
> release mode.
>

Looking at Bjorn's update, I believe the problem is unrelated to the
linked_list test.
I think the main slowdown here is because of reopening the BPF object
having failed tests over and over for each specific program.
If we make it work so that the object is only opened once and each
failing program can be tested, we can avoid the slowdown.
If this makes sense, I can work on this improvement.

