Return-Path: <bpf+bounces-95-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B693A6F7C90
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652F5280F68
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 05:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B51C2B;
	Fri,  5 May 2023 05:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31A156E6
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 05:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9AB8C4339E;
	Fri,  5 May 2023 05:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683265822;
	bh=QpkJMhZ3m9GSusSBrPp7eLeLROuJgsn77YyMMnU+3+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WTXKiJX1OJfeDqGW/4wdn7i/hpkdFzL+raL1vWZEWRkLmoo5dISJGmi1hU2aczL93
	 Opk/2lGZocj+DXoLAQoaHKMn3ZNzcS9x7x7l5sAF7RUfXe9bJlyrjJZCkCSBx40je9
	 5PBmyeonVan01f0N28barSQAJSvBLnF3b7AofsRxEzgwJa8x40+IJRuxivXtqB/mO2
	 nx8lCKAtJYgRp4ObLoztOPJivKleQqg9kNPoerzCmREH6Jappnug4ZrLzTJU7c+oz6
	 7fFyvO2QpJnBK1htTSwc1znNDg2YlVuu5c5+qjHaXenEVasJnsxp2qxKaWU6HeA4DN
	 ZfmpgecbN9zNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA74EE5FFC9;
	Fri,  5 May 2023 05:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 00/10] Add precision propagation for subprogs and
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168326582268.19364.13895089224168488627.git-patchwork-notify@kernel.org>
Date: Fri, 05 May 2023 05:50:22 +0000
References: <20230505043317.3629845-1-andrii@kernel.org>
In-Reply-To: <20230505043317.3629845-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 4 May 2023 21:33:07 -0700 you wrote:
> As more and more real-world BPF programs become more complex
> and increasingly use subprograms (both static and global), scalar precision
> tracking and its (previously weak) support for BPF subprograms (and callbacks
> as a special case of that) is becoming more and more of an issue and
> limitation. Couple that with increasing reliance on state equivalence (BPF
> open-coded iterators have a hard requirement for state equivalence to converge
> and successfully validate loops), and it becomes pretty critical to address
> this limitation and make precision tracking universally supported for BPF
> programs of any complexity and composition.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,01/10] veristat: add -t flag for adding BPF_F_TEST_STATE_FREQ program flag
    https://git.kernel.org/bpf/bpf-next/c/5956f3011604
  - [v3,bpf-next,02/10] bpf: mark relevant stack slots scratched for register read instructions
    https://git.kernel.org/bpf/bpf-next/c/e0bf462276b6
  - [v3,bpf-next,03/10] bpf: encapsulate precision backtracking bookkeeping
    https://git.kernel.org/bpf/bpf-next/c/407958a0e980
  - [v3,bpf-next,04/10] bpf: improve precision backtrack logging
    https://git.kernel.org/bpf/bpf-next/c/d9439c21a9e4
  - [v3,bpf-next,05/10] bpf: maintain bitmasks across all active frames in __mark_chain_precision
    https://git.kernel.org/bpf/bpf-next/c/1ef22b6865a7
  - [v3,bpf-next,06/10] bpf: fix propagate_precision() logic for inner frames
    https://git.kernel.org/bpf/bpf-next/c/f655badf2a8f
  - [v3,bpf-next,07/10] bpf: fix mark_all_scalars_precise use in mark_chain_precision
    https://git.kernel.org/bpf/bpf-next/c/c50c0b57a515
  - [v3,bpf-next,08/10] bpf: support precision propagation in the presence of subprogs
    https://git.kernel.org/bpf/bpf-next/c/fde2a3882bd0
  - [v3,bpf-next,09/10] selftests/bpf: add precision propagation tests in the presence of subprogs
    https://git.kernel.org/bpf/bpf-next/c/3ef3d2177b1a
  - [v3,bpf-next,10/10] selftests/bpf: revert iter test subprog precision workaround
    https://git.kernel.org/bpf/bpf-next/c/c91ab90cea7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



