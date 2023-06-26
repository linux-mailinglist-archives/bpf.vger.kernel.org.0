Return-Path: <bpf+bounces-3504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C790D73EE6E
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051071C209C3
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332E15AE9;
	Mon, 26 Jun 2023 22:09:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9D13AD1
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 22:09:14 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122EC46BA;
	Mon, 26 Jun 2023 15:09:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa8cd4a113so17208495e9.2;
        Mon, 26 Jun 2023 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687817351; x=1690409351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW5N5d/pwV7Vw3ZMYdLzRSCMPWGvIjPnCehAk85Dpvs=;
        b=IO19dlqtIIVgsyeENJrgE9E3aFRAShlcgwxGMnLRuvmZgO7ZMM3zG3C1zzwMzS5W09
         yfTvAphRgn08TGviftuTOpevw3iVXsH8ybHbqEsU35D+Ew8nsqZ/k3IlrpczqC3+2gH7
         qdzpyMYg3ZOAFlMwtm7PaNaJmvSa+OoXjrzG07dvW8bkNvxvrQBDPpYWTZ7GOLU5Z+Ia
         cXSKyPnQHZfLHsoopSx2M5skKkiszd0xOfGPnh4Hs09MLqbg50jxIBairkoNztXOdnBe
         vvo+N7wy/tRoNQwAdIpWlJU2ERPywftqZVv+BXDfLqEnixXwyDRnpE8c1LTtP6h0cIPp
         FZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817351; x=1690409351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW5N5d/pwV7Vw3ZMYdLzRSCMPWGvIjPnCehAk85Dpvs=;
        b=UjXE+Jo7YTku0h+9Z/Lf6TjJ+MGaWJrrF4jjGHToa68vnmAyOj9hX7iWBonmrP1AKC
         bwGPNQaih2sidS1JEzYrLroyOA1UJEmRSFZ1ZCAbeKMxGBpVukJjvNDt/J0qFfPXMtxh
         4gpMTHpUFLnFwM4zXv91CUR+YHrOVd+ee7N5h2pgU7Y9F82YtbgAJ3/xvZtFR7O5m3wj
         OcD1wbGyHcPcLTrNIw+JxSSfKhVFhJpxINS2EP3hPOWSiSRNAlACIwc3yiYVnnIu4g/y
         E2rRMxaZ/Sa41vtwWOfZ5iHvbOUPUZwM4qfNIy4uWadMcJDZGq/19K/bRWxE4nLsWiy+
         3aUA==
X-Gm-Message-State: AC+VfDx0hEbodxeHik0bvLpnziok88gp+p1LqiakdO7xoVWOTRrysmGM
	PUZ1hfecWrPbs7UjgI/D/sFigvipnOgOV2rt+LM=
X-Google-Smtp-Source: ACHHUZ76H4iru1ocJGddHJk+H++r9APm3LnR7R7bfrf0JKCqJ3dA0faBEIVUSfHL5pddsW66qkJg+QoyyvHB4l3bBAU=
X-Received: by 2002:a05:600c:b4b:b0:3fa:8219:9166 with SMTP id
 k11-20020a05600c0b4b00b003fa82199166mr5713158wmr.15.1687817351262; Mon, 26
 Jun 2023 15:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com> <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com> <CAEf4BzY2dKvMk_Mg2oLnD5a8aOhXCmU-0QD6sWGNZqkjbMrhBA@mail.gmail.com>
 <87wmztixr0.fsf@toke.dk>
In-Reply-To: <87wmztixr0.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 15:08:59 -0700
Message-ID: <CAEf4BzZ1cJDb2esPSMgEB7SsBm7e7tNQ69sPn7JuVkhqWsTSJw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, lennart@poettering.net, cyphar@cyphar.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 4:07=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> >> applications meets the needs of these PODs that need to do
> >> privileged/bpf things without any tokens. Ultimately you are trusting
> >> these apps in the same way as if you were granting a token.
> >
> > Yes, absolutely. As I mentioned very explicitly, it's the question of
> > trusting application. Service vs token is implementation details, but
> > the one that has huge implications in how applications are built,
> > tested, versioned, deployed, etc.
>
> So one thing that I don't really get is why such a "trusted application"
> needs to be run in a user namespace in the first place? If it's trusted,
> why not simply run it as a privileged container (without the user
> namespace) and grant it the right system-level capabilities, instead of
> going to all this trouble just to punch a hole in the user namespace
> isolation?

Because it's still useful to provide isolation that user namespace
provides in all other aspects besides BPF usage.

The fact that it's a trusted application doesn't mean that bugs don't
happen, or that some action that was not intended might be attempted
(due to a bug, some deep unintended library "feature", or just because
someone didn't anticipate some interaction).

Trusted here means we believe our BPF usage is not going to spy on
sensitive data, or attempt to disrupt other workloads, because of
design and code reviews, and we intend to maintain that property. But
people are still involved, of course, and bugs do happen. We'd like to
get as much protection as possible, and that's what the user namespace
is offering.

For BPF-side of things, we have to trust the process because there is
no technical solution. Running outside the user namespace we also
don't have any guarantees about BPF. We just have even less protection
in all other aspects outside of BPF. We are trying to improve our
story with user namespace to mitigate what's mitigatable.


>
> -Toke
>

