Return-Path: <bpf+bounces-31672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC0690142D
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 04:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B71C281E90
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 02:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13C4C9D;
	Sun,  9 Jun 2024 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpYm57li"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3C360;
	Sun,  9 Jun 2024 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717898515; cv=none; b=tW5GhG5ORX8IbWFHT5mjZENAI4O3Xi7NLd7huQMeKuOZN0SbUeeACl7JKtJa94AzBHQYU8atn/LIqq+It/uEMfNbiww7pM8i2/kURfdYopfjJWp1SWQVy7qHza0lHzkueZE/g+uVXfRXID9n5Jt6AwficKyxem+G58tappyLGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717898515; c=relaxed/simple;
	bh=08AGbFoiIhT8CCWPQ5323YR9ofwOGzf3ofO49c39UQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOugglt8uO9e8Nw6T3orPKYyqFJmmT6lP48EzcvZdDxJgY2TgoFJg51JGajD2z0WsAMkW3ignoIhgr7CGMvHTuzRW/asL6bKmt1PrR7RSyxIlmnkdehI96qfWYSHOrKwPKkabCIR0C6FaShYm8JhyhaAHnQq+a0VGBICnb6rdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpYm57li; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so496558a12.1;
        Sat, 08 Jun 2024 19:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717898512; x=1718503312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfXDqZwDxD8KMJhtW0AkGu6qi+j8Yxaz8SLLYgYQRh0=;
        b=VpYm57liBv3+3l3eHQEJm+GDyakMFdKR/CsUy3NUQvST1ZawiK7VjwPnoiW9yJ+MY2
         23Je+SJ2a1Ks7UzNOBUeoDFsg6GxHxPdbc/iz6pAJQIkqUwDGombwl4x5vdRq7v/X548
         wCE/VzTSbV56Ind6m+IZKigx9N7cqfJ8qpDMr/V/soida9CTY4QeXvuGZpVCtLarTfeS
         OvnM398wRJd/418cOidpQLRQRpu0WAEGYJFgi/0BQ4pPYOFOJ8auLyazE8TBX2KznpDq
         miy2uqmKBnHBIr5qwEJfBg+9FUJKmpCKJdFutjlZz5CEHTX1zdo7av5xI+2KFtjWznWd
         4htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717898512; x=1718503312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfXDqZwDxD8KMJhtW0AkGu6qi+j8Yxaz8SLLYgYQRh0=;
        b=mq/IylfLAOwNMVwFPNGBmX+wP22NYHx8vsi6ooIP9Hlb8sV6B10ev1cggh+nrNOLnb
         34etP0FWePv53CLdv9WJmHzZCjFtQNBCgZuNj24htBU5HTNDaO1xNwtjEnBz9r5xb5/r
         5fmUqgv5tS1v2hKyjjGX0dzKx4bA9NhRIZJCb5Ilk4RDZrsvRkd+KUxUJfqvGerwF1NC
         pRXZZUa5Dq/wDdv1LEG5TxvX+x1cBe96oHT67095iRJiWztRDMHk+BdgNvNF00GMrUJa
         SH3fT870hSKXSFI0XMuWHd1OJPnsjP09dl58lqKvOnwylio/ql2wVS2efyhBQZMSf+5E
         ZxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSSELe7EubuvSrOpD4nOsiAmsHVfSTY8bG6+qVQ6VAS/pSX82F16AMWrxwlYxxZCOFGbEXTvD9d947DrAoiAmSp9vBSUMNLItoU8qbypQbk0fUa2pT43MyDcBx
X-Gm-Message-State: AOJu0YwPBViD6yVYzQnAwtvaYy8OvgEKUShUUA5JuxLfzStpnkPUoFV5
	3geIBG2tbtkEJ4cJ7VQCLZy4L1iZU+QrZn5FoQluWv0S292qxTuq9zulDZvlqTVB8ApU6VBbp9a
	6bS4hhDVcpNnNi78S8hgzj+9RbSt0HL6B
X-Google-Smtp-Source: AGHT+IGd45m+2C9hnYWV2mEFTuUpDzvSnBlxlPAAzqNlpShpRcJf3vCbdqcj2Z3aizbL73yg0o/B6ULaP4K5bqtOpVw=
X-Received: by 2002:a50:9b11:0:b0:57c:620d:7700 with SMTP id
 4fb4d7f45d1cf-57c620d7a2amr2385574a12.35.1717898512340; Sat, 08 Jun 2024
 19:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmMxzPoDTNu06itR@pop-os.localdomain> <20240607213229.97602-1-kuniyu@amazon.com>
 <9f254c96-54f2-4457-b7ab-1d9f6187939c@gmail.com>
In-Reply-To: <9f254c96-54f2-4457-b7ab-1d9f6187939c@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 9 Jun 2024 10:01:14 +0800
Message-ID: <CAL+tcoA1KvG_QcD_GZT_S20z5FhadjzO5ku1Hk9HP-SzhkeCzg@mail.gmail.com>
Subject: Re: [Patch net] net: remove the bogus overflow debug check in pskb_may_pull()
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, xiyou.wangcong@gmail.com, bpf@vger.kernel.org, 
	cong.wang@bytedance.com, fw@strlen.de, netdev@vger.kernel.org, 
	syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Sat, Jun 8, 2024 at 4:01=E2=80=AFPM Eric Dumazet <eric.dumazet@gmail.com=
> wrote:
>
>
> On 6/7/24 23:32, Kuniyuki Iwashima wrote:
> > From: Cong Wang <xiyou.wangcong@gmail.com>
> > Date: Fri, 7 Jun 2024 09:14:04 -0700
> >> On Fri, Jun 07, 2024 at 01:27:47AM +0200, Florian Westphal wrote:
> >>> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >>>> From: Cong Wang <cong.wang@bytedance.com>
> >>>>
> >>>> Commit 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/=
push
> >>>> helpers") introduced an overflow debug check for pull/push helpers.
> >>>> For __skb_pull() this makes sense because its callers rarely check i=
ts
> >>>> return value. But for pskb_may_pull() it does not make sense, since =
its
> >>>> return value is properly taken care of. Remove the one in
> >>>> pskb_may_pull(), we can continue rely on its return value.
> >>> See 025f8ad20f2e3264d11683aa9cbbf0083eefbdcd which would not exist
> >>> without this check, I would not give up yet.
> >> What's the point of that commit?
> > 4b911a9690d7 would be better example.  The warning actually found a
> > bug in NSH GSO.
> >
> > Here's splats triggered by syzkaller using NSH over various tunnels.
> > https://lore.kernel.org/netdev/20240415222041.18537-2-kuniyu@amazon.com=
/
>
>
> Right. We discussed this before. I guess I forgot to send the fix.
>
> Florian could you submit the suggestion I made before ?
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index
> 358870408a51e61f3cbc552736806e4dfee1ec39..da7aae6fd8ba557c66699d1cfebd47f=
18f442aa2
> 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_s=
p);
>   static inline int __bpf_try_make_writable(struct sk_buff *skb,
>                         unsigned int write_len)
>   {
> +#if defined(CONFIG_DEBUG_NET)

I wonder why we want to avoid printing warning information especially
when CONFIG_DEBUG_NET is on? Any reasons?

> +    /* Avoid a splat in pskb_may_pull_reason() */
> +    if (write_len > INT_MAX)

I guess: if the purpose is to skip pskb_may_pull_reason and then
return a proper value (-EINVAL) to its caller when the above statement
is true, can we add the warning here on top of you patch:
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
?

After this, we can print useful information and let the caller catch
the -EINVAL return value.

Thanks,
Jason

> +        return -EINVAL;
> +#endif
>       return skb_ensure_writable(skb, write_len);
>   }
>
>
>

