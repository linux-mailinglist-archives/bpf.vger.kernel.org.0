Return-Path: <bpf+bounces-67497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CB7B44734
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030A7169DD9
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7D27FB1C;
	Thu,  4 Sep 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZzptI6f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427627E056
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017321; cv=none; b=sQOCPIDnSf/zQiaIB4BU/ObeS6tmAHfcg/W4WXsVgoKmFIJ5uzzmVS5uNdNYUgzSzbtjPPYFy1JRR/bQHS2+GwdR9oOIebAiOD0QALDWI4l6eyA0trTFYK2fXcIbefSsefKP4KTtcEhmFJb+fHqGtG9GPQVObJEoLC/YfcmbL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017321; c=relaxed/simple;
	bh=0f2DsioJC0fVlKf43S/586871Ko6aetl5MjQf/S6JhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAzPoD1PRgJtqOpJ21gdYchoYA+M0lNeomVPKoXoMYfrjJrtdKJaI3D4fPqoAmDnSGJfLbfn8DZCn17wjfmW8v16dJsXsv2pYrn4diakt3I2WxQj5hrxuN/Jg+fSnxbnVBVJNCM3XRMwQTZUXNwGQNP8x1DVS82MBD78FcYiVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZzptI6f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244580523a0so15880265ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757017320; x=1757622120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f2DsioJC0fVlKf43S/586871Ko6aetl5MjQf/S6JhU=;
        b=MZzptI6f+wkrRV53k/HYgvYsGBMbnTfRzpgxMssnQOtG1Gwzw0CwVa3KdsVLnKhzyV
         H4Y+UtA/ZvQ8+yJl8wAFT9N9/S1AnNDFuZIOl8EKIlMW/19PtSwZimPsVMi6Mn/7J5X1
         kxPDUm73EzjTtKOJPuwnlRMBKQrFPnW0b/dWiIAIxMpSjWxWqDLngoJFnI5lYVV6Xgs1
         amrl5hDpLtPArRnyXAgoNl+EuLDkYOxVDfWg7kNRgeC2YN7xeluSrd8BTlq8vJnovzDG
         NJgmnj23jGiUAkHCMJoGkV9qfpsf+guBE4JUXAySbLD4+q7+TpK5nCgAFwBg/Gc3kUU2
         mglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017320; x=1757622120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f2DsioJC0fVlKf43S/586871Ko6aetl5MjQf/S6JhU=;
        b=XcWAVjhEsMSzzYbeJS8seGyearYlanvg3x1So9lXeTvjZGrDGlsMghLuJjYrLpKZeL
         t/+4kPZKp3LIFhJ5pz9MvNeWwprdUf7M9OxVVgXy97t/sxVq4OmR8gToTWob3nizFjO7
         OPU0gMVcZgaIRcGiJA76PMLvr7Ns8Lo5B4wcR3d3DsRaFBk1JYnxvlftU7lwEF+6i4FK
         PPEak3ibldeODn4J1XGEqdlnj4Mcmdv9oUWE2ZkduWTkS6iSGZ7ZPzjK3klkweOoCJkE
         PjC5c6fbCBeX8cCINFu/MffPh2X4cmhN3WFTqCZ2ootJHX6RScr9H9o55uJ0pnfmaqB2
         5cUA==
X-Forwarded-Encrypted: i=1; AJvYcCXmGZijLWVCHnYlPnI/pEfWwCR8/tCnVlL2QuwBepJn+9+LZcOpIDWIRMgzRblkuw+TWGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMEWqOp9Oo+dCDDQryIxcNdPTJXFN6yT4oKgXayyjDmRAN2LH
	e+U3xVC78LvfZnGj64X7VILq9P9ltfmATLnL0MlQZFSydLpQ/glIwZozpzHfPdsKlSHNZvR/kfl
	1L6W2RzC7riiFVQBOdBNfbNbdPJscPKaQ/Ewwaxi9
X-Gm-Gg: ASbGncuXppYxH+yTyTj5RcFJ8UZemo2ik7EbTHQ2RQpFy5r4JKkwy42T9mPcYngfvoo
	qiRMaIV0ygU8yVpeXABFHXZE4Ewnl4zAz52gFbIeV9fLqN4tPe7aB7zpsk3XxC//KU7IVnH2ewj
	jNV+h+KJLUv7Ia0VSy39CDa/FuF7rffES9ZnpnCvesYgqd0wCmIZ3ygppoH8LvF6RUkVUeByQox
	18a+tzaDCmU6mneH27OUm1q0RXcM1nT6HJ3RHu4UHq1z2fcN5FVwyDXL8nMwW1ujFeBvhEGWDO7
	tIk=
X-Google-Smtp-Source: AGHT+IGCpw4BSt538n4Uw2GeGiMXguHm7w7MP4CxltxyWLimJdtsHYLf+rp0dqaFLLxBfB5jth41N3wmB6ZcBZqH9Wo=
X-Received: by 2002:a17:903:138a:b0:24c:a9c6:d193 with SMTP id
 d9443c01a7336-24ca9c6d532mr87039625ad.18.1757017319455; Thu, 04 Sep 2025
 13:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com> <20250903190238.2511885-5-kuniyu@google.com>
 <20250904063456.GB2144@cmpxchg.org>
In-Reply-To: <20250904063456.GB2144@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 4 Sep 2025 13:21:47 -0700
X-Gm-Features: Ac12FXzgx7crniaX9bGO-zMhcDMCF63LfUg1yz3p5hFqcyJzW1tUCJKKbUqLic4
Message-ID: <CAAVpQUA+rVJKMXQFATfxT=uX3QaLrCtCG_wtiGF_kt-_KrMRBQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:35=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Sep 03, 2025 at 07:02:03PM +0000, Kuniyuki Iwashima wrote:
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and processes not
> > controlled by memcg lose the seatbelt and can consume memory up to
> > the global limit, becoming noisy neighbour.
>
> It's been repeatedly pointed out to you that this container
> configuration is not, and cannot be, supported. Processes not
> controlled by memcg have many avenues to become noisy neighbors in a
> multi-tenant system.
>
> So my NAK still applies. Please carry this forward in all future patch
> submissions even if your implementation changes.

I see.

I'm waiting for Shakeel's response as he agreed on decoupling
memcg and tcp_mem and suggested the bpf approach.

