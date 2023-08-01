Return-Path: <bpf+bounces-6603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604D076BC7C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E6D1C2109C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF725146;
	Tue,  1 Aug 2023 18:29:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6423200AC
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 18:29:05 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C62E212D;
	Tue,  1 Aug 2023 11:28:50 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d35aa5419so30071946d6.1;
        Tue, 01 Aug 2023 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690914529; x=1691519329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtwD8hbxm1AtsZOcMHnXCSOew9XSoWb+JTcTwLos1Fs=;
        b=P+7iAYvCCSqWKBNXVaT6WGybYQ/ARxrhBokLesOVnd9UjhS91gAJfIzkDsvoGNIuh8
         1Oyx6Vt+iz9A64G7GY9aI9y8EH4UouviCEQYE9nqXgrClTiopzi8lmL8wxSfQXWKSpWR
         A0qkB6AjKhTqBBy/ZuI7CBYVwzkBdVzztUUeAPdyOxCmVdU1GuXZ6SVz9ieSRNic8xcQ
         yToZ9WkhA52ASzrHqK07TQbgLA2F7toN8jNrDy7OGoV5YCCD3WE660ttOB7YVovqqzHB
         L0wm8D7+qwW7KbaGMjlC+7zqueg7q+Ko+ogL/Q3cEW/3IeefK74O1SgGxJCiBvTtJoVX
         oklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914529; x=1691519329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtwD8hbxm1AtsZOcMHnXCSOew9XSoWb+JTcTwLos1Fs=;
        b=kJgLf69Vvx3ZAU4ZnomvP3eTVTujbO0xasqsOsupD2A/60HRYTD1C6SswuZhs8Ka0R
         TYiGyMlReprp4C35gJ5eHoeK7faca8A7cct5sKgdTySaawyyRmpFrY4HMDSQyAT42U2D
         XCV2MqZPLlH6R8O8E8qKmz6dhGJdQ4XpoTrttQJi1hACpV5RNIQF2DMb9h18LgT/s7RT
         7INq7Xd0tOttTVfaoPH/roVE2ie7ixU3JfgGBAwN4x1Z0alu295XbbCD1l3mYODXWykY
         Q5MKOwOtz9DSDkRTX0Yy12atziRqoj2KyYlS52TS657vrDidJbv/ctVYfQpfAZEVHzG8
         52ow==
X-Gm-Message-State: ABy/qLZvzAxKjPO4kyg9Qs/LlL+XTcoiYOmChZV9d4x3LWEsBQvAMom9
	nurvF1mC0TLvNDWdsEyjWbtiT/qmuJLLvYGYew8=
X-Google-Smtp-Source: APBJJlHlZRM2lI39c0SQhtQBdkjZ4yWBlSlfHuz5pw61JZ1xQGwvIFkqPdWqJLrybYgiJ3Jng5tX2bcpetRl4dNlyxU=
X-Received: by 2002:a05:6214:12c1:b0:635:ed4c:50a with SMTP id
 s1-20020a05621412c100b00635ed4c050amr11293006qvv.28.1690914529285; Tue, 01
 Aug 2023 11:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
 <ZMDvmLdZSLi2QqB+@krava> <20230726200716.609d8433a7292eead95e7330@kernel.org>
 <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com> <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
 <20230727105102.509161e1f57fd0b49e98b844@kernel.org> <c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
 <20230801100148.defdc4c41833054c56c53bf0@kernel.org> <bba3b423-8e38-ade3-7ce7-23b1be454d1f@oracle.com>
 <CA+JHD93Liq95RvfChifmnE7E9mKR42_W7rtpqgY9KAgYyGTZwQ@mail.gmail.com>
In-Reply-To: <CA+JHD93Liq95RvfChifmnE7E9mKR42_W7rtpqgY9KAgYyGTZwQ@mail.gmail.com>
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Date: Tue, 1 Aug 2023 15:28:38 -0300
Message-ID: <CA+JHD93MiFyJEP+1K7dAey+2d8v-az6qqwAKBgUzk9USXmmbzg@mail.gmail.com>
Subject: Fwd: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Cc: "cc: Jiri Olsa" <olsajiri@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, dwarves@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry, replied only to Alan :-\

- Arnaldo

---------- Forwarded message ---------
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Date: Tue, Aug 1, 2023 at 3:26=E2=80=AFPM
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with
the latest pahole
To: Alan Maguire <alan.maguire@oracle.com>


On Tue, Aug 1, 2023 at 2:37=E2=80=AFPM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
> On 01/08/2023 02:01, Masami Hiramatsu (Google) wrote:
> > On Mon, 31 Jul 2023 16:45:24 +0100
> > Alan Maguire <alan.maguire@oracle.com> wrote:

> >> Unfortunately (or fortunately?) I haven't been able to reproduce so fa=
r
> >> I'm afraid. I used your config and built gcc 13 from source; everythin=
g
> >> worked as expected, with no warnings or missing functions (aside from
> >> the ones skipped due to inconsistent prototypes etc).
> >
> > Yeah, so I think gcc-11.3 is suspicious too (and it seems fixed in gcc-=
13).

See below, but this one is interesting, gcc-13 works with
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy?

> >> One other thing I can think of - is it possible libdw[arf]/libelf
> >> versions might be having an effect here? I'm using libdwarf.so.1.2,
> >> libdw-0.188, libelf-0.188. I can try and match yours. Thanks!
> >
> > Both libdw/libelf are 0.181. I didn't install libdwarf.
> > Hmm, I should update the libdw (elfutils) too.
>
> That might help. Thanks!

Probably he needs to tweak these CONFIG_ entries:

=E2=AC=A2[acme@toolbox perf-tools]$ grep DWARF ../build/v6.2-rc5+/.config
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
=E2=AC=A2[acme@toolbox perf-tools]$

And make it use CONFIG_DEBUG_INFO_DWARF4=3Dy,
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dn

For DWARF5 I need to forward port what I have in:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=3DWIP-importe=
d-unit

- Arnaldo

