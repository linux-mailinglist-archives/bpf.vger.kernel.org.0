Return-Path: <bpf+bounces-58318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9150EAB89E4
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083B53A7FEA
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A71FBC8C;
	Thu, 15 May 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXebSOmW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF901F3FEB;
	Thu, 15 May 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320693; cv=none; b=EFUPVw5J8j1uPgw6OdJl/BVtXDrgXlx5n+UrnWRxWq6K2ZJuyVTH6kN1k+OhgB+82wbvOULOTgHQP0smwe08YOXizPdiWDhMGH6dzg2rR7SPWP69LP2IU+XRSXOCOXlbu99Uq3Ntodwwj0ETMAiyUFli1wv8O1jhtQvzfBHvVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320693; c=relaxed/simple;
	bh=gPLoJgRnkayVWLQlz1ZTjudKv0fME3HsKweEpIKKq+E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pocHM090JZpyN2+rN1XLLO5SOJx1G1ehk8pFsFgbmq5yqzRwQ6RiD3PEmo+arI4vjxykXsfdPmJhSYZsxQXDyppaVwLqjhmMV+DFp+fzCZBtPojG/u0ygc+2+bsx6Z+SCfk8Q/qMPc40r+q3Juaqiq8AQYjl5XU+IGsO9jPjHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXebSOmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A81C4CEE7;
	Thu, 15 May 2025 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747320690;
	bh=gPLoJgRnkayVWLQlz1ZTjudKv0fME3HsKweEpIKKq+E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mXebSOmWp+w4si2qesd00c6VxgzaTwS28nVOHCxpHOew/rDrZDXTVj4zjCXPg2a5h
	 yyU2lhydPthHrsQrVhj7ABbLHsEKOI06C56xmACTztVlZ+Reu/wF/ybUIm+1c20TRp
	 P1RAOIM/LI/udJwOZOhu325yh4a3wby3cua0rRfglWiu5yjtfdwXS5X5jqxAVn+iHU
	 D5/6ksrat5XfdtSt9sgf4V0ChWEhs40iXxF/pICpcnqFUmPupQQccRoFKAY0tFlqkx
	 JBOSd9lhxNQEMgBubTFaXYhIbp4RkiZKNV2j+1EyX3y/cuIf3vu2U835HQ8leEQ4XI
	 4S5OHz0rtQtFA==
Date: Thu, 15 May 2025 07:51:26 -0700
From: Kees Cook <kees@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
 Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
CC: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BREGRESSION=5D_bpf_verifier_slowdown_?=
 =?US-ASCII?Q?due_to_vrealloc=28=29_change_since_6=2E15-rc6?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
Message-ID: <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi=2Eyu@suse=2Ecom> w=
rote:
>Hi,
>
>There is an observable slowdown when running BPF selftests on 6=2E15-rc6
>kernel[1] built with tools/testing/selftests/bpf/{config,config=2Ex86_64}=
=2E
>Overall the BPF selftests now takes 2x time to run (from ~25m to ~50m),
>and for the verif_scale_loop3_fail it went from single digit seconds to
>6 minutes=2E
>
>Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
>support more granular vrealloc() sizing"[2]=2E To further zoom in the
>issue, I tried removing the only kvrealloc() call in kernel/bpf/ by
>reverting commit 96a30e469ca1 "bpf: use common instruction history
>across all states", so _krealloc()_ was used instead of kvrealloc(), and
>observe that there is _no_ slowdown[3]=2E While the bisect and the revert
>is done on 6=2E14=2E7-rc2, I think it should stll be pretty representitiv=
e=2E
>
>In short, the follow were tested:
>- 6=2E15-rc6 (has a0309faf1cb0) -> slowdown
>- 6=2E14=2E7-rc2 (has a0309faf1cb0) -> slowdown
>- 6=2E14=2E7-rc2 (has a0309faf1cb0, call to kvrealloc in
>  kernel/bpf/verifier=2Ec replaced with krealloc) -> _no_ slowdown
>
>And the vrealloc() change is causing slowdown in kvrealloc() call within
>push_insn_history()=2E

This is very strange! The vrealloc change should make things faster -- it =
removes potentially unneeded vmalloc and full object copies when it isn't n=
eeded=2E

Where can I find the =2Econfig for the slow runs?

And how do I run the test myself directly?

-Kees

>
>  /* for any branch, call, exit record the history of jmps in the given s=
tate */
>  static int push_insn_history(struct bpf_verifier_env *env, struct bpf_v=
erifier_state *cur,
>  			     int insn_flags, u64 linked_regs)
>  {
>  	struct bpf_insn_hist_entry *p;
>  	size_t alloc_size;
>  	=2E=2E=2E
>  	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
>  		alloc_size =3D size_mul(cur->insn_hist_end + 1, sizeof(*p));
>  		p =3D kvrealloc(env->insn_hist, alloc_size, GFP_USER);
>  		if (!p)
>  			return -ENOMEM;
>  		env->insn_hist =3D p;
>  		env->insn_hist_cap =3D alloc_size / sizeof(*p);
>  	}
> =20
>  	p =3D &env->insn_hist[cur->insn_hist_end];
>  	p->idx =3D env->insn_idx;
>  	p->prev_idx =3D env->prev_insn_idx;
>  	p->flags =3D insn_flags;
>  	p->linked_regs =3D linked_regs;
> =20
>  	cur->insn_hist_end++;
>  	env->cur_hist_ent =3D p;
> =20
>  	return 0;
>  }
>
>BPF CI probably hasn't hit this yet because bpf-next have only got to
>6=2E15-rc4=2E
>
>Shung-Hsi
>
>#regzbot introduced: a0309faf1cb0622cac7c820150b7abf2024acff5
>
>1: https://github=2Ecom/shunghsiyu/libbpf/actions/runs/15038992168/job/42=
266125686
>2: https://lore=2Ekernel=2Eorg/stable/20250515041659=2Esmhllyarxdwp7cav@d=
esk/
>3: https://github=2Ecom/shunghsiyu/libbpf/actions/runs/15043433548/job/42=
280277024

--=20
Kees Cook

