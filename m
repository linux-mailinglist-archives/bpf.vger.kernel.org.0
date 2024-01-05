Return-Path: <bpf+bounces-19140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA3825B95
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 21:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C0A2833FD
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A935F12;
	Fri,  5 Jan 2024 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fu1qBJqI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35123608A
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso2364759a12.2
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704486360; x=1705091160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=Fu1qBJqIWxxcyDLUZHseQ4WL035I81YDj3pn4RYWS9nLOvCf/jU1OCWf1Rka9AZP+T
         yj/5OBHTzEmbAVaqc0LUlgwfz7gzOUzUSIg2MniCFPbjoMLdB1tz4K7rkGztgO4dgBQn
         3bIun3N9s3c2Drt49Phvx14aix5mVT8Eoy9zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704486360; x=1705091160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=glQrdZeJjse31j6SLm4Vw0tcf/96uZGXq2OdQPPjt4aRDM6EtKnHBM2qJQMc5cI+36
         OTCXGHzowk8sRbxokehAWn8RRPvQk40Gi5bOEVLEO8qeVE/VmM/awt4M0816sraCM6px
         Xeg7xWU8YEKx/ttE+zTx8MBag/Lw9sB45pfHIcTzHLTL7dD+SqnTWenME4qkC/miVyef
         C3WeXlorDMMCH/OxWrDPIsAXRZRCJa1AbZxZO+A5A5x6m+5wrW3XdTfRpGIDqf1Lqu+0
         nCVbVmc7uG23FfS546rDMAHABGkIzk+B6DymUIGirvUVrSFft0mtgfoTOpoEJah9+uPg
         wnsg==
X-Gm-Message-State: AOJu0Yw9+ZddfH8U6jf3dytL3iNyRfru9U0WvMEqAIc0Yf/bBs13v6xt
	wuvXijGUIx1ViL8ZS5+SKvgiebRSu9TQw2p6XCrTSdHZOIIhuA0z
X-Google-Smtp-Source: AGHT+IF9HJAzGpFZObrQoAnGUAXof9GXA63lQkgrHfAHzBcSf491LZXGStYSPRhwe+RhNWIAHHT0hg==
X-Received: by 2002:a17:906:4e82:b0:a26:9c11:6400 with SMTP id v2-20020a1709064e8200b00a269c116400mr1182632eju.123.1704486359724;
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b00a26ac88d801sm1220736ejb.30.2024.01.05.12.25.59
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a27cd5850d6so208674166b.1
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 12:25:59 -0800 (PST)
X-Received: by 2002:a17:906:25d4:b0:a27:9365:ef73 with SMTP id
 n20-20020a17090625d400b00a279365ef73mr1360283ejb.38.1704486358728; Fri, 05
 Jan 2024 12:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:25:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

I'm still looking through the patches, but in the early parts I do
note this oddity:

On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> +struct bpf_token {
> +       struct work_struct work;
> +       atomic64_t refcnt;
> +       struct user_namespace *userns;
> +       u64 allowed_cmds;
> +};

Ok, not huge, and makes sense, although I wonder if that

        atomic64_t refcnt;

should just be 'atomic_long_t' since presumably on 32-bit
architectures you can't create enough references for a 64-bit atomic
to make much sense.

Or are there references to tokens that might not use any memory?

Not a big deal, but 'atomic64_t' is very expensive on 32-bit
architectures, and doesn't seem to make much sense unless you really
specifically need 64 bits for some reason.

But regardless, this is odd:

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{
> +       put_user_ns(token->userns);
> +       kvfree(token);
> +}

> +int bpf_token_create(union bpf_attr *attr)
> +{
> ....
> +       token = kvzalloc(sizeof(*token), GFP_USER);

Ok, so the kvzalloc() and kvfree() certainly line up, but why use them at all?

kvmalloc() and friends are for "use kmalloc, and fall back on vmalloc
for big allocations when that fails".

For just a structure, a plain 'kzalloc()/kfree()' pair would seem to
make much more sense.

Neither of these issues are at all important, but I mention them
because they made me go "What?" when reading through the patches.

                  Linus

