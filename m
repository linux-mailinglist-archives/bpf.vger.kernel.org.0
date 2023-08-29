Return-Path: <bpf+bounces-8922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6176678C892
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A028124D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35417AD2;
	Tue, 29 Aug 2023 15:26:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFB14F6B
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 15:26:46 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA831B4
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:26:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so66937121fa.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693322780; x=1693927580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50mcfLiz7pKWihf7pV3Nv61gQMWu7yH2UtWWZoG6nBE=;
        b=n2Ax+nu4E6n0M8RHIlS6y0bBossY0+RHgL46fhS1bWKI9ZN+LzgasdQ9kwq93aQttc
         IJCaKThjPz1WZp2nozneLWyyJ1c9X+XRR2bw9LNoh03nGeDunWF6lG589pzpglPBQ7RN
         QGtf+BITjchsrF8jsZkzoBV7MBpxcLDwvaf1L5aV/x+byl/JTtFLw3hfjSVrRFa7bRCO
         tygCnl2BzATlmW39QunED6123ct6PseRMga6rNKfVDxBCEKAEKPGYvTWKtT/5HEaI+RN
         Jcqh5M2q7yEcp9XIKuWf6gW+YslptXn/qIDfeRAJ4B2eycLhxfor0KE7xlsMR5ZHK4EF
         paiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693322780; x=1693927580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50mcfLiz7pKWihf7pV3Nv61gQMWu7yH2UtWWZoG6nBE=;
        b=VI0dHljcpsfCJXvLWwIqlhVx8wts9xlH/5BZA0jWBYlBTumRA9MD/rgH5rK25CpD1W
         24zomWZbTZ4TdNHkbbnYIhtexjSgIzinJJ2NdfgaHt79XsNVdM+ijA3uLt9QGqvN9dWp
         y8fMCeFSuOH5BguFJzLgCzrnfwunmFSYPjZUsccSaX4qO8tZzgdTb/mF7rSdXdCnbJVr
         /GUuuMq02SsYs6twgFLMZtpUhu5gk4ZkrR0XZQgejN+47xNMkUbmscXJzeyUyjL+ehfj
         ghr4p7bMqbwAG5bAZNehYvwjlj0ocsEfo/VmxigHK+2ZaqS4kOOSCcpTvY8X+1PU9qaq
         IJog==
X-Gm-Message-State: AOJu0Yy5qNZNoK033T8QxJKnxW7P40FNy3W2Nv4EP5icVi0n5HY80qDd
	r+Qw4z7rTS8NgBqq4cYzjBI8D/lxzfYvGDlmJEc=
X-Google-Smtp-Source: AGHT+IF5uePVMV9wlzk8ZmlVAfyZNGnD6jtBJ3lU/97ukwTNrH6W1enYQVNX0c/Glt34Ri1jPiCs7z7hmg84tekrxas=
X-Received: by 2002:a2e:b5b7:0:b0:2bc:f9d0:c3d7 with SMTP id
 f23-20020a2eb5b7000000b002bcf9d0c3d7mr7419473ljn.3.1693322780067; Tue, 29 Aug
 2023 08:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev> <200dcce6-34ff-83e0-02fb-709a24403cc6@huaweicloud.com>
 <87zg2e88ds.fsf@all.your.base.are.belong.to.us> <64873e42-9be1-1812-b80d-5ea86b4677f0@huaweicloud.com>
 <87sf8684ex.fsf@all.your.base.are.belong.to.us> <878r9wswwy.fsf@all.your.base.are.belong.to.us>
 <fd07e0a3-f4da-b447-c47a-6e933220d452@linux.dev> <65c9e8d9-7682-2c8d-cd4d-9f0ca1213066@huaweicloud.com>
In-Reply-To: <65c9e8d9-7682-2c8d-cd4d-9f0ca1213066@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Aug 2023 08:26:08 -0700
Message-ID: <CAADnVQJGVJCh=i1tuov4t1MmUx5=ybjF544i4F4m-SbHd5N6vA@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
To: Hou Tao <houtao@huaweicloud.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 6:57=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/27/2023 10:53 PM, Yonghong Song wrote:
> >
> >
> > On 8/27/23 1:37 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> >> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
> >>
> >>> Hou Tao <houtao@huaweicloud.com> writes:
> >>>
> >>>> Hi,
> >>>>
> >>>> On 8/26/2023 5:23 PM, Bj=C3=B6rn T=C3=B6pel wrote:
> >>>>> Hou Tao <houtao@huaweicloud.com> writes:
> >>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 8/25/2023 11:28 PM, Yonghong Song wrote:
> >>>>>>>
> >>>>>>> On 8/25/23 3:32 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> >>>>>>>> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> >>>>>>>> selftests on bpf-next 9e3b47abeb8f.
> >>>>>>>>
> >>>>>>>> I'm able to reproduce the hang by multiple runs of:
> >>>>>>>>    | ./test_progs -a link_api -a linked_list
> >>>>>>>> I'm currently investigating that.
> >>>>>>>>
> >>>>>>>> But! Sometimes (every blue moon) I get a warn_on_once hit:
> >>>>>>>>    | ------------[ cut here ]------------
> >>>>>>>>    | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
> >>>>>>>> bpf_mem_refill+0x1fc/0x206
> >>>>>>>>    | Modules linked in: bpf_testmod(OE)
> >>>>>>>>    | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           =
OE
> >>>>>>>> N 6.5.0-rc5-01743-gdcb152bb8328 #2
> >>>>>>>>    | Hardware name: riscv-virtio,qemu (DT)
> >>>>>>>>    | epc : bpf_mem_refill+0x1fc/0x206
> >>>>>>>>    |  ra : irq_work_single+0x68/0x70
> >>>>>>>>    | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp :
> >>>>>>>> ff2000000001be20
> >>>>>>>>    |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 :
> >>>>>>>> 0000000000046600
> >>>>>>>>    |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 :
> >>>>>>>> ff2000000001be70
> >>>>>>>>    |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 :
> >>>>>>>> ff600003fef4b000
> >>>>>>>>    |  a2 : 000000000000003f a3 : ffffffff80008250 a4 :
> >>>>>>>> 0000000000000060
> >>>>>>>>    |  a5 : 0000000000000080 a6 : 0000000000000000 a7 :
> >>>>>>>> 0000000000735049
> >>>>>>>>    |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 :
> >>>>>>>> 0000000000001000
> >>>>>>>>    |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 :
> >>>>>>>> ffffffff82d6bd30
> >>>>>>>>    |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10:
> >>>>>>>> 000000000000ffff
> >>>>>>>>    |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 :
> >>>>>>>> 0000000000000000
> >>>>>>>>    |  t5 : ff6000008fd28278 t6 : 0000000000040000
> >>>>>>>>    | status: 0000000200000100 badaddr: 0000000000000000 cause:
> >>>>>>>> 0000000000000003
> >>>>>>>>    | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
> >>>>>>>>    | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
> >>>>>>>>    | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
> >>>>>>>>    | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
> >>>>>>>>    | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
> >>>>>>>>    | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
> >>>>>>>>    | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> >>>>>>>>    | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
> >>>>>>>>    | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
> >>>>>>>>    | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> >>>>>>>>    | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
> >>>>>>>>    | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
> >>>>>>>>    | [<ffffffff812b6904>] do_irq+0x66/0x98
> >>>>>>>>    | ---[ end trace 0000000000000000 ]---
> >>>>>>>>
> >>>>>>>> Code:
> >>>>>>>>    | static void free_bulk(struct bpf_mem_cache *c)
> >>>>>>>>    | {
> >>>>>>>>    |     struct bpf_mem_cache *tgt =3D c->tgt;
> >>>>>>>>    |     struct llist_node *llnode, *t;
> >>>>>>>>    |     unsigned long flags;
> >>>>>>>>    |     int cnt;
> >>>>>>>>    |
> >>>>>>>>    |     WARN_ON_ONCE(tgt->unit_size !=3D c->unit_size);
> >>>>>>>>    | ...
> >>>>>>>>
> >>>>>>>> I'm not well versed in the memory allocator; Before I dive into
> >>>>>>>> it --
> >>>>>>>> has anyone else hit it? Ideas on why the warn_on_once is hit?
> >>>>>>> Maybe take a look at the patch
> >>>>>>>    822fb26bdb55  bpf: Add a hint to allocated objects.
> >>>>>>>
> >>>>>>> In the above patch, we have
> >>>>>>>
> >>>>>>> +       /*
> >>>>>>> +        * Remember bpf_mem_cache that allocated this object.
> >>>>>>> +        * The hint is not accurate.
> >>>>>>> +        */
> >>>>>>> +       c->tgt =3D *(struct bpf_mem_cache **)llnode;
> >>>>>>>
> >>>>>>> I suspect that the warning may be related to the above.
> >>>>>>> I tried the above ./test_progs command line (running multiple
> >>>>>>> at the same time) and didn't trigger the issue.
> >>>>>> The extra 8-bytes before the freed pointer is used to save the
> >>>>>> pointer
> >>>>>> of the original bpf memory allocator where the freed pointer came
> >>>>>> from,
> >>>>>> so unit_free() could free the pointer back to the original
> >>>>>> allocator to
> >>>>>> prevent alloc-and-free unbalance.
> >>>>>>
> >>>>>> I suspect that a wrong pointer was passed to bpf_obj_drop, but do
> >>>>>> not
> >>>>>> find anything suspicious after checking linked_list. Another
> >>>>>> possibility
> >>>>>> is that there is write-after-free problem which corrupts the extra
> >>>>>> 8-bytes before the freed pointer. Could you please apply the
> >>>>>> following
> >>>>>> debug patch to check whether or not the extra 8-bytes are
> >>>>>> corrupted ?
> >>>>> Thanks for getting back!
> >>>>>
> >>>>> I took your patch for a run, and there's a hit:
> >>>>>    | bad cache ff5ffffffffe8570: got size 96 work
> >>>>> ffffffff801b19c8, cache ff5ffffffffe8980 exp size 128 work
> >>>>> ffffffff801b19c8
> >>>>
> >>>> The extra 8-bytes are not corrupted. Both of these two
> >>>> bpf_mem_cache are
> >>>> valid and there are in the cache array defined in bpf_mem_caches. BP=
F
> >>>> memory allocator allocated the pointer from 96-bytes sized-cache,
> >>>> but it
> >>>> tried to free the pointer through 128-bytes sized-cache.
> >>>>
> >>>> Now I suspect there is no 96-bytes slab in your system and ksize(ptr=
 -
> >>>> LLIST_NODE_SZ) returns 128, so bpf memory allocator selected the
> >>>> 128-byte sized-cache instead of 96-bytes sized-cache. Could you plea=
se
> >>>> check the value of KMALLOC_MIN_SIZE in your kernel .config and
> >>>> using the
> >>>> following command to check whether there is 96-bytes slab in your
> >>>> system:
> >>>
> >>> KMALLOC_MIN_SIZE is 64.
> >>>
> >>>> $ cat /proc/slabinfo |grep kmalloc-96
> >>>> dma-kmalloc-96         0      0     96   42    1 : tunables    0    =
0
> >>>> 0 : slabdata      0      0      0
> >>>> kmalloc-96          1865   2268     96   42    1 : tunables    0    =
0
> >>>> 0 : slabdata     54     54      0
> >>>>
> >>>> In my system, slab has 96-bytes cached, so grep outputs something,
> >>>> but I
> >>>> think there will no output in your system.
> >>>
> >>> You're right! No kmalloc-96.
> >>
> >> To get rid of the warning, limit available sizes from
> >> bpf_mem_alloc_init()?
>
> It is not enough. We need to adjust size_index accordingly during
> initialization. Could you please try the attached patch below ? It is
> not a formal patch and I am considering to disable prefilling for these
> redirected bpf_mem_caches.
> >
> > Do you know why your system does not have kmalloc-96?
>
> According to the implementation of setup_kmalloc_cache_index_table() and
> create_kmalloc_caches(),  when KMALLOC_MIN_SIZE is greater than 64,
> kmalloc-96 will be omitted. If KMALLOC_MIN_SIZE is greater than 128,
> kmalloc-192 will be omitted as well.

Great catch. The fix looks good.
Please submit it officially and add an error check to bpf_mem_alloc_init()
that verifies that ksize() matches the expectations.
The alternative is to use kmalloc_size_roundup() during alloc for
checking instead of ksize().
Technically we can use kmalloc_size_roundup in unit_alloc() and avoid
setup_kmalloc_cache_index_table()-like copy paste, but performance
overhead might be too high.
So your patch + error check at bpf_mem_alloc_init() is preferred.

