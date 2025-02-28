Return-Path: <bpf+bounces-52914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBAEA4A513
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5503BAF34
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD391CAA9E;
	Fri, 28 Feb 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH2zQkGs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390923F360;
	Fri, 28 Feb 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778267; cv=none; b=DXMqPx2gkYDV3x2FWjd6b/QzyPjlm+jcazXI+IcfeWJTPd3aUDQv2hi/eMZm8KM3Z6k/mtNNS17GKFzGIfBF+f0piNbKwESj+4a7fDNP2Wg0wiKzvFHciqxZALd3EIzRRw+kVhdbDZG/2xWLZYETvHHIoWmHT8vvyPL62hAXlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778267; c=relaxed/simple;
	bh=7UtE+tNGxM7UCB6Ic8BrxY/GOyLRh9HdF7PvffhXZb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVVTl7Mh2zOoq7TLTyXPEdTu4evD/FGcq75RHE21WcbKmHjMnaHFJGLGB6K37G/IGm18nTjaSO3QSx+IgwN//3SgckA5RsUVLeW9q+wG36vC33AeU9ycrejsZnuyL7LMjvmb4IXyNqidOqLSAhxU7HpuK9jMOmnvrNu8dVZTMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH2zQkGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6F9C4CED6;
	Fri, 28 Feb 2025 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740778267;
	bh=7UtE+tNGxM7UCB6Ic8BrxY/GOyLRh9HdF7PvffhXZb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DH2zQkGseQlyKGm3wqVeVEpCzgyUuNDdPKgWojZXc9lnOqyoKJnU6ayNzF874kFes
	 cXdRNoYysIkHX+fRnZ6s+7Dlil9EBFIww8ULLO45n9z+LHoMnYXpKBIGIF14S6IPZE
	 J9okNlQkTTrkp0lx4/AfMKTL04yk58WYI/fPXjmBZimPb3hTY3wFpHRU8IgnCB+v8v
	 EpA1FUWAXv/xmRNkN9WeZAgqCPKAGIUWk4vYQTEv9NSeMd0ZUq5wEXbHNW9C5jMUon
	 pNYmdqNqmezUUubrBWGXAnBG3f6dYRfyQ1rXZlhAshAcO46cmQMn6dvPTkuPdpUPBU
	 +ar5DbetWphww==
Date: Fri, 28 Feb 2025 11:31:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
Message-ID: <Z8IrGagRhkHlUejz@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
 <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DZ9pqlWim8EIwk@slm.duckdns.org>
 <CAADnVQ+bXk3qTekjVZ7NU0TpCh4zNg1GNFL-zdW++f2=t_BT8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+bXk3qTekjVZ7NU0TpCh4zNg1GNFL-zdW++f2=t_BT8Q@mail.gmail.com>

Hello,

On Thu, Feb 27, 2025 at 06:34:37PM -0800, Alexei Starovoitov wrote:
> > Hmm... would that mean a non-sched_ext bpf prog would be able to call e.g.
> > scx_bpf_dsq_insert()?
> 
> Not as far as I can tell.
> scx_kfunc_ids_unlocked[] doesn't include scx_bpf_dsq_insert.
> It's part of scx_kfunc_ids_enqueue_dispatch[].
> 
> So this bit in patch 3 enables it:
> +       if ((flags & SCX_OPS_KF_ENQUEUE) &&
> +           btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id))
> 
> and in patch 2:
> +       [SCX_OP_IDX(enqueue)]                   = SCX_OPS_KF_ENQUEUE,
> 
> So scx_bpf_dsq_insert() kfunc can only be called out
> of enqueue() sched-ext hook.
> 
> So the restriction is still the same. afaict.

Hmm... maybe I'm missing something:

  static int scx_kfunc_ids_ops_context_sensitive_filter(const struct bpf_prog *prog, u32 kfunc_id)
  {
         u32 moff, flags;

         // allow non-context sensitive kfuncs
         if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive, kfunc_id))
                 return 0;

         // allow unlocked to be called form all SYSCALL progs
         if (prog->type == BPF_PROG_TYPE_SYSCALL &&
             btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
                 return 0;

         // *** HERE, allow if the prog is not SCX ***
         if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
             prog->aux->st_ops != &bpf_sched_ext_ops)
                 return 0;

         /* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/

         // other context sensitive allow's

So, I think it'd say yes if a non-SCX BPF prog tries to call a context
sensitive SCX kfunc.

Thanks.

-- 
tejun

