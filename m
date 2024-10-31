Return-Path: <bpf+bounces-43631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6F9B7460
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 07:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E0228339F
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 06:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E31422C7;
	Thu, 31 Oct 2024 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvbUe8Gu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966BC13D245;
	Thu, 31 Oct 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730355437; cv=none; b=bTOv1SQR1A2kX4400B9iD2R6HKY12FJJcsEgR3QBc7XOrde8Mq2eu4TgcTwyHVcMnDrSSDttXp4a6VXr3lfm+sXBxEwn1o1Q+NZX83mZERzSQsf0p1y8vAMPv0JFVgjQH5P5ip8SwlphmLJ78nIUSuGfuwHi16UrDo9jdFNMC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730355437; c=relaxed/simple;
	bh=8HsG/AVOvVWvjm5f5/DShlPUjg6c3lTyZvLttwf7Noc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldCFDwYh0GlblZT5HQePYIRU5dOxcxv+UDZmzGk7/CWrib/7kndttEwUagrP76T6sR8qkOG5yssuP7Ve/OoSzZYVxli4Y/8kdCECanASbXmTpFL4Jrm7YshOQb++ohJc89wMyIje2FrfYWBIXUCkANaUkAqo9JGk0M/Id7Z7BQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvbUe8Gu; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4e551efdbso2286755ab.3;
        Wed, 30 Oct 2024 23:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730355435; x=1730960235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HsG/AVOvVWvjm5f5/DShlPUjg6c3lTyZvLttwf7Noc=;
        b=bvbUe8GuFC7Neyghs7nv7SRQt9q/7HiFXK4dh99YeKY/8vgzRNgys4ohkCBXUZ0BSI
         ko8i1MTnJ4oJ4S6IjYBkvlefgabapB0bTiEQc36SfJQTCyI3uzM63bg/SVK+v/fB3au3
         3LMahh2xgNZiz3m7AfD5wjlTgusVyVDz+RO+TYoPMsktgqtpWlX9OAYc9J2wU48ZLKAK
         SymiKngMvwj8mTQDIqMr3Q/Ys/1aAYNAmDVP3cCavTOvLBDnsnQvwhZLL1bUS4/wDh8T
         ZjP+BahC0vqSpfkqj0Y1lNgM0dLimPvkkxszp2itIfst7KjCSvoToq+3+b42v2BZIaEx
         gKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730355435; x=1730960235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HsG/AVOvVWvjm5f5/DShlPUjg6c3lTyZvLttwf7Noc=;
        b=fkR0VgMyEw1Q3OyHJuJIb1V0CaFB38mw2mCuRkCdeQMSreJ9f4yGx0Aiyds5V4sozn
         hTqou/HWpaLb84mfJQhg7hMZ8rFbNJEe9Ze54bMEAcL8a6z/Dt2HwtivxIS4B9SjSSdU
         sOzOP02e9vqtGFYz9lN+7URaOC/vsEq75u2Vis0m2Ic3UTVqqeFFzaoNfqnx2aVjkCf8
         vGYvfDW97bv3XaEN0tJQBEaLRzafdNa5x8gb5wt9J7I7W4BbOFloSFgC60q7VbRU+nt5
         J0Eygzy67uVHV6uBy/Gpy/V706jK052yTXHeeWz/JZvCaBKgXIIhWMp9RMjfDQLo0YrG
         JFFA==
X-Forwarded-Encrypted: i=1; AJvYcCVJEK23DQ9mqF9VECndoIBuFu7A8l4gK6JH3elGsNVMcvzU4WP2F2tAXwKI1G56PJaqRq95i1Hb@vger.kernel.org, AJvYcCW7iqa9GKaRfbDN0/c17RUo6TKdQ2aHJ+ZXHZYnKrT0DVGdtdAzKnuieIwdUJoZf2OuiAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46qUxjyjJk94mxz/9Y4qMeWDD1mHXptBTRkC485x6/UL4XeVm
	YitmuySkwN4pRb9CrmTI1N+C+Wleg3Nmmm2uPFZVNRvLX1ffYDL1mNjWBT/RRd1TawUZhZhYDPW
	/Vf/rXN3f1drf9znmntJQbsPt4jh7Dg==
X-Google-Smtp-Source: AGHT+IGbNpic/BdiijIe65L4RRBuLypikRdPmVkHo5k6kGdLInfvx8OL+9ElCBwaL1ptJeg81MY1qIiw9aC9XybLIT0=
X-Received: by 2002:a05:6e02:1529:b0:3a4:eaae:f9f0 with SMTP id
 e9e14a558f8ab-3a609a2adc5mr28156315ab.2.1730355434781; Wed, 30 Oct 2024
 23:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
 <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
 <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev> <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
 <0b4392ce-b10d-4103-b592-2ab7a624cae7@linux.dev>
In-Reply-To: <0b4392ce-b10d-4103-b592-2ab7a624cae7@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 31 Oct 2024 14:16:38 +0800
Message-ID: <CAL+tcoBHNbHu0i+oLA5inZg=sYXUb4+va0qd-c1TZCQFunk7Dg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:52=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/30/24 7:41 PM, Jason Xing wrote:
>
> >> All that said, while looking at tcp_tx_timestamp() again, there is alw=
ays
> >> "shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;". shinfo->tske=
y can be
> >> used directly as-is by the bpf prog. I think now I am missing why the =
bpf prog
> >> needs the sk_tskey in the sk?
> >
> > As you said, tcp seqno could be treated as the key, but it leaks the
> > information in TCP layer to users. Please see the commit:
>
> I don't think it is a concern for bpf prog running in the kernel. The soc=
kops
> bpf prog can already read the sk, the skb (which has seqno), and many oth=
ers.
>
> The bpf prog is not a print-only logic. Only using bpf prog to do raw dat=
a
> dumping is not fully utilizing its capability, e.g. data aggregation. The=
 bpf
> prog should aggregate the data first which is to calculate the delay here=
.

Agree, I forgot BPF is only for admin, so it's a feasible solution. It
saves a lot of energy :)

It looks like the thing is getting simpler and simpler, which could be
mostly taken over by bpf itself at last. Good news!

Thanks,
Jason

