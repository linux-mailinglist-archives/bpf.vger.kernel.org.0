Return-Path: <bpf+bounces-970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D696B709E92
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 19:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908B4281D3D
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DC12B6F;
	Fri, 19 May 2023 17:52:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675112B62
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 17:52:15 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A0DE
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 10:52:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96598a7c5e0so570887966b.3
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684518733; x=1687110733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGnYbqcZG6G5Zygfq9ya1FX/PrdFw/7KpC0G/WDYb3g=;
        b=FIMRblw36BzoXIv5bXJuzONQg393eU36NyKvPxHPTG4OOKcIthe7CxE9Y7xpyARiKs
         r8sZf4GXjmxCQxmwf08kAtykoIyPKW3Tj0E/wsBUcXGlW/siH+jveScs+pQPpmjIPU/C
         sHCbo4YfKWpLlqGpqCUhv0W9+xXXG9IHrlcko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518733; x=1687110733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGnYbqcZG6G5Zygfq9ya1FX/PrdFw/7KpC0G/WDYb3g=;
        b=UiQazHcWF+GSZ36jKSDqCL1hLDeB7zQQBJpwqFYYIElptw8Rl1n7sMQX/3dblvONc2
         nzj4xLc61jq9xgfRhtTFOA+Z1SS91Ys5WNIpq32xxJumOBllbHO2UtdjTAonGl+CXwvw
         /bDB+c1rFfVMn2W6J2hUj6XFnXCiNq665xV5ug4Z7jD0hJSp+wMpwVksBEvWBzXWSjm2
         4JZ2LREuZl6OZ6XZ2x3PWBkWKuH2qqbQIsFuiZIeWsozHXyW0FOB01HrE1aOI+8ypCdl
         X9dybHKRruXHcx8GIs5oBCxETNiVCsZMLRB6gS5QyCLw3ymsyavNgkyq/wCuh9SQ0fVv
         kUDA==
X-Gm-Message-State: AC+VfDxuynpGSSjxxp5DKra4rpLnmrHGQ8MAtdI6+Ej4ZMuUus2cEV4u
	NOLBD0V1tBQ3h0rQsXoDuLLkV16mYrF92HhAJH5iUjC5
X-Google-Smtp-Source: ACHHUZ7876bJu8Fh0tNiJ8wf64QfxO/5AwMNCIj6WVrec4EwaefIIWOJ5tOyzu6AVXq8ZfnMoL6Zpw==
X-Received: by 2002:a17:907:96aa:b0:958:5474:a84a with SMTP id hd42-20020a17090796aa00b009585474a84amr2441448ejc.38.1684518732892;
        Fri, 19 May 2023 10:52:12 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id l7-20020a170906938700b00947ed087a2csm2521041ejx.154.2023.05.19.10.52.11
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:52:11 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5112cae8d82so1442906a12.2
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 10:52:11 -0700 (PDT)
X-Received: by 2002:a05:6402:b11:b0:508:41df:b276 with SMTP id
 bm17-20020a0564020b1100b0050841dfb276mr2186732edb.22.1684518731037; Fri, 19
 May 2023 10:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner> <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner> <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner> <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
 <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com> <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
In-Reply-To: <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 May 2023 10:51:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=win2x_KORa1CJTaX0VrBy9ug_GXNwPpcPXVQbedHSYhsg@mail.gmail.com>
Message-ID: <CAHk-=win2x_KORa1CJTaX0VrBy9ug_GXNwPpcPXVQbedHSYhsg@mail.gmail.com>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Lennart Poettering <lennart@poettering.net>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 9:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> My point that the kernel can help here.
> Since folks don't like sysctl to control FD assignment how about somethin=
g like this:

No. Really.

The only thing that needs to happen is that people need to *know* that
fd's 0/1/2 are not at all special.

The thing is, it's even *traditional* to do something like

        close(0);
        close(1);
        close(2);

and fork() twice (exiting the first child after the second fork).
Usually you'd also make sure to re-set umask, and do a setsid() to
make sure you're not part of the controlling terminal any more.

Now, some people would then redirect /dev/null to those file
descriptors, but not always: file descriptors used to be a fairly
limited resource. So people would *want* to use all the file
descriptors they could for whatever server connections they
implemented. Including, very much, fd 0.

So really. There is not a way in hell we will *EVER* consider fd 0 to
be special. It isn't, it never has been, and it never shall be.

Instead, just spread the word that fd 0 isn't special.

The fact that you think that some completely broken C++ code was
"written with high quality", and you think that is an excuse for
garbage is just sad.

Those C++ libraries WERE INCREDIBLE CRAP. They were buggy garbage. And
no, they are in no way going to affect the kernel and make the kernel
do stupid and wrong things.

                    Linus

