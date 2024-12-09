Return-Path: <bpf+bounces-46432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F49EA2DE
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DFE282926
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2622488B;
	Mon,  9 Dec 2024 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MewChY+n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0119B3EE
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787313; cv=none; b=OR2jeGEh0qev9WpWPGANIS2mBxm7PswJoyIWYl9bfJVdSGgqAZD5V6azsYW9Sbui+/MwGnhYLryeSmV2ls1uHvsfF8MxL4rRvyo4O/rFDbQsRrcTWUOQuYs4hFaIwyrJmu8jnCPJq7DH5tif3S6oB9F1kRIhMDQKhx8yULpq41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787313; c=relaxed/simple;
	bh=JN7EQT0Mthw7Oga4n+IAssHnuIq/QLIEyXqz0jw/0Pk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBlPEDAKl7TYoKLZDiTFQf2lvlK92Iw2plZePexwnDlq4GUrmc6yoKn+F2WMSdSajh1wffUsl4bRqmp6oitXPH/jyZPx2RIqMG1pICaYNXWH+5ZfGTV/TSAhGV8nY/WjuB3GmvPPvM83wSjtFZ2MzPs72661+3cwoFK89sVMyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MewChY+n; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385ed7f6605so2204609f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733787309; x=1734392109; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13GeoEKWgDJmL8HGpvtdBM7JrqVpe1ZXGZGoTYzhGwg=;
        b=MewChY+nmGD2L+DYSjLe8zlc50Qvy8PNAjBNeA+ge7e8ijKFB0h06h1HZA7P/mghCY
         MIopqaZKvcc97/nGrjRloaJKAu/4nGEhvW5CPMBOfiHpbCOAOL7NKAGmpNJ4OB3N/UnU
         ldrzZIi5ro100rnqGT4PKzjmPHL/7nAUo+zF4hPuV/ULDM1nAa8uoxn2qajxYVectVoB
         XxrqwsA9eu1dK7RFo0kDFIuVFfVSItRwYsgWAHazdcjuBP1m5hNX8FzfBzyaWOCHjDRs
         +os+S66ErvhaD6p4NIKE7Z1vo4nJbfHUNozSMsagbLkbIZZxwAdvFtDU5ifuqm8FC9nf
         +OgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787309; x=1734392109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13GeoEKWgDJmL8HGpvtdBM7JrqVpe1ZXGZGoTYzhGwg=;
        b=DPsEbmceqgfZXYBGbG9SYiwylHZ4iJWQuxWW4lyvgtYZin27a60qM8XCjR0yHgOvCa
         h0HUhDNdKmA3zvRHYs+NHaa1THS1OrDno0o1NgvDsBxaQtAxgBqagZBiBfnmE0EqMCed
         UMf5Z8wTGkL6R47LoGK31pgehea4Zbn0yOKoH3zAT4E+ct+vJdqGNMhlD19hsvVntYco
         oJ9K2aaeGfpvGwStrMGfZuFgKw9Qiotj59Ibfr8VBeUDsXUAZc8Kkw3JKbkVPyIOtI0y
         hz2mYEfEtLAkASvhxYw+dm/EUsFOzeIyoKYa3tHUU4zvXc7CKaI4/W0zbSEYUFrtMlyt
         gwRA==
X-Forwarded-Encrypted: i=1; AJvYcCVAypm/YKFhQTJUyyWdZ0vw0yJT1d/kooTm8rWe/aOAUhBCA/b/E/VzrvhsJn+yHLBNHJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzddCYdFDpSt3LP2jvO4aZeFMLlX/P95ykXs6T6wwVgct5sVXeJ
	Jrw3uU14cPjjhtbdCixSZcMfrsX+YaUqdOqJg9HVCrCInuVEayoi
X-Gm-Gg: ASbGncs0Xk4SyJJCYv6zYqZJsA0xJu8SJMTufg6/mE5V+I8J1/3EvrqsCZgDbZZIr/G
	OL9j1M8kHqDbbWREq/1feFu8rBysIk71vP4xIZDUDwT49ccMjuWAm6nuUs295RQnDIigrnanmLc
	mA5jDASGsmjELaslLW+CPCugdIwzBlRNROd3wMIvs0ZyOcHAJeV6wdb+OOvoobeNcjyUuXFzCWI
	MT+ubYOVGOU1ch3UY6oMgxNB11vwfrUsDFjD5zU7XGYL9Yy6/Pw2mEGhnm3KFs=
X-Google-Smtp-Source: AGHT+IG5RehCD2kprub3yUaWn6JSzbSn/PpawyCRTrlNuhO5C8ad8oaxPStjhvDlTvTtgVmRZNH2jw==
X-Received: by 2002:a05:6000:1868:b0:385:e38f:8dd with SMTP id ffacd0b85a97d-386453f9d18mr1783382f8f.46.1733787308790;
        Mon, 09 Dec 2024 15:35:08 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc26sm14182445f8f.38.2024.12.09.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:35:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Dec 2024 00:35:05 +0100
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, kkd@meta.com,
	Manu Bretelle <chantra@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as
 scalar
Message-ID: <Z1d-qbCdtJqg6Er4@krava>
References: <20241206161053.809580-1-memxor@gmail.com>
 <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
 <CAP01T75PQ3RENtQMD+JkB9DZcsUYp+AH6VJURGO730DkuLUMmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T75PQ3RENtQMD+JkB9DZcsUYp+AH6VJURGO730DkuLUMmA@mail.gmail.com>

On Fri, Dec 06, 2024 at 07:10:48PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Fri, 6 Dec 2024 at 18:59, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 8:11 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > An implication of this fix, which follows from the way the raw_tp fixes
> > > were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID are
> > > engulfed by these checks, and PROBE_MEM will apply to all of them, incl.
> > > those coming from helpers with KF_ACQUIRE returning maybe null trusted
> > > pointers. This NULL tagging after this commit will be sticky. Compared
> > > to a solution which only specially tagged raw_tp args with a different
> > > special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
> > > overloading PTR_MAYBE_NULL with this meaning.
> > >
> > > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> > > Reported-by: Manu Bretelle <chantra@meta.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 82f40d63ad7b..556fb609d4a4 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
> > >                         return;
> > >
> > >                 if (is_null) {
> > > +                       /* We never mark a raw_tp trusted pointer as scalar, to
> > > +                        * preserve backwards compatibility, instead just leave
> > > +                        * it as is.
> > > +                        */
> > > +                       if (mask_raw_tp_reg_cond(env, reg))
> > > +                               return;
> >
> > The blast radius is getting too big.
> > Patch 1 is ok, but here we're doubling down on
> > the hack in commit
> > cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> 
> There are two concerns:
> First, it applies whether or not a register is a raw_tp arg. There is
> a way to detect that (with some register state, instead of using a
> separate tag).
> Second, we treat the program in the == NULL branch as if the pointer
> _maybe_ null, and in the != NULL as definitively not NULL.
> I don't really see how that's too different, given we already allow direct
> access etc. when the pointer is _unchecked_ after entry, and the state
> is same as
> the case where == NULL branch is explored.
> 
> >
> > I think we need to revert the raw_tp masking hack and
> > go with denylist the way Jiri proposed:
> > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
> >
> > denylist is certainly less safer and it's a whack-a-mole
> > comparing to allowlist, but it's much much shorter
> > according to Jiri's analysis:
> > https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/
> 
> Ok, let's revert.
> Jiri, do you have the diff around for that attempt? Could you post a
> revert of the patches and then the diff you shared?
> If not, I can carry it as well with the revert, if you share it with
> me (keeping the attribution etc.). Either is fine, lmk.

hi,
sorry for late reply.. I rebased it, there were some conflicts, it's compile tested,
and perhaps not up2date:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=bpf/tp_fix

jirka

