Return-Path: <bpf+bounces-17859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59610813613
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B9EB21A03
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7A5F1FD;
	Thu, 14 Dec 2023 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nv/vsumd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDEB11A
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 08:20:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso12124a12.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702570854; x=1703175654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9Tkbd+vgvPfQvmzFuw7EJp9AlY0xKXUe/iYI8xwtkc=;
        b=Nv/vsumdYBPzOmCTxniyEF/90Io4t7gYAP3d/4NoEm1xdnyIwvN5yb38J7YcFOQUtn
         M00la6P8kuQV9t9L/aUNWVCDGT5K+XX54o7NjnuCNLiWqoehZpHuSaA7sirz7R8o+344
         7N2AMW4sTE7Fq4mXdAwwwlmSTijUi+YjcWJM9wbMwFxb88KAz9RxIcYcffFOTR+2a1jA
         xCGnFEHWebdiJY27jioYQA8K32Q+NTywaFaPJXJW0eyKUplUkZeMoRUcdeqqHabfEeyE
         hIiUgCgoWRpODInveWdinYOmoOeJvAvgrzF2F9Murg6NWxobXun438+ViHbcfk/EWVCn
         ktVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570854; x=1703175654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Tkbd+vgvPfQvmzFuw7EJp9AlY0xKXUe/iYI8xwtkc=;
        b=A9VGOLL7ZYiKxcThYYefQP0MXguT0s9k/ovUUbpzJ9IvgL2gQ9FzMsa8WIHa3H8MgS
         0jPsNOxh4u3ns8vtPy/v2MULFz4KbTsWkj3si5k+Z+yF4TWyHTfM3oRZ4IsQ8ftXLzaZ
         vHjObOImkc+rRpSPTZEPqpwzcTuGBRofBEF87rhPG/JPPUVAf0rDcY32dqNY3W75wQQS
         kqliHFvEam+ZvaF4sbKvawflbwCwQnEHwVcIw/yb1IMRQa4+ZVf7PE/Gq1waD44MPrqX
         dzBxlaXYSMUPTIs0VUgmmUlWUiUrRAqnzByvTyMQuPIXWwsZG9n3xd4yHFhl6uPSiIyQ
         bc/A==
X-Gm-Message-State: AOJu0YwPA3Rfuxsbi35ErsTghqBmMLGmqV0RRXyotpP38zr2yHucqmMB
	QGH6SN/THMR+7TIqu/ETUExbfy1DC9i+bcIBt76N6Q==
X-Google-Smtp-Source: AGHT+IEccxJBJUVFiwQuPTLlWaecen1ncKNDDCSulEKeP/RqVKpMu+tXNpVr4FuJ6hf0D4Enp1tkHn7cV3bjYLMOsdY=
X-Received: by 2002:a50:bacf:0:b0:545:279:d075 with SMTP id
 x73-20020a50bacf000000b005450279d075mr648060ede.1.1702570854005; Thu, 14 Dec
 2023 08:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214155424.67136-1-kuniyu@amazon.com> <20231214155424.67136-3-kuniyu@amazon.com>
In-Reply-To: <20231214155424.67136-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 17:20:43 +0100
Message-ID: <CANn89iLo7xoB3NR-0goSH+buLZ2ekXPBUCGWLOSMWGLDfHL5ug@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/6] tcp: Move skb_steal_sock() to request_sock.h
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF.
>
> If BPF prog validates ACK and kfunc allocates a reqsk, it will
> be carried to TCP stack as skb->sk with req->syncookie 1.
>
> In skb_steal_sock(), we need to check inet_reqsk(sk)->syncookie
> to see if the reqsk is created by kfunc.  However, inet_reqsk()
> is not available in sock.h.
>
> Let's move skb_steal_sock() to request_sock.h.
>
> While at it, we refactor skb_steal_sock() so it returns early if
> skb->sk is NULL to minimise the following patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

