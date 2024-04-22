Return-Path: <bpf+bounces-27445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35F8AD311
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BA11F213D1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576182EB11;
	Mon, 22 Apr 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7oYDdyT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195115383C;
	Mon, 22 Apr 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805684; cv=none; b=rou6jhFeomncZg0+pkZkXLF+kmqi0vMWQfig2ShyZGu+WtYFGhECFdF7ErcCwRw59xABPDr8xx37Q9n2w+EqKW24vRu7uLs+INGuYqF7tyuyI5vxz1nCoR/cohzdlECFuXE8TDtCwCD0XW2d88ZIcOq6RPk2ea7yzpO4emcERZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805684; c=relaxed/simple;
	bh=w0hxzmG1gYn8WGCfF/7Fupn+EIiThl4LxR3lirgjX8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkhIdlwbf6tp2960EZ1BpUR2bR9fFK2zjJpJ7qsjuVA/if9UfHcU40Ns5ODlHSdMNEuSa/ej68teUYhRMQKVVn1b0mwRbhnudhUMjFLcrPyF1JwigK7KflAu1Qxn1s/HW4woQLsidYl27TC/Tq3l3E4Iwv5N32+gCIk8GI6FCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7oYDdyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B20C113CC;
	Mon, 22 Apr 2024 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713805684;
	bh=w0hxzmG1gYn8WGCfF/7Fupn+EIiThl4LxR3lirgjX8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7oYDdyTpVj7IpdCj9j2ZvxONjy4/oU3wQgK7vu9dTvAqK7cbaVXGyXpbEEHmKlVx
	 UiavVa39FL5HJ8NPsACJVANWleEtb0+I+hu7dgs9g7KKlmj9eskdOpejgGsHWJaSJ1
	 xMjB/8sL+nxRE8BhnAl4C4sgFreF+qhCAFDDPfaOj56BCziZMq45JYV93oEg6hrSlK
	 ytIhvh5OknxA6W84y+XbKnH4moYtnDCocgv/lNrp/M3HBqQn/Lvg7auIybwa7M1G2K
	 cnoGoVk+kmSHgynilWb7QkwToK89ovB+3CEf+pO9a+jS08QfHX7MvI4lS9PqQsb6pt
	 4Pr5JFwK+nysg==
Date: Mon, 22 Apr 2024 19:07:58 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
Message-ID: <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net>

On Apr 22 2024, Daniel Borkmann wrote:
> On 4/22/24 9:16 AM, Benjamin Tissoires wrote:
> > Arrays of progs are underlying using regular arrays, but they can only
> > be updated from a syscall.
> > Therefore, they should be safe to use while in a sleepable context.
> > 
> > This is required to be able to call bpf_tail_call() from a sleepable
> > tracing bpf program.
> > 
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> > Hi,
> > 
> > a small patch to allow to have:
> > 
> > ```
> > SEC("fmod_ret.s/__hid_bpf_tail_call_sleepable")
> > int BPF_PROG(hid_tail_call_sleepable, struct hid_bpf_ctx *hctx)
> > {
> > 	bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
> > 
> > 	return 0;
> > }
> > ```
> > 
> > This should allow me to add bpf hooks to functions that communicate with
> > the hardware.
> 
> Could you also add selftests to it? In particular, I'm thinking that this is not
> sufficient given also bpf_prog_map_compatible() needs to be extended to check on
> prog->sleepable. For example we would need to disallow calling sleepable programs
> in that map from non-sleepable context.

Just to be sure, if I have to change bpf_prog_map_compatible(), that
means that a prog array map can only have sleepable or non-sleepable
programs, but not both at the same time?

FWIW, indeed, I just tested and the BPF verifier/core is happy with this
patch only if the bpf_tail_call is issued from a non-sleepable context
(and crashes as expected).

But that seems to be a different issue TBH: I can store a sleepable BPF
program in a prog array and run it from a non sleepable context. I don't
need the patch at all as bpf_tail_call() is normally declared. I assume
your suggestion to change bpf_prog_map_compatible() will fix that part.

I'll digg some more tomorrow.

Cheers,
Benjamin

> 
> >   kernel/bpf/verifier.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 68cfd6fc6ad4..880b32795136 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18171,6 +18171,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >   		case BPF_MAP_TYPE_QUEUE:
> >   		case BPF_MAP_TYPE_STACK:
> >   		case BPF_MAP_TYPE_ARENA:
> > +		case BPF_MAP_TYPE_PROG_ARRAY:
> >   			break;
> >   		default:
> >   			verbose(env,
> > 
> > ---
> > base-commit: 735f5b8a7ccf383e50d76f7d1c25769eee474812
> > change-id: 20240422-sleepable_array_progs-e0c07b17cabb
> > 
> > Best regards,
> > 
> 

