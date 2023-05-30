Return-Path: <bpf+bounces-1468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624927170DA
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 00:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FCB1C20DB3
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E992D259;
	Tue, 30 May 2023 22:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CBA948
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 22:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FBF9C433D2;
	Tue, 30 May 2023 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685486420;
	bh=IbfJ4mCBTG/vGKhMNMzJU8QML5/lXc88LBmkV+oS08Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tKCtyet9GDCQPTv4WWO2es1TveUpAEHjFhYa2nGreEe2gZxouGht1LsSBBf2aPbNi
	 g0LNml/XwkQKKbX33faDJh0S9lDslBsBofpZWWl6rgHbUqQmXqYSTPvUH3qQlicPE5
	 M/PBFXY6clrapKxPX29jYnXG1akGgZBaVRe2uZDzJrySWHRqaxa5xJU7h0aGHdF++w
	 1UzKxhzbhtHNhwNSCWlAsnCvRCo99ucyXnhCLM9pSkQmXhJeT5/LgBDtZBJO/i9pGl
	 0E02QOUGsUI64AnaXPaDUxlDPiCOj3JW4g3Pb2bUuKFHvD+WBBOB0z01NvYCz28h7V
	 EnrElBeoEU3Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03838E52C0F;
	Tue, 30 May 2023 22:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Silence a warning in btf_type_id_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168548642000.11166.404309143613379286.git-patchwork-notify@kernel.org>
Date: Tue, 30 May 2023 22:40:20 +0000
References: <20230530205029.264910-1-yhs@fb.com>
In-Reply-To: <20230530205029.264910-1-yhs@fb.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 syzbot+958967f249155967d42a@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 30 May 2023 13:50:29 -0700 you wrote:
> syzbot reported a warning in [1] with the following stacktrace:
>   WARNING: CPU: 0 PID: 5005 at kernel/bpf/btf.c:1988 btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
>   ...
>   RIP: 0010:btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
>   ...
>   Call Trace:
>    <TASK>
>    map_check_btf kernel/bpf/syscall.c:1024 [inline]
>    map_create+0x1157/0x1860 kernel/bpf/syscall.c:1198
>    __sys_bpf+0x127f/0x5420 kernel/bpf/syscall.c:5040
>    __do_sys_bpf kernel/bpf/syscall.c:5162 [inline]
>    __se_sys_bpf kernel/bpf/syscall.c:5160 [inline]
>    __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5160
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Silence a warning in btf_type_id_size()
    https://git.kernel.org/bpf/bpf-next/c/e6c2f594ed96
  - [bpf-next,v2,2/2] selftests/bpf: Add a test where map key_type_id with decl_tag type
    https://git.kernel.org/bpf/bpf-next/c/e38096d95f4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



