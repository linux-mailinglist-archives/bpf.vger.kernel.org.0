Return-Path: <bpf+bounces-18513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5E81B2B9
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 10:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FE282F28
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952CC49F91;
	Thu, 21 Dec 2023 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="enlSRQbv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B974CB41;
	Thu, 21 Dec 2023 09:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF71C433C7;
	Thu, 21 Dec 2023 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703151279;
	bh=3M0FrBm8ctRNbvo3lmQCfqxO3Cbge5seXT98yPca/sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enlSRQbv+2BqjyNB0PYveFexPiMCYBQ/wVv8Fz0JRHsRJrsW7vIEZ4mx/UjpWcjmI
	 7afRr/Mug5hPra+XUone9ibcIiOH/FNiVAbsmcX7XeM9fRqQaV+91HwkQBj54QeClP
	 vpALd9rKK6AkIrgRFxIcxyrwuAd94YECdhJO6kl0=
Date: Thu, 21 Dec 2023 10:34:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCHv4 bpf 1/2] bpf: Fix prog_array_map_poke_run map poke
 update
Message-ID: <2023122113-thirsting-county-ca67@gregkh>
References: <20231206083041.1306660-1-jolsa@kernel.org>
 <20231206083041.1306660-2-jolsa@kernel.org>
 <20231221090745.GA431072@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221090745.GA431072@google.com>

On Thu, Dec 21, 2023 at 09:07:45AM +0000, Lee Jones wrote:
> Dear Stable,
> 
> > Lee pointed out issue found by syscaller [0] hitting BUG in prog array
> > map poke update in prog_array_map_poke_run function due to error value
> > returned from bpf_arch_text_poke function.
> > 
> > There's race window where bpf_arch_text_poke can fail due to missing
> > bpf program kallsym symbols, which is accounted for with check for
> > -EINVAL in that BUG_ON call.
> > 
> > The problem is that in such case we won't update the tail call jump
> > and cause imbalance for the next tail call update check which will
> > fail with -EBUSY in bpf_arch_text_poke.
> > 
> > I'm hitting following race during the program load:
> > 
> >   CPU 0                             CPU 1
> > 
> >   bpf_prog_load
> >     bpf_check
> >       do_misc_fixups
> >         prog_array_map_poke_track
> > 
> >                                     map_update_elem
> >                                       bpf_fd_array_map_update_elem
> >                                         prog_array_map_poke_run
> > 
> >                                           bpf_arch_text_poke returns -EINVAL
> > 
> >     bpf_prog_kallsyms_add
> > 
> > After bpf_arch_text_poke (CPU 1) fails to update the tail call jump, the next
> > poke update fails on expected jump instruction check in bpf_arch_text_poke
> > with -EBUSY and triggers the BUG_ON in prog_array_map_poke_run.
> > 
> > Similar race exists on the program unload.
> > 
> > Fixing this by moving the update to bpf_arch_poke_desc_update function which
> > makes sure we call __bpf_arch_text_poke that skips the bpf address check.
> > 
> > Each architecture has slightly different approach wrt looking up bpf address
> > in bpf_arch_text_poke, so instead of splitting the function or adding new
> > 'checkip' argument in previous version, it seems best to move the whole
> > map_poke_run update as arch specific code.
> > 
> > [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
> > 
> > Cc: Lee Jones <lee@kernel.org>
> > Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> > Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 46 +++++++++++++++++++++++++++++
> >  include/linux/bpf.h         |  3 ++
> >  kernel/bpf/arraymap.c       | 58 +++++++------------------------------
> >  3 files changed, 59 insertions(+), 48 deletions(-)
> 
> Please could we have this backported?
> 
> Guided by the Fixes: tag.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


