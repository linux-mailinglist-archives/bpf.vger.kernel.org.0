Return-Path: <bpf+bounces-70741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB053BCD805
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 16:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F1604FFA1D
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834D2AD0D;
	Fri, 10 Oct 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgcdt5nb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B882F549F
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105963; cv=none; b=PI/aqg/+18NNAZotla424Z38VLt6uUHR84VWCgGGbnjhCfIHt7GjwSN/9j/o7aedvr0A3n95YDH+/uJ3HvfHS1d7hO54UeN92HsWsBz7laonNrPuc2WXytwdOX9Z0maM9M5LIoLptdxW40aSLE6TParrQ1E1bEtZChhrYz47H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105963; c=relaxed/simple;
	bh=FdLxE7Lm30nhyAzpTObSV2SsmYXiyE6njXvC6pEK/ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdlu2RzPmoW4cGgmcSq50WzsQM8zMe5QzjM26lk5zJHTBIzChTUn/Az11lNzfd76b6c4WXBJrz1Bx/WuYx9l7alB/DjjmvUQ3snAj2tGTiG1IZ1sHOFI/yiJ7nTGKNmaoLsMj/Xl8GsJ0v9r16DkNZbDXKDMa9OR4qQNM2hNdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgcdt5nb; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d6051aeafso22134217b3.2
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760105961; x=1760710761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdLxE7Lm30nhyAzpTObSV2SsmYXiyE6njXvC6pEK/ss=;
        b=mgcdt5nbX1LLUaGdnUPLUImPENVMbDBZ/LIBH4nO6BbtnVPuj8xQF++g6WRLpevd9u
         nQNz4U6c5mLeiUazjtzOJfUDLN6RBUPm2934+fnbqyxYCK640jwZ8YdS5ua/b1g5r+7G
         iedrPck8PskE12I+Bpw1Yq/hP+b+KHWaxyjsmtlkvMJrGVu0ritCRfA+ESqZ4fE035XU
         3U0JUz3LaPiJckH/vh7wDwrKh6V9uvmtAOHBe4Un+G0XQGcyeRSxd9VO+qb8HlElyAd1
         CzOTaYPoVYmVJk1zb+4P5RVGJlztoex7DUOtgfOtcLnxs2SvImjz8upUTUMZh14y4Cfo
         uYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105961; x=1760710761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdLxE7Lm30nhyAzpTObSV2SsmYXiyE6njXvC6pEK/ss=;
        b=UCO80ODVi9pKM4kl+lHClGaerzTgVoJ7eHJnqxJKRYIxqz639Gc6C7TjBuBLTfIjwO
         ueGbhhYltHMqSU9Wphin7D737DlKy6KnO4RsKqbrk0krj6Pk4zofoUVei8W+Sfe+2zQk
         ku0qn6M88uPTCalf5cj/RHQzog3UcxMV0yjeoJ4kmqH7/ewRVfx+X9aiki7wzHPZcUhD
         Ob28TTheFl1sjLl1p/F/0qVH8WkiCydFDMFOHPV/i/Ceenz0yoWOTxYHTZSvRa1wvvjX
         n6Yv1Ichrkay/pudFmPsWg9YVcGZ6bYVcWhY3z22Bbtxl+8kizCExiDBl1RVQtlDqJsZ
         aXDg==
X-Forwarded-Encrypted: i=1; AJvYcCUrDdQCHRWZJVSzbzI5PDMKYlJoQMi/09xjkw24SkSCX9Glp62lxsqRIJ70sP/4vE0/uNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+PETVKQczp0ZCwoMEWLpjkYDuZEZ57FJIuJ9tksECG32Ms+C
	L5CcWDgOppYaDXISa3ZouJsqKu9jNdCO+rAuGTdzZlVHvan/1Yo0J6Vlk2NW3RSmBaYaMFLzaZb
	nHIubXU/jzNnyLja/KL9+BaXuN+3e554EN5XNZCQh
X-Gm-Gg: ASbGncvYTd+FX8PeDETFSISmZXcsA8LQ4n2PIDNlfjF294KDDkbXNS4X1dBo1/jecaK
	f/X2/BNZCdWyNGUWwkSeWsytHWEa4gj5JtXUbfV+WC2gBFCEcXKkT1d/rO68x2/ApB3h08EF3Nj
	qYOeXZFUGMKLdp/k2ULGVKky0KHVR7DE61R3zxJxcIhmAQRameMDh11tHCJOCu1wA79wV2WasaD
	OTBrXZ2YWPaiUbg/3MlMDKvQMcEXdBZu7S0ppqohtJf
X-Google-Smtp-Source: AGHT+IH5jygwKiKj8iWh7NXNa5aupSDxyDfR+khBSnZcImv7vqxxqCrpmKSorFziFLH513QVJf/OcUBtXZUfZcpK4oU=
X-Received: by 2002:a53:b6cd:0:b0:636:d4ab:a507 with SMTP id
 956f58d0204a3-63ccb85e07emr8088258d50.16.1760105960542; Fri, 10 Oct 2025
 07:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com> <20251007001120.2661442-2-kuniyu@google.com>
In-Reply-To: <20251007001120.2661442-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 07:19:07 -0700
X-Gm-Features: AS18NWANXiYqX9j9t6ZkUl82Zdn7j6m_ZQHBRWnadmG5JVnbTEP8rqhXa70_KeA
Message-ID: <CANn89i+=V0Pr4B0C9NH4vLf4kRdQAhpT53UyVPEPxQavvZ6FCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:11=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> If memcg is enabled, accept() acquires lock_sock() twice for each new
> TCP/MPTCP socket in inet_csk_accept() and __inet_accept().
>
> Let's move memcg operations from inet_csk_accept() to __inet_accept().
>
> Note that SCTP somehow allocates a new socket by sk_alloc() in
> sk->sk_prot->accept() and clones fields manually, instead of using
> sk_clone_lock().
>
> mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
> so I added the protocol check in __inet_accept(), but this can be
> removed once SCTP uses sk_clone_lock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

