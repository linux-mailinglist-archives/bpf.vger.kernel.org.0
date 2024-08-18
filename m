Return-Path: <bpf+bounces-37441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F718955AF2
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 06:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141CE1F21689
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 04:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB5DDD2;
	Sun, 18 Aug 2024 04:38:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68ADDA8
	for <bpf@vger.kernel.org>; Sun, 18 Aug 2024 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723955925; cv=none; b=VmYVjV5odCrP9PMnBZ4JtxUBauHu4koNZhzh61s+/0Uo+IsmxY5j94F4ZubMQLTvvV8xAwFFGM/UzT5mCpkJsB68rogloCOsvBPiXj8zGMw6QbY+98KFKKK9DBbB73wE60SOD2DUX7qNsuPvLwUS+bzDnCpV67lRC3UCqMYq9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723955925; c=relaxed/simple;
	bh=CP/UUb9OK861jB+q5hDHU0iwUw1AWWMFLiJdlrXLEbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zce2XJrHpWZN9fjRGGXqk3wXtmCDWi1Tp7OeLLZh7wZCPV8L+o7InBo49DreIoBSbpTlXVzVEicLtBUhiI/EhGQZTL6czXXH+HAz1QMXWCsVeEK8b6aZ10p8BlvlZLuFHE2Q7YhaP+JshU+XjYrOq0w3VnuWuGvqPQl1GAmcxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 47I4baax016990;
	Sun, 18 Aug 2024 13:37:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 18 Aug 2024 13:37:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 47I4bZ6h016984
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 18 Aug 2024 13:37:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c9ec24cb-f0f0-4666-af4b-584def5b6b2e@I-love.SAKURA.ne.jp>
Date: Sun, 18 Aug 2024 13:37:37 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/4] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
        bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
        andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
        renauld@google.com, revest@chromium.org, song@kernel.org,
        linux@roeck-us.net
References: <20240816154307.3031838-1-kpsingh@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240816154307.3031838-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/17 0:43, KP Singh wrote:
> # v13 to v14
> 
> * Dropped Patch 5 based on the ongoing discussion in
>   https://lore.kernel.org/linux-security-module/20240629084331.3807368-4-kpsingh@kernel.org/, BPF
>   LSM will still have default callbacks enabled.

Why not use

struct lsm_callback {
	struct list_head list;
	struct static_call_key key;
}

for each callback given that the latency is mostly caused by use of indirect function call?

Then, we don't need "lsm: count the LSMs enabled at compile time" (which I'm NACKing).

> * Dropped Patch 4 as recommended by Paul, indirect calls will remain in some LSM hooks for now.
>   https://lore.kernel.org/linux-security-module/20240629084331.3807368-5-kpsingh@kernel.org/
> * Fixed minor nits in Patch 3


