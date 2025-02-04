Return-Path: <bpf+bounces-50353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16D9A269CA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FAA18821F3
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469914B094;
	Tue,  4 Feb 2025 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXhXhVvW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDE1482F5;
	Tue,  4 Feb 2025 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738632344; cv=none; b=EvSMM98908xwjiStzO5MMsFfQkXgDKk+pj4dR/g6ZNOkZlLa9rXfM/QkorAQWZi3HbG27YZY2uzJNlc4+PdL7oCVY9RYKbj9JlsC/jZer4nZIdle0KclyNpFF+UUnoMzTBPj4u/4vlP8FR3+2nDziLKaCZQHO/bAv1L3lR/jjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738632344; c=relaxed/simple;
	bh=xykioqIni0+KPm6yb5W3gkaTg6YvrV+yFQnMDfSn190=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrOJe28vuLIsDWYOwVcBQz8JFAANbWtbjSgZneU3s8Ke8mOqxpgDZ2H0BPbmZku+P+iR0iXh7krk407xN3hLlmURDuuZAbxCySaiorLdbhuQSafip2/Dmm80mUCZh8q9EfKyw4Ax5KPT7ftgbv6wooF2Q2+pcEuqJXGQ+YsDLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXhXhVvW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8521df70be6so69496239f.1;
        Mon, 03 Feb 2025 17:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738632341; x=1739237141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu5jFdXB9IhaZG9FkaWwooYWHBZxVV40JdCfL3bku9s=;
        b=NXhXhVvW/4Q3Z9TFLie3bGVxggIpotXeuZFB5Nenhhyw/RYaZlkW2xie8zBTgJ4IYQ
         pVgMwuxLE9TUg6HBr4fBgfgqm3Rdw5Y/UzCZlgY/4IU82SNPjJxiLaoHJ1ZZTNb3moO+
         5bTYhR52MU4/b8iHTuyelmLw4CNU6W6lhubmqIytXZqnwobFBeh4m/eQV1msGfIVBRyw
         egnvBjcA8B/IIuIPg5lkBk/cp9VxnQ9zHND/WJtefn18S0WXnqD/5Ht3Kon+HJ2kZNbU
         DfCaHOm94so8IuRBAipcl6IiZJJDc9AZl0MYkkaZ2IkHpBzvS9dPoVZooE/GTcjMNSz4
         uwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738632341; x=1739237141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu5jFdXB9IhaZG9FkaWwooYWHBZxVV40JdCfL3bku9s=;
        b=tn5Y0bakhqmhHAOJ3OrclPyRsGUl2k2nR7df6UOGDa9/bUyc8bNPe88xKqYP65XevY
         0naF500QuTgWdeyv2ebMJqPID21MCvndF3Qv34/pWZiKdS1BULxyHzuRZ0CLAj9s0VgH
         k0OQyQRRCT6MjoHaDpcsKCFcq8IF/tS/lDCWNwOcAfbdPor0a2TqIHfVNjZhMDxv5euM
         4GqZmJA2Hy8HEuAjnYXO9SrPxRtFWwyj8YDEcFBAiGs+bKaIfG6sc7OIb6AMjwqcmBe9
         GeHtJ8YrKvKqmW7SyCO/bd96MPfwGWReoEL/WmlNgquXmRam16yUYa6XUeQzCJ8Z2N3L
         UoTw==
X-Forwarded-Encrypted: i=1; AJvYcCUFkI+ftflQsrmnt1Cn3iZ+f0DU1i7mCM7cvPocJGRTCkFRD9FJ399/TtpKLbAEINtIDA0=@vger.kernel.org, AJvYcCUo0qso9WNNVSvniH4xWXB+1LdF/61wOLpS82eNfJQAxSKgvJLqQyrFrVBqSg+nThY8grutEaz1@vger.kernel.org
X-Gm-Message-State: AOJu0YydO5oQ6iKa5wrZ2n/TT4uele9h5qYbVqjGGcEVL2guy2pHVlr4
	zMU9E4xeQ5nx9SshXumX8My9YojbaQQjuI66hIvPOpbl0CMZVbzV5EOLQJTJkaCSqldZ8ug6QdF
	lXLY3Tjj9wT+KgPpaMHuYEUT7E74=
X-Gm-Gg: ASbGncvGUpdy2mzXwQYez3lnC4HdzTFxgQAARdiYljT/0pmopEXE5lzjloVd+iVrwkq
	u0uVG2exJzyluyMEskgWAnxF3elKIMuloGF6xvs5iJBuJEtbPNVhEaFs2SLJAirL/Y9c0Dmg=
X-Google-Smtp-Source: AGHT+IFrMCJr3NsVHaCbGCt3eVumErzGsT6ItE3W5IHGucQL91XEA7pJVOmhrRYXo9m4Ga6DtCrEX1pn2JN4RqPth6Y=
X-Received: by 2002:a92:cda3:0:b0:3cf:b626:66c2 with SMTP id
 e9e14a558f8ab-3cffe45bc82mr220682305ab.19.1738632341635; Mon, 03 Feb 2025
 17:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com> <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
In-Reply-To: <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Feb 2025 09:25:05 +0800
X-Gm-Features: AWEUYZlD8VEPdq8cuo2nwG4EqDH9kX1DLBQB96vWN0rfIiSXXdy3Rb90xJjcpJE
Message-ID: <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 11/13] net-timestamp: add a new callback in tcp_tx_timestamp()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/28/25 12:46 AM, Jason Xing wrote:
> > Introduce the callback to correlate tcp_sendmsg timestamp with other
> > points, like SND/SW/ACK. We can let bpf trace the beginning of
> > tcp_sendmsg_locked() and fetch the socket addr, so that in
>
> Instead of "fetch the socket addr...", should be "store the sendmsg times=
tamp at
> the bpf_sk_storage ...".

I will revise it. Thanks.

>
> > tcp_tx_timestamp() we can correlate the tskey with the socket addr.
>
>
> > It is accurate since they are under the protect of socket lock.
> > More details can be found in the selftest.
>
> The selftest uses the bpf_sk_storage to store the sendmsg timestamp at
> fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timestamp (i.e.
> BPF_SOCK_OPS_TS_SND_CB added in this patch).
>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/uapi/linux/bpf.h       | 7 +++++++
> >   net/ipv4/tcp.c                 | 1 +
> >   tools/include/uapi/linux/bpf.h | 7 +++++++
> >   3 files changed, 15 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 800122a8abe5..accb3b314fff 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7052,6 +7052,13 @@ enum {
> >                                        * when SK_BPF_CB_TX_TIMESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg sysc=
all
> > +                                      * is triggered. For TCP, it stay=
s
> > +                                      * in the last send process to
> > +                                      * correlate with tcp_sendmsg tim=
estamp
> > +                                      * with other timestamping callba=
cks,
> > +                                      * like SND/SW/ACK.
>
> Do you have a chance to look at how this will work at UDP?

Sure, I feel like it could not be useful for UDP. Well, things get
strange because I did write a long paragraph about this thing which
apparently disappeared...

I manage to find what I wrote:
    For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable because
    there are two sending process, 1) lockless path, 2) lock path, which
    should be handled carefully later. For the former, even though it's
    unlikely multiple threads access the socket to call sendmsg at the
    same time, I think we'd better not correlate it like what we do to the
    TCP case because of the lack of sock lock protection. Considering SND_C=
B is
    uapi flag, I think we don't need to forcely add the 'TCP_' prefix in
    case we need to use it someday.

    And one more thing is I'd like to use the v5[1] method in the next roun=
d
    to introduce a new tskey_bpf which is good for UDP type. The new field
    will not conflict with the tskey in shared info which is generated
    by sk->sk_tskey in __ip_append_data(). It hardly works if both features
    (so_timestamping and its bpf extension) exists at the same time. Users
    could get confused because sometimes they fetch the tskey from skb,
    sometimes they don't, especially when we have cmsg feature to turn it o=
n/
    off per sendmsg. A standalone tskey for bpf extension will be needed.
    With this tskey_bpf, we can easily correlate the timestamp in sendmsg
    syscall with other tx points(SND/SW/ACK...).

    [1]: https://lore.kernel.org/all/20250112113748.73504-14-kerneljasonxin=
g@gmail.com/

    If possible, we can leave this question until the UDP support series
    shows up. I will figure out a better solution :)

In conclusion, it probably won't be used by the UDP type. It's uAPI
flag so I consider the compatibility reason.

