Return-Path: <bpf+bounces-18254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA31817F35
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B821C22815
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF415C4;
	Tue, 19 Dec 2023 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QpjNzB1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E415A5
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3366827ca79so1571934f8f.3
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702948642; x=1703553442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2d8n5veSwDKrjujjZS9oHRQwKzoLqynkBXf88Dby3fc=;
        b=QpjNzB1MBfLG3FKO8ypDwYjxVaYBBCwmmO7Anpbhn6y7S2A/8BU3twlYeJIjqTfEXw
         YkwCarvyt4Q0dcYTG0sANiG7TFUPx76/D0bGVZ8HSmz+0f8zu7tLqtpwkpEVTWiLTZyc
         FGbkiKguJbtjRZY4Izroc0ZEKkpvGp4ATrGYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948642; x=1703553442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d8n5veSwDKrjujjZS9oHRQwKzoLqynkBXf88Dby3fc=;
        b=xS3S15mrku0jC38fqBxEyBluQF0E3UNBXspraA9vDGmvWVnX+AIi1mm2GVdxecttFE
         /S8z93naoTIehxlkOd9vGir5xdiYhOhQ5KY/Kl2PzjNIATWgKg+rLFtzDdx/oUNTR4CT
         XWYxOluWwBK90xgQIcfhgF/cKaQ/IJwzksHe7gp2EkebEecGFAiWMTyS4vATLBHJutIm
         Wbdk2g6dnaagnDh2YQSil7Ex/gnt+2+yZGOOg5km4eXsnCEqTjYZFU/Asxe7zhnWTvtH
         Hkv+Xy/7cHpSssPTbz73C9YNiw+C0w1knIg0xFPhT2dBQM4ZX7/xEi9AgU4IqWqaLeAx
         KeYw==
X-Gm-Message-State: AOJu0YxYRB69ZVVGoLSErYPsYy3wiWjl/05p5mNq6iLmy9+mAO/WD58w
	cJfkFFOMwYPLInCVVjGyv1cgoTkzTB/0qN8l3VT68Q==
X-Google-Smtp-Source: AGHT+IGaad4FAbOr3NDa7uPTSjKdfakpqBlnj3/rptmggbt3y/jl/7WdvahLn5/QG/b5vacAG9BmBA==
X-Received: by 2002:a05:6000:4f0:b0:332:c9eb:87dc with SMTP id cr16-20020a05600004f000b00332c9eb87dcmr9058205wrb.44.1702948642545;
        Mon, 18 Dec 2023 17:17:22 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402434400b00552720b4c73sm4898662edc.67.2023.12.18.17.17.22
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 17:17:22 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55193d5e8cdso4482939a12.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:17:22 -0800 (PST)
X-Received: by 2002:a17:907:7d8c:b0:a19:a19b:55ef with SMTP id
 oz12-20020a1709077d8c00b00a19a19b55efmr9119435ejc.127.1702948641815; Mon, 18
 Dec 2023 17:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com> <20231218165513.24717ec1@kernel.org>
In-Reply-To: <20231218165513.24717ec1@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 18 Dec 2023 17:17:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBBWGaQy=rtS2Ma6QPqbQ+jEUKUWfF2zS7gDXpim11bA@mail.gmail.com>
Message-ID: <CAHk-=whBBWGaQy=rtS2Ma6QPqbQ+jEUKUWfF2zS7gDXpim11bA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, 
	peterz@infradead.org, brauner@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@fb.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 16:55, Jakub Kicinski <kuba@kernel.org> wrote:
>
> LGTM, but what do I know about file systems.. Adding LKML to the CC
> list, if anyone has any late comments on the BPF token come forward
> now, petty please?

See my crossed email reply.

The file descriptor handling is FUNDAMENTALLY wrong. The first time
that happened, we chalked it up to a mistake. Now it's something
worse.

Please don't pull until at least that part is fixed.

I tried to review the token patches, but honestly, I got to that part
and I just gave up.

We had this whole discussion more than 6 months ago:

  https://lore.kernel.org/all/20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner/

and I really thought the bpf people had *understood* they their
special use of "fd == 0" was wrong.

But it seems that they never did. Once is a mistake. Twice is a
choice. And the bpf people have chosen insanity.

               Linus

