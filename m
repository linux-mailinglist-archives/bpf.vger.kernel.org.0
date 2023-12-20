Return-Path: <bpf+bounces-18356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265038196C5
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598181C24693
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4CBE6F;
	Wed, 20 Dec 2023 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETRr+YlV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2EBE4C
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 02:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A0CFC433C9;
	Wed, 20 Dec 2023 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703038827;
	bh=4MNOiK/KdMkptao47kh4i6lSE/Ge/LxWgds8LflKdU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ETRr+YlVQIwzRrSeXcwrNIivveVFCX9jIy2EFt50lKlDdJFIOtJIIYUddf/mH8Sg0
	 aQCngdwzTYQY0FdZxDqVKzaSqsmaEHbz4Fsn0WGwoatuVUBM0mKLu2o5yvkPe77qZ2
	 WIlpRgr5R7EDtvrElv/G4TSHKkEpXvfMAKqPQzYXoHAAdyoe9ptsx+uiuVdR3sVuAq
	 7SXIi/AU7WTVSzjymZWC0fMiTMp4IxjdpRXyTStMIULL9HMTG2OdXZthn0dyAewLW5
	 ITz9S/+9dZeJBN/BZQCWB3HwiAvyJuDw4rmpVgk3hM54Xs9QO0iq5RXJNsHyu1on41
	 oW7y/srOt9CxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20179C561EE;
	Wed, 20 Dec 2023 02:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 00/10] Enhance BPF global subprogs with argument
 tags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170303882712.21964.17240380114004392748.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 02:20:27 +0000
References: <20231215011334.2307144-1-andrii@kernel.org>
In-Reply-To: <20231215011334.2307144-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Dec 2023 17:13:24 -0800 you wrote:
> This patch set adds verifier support for annotating user's global BPF subprog
> arguments with few commonly requested annotations, to improve global subprog
> verification experience.
> 
> These tags are:
>   - ability to annotate a special PTR_TO_CTX argument;
>   - ability to annotate a generic PTR_TO_MEM as non-null.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,01/10] bpf: abstract away global subprog arg preparation logic from reg state setup
    https://git.kernel.org/bpf/bpf-next/c/4ba1d0f23414
  - [v3,bpf-next,02/10] bpf: reuse btf_prepare_func_args() check for main program BTF validation
    https://git.kernel.org/bpf/bpf-next/c/5eccd2db42d7
  - [v3,bpf-next,03/10] bpf: prepare btf_prepare_func_args() for handling static subprogs
    https://git.kernel.org/bpf/bpf-next/c/e26080d0da87
  - [v3,bpf-next,04/10] bpf: move subprog call logic back to verifier.c
    https://git.kernel.org/bpf/bpf-next/c/c5a7244759b1
  - [v3,bpf-next,05/10] bpf: reuse subprog argument parsing logic for subprog call checks
    https://git.kernel.org/bpf/bpf-next/c/f18c3d88deed
  - [v3,bpf-next,06/10] bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args
    https://git.kernel.org/bpf/bpf-next/c/94e1c70a3452
  - [v3,bpf-next,07/10] bpf: add support for passing dynptr pointer to global subprog
    https://git.kernel.org/bpf/bpf-next/c/a64bfe618665
  - [v3,bpf-next,08/10] libbpf: add __arg_xxx macros for annotating global func args
    https://git.kernel.org/bpf/bpf-next/c/aae9c25dda15
  - [v3,bpf-next,09/10] selftests/bpf: add global subprog annotation tests
    https://git.kernel.org/bpf/bpf-next/c/0a0ffcac92d5
  - [v3,bpf-next,10/10] selftests/bpf: add freplace of BTF-unreliable main prog test
    https://git.kernel.org/bpf/bpf-next/c/f0a5056222f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



