Return-Path: <bpf+bounces-60634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A940AAD981F
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 00:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CDC4A0CCE
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 22:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CFE28DEE7;
	Fri, 13 Jun 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G95iBrRN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B2223DD1;
	Fri, 13 Jun 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853457; cv=none; b=YTcVjgYj6Qqg3aCFY7KA2TA675n7N2YIgXAc2idWDR6ePwUG5MjSW4hxOsOJZ9onz9YEJiBNBYHAJn/rL77GHCJLfiHqa4R656BDp/t1ixlzmHJYdrCDpfIx83sCaOmPIDj3KBEzkw7gIkI5PDQX9mNtd8YiDD9thJN3RPVC8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853457; c=relaxed/simple;
	bh=bNdwETcqpIfwYNdS7suhS0ZcjU3owd6t5QykQLqOVvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4o5vKpAgyFnAY/Juw2xUWYFJ7zZ90+GdH4UXrSuyEdaavCb500pmMb3DruwyqHATJJLYEYWnX/QLLhj6uLIwP0Qek5CHRxtbuGpYjfozBkPkdp6EFNhVQCWb+Xeyh4N1GpKIHkFjDpq/pNIvpgnMs6txCePtg1x00SgbFMeshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G95iBrRN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235ef62066eso36559825ad.3;
        Fri, 13 Jun 2025 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749853455; x=1750458255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq5VKt9XQUETe4teH1wFT9y9yXrZ3gXfIAVVgBJvQTg=;
        b=G95iBrRNWwWb1n5aXu35wMnsY5wKmywYvFAV9nvbCVoGK04OilQNsEAxYcmzh0yO7e
         64TZPqDPCK1tgLlwHZHeDjrALjU34d5au8jI0Hn/a5PG7XVhBvzGQbxoWjrqkyT5ebZI
         fAtVyj46u8cjsSjxa8vsGP5Yu9JJIwN3+LQ77mIcaSO7KKQBKdApLnItthNFy1HxD5Nn
         z/xffEdtIHvRchcPzk1Qzvu9UQlJF8DImcahNDuYzay4IdMipXF3zSeD0nEh0UmQr+VM
         KjNLW1TyrGtonARMpTMpPTzMNgsFblev1QvvG6ir860hsB7qprrrlYElRora1ybPvZkE
         66CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853455; x=1750458255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gq5VKt9XQUETe4teH1wFT9y9yXrZ3gXfIAVVgBJvQTg=;
        b=HMHKqBjYJCY0wSvCKIC5X0vNrXOZPQlkCrWxNRjZsQKriO0J5u0iNDE8skZgjgjef4
         7DzIYByU07/OFf/BrOHcQAt8GcPAj/Lb7joBFQQqhUha+xljloNpOAOskLCyk7T0cq7B
         6P/+ww6/XFMO1JPdnTr1BAvmb9wXJ65NOJ+vHlN7s8337nX6EJPLJlt/dRBg/t+V3KRd
         fcV4uDxudIXtUx0BZ98lnZ/kzkbASGbJVK/wN4/odUvVso2LSxPIx9gnU27bbbpmlszk
         xvJtYVNzv11uzXOh1ex7ch9IeSDmvyEHHQnRqeaRp9cRd5IctCybAk3UxivhpOaYz9Mu
         g9hw==
X-Forwarded-Encrypted: i=1; AJvYcCVVFWrQMEiVpupvc2Oreio0oWDGR76lBLMxJS7t7mo0oqz3wIFtyW/MMXAGbgm4kzIG3wLJzkHq@vger.kernel.org, AJvYcCWqtXCb4rbW2FLexLTLWrlF2mkcLfXEbRuGdHjo8hK9iuOHKtl9kgS1ESMiUzCeBy+OP/8=@vger.kernel.org, AJvYcCX2nETv7WJbXWvTPhyRPkGlCWjDCtxMaKLa1BcQ8Up1TuCQXA6pYf+r3DgJkKEA4RXfTwFuGXKHMFZ3ObJgy0g1RwN91gDv@vger.kernel.org, AJvYcCXx4MJYl1MF64B0ZnYubbn385U0vAta0LkpVkHhr2p9xBH7p49QXpV/uQee3m9KC/PG+UgWjytDsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEg+JoERKj9aWn367D9AZTgxi9IeNfJL4hMtQ/0KM4GmD1OvFb
	phHTizpJAUlyon1IXx0n9D6QszM+yRcov8+FqiJME+1bsPU7J88FiVA=
X-Gm-Gg: ASbGncuve7AMuZO875ms7V7bainzeCEfbLXNVUyuWPY4LkoPQAb9wsyh6g1skmccEeE
	iMit9SP6InQJKEdEM+0dBKNP5akSgK8esQyrlx+pIADeTg6nGGer7ESk2jSHjk55v8VGe9AUr6L
	7ZT9lZa9En7LmQi/h6upgUZUkcY+Z1SRdn6/7VDl7cxjtlA2StgBWBoNgWLjPLJ0lRJgzaV+M6s
	BFtZTlj6E1rXWgsflkM+ERH1A5DCY4K6tnY3iW7erz4Z6NozcaKuzKmnvX920t00FENiaYJc5U2
	AoyynanFnu8CEogXmOScIUUk/95P1TwwBNb+DTg=
X-Google-Smtp-Source: AGHT+IFKqOsIF5o2ATOddrVQR907k/h/rIQbIbX/Zwqp6dzJMu6Rk3B4uBoE6XABiEFQpVNqbfpVcQ==
X-Received: by 2002:a17:902:ce89:b0:220:c164:6ee1 with SMTP id d9443c01a7336-2366b3dd319mr15926205ad.32.1749853455000;
        Fri, 13 Jun 2025 15:24:15 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm19840615ad.239.2025.06.13.15.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:24:14 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/4] af_unix: Allow BPF LSM to filter SCM_RIGHTS at sendmsg().
Date: Fri, 13 Jun 2025 15:22:12 -0700
Message-ID: <20250613222411.1216170-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Since commit 77cbe1a6d873 ("af_unix: Introduce SO_PASSRIGHTS."),
we can disable SCM_RIGHTS per socket, but it's not flexible.

This series allows us to implement more fine-grained filtering for
SCM_RIGHTS with BPF LSM.


Changes:
  v2: Remove SCM_RIGHTS fd scrubbing functionality

  v1: https://lore.kernel.org/bpf/20250505215802.48449-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  af_unix: Don't pass struct socket to security_unix_may_send().
  af_unix: Call security_unix_may_send() in sendmsg() for all socket
    types
  af_unix: Pass skb to security_unix_may_send().
  selftest: bpf: Add test for BPF LSM on unix_may_send().

 include/linux/lsm_hook_defs.h                 |   3 +-
 include/linux/security.h                      |   7 +-
 net/unix/af_unix.c                            |  32 ++--
 security/landlock/task.c                      |  16 +-
 security/security.c                           |   5 +-
 security/selinux/hooks.c                      |  14 +-
 security/smack/smack_lsm.c                    |  12 +-
 .../bpf/prog_tests/lsm_unix_may_send.c        | 168 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_unix_may_send.c   |  83 +++++++++
 9 files changed, 309 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_unix_may_send.c

-- 
2.49.0


