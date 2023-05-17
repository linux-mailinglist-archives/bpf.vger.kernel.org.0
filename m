Return-Path: <bpf+bounces-814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735270708C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011EB1C20EFA
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E7231F01;
	Wed, 17 May 2023 18:15:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAD10966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 18:15:38 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E883F3
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:15:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so2020208a12.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684347333; x=1686939333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glKf7NIJxMjvHArJbyFniLngVqkquHliX4T2ECqtZCU=;
        b=cYfzgsSW1eAL0mcxFzcFEGVKiKhkmtJW2V5Bn8D9TKCTdWnP8YMHoqvHHyUmLhNLZQ
         qjqngIFqiAXhlgkoJqdb5JkZr6fW7vDx8Jt32RAYmGXcCUaLzFcRx66QXuHZMv1B/NGS
         z0NFZBSQMtvdSXWji9N4a3iDY8hTZ6unme+Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347333; x=1686939333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glKf7NIJxMjvHArJbyFniLngVqkquHliX4T2ECqtZCU=;
        b=j976biu/V34oHXRieIdziQoZ/v/aYPGhkqdpq0cyjhYv9B+gjpsiV8gHWSCD5u7x5a
         i6Va2VCg/zX12enSM9dkTGOosU9bd+SiWyFh+XKyuudr1+PfNvJO0FZ/euvfD29J1k9f
         S2KqW4hrrYlHS1KFWMo5tDGSQqhE2yJHPUWuZXcn3XrLGxIyU0M2vr2b2ZB62072tB6x
         e3TWPEui/dpkVsSARqupXEBMULXpNXQ6PIdWP5voptYPFrQqxeKOeLCQ+Wrt/E09HsZt
         j3Ss9pDaUimxDA4IGTV3CmSAux6XdNuRJ4wSdCQI0mV6/9d7omx2SiFo9220ndxKN4aB
         NFkQ==
X-Gm-Message-State: AC+VfDxIA+ao/VJ+SxwqsTvry5c+7CPNseSL1wPWyjcU2BqomCP21k63
	Clww49PRABDqautklJLWjNBQ7JSAr6dDX4HB+xsifb4b
X-Google-Smtp-Source: ACHHUZ6d5ovz5zY+rzKfaAwGSUoVgp25Vz78aB1+dWqfOzK0aY9817aJxrkqeWVC9VLMZBsxLec3kA==
X-Received: by 2002:a50:ef04:0:b0:510:47a3:e775 with SMTP id m4-20020a50ef04000000b0051047a3e775mr2883439eds.41.1684347333648;
        Wed, 17 May 2023 11:15:33 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id y15-20020a50e60f000000b0050bc27a4967sm9536634edm.21.2023.05.17.11.15.32
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:15:32 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-510b7b6ef59so2004046a12.3
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:15:32 -0700 (PDT)
X-Received: by 2002:a17:906:dacb:b0:966:53b1:b32a with SMTP id
 xi11-20020a170906dacb00b0096653b1b32amr31032871ejb.53.1684347331694; Wed, 17
 May 2023 11:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517172243.GA152@W11-BEAU-MD.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 May 2023 11:15:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
Message-ID: <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
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

On Wed, May 17, 2023 at 10:22=E2=80=AFAM Beau Belgrave
<beaub@linux.microsoft.com> wrote:
>
> On Tue, May 16, 2023 at 08:03:09PM -0700, Linus Torvalds wrote:
> > So what is it that could even race and change the list that is the
> > cause of that rcu-ness?
>
> Processes that fork() with previous user_events need to be duplicated.

BS.

Really. Stop making stuff up.

The above statement is clearly not true - just LOOK AT THE CODE.

Here's the loop in question:

                list_for_each_entry_rcu(enabler, &mm->enablers, link) {
                        if (enabler->event =3D=3D user) {
                                attempt =3D 0;
                                user_event_enabler_write(mm, enabler,
true, &attempt);
                        }
                }

and AT THE VERY TOP OF user_event_enabler_write() we have this:

        lockdep_assert_held(&event_mutex);

so either nobody has ever tested this code with lockdep enabled, or we
hold that lock.

And if nobody has ever tested the code, then it's broken anyway. That
code N#EEDS the mutex lock. It needs to stop thinking it's RCU-safe,
when it clearly isn't.

So I ask again: why is that code using RCU list traversal, when it
already holds the lock that makes the RCU'ness COMPLETELY POINTLESS.

And again, that pointless RCU locking around this all seems to be the
*only* reason for all these issues with pin_user_pages_remote().

So I claim that this code is garbage.  Somebody didn't think about locking.

Now, it's true that during fork, we have *another* RCU loop, but that
one is harmless: that's not the one that does all this page pinning.

Now, that one *does* do

        list_add_rcu(&enabler->link, &mm->enablers);

without actually holding any locks, but in this case 'mm' is a newly
allocated private thing of a task that hasn't even been exposed to the
world yet, so nobody should be able to even see it. So that code lacks
the proper locking for the new list, but it does so because there is
nothing that can race with the new list (and the old list is
read-only, so RCU traversal of the old list works).

So that "list_add_rcu()" there could probably be just a "list_add()",
with a comment saying "this is new, nobody can see it".

And if something *can* race it it and can see the new list, then it
had damn well needs that mutex lock anyway, because that "something"
could be actually modifying it. But that's separate from the page
pinning situation.

So again, I claim that the RCU'ness of the pin_user_pages part is
broken and should simply not exist.

> > Other code in that file happily just does
> >
> >         mutex_lock(&event_mutex);
> >
> >         list_for_each_entry_safe(enabler, next, &mm->enablers, link)
> >
> > with no RCU anywhere. Why does user_event_enabler_update() not do that?
>
> This is due to the fork() case above without taking the event_mutex.

See above. Your thinking is confused, and the code is broken.

If somebody can see the new list while it is created during fork(),
then you need the event_mutex to protect the creation of it.

And if nobody can see it, then you don't need any RCU protection against it=
.

Those are the two choices. You can't have it both ways.

> > Oh, and even those other loops are a bit strange. Why do they use the
> > "_safe" variant, even when they just traverse the list without
> > changing it? Look at user_event_enabler_exists(), for example.
>
> The other places in the code that do this either will remove the event
> depending on the situation during the for_each, or they only hold the
> register lock and don't hold the event_mutex.

So?

That "safe" variant doesn't imply any locking. It does *not* protect
against events being removed. It *purely* protects against the loop
itself removing entries.

So this code:

        list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
                if (enabler->addr =3D=3D uaddr &&
                    (enabler->values & ENABLE_VAL_BIT_MASK) =3D=3D bit)
                        return true;
        }

is simply nonsensical. There is no reason for the "safe". It does not
make anything safer.

The above loop is only safe under the mutex (it would need to be the
"rcu" variant to be safe to traverse without locking), and since it
isn't modifying the list, there's no reason for the safe.

End result: the "safe" part is simply wrong.

If the intention is "rcu" because of lack of locking, then the code needs t=
o
 (a) get the rcu read lock
 (b) use the _rcu variant of the list traversal

And if the intention is that it's done under the proper 'event_mutex'
lock, then the "safe" part should simply be dropped.

               Linus

