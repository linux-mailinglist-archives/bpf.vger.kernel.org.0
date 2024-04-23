Return-Path: <bpf+bounces-27560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7EF8AEA0B
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2A01F22EB5
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9E13B795;
	Tue, 23 Apr 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGo/PjZq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB766290F
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884550; cv=none; b=geUs/EgJJNGGjmdJaq1bQeTjgLtt0yy/+DC0QFw2eYUC0rALDFIsO+DbGDy4OFBmcfeblD/cnFMQt+Gt1Q0ax/vRimDOfeCvkh/L+O6j3q1L8BWWCqz1nmI4S8UtoviEpODY16GG4VSUFKygtTUe9aSGIbKDMR0VYGs0hYo7kdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884550; c=relaxed/simple;
	bh=xT4PPX+ufck5q9VZr44LtvXntLgsX8sRkSWKOZahJ2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/K5hYSw2q6wQPCHzZoPLgDgCmvc2WZYQLEMJ+XAXkWP1rl3zUXzloJ1YebtrraT0SH1n8Vdm6KVHmyma6pG4cUaylEK7tNN0QdGMzJndUziCWoVPKq6aOQjhuUfQwjmR0IvXqA/oghfIdlSXiQYhH2ti5+MVabStVlMp90b41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGo/PjZq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34af8b880e8so1492331f8f.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884547; x=1714489347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hw88UBD+WjDSmwEzT4cwff+eJzsbEmLW8/T+nRVFXE=;
        b=CGo/PjZqvmdwZXZ060+3Y9Yuk2zJS03LdRpW8KR0dUiQJ+aaFjEE2wHXr/TyE1ol5W
         LfK/9uPkc3LHfV5KZzXLExY2n+W5wlN1ZY4jktHj6gaoC4iyw2xpElhjI1mo+5Ui6qyb
         UiHJIC7jbu77wEn5IT93eU4ilMtEu/G0jTjT3KBSrhl7BmdTUXpK+vHQ2JvWuU5khDpk
         bpgg9m9k5uABph+pBj49yJ/ZE12WW7+ZDIs4vKZ4bPjg03pIYjqGPLUTWt7f+vWHu97B
         20D9XLTmKCmNxPHHxe8m6ptl3z3seNzslBVL+Vhy0FqKih+jDCqGsArmA3Esf0TVWfr7
         iu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884547; x=1714489347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hw88UBD+WjDSmwEzT4cwff+eJzsbEmLW8/T+nRVFXE=;
        b=dTmxCN924JnEsE/dgRft7SQ2q3cFKRRRFHyeaIzlVQ/BXGTslXyZQst5dUKVCCMIAv
         namuPoINuYMgi5LAmbZEX4QRr+HoalxwHPBD0H6phnOgqTgGL200jFuW/QbG0pWP6P9Z
         6IisKqEV3NdodFqy+FTvj61CzwKHFgms8Ds6c0PUiD749wfM2uN42FHLtfFSgRcH9ECW
         OTO2zJasrz+MclznXbCWGRfipnrc8zgqQ4q5wv/byQEDF/ytdWEaRWjckdDIJZ2eQrsr
         LEAXYkFpg95XgJSWUpPs1pfu83mNoBN3ACDsO/QfXu3W83vYVMWrqCIRGyJD50lwiOTg
         zqAw==
X-Forwarded-Encrypted: i=1; AJvYcCWX9F2nDsfpytO4LbltPh0q65S+mJ9nYoO6HV6E7hC9eOWiDeEKbhpKbqSo7n64fo+mTp+uf/Xqfx06wHwfT379g5v6
X-Gm-Message-State: AOJu0Yyiacia9uSGZj09IFKSWFVVmkce0lL7O4YkuY89NeQmodaKANMz
	ICZ8wSBg3AGjapzL9RnZV6jj0Gp/oFzDGVrVKIBXqumisuNAQVnUSc1/twgVARKUUfswRE/ynDD
	LNb3p5Z3gxNQ7hB+2ksNrwtFIKsg=
X-Google-Smtp-Source: AGHT+IFY239VaEZxSoZPAltgtEKljOZStEQnIDy8RDqR8ScEpEBymBgvqTJckem48ZtdFN9I/KCxpDh3Zo0nIwnwtns=
X-Received: by 2002:a5d:4b03:0:b0:341:b5ca:9e9c with SMTP id
 v3-20020a5d4b03000000b00341b5ca9e9cmr1742665wrq.25.1713884547038; Tue, 23 Apr
 2024 08:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423061922.2295517-1-memxor@gmail.com> <20240423061922.2295517-3-memxor@gmail.com>
 <ZieYvK0GXs4OkTy4@krava> <CAP01T74v0SCoCkg1gJnz4xPsBc5Q7bV0=-xXKfo00z1R5bz0Aw@mail.gmail.com>
In-Reply-To: <CAP01T74v0SCoCkg1gJnz4xPsBc5Q7bV0=-xXKfo00z1R5bz0Aw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Apr 2024 08:02:15 -0700
Message-ID: <CAADnVQKN=ABKTFmDvbmZK2RmYLA--Yn4KGqDU7ujZbuHgE311A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for preempt kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:06=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 23 Apr 2024 at 13:17, Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Apr 23, 2024 at 06:19:22AM +0000, Kumar Kartikeya Dwivedi wrote=
:
> > > Add tests for nested cases, nested count preservation upon different
> > > subprog calls that disable/enable preemption, and test sleepable help=
er
> > > call in non-preemptible regions.
> > >
> > > 181/1   preempt_lock/preempt_lock_missing_1:OK
> > > 181/2   preempt_lock/preempt_lock_missing_2:OK
> > > 181/3   preempt_lock/preempt_lock_missing_3:OK
> > > 181/4   preempt_lock/preempt_lock_missing_3_minus_2:OK
> > > 181/5   preempt_lock/preempt_lock_missing_1_subprog:OK
> > > 181/6   preempt_lock/preempt_lock_missing_2_subprog:OK
> > > 181/7   preempt_lock/preempt_lock_missing_2_minus_1_subprog:OK
> > > 181/8   preempt_lock/preempt_balance:OK
> > > 181/9   preempt_lock/preempt_balance_subprog_test:OK
> > > 181/10  preempt_lock/preempt_sleepable_helper:OK
> >
> > should we also check that the global function call is not allowed?
> >
>
> Good point, that is missing, I'll wait for more reviews and then
> respin with a failure test for this.

I couldn't find the check in patch 1 that does:
"Global functions are disallowed from being called".

And I agree that we need to allow global funcs in preempt disabled region.
Sounds like you're planning that in the follow up.

