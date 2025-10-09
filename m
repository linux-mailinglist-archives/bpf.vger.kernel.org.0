Return-Path: <bpf+bounces-70645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13CBC79C2
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 09:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CA0B4F3695
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302E2C0268;
	Thu,  9 Oct 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnvQmqxZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4721A23A4
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993678; cv=none; b=p9/th68dpUAqG9U8WZ9ZftbnzXill55VTafBOmK8aLzmeE/cqqMgNMWu7FtofS8nsYdXOZXv9hetSDINtpOwZWvMC1Jp9j6nTvFXyCgNK1z/yCPwA8q79d0tmPSXYWSAd9RuE0fmjCpCynoVFbjSemZx4sN3GPl1Fq6h2br1qeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993678; c=relaxed/simple;
	bh=lbbVyk5jCBer66b9CPFbrfSyMRiBlKAI8daIXk3lt70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHIsqbun2RJcUWxoFMrUuXFeX37F6xQXsaXwgK1rsv/gbmJ5HS0BbhgZmR9/EnZynO91ngPUQkPj83aQwJv0QeHkTFaxexdc2+loQQolzLwVJL3GZjVcWrIbKrn1SCWwfq6pfqwavj6hHJ0T3fNSStNuEcKFH63NFJX8M1gZjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnvQmqxZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4df60ea79d1so5696421cf.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759993676; x=1760598476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M52dh1h+FfVjykyrFeFn3fcuq9jJ8NMh6+SJVp+QDw=;
        b=TnvQmqxZFG/sxOwPBPwnYGgMkEc4zqUpG4EHS4nuKORDYTrncQOkNboEATQGD+jc8k
         Fx9Dgl5Xlv8+PULY5zYHD/7tehLiEpgt+dupflPvF2x69WkLuDREPnjj4m8iJK9cxSss
         0yBCfCBmnxR1Qi/RKE547TJnRZcrRUll3hwlTBnfTGm8lb/qaJM76Wv/SSjeUeavR5Ts
         9TUL++xlKd+7mS732GqXIDn3pEY7Tmximo7hstttDYJs1naJiGgmWmCJo+edOLiYM3aZ
         TAkTm2d3OYXFOxoHexAf62Qpvutax+IxHbsKTJaSN2YACZd7u++x0sjlgcNjXBU9V7cx
         dLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759993676; x=1760598476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M52dh1h+FfVjykyrFeFn3fcuq9jJ8NMh6+SJVp+QDw=;
        b=Xlo2gj8a+pK6Aox6993hrwb+kwZOdr23pRkkVYJy4Jp4MWGoDgq2eHK6/Q0fPGKbG/
         PU7dPpYGkgshNujCqQkwd89BPHxG8RgUPpG+TsNmSLIa//ehpY3jo9qJj3FeVzijuB+D
         jss387mdkfiCbeKSoJrkm1JgRL0dZ65Jl81tHTWiopRgc5q/iwwMTOSU+EwlgIRRZ6ns
         EPP2VEncOwWTOO1hDUWw9dkbyCI6Tt2inljKI8p/+7VzS6ZZ3jUnlanLdelkePwgytwv
         B8UpR4Mr5PUGfeVr5Bb5gRc7j2xM/o0VtLldeXfcx7Sk555fQdqkhhoUH5+e3XlDU1fX
         cZxg==
X-Forwarded-Encrypted: i=1; AJvYcCW+1aAJe/rdPgHAEjuh7a9in4geChiuFDmHwek/hxKuGrLqjASBLu7HMBc04FXlnkY29kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxE/4zm7C8nW1+obyi4jkJ2XveJqxpPX03D+HgioU5RZtRSNML
	QTVILtLAfEeKiMyM2RlV4vwLqa1TNsx655A9wfgGWqKCEP/l24cL9nKQegvJ4g7V5crRaJXEryS
	sNlp7LYEwWSgkltTtkrWU9j9O9kYmkIQj2XA82Lm0
X-Gm-Gg: ASbGncviPeZqMJCUJjy+FzoIyqvv+iS0885tYcEJX0KhaPfRZADJK0tLvebK53FovU7
	1yRwGVjOWxTwbYGPK3XNFVx/6Xzcus1N2252wBeJGt5gkiZQyMQoGFa43thNGkKvRQy73yL44+e
	3J8nVJQKVmrymFv3P6QMq1OaOMkcdweuwr/j8zeWzBPQyy0afuto+SNeQCl06UlnLIorbtngMin
	ETLv58wCrY8aVMciL/SsjQmf2xxIelYOAICVw==
X-Google-Smtp-Source: AGHT+IGX8qBecZyb+pIbR5G0iTKPZsClm1K9y+5nFkeZs4NBukkbXnHL7r7xRdYK4Yr36ptDZgKGjM2jiXSeZKLPycE=
X-Received: by 2002:ac8:5847:0:b0:4d2:95ab:ecb0 with SMTP id
 d75a77b69052e-4e6ead5afb8mr84565721cf.64.1759993675359; Thu, 09 Oct 2025
 00:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
In-Reply-To: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Oct 2025 00:07:44 -0700
X-Gm-Features: AS18NWASjTPvsTSPBC6XRuDuoZqgCPV0bsX2fSbCWNUjwlh1HcRwARWtjH3Fxjw
Message-ID: <CANn89i+rHTU2eVtkc0H=v+8PczfonOxTqc=fCw+6QRwj_3MURg@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
To: zhengguoyong <zhenggy@chinatelecom.cn>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:07=E2=80=AFPM zhengguoyong <zhenggy@chinatelecom.c=
n> wrote:
>
> When using sockmap to forward TCP traffic to the application
> layer of the peer socket, the peer socket's tcp_bpf_recvmsg_parser
> processing flow will synchronously update the tp->copied_seq field.
> This causes tp->rcv_nxt to become less than tp->copied_seq.
>
> Later, when this socket receives SKB packets from the protocol stack,
> in the call chain tcp_data_ready =E2=86=92 tcp_epollin_ready, the functio=
n
> tcp_epollin_ready will return false, preventing the socket from being
> woken up to receive new packets.
>
> Therefore, it is necessary to synchronously update the tp->rcv_nxt
> information in sk_psock_skb_ingress.
>
> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>

Hi GuoYong Zheng

We request a Fixes: tag for patches claiming to fix a bug.

How would stable teams decide to backport a patch or not, and to which vers=
ions,
without having to fully understand this code ?


> ---
>  net/core/skmsg.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 9becadd..e9d841c 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -576,6 +576,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psoc=
k, struct sk_buff *skb,
>         struct sock *sk =3D psock->sk;
>         struct sk_msg *msg;
>         int err;
> +       u32 seq;
>
>         /* If we are receiving on the same sock skb->sk is already assign=
ed,
>          * skip memory accounting and owner transition seeing it already =
set
> @@ -595,8 +596,15 @@ static int sk_psock_skb_ingress(struct sk_psock *pso=
ck, struct sk_buff *skb,
>          */
>         skb_set_owner_r(skb, sk);
>         err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, true);
> -       if (err < 0)
> +       if (err < 0) {
>                 kfree(msg);
> +       } else {
> +               bh_lock_sock_nested(sk);
> +               seq =3D READ_ONCE(tcp_sk(sk)->rcv_nxt) + len;
> +               WRITE_ONCE(tcp_sk(sk)->rcv_nxt, seq);

This does not look to be the right place.

Re-locking a socket _after_ the fundamental change took place is
fundamentally racy.

Also do we have a guarantee sk is always a TCP socket at this point ?

If yes, why do we have sk_is_tcp() check in sk_psock_init_strp() ?

> +               bh_unlock_sock(sk);
> +       }
> +
>         return err;
>  }
>
> --
> 1.8.3.1

