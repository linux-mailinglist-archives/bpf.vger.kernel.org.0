Return-Path: <bpf+bounces-71502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAFBF5F04
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7798482FED
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194322F0C7F;
	Tue, 21 Oct 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltTJAwUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F22E6CBE
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044565; cv=none; b=UTPhwTss7Lm5dV7mIN734aoWtaVgztSOmRDQEGcfyvCXMTP9fDpwUPFswIMYRTr2fnHTamvmpQhZv5o+aWDTb07bOm5ArXsdYeztZNEowkAedrBIs4AcxnQa+ahEsHKoLoe1/bi1ISz0/qOhM8H16kckGcq0rQ/WW8wDkfjWm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044565; c=relaxed/simple;
	bh=Cmlt8NumtSJsa31SmZDdXrhoNC6ZwQkLlZeCoQNExr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd38jgqwTkYxTvjiLXfWTsUhoKR5ObufaHxLtfGYl7/Rmhvo9FqNYUOQ1Gm9la6ccSLvL9sIdXkcxz4cv0tVsH5lo3MbHlBlmcwc38hxcS7Q7Gx3uynyZBsz3zmGsMMhmC59MyyWzuFXJMr+kP29Hdmba9b43qfUDyocH+LhDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltTJAwUu; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-430ca4647c7so18945685ab.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761044563; x=1761649363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmlt8NumtSJsa31SmZDdXrhoNC6ZwQkLlZeCoQNExr0=;
        b=ltTJAwUufV/rwJu+SJ23F3MkB7y5hfoy1+Om0/YBaLUhTfIThIOF4d2cK5cSLEMwLI
         Lys3AVNaAufGGNEzUsd2/VuARMnMgk5B1RlqDBbMhJFKO/O601nFISblNssn6p2TsL8u
         Ni3lVsHDrFcVLG5fkhpTxiycuqGytzAiMgNJgTUO9h1Qk7ktJK0pbsX/4Bln04Diwm5P
         u0IkGs8R8B9UFofpCsTV2/zbYbb43cW7IRuVd/FvX82I32jXKa4OW35dcrZ5MPBHkPDq
         QpCxoiB0CvIqtidP6RhT+5TpfP9l2yoXUB5Ddy3j8CoJT3Z4M3j8MN9+UeEt7hdIfedC
         6UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044563; x=1761649363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmlt8NumtSJsa31SmZDdXrhoNC6ZwQkLlZeCoQNExr0=;
        b=ALACetAFSxlG3ucfAF1NAUBYmHTyP4vjZbE03fky29VZqxZch/x3Wi3TjZnVCBkHI2
         pJerY5CzuK2rLYPloFCbeIDRgE69xwuLLrdVunZA1vEWb3Rs3oGTuQyROj7j8IAFip34
         CzbzyO4i6WkOHVUaDid6ydtMxEvtJZ4ph4YRfQbTxHHZpzCneAJeEL0h6FBbZIuL0k8V
         I971lWnYHVcVrrcbP1ApLpsWXK81Kx2ePhE4ymU1CrsFW59R5cMgs9ZO9FHVjGrMfG8p
         0S6VGfi+Q+aqcUf+/Mg0JzHASB84S6xYEaGCAwiTOJGr3SPKqxmUCCBWf+o2Cn0oD77q
         98qw==
X-Forwarded-Encrypted: i=1; AJvYcCXtxE+0pgqIyimJHXWI3FUFx5izjj91mgMFc/YfY+koCVUx5fWxeVe/YFR3y6yBT9PtjjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBDwzBx28Xa/35l/IrXjx86iYxiWG5AOKCUNO/K5INpK9ARYf
	tvY4+eD9XxuX37j3sghbsmIIxspUXkHpb/MVmt4JrhVnwjhE7CMZTeqHpEKBin+iXabXwPGyhHL
	WagV1DJB04bEKph6ezpmGtw5Z2t0YIs4=
X-Gm-Gg: ASbGncvBtGno68ZZOWNrTJC/SCxWl/O3Gn13UcFKNjLW9cFL0Q1Mn8AkKPL7r/tKA+d
	H7y3NKQwHAscsUbAx2/xrKxjoARJ0xQed/HyBVS/AlK5sq8Mr0ciz1d/HbeITLdkE95f6ueE6UR
	8mU0SYyu3NP/vMcL9DOIQ4CyZRUKffgazfsyarMZAMERYa2np07o8U2I6AddNDuccsn00/fIS9f
	PLYZVakbRt+J/c3v6xbZ5MwgBqFKipk2VERQOJMx+bGt6Ae+ZMB2UN5G1UE
X-Google-Smtp-Source: AGHT+IHDvByBOPVYHIM7/SpMKaHb9J7qIjNeZ2MsVhMaPnXi82oD7w6a2DPK+veb6OO14N7/6t0e3oYgls0HP9mG/KM=
X-Received: by 2002:a05:6e02:1a42:b0:430:b338:e55 with SMTP id
 e9e14a558f8ab-430c53068c3mr258026025ab.29.1761044563024; Tue, 21 Oct 2025
 04:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu> <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu> <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
In-Reply-To: <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Oct 2025 19:02:06 +0800
X-Gm-Features: AS18NWCp3gMZ-vHw7hgTUJk16mOhgcBAjCX7S1cJLh5bN_2YLJL2QzmYE9tiq-s
Message-ID: <CAL+tcoA0TKWQY4oP4jJ5BHmEnA+HzHRrgsnQL9vRpnaqb+_8Ag@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: mc36 <csmate@nop.hu>
Cc: alekcejk@googlemail.com, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	1118437@bugs.debian.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:31=E2=80=AFAM mc36 <csmate@nop.hu> wrote:
>
> hi,
>
> On 10/20/25 11:04, Jason Xing wrote:
> >
> > I followed your steps you attached in your code:
> > ////// gcc xskInt.c -lxdp
> > ////// sudo ip link add veth1 type veth
> > ////// sudo ip link set veth0 up
> > ////// sudo ip link set veth1 up
>
> ip link set dev veth1 address 3a:10:5c:53:b3:5c

Great, it indeed helps me reproduce the issue, so I managed to see the
exact same stack. Let me dig into it more deeply.

Thanks,
Jason

