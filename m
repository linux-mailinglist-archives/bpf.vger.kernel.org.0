Return-Path: <bpf+bounces-66607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79020B37544
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 01:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B44D1BA1C80
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F6C2FE054;
	Tue, 26 Aug 2025 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3lbifus4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730A2BE7DD
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249819; cv=none; b=JCgJVv66gdyC2VtSpGtmdwQgf1w7H7bNlV8syJTxcm1O7Gm/O2JwGd1JrtfjnAWYgED1n6G34CmBaF9cjnY70l6VkdaJqUDb21vopK2lOxlbta4JJfH3eoFqJmjo7XY95BbfgNLNxRern1a9ckO2abOLRe0A9bfVRwV4Ds6Rxb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249819; c=relaxed/simple;
	bh=HzHR1FIpZ+Ah0OX76qvjupuPRN2VYosMVQ84TKC+cRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OO3m31mckmifk9/T96V9OY1mfU17j8J2WUGkBQA3xcivFbSlQDVQC8Iphj+RQHMw/cvWViXc0FdWRiJa/3RMi7ix9sEPcmiWeNPvKtUz5Uo8Xb8pkmIgXDoNF9zKv6R3v9AAnRQlTp90shuIUGiod5isKA1DqYz5kw5mbZmn3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3lbifus4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2487a60d649so11619005ad.2
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756249817; x=1756854617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFHzS9Vz2qI33T641gBuN81YJ0ykJAgwplIKTWI5uc8=;
        b=3lbifus4lU2TGD3J3ffIv1JhCMwWka8tmJbSaYY3LB98V9I1g3GAlnkgmBoSsE3Rzs
         yFxigLVtvboW8Cq+XPF+HxQaZIQCxOjx00AYTqXAbhmiXTLKGuuy6yQCq6I1wTnnnbc4
         e19rdz5Efof1IZykT8xZFlGFQDuMY42LfG9+ZpC887hMbIZDrpKojJ87boO67zn608WE
         Wd3o/qbOyx12Ro/8oaVrprQHdcnF4rCA1QDEsfW+nviE1lU9Dq5em9/SC3G0mvyA7KkW
         DCC8pUuwoOQN0AKPbe/MUka8zEmuHlVMqJjVbA/bbVrotrw4/Z7wCSh4dr2o1Hpb7hN+
         UUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756249817; x=1756854617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFHzS9Vz2qI33T641gBuN81YJ0ykJAgwplIKTWI5uc8=;
        b=QXu/zbFiZbwlCGfiGE7DaiUitEQgjc5BCsgbOodLUS1Za/55HIRvPlGI0oGtUuKmid
         nW5sqwLS3/Z2+THGjeDFB4UM6pezwvQk9XRs4zoe4MtnLgS6jvFRQ0Nel4dZxR1WiO8F
         zHk2v+egcBbCpjTBrFiV19Z2DjAKyyamPJRw/iHF4POM3JwxvDkU+3FV1smENDAkq0la
         om5+UUeZlTic5axFfrd4+pPjP6j+a/9SsPG2xXVhb95gSyKxMTRyYDPl5u3dZYhuqPJM
         8KJh9QrFfv3SkOfwSfG4bSCLhJc+/7jCXIY0+pi+VgGDZkN8OF3sQ260fvGQljaiaEer
         AzDw==
X-Forwarded-Encrypted: i=1; AJvYcCVhVK865IMvFlKXio/EbOlaZ2QCOCJlu3KUFKV9JibWsgZXqOR7LFYwR2GdAgF73Anm3n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCHrwthEHZQBSDIXCKCZRbt87UG6nmM3FZDrvE667UPYygu7i
	F4dYf35jfR96MknaDwr6dRvsOR1IxLozKC9hKrlRogs/w717E7xeYmHZBmMI8hTIwFVQ+LO4W6/
	8P0CIiYk7DBLi1wI5z0GlbGFKA6uwi/cDTby5K+wB
X-Gm-Gg: ASbGncsfxRqmm7Sx2/pmh672T7KOFm3/8Y6fis5Adn4c3JM5FDUgxAUyJl2YpK7hIIo
	wellc3LGd5/jc+JUx3cOuQFXRb9+XS4lDjC6CqjU4tVDgPcGzHsXubXjU1jNPdoUP/XFCRtaRwz
	Sz9X1+YKexSc2VWUj7yEI9nMpKqsH8OzW1F/LWQ+E4pMzwPWzpMPUclcGgRKUtB881GAna9gcaw
	p0pbVmQtWItZbAZxJYx9VSiY+BErsH58zyCQ6kHLu6zOksLDr+cxPN3PkiDV+ADeplgYCG+OWo=
X-Google-Smtp-Source: AGHT+IGn57sOU6swdYsx/QCrjhxq0MqZLxuckGMve65sULjrNihbiqrOdTIv5dqJ+0z/cHjZlaY5GmZUPCfXi3CBib8=
X-Received: by 2002:a17:903:19e7:b0:246:688c:7f64 with SMTP id
 d9443c01a7336-246688c832fmr177995805ad.41.1756249816687; Tue, 26 Aug 2025
 16:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
 <20250826002410.2608702-1-kuniyu@google.com> <2bac5d14-6927-4915-b1a8-e6301603e663@linux.dev>
 <CAAVpQUC-5r+nbB=Uhio0WOEDV7dMcuUM-tF=auAV_rvAWH5s0g@mail.gmail.com> <93ddc9c9-e087-4a8d-a76c-8a081cf3f1ac@linux.dev>
In-Reply-To: <93ddc9c9-e087-4a8d-a76c-8a081cf3f1ac@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 16:10:05 -0700
X-Gm-Features: Ac12FXzqS7J_KCoPi7cmkEec0GJrW4e6XliBpPlO8EvOCw7H9usNDhXkpymiyVk
Message-ID: <CAAVpQUB18FOE3iJWt4kAUexEb9ND9An2xn=0Qz=5W6YeWGgi9Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: almasrymina@google.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, hannes@cmpxchg.org, john.fastabend@gmail.com, 
	kuba@kernel.org, kuni1840@gmail.com, mhocko@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, roman.gushchin@linux.dev, 
	sdf@fomichev.me, shakeel.butt@linux.dev, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:02=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/26/25 2:08 PM, Kuniyuki Iwashima wrote:
> >> ... need a way to disallow this SK_BPF_MEMCG_SOCK_ISOLATED bit being c=
hanged
> >> once the socket fd is visible to the user. The current approach is to =
use the
> >> observation in the owned_by_user and sk->sk_socket in the create and a=
ccept
> >> hook. [ unrelated, I am not sure about the owned_by_user check conside=
ring
> >> sol_socket_sockopt can be called from bh ].
> >
> > [ my expectation was bh checks sock_owned_by_user() before
> >    processing packets and entering where bpf_setsockopt() can
> >    be called ]
>
> hmm... so if a bpf prog is run in bh, owned_by_user should be false and t=
he bh
> bpf prog can continue to do the bpf_setsockopt(SK_BPF_MEMCG_FLAGS). I was
> looking at this comment in v1 and v2, "Don't allow once sk has been publi=
shed to
> userspace.". Regardless, it seems that v3 allows other bpf hooks to do th=
e
> bpf_setsockopt(SK_BPF_MEMCG_FLAGS)?, so not sure if this point is still r=
elevant.

In v3, it's nuanced to limit hooks with sk->sk_memcg
to unlocked hooks, socket(2), but if there is unlocked place
with non-NULL sk_memcg in _bh context, we will sill need to
use setsockopt_proto.

sk_clone_lock() and reuseport_migrate_sock() in inet_csk_listen_stop()
are the only places where we don't check sock_owned_by_user().

sk_clone_lock ()'s path is fine as sk_memcg is NULL until accept(),
and sk_reuseport_func_proto() doesn't allow setsockopt() for now
(error-prone to future changes), but I may be missing something.

