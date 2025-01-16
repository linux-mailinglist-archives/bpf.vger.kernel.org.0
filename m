Return-Path: <bpf+bounces-49016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA464A130B6
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 02:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC7D16126D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67762AE99;
	Thu, 16 Jan 2025 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6o5kyq1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BD6136;
	Thu, 16 Jan 2025 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990592; cv=none; b=NcGUtCPdeZ6B70hRf37gLNGtptLxcIDNMY9mjHYnNXSScb5b/j5iPvo5iOWT4CuqjSd8ntE1twBnHravWD5G2XGa2QeTLqJsakpMwpP0PvrqlRUJGPsjg3/JcQ2DDLksMAC7Df1a9p5cMjE/nsiCy9RZHVs6GrREwq9eY9a5mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990592; c=relaxed/simple;
	bh=RBcaA5Qs3Sl79hmCs+h8iDGCvOrlk79gpNojaTiLrrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzfflFc1eVhz1O/fRxAItwyAVdOXmSz78WTlGlUbB0K+tVs73ZazskeAqbA180gJNFhSb8JSNamF0jPJxrbK/JNrwtSrM7kFSvmejifIWirXH3hdfTLsLPci/hSL6ItvcqF4BUfx93fxy152BkE0QwfbCiHGD7G6PTleWAErdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6o5kyq1; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce7a77e5a1so1396905ab.0;
        Wed, 15 Jan 2025 17:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736990590; x=1737595390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvYa6gBShMYLfc1ehjv5ezyY0fRHP8xKJ616OqcJkdg=;
        b=i6o5kyq1oCDKdgxvDzTY9J/yxq4OfvXNIIuMw9iA4jBjXsxTvhBqVL0TwWJj0PiMnK
         T5aHTWhshj9eP3hJy91px575XxvACtkL7X0NzZ5b0B2k8i5P0RfdrEeTCm/y0S+QYETR
         YKcu9dkKPwCt4gWeUzLxRoljnb+lv6pZ3uGDOfkGiDdxbR2BShrKa3kvN9lGUUoaiju7
         UajOa7nsAXY+CIaEPzP0V1NrDSmej1+WHkYlWIbK822eHZIJ8yewD+s+rvaPwRARAAan
         Sn3RZjAm+N/pErJq5q6hwcuzwxoLe7MWKtRkWmUnEGYFhyXtZco5APPYGGSuMgjZOjm2
         yCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736990590; x=1737595390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvYa6gBShMYLfc1ehjv5ezyY0fRHP8xKJ616OqcJkdg=;
        b=FXJr6JLanXiJvfl0+8rdX1bKxPSycEHFN1bMh4NfD9W0yH2BDm8uH6BSzEaab8knqZ
         QrQ0sPoYhVP+I9DeCazOf8tg4wUiCY8TXQfXmek5iqACILHN75iAAJfeUrFbbs2U/kz6
         srRkb5LE7H/yLb4VF4q2pItTYpIkulvUbG82NgWVYOxnELssbsIFtKgKEO9GrwOvtnsH
         sBro/wxsH0o2lTx304znKPVl+W6VV+MRO/tt0l6ZTnfRXVTWEMhv0n6mrxARyqjj6m0T
         K1AYIk7ORpvtX8DcdaehcpbwirE/EoAZydpXfXUQePHrAYeN++HCPS0IJngJlNNRM02R
         DXcg==
X-Forwarded-Encrypted: i=1; AJvYcCVfdBTRaGdJ7wwfQI9hkiTOGT6lus96l+8p/24aU2kjnYlTPKVnoMMCbjz24mXRzbpGVMn1NA7g@vger.kernel.org, AJvYcCXyHez+RJJOgLMKus6dIwx0YTLL0XFm4H1s0CFh5tJlSssMo3uT69Satz9XsRKsC6MdxeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhnqCOWHXSKAs893JiS4LrqYkA21F9GsjZjmu+DrgqfEQV9pU
	VTYJVsidXuoZn2DZRt6nDjnVF/gFG69OgR+kSx0mzk8MjsmlMebqtfRDl6qaeARNcZVj6ry6ZEb
	9ywLqZY76CD6g7sdFEWJPo5IW+e0=
X-Gm-Gg: ASbGncsWvwEgq+koJ/k4Y+V6MLR5iM78X4vq0hBPUSkoo3WJ0oImq/8s3TrmU31F85B
	DAKK2q9IrOWvmdFH6NkviwYNCr1/4+R7JMGj/
X-Google-Smtp-Source: AGHT+IGSFwXspnnJ+/rQwX1+9nIbZKKjx0HH32EmB1nGas3RFsKQVO1fZDkbvMkquAb8ofmuGkP9nZ6l27awyd8v0Fg=
X-Received: by 2002:a05:6e02:1808:b0:3ce:665b:cdf7 with SMTP id
 e9e14a558f8ab-3ce665bd10amr128208305ab.14.1736990589714; Wed, 15 Jan 2025
 17:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-14-kerneljasonxing@gmail.com> <5d9ba064-3288-4926-b9dc-3119bb3404c1@linux.dev>
 <CAL+tcoCe-Ee92r5B7LwV8GCxEBWDzq3X_g_oOWWzo7-u4wYZzw@mail.gmail.com> <d9601490-26f6-4aaf-80f0-0c92464e0c42@linux.dev>
In-Reply-To: <d9601490-26f6-4aaf-80f0-0c92464e0c42@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 09:22:33 +0800
X-Gm-Features: AbW1kvb2vs2P9WxqvK19o8s7BIB_j8jMMqUgpVTx_3AZLlwDETgHXyeMeAu3NoM
Message-ID: <CAL+tcoBu=5Ub_5E3HNK6uub4MiHEOpRCgtWMRQX3heKObM9rHA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 13/15] net-timestamp: support tcp_sendmsg for
 bpf extension
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

On Thu, Jan 16, 2025 at 9:18=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/15/25 4:41 PM, Jason Xing wrote:
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index a0aff1b4eb61..87420c0f2235 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -7037,6 +7037,9 @@ enum {
> >>>                                         * feature is on. It indicates=
 the
> >>>                                         * recorded timestamp.
> >>>                                         */
> >>> +     BPF_SOCK_OPS_TS_TCP_SND_CB,     /* Called when every tcp_sendms=
g
> >>> +                                      * syscall is triggered
> >>> +                                      */
> >>
> >> UDP will need this also?
> >
> > Yep.
>
> Then the TCP naming will need to be adjusted.

Right, right!

>
> While on UDP, how the UDP bpf callback will look like during sendmsg?
>
> >>> @@ -1067,10 +1068,15 @@ int tcp_sendmsg_locked(struct sock *sk, struc=
t msghdr *msg, size_t size)
> >>>        int flags, err, copied =3D 0;
> >>>        int mss_now =3D 0, size_goal, copied_syn =3D 0;
> >>>        int process_backlog =3D 0;
> >>> +     u32 first_write_seq =3D 0;
> >>>        int zc =3D 0;
> >>>        long timeo;
> >>>
> >>>        flags =3D msg->msg_flags;
> >>> +     if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
> >>> +             first_write_seq =3D tp->write_seq;
> >>> +             bpf_skops_tx_timestamping(sk, NULL, BPF_SOCK_OPS_TS_TCP=
_SND_CB);
> >>
> >> My preference is to skip this bpf callout for now and depends on a bpf=
 trace
> >> program if it is really needed.
> >
> > I have no idea if the bpf program wants to record the timestamp here
> > without the above three lines? Please enlighten me more. Thanks in
> > advance.
> >
> > I guess there is one way which I don't know yet to monitor at the
> > beginning of tcp_sendmsg_locked().
>
> The tracing bpf program (fentry in particular here). Give the one-liner b=
pftrace
> script a try.
>
> Take a look at trace_tcp_connect in test_sk_storage_tracing.c. It uses fe=
ntry
> and also bpf_sk_storage_get.

Thanks for the reference!

>
> If tcp_sendmsg_locked is inline-d, it can go up to the tcp_sendmsg(). It =
would
> be nice to have a stable bpf callback if it is really useful but I suspec=
t this
> can be revisited later with the UDP support.

Got it!

>
> [ I will followup other replies later. ]
>

Thank you!

