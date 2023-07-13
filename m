Return-Path: <bpf+bounces-4970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB89752BAE
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 22:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BE428159B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57251F929;
	Thu, 13 Jul 2023 20:31:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832076120
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 20:31:52 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397502715
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 13:31:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso11043255e9.0
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689280309; x=1691872309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPciF0EVeOAxtc9apUd6YJTK65RmMx7elq3AOSzgMcI=;
        b=OKwThkzQ0+E08mpEsnxyhT3XTXFu1LChRVAAsv5WeEc38RbbSeW4IcJTWwatlG0kB2
         IkpqK5XEmk0CNBEPzo7awkCDIcuIAd/ciK921tNTeownJMbKalVRqbqKLkS56fNnUef2
         NPsIkhiRS9gMJW5JW8qf/uDaT3+y1efBdq1H9HBpisMOmCZymdWgtGEzbZg0+WkYFOeL
         cUL63zc/qIylL16nkv7BHdS/q1dLgrU0xm7FB7/EhszlT+TpYZ/ByVGcUO5Dl+dAgKbg
         7wjp/ugLWA81cuanWxa3mAKDwSGXftQxrThnP3VHn9Jxhh/OTJyRMdMF88TAOqodqOgt
         vhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280309; x=1691872309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPciF0EVeOAxtc9apUd6YJTK65RmMx7elq3AOSzgMcI=;
        b=E5pA2cprNCizcBCvSWrdEoKRYUrYx0Q714G2+if+WzWclTugRkDO++6sAgfVQyMKR1
         iiZSP5lMTTD0qQee5kmWFwiixldAgpmSxK36gZaMMMY94l+c+VYGV5f6SIHHceApK2zV
         LCWqmVGPjj7F2AfzBDsuA2MtYMpxohCW9jU3nIpTqI75+RE/g79xI4puxlC+8TpLF6sP
         pRMRY/gnaHTpyS+wOalYIOpJS/YddBKH3kxtnf++SNf/1BQWilWmKom9bQykzn7+CntB
         dQQ26yKCCab0zc2QcJTf1sAE3MsR9RnrVjwEDPFWMfVhhUj9pnrCQweQmUIMsEeGtICX
         6I3Q==
X-Gm-Message-State: ABy/qLa3SHtkrHN1VM5KUV2rTfmzykVZicdyNh1+Q+/yJ7KKfafGYI4D
	aybwiCua9mZ3HSHKawYNaO8iInTT6pX6ceiD894=
X-Google-Smtp-Source: APBJJlHl3Vtoy7fBv4jfZlJ3ggHoainV8W3wltPMg1jwvjvgMpX/RoZnFigPf8uRD/71K5zlUiRaGjmTrtKpBvqStWU=
X-Received: by 2002:a5d:5944:0:b0:313:fce9:c568 with SMTP id
 e4-20020a5d5944000000b00313fce9c568mr2248623wri.31.1689280308471; Thu, 13 Jul
 2023 13:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712010504.818008-1-liu.yun@linux.dev> <CAEf4Bzay5QC_pbH-Km-oqL8MzzyUCtKU3Xc2Jie5bbRc=PBi5A@mail.gmail.com>
 <CAADnVQ+KwbRo0QsNOZPVW2Xpn1x5=N6pNL1MwKGrNnbbtTX3Lg@mail.gmail.com>
 <CAEf4BzYyH1+_6_LCro9AYnWknrv7ZFW03+cqqkthyCdf7qQ10g@mail.gmail.com> <xzhh4o27vtnstev3i64wqwd4jkuatvqrgoev3fv4igequpjiye@wpsfpb4p4hr7>
In-Reply-To: <xzhh4o27vtnstev3i64wqwd4jkuatvqrgoev3fv4igequpjiye@wpsfpb4p4hr7>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Jul 2023 13:31:35 -0700
Message-ID: <CAEf4Bza-GXp9TO4gBZ=m6vSszHLW4uQvACKyoOaWMD985k-4tg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Support POSIX regular expressions for multi kprobe
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jackie Liu <liu.yun@linux.dev>, 
	Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 9:56=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Wed, Jul 12, 2023 at 09:13:04PM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 12, 2023 at 8:05=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jul 11, 2023 at 10:42=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Jul 11, 2023 at 6:05=E2=80=AFPM Jackie Liu <liu.yun@linux.d=
ev> wrote:
> > > > >
> > > > > From: Jackie Liu <liuyun01@kylinos.cn>
> > > > >
> > > > > Now multi kprobe uses glob_match for function matching, it's not =
enough,
> > > > > and sometimes we need more powerful regular expressions to suppor=
t fuzzy
> > > > > matching, and now provides a use_regex in bpf_kprobe_multi_opts t=
o support
> > > > > POSIX regular expressions.
> > > > >
> > > > > This is useful, similar to `funccount.py -r '^vfs.*'` in BCC, and=
 can also
> > > > > be implemented with libbpf.
> > > > >
> > > > > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > > > > ---
> > > > >  tools/lib/bpf/libbpf.c | 52 ++++++++++++++++++++++++++++++++++++=
++----
> > > > >  tools/lib/bpf/libbpf.h |  4 +++-
> > > > >  2 files changed, 51 insertions(+), 5 deletions(-)
> > > > >
> > > >
> > > > Let's hold off on adding regex support assumptions into libbpf API.
> > > > Globs are pretty flexible already for most cases, and for some more
> > > > advanced use cases users can provide an exact list of function name=
s
> > > > through opts argument.
> > > >
> > > > We can revisit this decision down the road, but right now it seems
> > > > premature to sign up for such relatively heavy-weight API dependenc=
y.
> > >
> > > regexec() is part of glibc and we cannot link it statically,
> > > so no change in libbpf.a/so size.
> >
> > right, I wasn't worried about the code size increase of libbpf itself
> >
> > > Are you worried about ulibc-like environment?
> >
> > This is one part. musl, uclibc, and other alternative implementations
> > of glibc: do they support same functionality with all the same options
> > and syntax. I'd feel more comfortable if we understood well all the
> > implications of relying on this regex API: which glibc versions
> > support it, same for musl. Are there any extra library dependencies
> > that we might need to add (like -lm for some math functions). I'm not
> > very familiar also with what regex flavor is implemented by POSIX
> > regex, is it the commonly-expected Perl-compatible one, or something
> > else?
> >
> > Also, we should have a good story on how this regex syntax is
> > supported in SEC() definitions for both kprobe.multi and uprobe.multi.
> >
> > Stuff like this.
> >
> > But also, looking at bpftrace, I don't think it supports regex-based
> > probe matching (e.g., I tried 'kprobe:.*sys_bpf' and it matched
> > nothing; maybe there is some other syntax, but my Google-fu failed
> > me). So assuming I didn't miss anything obvious with bpftrace, the
> > fact that it's been around for so long with so many users and lack of
> > regex doesn't seem to be the problem,
>
> bpftrace only supports wildcard (`*`) operator like in globs. One thing
> that might help bpftrace get away with that is being able to specify mult=
iple
> attachpoints for a single probe. Eg.

Right, and you can do the same with libbpf. Call
bpf_program__attach_kprobe_multi() multiple times with different globs
and/or define multiple SEC("kprobe.multi/xxx") entry functions that
just call into a common logic-handling subprog.

I find, in practice, that regexes are often completely unnecessary for
selecting subsets of functions, if one has globs already.


>
> ```
> tracepoint:foo:bar,
> tracepoint:baz:something
> {
>         print("hi")
> }
> ```
>
> Thanks,
> Daniel

