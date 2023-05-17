Return-Path: <bpf+bounces-694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F4705DAD
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DD0280C53
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F68417F3;
	Wed, 17 May 2023 03:03:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57817D0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:03:35 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB48A5252
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 20:03:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965e4be7541so32510166b.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684292608; x=1686884608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQC84bjg5veEkaq5Nnh/MZ6+IOv+WPa/0t9irvzCFqA=;
        b=gj4J4tXNFizhNQB/HoengzmVIQXJSFw4abMjN/yA0HJfTXudNTk3BX/b7D2efAx9ZJ
         Gdaz4BmOqUYa/csf1ugtVdGcRRFUI/kSpTe7Caq0rwhwBhzRG0vIjMA09uEaDIvx7j2h
         pBR5EEvj8SHJoQGU9cKoodwuUaxVvRy7vby6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292608; x=1686884608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQC84bjg5veEkaq5Nnh/MZ6+IOv+WPa/0t9irvzCFqA=;
        b=WB9Vx5UGU913DCwvRA3QIdNNx78iOF31KwULwj0ZaraC2B0atP5Ow6hbRZWjQIl+iI
         tVOnH4kGH2HJZ2nXE8TC8O0xCmJc9ATsAnhywFmCLT1v5quza/dJsZYVG16hAnRsbQTA
         /tElwBdNRMdnBM2Kmlv9PKUDAG/tf+hvzVHJKIg0jKBRQw0hp9qsAQZOtVqg9TJCQLO4
         Kh3ecKe4OK/bOGS74G6gaqNkeWa4Gk39YoAPUb+tJ2kth1YkYtqfv05pXiZofFw/5i/n
         PpZTrhwAh/POT19501xylNtV1Xe4TfQpfKJgRifJ5cRKFgwwvaGQEceJgvYBVmYAjzy8
         2djw==
X-Gm-Message-State: AC+VfDxia64qKHsQiRHbrzI9My2NOs02BPRJ9ER7MrZyiT+4xGpT4Pkx
	+CJTH6todOmTWRuAA2gbFsiS/qh5+ZxY4u2CMShJu9Zd
X-Google-Smtp-Source: ACHHUZ7UWvQibDg8vXgGwWx3zNGUiSoMdWr4c8BJHbmt/PlajvMN00FYn63P7v/tnq/gcMwxtmBx2A==
X-Received: by 2002:a17:907:360a:b0:960:7643:c973 with SMTP id bk10-20020a170907360a00b009607643c973mr33860506ejc.66.1684292607932;
        Tue, 16 May 2023 20:03:27 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ia21-20020a170907a07500b00966392de4easm11819711ejc.14.2023.05.16.20.03.26
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 20:03:27 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-965e4be7541so32506666b.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 20:03:26 -0700 (PDT)
X-Received: by 2002:a17:907:6d15:b0:96a:bfc:7335 with SMTP id
 sa21-20020a1709076d1500b0096a0bfc7335mr23923089ejc.53.1684292606486; Tue, 16
 May 2023 20:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com> <20230516222919.79bba667@rorschach.local.home>
In-Reply-To: <20230516222919.79bba667@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 May 2023 20:03:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
Message-ID: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
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

On Tue, May 16, 2023 at 7:29=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> So this code path is very much in user context (called directly by a
> write system call). The issue that Alexei had was that it's also in an
> rcu_read_lock() section.
>
> I wonder if this all goes away if we switch to SRCU?

Yes, SRCU context would work.

That said, how critical is this code? Because honestly, the *sanest*
thing to do is to just hold the lock that actually protects the list,
not try to walk the list in any RCU mode.

And as far as I can tell, that's the 'event_mutex', which is already held.

RCU walking of a list is only meaningful when the walk doesn't need
the lock that guarantees the list integrity.

But *modification* of a RCU-protected list still requires locking, and
from a very cursory look, it really looks like 'event_mutex' is
already the lock that protects the list.

So the whole use of RCU during the list walking there in
user_event_enabler_update() _seems_ pointless. You hold event_mutex -
user_event_enabler_write() that is called in the loop already has a
lockdep assert to that effect.

So what is it that could even race and change the list that is the
cause of that rcu-ness?

Other code in that file happily just does

        mutex_lock(&event_mutex);

        list_for_each_entry_safe(enabler, next, &mm->enablers, link)

with no RCU anywhere. Why does user_event_enabler_update() not do that?

Oh, and even those other loops are a bit strange. Why do they use the
"_safe" variant, even when they just traverse the list without
changing it? Look at user_event_enabler_exists(), for example.

I must really be missing something. That code is confusing. Or I am
very confused.

            Linus

