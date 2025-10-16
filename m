Return-Path: <bpf+bounces-71070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23390BE147A
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 04:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04EB34EDFDE
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 02:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBE1E5B94;
	Thu, 16 Oct 2025 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLQ27IFJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A6B661
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581987; cv=none; b=H6izp5SFI2tnfER/CeAAliWx/U6WLO4fnkveQacm0Y29mRFknJQK4OyiX++f/CZr94U7m+sHLS3Lxo/ncuaRT6vfAW/hHsSSuXiTTHEVtVIhOTfSY+ouzxBgOus3YyDJ+RL/r7CV5pZIhU54m1Jol3z/3WqquehxwpmJT6OaS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581987; c=relaxed/simple;
	bh=F+SPc5GavxXWGdSVhfhZs5HKHwDQJm27pTpkyxfbKIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKemctBssEUdlRNq0z/Wvwz2KQPC5boN2e39f9bYXtABtabTB+YXzh75nfIvV2bGxiXax+DZDcQHt570/R5rx31pY1uQgtvPLDkLejrCzpX7TYv+v5sIovId750haBnVL/PZk7S6x+EgS0OFKKdiY23cRTS6TpQd4tXppFsQmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLQ27IFJ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-64d696840b6so123186eaf.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760581985; x=1761186785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNWcTy4xR1JOOLpvPDs36WVrv9lERjF5a5A+G+lBCZA=;
        b=FLQ27IFJgHoRphD7K7yX1/hMC098zn5Y5cilxTLvXcvNo0riaQ2eBeCCeSqCOXpadW
         vfZYgh6uVFo3WzGHHW37qRA+3UM/cHG1kUgA0RvGFJ/ON8b3Qrr9ta/0k6MDya3Gbwmu
         aiEeemb9ag4650+Il8W/xT7KUTVwp48P8fN7xOMGUEitevC3MaES+wNIU8a4igkHzBVO
         8xEWsjmCvtMliP1H0FVQzZEckfE4Hlfh+MkKZPeEIIlle5WRqDSyacTYd8CCl7i1Ux5B
         QNMgj3EHmpLKqgQ5UFIDmU06ISNFH2hHDT3Fg+kc4RI+X0kdHk/Mr64vh22uenWIHj9I
         K1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760581985; x=1761186785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNWcTy4xR1JOOLpvPDs36WVrv9lERjF5a5A+G+lBCZA=;
        b=MEjs+cICsi4eRSdYRTPS+77YTcH5k3Hnr7vO1kpfsFKsTMiUj2Lo4GVt6UoOU14zPq
         fxe7s1gU4f9+IVD0qPslgzPjpuuNBUDjNZZMnHSCrCIL5N4ThBGbfpVFMj7lEJF1285C
         /7sw4J2uKIyVY8NIZkVmDK5nzbDke/IzDPzBt1KIQjnMpohT7FNQ2S5bJYPbLDDwOkeD
         45nCB4d1GnLY3DSLMLHY9p2diGo7DzCUoqFvj5+WfvY5Qn2fbsxbzsDYhLNl2g2hxPG8
         gpzY1VHJ6rDNVePoPPsqvap+J+GPM/lhR/fDAiYZ4/+6GiVtPfd/kUqG+DY/USpEE7em
         G72g==
X-Forwarded-Encrypted: i=1; AJvYcCUPFvUZYgO5+AmREKvFEtkIh/IxcSqskkube7FKVxXsoSPfRQovwMMmzT97TKL8+qZSIjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwcUD5wgFGD9eTTw55YA/1QpiSg8ho3TaYQa2axGs9K/CBD5z
	EwgG8yTosqmskmax09VwyoB9YTNOPim4eQzQ8JNNcHAUs71kEmb+3rW9Y23O3/eLT/SN/konkEI
	KX6A2UySI1Bjw6lLDJm+tKwXxhHzONu8=
X-Gm-Gg: ASbGncvq0yMUL8zDl8yZwR2A9admrOmzVhQ4p1dOifgY0jxjn0d1rjRml2GxXOwW7Rx
	aQ0MtnsTMrcrjd7GN5G34Oo3LnuWWsZtj6bYC+mKjNCADnrEdKllHzhSFxGttJYqYtia6ANgaj1
	1aQNs83DXmUezIUGGTo+jhTPA5S+flRXLy4ZsY1aRtnB9NAMzk+bTnelrV9vNBGRp4vcPgNLwMA
	QsyraKaFhcSn9jChNL17wzG5tHjyCjx3fg/EqC1PKrGuz920UPy15U7JimFJk98EIBM3RQ=
X-Google-Smtp-Source: AGHT+IF+O/5QL0QgiDjkhtOEpIr0iqku3f5Z/U6TAov0e076glnS2AzZo7UaiYoUn/cdNkI3kftKveHbzhf/uxcHARc=
X-Received: by 2002:a05:6870:264:b0:321:278a:1811 with SMTP id
 586e51a60fabf-3c0fac557b5mr15972017fac.45.1760581985044; Wed, 15 Oct 2025
 19:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL8PWAqzfdaSYwn0JyX4_TBPWZmCunMn8ZRKJYwgb2KAQ@mail.gmail.com>
 <20251015025049.9492-1-higuoxing@gmail.com> <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
In-Reply-To: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
From: Xing Guo <higuoxing@gmail.com>
Date: Thu, 16 Oct 2025 10:32:53 +0800
X-Gm-Features: AS18NWBYgEovx4J4h4xeHYM2TKTmjUsetKMmyFNty9V9DrZKsGgklcptteDqKUw
Message-ID: <CACpMh+B5bjbLKief_9-RtE-e_06WqKGuk-awoHHYfO_s3aYk0g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, olsajiri@gmail.com, 
	sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:20=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 14, 2025 at 7:50=E2=80=AFPM Xing Guo <higuoxing@gmail.com> wr=
ote:
> >
> > Recently, I noticed a selftest failure in my local environment. The
> > test_parse_test_list_file writes some data to
> > /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> > the data back.  However, after writing data to that file, we forget to
> > call fsync() and it's causing testing failure in my laptop.  This patch
> > helps fix it by adding the missing fsync() call.
> >
> > Signed-off-by: Xing Guo <higuoxing@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
>
> I accidentally applied it to bpf-next tree and had to drop it from there.
>
> It actually doesn't apply to bpf tree cleanly, so please rebase and resen=
d.
>
> But first, did you validate that fclose() actually fixes the issue for
> you? Because I don't think fclose() will call fsync(), will it?
> fclose() will basically do the same thing as should be done with
> fflush() anyways, so I have my doubts.

Thanks for pointing this out.  Adding fclose() resolves the issue on
my laptop too.
I prefer switching back to using fsync() according to your comment.

Best Regards,
Xing.

>
> Furthermore, your commit message doesn't correspond to your patch.
> There is no fsync() call here, please fix that as well.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/too=
ls/testing/selftests/bpf/prog_tests/arg_parsing.c
> > index bb143de68875..0f99f06116ea 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> > @@ -140,9 +140,11 @@ static void test_parse_test_list_file(void)
> >         fprintf(fp, "testA/subtest2\n");
> >         fprintf(fp, "testC_no_eof_newline");
> >         fflush(fp);
> > -
> > -       if (!ASSERT_OK(ferror(fp), "prepare tmp"))
> > -               goto out_fclose;
> > +       if (!ASSERT_OK(ferror(fp), "prepare tmp")) {
> > +               fclose(fp);
> > +               goto out_remove;
> > +       }
> > +       fclose(fp);
> >
> >         init_test_filter_set(&set);
> >
> > @@ -160,8 +162,6 @@ static void test_parse_test_list_file(void)
> >
> >         free_test_filter_set(&set);
> >
> > -out_fclose:
> > -       fclose(fp);
> >  out_remove:
> >         remove(tmpfile);
> >  }
> > --
> > 2.51.0
> >

