Return-Path: <bpf+bounces-69665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13511B9DECB
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50603839E8
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B222638BC;
	Thu, 25 Sep 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvi4XKDY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415B21ADA7
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786849; cv=none; b=r0vthqP6q1OxykEjmdS7ct8Q6/+H8/ekN88yPN4bs+RS9T/OxRjrJbH8VvUVuumgh6JFrb/G2RslZEntCxz4nw4FkdGUULkXtqOJQ+Yq62MfQIdoGAQrieV/1iITHYrP+FTEIxIKuJwrf7srMk3C/GyFnRb/sFnql5/kzPxwa/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786849; c=relaxed/simple;
	bh=sXuIRkcSDSwCLbzqCXPg43cRNCGp6GBaCd28CalI5TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a88jTPOw1PjPoIjacwUOECkqge5FUGviEzgtXRE7PeMyDkBPxEeYErhuZFe8GCPBP69+Vr32owxrFIe5hpYTnK/iFiHMm/zqlFg6ihva0jM9TzJApL1vU3maLXmJMfJ6REhK+WbRPVhDbHudgErbCjLQKFDHO1oLK72GYfeluM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvi4XKDY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57abcb8a41eso13946e87.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758786846; x=1759391646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7H/7dcF0DnQCzlj6kekKQKqU8yy+jLuwRDWAmlb5u4=;
        b=rvi4XKDYMii9sh9Tck+pN0/aZPhYWq5fV94XWht/GgNui81tQBAvyx9qcw0AZCZqh9
         wSQLt+21AH3sIRPr5pEk3m6DqxsZ3dtMSKRHxSoCZ/LCmjHNF5FD0T4eVu6xBcU3hAon
         oybp5EFAkebGsppPiw9aBtVOL5RlrR6Vlq21ljFeO+vluwyYBLkdLhexjq5C8zjvF6fO
         8HsqsBK/+dTjUypjjWvMPOshM3qN2XpBjcH5J2KKJ+Qao0VTNMyWRMdQ1NlCrAMeFD0V
         wRzwEcssrfbHokwrC/clD+863pAm2ia0vcf5u6R3tjBGv+u1Ju0ljH86A7Xqbcnby8In
         ySpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786846; x=1759391646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7H/7dcF0DnQCzlj6kekKQKqU8yy+jLuwRDWAmlb5u4=;
        b=uppnPmOhh9/3Lzaoh/xgpGhoITKjCgHZolqLcP0Wnh6IP3NpS98vJH+/JoI9aOL7jt
         HzuNPWgw01FqW0+WewTvY6HLIdprZYOMm7uQcFFWJKJFd9/VtOiope4t9pbLAd1AQnsn
         xnS8fCxeD7OXqMYr1McOLdjRLVPdvUuOY/HPFsak7cGsaQ8qIoxG4EPkorhjfALO/kfB
         Os/DMzDdV5/UMd+SktYCpOZCMimQODxrghoizeEqu+nRMI2/Dc/9VoGOt5VYjs8CjeQn
         eGjSPaoHz9g8nlOMZ2VYgFvtrDBUk/RPIbyrpWvVgzDiOFQkcDZzVjI3unvsEV36Lf/+
         +img==
X-Forwarded-Encrypted: i=1; AJvYcCX6sqYczMdgmlb9t8U+T7aUCSYytcbfUaQdQXMv9oFRfft1J/s/jnuRKihzK7cT5XXKXQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4QxhgX4iWQRLuGOCp3VFKUdIbgroVnX20E62CeUJQ6ALiQtF
	tMvOMYnseUPLE/Mr+5YZyD0EMpGQSdqiGgB4iaOccwNpp9sQ/O42zZ4rNbPrxpFcM5d00Qb6iqg
	Io4Qg5rGPKauOd/V0Hb7zP0Qti5z7kCGbidgj9fTa
X-Gm-Gg: ASbGncv2TmtQ+aeX5mjkddcgKTDUjmXD/ZTp3cjrINEvENtSL+GDYKsLfxkRnWhNoyA
	ukAgluVcc9cc/ey9MCgBbxMK7u5s3bo8RXthCsXV/ddm+3/QfrBXwjXnNWanOcZshOzgxe6rGmz
	+WIfegV7OAzYunbnJgC/vgoMS/DaKbdCSyUVi3NXW2tpoI0/5crdBlNc46et1O0H1qLwujezZvg
	AEwIrDIvv9ICFMRuevMiu6+
X-Google-Smtp-Source: AGHT+IHYxQQEMpheS5fEalhtIA/pXf2Md494D4DDnhf5j1AhD8VDSh22QtqaZpxTT9fx/YzMYoa7fKWF0ANV5bv0djM=
X-Received: by 2002:a05:6512:2288:b0:55b:528c:6616 with SMTP id
 2adb3069b0e04-582b1b17861mr280355e87.6.1758786845720; Thu, 25 Sep 2025
 00:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924060843.2280499-1-tavip@google.com> <20250924170914.20aac680@kernel.org>
In-Reply-To: <20250924170914.20aac680@kernel.org>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 25 Sep 2025 00:53:53 -0700
X-Gm-Features: AS18NWBEX4g5KLKkNf-lBld4t5AZRDgZiFWedmr4AlhJPhNdQgc3_QoeOfHdbBE
Message-ID: <CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, toke@redhat.com, lorenzo@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 24 Sep 2025 06:08:42 +0000 Octavian Purdila wrote:
> > When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
> > bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
> > crash occurs due to detecting a bad page state (page_pool leak).
> >
> > This is because xdp_buff does not record the type of memory and
> > instead relies on the netdev receive queue xdp info. Since the TUN/TAP
> > driver is using a MEM_TYPE_PAGE_SHARED memory model buffer, shrinking
> > will eventually call page_frag_free. But with current multi-buff
> > support for BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the
> > page pool.
> >
> > To fix this issue check that the receive queue memory mode is of
> > MEM_TYPE_PAGE_POOL before using multi-buffs.
>
> This can also happen on veth, right? And veth re-stamps the Rx queues.

I am not sure if re-stamps will have ill effects.

The allocation and deallocation for this issue happens while
processing the same packet (receive skb -> skb_pp_cow_data ->
page_pool alloc ... __bpf_prog_run ->  bpf_xdp_adjust_tail).

IIUC, if the veth re-stamps the RX queue to MEM_TYPE_PAGE_POOL
skb_pp_cow_data will proceed to allocate from page_pool and
bpf_xdp_adjust_tail will correctly free from page_pool.

