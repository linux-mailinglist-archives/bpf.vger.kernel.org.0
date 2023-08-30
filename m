Return-Path: <bpf+bounces-9003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82E478E128
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D435280FFF
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF594846A;
	Wed, 30 Aug 2023 21:07:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355B747D
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 21:07:53 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F2CF4
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 14:07:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso4371791fa.1
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693429529; x=1694034329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE091EAMyBUkgqinpZjH9mkYDXTVY9tjdEA2YqEI9+o=;
        b=Z2OhtZxOfIvcWSvnMj88WkKv53GHfW7ttx+e3HvWK9nHES7TUqH03ao3odsvuS4nDS
         rpGxXsbLaq2Vf8s1yaJm7PQ7h0aGartLCbZOWj7WYx7/oMPSV7/SVKpqHsVfpK49dXh5
         hXJkDZFi3kvEYZ9NaifufC4C15u7rOzxg3ctl2LwtXLKomdMg5ElCGztV85TtC2OFFST
         qFzJJFPfHPqOzu0uVSj17XJ+kQgfd1WHpWDoSEzsVjdE+X55I0jt8wrOq41cNGUH51qn
         gXc/rQvZwLLVOqnrFXqBYpE7C6Wb9Mqn/AVYEQzDEEtTaf2XcCPZmE2NZVcMWDYsLPVt
         Nr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429529; x=1694034329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE091EAMyBUkgqinpZjH9mkYDXTVY9tjdEA2YqEI9+o=;
        b=gzEqKxLFPhrcBlcQlIEvAvCkn8Y43slloDfwt6QWAuEVnmivCyLFW2Fgi2JqCW5+ZI
         Je7PVLoLKyErXHnoVWCJeWQJ2YJ/wuIuQpuq+syv//IIUSAW9ljp/J0L9VXVBzbrafvG
         SYr7iswK6wKfUA2xCuo1JsZ7br3xo6A5rEP3/v+B+39N0GJV1mE9Abg8sA/4n5I+STUv
         zYwFDN9KCbvQyRcg3RCIxPYmitiVx0MlokWsHtCxk6JFSSUmAuC4RpXlHRnPf7HRDqOU
         //OZODwoX8bz+ihCH3Z0Y4mrCn5D/ordGicxL6M33W4txFi1IxGqgazBSrrNNSrjI8IL
         yHgA==
X-Gm-Message-State: AOJu0Yyx31LELD5Bx8D0SdEARwOwhbbLpFl9rCv9FkvAGMYaf6d9UvFo
	MOoB09klY/EHubsLNG+hzxoO0GLoSN75dA1vnAlKq40NY+I=
X-Google-Smtp-Source: AGHT+IHzyDVjRy2AE3OelchKTho4bCvxzRnsVwCW99+Y1Zk3iNfcE6dC3PaMjb0rp+5CHdDS0fs1kcngazPXjEqAgEA=
X-Received: by 2002:a2e:9f50:0:b0:2bd:1d02:5026 with SMTP id
 v16-20020a2e9f50000000b002bd1d025026mr2644298ljk.15.1693429528758; Wed, 30
 Aug 2023 14:05:28 -0700 (PDT)
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
 <CAADnVQJGVJCh=i1tuov4t1MmUx5=ybjF544i4F4m-SbHd5N6vA@mail.gmail.com> <76151038-155d-eac7-d6bb-d569c69fca3d@huaweicloud.com>
In-Reply-To: <76151038-155d-eac7-d6bb-d569c69fca3d@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Aug 2023 14:05:17 -0700
Message-ID: <CAADnVQK-syC0MBOR1eg_xp3kkhOcojHv1OT4eDu3=u1CekOTtA@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
To: Hou Tao <houtao@huaweicloud.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 5:09=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/29/2023 11:26 PM, Alexei Starovoitov wrote:
> > On Mon, Aug 28, 2023 at 6:57=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 8/27/2023 10:53 PM, Yonghong Song wrote:
> >>>
> >>> On 8/27/23 1:37 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> >>>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
> >>>>
> >>>>> Hou Tao <houtao@huaweicloud.com> writes:
> >>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 8/26/2023 5:23 PM, Bj=C3=B6rn T=C3=B6pel wrote:
> >>>>>>> Hou Tao <houtao@huaweicloud.com> writes:
> >>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On 8/25/2023 11:28 PM, Yonghong Song wrote:
> >>>>>>>>> On 8/25/23 3:32 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> >>>>>>>>>> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the b=
pf
> >>>>>>>>>> selftests on bpf-next 9e3b47abeb8f.
> >>>>>>>>>>
> >>>>>>>>>> I'm able to reproduce the hang by multiple runs of:
> >>>>>>>>>>    | ./test_progs -a link_api -a linked_list
> >>>>>>>>>> I'm currently investigating that.
> >>>>>>>>>>
> >>>>>>>>>> But! Sometimes (every blue moon) I get a warn_on_once hit:
> >>>>>>>>>>    | ------------[ cut here ]------------
> >>>>>>>>>>    | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
> >>>>>>>>>> bpf_mem_refill+0x1fc/0x206
> >>>>>>>>>>    | Modules linked in: bpf_testmod(OE)
> >>>>>>>>>>    | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G         =
  OE
> >>>>>>>>>> N 6.5.0-rc5-01743-gdcb152bb8328 #2
> >>>>>>>>>>    | Hardware name: riscv-virtio,qemu (DT)
> >>>>>>>>>>    | epc : bpf_mem_refill+0x1fc/0x206
> >>>>>>>>>>    |  ra : irq_work_single+0x68/0x70
> >>>>>>>>>>    | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp :
> >>>>>>>>>> ff2000000001be20
> >>>>>>>>>>    |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 :
> >>>>>>>>>> 0000000000046600
> >>>>>>>>>>    |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 :
> >>>>>>>>>> ff2000000001be70
> >>>>>>>>>>    |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 :
> >>>>>>>>>> ff600003fef4b000
> >>>>>>>>>>    |  a2 : 000000000000003f a3 : ffffffff80008250 a4 :
> >>>>>>>>>> 0000000000000060
> >>>>>>>>>>    |  a5 : 0000000000000080 a6 : 0000000000000000 a7 :
> >>>>>>>>>> 0000000000735049
> >>>>>>>>>>    |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 :
> >>>>>>>>>> 0000000000001000
> >>>>>>>>>>    |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 :
> >>>>>>>>>> ffffffff82d6bd30
> >>>>>>>>>>    |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10:
> >>>>>>>>>> 000000000000ffff
> >>>>>>>>>>    |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 :
> >>>>>>>>>> 0000000000000000
> >>>>>>>>>>    |  t5 : ff6000008fd28278 t6 : 0000000000040000
> >>>>>>>>>>    | status: 0000000200000100 badaddr: 0000000000000000 cause:
> >>>>>>>>>> 0000000000000003
> >>>>>>>>>>    | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
> >>>>>>>>>>    | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
> >>>>>>>>>>    | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
> >>>>>>>>>>    | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
> >>>>>>>>>>    | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
> >>>>>>>>>>    | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
> >>>>>>>>>>    | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> >>>>>>>>>>    | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
> >>>>>>>>>>    | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
> >>>>>>>>>>    | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> >>>>>>>>>>    | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
> >>>>>>>>>>    | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
> >>>>>>>>>>    | [<ffffffff812b6904>] do_irq+0x66/0x98
> >>>>>>>>>>    | ---[ end trace 0000000000000000 ]---
> >>>>>>>>>>
> >>>>>>>>>> Code:
> >>>>>>>>>>    | static void free_bulk(struct bpf_mem_cache *c)
> >>>>>>>>>>    | {
> >>>>>>>>>>    |     struct bpf_mem_cache *tgt =3D c->tgt;
> >>>>>>>>>>    |     struct llist_node *llnode, *t;
> >>>>>>>>>>    |     unsigned long flags;
> >>>>>>>>>>    |     int cnt;
> >>>>>>>>>>    |
> >>>>>>>>>>    |     WARN_ON_ONCE(tgt->unit_size !=3D c->unit_size);
> >>>>>>>>>>    | ...
> >>>>>>>>>>
> >>>>>>>>>> I'm not well versed in the memory allocator; Before I dive int=
o
> >>>>>>>>>> it --
> >>>>>>>>>> has anyone else hit it? Ideas on why the warn_on_once is hit?
> >>>>>>>>> Maybe take a look at the patch
> >>>>>>>>>    822fb26bdb55  bpf: Add a hint to allocated objects.
> >>>>>>>>>
> >>>>>>>>> In the above patch, we have
> >>>>>>>>>
> >>>>>>>>> +       /*
> >>>>>>>>> +        * Remember bpf_mem_cache that allocated this object.
> >>>>>>>>> +        * The hint is not accurate.
> >>>>>>>>> +        */
> >>>>>>>>> +       c->tgt =3D *(struct bpf_mem_cache **)llnode;
> >>>>>>>>>
> >>>>>>>>> I suspect that the warning may be related to the above.
> >>>>>>>>> I tried the above ./test_progs command line (running multiple
> >>>>>>>>> at the same time) and didn't trigger the issue.
> >>>>>>>> The extra 8-bytes before the freed pointer is used to save the
> >>>>>>>> pointer
> >>>>>>>> of the original bpf memory allocator where the freed pointer cam=
e
> >>>>>>>> from,
> >>>>>>>> so unit_free() could free the pointer back to the original
> >>>>>>>> allocator to
> >>>>>>>> prevent alloc-and-free unbalance.
> >>>>>>>>
> >>>>>>>> I suspect that a wrong pointer was passed to bpf_obj_drop, but d=
o
> >>>>>>>> not
> >>>>>>>> find anything suspicious after checking linked_list. Another
> >>>>>>>> possibility
> >>>>>>>> is that there is write-after-free problem which corrupts the ext=
ra
> >>>>>>>> 8-bytes before the freed pointer. Could you please apply the
> >>>>>>>> following
> >>>>>>>> debug patch to check whether or not the extra 8-bytes are
> >>>>>>>> corrupted ?
> >>>>>>> Thanks for getting back!
> >>>>>>>
> >>>>>>> I took your patch for a run, and there's a hit:
> >>>>>>>    | bad cache ff5ffffffffe8570: got size 96 work
> >>>>>>> ffffffff801b19c8, cache ff5ffffffffe8980 exp size 128 work
> >>>>>>> ffffffff801b19c8
> >>>>>> The extra 8-bytes are not corrupted. Both of these two
> >>>>>> bpf_mem_cache are
> >>>>>> valid and there are in the cache array defined in bpf_mem_caches. =
BPF
> >>>>>> memory allocator allocated the pointer from 96-bytes sized-cache,
> >>>>>> but it
> >>>>>> tried to free the pointer through 128-bytes sized-cache.
> >>>>>>
> >>>>>> Now I suspect there is no 96-bytes slab in your system and ksize(p=
tr -
> >>>>>> LLIST_NODE_SZ) returns 128, so bpf memory allocator selected the
> >>>>>> 128-byte sized-cache instead of 96-bytes sized-cache. Could you pl=
ease
> >>>>>> check the value of KMALLOC_MIN_SIZE in your kernel .config and
> >>>>>> using the
> >>>>>> following command to check whether there is 96-bytes slab in your
> >>>>>> system:
> >>>>> KMALLOC_MIN_SIZE is 64.
> >>>>>
> >>>>>> $ cat /proc/slabinfo |grep kmalloc-96
> >>>>>> dma-kmalloc-96         0      0     96   42    1 : tunables    0  =
  0
> >>>>>> 0 : slabdata      0      0      0
> >>>>>> kmalloc-96          1865   2268     96   42    1 : tunables    0  =
  0
> >>>>>> 0 : slabdata     54     54      0
> >>>>>>
> >>>>>> In my system, slab has 96-bytes cached, so grep outputs something,
> >>>>>> but I
> >>>>>> think there will no output in your system.
> >>>>> You're right! No kmalloc-96.
> >>>> To get rid of the warning, limit available sizes from
> >>>> bpf_mem_alloc_init()?
> >> It is not enough. We need to adjust size_index accordingly during
> >> initialization. Could you please try the attached patch below ? It is
> >> not a formal patch and I am considering to disable prefilling for thes=
e
> >> redirected bpf_mem_caches.
> >>> Do you know why your system does not have kmalloc-96?
> >> According to the implementation of setup_kmalloc_cache_index_table() a=
nd
> >> create_kmalloc_caches(),  when KMALLOC_MIN_SIZE is greater than 64,
> >> kmalloc-96 will be omitted. If KMALLOC_MIN_SIZE is greater than 128,
> >> kmalloc-192 will be omitted as well.
> > Great catch. The fix looks good.
> > Please submit it officially and add an error check to bpf_mem_alloc_ini=
t()
> > that verifies that ksize() matches the expectations.
>
> Do you mean to check the return values of ksize() for these prefill
> objects in free_llist are expected, right ?

I'd like to avoid adding extra flags to alloc_bulk() and passing them along=
.
Instead prefill_mem_cache() can peek into 1st element after alloc_bulk()
and check its ksize.

> > The alternative is to use kmalloc_size_roundup() during alloc for
> > checking instead of ksize().
> > Technically we can use kmalloc_size_roundup in unit_alloc() and avoid
> > setup_kmalloc_cache_index_table()-like copy paste, but performance
> > overhead might be too high.
> > So your patch + error check at bpf_mem_alloc_init() is preferred.
> I see. Using kmalloc_size_round() in bpf_mem_alloc() is indeed an
> alternative solution. Will post it.

No need. I think perf degradation for a corner case is prohibitive.

