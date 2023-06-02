Return-Path: <bpf+bounces-1719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C102F72085A
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B653281A24
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3B3331C;
	Fri,  2 Jun 2023 17:27:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D56332EE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 17:27:49 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A301BD
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 10:27:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f50e26b8bso354861366b.2
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685726863; x=1688318863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYco1kyGLPaO8luhKC774tirsM8ZtwBM/9F43y6tSm0=;
        b=NG4x7BTyaIX0HOZI0dsEMTJs0z+9fWVDG+CbkxtiffrZ6gAxVSm0ePtAUXmdnZmNiP
         G41eNexAbiPNBih/8zzFI3JdpI0VHk+WwPMAb1VOF6ZaJm+bLjbddzX7jagSS9WOn51f
         tpKHhbZLGfXZT36UKEbNQlQnf64GQU8IqNGFJWvb0PHpSvpwMtfy7SSJswCBpo/HZimP
         YrkVWMja5xh8tQUwa5PvzC1UZHsF2WTcgekLncI3DlddSydRWcfx/eWUvoVCS14a+bSm
         HnRMoLdb1BeHFRDRllXS15ffWrGDZVAVPMG5MK3WSfyaP0nUp2sP0v637AYImlhpMrxx
         pKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685726863; x=1688318863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYco1kyGLPaO8luhKC774tirsM8ZtwBM/9F43y6tSm0=;
        b=UP6PoRIAdm/s0pCbNJjBUtT203xxcBMxJPCvLiR51dI8Sr2P5hG+jGteRNTr6OePHA
         MPrLeSZKlqbL2iHlZj+hWDU9cER9yy5MfDRx4ZyM5sXN9OqVStO1Bq6KM+STeCRRQYvO
         2s4KgOb3Hsd87VB1uFspc4/Dr3XvktzWBqqZR2bQgVZL5KvZ97iYJea1teNRXk9I5biH
         W4KN9WFTvD7DFrCKe5TcjJL4i+cK8gDkyO6g/a2xkcvpMesuN3T5jm09Ycc+TOxOlnFX
         JmX/SehB1o+kArqEBBnzlvzqXT2PXLbK9VeOHwd9JfJs0FC/MSjSANrXOqCr/A1snG5g
         CdSQ==
X-Gm-Message-State: AC+VfDyL4JvDHmFsoF4y9jFEb10ITB1Fl2nBtCjptOGyk8c9vQqp0MBO
	L5gpZrqQNz2XSz/HStG8RnMoysfKOwcS7T3A7Kc=
X-Google-Smtp-Source: ACHHUZ5m7RToeDRZ1Yexp39P/YcbBfgECg3DFPiFpZSmiodlhqKlqOhnBpCtIt8ZEVWqqChyKsV2CBvhuzBQYydFWgM=
X-Received: by 2002:a17:907:2681:b0:96a:fd8a:f840 with SMTP id
 bn1-20020a170907268100b0096afd8af840mr11054798ejc.49.1685726863284; Fri, 02
 Jun 2023 10:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZG8f7ffghG7mLUhR@krava> <20230525102747.68708-1-liu.yun@linux.dev>
 <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com> <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev>
In-Reply-To: <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 10:27:31 -0700
Message-ID: <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with available_filter_functions
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 6:38=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> wrot=
e:
>
> Hi Andrii.
>
> =E5=9C=A8 2023/5/26 04:43, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Thu, May 25, 2023 at 3:28=E2=80=AFAM Jackie Liu <liu.yun@linux.dev> =
wrote:
> >>
> >> From: Jackie Liu <liuyun01@kylinos.cn>
> >>
> >> When using regular expression matching with "kprobe multi", it scans a=
ll
> >> the functions under "/proc/kallsyms" that can be matched. However, not=
 all
> >> of them can be traced by kprobe.multi. If any one of the functions fai=
ls
> >> to be traced, it will result in the failure of all functions. The best
> >> approach is to filter out the functions that cannot be traced to ensur=
e
> >> proper tracking of the functions.
> >>
> >> Use available_filter_functions check first, if failed, fallback to
> >> kallsyms.
> >>
> >> Here is the test eBPF program [1].
> >> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b=
3eadde97f7a4535e867
> >>
> >> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> >> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++---=
--
> >>   1 file changed, 83 insertions(+), 9 deletions(-)
> >>
> >
> > Question to you and Jiri: what happens when multi-kprobe's syms has
> > duplicates? Will the program be attached multiple times? If yes, then
> > it sounds like a problem? Both available_filters and kallsyms can have
> > duplicate function names in them, right?
>
> If I understand correctly, there should be no problem with repeated
> function registration, because the bottom layer is done through fprobe
> registration addrs, kprobe.multi itself does not do this work, but
> fprobe is based on ftrace, it will register addr by makes a hash,
> that is, if it is the same address, it should be filtered out.
>

Looking at kernel code, it seems kernel will actually return error if
user specifies multiple duplicated names. Because kernel will
bsearch() to the first instance, and never resolve the second
duplicated instance. And then will assume that not all symbols are
resolved.

So, it worries me that we'll switch from kallsyms to available_filters
by default, because that introduces new failure modes.

Either way, let's add a selftest that uses a duplicate function name
and see what happens?

> The main problem here is not the problem of repeated registration of
> functions, but some functions are not allowed to hook. For example, when
> I track vfs_*, vfs_set_acl_prepare_kgid and vfs_set_acl_prepare_kuid are
> not allowed to hook. These exist under kallsyms, but
> available_filter_functions does not, I have observed for a while,
> matching through available_filter_functions can effectively prevent this
> from happening.

Yeah, I understand that. My point above is that a)
available_filter_functions contains duplicates and b) doesn't contain
addresses. So we are forced to rely on kernel string -> addr
resolution, which doesn't seem to handle duplicate entries well (let's
test).

So it's a regression to switch to that without taking any other precautions=
.

>
> >
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index ad1ec893b41b..3dd72d69cdf7 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, cons=
t char *pat)
> >>   struct kprobe_multi_resolve {
> >>          const char *pattern;
> >>          unsigned long *addrs;
> >> +       const char **syms;
> >>          size_t cap;
> >>          size_t cnt;
> >>   };
> >>

[...]

