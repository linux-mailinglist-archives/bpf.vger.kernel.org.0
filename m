Return-Path: <bpf+bounces-4301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B63174A4FE
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5698728137A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C90BA4D;
	Thu,  6 Jul 2023 20:37:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E982FB6
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:37:32 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA0C1BEC;
	Thu,  6 Jul 2023 13:37:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so13028635e9.2;
        Thu, 06 Jul 2023 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688675845; x=1691267845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1y6sY5IL8maEPoxcUQbDNd92JJk/UyiG7RcS1SJQq0=;
        b=Uh+McG/W+U0T9IGDuAa4rPGT64F/5QUD+NE6G4jUXdHusmmTL6T6PUvZqKatx7qBtC
         OsJngx5UhUCm9b8EqtzElqLBOZiT6gO0EE4X7767wIu5RccybZN3uCAtmIiBzOYG6XqT
         3Z2JNdRaN2kVUdNUJP7WaoLylOUbxwJza1HQpFdHK+GrUG2qF5A+3/xcbtfvqIDVZwy3
         K7DC1F5TTD+wvAaTcPUCNwx8YaecAR5Hd0bTfSEZPJQFoEyMPP8u9lzBatVF+0VxhL5L
         LbVwaM/L2AdU7A5lHQVQQHb/DY0VKBidNzW6iHVdY00kz4EIz5vJ7dqsXHqeLU/EadjG
         YW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688675845; x=1691267845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1y6sY5IL8maEPoxcUQbDNd92JJk/UyiG7RcS1SJQq0=;
        b=OaMip39ycph4XFq4E4LKQgSJ3DLhypYURRbBZt+aEwrQaJS7XO+j52XoW0oRF5Jibk
         nd/iDIeX+2LpttBZXpDKpV9VW5t43PopgXetc9TJ4p1axFD3F89E963jhuMGKUtDpoR8
         T+0D9wWNg+4faUsLUoPEhpvmaxVqDPalHr89D8wgcyFVOIctw+UpCXrwWiZabhq+Bh9L
         oJ/MNxl/gyY9MOqz5O2ovzyomZJVOhPRv78T7+O3/QTi8A1Xjq0lOcmx7vC2OY7EdAKG
         ZXMgx6B4aJinuT48IYEhBz+CTWw3tHzq7DafAY/4wVpOSHvnQXDe5vQSzHk4HbbQ2vNG
         v/SA==
X-Gm-Message-State: ABy/qLbph6TKm6d8XigVUOtBzUuf+TNyIPi31rAgzG2DYlV29icCTXKO
	z1LP6duT+XOevgMMGog5HOIcND1ZaXpD5JIM0bWJbzwaKgE=
X-Google-Smtp-Source: APBJJlHcMtXunkOCHa18bnHOevY//NNCKi671JX/ijMKtfkXBEzgvN6TlUmJ5uydB6gV7RM3GwZMnQAXsttM7Ivb/Y8=
X-Received: by 2002:a7b:c7d9:0:b0:3f5:146a:c79d with SMTP id
 z25-20020a7bc7d9000000b003f5146ac79dmr2190125wmk.15.1688675845148; Thu, 06
 Jul 2023 13:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner> <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner> <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
 <87a5w9s2at.fsf@toke.dk>
In-Reply-To: <87a5w9s2at.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 13:37:13 -0700
Message-ID: <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 4:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > Having it as a separate single-purpose FS seems cleaner, because we
> > have use cases where we'd have one BPF FS instance created for a
> > container by our container manager, and then exposing a few separate
> > tokens with different sets of allowed functionality. E.g., one for
> > main intended workload, another for some BPF-based observability
> > tools, maybe yet another for more heavy-weight tools like bpftrace for
> > extra debugging. In the debugging case our container infrastructure
> > will be "evacuating" any other workloads on the same host to avoid
> > unnecessary consequences. The point is to not disturb
> > workload-under-human-debugging as much as possible, so we'd like to
> > keep userns intact, which is why mounting extra (more permissive) BPF
> > token inside already running containers is an important consideration.
>
> This example (as well as Yafang's in the sibling subthread) makes it
> even more apparent to me that it would be better with a model where the
> userspace policy daemon can just make decisions on each call directly,
> instead of mucking about with different tokens with different embedded
> permissions. Why not go that route (see my other reply for details on
> what I mean)?

I don't know how you arrived at this conclusion, but we've debated BPF
proxying and separate service at length, there is no point in going on
another round here. Per-call decisions can be achieved nicely by
employing BPF LSM in a restrictive manner on top of BPF token (or no
token, if you are ok without user namespaces).

>
> -Toke
>

