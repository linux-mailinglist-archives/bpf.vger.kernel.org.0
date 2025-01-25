Return-Path: <bpf+bounces-49743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD6A1C052
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0861883214
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280921F3D45;
	Sat, 25 Jan 2025 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNl7rHW2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448571F2C35;
	Sat, 25 Jan 2025 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768988; cv=none; b=GnKlQtaVCD0M45xzEkwEFrobXnhWvaiGBHHFqBg8OoYGGUKTJ0LqOsBT7nwPMLvGHlVqOqSCLJpIsNCO5FoMpg3FGotVb0F9b5z6sGiONM3qQXOrIvIRBPVCYQ3cpfh7J+NlAFfw+Nf/fcFSbRTEP8sMgDYnzTlWIq7HOGjplB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768988; c=relaxed/simple;
	bh=LlXW+3i46sk7hmRqmbpX8fq1YMbBPbwnBQPHqvkl2/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDjwAfPxX2OQVLQyogASMZOdhl6jVKoh04HV+U15RfXgmzf8r0FL9jsgsjeALeYQkr8uZZV/cYOUcLBT/p4XUr2HIQ7vUlc3oTUNgtaAN/+cildf8aaT+KdumbFBXNDRC9w4FSt9AbMNTMNxD3a9GFhc0CFfwn+syWDar6Kqi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNl7rHW2; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8521df70be6so125064339f.1;
        Fri, 24 Jan 2025 17:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737768986; x=1738373786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5Q+YlzN963ayxhnyM9IkYILIEOhwcea4ckyMgDoNhY=;
        b=LNl7rHW2po0if+Fs0THHT1Qi35BSF2+tefBOFX0NFZV050+IzRU6ksZlX569Akdp3A
         vf9cnJ0UQVSC6d0LIV+VH8KWWQiZOpcrJ0yhjqJHe7DS5T/uJwCqSAnaH9ikpLh7rJDJ
         JRAMLStgZcMbIRfDLZtW2fDgx95qbSVjjgIGPkZEl+iM/B9oR+hn5PsqRY+a6BX7rw7X
         zGkLFXROwP5jAKe0IGH/n9KcXs2ivlvtXpDxQR1QbZ8E0pwTTBbpL3CN/EOMvtsq8+Du
         xgwosvQ71RAFSiHdUCfs1VNEjYHhTkiqBBWLl171r0IZ4FpVPQ50MqKaSlNqmcuhSvuK
         Wbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768986; x=1738373786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5Q+YlzN963ayxhnyM9IkYILIEOhwcea4ckyMgDoNhY=;
        b=ZaXl8pTYNP65twx3m/Uu2l65G6Oy0hGNYxelM5koHWzhn1YljeI+J8h71ulDCx2X/L
         yN5miWKRtOlPgvWtDmzzvFV2XT+G9dC7E8SBEtQ1Jh5DD/kfOzgUgY8out1NSSEcSx8W
         8xwHCTVD/ROJDcV/A84+5za4cRNtPOnjxkzlAc5Wb5e78foXvInkmVUh0WoV4mpdynxw
         ZKr1QTk20w/Ekll738Qo7/j/+fpSlFrkjFAFQbCk6tERaxc9P9FoNHAxj9uZOyIbBRwE
         1m7ia91cvSWdXXZUiTXdQSkBQfSNO7sLkKLqFxCFalY+uB0P8CyNlScTsKe0HKiwP8kj
         8U0w==
X-Forwarded-Encrypted: i=1; AJvYcCU725w01KlI+K/qdGAWbS0gLx1Uwx9uA4XvsjB4bC9JbAcBAiNx1ztp5jCoefeWDHB70Ek=@vger.kernel.org, AJvYcCW/8+rZe8/oH7eYZ5QvNzLiFG2pekb0e1YZGuhyq3MyafyyWpcTaqvc5qF8VZcb+6YMPbZfA4qk@vger.kernel.org
X-Gm-Message-State: AOJu0YxoY9i6AAu9ab4mQ/MFlbIiP8Ell4kP3tdJTaAxzhwFkF3RKxKy
	Ug+ug/knnhrXePpKQdeZHaHXDjdklo/won5F30EETNn3tdyUL9bv4nWD8eGCiRLCL4O3zV/FBRR
	5UHyKqkEHMnGfPFnTQmfhz8rNJlg=
X-Gm-Gg: ASbGnct21sAjkYU8bGK2BFGUZyANDXSdSqCbCSECG05OPB2dCGnxvGrMwb/0Lq001ux
	J2dQ92Ov78WGWZW13YflKIQMrTSEBOzMuLxxPdyAhfWeZAm/pkoW6TTRHHqPXYw==
X-Google-Smtp-Source: AGHT+IHbF3BGJC0JUJQK5Hp+ZndTeKesim/ojM0+K8C2OBJDVwUrtR9kC5XEyOB4szwODe+8khPO9K+ay4OCh2ALLmE=
X-Received: by 2002:a05:6e02:743:b0:3cf:cb65:8c74 with SMTP id
 e9e14a558f8ab-3cfcb658d19mr45667355ab.7.1737768986220; Fri, 24 Jan 2025
 17:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-9-kerneljasonxing@gmail.com> <40e2a7d8-dcba-4dfe-8c4d-14d8cf4954cf@linux.dev>
 <CAL+tcoCzH2t0Zcn++j_w7s2C1AncczR1oe9RwqzTqBMd4zMNmg@mail.gmail.com> <3a91d654-0e61-4da0-9d09-66a82a24012a@linux.dev>
In-Reply-To: <3a91d654-0e61-4da0-9d09-66a82a24012a@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:35:50 +0800
X-Gm-Features: AWEUYZnvyVnV-lfMlI4hB7T56ypxNuGvhbYES1XBHzjPQHRE_wKwmbJ9u0ApDQo
Message-ID: <CAL+tcoBVtqNA_7dN3vpG9VqagjM=VaRKKxDBUiUK-DHPA5Mg=A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 08/13] net-timestamp: support hw
 SCM_TSTAMP_SND for bpf extension
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

On Sat, Jan 25, 2025 at 9:30=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/24/25 5:18 PM, Jason Xing wrote:
> >>> @@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *s=
kb, struct sock *sk,
> >>>                op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >>>                break;
> >>>        case SCM_TSTAMP_SND:
> >>> +             op =3D sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS=
_HW_OPT_CB;
> >>>                if (!sw)
> >>> -                     return;
> >>> -             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> >>> +                     *skb_hwtstamps(skb) =3D *hwtstamps;
> >> hwtstamps may still be NULL, no?
> > Right, it can be zero if something wrong happens.
>
> Then it needs a NULL check, no?

My original intention is passing whatever to the userspace, so the bpf
program will be aware of what is happening in the kernel. Passing NULL
to hwstamps is right which will not cause any problem, I think.

Do you mean the default value of hwstamps itself is NULL so in this
case we don't need to re-init it to NULL again?

Like this:
If (*hwtstamps)
     *skb_hwtstamps(skb) =3D *hwtstamps;

But it looks no different actually.

Thanks,
Jason

