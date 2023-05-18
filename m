Return-Path: <bpf+bounces-838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3947076E3
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71DC1C20FF4
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 00:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03693198;
	Thu, 18 May 2023 00:23:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8650160
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 00:23:38 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C7E8
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:23:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so2203387a12.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684369415; x=1686961415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT8xYYCjH6ggOvHhW6+9I5mhGuzNhDu/1pBE5VbcuBw=;
        b=INQ4ISvc/du1t93TevcwNUnl1FdGbLPaut0dYlmHtAFewyWsiD2G8ntDEYWxo6+wbl
         LBjopCMy6cL9RCR4oBDwt5vOu9JpFTsFjhDDUOUbhvHjjI9fCHkwVCJ1m/vLpyBblPnN
         LCqRCJ8rIy1fAhcSPvQ4GnHuyEVc0Nxpteazc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369415; x=1686961415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT8xYYCjH6ggOvHhW6+9I5mhGuzNhDu/1pBE5VbcuBw=;
        b=edDMPSDqadD4PdM5KNhMUpUDgveuW4xvWCy6u8Hq1MyxI81rV3sc0yqX5+Ih+5mp8Q
         skVywGNwQ0LiuRN0c749w0S21ddKxPiQV/k9hr9335X6E/k41u1y53+N7ROTrAxk9vbo
         giYxP1QMQDhLuu6tJhNX7as/7ss9qmEG+f061yTekU5Vum//It7Kl56ysDZgFhNtlSOH
         qLQgy5EXY3yLU68xhzZGk/AyQoU1hIdCCmwIHn7Ub45RZkRmcx6YZMu60heXwHlVVt0R
         8FB64obethy5//lWB0jfk7bpPs2uboVTzbLiqPvOLQhn+VzcMh3RN2hmrTt0pc3rG3L0
         Fk2g==
X-Gm-Message-State: AC+VfDyoZvANyeAfrAu+W4h7SbDSIwubV2kqiuuxlwezViljvHmqrkKB
	NMvLNwNoXxecdtc2LWhC77191VWNiMoXWzKnbdT9v+TW
X-Google-Smtp-Source: ACHHUZ5EfnGlwrHZUHtzcnAKBWWs1JPk7ZsxorOd9AHFU9a66jS2T4Gi3CoChiXc9vBv+U12p6wVkA==
X-Received: by 2002:a17:906:eec5:b0:94b:cd7c:59f4 with SMTP id wu5-20020a170906eec500b0094bcd7c59f4mr35013767ejb.16.1684369415610;
        Wed, 17 May 2023 17:23:35 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090606d000b00966330021e9sm219274ejb.47.2023.05.17.17.23.34
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:23:34 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-965c3f9af2aso214564566b.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:23:34 -0700 (PDT)
X-Received: by 2002:a17:907:7dab:b0:967:a127:7e79 with SMTP id
 oz43-20020a1709077dab00b00967a1277e79mr31504240ejc.28.1684369414251; Wed, 17
 May 2023 17:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
 <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
 <20230517230054.GA195@W11-BEAU-MD.localdomain> <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
 <20230517192528.043adc7a@gandalf.local.home> <20230518001422.GA254@W11-BEAU-MD.localdomain>
In-Reply-To: <20230518001422.GA254@W11-BEAU-MD.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 May 2023 17:23:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU0vq8aL_VmUDqwh9_fo8nXYt65PBjihNetTMq4s8OsA@mail.gmail.com>
Message-ID: <CAHk-=wjU0vq8aL_VmUDqwh9_fo8nXYt65PBjihNetTMq4s8OsA@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 5:14=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> Do you run with CONFIG_DEBUG_ATOMIC_SLEEP? It will not splat with just
> CONFIG_PROVE_LOCKING and CONFIG_PROVE_RCU, which bit me here. I'm now
> running all three now that I know better.

I wonder if we should just make PROVE_LOCKING select DEBUG_ATOMIC_SLEEP..

PROVE_LOCKING is the expensive and complicated one. In contrast,
DEBUG_ATOMIC_SLEEP is the "we've had this simplistic check for some
very basic requirements for a long time".

So DEBUG_ATOMIC_SLEEP is really just a minimal debugging thing, it
feels a bit silly to have all the expensive "prove locking with
lockdep and all our lock debugging", and then not test the trivial
basics.

           Linus

