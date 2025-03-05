Return-Path: <bpf+bounces-53261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB1A4F2DF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CA03AAA9B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 00:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFA2E336C;
	Wed,  5 Mar 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LYBkBoct"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053527452
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135217; cv=none; b=E7yK3xLlGS6jFxNSN8X7iGMZZ0w5BKBIf9X3OTFpddWDmEKPB+FXBAameYpUMOxRmcFSM01mBuTi6vEuOH6jhoj3+hS4zD310K9IS0whmqaCt6QNB4ky88ifognRmf2nc6DXHbF6yVisx5u3RTQWCyWre1JOhYY3NbOru9x+WBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135217; c=relaxed/simple;
	bh=8KEjXP08gAH9mtHlZwTSZJHkrRvWvyV0abRhH8806fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFzo3Mto9pXqihuYXz/J8dhI5E/hB5FFD3KOf0me4W/Pd1wKAyYo+MK6T+CVGxBUOOmSlmyX7EpQtEHeNqsFQHPmG5xm5CRiTO+DnG/EbzEseVwvezHv2iXLR5BncWICxpXihRLScUvp+xn9cmiIDu6vv9jgifnG3paOpsGISzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LYBkBoct; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so4559673276.3
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 16:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741135215; x=1741740015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLByKeK9jbAcIudXTB8h4/g+eKrBdZDjVDhHL4wGDkY=;
        b=LYBkBoctszf5rC2eNNrABPFqPNlWLnGPtCrmPAusBquV+EryKb8A1dvWiljC9Rn+hV
         kRELiQPMw/E8sYsPnvn/tSbrBuie6kxnJuZcSqtCmUaWbGtZWf/cj2EbZkgy6xfS2/D7
         C1DiH52qG9CG6e7kDNY7x6zXDtzMMFfGcn9e4q69JHr1YHXLssTqTq5pHeg06ZFJuu4d
         NyOC1FY4GBYEH/y0QDZ499MtiCdozx1VCrxY2HCyR1MZ3PnKwXaHDbBGnrL0KJzoYoIl
         1rGlsDgmk2ZvKNd2rFtyCpqVNUodm7/LuMHlC7nK+x2mTie2SXOh7qHk3WNRQAhmJfA0
         t08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741135215; x=1741740015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLByKeK9jbAcIudXTB8h4/g+eKrBdZDjVDhHL4wGDkY=;
        b=ZgqnYTXsV53xhXX6w3+wTJs7AawFB+ZTkZu2cSKBd95WLwr3IdxOQXiBanUp1EF5OV
         kekTJ22tc1Rv7YDOxWVV1DF0HIvbSDlkgBVRhX3SbmB8HwKVmkzvPUcTGYj7dofuqVLg
         fL4CZTUOBqmMzKwlr7Qyem1cTswSGTY8MGjpbMJwVBgsEOIjwaWTENjuGZbmZmb5/epb
         fygXyPGB4cQlhQYGEAArJo2tIWhJRImBXvjr6M3Pq+Q/kNOP4zxuiMqKccd2g7wrVP2b
         9gpiVIkaU7pZhRL1sAc664M75WqMSLVjkR/U9zA+SMQnG4U2p4OPO24x4anny0jMjPgO
         CYyg==
X-Forwarded-Encrypted: i=1; AJvYcCVr0Hm2WGiMBlgFKw1q1UeHL55a3owG9vapZ+Q+pTqD9v2ydNyqvmAHt+BVoUO6/YRoWyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJJPUZioUiiu9LViNS6TFWCrvLdne5bNJ/IJ6byN+m7JQIhpq
	iOowqg2b73bAcUvwTs3c0kubq1gTqYrVJyDWVuf0Wpa+DsbsnR1kM75OcL8qIx0FYsRK84cpR0E
	+z6oHhGdIyy8QwhEGPeOpZhST+F30RQo2yjf9
X-Gm-Gg: ASbGnct9Mtgmh2E7CbPdT7ovysy8sz5yd86oaZKZ+e0dkHyb//kUMgQMvuOOFdkhtvk
	Y2NiZfiI05T3sc8HRUnKqCEVMaA0s/6l+hskTQVz8ViksedUNfT389z38fM4pwSw4HS7zr5gBKh
	9oXEy416QjU8X0wPVCclrMFNJdrQ==
X-Google-Smtp-Source: AGHT+IEzmMWOQvRMnjDkFhghROqg9lxOvTBles4ByHr5bhpu3fcrvkVJICgDGQ2HmqiNLuH79Zde6tj1J0pYKTCXHas=
X-Received: by 2002:a05:6902:2009:b0:e5d:92a5:9f79 with SMTP id
 3f1490d57ef6-e611e35f307mr1471560276.34.1741135214898; Tue, 04 Mar 2025
 16:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com> <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:40:04 -0500
X-Gm-Features: AQ5f1JqF5eg5kGEnn453gAfWw1axYxi2H7tbUtolXQD5gFiAWaVD4kDHxBozzFk
Message-ID: <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> The security_bpf LSM hook now contains a boolean parameter specifying
> whether an invocation of the bpf syscall originated from within the
> kernel. Here, we update the function signature of relevant test
> programs to include that new parameter.
>
> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> ---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++---
>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)

I see that Song requested that the changes in this patch be split out
back in the v3 revision, will that cause git bisect issues if patch
1/2 is applied but patch 2/2 is not, or is there some BPF magic that
ensures that the selftests will still run properly?

--=20
paul-moore.com

