Return-Path: <bpf+bounces-296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4926FE188
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABE52814B1
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69E1642B;
	Wed, 10 May 2023 15:28:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5E12B6F
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E40C433EF;
	Wed, 10 May 2023 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683732500;
	bh=nnVeWEKn+i0B7KMuUwtAKdJTm6c0z8xg8GnzhnXd6OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=siq4VbiiBpa4YJEAL9bHc+hyGClAhsVB+oIobHGQJeOmLWY/Lg8g7UYKnrISQe2g0
	 pSA0hegP7FTVQCL501rGvG0HK+CCCd47ogQdiWj7DwM3ZDW6Tgo4D+NyQ/wbLD1uEN
	 NT02JxrQ74m2wo+poj8CSVk9vWL+ownWVYW2UnfanOAnNXlZ7mJQ37MXh5ptmFBgoF
	 Ar777cZne7uy7An/nylGHMjZaWEv8OK6t4cwHiSkzPeukcx4BIC5hETEv1s1Yn3ylr
	 yUjT/m9RmxCI2FTlbI6L7iN//fESmUu1UI1rYMoNDVh03UvEpdTDIzmMWYuQZYKvBL
	 +eFf0ZiEXlfjA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 76C79403B5; Wed, 10 May 2023 12:28:17 -0300 (-03)
Date: Wed, 10 May 2023 12:28:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to
 task_mm_init
Message-ID: <ZFu4Ea/zBPAFYwcH@kernel.org>
References: <20230424161104.3737-1-laoar.shao@gmail.com>
 <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
 <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
 <0d9bbdf6-12b7-a9a3-9bf3-7f67b01c5c3e@oracle.com>
 <CAADnVQKeSmeC1RR1CJ=r4=sLrBwTH3UnPHhy-Pm_DeGOrDor1g@mail.gmail.com>
 <5ef0ff27-2720-42c0-d432-c21ecde0c58d@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ef0ff27-2720-42c0-d432-c21ecde0c58d@oracle.com>
X-Url: http://acmel.wordpress.com

Em Wed, May 10, 2023 at 02:08:49PM +0100, Alan Maguire escreveu:
> On 09/05/2023 22:21, Alexei Starovoitov wrote:
> > On Tue, May 9, 2023 at 11:44 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >> On 02/05/2023 04:40, Alexei Starovoitov wrote:
> >> won't the pahole v1.25 changes help here; can you try applying

> >> https://lore.kernel.org/bpf/1675949331-27935-1-git-send-email-alan.maguire@oracle.com/

> >> ...and build using pahole; this should eliminate any functions
> >> with inconsistent prototypes via

> >>       --skip_encoding_btf_inconsistent_proto
> >>         Do not encode functions with multiple inconsistent prototypes or
> >>         unexpected register use for their parameters, where  the  regis‐
> >>         ters used do not match calling conventions.

> >> I'll check this at my end too.

> >> Alexei, if this works should we look at applying the above
> >> again to bpf-next? If so I'll resend the patch.

> > I've lost the track with pahole fixes.
> > Did Arnaldo re-tag pahole 1.25 or released 1.26 with the fixes?
 
> My understanding is the pahole repo is prepped for v1.25,
> meaning that it will build with version 1.25 but it is
> not officially released yet; Arnaldo will correct me if
> I've got that wrong.

Right, pahole 1.25 was released with those options/fixes.

- Arnaldo
 
> > Alan,
> > please submit a fresh patch for bpf-next to enable
> > --skip_encoding_btf_inconsistent_proto, so it can go through CI.
> > I cannot test all combinations manually.
> > 
> 
> Done; see [1]. If CI picks up the latest version from
> the dwarves repo, it will see version 1.25.
> 
> I've tested the above specific case along with general testing
> using latest pahole.
> 
> When running pahole with --verbose and
> --skip_encoding_btf_inconsistent_proto
> 
> we see:
> 
> skipping addition of 'mm_init'(mm_init) due to multiple inconsistent
> function prototypes
> 
> 
> ...and
> 
>  bpftool btf dump file vmlinux |grep mm_init
> 
> shows the function is not encoded in BTF due to these inconsistencies.
> 
> Thanks!
> 
> Alan
> 
> [1]
> https://lore.kernel.org/bpf/20230510130241.1696561-1-alan.maguire@oracle.com/

