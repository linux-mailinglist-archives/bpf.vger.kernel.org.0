Return-Path: <bpf+bounces-36483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0DB94970B
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FC92826AC
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C27581B;
	Tue,  6 Aug 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TnzK2BMC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0446444
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966314; cv=none; b=h5IyGCmdBP6fO9CI8/Gb4eGWBUV98d9hPT5TOBcu8j0fIhhGxIMIJ7apMAHvOPl+mlQwvQ9cQRoetj1Jt4SKdQaGvdWmpwb8kU7JXBmnIvclgpZC+5vcWb514+yC58Wx5Qb1lqXvp2Xo9hZftlzaCmSdC/hCdwl64VdqySbNgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966314; c=relaxed/simple;
	bh=0tLFNAjZhobO+5ZBb4zaqEL5Jl6woFc4ybqgkujup/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j9BPSYfDM4oj8lQQs1PwnH7JhEqjoQ5pU7XTG9yZCg66AU8Ymsn1seGrZfYO3VovHDUJVk6EMjd/zGy6iikLH1Mh4OKxaVJQ3AmQAJOK0KM/GeM91CSaNUBHwiuwU/xKcOlu5iITK7WgdZdK56PymabQW9quNZ4L1GrH8rsykOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TnzK2BMC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso1102140a12.1
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722966310; x=1723571110; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xi6uKEtI3ydcMFh53TpPa6nlM2/m0g8EIF/kx2Za9s=;
        b=TnzK2BMCIL8/Jz/7YeW7TQPqfmkzLwmrH0mAbTg+Sdu7EO3JWqb3bjMUvxGJqC7UdB
         NJWs1jPkGf7iInPJCiOLpTrnW/H3inSRb26t9u5K7w+ipQoPqvaRD3QltAlsmCPOlwSr
         LytL8+DL2SIs2lLSYUYJB8IevAHcid4ju5vNI+8InuNPMCtgthftIVbUdBE7xYd2A8JS
         N6xK4Yxb4PPNJ1TxJU9I3zcbdjgFt4l+kh3KtzID+0LzjIjN1zbnLSZnYywgqxUmy/qU
         AYwW85FXjan7KnY60BrKIsmGDI6JDJn/W2OkQ6FbWrOLOKpUiVHKtSitE5AziMhujVSr
         eZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966310; x=1723571110;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Xi6uKEtI3ydcMFh53TpPa6nlM2/m0g8EIF/kx2Za9s=;
        b=PaVGxR6nBA5Lq5ZeEC08HP2TcV3KOoOc3sjbDG3j6R2QKLn5uppHf45x100pjHaGGd
         fYtgO30i0NHegT84Bkx4r+Akg0EGL099BXx+Jx/CUqTxOGxrvkqUIxRnKjQ9FX9BgRuu
         agSHj/7T5IKYbhPV010dRUvfDCom2nJnnMb2477n9K3z6QytbL5AjwvIz9EQugibJcEk
         uQQyfwUAiQBHo4/U5SovZWM2DJGqlCceNKmYFLO58ypJX7Q1hsZ4aIZwtpSqrAriQUmO
         FQ14yZtc6JfSLSacHmqeXCH34mvhGPnb6BwtkzOODEJYlH3722jEzF+2ctY06jXvrprB
         4NyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEm3WyxVDwqMZikGsGvJuZXFTtzEc/5UwVFPTPG7dkkHiR38ciQsIfJWzOHw7R7JkUAjPRmF3000r1UXhJSxw7+7Ha
X-Gm-Message-State: AOJu0YxI9/2H65d+gxnNjzMQ/8CKkHQkpo6Axdgbu3krTIRfYNwBFsoZ
	7hDcxL+409wNAjCLF8AWqQUZCqyWrCRwFMsNZT6UgI8fGP+nWOMWxau72d+2HoQ=
X-Google-Smtp-Source: AGHT+IHsMgSIGDF9mdMgRCHYX3ehKL2Du+ZMgmMto3bDVzv9/bnv6kg+8D9dwyetoyMdqeWFiBEflw==
X-Received: by 2002:a50:eb0b:0:b0:5a2:8802:8e10 with SMTP id 4fb4d7f45d1cf-5b7f36f556amr11358198a12.8.1722966309815;
        Tue, 06 Aug 2024 10:45:09 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb88c4598asm2808992a12.82.2024.08.06.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:45:08 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co> (Michal Luczaj's
	message of "Tue, 6 Aug 2024 19:18:31 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	<87y159yi5m.fsf@cloudflare.com>
	<249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 06 Aug 2024 19:45:07 +0200
Message-ID: <87ttfxy28s.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
> On 8/6/24 14:01, Jakub Sitnicki wrote:
>> On Wed, Jul 31, 2024 at 12:01 PM +02, Michal Luczaj wrote:
>>> Series takes care of few bugs and missing features with the aim to improve
>>> the test coverage of sockmap/sockhash.
>>>
>>> Last patch is a create_pair() rewrite making use of
>>> __attribute__((cleanup)) to handle socket fd lifetime.
>>>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> Changes in v2:
>>> - Rebase on bpf-next (Jakub)
>>> - Use cleanup helpers from kernel's cleanup.h (Jakub)
>>> - Fix subject of patch 3, rephrase patch 4, use correct prefix
>>> - Link to v1: https://lore.kernel.org/r/20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co
>>>
>>> Changes in v1:
>>> - No declarations in function body (Jakub)
>>> - Don't touch output arguments until function succeeds (Jakub)
>>> - Link to v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
>>>
>>> ---
>>> Michal Luczaj (6):
>>>       selftests/bpf: Support more socket types in create_pair()
>>>       selftests/bpf: Socket pair creation, cleanups
>>>       selftests/bpf: Simplify inet_socketpair() and vsock_socketpair_connectible()
>>>       selftests/bpf: Honour the sotype of af_unix redir tests
>>>       selftests/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
>>>       selftests/bpf: Introduce __attribute__((cleanup)) in create_pair()
>>>
>>>  .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 ++--
>>>  .../selftests/bpf/prog_tests/sockmap_helpers.h     | 149 ++++++++++++++-------
>>>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 117 ++--------------
>>>  3 files changed, 124 insertions(+), 170 deletions(-)
>>> ---
>>> base-commit: 92cc2456e9775dc4333fb4aa430763ae4ac2f2d9
>>> change-id: 20240729-selftest-sockmap-fixes-bcca996e143b
>>>
>>> Best regards,
>> 
>> Thanks again for these fixes. For the series:
>> 
>> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
>
> Great, thanks for the review. With this completed, I guess we can unwind
> the (mail) stack to [1]. Is that ingress-to-local et al. something you
> wanted to take care of yourself or can I give it a try?

I haven't stated any work on. You're welcome to tackle that.

All I have is a toy test that I've used to generate the redirect matrix.
Perhaps it can serve as inspiration:

https://github.com/jsitnicki/sockmap-redir-matrix

>
> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>
> Also, I've noticed patchwork still lists (besides this one) the old version
> of this series. Am I supposed to tell the bot to disregard it?

Only the maintainers can change patch set status in patchwork:

https://docs.kernel.org/process/maintainer-netdev.html#updating-patch-status

