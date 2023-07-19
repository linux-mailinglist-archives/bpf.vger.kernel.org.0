Return-Path: <bpf+bounces-5345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF3759C45
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6736281987
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9D1FB51;
	Wed, 19 Jul 2023 17:20:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0817F6
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB79CC433C7;
	Wed, 19 Jul 2023 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689787225;
	bh=dOUlY57gmF12KLyZcd/tMhPhrecPGOMKQPrgcr3Pc7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NhWY0vVBkfbQzuPIYFRYsP3IkUjvzmd58thonKEIFn9ETJ9L9h3cP6x9+QRy4B88n
	 hZAxmdeisuXd17izG9Mt+o5tAESVB8t/Q0aytPLj9gOmiFgY2hYnOsklpfWGLJzjqj
	 fa8TyFqjomf3Dz/nY6Rp3dDQq//oq+c2CkyNSWyTHoCL5RFNkA9Lw4RK/t2YKYqvfO
	 61/INmlIbp38FNZe6W/YgKYogSNgI/Q3niex0GZLVeAW2gn9JdZTEjIk6r8jWk/e2/
	 C9h8h5cGe0DulqBkuzEAjqMLhTv5c9suwKeA0XodXLce39vs3KbLnep/FYH3bzEmgE
	 lZ/62ewUMCxJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C61F4C6445A;
	Wed, 19 Jul 2023 17:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: sync tools/ uapi header with
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168978722480.3388.219567156617549154.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 17:20:24 +0000
References: <20230719162257.20818-1-alan.maguire@oracle.com>
In-Reply-To: <20230719162257.20818-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: davemarchevsky@fb.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Jul 2023 17:22:57 +0100 you wrote:
> Seeing the following:
> 
> Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
> 
> ...so sync tools version missing some list_node/rb_tree fields.
> 
> Fixes: c3c510ce431c ("bpf: Add 'owner' field to bpf_{list,rb}_node")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: sync tools/ uapi header with
    https://git.kernel.org/bpf/bpf-next/c/41ee0145a4ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



