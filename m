Return-Path: <bpf+bounces-3830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C17443BB
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 23:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D38281234
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303B51774A;
	Fri, 30 Jun 2023 21:02:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417A16428
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 21:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF1CC433C0;
	Fri, 30 Jun 2023 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688158974;
	bh=JcRoUVFNM9/6PR4mDTjNnE2muKhhGvnoeEasmT4br1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byinquFCr/Gggvsv/R7A6N614gv3EUx+4dmFXAZ0rdYEOYUAaZ5fnniEEAPyS6JHA
	 n6kp6jaizk1QTx7gyAbl30ZH9jidBOv1qFDjQy7mm4+zaJirNeeC7HkKGOC17av1lr
	 jYfbWFNbe6en6ziR8GSr5LTX6ziEpA2v2XQhxzDI1kMCCCKHSE7XUQkdb+K9aaC/He
	 GMk4oItAKiyRjJcHhOIzFD4NTmokq96vZS/TWbCJsZm/1XJg2A7zi5cBE8DfyDNn3M
	 F17bf4dQko3kkURaNgauZR9oJrDbqOuxge9fhH4S7LBn27lrsPDA1E1SESju5saP8Z
	 xrup+9a4lckFw==
From: SeongJae Park <sj@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: SeongJae Park <sj@kernel.org>,
	martin.lau@linux.dev,
	Alexander.Egorenkov@ibm.com,
	ast@kernel.org,
	memxor@gmail.com,
	olsajiri@gmail.com,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date: Fri, 30 Jun 2023 21:02:51 +0000
Message-Id: <20230630210251.126928-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <75483b53-bd8e-692e-ed18-a4c87cf20a1b@iogearbox.net>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 30 Jun 2023 22:52:24 +0200 Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 6/30/23 9:48 PM, SeongJae Park wrote:
> > On Fri, 30 Jun 2023 16:53:38 +0200 Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 6/28/23 6:46 PM, SeongJae Park wrote:
> >>> __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> >>> .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> >>> the function prints an error message and return an error.  As a result,
> >>> such modules cannot be loaded.
> >>>
> >>> However, the section could be stripped out during a build process.  It
> >>> would be better to let the modules loaded, because their basic
> >>> functionalities have no problem[1], though the BTF functionalities will
> >>> not be supported.  Make the function to lower the level of the message
> >>> from error to warn, and return no error.
> >>>
> >>> [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> >>>
> >>> Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> >>> Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> >>> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >>> Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> >>> Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
> >>> Cc: <stable@vger.kernel.org> # 5.18.x
> >>> Signed-off-by: SeongJae Park <sj@kernel.org>
> >>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> >>
> >> I presume this one is targeted at bpf (rather than bpf-next) tree, right?
> > 
> > You're correct.  It's not urgent for us, but I would prefer it to be merged
> > into all affected kernels as early as possible.
> 
> Ok, sounds good, bpf tree it is then.
> 
> >>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >>> index 6b682b8e4b50..d683f034996f 100644
> >>> --- a/kernel/bpf/btf.c
> >>> +++ b/kernel/bpf/btf.c
> >>> @@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
> >>>    
> >>>    	btf = btf_get_module_btf(kset->owner);
> >>>    	if (!btf) {
> >>> -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> >>> -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> >>> -			return -ENOENT;
> >>> -		}
> >>
> >> Why the above one needs to be changed? Do you also run into this case? vmlinux BTF
> >> should be built-in in this case. I understand it's rather the one below for BTF +
> >> modules instead, no?
> > 
> > Again, you're correct.  This change is not really needed.  I was interpreting
> > Kumar's suggestion merely into code without thinking about his real meaning,
> > sorry.  I will restore this in the next spin.
> 
> Perfect, I think after your v3 respin it should be good to land.

Thank you!  I will send it by tomorrow, to give people enough time to comment.
If you don't want to wait, please let me know :)

Also, please note that this will not cleanly applicable on 6.1.y.  I will
provide the backport to stable@ as soon as this is merged into the mainline.


Thanks,
SJ

> 
> Thanks,
> Daniel
> 

