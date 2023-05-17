Return-Path: <bpf+bounces-823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC987072BD
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABAB28127F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0F9449A7;
	Wed, 17 May 2023 20:09:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9B111AD
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 20:09:21 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B489E6A62
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 13:09:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso189810166b.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684354157; x=1686946157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUJuL+2WvYBnwuI2AxMqbxeUZxgtHjH0G/Zm8si7raQ=;
        b=FswP8g2FI3659/s/93gVCGsv3xZZtGIZfyfW2LeNfXS8vk7ZVBjKBV5EubqxsPWC4B
         DTiSzYAVTqlLfpqatXRUYC2ud7ZZO/vsf5e6eQGX32M+kzCJw+W5bHv1BObk06wK2Nh+
         YyCLeqhvFzPSmMK/EQYkoCJ95VGK9AkRl/KJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354157; x=1686946157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUJuL+2WvYBnwuI2AxMqbxeUZxgtHjH0G/Zm8si7raQ=;
        b=W0v0zgjLS74jfMBFj2/ewZIv4o8WjPiNf8RoIzxD2wdu1MLc7Sgm4nvhZhBQkVHc5A
         pmZ5fnywfzkcVFDwioqfdE21BZnMltyqDrRFuqrFB2Wgndhs35qs7EERKH05MvPC6p3R
         S0km2ga3554gzfTNdkZaZTMdxCZ1e5eb86e1/MsKtSbqL9f84NnasYbMKUwXQQKeOgzx
         yBOoo+iHQ20LmvzTOruRI0EcMq4SNPHoCGXeLVfdnPskpH1VnCeOgap5PP51BJ80ozfF
         bzsAnNKcVZ61xcLqEJQg+5yeW0V2SXayaj1qwCK0TPlKJy35iwls/b4ozHb98bwtoNOP
         EC0A==
X-Gm-Message-State: AC+VfDxkmqiS6UUJYnnqyoYguPRoc1MUIL+SJETVB369ZtPD0xGc63Fu
	iBPRsTArLWmxHr4pDHylhy/dsaC2vWJlpuywIUlPkRFF
X-Google-Smtp-Source: ACHHUZ6WX+4lp4pWvIt4hOORZYn0icLYnMlqOZJOrFhgmcvei4tkLGQOTdqYwVNaLHQvz/bzpvjhIQ==
X-Received: by 2002:a17:907:1c23:b0:966:2984:3da0 with SMTP id nc35-20020a1709071c2300b0096629843da0mr38882879ejc.63.1684354156861;
        Wed, 17 May 2023 13:09:16 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id n1-20020a170906378100b0096a74be3dd4sm9210478ejc.60.2023.05.17.13.09.16
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:09:16 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso189806066b.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 13:09:16 -0700 (PDT)
X-Received: by 2002:a17:907:7291:b0:96a:717:d452 with SMTP id
 dt17-20020a170907729100b0096a0717d452mr29868922ejc.19.1684354155799; Wed, 17
 May 2023 13:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
In-Reply-To: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 May 2023 13:08:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com>
Message-ID: <CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com>
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

On Wed, May 17, 2023 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. this is the patch that I think should go on top of it to fix the
> misleading "safe" and the incorrect RCU walk.
>
> NOTE! This adds that
>
>         lockdep_assert_held(&event_mutex);
>
> to user_event_enabler_update() too.

One more note: I think it would be really good to use different names
for the "links".

We have "mm->link", that is the list of mm's on the 'user_event_mms'
list, protected by the 'user_event_mms_lock' and RCU-walked.

And then we have 'enabler->link', which is the list of enables on the
'user_mm->enablers' list, protected by event_mutex, and _also_
occasionally RCU-walked.

And then we have 'validator->link', which isn't RCU-walked, and seems
to also be protected by the event_mutex (?).

This is all very confusing when looking at it as an outsider.
Particularly when you sometimes just see

        list_del_rcu(&mm->link);

and you have to figure "which 'link' are we talking about again?".

Also, I have to say, I found "mm->next" *really* confusing at first.

It turns out that "mm->next" is this list that is dynamically built up
by user_event_mm_get_all(), and is only a one-shot list that is valid
only as long as 'event_mutex' is held. But the only lock the code
*talks* about is the RCU lock, which does *not* protect that list, and
only exists as a way to walk that user_event_mms list without taking
any locks.

So user_event_enabler_update() actually relies on that 'event_mutex'
lock in another way than the obvious one that is about the
mm->enablers list that it *also* walks.

Again, that all seems to work, but it's *really* confusing how
"mm->next" always exists as a field, but is only usable and valid
while you hold that event_mutex and have called
user_event_mm_get_all() to gather the list.

I think both user_event_enabler_update() and user_event_mm_get_all()
should have a mention of how they require event_mutex and how that
->next list works.

Anyway, I still *think* the two patches I sent out are right, but I'm
just mentioning this confusion I had to deal with when trying to
decode what the rules were. Maybe all the above is obvious to
everybody else, but it took me a while to decipher (and maybe I
misread something).

             Linus

