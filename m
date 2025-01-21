Return-Path: <bpf+bounces-49348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAFCA179F9
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 10:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788F0167414
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167971BDABE;
	Tue, 21 Jan 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="ZPKxM2am"
X-Original-To: bpf@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EAA2F5B;
	Tue, 21 Jan 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450966; cv=none; b=P3Z1JWUtwz4g21NvigOw9xGOPH7C/3qrxMsbo3YSCp1BPJ8y5zRdCsc0oF6IlfhGdZNPpVIVZQo7DcBmakRKb+og2hiOlUahjBCrL+OMdRmLvSUDu46c3LmnAlyY3XcyCViCPyRzx3Ge4HNPVCznuwt1oXDuRSmJHBx2GAMwg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450966; c=relaxed/simple;
	bh=4DnfCziQBJGKp1zze7S95nSNViMkskaJ3KlMHUCsRkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfCLlq81sFGkUekdoFifUCqC+GxfdQ6w0c+SUVcV6Twe9YT9fdgaCnTFr1rphp82KyUCXMFKhj5P7e/7oTRfbUGCyTNJCV8Ii9gNbqriEYD7fHRxi1YD+wHMT+6GkZ0S6loNujxDVqUQSQkGbfQA77drbr7mHgbOvPS+fgTBPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=ZPKxM2am; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1737450913; bh=4DnfCziQBJGKp1zze7S95nSNViMkskaJ3KlMHUCsRkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPKxM2amTPGPIpfxipp3rs1X8Hnc0pPHj/RxT3tOOGRaNFs2sLwHZNTczL6MlDYJ1
	 T+lBRMT2IhuXm+6y2adZrP/IMv5bSPxgz8fkZM68x+sqS6EYHUzl6RNg9+SJlaSiNz
	 M9qFazSLZtOL4dHwUBBCLhEAzlTuBn8JVjBPc8iM=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 678f65a1-35e9-7f0000032729-7f000001d526-1
	for <multiple-recipients>; Tue, 21 Jan 2025 10:15:13 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 21 Jan 2025 10:15:13 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id F368C80734;
	Tue, 21 Jan 2025 10:15:12 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id E6DB218232C;
	Tue, 21 Jan 2025 10:15:12 +0100 (CET)
Received: from nicolas by l-nschier-z2.ads.avm.de with local (Exim 4.98)
	(envelope-from <n.schier@avm.de>)
	id 1taALo-00000002Jyc-2SqF;
	Tue, 21 Jan 2025 10:15:12 +0100
Date: Tue, 21 Jan 2025 10:15:12 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Ruowen Qin <ruqin@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
Message-ID: <20250121-fair-succinct-cicada-e432d7@l-nschier-z2>
References: <20250120023027.160448-1-jinghao7@illinois.edu>
 <CAK7LNASn2aS6kcOy2Ur=tv_0fuEw8Gv06cVrOJ0x==AD9YRwRg@mail.gmail.com>
 <c07454ba-d124-45d0-815e-2951c566e0bf@illinois.edu>
 <7bed760c-7184-4719-8cda-1b7fcbc8577b@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bed760c-7184-4719-8cda-1b7fcbc8577b@illinois.edu>
X-purgate-ID: 149429::1737450913-A6C18833-0F051EBE/0/0
X-purgate-type: clean
X-purgate-size: 2953
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

On Tue, Jan 21, 2025 at 02:48:54AM -0600, Jinghao Jia wrote:
> 
> 
> On 1/20/25 6:47 PM, Jinghao Jia wrote:
> > 
> > 
> > On 1/20/25 6:42 PM, Masahiro Yamada wrote:
> >> On Mon, Jan 20, 2025 at 11:30 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
> >>>
> >>> Commit 13b25489b6f8 ("kbuild: change working directory to external
> >>> module directory with M=") changed kbuild working directory of bpf
> >>> samples to $(srctree)/samples/bpf, which broke the vmlinux path for
> >>> VMLINUX_BTF, as the Makefile assumes the current work directory to be
> >>> $(srctree):
> >>>
> >>>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
> >>>
> >>> Correctly refer to the kernel source directory using $(srctree).
> >>>
> >>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> >>> Tested-by: Ruowen Qin <ruqin@redhat.com>
> >>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> >>> ---
> >>>  samples/bpf/Makefile | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >>> index 96a05e70ace3..f97295724a14 100644
> >>> --- a/samples/bpf/Makefile
> >>> +++ b/samples/bpf/Makefile
> >>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
> >>>
> >>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
> >>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
> >>> -                    $(abspath ./vmlinux)
> >>> +                    $(abspath $(srctree)/vmlinux)
> >>
> >> This is wrong and will not work for O= build.
> >>
> >> The prefix should be $(objtree)/
> >>
> >>
> > 
> > I thought the $(srctree)/vmlinux is a fallback when $(O) is not defined, am I
> > understanding it wrong here?
> > 
> > --Jinghao
> > 
> 
> I played with kbuild a little bit more. It seems that the way the Makefiles are
> set up does not allow a sample/bpf build w/o O= when the kernel itself is built
> w/ O=, as it directly invokes the top-level Makefile. If O= is passed to the
> sample/bpf build, the $(abspath $(if $(O),$(O)/vmlinux)) part should take care
> of that. With that said, please do correct me if I am wrong.
> 
> --Jinghao

$(srctree) refers to the root of the kernel source tree, while
$(objtree) refers to the root of the kernel object tree.  Even if both
variables have the same value for the case you are fixing, it makes
sense to align to the meaning of the variables as described in
Documentation/kbuild/makefiles.rst.

In short: if you want to access file created during the kernel build,
please always use $(objtree) instead of $(srctree).

Hope that helps.

Kind regards,
Nicolas

