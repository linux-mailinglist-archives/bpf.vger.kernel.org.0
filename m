Return-Path: <bpf+bounces-832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDC707650
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 01:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318612815C5
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 23:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46A2A9D4;
	Wed, 17 May 2023 23:15:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276142A9C8
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 23:15:06 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4626B6
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:15:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659c5b14d8so216449666b.3
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684365302; x=1686957302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk6cd8LcbzAJxt5N/GDDi+PvU6BaObHMv6cAraPkag0=;
        b=L3qjB3VaqsqlOiGB5yeTiiPsIIfhodMmHKQY2F8CmzC2L7OHTbVab0xh8JeM0wAPRf
         MVnA11JyPXHzfj84mH2U6ojLkg5Bs+WuZdXTkNXfkEFxQ3AqIyqzUyF4jEc8wFX0MnLP
         qf/BBm0TbuUJvdeQBAKk9cgSNfVYQQ9hV9DHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684365302; x=1686957302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk6cd8LcbzAJxt5N/GDDi+PvU6BaObHMv6cAraPkag0=;
        b=TDz9QhZMNb+DpFKyB/udNdi0926HybAer+3uWNx5QCLp6Vy32diRBv3IhT3MlRbayY
         VhQVtvnXrvjhH4yKNDUAIM2ZYO4QgbhcIR4i2QCYP/2x/Nz52EPuB/qvfwXQHpvmb+YZ
         ooVanz5sde3WVqvq7zhFHIzThQOvnCqrAZ/gzReHdH+kA3fnnZksjsT4MMs8bmDok7gR
         mVugZWwb7a6KgA0mdQINwWSNq1fqfc5yCB40/ZiJ+TksTzVU/Hk4oyfNuctzGQjHCHF1
         U3E47gIvifYOmxPqCRI6XPDWPDJ02n7aMaal1jh4BvnGzQXokCe/w9ttZfIw+hZZ5Sul
         x1xg==
X-Gm-Message-State: AC+VfDyg4/jx+YU8UVFE6q+oJSGTOoLVm6e8mi9QpkOiMycDqaTiHJ21
	UmUodZwEmwREqFZ3XPsZWHIn7pIyD1d4fucdMW6FpevF
X-Google-Smtp-Source: ACHHUZ4zNZ+9Qm+7EcCzqaGtQCmcSNrGGfdV+OlpN1N/6gD+LHUIyKuPuCHz1Xgs0BHuOwHk6GxMCQ==
X-Received: by 2002:a17:907:9445:b0:96a:3e7:b588 with SMTP id dl5-20020a170907944500b0096a03e7b588mr24857102ejc.40.1684365302020;
        Wed, 17 May 2023 16:15:02 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id my48-20020a1709065a7000b009664e25c425sm158580ejc.95.2023.05.17.16.15.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 16:15:01 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso217101566b.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:15:00 -0700 (PDT)
X-Received: by 2002:a17:907:c26:b0:966:238a:c93 with SMTP id
 ga38-20020a1709070c2600b00966238a0c93mr38602562ejc.68.1684365300509; Wed, 17
 May 2023 16:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
 <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com> <20230517230054.GA195@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517230054.GA195@W11-BEAU-MD.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 May 2023 16:14:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
Message-ID: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, dthaler@microsoft.com, brauner@kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 4:01=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> Do you mind giving me your Signed-off-by for these?

Assuming you have some test-cases that you've run them through, then yes:

 Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

for both. But since I can't really test them myself, I'd really like
that. I did these patches just by looking at the source code, and
while I think that's an excellent way to do development, I do think
that testing is _also_ required.

And that second patch was obviously not even build-tested, so really
just a "something like this".

> I plan to do a series where I take these patches and then also fix up a
> few comments and the link namings as you suggested.

Sounds good.

> First patch is clean, second patch I made the following changes and
> after that passed all the self-tests without bug splats with
> CONFIG_PROVE_LOCKING/RCU and ATOMIC_SLEEP:

Your suggested version with just "list_add()" and a comment about why
it doesn't need RCU safety looks good. And the build fix obviously
requited ;)

                  Linus

