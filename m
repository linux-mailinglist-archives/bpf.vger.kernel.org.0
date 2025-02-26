Return-Path: <bpf+bounces-52658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7FCA46607
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7193A4485
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F701EDA00;
	Wed, 26 Feb 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP/HB7ym"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CF79D0;
	Wed, 26 Feb 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585637; cv=none; b=ZypeDKUbgl7BnnJ2mJXOKihjz9QjyxurUQv8LNJ85ypzBXnnct7TdA6pbkq4kxoeu841LFk5J7SX4oqyUzBX3Ffnz+9isaQgCCBBWX4mO3lE3dEPDbY1AYqtTke/pAXkmDS0/Gubn9UE2wX63/w8Y07y2EkC5JpSmOKY5zv0jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585637; c=relaxed/simple;
	bh=kHkB+HCaBdSvy0bFIms6en6j+ch1WkP5IOkqbnS1gSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMvCRltD4Td0TwzIp7wF/uEKZRF2sWs4iC8VTwUdLgdV5+ex9XpxJpl5gbSQKjb73OhK7hoBEDIy7Pcooo+zUhfyASpPSZOC4cguF9nF3KuPlG9bXnoLOzGRPEJWcYuP0T5H6QTfRVRj2XDxmluAtyHdYfrsV+BlGh8s1hdqqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP/HB7ym; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394036c0efso45294005e9.2;
        Wed, 26 Feb 2025 08:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740585633; x=1741190433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHkB+HCaBdSvy0bFIms6en6j+ch1WkP5IOkqbnS1gSY=;
        b=QP/HB7ymyPudJ3I4Wqhk/S5eVzWclxnPKfgoS/DmWCh1+xWScs4W5MS/I73T48D1oJ
         jeq6o+1R62mxBMctZ1HZ+dFQsRYHt4Pz5SLpigd0kj/gFqNnKAXMjjxgOGUdt43QERB1
         cDRlpGvZ4Y9Ev8gu9hAOlDoBFEZRVR8bbMg0CgRf7/Ox2HTHsiAmJIpnxjps906FXjx0
         Dm2w6Zo0Urmw2JN99AXvp1kUHMt4iAq3LpjiPZBw7EEiZEiQkjb/0Wd50+LbRz1fQ5dI
         YXoZsJEsDq5hNwa+BizBdia8cuTAtb2q6CQN6lvTWSTIHrB6x11zNkeoKGR+ZNNCZiIW
         MVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585633; x=1741190433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHkB+HCaBdSvy0bFIms6en6j+ch1WkP5IOkqbnS1gSY=;
        b=aUQy29w7tbJv/FCYVdDw2t6N2XqiucPV1kBZoJr5SsYH6zufZlQHs5+hLYRkudUOVZ
         VhvT3rLSVlRbK08cn/8L7OfdM/rXgY9+7GvSb2Dlo3AvvOdoXJxOwqQ8BxvvgmahkrxC
         eYSZntWNhTEzJkPIlOKuMvmvm82/g4G1M8J5MRhFXvPtJeWo/qBVXSo4qnuOwJJjg/PE
         H/htgUATONL9emXccFtIykd45l48fgw5ozjWcpdo/j2pTE5hEgcys9ok7VpkqDWo7g6J
         ALYfiualdfngt99KmspKWIw4lMFq8/LN7HvHicRnNaQD0TyM7vXZcMA3QK+Je4wb6bPm
         atIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNQyg19SB81raOJCSzyJZxB+BH8Nd0UIBo+DIKMdS/pHQaCYp2HjjQwFYRbDolPWqDZDBESik6DQ==@vger.kernel.org, AJvYcCWbeofh/YL4a1yL8mMDo6zjGaMCldaFdG8XBoDeEJgQ5jUyrNqDjfnznCvIYdHwrDCIJ57dCtPWRtdtC2+Btaje1zOYWZO8@vger.kernel.org, AJvYcCWlZFtVWYiADK6uy9RvlYU16HvtyRYj8DrLWEXmHFX2bkPLhfBvlNzs3iwSo/ISVWbV/dbh2MCiPcLgS27F@vger.kernel.org, AJvYcCXRR2ch2tnlPBlmrgT/egIcCpfZOKoXqXh6kqfFU0cPktTB+Y4xGZeP9TiJS6XCghT2VaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3hyLEoIK8xDQ8ZqiMJBmzVtpYM3WfUY5IJRPeyg9dyxEukj4
	tPtCFGs97fEYnjXTzepbx7qZx9Pom2SiNVPCvpgKKMoA4zW27FB9AbemqXQztgrbs1lCGvwAH0x
	SLGK+ebdKQfcUnO5MLsRe1MduphM=
X-Gm-Gg: ASbGncvki0pCZhKCNxp+uWlMkTxwjUKoGcjwGvuhGPJHojf842AgdnxO2IQ9pDso+T9
	8kQp3HrcsP4QFLILOxrHXuKJ+ZmOQ2cemVN1lStYd8tg+gBRoVrgnlgwMk4MvPMgyb15871ngmi
	G+ZWWNVNbqz2Q4jAwyW+mgiLM=
X-Google-Smtp-Source: AGHT+IEnzIccpTSpu38ZRm976PQcvhBwWZzlzuIa9i47JomSH3nFGn6WIQR/4wJQ7agbT1bgR03CzlctzwvY2FprXoU=
X-Received: by 2002:a5d:64ee:0:b0:38f:4acd:976d with SMTP id
 ffacd0b85a97d-390d4f367e8mr2395003f8f.9.1740585632741; Wed, 26 Feb 2025
 08:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226003055.1654837-1-bboscaccy@linux.microsoft.com>
 <20250226003055.1654837-2-bboscaccy@linux.microsoft.com> <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 08:00:21 -0800
X-Gm-Features: AQ5f1JqssAv3oBHTb3IsiX4NYi90Rnt9V3TLX6TONZbYMfDzNUbG2vAqbXFr2u8
Message-ID: <CAADnVQJWMBRspP-srQwe8_B1smGG1hs3kVbpeiuYo-0mLWAnUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] security: Propagate universal pointer data in bpf hooks
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:06=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, Feb 25, 2025 at 4:31=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > Certain bpf syscall subcommands are available for usage from both
> > userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> > need to take a different course of action depending on whether or not
> > a BPF syscall originated from the kernel or userspace.
> >
> > Additionally, some of the bpf_attr struct fields contain pointers to
> > arbitrary memory. Currently the functionality to determine whether or
> > not a pointer refers to kernel memory or userspace memory is exposed
> > to the bpf verifier, but that information is missing from various LSM
> > hooks.
> >
> > Here we augment the LSM hooks to provide this data, by simply passing
> > the corresponding universal pointer in any hook that contains already
> > contains a bpf_attr struct that corresponds to a subcommand that may
> > be called from the kernel.
>
> I think this information is useful for LSM hooks.
>
> Question: Do we need a full bpfptr_t for these hooks, or just a boolean
> "is_kernel or not"?

+1
Just passing the bool should do.
Passing uattr is a footgun. Last thing we need is to open up TOCTOU concern=
s.

