Return-Path: <bpf+bounces-40581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC9E98A786
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2857A1F21231
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF751922D4;
	Mon, 30 Sep 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO+uUT9u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D11917C9;
	Mon, 30 Sep 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707473; cv=none; b=O++KsiZbLpz6+35rHWlLIdfVEYfBvaeMKc27OYvJM6ihmPTKOe+30DPJ3dZ58hmHM/yf5FCcRNcccfgEUaVBw3Sfcc1C1I1qVZC/qH/lRurHn/LU6va0zCshWPbaBJJzGKkCt521RHZ2SU75OeG/GoGI+A+NamImtnqwqDVSVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707473; c=relaxed/simple;
	bh=ipepkvfiPX+ZEqZOxphg5qn1Go5y+GVSQgG04K8aJXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xcy5KR4MTeV1oRv4+D2BBPRHts6Ts8J1c9DMNV6NBEXm8A4v+ohOmKcXGAEtauicYnTDqbSDzGrNNWFqjy6YXNacacyI+CMAPjW22nYP6iE+qJ51HC7C22wcBT4oPJpKoffLEHJa0YflMS+z3ZtvAT/LyxVUCNLkfsPNjByfKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO+uUT9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498DDC4CEC7;
	Mon, 30 Sep 2024 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727707473;
	bh=ipepkvfiPX+ZEqZOxphg5qn1Go5y+GVSQgG04K8aJXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vO+uUT9uYnwjeh3HBhqZAMO58cDZzJRC6ukvJTM4Cpv2iLpJmR4oO40kCm7V0K6uc
	 YfV67rgDIMvQc+M5DbHJuJbYRIARJWSKIfWNYPFH9G+nGfbpMF8dj1ShTMEbM7C3Z3
	 xVpzzGt76CIrz09ItRkHkooN2B8HGADjjgviacoYoOT8LP75n0E/+Z2SwwEksFeqzB
	 vb00wxjXuw11ad9PBPBkJA0/H+E5tumzMwAtAFkAjbDl1/BnXg+cHPEpcRdh7b890a
	 63E5bXDl6tb4FlJeOnb4dDyACAMaaMctX/0EvZJViTwN0t9NMK1JQSpVEGWd4ZIAHX
	 sTpz4E217DWHA==
Date: Mon, 30 Sep 2024 11:44:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, martin.lau@linux.dev
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags for
 eligible kfuncs
Message-ID: <Zvq5TmDGqZIdPMya@x1>
References: <20240916091921.2929615-1-eddyz87@gmail.com>
 <CAEf4BzY5qmrRjNHESAjNm9DnMdfqmaHWYFXZZUC=L0pLJMLuwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY5qmrRjNHESAjNm9DnMdfqmaHWYFXZZUC=L0pLJMLuwA@mail.gmail.com>

On Fri, Sep 27, 2024 at 02:52:24PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 16, 2024 at 2:19 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > For kfuncs marked with KF_FASTCALL flag generate the following pair of
> > decl tags:
> >
> >     $ bpftool btf dump file vmlinux
> >     ...
> >     [A] FUNC 'bpf_rdonly_cast' type_id=...
> >     ...
> >     [B] DECL_TAG 'bpf_kfunc' type_id=A component_idx=-1
> >     [C] DECL_TAG 'bpf_fastcall' type_id=A component_idx=-1
> >
> > So that bpftool could find 'bpf_fastcall' decl tag and generate
> > appropriate C declarations for such kfuncs, e.g.:
> >
> >     #ifndef __VMLINUX_H__
> >     #define __VMLINUX_H__
> >     ...
> >     #define __bpf_fastcall __attribute__((bpf_fastcall))
> >     ...
> >     __bpf_fastcall extern void *bpf_rdonly_cast(...) ...;
> >
> > For additional information about 'bpf_fastcall' attribute,
> > see the following commit in the LLVM source tree:
> >
> > 64e464349bfc ("[BPF] introduce __attribute__((bpf_fastcall))")
> >
> > And the following Linux kernel commit:
> >
> > 52839f31cece ("Merge branch 'no_caller_saved_registers-attribute-for-helper-calls'")
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  btf_encoder.c | 59 +++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 43 insertions(+), 16 deletions(-)
> >
> 
> LGTM,
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Arnaldo, can you please take a look and if everything seems sane apply
> it to pahole master, so it's easier to use it locally? Thanks!

Minor clash with Alan's

Fixes: 5205d02d8e84a775 ("btf_encoder: record BTF-centric function state instead of DWARF-centric")

Fixed up, testing.

- Arnaldo

