Return-Path: <bpf+bounces-42099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E399F911
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2049B1C2369B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8BF1FBF69;
	Tue, 15 Oct 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAQSO5U5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777E1F80D4
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027683; cv=none; b=TA+cVlnD6zFMSZ8gXY7Hc2cwTtMVr/MTDxegp/uW/rRz7VI10SgQcRZ8YBibE8jbFQadGNXx4LuaD3Vhh2yEdUFLlygO+AYhCMzl2NaqavFfgLzPWlYfRLqYFUja4On46Le5gxhJbhQ8vGsMvl63hV+ttSsaXj4HB2WbFRKZ+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027683; c=relaxed/simple;
	bh=zabEMJ1IjskCRUlbGViWM5HJGHXV6S58kC21p3TIQ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q32HVoDgEQbtEQTrhuuIXhhfSd31Fsg8VFqri0gMrfaUzN9LVVG9sP1e+cJzCpxILh18NfqOVyyboDHrkzS6dfTBeEZEfLLuyWYIaAlHvQBhovaTxV0n68a96U5cgcYJr3aeyh0btwCvP/fTw6SN4VCfiC6mQtitqjzdpCxNot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAQSO5U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E6BC4CEC6;
	Tue, 15 Oct 2024 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729027682;
	bh=zabEMJ1IjskCRUlbGViWM5HJGHXV6S58kC21p3TIQ/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tAQSO5U5ktBCONvJ2D1svIafladCczEZ+UsZ7BJPBQMckf9Wen/zaQxqgiB9msTd7
	 TifQfX2HnKJ288qYPwpQja9/QAJSWtSbTXcFn96w6QYUYoWulT5GW61qAHbbC0Mp77
	 84S01JtPYQObraOiYjM4ghqulD/4xaDKgkifQ3q7z5LJRnSDMHKiP5AKmLfqmgWaZE
	 F6QN3lN4ijZ5ubH/R3yw+ISX281isklxLGG5zvDbnWL5wv1OVc4fY6bh04j+zttfAr
	 AmDunhuZaqJ6AVzQPoIdmF+Nh/eGEWuFrhqIHUmAM+mky3YRfR7CkXzbSS9J+Oh5xN
	 uQ5fNyGLW/Hzw==
Date: Tue, 15 Oct 2024 11:28:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 00/10] bpf: Support private stack for bpf
 progs
Message-ID: <Zw7eYb9XZYqhazlf@slm.duckdns.org>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010175552.1895980-1-yonghong.song@linux.dev>

Hello,

On Thu, Oct 10, 2024 at 10:55:52AM -0700, Yonghong Song wrote:
> The main motivation for private stack comes from nested scheduler in
> sched-ext from Tejun. The basic idea is that
>  - each cgroup will its own associated bpf program,
>  - bpf program with parent cgroup will call bpf programs
>    in immediate child cgroups.
> 
> Let us say we have the following cgroup hierarchy:
>   root_cg (prog0):
>     cg1 (prog1):
>       cg11 (prog11):
>         cg111 (prog111)
>         cg112 (prog112)
>       cg12 (prog12):
>         cg121 (prog121)
>         cg122 (prog122)
>     cg2 (prog2):
>       cg21 (prog21)
>       cg22 (prog22)
>       cg23 (prog23)

Thank you so much for working on this. I have some basic and a bit
tangential questions around how stacks are allocated. So, for sched_ext,
each scheduler would be represented by struct_ops and I think the interface
to load them would be attaching a struct_ops to a cgroup.

- I suppose each operation in a struct_ops would count as a separate program
  and would thus allocate 512 * nr_cpus stacks, right?

- If the same scheduler implementation is attached to more than one cgroups,
  would each instance be treated as a separate set of programs or would they
  share the stack?

- Most struct_ops operations won't need to be nested and thus wouldn't need
  to use a private stack. Would it be possible to indicate which one should
  use a private stack?

Thanks.

-- 
tejun

