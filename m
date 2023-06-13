Return-Path: <bpf+bounces-2547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CED72EE35
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 23:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5293C1C20A61
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 21:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FB3ED83;
	Tue, 13 Jun 2023 21:43:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E553D385
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 21:43:28 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8B1BC6
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 14:43:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bacf685150cso34282276.3
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686692606; x=1689284606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIVGrn2UG3gN2eNILh7fTseSDqg8knsp5sSLFqLEHtc=;
        b=K82SWrC47y9svWfAJiRRS8RkXj5CtpYx2+cpvsF8vlQJOJBv9VTnZ/ZF406SGPZ/cQ
         PuKnDklPjxR7CmsSTOtn3AHyoXAGnmO/yy0LFY35Wb/B3eU/8Qys5akTlIzlzgwWVy7f
         LQ065Qd5k7eJtxGashEd4kJePL0vdixSMONX+InuGwDAe+n8dheiF7DLw+Nj9ydyMTrw
         3hjMGnZr4qSfAoCERrgD36BGE654El3yt5+Md/NncaJLvnpXvcoWAxZ3pC7HjnPP43ta
         043I7yLomJuEy6DomEryzFx3yuLAH4Wop1Gi3yGa4187w96gbNywecR8xGewSdy6Bi3S
         +y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686692606; x=1689284606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIVGrn2UG3gN2eNILh7fTseSDqg8knsp5sSLFqLEHtc=;
        b=doUWr3tS4+di4AktA39HQhMovUFvqCu0JzDlkRSPVpYLc13irR299kXsORM3HafJ5U
         dBXF5Himu9wLSOBUzx8jYcMtpfSvY0b0ra7BuyHpUDlnCZfMVRP2ymgwPN3ySEhqXQa0
         4fHgC1I304TK5zTkEJ8ADjaobKTziQw7NiIAMk/BPzsu+IdUrkGFdKRFfT50emgumXNG
         Hr3fWUEaljJ4q5XZuF1zbRzUjX85G5aYGw7U/jJ6YDRMOa9wlQnrAMrJgrtaZ/mzbzqB
         h1OOGj3OA58UujPJcIsad434uaXIKqsbhW6HSVX04AhOvem6EE0Mw4DnEfYccPI9hW5H
         fF2Q==
X-Gm-Message-State: AC+VfDzJM43IPbeinGYYgHeRHpQoOXn4QfoOa6liTn6IszZ6rhKfju6e
	H3wi3nDz9dLqiXMjkv3eMoraxyMLDzhQINsQfjt2
X-Google-Smtp-Source: ACHHUZ48EzshYzKiXjopsdVfpagGQ7YaGMsS2CpO7ZtH3eZvHC8m7Pi+Jaw59xQX7oHZqQPBowjQ8wJAabBg1EOOml0=
X-Received: by 2002:a25:add3:0:b0:ba5:ee5a:f41c with SMTP id
 d19-20020a25add3000000b00ba5ee5af41cmr380926ybe.1.1686692605945; Tue, 13 Jun
 2023 14:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com> <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com> <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
 <63e14c10.170a0220.beb2a.bc4c@mx.google.com> <CACYkzJ4LX6Acxs0s-d2+hC0Zfx2CTL7_JpeWD9pGz4b9_0J29g@mail.gmail.com>
In-Reply-To: <CACYkzJ4LX6Acxs0s-d2+hC0Zfx2CTL7_JpeWD9pGz4b9_0J29g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jun 2023 17:43:15 -0400
Message-ID: <CAHC9VhTQ_x=MccVU9gtndy3tW-SOdXpQoOa1RTd0jr4_iO1xZQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	jackmanb@google.com, renauld@google.com, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 10:48=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Mon, Feb 6, 2023 at 7:51=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
> > On Mon, Feb 06, 2023 at 07:41:04PM +0100, KP Singh wrote:
> > > On Mon, Feb 6, 2023 at 7:29 PM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
> > > >
> > > > On 2/6/2023 9:48 AM, Song Liu wrote:
> > > > > On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> > > > >> On 2/6/2023 5:04 AM, KP Singh wrote:
> > > > >>> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.or=
g> wrote:
> > > > >>>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> > > > >>>>> The indirect calls are not really needed as one knows the add=
resses of
> > > > >>> [...]
> > > > >>>
> > > > >>>>> +/*
> > > > >>>>> + * Define static calls and static keys for each LSM hook.
> > > > >>>>> + */
> > > > >>>>> +
> > > > >>>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)         =
         \
> > > > >>>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),    =
         \
> > > > >>>>> +                             *((RET(*)(__VA_ARGS__))NULL)); =
         \
> > > > >>>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME,=
 NUM));
> > > > >>>> Hm, another place where we would benefit from having separated=
 logic for
> > > > >>>> "is it built?" and "is it enabled by default?" and we could us=
e
> > > > >>>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we nee=
d to use
> > > > >>>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> > > > >>>> out-of-line? (i.e. the default compiled state will be NOPs?) I=
f we're
> > > > >>>> trying to optimize for having LSMs, I think we should default =
to inline
> > > > >>>> calls. (The machine code in the commit log seems to indicate t=
hat they
> > > > >>>> are out of line -- it uses jumps.)
> > > > >>>>
> > > > >>> I should have added it in the commit description, actually we a=
re
> > > > >>> optimizing for "hot paths are less likely to have LSM hooks ena=
bled"
> > > > >>> (eg. socket_sendmsg).
> > > > >> How did you come to that conclusion? Where is there a correlatio=
n between
> > > > >> "hot path" and "less likely to be enabled"?
> > > > > I could echo KP's reasoning here. AFAICT, the correlation is that=
 LSMs on
> > > > > hot path will give more performance overhead. In our use cases (M=
eta),
> > > > > we are very careful with "small" performance hits. 0.25% is signi=
ficant
> > > > > overhead; 1% overhead will not fly without very good reasons (Do =
we
> > > > > have to do this? Are there any other alternatives?). If it is pos=
sible to
> > > > > achieve similar security on a different hook, we will not enable =
the hook on
> > > > > the hot path. For example, we may not enable socket_sendmsg, but =
try
> > > > > to disallow opening such sockets instead.
> > > >
> > > > I'm not asking about BPF. I'm asking about the impact on other LSMs=
.
> > > > If you're talking strictly about BPF you need to say that. I'm all =
for
> > > > performance improvement. But as I've said before, it should be for =
all
> > > > the security modules, not just BPF.
> > >
> > > It's a trade off that will work differently for different LSMs and
> > > distros (based on the LSM they chose) and this the config option. I
> > > even suggested this be behind CONFIG_EXPERT (which is basically says
> > > this:
> > >
> > >  "This option allows certain base kernel options and settings
> > >  to be disabled or tweaked. This is for specialized
> > >  environments which can tolerate a "non-standard" kernel.
> > >  Only use this if you really know what you are doing."
> >
> > Using the DEFINE_STATIC_KEY_MAYBE() and static_branch_maybe() macros
> > tied to a new CONFIG seems like it can give us a reasonable knob for
> > in-line vs out-of-line calls.
>
> Coming back to this after a while as I finally got time to work on
> this. (work/personal downtime).
>
> I am changing it to DEFINE_STATIC_KEY_TRUE in this patch and
> DEFINE_STATIC_KEY_MAYBE in a subsequent one and guarded by a config
> called CONFIG_SECURITY_HOOK_LIKELY. I am letting it default to yes,
> but distros can change it depending on their choice of LSM and
> performance characteristics.

I'm still more curious about the correctness/isolation aspect that I
mused about back in Jan/Feb on your original posting.

--=20
paul-moore.com

