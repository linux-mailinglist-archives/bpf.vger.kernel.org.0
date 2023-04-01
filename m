Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB326D3344
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 20:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDAS5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAS5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 14:57:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E133B768
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 11:57:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so102426621edb.4
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680375458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My4yZEK4wuSxu8Jk+/UqTrS9THhHNLMaLTOPMBmPHqs=;
        b=GaBK0ipbYbTo2UODUiseCzN3dZs+3tDP4in+noPZSkfsaFTSdo+nJfi8p5Ky/BwsFU
         ZdlBb6628F9KP5b5s5QAI7D3CPzeJLFF3+8GDnRY4P++w79E6jPS3LY42EDdPRDePRs1
         cRPiANpA3BihTHm5XGm9my5b0TWejO0LZL54FKt7AhN7d015pRmKQvS6KviQPYSe642y
         6e58+NqvGF8OUdugPIFWjQSyuhw7yO8n14J4OHqaN507lZMBQOK3si9RyKHqjj4GlAf6
         dehbhrPjTyStvfPtuSfAXoO52vGZTqi/67Y3o3Z+EsCX9DB1j3v/42W2gEJnMdLGeMDZ
         aJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=My4yZEK4wuSxu8Jk+/UqTrS9THhHNLMaLTOPMBmPHqs=;
        b=N7jCIjpKCRpkx6TPgRESxYQoOJ322903oz5Z66D/1bo/4RQGW9p/LsjpKzWhWmJJul
         UbWjDGXmTAju8yjJvK0iMlbHqHXVQNp6HTx/WkIvm/Qa0W0vUdLfHDpt8+jhRAVIGxYY
         vvZHUqShB1uLLttv35sjhbVRij1OZRtzB7DPJ0DvrCTG+AW7SG1r+JJjuVpK47WsRI2y
         Becpt02I11wK4Uit9+EumeQZuB5dmIS4f8U4MWOh+GOVTF9kIY+yxxBxmWCEkGUS9n5V
         2/W5fN0iT/0P/tbNFQCfQTmcETWGCVOrdlxl42x2aN4jMEz9PwgcilbqxtFBKLnjGnxX
         IUhw==
X-Gm-Message-State: AAQBX9fopjKrGawHv1cqDT+hAs2a9yqCmFXx/tuXnN3YEe4vf87P4/dU
        NW7hHicSzg36znUrRIaE7ks05IB3h9v3UkowvlUfO7ptu8ad6+pumAA=
X-Google-Smtp-Source: AKy350b3LmD0KkPjiYnMBe3RHbw0DtmKzlEMl4bSIZQXjD0jCkkJeHk9EyuSRLHgBEfVWswN2fd0AZJYhep6qCdGosQ=
X-Received: by 2002:a50:a444:0:b0:502:4f7:d286 with SMTP id
 v4-20020a50a444000000b0050204f7d286mr15086280edb.4.1680375458506; Sat, 01 Apr
 2023 11:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230312190600.324573-1-joe@isovalent.com> <c6172fe2-7d88-f9f8-e19a-47c232f9cb75@linux.dev>
 <CADa=RyxDHp5x0iCcfgiCDuM68we=dTAmVBvx1hgrRLBbN27rdw@mail.gmail.com> <f015a098-1e17-b503-a098-b3d1adbe4ce8@linux.dev>
In-Reply-To: <f015a098-1e17-b503-a098-b3d1adbe4ce8@linux.dev>
From:   Joe Stringer <joe@isovalent.com>
Date:   Sat, 1 Apr 2023 11:57:27 -0700
Message-ID: <CADa=RywTEdbTdHHi=Qh6MRrHRUDUKZfPGU---Ea+-RF7+t+o+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and graph
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, bagasdotme@gmail.com,
        maxtram95@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 11:05=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 3/15/23 6:54 PM, Joe Stringer wrote:
> > On Tue, Mar 14, 2023 at 12:31=E2=80=AFPM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> Maybe a note somewhere to mention why it will still fail to
> >> shrink the list because the htab_lock_bucket() have detected potential
> >> deadlock/recursion which is a very unlikely case.
> >
> > I missed the "shrink the list" link here since it seems like this
> > could happen for any combination of update or delete elems for the
> > same bucket. But yeah given that also needs to happen on the same CPU,
> > it does seem very unlikely...
>
> shrink should try to shrink a couple of stale elems which are likely hash=
ed to
> different buckets. If shrink hits htab_lock_bucket() EBUSY on all stale e=
lems,
> shrink could fail but unlikely.

The failure case I had in mind for this is to assume that shrinking
succeeds and we find an LRU node during the htab_map_update_elem()
call through prealloc_lru_pop(), but then immediately afterwards it
makes a direct htab_lock_bucket() call which has just one chance to
succeed based on whether this CPU races against some other user of the
bucket lock. Still seems somewhat rare, but feasible to hit.

> > Could there be a case something like "userspace process is touching tha=
t bucket,
> > gets interrupted, then the same CPU runs an eBPF program that attempts =
to
> > update/delete elements in the same bucket"?
>
> raw_spin_lock_irqsave() is done after the percpu counter, so there is a g=
ap but
> not sure if it matters though unless the production use case can really h=
it it.

Yeah unfortunately I'm going off an incident from last year and I
don't have this level of visibility into the failure scenario in a
prod-like environment today.
