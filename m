Return-Path: <bpf+bounces-36465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB047948E49
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 14:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE491C2347F
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322B21C3F31;
	Tue,  6 Aug 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gMY2Bf98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969B1BDA83
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945692; cv=none; b=qHa5tUAY8Uh9n7NeFQm3vv/X7lUTTMS7eG15HACWL6stbhnpDjEbiTZIKMW1W9ePKTYGV6PK3LRb9bwpOFSYDANTSD2B5SEQzOY8o+ccftPg9BKnuvpXbrgehUdo4Hu5eAH5v7cs5Qdmk60ouoyq1OtXZDqxW25m960Egylw0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945692; c=relaxed/simple;
	bh=Lugsx6fzDwyeoUcfvVDJLgsJHlh3ibZ4yuE5vwJULrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8m/UqstJjLSDZMvJDoT1+FfCs7AIjDYmITZgv7dyFntcSux1nCtxYwnlAyJN7rgPtfndFsXgbRg/sA/cxq1rnwKOVoWU2ybFZXNq9zd2Ui91fG0z338X2eINYRyUlJzFqvTLG8ACCV4aY05ZYk7tkOh6x3thYuktur+fSySgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gMY2Bf98; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so71777066b.1
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722945689; x=1723550489; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC/B0o7+RdgTPnb7EbqFy0h9TTXJHbv05EgMHed2hQM=;
        b=gMY2Bf98RUpANUbwD9ZjlIIy2UNvloYw+lDyi/4UM926nHwFATP4/ast0lBvXJ33Hp
         Mm9vgmCj1S6ftjh7+jhn9Gx/enN7wDXbic6cvka08aXjsSS7DVYAR/FNbWX/coGPO31X
         uAx9BE80T1aRyqm5PGeEjlwaIU+WzvQlzP3e4lSYg+gTvlYzFa4LNRLeIaN1ZCetayAU
         pIclbAWEcyf4+zG+6bOWkT5/QG5a0mkwhY+SE7YkgJu8xlfDMh3FdRhp+FaMRt+yMY3A
         J+N8HgfGGVH9weCRztOCergGyNEQ61FJ1TLhD53W68W16kfXcq9CjZKFnTaG9T1s3sxD
         EufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945689; x=1723550489;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC/B0o7+RdgTPnb7EbqFy0h9TTXJHbv05EgMHed2hQM=;
        b=eieKjKt6mg8BNzzQLwG6P2Yl2+sT+elHJ686zKWkidUd7vKZwtmy8qLiDDcgJphJLW
         mEKqjouhlEFqaJuERzGJTGbn2aqeidZynqwycE/zXGMz8Zg1uSYo4JqYU9JZ1X1dk/cN
         nJb60Up360gKMVojwE/6GKMgh9T/BrYNVThtrqRDlTzl6j8L6jrc38DlUvQL+lbe55hu
         yeXs612MMhfkD/mF2k/nhUx189fyiGv11PLMKPoc8kvT9jRBI6nZq9agBynq9C2bsAtD
         sBVfolQTbRpl+yDdYjiP6URBHCKCz8EqIOH5ttWmBIRmugNzR0JUz6w5F5ElhChmIz7p
         R8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWZMJBcaNmqMCZ5LiYQ7b+wt1yhTiElXuJTDU7zEbp7BTka5Un3z636BwVeC8eoEEfBW2NP6KoaR9AV1UBmpgD8Xxe9
X-Gm-Message-State: AOJu0Yx//M393whD0jdoWXGezyNgwTQK/41qJ+zr0kLMnLwDcUk7CLwt
	zahhNVla0XSzdVnGQ/MQbfhZUomzSMRiNA5dvyuKYnyz8hNag37Bmy9OmpK1K1M=
X-Google-Smtp-Source: AGHT+IFZECUBQXofC+L4rA9OhKjiBlUfVSyXAns5FoFrow7eTVkumUQVC1WUleF3rWg3eVS8qyr7bQ==
X-Received: by 2002:a17:906:db03:b0:a7a:b070:92cc with SMTP id a640c23a62f3a-a7dc5106e2amr1253822266b.45.1722945687914;
        Tue, 06 Aug 2024 05:01:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c801sm539912666b.59.2024.08.06.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:01:26 -0700 (PDT)
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
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	(Michal Luczaj's message of "Wed, 31 Jul 2024 12:01:25 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 06 Aug 2024 14:01:25 +0200
Message-ID: <87y159yi5m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31, 2024 at 12:01 PM +02, Michal Luczaj wrote:
> Series takes care of few bugs and missing features with the aim to improve
> the test coverage of sockmap/sockhash.
>
> Last patch is a create_pair() rewrite making use of
> __attribute__((cleanup)) to handle socket fd lifetime.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v2:
> - Rebase on bpf-next (Jakub)
> - Use cleanup helpers from kernel's cleanup.h (Jakub)
> - Fix subject of patch 3, rephrase patch 4, use correct prefix
> - Link to v1: https://lore.kernel.org/r/20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co
>
> Changes in v1:
> - No declarations in function body (Jakub)
> - Don't touch output arguments until function succeeds (Jakub)
> - Link to v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
>
> ---
> Michal Luczaj (6):
>       selftests/bpf: Support more socket types in create_pair()
>       selftests/bpf: Socket pair creation, cleanups
>       selftests/bpf: Simplify inet_socketpair() and vsock_socketpair_connectible()
>       selftests/bpf: Honour the sotype of af_unix redir tests
>       selftests/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
>       selftests/bpf: Introduce __attribute__((cleanup)) in create_pair()
>
>  .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 ++--
>  .../selftests/bpf/prog_tests/sockmap_helpers.h     | 149 ++++++++++++++-------
>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 117 ++--------------
>  3 files changed, 124 insertions(+), 170 deletions(-)
> ---
> base-commit: 92cc2456e9775dc4333fb4aa430763ae4ac2f2d9
> change-id: 20240729-selftest-sockmap-fixes-bcca996e143b
>
> Best regards,

Thanks again for these fixes. For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

