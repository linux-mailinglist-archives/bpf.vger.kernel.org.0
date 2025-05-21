Return-Path: <bpf+bounces-58675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB7ABFDC2
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B847A9865
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EE28F958;
	Wed, 21 May 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6S68Oa/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FC1C8633;
	Wed, 21 May 2025 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858780; cv=none; b=NdKbw0WYgXpyM1YBKir0akvEzVJqdM7VIBTv9qlOJKcRy0VqfPaojTSL4W6+52T1yIy3CyFrAab+Yr0Z3NXp5vqjwuXX0/lF8+lU2Up5o4QotH8WKoQTz3+MBTmPRq53U22jt+3jJgfQBJYCPDWbbhEMFf9ht55gmcHlK8WAmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858780; c=relaxed/simple;
	bh=tjhYjW7L4FFFPrubQbwH1r1XPujrrt0fp4n3hhJMc1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NLqQqIPQFs4z0R9dfUN8+ctxTS38n53xUtrCKMYyZozwX/HEJ1MALNoUvqK0ax/QHhh3P/FRTM7d9eEu4Ih5tj+nkk5zg1snlNKCxkF/vyKkn4nZxN4gM/UdQ16644CqjRB6plLiwed9xX6QNB6XwOpVgOd+5RmiDF85soOofUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6S68Oa/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23211e62204so34848485ad.3;
        Wed, 21 May 2025 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747858778; x=1748463578; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSnh0EqJ0VKkWF+UpGyT7j1E38rWKeg6E0XzeWHYX4E=;
        b=W6S68Oa/XLkHa2fePunblMEHlYCCwuCA9GTs46HaBwH+BbpzkDAwkfX/Zp2G4koONo
         59GzmuiTUjbwdl8RPlaZsXxq5XecM7r7zBGwQ+Lnozt88elysIPYHW+lmwBwqLS/ouEM
         QArmFpyBLUKUHL2+Tku7MXxU5Rz4cVgGIsVeY6EYbr95P8MU3fBZRaYUWmKq3pSsf/CA
         rwbjBvPx2EhRJilx6xUdQKLJmi1WelSaY31EOQt+4G2fGJL72x5KZEd/3cnoUKnkQF7y
         L5JD6LpRcN0C2rXW+Gn0yLQlNwfnTegaP4sHmtzcv2Hu1NsMcbFH7ZqkU3jXyPE9I1Ti
         rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747858778; x=1748463578;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSnh0EqJ0VKkWF+UpGyT7j1E38rWKeg6E0XzeWHYX4E=;
        b=tgU95PFlNx7S0k8Bl+C0wig95C8vkn9Eja8Oz7UzcWp7rV6JLtjhUGWhcvQAcBbtxy
         Nch9q1lfluD7nLGrLCIn7Xc3HhQB4Boj5UhlrB8y87Ho/7zCfMiWS0NaeGZ9xMccyIR/
         an5FEloXlxiY61E9FxL9za68mAsQ9nlY4/QnyJWojI/Io5ZGm5Of2MJeX7gQEFU0K/gJ
         b2Ss0Qg9m+OzqJpUbA6qI19HDaOCgGWZVs75bl5E9Ouw6r8QG3YQLLUUE9Uk4JL2zgCs
         milKrA3xWOc+04lmKmNo7CGUPnj5bh091kwqdx/pxDw+PS/Mv6jqsdKCjqtF4tSVIGaI
         IGvA==
X-Forwarded-Encrypted: i=1; AJvYcCXd1ye6KSWiGviavQXVTMusYI+zJ4mTsjwYPOS9e9P+qiSRBca9L42C2aE3FqsUoqDZMnOZeA7Vf9o3VQqL@vger.kernel.org, AJvYcCXna/C8TQIeymeeC6ATXj5h/6lMLoLjG212Jz3SKXQ3YxhsKdD6ncya7LyBMNuW21HAEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkHEaRUETW9SPst6+/GdZxWbcZuT+WszMqLrMsHM+bUlawWSn
	83F1wjKEXCScZtTECe+ny/1rN0kN3hXx6pZBwvZyijvS+G0ZqAg3TussIQ73ESCm
X-Gm-Gg: ASbGncsgnEgEASkhr13koO4otAtoBII5zVGt5Bf5YltQ+uyIYbqfTeuBOHk9sycqn3O
	YQIZQamC5G2tsowzBZiX6MLeF/ZvYt+59rKp7oo8z7AGkMluWecvLcNnxZEJnOskiv6iBORvgug
	EadLOCF9xawfDeLMK8aV59ks0nAfkaqJ7M4lsQRlOTnxbt6iih3dbYYnsmApOujUtgfauiRhaJz
	4bFk4IzJeZYGEUaPWQCLNz+RydsIBI7BXCYm0a/JwhJfqaTXc9svObeA2Dhtk6ppuAnXs42G9SD
	ILpnNbNAgcnIulSan6tSahwtYXFe1M1ei0l8FGwODqEwOpSoSrFnK8j7xQVSEUEgSg==
X-Google-Smtp-Source: AGHT+IGuzyAubJs8rThsSBUlBsdu9PutsXbGiWaYozgupNOPTNoCAuzoUgu3d3pUg+n5akbiBL9tNA==
X-Received: by 2002:a17:903:2404:b0:232:7741:95a7 with SMTP id d9443c01a7336-232774195cfmr103058175ad.43.1747858778014;
        Wed, 21 May 2025 13:19:38 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac959esm97045435ad.33.2025.05.21.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:19:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peilin Ye <yepeilin@google.com>,  Puranjay Mohan <puranjay@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@google.com>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  bpf <bpf@vger.kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: verifier: support BPF_LOAD_ACQ in
 insn_def_regno()
In-Reply-To: <CAADnVQLgPBcRAqKfCXQwZae2jKDfp=xSFZCgzHgg-jcBTYp-yw@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 21 May 2025 13:04:47 -0700")
References: <20250521183911.21781-1-puranjay@kernel.org>
	<80ef5e2e-c2d9-45b7-9a48-f8c1a4767eae@gmail.com>
	<CAADnVQLgPBcRAqKfCXQwZae2jKDfp=xSFZCgzHgg-jcBTYp-yw@mail.gmail.com>
Date: Wed, 21 May 2025 13:19:35 -0700
Message-ID: <m2v7ptd8dk.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

[...]

> I suspect it was already fixed by commit
> fce7bd8e385a ("bpf/verifier: Handle BPF_LOAD_ACQ instructions in
> insn_def_regno()")

I see, series [1] is not a part of the tag [2] tested by syzbot, thank you.

[1] "bpf, riscv64: Support load-acquire and store-release instructions"
    https://lore.kernel.org/all/cover.1746588351.git.yepeilin@google.com/
[2] 172a9d94339c ("Merge tag '6.15-rc6-smb3-client-fixes'")

