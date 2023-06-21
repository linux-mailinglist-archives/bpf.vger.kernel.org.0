Return-Path: <bpf+bounces-3005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B4738240
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 13:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589DA1C20B12
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3111CBD;
	Wed, 21 Jun 2023 11:15:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD09D53F;
	Wed, 21 Jun 2023 11:15:08 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06EC186;
	Wed, 21 Jun 2023 04:15:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qBvna-0006ir-Ck; Wed, 21 Jun 2023 13:14:54 +0200
Date: Wed, 21 Jun 2023 13:14:54 +0200
From: Florian Westphal <fw@strlen.de>
To: Florent Revest <revest@chromium.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lirongqing@baidu.com, wangli39@baidu.com,
	zhangyu31@baidu.com, daniel@iogearbox.net, ast@kernel.org,
	kpsingh@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
Message-ID: <20230621111454.GB24035@breakpoint.cc>
References: <20230615152918.3484699-1-revest@chromium.org>
 <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Florent Revest <revest@chromium.org> wrote:
> On Tue, Jun 20, 2023 at 8:35 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >
> > On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> > > If register_nf_conntrack_bpf() fails (for example, if the .BTF section
> > > contains an invalid entry), nf_conntrack_init_start() calls
> > > nf_conntrack_helper_fini() as part of its cleanup path and
> > > nf_ct_helper_hash gets freed.
> > >
> > > Further netfilter modules like netfilter_conntrack_ftp don't check
> > > whether nf_conntrack initialized correctly and call
> > > nf_conntrack_helpers_register() which accesses the freed
> > > nf_ct_helper_hash and causes a uaf.
> > >
> > > This patch guards nf_conntrack_helper_register() from accessing
> > > freed/uninitialized nf_ct_helper_hash maps and fixes a boot-time
> > > use-after-free.
> >
> > How could this possibly happen?
> 
> Here is one way to reproduce this bug:
> 
>   # Use nf/main
>   git clone git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git
>   cd nf
> 
>   # Start from a minimal config
>   make LLVM=1 LLVM_IAS=0 defconfig
> 
>   # Enable KASAN, BTF and nf_conntrack_ftp
>   scripts/config -e KASAN -e BPF_SYSCALL -e DEBUG_INFO -e
> DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e DEBUG_INFO_BTF -e
> NF_CONNTRACK_FTP
>   make LLVM=1 LLVM_IAS=0 olddefconfig
> 
>   # Build without the LLVM integrated assembler
>   make LLVM=1 LLVM_IAS=0 -j `nproc`
> 
> (Note that the use of LLVM_IAS=0, KASAN and BTF is just to trigger a
> bug in BTF that will be fixed by
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=9724160b3942b0a967b91a59f81da5593f28b8ba
> Independently of that specific BTF bug, it shows how an error in
> nf_conntrack_bpf can cause a boot-time uaf in netfilter)
> 
> Then, booting gives me:
> 
> [    4.624666] BPF: [13893] FUNC asan.module_ctor
> [    4.625611] BPF: type_id=1
> [    4.626176] BPF:
> [    4.626601] BPF: Invalid name
> [    4.627208] BPF:
> [    4.627723] ==================================================================
> [    4.628610] BUG: KASAN: slab-use-after-free in
> nf_conntrack_helper_register+0x129/0x2f0
> [    4.628610] Read of size 8 at addr ffff888102d24000 by task swapper/0/1
> [    4.628610]

Isn't that better than limping along?

in this case an initcall is failing and I think panic is preferrable
to a kernel that behaves like NF_CONNTRACK_FTP=n.

AFAICS this problem is specific to NF_CONNTRACK_FTP=y
(or any other helper module, for that matter).

If you disagree please resend with a commit message that
makes it clear that this is only relevant for the 'builtin' case.

