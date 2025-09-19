Return-Path: <bpf+bounces-68911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED6B88052
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23103A9872
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3925A33A;
	Fri, 19 Sep 2025 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6pYNDbX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEA221294
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264409; cv=none; b=sZzbnq3FP0xI+WhSgWo5BEAadui36Le7LgqyhJJJWd6bqgRPOj9N83WhsfkoFlyiRkVkCUk+edi49E2OGcGICJPcf3cRPic6CPDkAEMltUButw3ZqilIZ82wazj0QIeJXHeKoqyai2CKOMkRM2OMXmkzt4TqfFIHFJqV+Y4oJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264409; c=relaxed/simple;
	bh=tiwJc2DbcE23uybIVlR444JTUoVRrHB+WBciYS4uQJw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7LglAmc2oDdVTv4pMnaO8Ab274HUMan9gLKZ9A8HPoVavN7l7zlUhdG3VzW99/am8uP6kgAttEnXrwkMyjdPimrE5RqOdnjkYFZVt5f8EQG/1/EJaO9Udrzl1CNqOhPaOhxTKZIytF6iPQH4XNFGytGBfT7yEesMAoDPnbZ0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6pYNDbX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456ce0b96so20220735ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758264407; x=1758869207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiwJc2DbcE23uybIVlR444JTUoVRrHB+WBciYS4uQJw=;
        b=P6pYNDbXsUKAiwk+XAGWZUWsmYBZWeheTAJ0dnkELLlwWCdC7WSluyApW7KhBsoz9b
         omoChrK4ChRrWW+gA5a4Vi/G1zZHCpi5WflHo4R+U36+DLk7bj29cf9Z+o3kB28GUXaP
         NToBGpW47xlezhedXr54JsIB25LxmKsCzfqOdo2Q/ZbKh9g6Dg1YAZHvt9z2tAtYSkHL
         9et236dhHEULseGU4DyLSWarWmeUUAG23h5uHA8es94KrisOdDhEHjRrikhYI5Q8Zn5l
         bQKCpTG2nHokoLsAICVxSyi7K7g4GkinQC3TmLntxfjr2gMz4a7E+EG9RGiP1ExvEUvb
         /upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264407; x=1758869207;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiwJc2DbcE23uybIVlR444JTUoVRrHB+WBciYS4uQJw=;
        b=SB+ZPbZii5599cTF4Vp00lquPWP2z69PDNhlCzAEkmvy2iRuccyKH2OIub74KBBtmI
         MKIgzfdrOgmRb98uXYXArBqdVbwXhtsTPxnzZHEPCj7eO1rIE6/17012K2mPCpXWERyi
         1f0yopBmD3IKNiknc0KzZhceYqH8RJj+mHe5rapXAjekzPFfNNtgFZs88VKD0BfxXgP5
         Tfm5SoBrFojTpNdSnW7KcKmIfc1DEgOzA9ES1pNwzTXtTLMo5WAPFOYBrLssY1C+T4qo
         AU8I/5dctsalSCM9xN1OKmVdUMvvCyiaofTP0X4ZTBY1V4LWcY6oZLA5F64Y+xywchvV
         b+hA==
X-Forwarded-Encrypted: i=1; AJvYcCUXmqiPar5cT6C33GfArDLtAMqs4c1USqw4cPfdG9brhRQ1yMVXacHpgrNJRII/JAVo1XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE++TlYmYC2WYnmbixPD2JivK8BRk0bVOcm1gv8ZhzelOJ1u0X
	QXyWEYq4bMbeCrS5aROy+sSFBYo1i/Bt4TaaSd89EpWFGVyapf6nLGwq
X-Gm-Gg: ASbGncs8SiL/148pEhLuDYomxkJsgzKaPe1hTJREnkUKWGf13qvwzqES291fobg5cmI
	Q84M0yZD/LT6zUAjtpfH0XuhOvsYvWQ63wsWS0rziOJuaPcNGkTaJstZgrQnjTkk53Kr+dn1XAg
	qSXLE7MWq6c1D8zeR4A3Pb9nDg5RmTzupMjZ8Dhtc1Vxb2qYp7lRKOfJhsY2pZrOhdjUSLcorM7
	3r/9sqZ2+q5azkBrrnlS6lGownLqr8HKqpMOFj/ZOp2UWhOsLq9lInyMGuTTKPJ6JWZ4/N9Vn5S
	CSkE2oh7FIBzuOW5TEGO8Rcw1we0eypWGAGt6Ur5eyFjLBUpEHsp7lzVE/Vn7R/JYs1Gnm9s7td
	W16IIatdYlORLRJH8n5k=
X-Google-Smtp-Source: AGHT+IH30pwfkRtYtRoDAkk0F0GDT8+fwCzlBoSaAujLDgKbpnTFrdDytXimnyhVlb/JE1B06URrqg==
X-Received: by 2002:a17:902:fc8f:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-269b6ca3806mr39319955ad.0.1758264406781;
        Thu, 18 Sep 2025 23:46:46 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm44880095ad.101.2025.09.18.23.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 23:46:46 -0700 (PDT)
Message-ID: <938446871de1d0b91ca7eb56dd75442b1d58b4b4.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/13] BPF indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 18 Sep 2025 23:46:43 -0700
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> This patchset implements a new type of map, instruction set, and uses
> it to build support for indirect branches in BPF (on x86). (The same
> map will be later used to provide support for indirect calls and static
> keys.) See [1], [2] for more context.

With this patch-set on top of the bpf-next at commit [1],
I get a KASAN bug report [2] when running `./test_progs -t tailcalls`.
Does not happen w/o this series applied.
Kernel is compiled with gcc 15.2.1, selftests are compiled with clang
20.1.8 (w/o gotox support).

[1] 3547a61ee2fe ("Merge branch 'update-kf_rcu_protected'")
[2] https://gist.github.com/eddyz87/8f82545db32223d8a80d2ca69a47bbc2

[...]

