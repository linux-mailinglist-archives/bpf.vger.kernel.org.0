Return-Path: <bpf+bounces-4853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C672F750BBF
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 17:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0262A1C20F83
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14734CF2;
	Wed, 12 Jul 2023 15:05:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2312AB35
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 15:05:18 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1747E1BD3
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:05:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b698937f85so117003491fa.2
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689174308; x=1691766308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6SyJOSVvusBtFBvNCJLaBkjKWfcm1rOjTdZrwlmHgc=;
        b=QdQNFHO6w5mgZoNdq2ixmd0KXG8JIYqlhdwC3dvnJ0Dd49YVkE2pa5KVGZPZIFtdue
         CPlGHRBG6Wq+8ADfaqo1o2iVQUubsKYHgyfv604PGEoOVUbqQmhAdW1GpufurMJOGMU0
         4TVE22gf4VV1avCSCzg2kZ9bZBzDxsLAnFFzQyrKDDRw/MYjLRNukrSTRp2Oz3GHSqrM
         fuCwVUUk7pdWT0UCsL5JBG/ZH9BqRKB6jpZu6t/1vv7msOgmytbZ6A/UJQmetEiAuvs6
         1rdzLMz1yf/94lopnxNGERdjkXIdLOSmaSONuGN3PsUxn8ZRa0gkJlj+ovOxaYFlMFyi
         Hl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174308; x=1691766308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6SyJOSVvusBtFBvNCJLaBkjKWfcm1rOjTdZrwlmHgc=;
        b=VoMG4OhqrCB+Tg0iLBY0jiU004bAKwxkt5zlZJdgeE3jFrqdsv72U0LiwdvfABJI6W
         ik2+RJpStUEPzvg6aLLrX+zbmqnU6JvxrnPpLa7CD5hoMaTG1suIDvgRarkw7e+B2md0
         waZ5AWipG51Oak5UN8Ozi26Mcwiu1NLgL9J9fIpe6AXkkGhQtRqJZuIPEbzGIvFSVBww
         MsV6u5mThuzVt4Hj6jJ+z1fhaY73avzChfXuXm+WxRZ/K0wz3kaVOax4xWC8/l4mC5GC
         Nrm4S8Smk6mpqIkTFMltwyV8U3/A/XrjBubNVKXpNMRoFhEVHVfMwYPniQBLEpSwAuce
         /+iQ==
X-Gm-Message-State: ABy/qLYgZWfAQNtTFoEGyYMtQAsPLIw6GhLzPyHfGFymw8ftlb16am4x
	4WfsrnudI3bCCX+9XEddAa/Ov3yoAKmmRnxh7pVWFzB4
X-Google-Smtp-Source: APBJJlEVsc/5q07RciSDphsyOummOyMP7YeIG4kXNngR0Ard+9Mvs1sWIuM3xnLDSLEkR0OfnddsJoPuUo8vwh8wQis=
X-Received: by 2002:a2e:9b91:0:b0:2b6:dc3a:a99f with SMTP id
 z17-20020a2e9b91000000b002b6dc3aa99fmr16965130lji.17.1689174307910; Wed, 12
 Jul 2023 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712010504.818008-1-liu.yun@linux.dev> <CAEf4Bzay5QC_pbH-Km-oqL8MzzyUCtKU3Xc2Jie5bbRc=PBi5A@mail.gmail.com>
In-Reply-To: <CAEf4Bzay5QC_pbH-Km-oqL8MzzyUCtKU3Xc2Jie5bbRc=PBi5A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jul 2023 08:04:56 -0700
Message-ID: <CAADnVQ+KwbRo0QsNOZPVW2Xpn1x5=N6pNL1MwKGrNnbbtTX3Lg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Support POSIX regular expressions for multi kprobe
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>, Jiri Olsa <olsajiri@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 10:42=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jul 11, 2023 at 6:05=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> wr=
ote:
> >
> > From: Jackie Liu <liuyun01@kylinos.cn>
> >
> > Now multi kprobe uses glob_match for function matching, it's not enough=
,
> > and sometimes we need more powerful regular expressions to support fuzz=
y
> > matching, and now provides a use_regex in bpf_kprobe_multi_opts to supp=
ort
> > POSIX regular expressions.
> >
> > This is useful, similar to `funccount.py -r '^vfs.*'` in BCC, and can a=
lso
> > be implemented with libbpf.
> >
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 52 ++++++++++++++++++++++++++++++++++++++----
> >  tools/lib/bpf/libbpf.h |  4 +++-
> >  2 files changed, 51 insertions(+), 5 deletions(-)
> >
>
> Let's hold off on adding regex support assumptions into libbpf API.
> Globs are pretty flexible already for most cases, and for some more
> advanced use cases users can provide an exact list of function names
> through opts argument.
>
> We can revisit this decision down the road, but right now it seems
> premature to sign up for such relatively heavy-weight API dependency.

regexec() is part of glibc and we cannot link it statically,
so no change in libbpf.a/so size.
Are you worried about ulibc-like environment?

