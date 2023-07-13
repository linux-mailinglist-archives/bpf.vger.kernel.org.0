Return-Path: <bpf+bounces-4917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9F75173A
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DCC1C210B2
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C36525D;
	Thu, 13 Jul 2023 04:13:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6A468C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 04:13:20 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8D10EA
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 21:13:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso511619e87.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 21:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689221597; x=1691813597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts/9Qm6X6UWmgYs2CZaefdSlQ9t4QfutXOvmy44Mycc=;
        b=BQ7I1w3T2lC/Pw6LgaC5HRD8HQvd3wg+tFps7DGMM5AkkfAtzbPv4PQBgHEgL7dFov
         hn1x3UU0bloSEIyQgyZi2XijjyI/rqF3WH4tKLG4k+JsR4KfUV5rGDTzU1p9VnqGkmXU
         HxH/0/s6++x/cb8iiRukLG0GKD/6hc/29zUoB/YN1uUTiddHCcHpLnE0ADBhaiCraUCz
         K0wNYiPKa9CVIqjdJOkUmQ6vNMSJxhFHkuF7uB+tYaSRdnDU+Ptiyd+ljQZF/SR3E1m5
         wORyQxC4zctF+FTVl17l9PTZc/ozFKAYrNiC4J/tIdkef6gtdggQ4Uh6TXsFjEzBTo7t
         i9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221597; x=1691813597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts/9Qm6X6UWmgYs2CZaefdSlQ9t4QfutXOvmy44Mycc=;
        b=aONcGpeobIDjgqoMP6VDBaLUAzNFXJObOmBo36XCQRSzPckbnFs2eZB6jeC+2pTJKq
         G0IStx0OC7oAp6pGEJ0+LD4+G0qoHAUX4AcillbPYJPWypXIOGbKP3Ywlp5TYvaNeQVM
         h/4WW2SyDmSv5SzJwMgssmAWHDeaIf5fxGNm3j3SA4z9GqlF72M02bwiK+8IbOvCCAFu
         HORSNs78x1MDiNZksFOUMJa4+TFX4M7P7QQBHYDcSdTUWHTb/jIqffpqSiyujxb8LCWU
         9OajTmlSuza1z7qlrfXory7rvK/+9Y5TQEB2eXRR0yUn0OHgJNJLd3uSwRaBENEHNFp1
         KL5A==
X-Gm-Message-State: ABy/qLYNJ64sRKYXKudYOvAE8kHNE7QCbBtboBdfefaiIqyVRrvwMro0
	JtwWUJxmyjTdE7hq0G/7+pvl4QEUc86PeHGD3Io57ozL
X-Google-Smtp-Source: APBJJlEwN1EP/379ud0+8zczHZSJOcxNmYwL5VQ51lxUH5Vp3OtwB+3GdlEDY9bnH2X6rQ7fYQbd38GwWNobhfRAo9U=
X-Received: by 2002:a05:6512:3592:b0:4fb:893e:8ffc with SMTP id
 m18-20020a056512359200b004fb893e8ffcmr165215lfr.17.1689221597082; Wed, 12 Jul
 2023 21:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712010504.818008-1-liu.yun@linux.dev> <CAEf4Bzay5QC_pbH-Km-oqL8MzzyUCtKU3Xc2Jie5bbRc=PBi5A@mail.gmail.com>
 <CAADnVQ+KwbRo0QsNOZPVW2Xpn1x5=N6pNL1MwKGrNnbbtTX3Lg@mail.gmail.com>
In-Reply-To: <CAADnVQ+KwbRo0QsNOZPVW2Xpn1x5=N6pNL1MwKGrNnbbtTX3Lg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Jul 2023 21:13:04 -0700
Message-ID: <CAEf4BzYyH1+_6_LCro9AYnWknrv7ZFW03+cqqkthyCdf7qQ10g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Support POSIX regular expressions for multi kprobe
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>, Jiri Olsa <olsajiri@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 8:05=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 11, 2023 at 10:42=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jul 11, 2023 at 6:05=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> =
wrote:
> > >
> > > From: Jackie Liu <liuyun01@kylinos.cn>
> > >
> > > Now multi kprobe uses glob_match for function matching, it's not enou=
gh,
> > > and sometimes we need more powerful regular expressions to support fu=
zzy
> > > matching, and now provides a use_regex in bpf_kprobe_multi_opts to su=
pport
> > > POSIX regular expressions.
> > >
> > > This is useful, similar to `funccount.py -r '^vfs.*'` in BCC, and can=
 also
> > > be implemented with libbpf.
> > >
> > > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 52 ++++++++++++++++++++++++++++++++++++++--=
--
> > >  tools/lib/bpf/libbpf.h |  4 +++-
> > >  2 files changed, 51 insertions(+), 5 deletions(-)
> > >
> >
> > Let's hold off on adding regex support assumptions into libbpf API.
> > Globs are pretty flexible already for most cases, and for some more
> > advanced use cases users can provide an exact list of function names
> > through opts argument.
> >
> > We can revisit this decision down the road, but right now it seems
> > premature to sign up for such relatively heavy-weight API dependency.
>
> regexec() is part of glibc and we cannot link it statically,
> so no change in libbpf.a/so size.

right, I wasn't worried about the code size increase of libbpf itself

> Are you worried about ulibc-like environment?

This is one part. musl, uclibc, and other alternative implementations
of glibc: do they support same functionality with all the same options
and syntax. I'd feel more comfortable if we understood well all the
implications of relying on this regex API: which glibc versions
support it, same for musl. Are there any extra library dependencies
that we might need to add (like -lm for some math functions). I'm not
very familiar also with what regex flavor is implemented by POSIX
regex, is it the commonly-expected Perl-compatible one, or something
else?

Also, we should have a good story on how this regex syntax is
supported in SEC() definitions for both kprobe.multi and uprobe.multi.

Stuff like this.

But also, looking at bpftrace, I don't think it supports regex-based
probe matching (e.g., I tried 'kprobe:.*sys_bpf' and it matched
nothing; maybe there is some other syntax, but my Google-fu failed
me). So assuming I didn't miss anything obvious with bpftrace, the
fact that it's been around for so long with so many users and lack of
regex doesn't seem to be the problem, I'm just not convinced we want
to add regex to libbpf. At least not yet. Meanwhile, users can do
regex-based symbol resolution on their own and just provide resolved
function names to bpf_program__attach_kprobe_multi(), so lack of regex
is not a blocker for anything.

So that was my thought process and some reasons for hesitation.

