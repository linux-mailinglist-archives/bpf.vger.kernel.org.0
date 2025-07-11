Return-Path: <bpf+bounces-63065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2B0B0225D
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF833BDFBB
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82B2EF9D1;
	Fri, 11 Jul 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYx7lPTO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848856ADD;
	Fri, 11 Jul 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253871; cv=none; b=ITL/vM70e0Xa1PtifItxjRATY1ZStSSjrRA/Ix7deWb06MiLZyI9ZKQRXULW3cxXjkdHWQ5R9y8qd86/haBVGolrPfxoReUK7x31NDg/naHiPiW/ZS+g80tHuCrn7OpL8EysguUkeKzoC515tUkW9rZ/hPPF1eMmM2BBfjJKarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253871; c=relaxed/simple;
	bh=8aE1JxSW3G0isHfGWdjKtE6mW9HmNDr4uEJaMprap4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVFqY/4+bGUCfXqwnSWRprhF8XbsldJYN0Ts3okzSWeCmzZ94Vg8L4IGaEVegwps7KYAPl7+B7WZE3oytWHuTquNI/3eQV218u7q1kGSMfAnbs+o/2S56xpgvQefetbdkTWZV+WeITSbkjXX4dgYxUnnE98FBgJIU+fhDxWDLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYx7lPTO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313154270bbso2339630a91.2;
        Fri, 11 Jul 2025 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752253870; x=1752858670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chzMb0CbAkU+BHqpihuecBQN2CqI/VHpcerfyO7Hzfg=;
        b=MYx7lPTOSr4bwcGVqM0WprhpXs5PfcjSmBl+WiNWbo8RRX78ocVDe1uKlHqYKC3zq+
         TggPEYzZdObRa9qmYWtpET+QW6K+CgCcUtPlW0zSEnoZ/AtdDJr/6MHURayNEipUA9u1
         +2zCpBKXPOY1+qMZ6Nh7/I5dnQwKbEytlK0RBOGdqipRckdHI3Pqeqjdki5R1FTAY5hg
         NAgDRn6y43tSOmuN7sDQlX1Mo2S3crPfNxYmA8uvM7WWgnrQ2lOVwVroIOBeHeut6N83
         +DBTTtJxBlzKyZY4VZPz22s/5ShzgYJnqFS4YGWJp6o9nj5koVoNGtzMAyVirJaWM6qa
         nJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253870; x=1752858670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chzMb0CbAkU+BHqpihuecBQN2CqI/VHpcerfyO7Hzfg=;
        b=OFDeS9D2Cl43XQfLtnuGGJO2c5qgT9FRD5EkmAz3lkBecDBEFZI1AsSUJMmwzINQIN
         A8IkzONblDaOVUm1J3Mgg1RVEd7NfvOL7LwU5QGBDbb3QfaqkCrlfJrU5D5cbFOPXiO3
         ZV+/eolXg/3oigjS34ILDRF1iBhkCsbfkJLV+ecmn3+EC0KfnrDFuvF/BDIROErpxysd
         vxvBE4IOZFXXEIE6S8/f5YHQqMmNLanQ6/uG9oj5zOopmxzqLs9k+G8wChS/q4iX0IJ+
         a8bb7u2bp7c5fmElXSH5CFPF9wVcFGrQn31CV3ZvVmuA3FzziiuWTqhcilNFLhruvOWh
         cAzA==
X-Forwarded-Encrypted: i=1; AJvYcCUHA1RFuS8KQiVON3Zai80UmebOR0YyV3TOrNwY2Hlq6Cai3rbVLlmndKZQTPj2RpipgBM=@vger.kernel.org, AJvYcCUvrM9OMQZbwL1gkIzq7sE/G0la3sk1PqS+k5CT6mSrmKWa8y5ozhzGlUL8hDU8jDcHpU/gsxaGSSIR24Pj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tcyILrDodyokli/VEwbxOK1lXHR0CfnwgKxtwA1dcEKVhyHE
	8qkK1ISWs3HC7DOTOIHhEhIxj6QXOnz/czrYeoHRYZ5rXBlWOznULYrJeeEYsSK3rgqbPyBg299
	PZCnDE9V5dguXYzqJzbPy7zqQXkoMvgkRew==
X-Gm-Gg: ASbGnctaXz+vA/H8hpTgwbBeorEmyFYeWHnqT/c6ejMoeOthYuEp3ISj3DQPsIr+vqA
	hot0ifE4HLz1J0DnYPS3rFWXjXWZ9IYkriKaVAT51GTnUA7auf3G/Vf89tYRWLJ+nfeZilIIq2y
	VRctJ5dxlfzIg6UIUh+Trz9NH/dRr/lKXKgnz+8B9CUT5OVPIV4O/WUFqDKYR4hmpNpj/cxMpoy
	0mLlD54HfIcnxDFbeW8nfk=
X-Google-Smtp-Source: AGHT+IHhtCd4JlwSIQMFXtWQSMSQaXgtm0PYL+GxoQUWMjTPCiVAZVQ+Rhc6xOknOX4S+eIuNZKviqG0MwMt0M4BbZU=
X-Received: by 2002:a17:90b:4b45:b0:311:e5b2:356b with SMTP id
 98e67ed59e1d1-31c4ca8458fmr6794354a91.11.1752253869733; Fri, 11 Jul 2025
 10:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711094517.931999-1-chen.dylane@linux.dev>
In-Reply-To: <20250711094517.931999-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Jul 2025 10:10:57 -0700
X-Gm-Features: Ac12FXwfksYKwkrQ5hnmvg4qR2jYIfHhntWZzYmffC0lny9k72i7AzWWlqBpLMw
Message-ID: <CAEf4BzZzsqu1=Q-3+6uJvgvKd52o+FR=DFp28w+vT5knP9NyCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com, 
	kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 2:45=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> The 'commit 35f96de04127 ("bpf: Introduce BPF token object")' added
> BPF token as a new kind of BPF kernel object. And BPF_OBJ_GET_INFO_BY_FD
> already used to get BPF object info, so we can also get token info with
> this cmd.
>

Do you have a specific use case in mind for this API? I can see how
this might be useful for some hypothetical cases, but I have a few
reservations as of right now:

  - we don't allow iterating all BPF token objects in the system the
same way we do it for progs, maps, and btfs, so bpftool cannot take
advantage of this to list all available tokens and their info, which
makes this API a bit less useful, IMO;

  - BPF token was designed in a way that users don't really need to
know allowed_* values (and if they do, they can get it from BPF FS's
mount information (e.g., from /proc/mounts).

As I said, I can come up with some hypothetical situations where a
user might want to avoid doing something that otherwise they'd do
outside of userns, but I'm wondering what your motivations are for
this?

> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/bpf.h            | 11 +++++++++++
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  kernel/bpf/syscall.c           | 18 ++++++++++++++++++
>  kernel/bpf/token.c             | 30 ++++++++++++++++++++++++++++--
>  tools/include/uapi/linux/bpf.h |  8 ++++++++
>  5 files changed, 73 insertions(+), 2 deletions(-)
>

[...]

