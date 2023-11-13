Return-Path: <bpf+bounces-14996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDE7E9D52
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91524280D72
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA9208B4;
	Mon, 13 Nov 2023 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/DT/y7I"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CA208A3;
	Mon, 13 Nov 2023 13:37:03 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38495;
	Mon, 13 Nov 2023 05:37:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso36060955e9.2;
        Mon, 13 Nov 2023 05:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699882620; x=1700487420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocmDA6id/NF3DaxM6Cm9iwKhBzx43it0XbOd19pAJbQ=;
        b=h/DT/y7IvyTniQYUrjvCwXt+faDPxOXDT8hnyiueWa9vh9lUvz7obYDn/XpWjXJHiP
         17MDgf7dLoD4OyWfSAduLEc1uXUE2gBvE+ZoRHN6jbeBSNtvWtECnhMO+8rLtZ3XPanf
         XrDg8lC2HZiVXZ283mq4v15pGepxNZY/eOuREYMQIVMrUNlb3J0qbxBF4XwKIty/366+
         emJIIwk7WW210EFX7EHXK3qhCLSrhN24ZZtGOX7c2mg4f/QzObDc/v0u23Mtr8Pvg5Eo
         AV8zi1RJyDRhtj3WQYOvehO8l3LTWTieo5Da4idYhWD0tST+YRq75dm8aAo08yxeJwzA
         rlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699882620; x=1700487420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocmDA6id/NF3DaxM6Cm9iwKhBzx43it0XbOd19pAJbQ=;
        b=r9vStYdSxCDetLVZFyTfYbUJCSXdbFUnA2AFDx8MzdlM7fAWA5zSSd352X0sj5gIFD
         2k9qWqcF4+HEyGE8Pal9MHNW72kF5Hco8rFzzYpU8zzUHJ7Xc03+Ndp348L/L56v//GU
         /kIo7gBecGgtwYPiQpN6NWiradrz7KPFzOEVaEKb1In2m7Xa1Sa1VqO1FPMA3khbm+3w
         2KDuE0pFA6iEt0IawVkVwqOHTq1VeVyajI4I7xk1h8PPUxz/oB4dGja8GcpR4gWl3Wwf
         d9d2ZpIonp9mNWxE7s29a/9rceEsGuDn7yHqKKuKi6zDZ4tzEz6ohiL2jsSrNYwuJmGd
         EMqg==
X-Gm-Message-State: AOJu0Yxu9MtAUHYDcnAK6Nb3hfLwxi/1NgoOqLIznbbcRXAaPci5CiFy
	vGJ1uViasTaAwdNvVN1xvddswZwbzQRMISjJfLp2F3oY
X-Google-Smtp-Source: AGHT+IH2JbpoZJDSXbPjWtRDsPd4GFnlAZZXM7umYwn2IInVRnZwL1jyqoMST4ZWqPrsVRzdJh/45mbJ4qPL43U9rhY=
X-Received: by 2002:a5d:4d86:0:b0:32f:7901:c462 with SMTP id
 b6-20020a5d4d86000000b0032f7901c462mr5230198wru.3.1699882619897; Mon, 13 Nov
 2023 05:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1699609302-8605-1-git-send-email-yangpc@wangsu.com>
 <CAADnVQL=8-ViD7vPy4tQ1Ek6TzC24aMVFwt4_k0Jc7igz-5Jkw@mail.gmail.com> <87y1f2f20f.fsf@cloudflare.com>
In-Reply-To: <87y1f2f20f.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Nov 2023 05:36:48 -0800
Message-ID: <CAADnVQJARz-9XgpCPvjwXCgyYkvZBbHez=wR5OcmA1TpSyYSKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, sockmap: Bundle psock->sk_redir and
 redir_ingress into a tagged pointer
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Pengcheng Yang <yangpc@wangsu.com>, John Fastabend <john.fastabend@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 1:14=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Fri, Nov 10, 2023 at 07:42 AM -08, Alexei Starovoitov wrote:
> > On Fri, Nov 10, 2023 at 1:44=E2=80=AFAM Pengcheng Yang <yangpc@wangsu.c=
om> wrote:
> >>
> >> Like skb->_sk_redir, we bundle the sock redirect pointer and
> >> the ingress bit to manage them together.
> >>
> >> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> Link: https://lore.kernel.org/bpf/87cz97cnz8.fsf@cloudflare.com
> >> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> >> ---
> >>  include/linux/skmsg.h | 30 ++++++++++++++++++++++++++++--
> >>  net/core/skmsg.c      | 18 ++++++++++--------
> >>  net/ipv4/tcp_bpf.c    | 13 +++++++------
> >>  net/tls/tls_sw.c      | 11 ++++++-----
> >>  4 files changed, 51 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> >> index c1637515a8a4..ae021f511f46 100644
> >> --- a/include/linux/skmsg.h
> >> +++ b/include/linux/skmsg.h
> >> @@ -78,11 +78,10 @@ struct sk_psock_work_state {
> >>
> >>  struct sk_psock {
> >>         struct sock                     *sk;
> >> -       struct sock                     *sk_redir;
> >> +       unsigned long                   _sk_redir;
> >
> > Please don't.
> > There is no need to bundle them together.
>
> Seeing how the code turned out, I agree - it didn't work out.
> Code is not any simpler. My gut feeling was wrong here.
>
> I gotta ask for, for the future, though -
> this is not a "no" to tagged pointers in general, right?

In 99% cases there is no need to mix pointers with flags.
When you need to set/unset both pls use a lock.
A lot more obvious to humans and tools.

