Return-Path: <bpf+bounces-47203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A69F5F48
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 08:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCD4188C625
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D718165F16;
	Wed, 18 Dec 2024 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/24TD2F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F515E5BB;
	Wed, 18 Dec 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734506868; cv=none; b=TNwiUxwsaYjHv6T3NwGJFGqzpizrlT1DqXxtKyf5Sm1wZOBirf4IcCuXU37p9ZDpJhvxZqYX9ZN0NiuUfziiTY26EY4EnBMe4f6lQ0H/6esJbFGKhgl9YoReMDtCtLMIWoAZo4xwzBAS3/LABqcb0RmowtCFug6yrQoJQYeTEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734506868; c=relaxed/simple;
	bh=PmiB2jVs4zNHVOPQ6aZNIWnq+/9oepP9P098lzS+iCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3lnpxyL1aGomi/YGjOMw+CNtBiHLWHwoj8Da+sW8y9x0WEn6DemIim8xYrhLAV4aoUXNq1VfggmLPUNNThVuRXx6nuB98s1mFOPzOXSU5kNFX8j49cWjtG/Lix9jHIc1RIgeFt4i0O65zR5eywrxPBYhvY6sak305qc2VsnVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/24TD2F; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so4175771f8f.1;
        Tue, 17 Dec 2024 23:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734506865; x=1735111665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmiB2jVs4zNHVOPQ6aZNIWnq+/9oepP9P098lzS+iCE=;
        b=Q/24TD2Ff1VbJNe5SLjg7mjG2dtAXd27YmF2FgsGAd18aW8oIVFFmp00tWg7cLjstu
         0no9W60C4CoPsaY1SBsXI96GniLyGsz3DD4sXGBvp6MEPsFAhc/iZ1/WE1jzuxVsYdAg
         eIkM6YaYxRyT1fvvo5BskYra34Pt65pNvzZmuBrqR5lh/B0Hbi2AmLXm+Ka7O124hc0X
         dE6iudr7Tv5zyswz7wt6I06Mn4iMeMeel0J0oTNlSxG+vEhSsRCGySmkJQTk77logOp9
         SO5LS8o9JY53PUpOqHks1SqevcQNcV8tau98Et4QQDpMfZU3IGL9FvtRm6e7blQj0GoT
         4B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734506865; x=1735111665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmiB2jVs4zNHVOPQ6aZNIWnq+/9oepP9P098lzS+iCE=;
        b=JTNAp5wLLXKheT3fsuB5Iuj/2tDxJYqXqYhau6hvXDvFM5A/1bV6kDjYEnwCZjpm8G
         G4nHKvpXqwseRHJw+iGPdd7tOfvrYpyCiW3Tg21nQifKvXDdBGQvuGEa4PemcymoPtn8
         TeHPstJsA5j0eI/1znjb1J/QAu18Wf1YZ5M2ogQdZWOEVfoWNHWhM6fQPtSfyaLR+e9R
         5BD9PUJdOQPPP+/mVDGMarBuQim5ofhr1SAk6SDqqzzUPPz3MdUQq6B7FCrMPwPiIrK+
         HHdOyeG5e5Pu9sD80tRsF/5XNwp64V586sPUXVciZesb1Pa5E35iVPeBltCg/H1pgLkg
         PMLg==
X-Forwarded-Encrypted: i=1; AJvYcCVR5rakiq/0zSc1wrm0j6UYCL5b/56kEFpKhYS5CQcVIHzUY/XUI1J4KYPmk/3AjY87ZgQk3/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKqYlHZ4qlIiCUqT4vIwiP1AQSANNDjlIAGyz6a8Frk7/InK+
	vGsIb98qoy6gAfDgyJChQrvUkbaiXV1pmcXNSsc+QpyadwtBHD5/KSSrxS6HxSl91QjLjq8ayWZ
	NKI1XjJgm38Om0zz/CBxunBa5H9qk7Q==
X-Gm-Gg: ASbGnctPsXId6dzjQKOdg728LisCj54R5fz9mtJg+/a5h8yTQiXzYvAZ6I8WIe3YbVg
	xPu7rFc2EA6vxKed/zJx+qaIeIXs6NLUXDk4mCw==
X-Google-Smtp-Source: AGHT+IHsFDtU4ndn8JgqApZlkcUJ7PVZCQoLpOIAu6Ie5v6zTMXKtYOVmuiPDRtptlAQbimxh4F9JCj8kDWVKj7p6KM=
X-Received: by 2002:a05:6000:1446:b0:385:fd31:ca31 with SMTP id
 ffacd0b85a97d-388e4d96b6fmr1556682f8f.53.1734506864489; Tue, 17 Dec 2024
 23:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ffsmmoqcc7yru7yc6sykdwfnad5phgddl5wysq4bw3mwdaiixx@znzt4ucmf37g>
In-Reply-To: <ffsmmoqcc7yru7yc6sykdwfnad5phgddl5wysq4bw3mwdaiixx@znzt4ucmf37g>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 23:27:33 -0800
Message-ID: <CAADnVQJXEmy4v6z8eYYPtgApWvv4LGgYExsFvbVPBe6BN9xAeQ@mail.gmail.com>
Subject: Re: [BUG stable 6.6] kernel crash in BPF selftests dummy_st_ops
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:02=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> (Maybe a good first-timer bug if anyone wants to try contributing during
> the holiday seasons)
>
> The stable v6.6 kernel currently runs into kernel panic when running the

Does it repro with the latest kernel?
If not, please make an effort and figure out which patch is missing in 6.6.

