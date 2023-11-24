Return-Path: <bpf+bounces-15830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C27F8568
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 22:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F772820B5
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4113BB36;
	Fri, 24 Nov 2023 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWDtU42I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9919AB
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 13:20:12 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso30244301fa.3
        for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 13:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700860811; x=1701465611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3iUEvooS6LvoxobsGk/GXAcB8kezGs2AkcikIhMBXs=;
        b=TWDtU42IiiNUEmrKYA2mNf+Zf+kF6ltij6hqaM2VzLtlaR8rNZy1nJmRqDXrG6IZPl
         vsMNGHI3pdEdPSfR1CaABzQW/IvbBLaE+4HHtjTzjiyAYYR+byy4PT7C1uEVw6kPwu8l
         V4oM3o1bn3tM/SF86Z+hEAAkSV+NKjYWvSclIPLMv2MZTMK6ULWZGQ7VUzHfe3gmetsO
         0i7lyi+LgxbiSvLsOyLb2OIuQQJoQxxvo401KX/QmnDlWGK0rjHd20WZJ2gPTeKVPdS+
         zhFq4nFA25T3LT44lAdZpRatEgGReWIMvd5PcErCr4D+ncYJOSicoNHdT7309vyEmgfK
         SiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700860811; x=1701465611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3iUEvooS6LvoxobsGk/GXAcB8kezGs2AkcikIhMBXs=;
        b=AyJSrZMYstfdbi0tokYzAu1BXjGdLfd2td0MbmtLU6EureN0yMjAVeSpmRd3+kFUCW
         fJDOE2z2beRbwmN+A8+5ldNvjx09Y+zZ9xL7gi39dZwbKyTnxso4HX6jbWA+NT2bTMQA
         7u1Pc3BS4lKgl8/L8vNw+fYu7aLwpkDaNBYeRxMBIDgJ+gvIyK3Pt8Lt/vsXo6QAt6/8
         n0qz9qOHHZKwFoXxoP/OMtTYpyhkkJb4sdMKiZjhxFu8dTeNx512oOS4PP+JQkkxVb19
         k7hQke4eUsJ6NorJiiZeDYpNvzSqyhV+V6GCHpIUskFXet2WrHOGj1gmFmGvMLwl8q+V
         6crw==
X-Gm-Message-State: AOJu0Yw4kFkLyqjzkrbxJgq+VN5Hz7AWM5FPEVAyP8SdNnJ6QAjLr/y9
	fx2nv9ygmSeAlIjSz7M33rs=
X-Google-Smtp-Source: AGHT+IEVe2mi7AtJV67UkmYxoVyXy0BMsLM+s2/VIa9tOYWfPdtdMc0BOA2B8ad2lO5t5+c0X81thQ==
X-Received: by 2002:a2e:a41b:0:b0:2bc:b557:cee9 with SMTP id p27-20020a2ea41b000000b002bcb557cee9mr3478796ljn.43.1700860810755;
        Fri, 24 Nov 2023 13:20:10 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id u6-20020a1709064ac600b009ff1bb1d295sm2584803ejt.18.2023.11.24.13.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:20:10 -0800 (PST)
Date: Fri, 24 Nov 2023 22:16:31 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231124211631.ktwsigoafnnbhpyt@erthalion.local>
References: <20231122191816.5572-1-9erthalion6@gmail.com>
 <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>

> On Thu, Nov 23, 2023 at 11:24:34PM -0800, Song Liu wrote:
> > Following the corresponding discussion [1], the reason for that is to
> > avoid tracing progs call cycles without introducing more complex
> > solutions. Relax "no same type" requirement to "no progs that are
> > already an attach target themselves" for the tracing type. In this way
> > only a standalone tracing program (without any other progs attached to
> > it) could be attached to another one, and no cycle could be formed. To
>
> If prog B attached to prog A, and prog C attached to prog B, then we
> detach B. At this point, can we re-attach B to A?

Nope, with the proposed changes it still wouldn't be possible to
reattach B to A (if we're talking about tracing progs of course),
because this time B is an attachment target on its own.

> > +       if (tgt_prog) {
> > +               /* Bookkeeping for managing the prog attachment chain. */
> > +               tgt_prog->aux->follower_cnt++;
> > +               prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
> > +       }
> > +
>
> attach_depth is calculated at attach time, so...
>
> >                 struct bpf_prog_aux *aux = tgt_prog->aux;
> >
> > +               if (aux->attach_depth >= 32) {
> > +                       bpf_log(log, "Target program attach depth is %d. Too large\n",
> > +                                       aux->attach_depth);
> > +                       return -EINVAL;
> > +               }
> > +
>
> (continue from above) attach_depth is always 0 at program load time, no?

Right, it's going to be always 0 for the just loaded program -- but here
in verifier we check attach_depth of the target program, which is
calculated at some point before. Or were you asking about something else?

