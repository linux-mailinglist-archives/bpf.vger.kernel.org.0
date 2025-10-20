Return-Path: <bpf+bounces-71373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B95BF014C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAEEB4F08E5
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431762ED14C;
	Mon, 20 Oct 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGXCH/MV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1072E8B75
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951094; cv=none; b=Hzad/ULk36pXbR0141u0Lmlsob59y7BBofQXJbhLero4cer92Pp/bQQS1qw5PlpNE/Ok2O5a/pHi8qXWBS6xa/woCoDhT/zErmOrOnu0Gr8odfOZQM0gAiso262j/iwW7Sl7huZN3HHJsAjkUETw5l9JOw/YVKtits/4iEUQcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951094; c=relaxed/simple;
	bh=rNa7mky+fCbxF54R6TCait+kuOtgvYJLoIoIYKwBB4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcOgXwHBfZKvlTJqBJkQRv20UhrDV9qjZy+cNujKrnCZwlXMg9UxOKES20RmI94sCYYtPsn7s3qGgtmmbyXLvATwh1jnMDwSymuyS2o+DkNfHsdW+ITNxLwnsLSeJDOXjIdMKrgAagunkWl1vNXjbYHv0dqYFiplvKSzvJ6oFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGXCH/MV; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430e6ac6bccso881795ab.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760951092; x=1761555892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNa7mky+fCbxF54R6TCait+kuOtgvYJLoIoIYKwBB4M=;
        b=gGXCH/MVJX+klLHX7w2AOlOFKi+QT0op/HDVYGaCwoRJHuRBwWon4OahSGZbDDNa6H
         YCyQxQUPgFzX5ADFjsu9FxXcTNB7B/Wh3wCh6ab54CZVikB/162zSUtlYRpycaphTfnR
         kEBrrIK6oMRhmf9M1h7/8mAFOuCdMGvsNhOuo3uIl9hK9ftno2JxTOjfhxDXExGGx8To
         4NYxHVZTbvO8BSmtWdGJtS/zn0y0Az99HP7AB6hHC643XXMN3L3OrDWEdZTzGYwUJ5Qj
         mDbXrvGhCjgRUhNX7bf/sM3ef6zjOTXt5a8i0oyxPVRDVzum/uNJ8c/+LLgldssl1C0X
         HmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951092; x=1761555892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNa7mky+fCbxF54R6TCait+kuOtgvYJLoIoIYKwBB4M=;
        b=DZTm/uGnx0E/hSHSasJTiYYBHKuCFEtUhJFAFyX0t/5fJEdk540KuJ7+nvkriRN6aF
         rmvqYe4JtxcTIvDkXxGeSHaWo4FEz0nSCzW1qKKQ2IYMwTxbeJTpHO1j9Ws4JeMePhQu
         iTEsUk6xjqMSkQulce+luAjeOGmJxIeNoCE088llfJ3/Lvsfb/b8/J1BCzDOqiT2HolY
         Dn70aDrkDi96kpSAXZIPSoD0UvLEhruWaOAt7MGn8wqsyMU3t7akpo1GZbgns43lhPBt
         oCTuQrrT2hkpdHgIemR6IqLPou0oAEYVfjuqU4ovT8rjI1625zSofmLf0gCQxLnN/uL7
         ZbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwMPYmLfJZtx75XPrxTCx/ow0hJa1lQTpWIqPz9b4cgoL8Lp4aELxwXe3sC3BRXRFhsoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtP/AwBG017/kTG3zzIdNUajwht5jcWg2cMjDTlhElxcGrWSXM
	1vHY4QrI68VkxchgDtHs5dTmO1Fvh18GMDS1h4tty5CsKpNFFnhKTInLs1xosLbyn8rbJn/oWNO
	KKuPrQXrS5VROs7owF2FWQvvP+06NnBU=
X-Gm-Gg: ASbGncu93O7B5Z15zcrZK+qPoTXkZytfLxWEclEixuvoKYUHMS2QK6MGkXcDYlVO4fU
	Jw5JQ00zi6iya+ouCtxr74TArwQnAeLtwZKLkGotanw8v5YA/SvOEDYAD0QdA9kdC03RT/PuXvx
	A0QTS2R+WfFOUxQKvAJoHTcA3sVlO7IqC6yMHy3CemB/1XMCVdTDG7WY2LH3U4M9rrOEHZ4zQsv
	1934whMMifmXKKPyRWf1Hd9H2zZbuXQcsUxDpzfdHfzejbUU1+xToIp9ZeZ6om2kH0W0A==
X-Google-Smtp-Source: AGHT+IHbFxABKJdkDFpndZrcm7O7RnmRKOWKdGfXP7hCauaGvoUYhf0iRfQUQ1Hid0h6Ka1JTIJ3bvujdm4aDeqRvNE=
X-Received: by 2002:a05:6e02:2301:b0:424:805a:be98 with SMTP id
 e9e14a558f8ab-430c52e5b7amr147501405ab.9.1760951092478; Mon, 20 Oct 2025
 02:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu> <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
In-Reply-To: <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Oct 2025 17:04:15 +0800
X-Gm-Features: AS18NWBmrX7pR-mzd1Ln7XLxaYpf0oT45HFNjpnxO9GjY_1QR-DL_G4ECdDzS2M
Message-ID: <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: mc36 <csmate@nop.hu>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 1118437@bugs.debian.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:55=E2=80=AFPM mc36 <csmate@nop.hu> wrote:
>
> hi,
>
> On 10/20/25 08:41, Jason Xing wrote:
> > Hi,
> >
> >> this happens 10/10 on host or in qemu-system-x86_64-kvm running 6.16.1=
2 or 6.17.2...
> >
> > Thanks for the report.
> >
> > I'm wondering if you have time to bisect which recent commit has
> > brought this problem. It looks like it never happens before 6.16?
> >
>
> and now confirming that 6.16.7 survives the reproducer code and 6.16.8 cr=
ashes...
>
> below is the decoded and raw 6.17 trace... regarding the exact commit has=
h, i
>
> would leave the chance for someone with much more resources than i have a=
t hand....

Thanks for working on this.

Strange thing is that I didn't manage to see the crash on 6.16.0-rc6,
6.17.0-rc3 or 6.18.0-rc1 that is the latest. I feel that your
environment is hugely different from mine.

I followed your steps you attached in your code:
////// gcc xskInt.c -lxdp
////// sudo ip link add veth1 type veth
////// sudo ip link set veth0 up
////// sudo ip link set veth1 up
////// sudo ./a.out

The version of libxdp that I use is 1.4.2, BTW.

Could you share me with your .config? I'm not sure if I missed something.

Thanks,
Jason

