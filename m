Return-Path: <bpf+bounces-2995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A978737F78
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AC92814EF
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CEFBE5;
	Wed, 21 Jun 2023 10:21:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F62DF60
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:21:01 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30460E65
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 03:20:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso3232776a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687342855; x=1689934855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMULsX7Dfo5b2zc6PeXXiTXS5XgNxl2nI88lUF+EMtE=;
        b=hNhaYwhGaP6KI5AaWtX45Uvo6vzdGw+3RgvM2Pc6af5WTt9Xk8YdtgCjYKK1UMfHeO
         yQZK/ZDfzszD04HEUinydZdKL3xmCg1x5aBYvETc92RxTf3MkKIZXvBvK5u5iUztQWeq
         AYVf4tlKpqLY5z/5NWWp0z7QyCYO52BLZ2hNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342855; x=1689934855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMULsX7Dfo5b2zc6PeXXiTXS5XgNxl2nI88lUF+EMtE=;
        b=XDaGbBxt9EO7uIo08hlrvTxxtgqQIkR4wcMamLYjPoRO//2OxcfgnjJzR63vuaf7Cs
         WZ26f/xIPjcQ+1f9ZZ167BUmPL96opo4/3qzCmSoFdcpQkdW4lZnRuixrAf6AlB8vqKt
         /Wv5+ngjujq9m56ix7ugrUWdGoKAFx4bs8w17vbwWpUpIYGjJeWjpVWd5Qb6pYCtMIb0
         8y38qdJPkp/932CaE2fVB+OvewFbM+YD+YKztcQCs9muKQj17EhMK8NeAztyUolgFls7
         W7dYOfUhmBsz4W2gsqDuWNs2cClI+8ndlBx8t3Z6W9dtBnWTzup22o/KzBLjcoTh+Z61
         FrUg==
X-Gm-Message-State: AC+VfDx96VCWEOYtV+Yqgwul5eCFY0HbO2s7a6xQLQOtHh8BXLWcE9K+
	XhVWym5AmIhOUQXX+MckoO/NVAvRzfxk+Cms+qNUEQ==
X-Google-Smtp-Source: ACHHUZ7/hNmsWRlrLpNbsJMKJIlg32nbmO1VWpWps6k5fEFwklcOENmUGp7zDOpHSwgP1dAkb1bR7mrJpnwtVIXnF5I=
X-Received: by 2002:a17:90a:d811:b0:256:87f4:432a with SMTP id
 a17-20020a17090ad81100b0025687f4432amr14607505pjv.18.1687342855601; Wed, 21
 Jun 2023 03:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
In-Reply-To: <ZJFIy+oJS+vTGJer@calendula>
From: Florent Revest <revest@chromium.org>
Date: Wed, 21 Jun 2023 12:20:44 +0200
Message-ID: <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, lirongqing@baidu.com, wangli39@baidu.com, 
	zhangyu31@baidu.com, daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 8:35=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> > If register_nf_conntrack_bpf() fails (for example, if the .BTF section
> > contains an invalid entry), nf_conntrack_init_start() calls
> > nf_conntrack_helper_fini() as part of its cleanup path and
> > nf_ct_helper_hash gets freed.
> >
> > Further netfilter modules like netfilter_conntrack_ftp don't check
> > whether nf_conntrack initialized correctly and call
> > nf_conntrack_helpers_register() which accesses the freed
> > nf_ct_helper_hash and causes a uaf.
> >
> > This patch guards nf_conntrack_helper_register() from accessing
> > freed/uninitialized nf_ct_helper_hash maps and fixes a boot-time
> > use-after-free.
>
> How could this possibly happen?

Here is one way to reproduce this bug:

  # Use nf/main
  git clone git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git
  cd nf

  # Start from a minimal config
  make LLVM=3D1 LLVM_IAS=3D0 defconfig

  # Enable KASAN, BTF and nf_conntrack_ftp
  scripts/config -e KASAN -e BPF_SYSCALL -e DEBUG_INFO -e
DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e DEBUG_INFO_BTF -e
NF_CONNTRACK_FTP
  make LLVM=3D1 LLVM_IAS=3D0 olddefconfig

  # Build without the LLVM integrated assembler
  make LLVM=3D1 LLVM_IAS=3D0 -j `nproc`

(Note that the use of LLVM_IAS=3D0, KASAN and BTF is just to trigger a
bug in BTF that will be fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3D97=
24160b3942b0a967b91a59f81da5593f28b8ba
Independently of that specific BTF bug, it shows how an error in
nf_conntrack_bpf can cause a boot-time uaf in netfilter)

Then, booting gives me:

[    4.624666] BPF: [13893] FUNC asan.module_ctor
[    4.625611] BPF: type_id=3D1
[    4.626176] BPF:
[    4.626601] BPF: Invalid name
[    4.627208] BPF:
[    4.627723] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    4.628610] BUG: KASAN: slab-use-after-free in
nf_conntrack_helper_register+0x129/0x2f0
[    4.628610] Read of size 8 at addr ffff888102d24000 by task swapper/0/1
[    4.628610]
[    4.628610] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
6.4.0-rc4-00244-gab39b113e747 #47
[    4.628610] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[    4.628610] Call Trace:
[    4.628610]  <TASK>
[    4.636584] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    4.628610]  dump_stack_lvl+0x97/0xd0
[    4.638738] i2c i2c-0: 1/1 memory slots populated (from DMI)
[    4.628610]  print_report+0x17e/0x570
[    4.640118] i2c i2c-0: Memory type 0x07 not supported yet, not
instantiating SPD
[    4.628610]  ? __virt_addr_valid+0xe4/0x160
[    4.628610]  kasan_report+0x169/0x1a0
[    4.628610]  ? nf_conntrack_helper_register+0x129/0x2f0
[    4.628610]  nf_conntrack_helper_register+0x129/0x2f0
[    4.628610]  nf_conntrack_helpers_register+0x24/0x60
[    4.628610]  nf_conntrack_ftp_init+0x114/0x140
[    4.628610]  ? __pfx_nf_conntrack_ftp_init+0x10/0x10
[    4.628610]  do_one_initcall+0xe6/0x310
[    4.628610]  ? kasan_set_track+0x61/0x80
[    4.628610]  ? kasan_set_track+0x4f/0x80
[    4.628610]  ? __kasan_kmalloc+0x72/0x90
[    4.628610]  ? __kmalloc+0xa7/0x1a0
[    4.628610]  ? do_initcalls+0x1b/0x70
[    4.628610]  ? kernel_init_freeable+0x174/0x1e0
[    4.628610]  ? kernel_init+0x18/0x1b0
[    4.628610]  ? ret_from_fork+0x29/0x50
[    4.628610]  ? sysvec_apic_timer_interrupt+0xe/0x80
[    4.628610]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    4.628610]  ? __pfx_ignore_unknown_bootoption+0x10/0x10
[    4.628610]  ? next_arg+0x20b/0x250
[    4.628610]  ? strlen+0x21/0x40
[    4.628610]  ? parse_args+0xc7/0x5f0
[    4.628610]  do_initcall_level+0xa6/0x140
[    4.628610]  do_initcalls+0x3e/0x70
[    4.628610]  kernel_init_freeable+0x174/0x1e0
[    4.628610]  ? __pfx_kernel_init+0x10/0x10
[    4.628610]  kernel_init+0x18/0x1b0
[    4.628610]  ? __pfx_kernel_init+0x10/0x10
[    4.628610]  ret_from_fork+0x29/0x50
[    4.628610]  </TASK>
[    4.628610]
[    4.628610] Allocated by task 1:
[    4.628610]  kasan_set_track+0x4f/0x80
[    4.628610]  __kasan_kmalloc+0x72/0x90
[    4.628610]  __kmalloc_node+0xa7/0x190
[    4.628610]  kvmalloc_node+0x44/0x120
[    4.628610]  nf_ct_alloc_hashtable+0x5b/0xe0
[    4.628610]  nf_conntrack_helper_init+0x1f/0x60
[    4.628610]  nf_conntrack_init_start+0x1c9/0x2d0
[    4.628610]  nf_conntrack_standalone_init+0xb/0xa0
[    4.628610]  do_one_initcall+0xe6/0x310
[    4.628610]  do_initcall_level+0xa6/0x140
[    4.628610]  do_initcalls+0x3e/0x70
[    4.628610]  kernel_init_freeable+0x174/0x1e0
[    4.628610]  kernel_init+0x18/0x1b0
[    4.628610]  ret_from_fork+0x29/0x50
[    4.628610]
[    4.628610] Freed by task 1:
[    4.628610]  kasan_set_track+0x4f/0x80
[    4.628610]  kasan_save_free_info+0x2b/0x50
[    4.628610]  ____kasan_slab_free+0x116/0x1a0
[    4.628610]  __kmem_cache_free+0xc4/0x200
[    4.628610]  nf_conntrack_init_start+0x29c/0x2d0
[    4.628610]  nf_conntrack_standalone_init+0xb/0xa0
[    4.628610]  do_one_initcall+0xe6/0x310
[    4.628610]  do_initcall_level+0xa6/0x140
[    4.628610]  do_initcalls+0x3e/0x70
[    4.628610]  kernel_init_freeable+0x174/0x1e0
[    4.628610]  kernel_init+0x18/0x1b0
[    4.628610]  ret_from_fork+0x29/0x50
[    4.628610]
[    4.628610] The buggy address belongs to the object at ffff888102d24000
[    4.628610]  which belongs to the cache kmalloc-4k of size 4096
[    4.628610] The buggy address is located 0 bytes inside of
[    4.628610]  freed 4096-byte region [ffff888102d24000, ffff888102d25000)
[    4.628610]
[    4.628610] The buggy address belongs to the physical page:
[    4.628610] page:000000001eb64ba1 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x102d20
[    4.628610] head:000000001eb64ba1 order:3 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[    4.628610] flags: 0x200000000010200(slab|head|node=3D0|zone=3D2)
[    4.628610] page_type: 0xffffffff()
[    4.628610] raw: 0200000000010200 ffff888100043040 dead000000000122
0000000000000000
[    4.628610] raw: 0000000000000000 0000000000040004 00000001ffffffff
0000000000000000
[    4.628610] page dumped because: kasan: bad access detected
...

> nf_conntrack_ftp depends on nf_conntrack.
>
> If nf_conntrack fails to load, how can nf_conntrack_ftp be loaded?

Is this maybe only true of dynamically loaded kmods ? With
CONFIG_NF_CONNTRACK_FTP=3Dy, it seems to me that nf_conntrack_ftp_init()
will be called as an __init function, independently of whether
nf_conntrack_init_start() succeeded or not. Am I missing something ?

