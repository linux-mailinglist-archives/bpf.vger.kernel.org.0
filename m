Return-Path: <bpf+bounces-19413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DF082BB1E
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 07:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1761C23C41
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 06:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9855B5DE;
	Fri, 12 Jan 2024 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHpsD+8d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C305B5BA
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336755f1688so5080644f8f.0
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 22:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705039346; x=1705644146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlM7X7t0RHEYSLIvi0to7M5Zz9I1Z4MUk5uJ4p3aSNI=;
        b=JHpsD+8d3SvQhMGbpXbpeWRp4NLtpnBSyHDYC7I6g0z4Zg8/Z7muDerYz1IHnPhROC
         YEcaFPQ6uV/SKrl+6my9LZK2/LABO90y1n1aIaDKcw17sLI/8lx1yR7MgMn/xl30lstW
         qxUPXL7ugogc5/KCKqn5qgJTCVQ8GgHsq5SoBwykANVwm/1h8ubecu26wQY1rqMz+eKn
         r7IfZTaG6VSrmzI9NSezF9xgvfSfKTnZfD+vQv8X7k0CjTjV3YFLiTVNTCN1QQcypl8e
         fwp4dcSySCRmeEVVOCST4rL/uC6/Rcfb+Vdy9Fq3CUjDpP/i0zRC/FY94VvUo0cZY8MP
         MveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705039346; x=1705644146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlM7X7t0RHEYSLIvi0to7M5Zz9I1Z4MUk5uJ4p3aSNI=;
        b=mFrOyOl2n8sqUpJYW8r0pZ4mwWjkq8O5qWwA8vkZotP0870UgwwYzCzdlviGuzyNRy
         z4MdwxMyP/kVq7g3yc4NWvnVL599pt0uZro9vmttqUWtBh3tuhVb0Y8Wg7Uy0EQkN+d1
         w/g/oZg6uVOfi6ddHE1lc7htcJ9NAnpd2fv/rDFmNa4eQErm+X5dajdoWYNLV4vylW94
         KPfg3S3igwmZbY2RpaV5OO4Yn0ShsPmj31J/k2U9DmPgV/PNA1oW2ze7epdzxn7mSSoe
         67gj3vvR9lGNvZyTqqA344Al9WhPfxFSi03IXFoZNZXCFh9gpgbwK/8nMqrU52hHSjDo
         x4Hw==
X-Gm-Message-State: AOJu0YxZw5lJjnOPYXXOu2a9OnIF4TriEWF/c/zm4LudgwD4ZObHHF4u
	Ze2QknJy4WeFYMA1L9QIbBmMtZcgm2pXS/6VQ7I=
X-Google-Smtp-Source: AGHT+IGZM4od0Pp1LPFokadNbS61ttn8yDjt3WcAr5w1pnbVZ3GIj3nkvMooMalUT4rTxJnk/jexdTVWq+8YVPA9eVU=
X-Received: by 2002:adf:fe0d:0:b0:336:fad1:ff49 with SMTP id
 n13-20020adffe0d000000b00336fad1ff49mr387479wrr.86.1705039345923; Thu, 11 Jan
 2024 22:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112041649.2891872-1-yonghong.song@linux.dev>
 <CAADnVQLH66gFbyqekSEbpzc+CRYkbMxcCAtBvMcCJo+8tfauqg@mail.gmail.com> <2c6fb29f-0256-4dec-a7d4-ce7bc24f091b@linux.dev>
In-Reply-To: <2c6fb29f-0256-4dec-a7d4-ce7bc24f091b@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jan 2024 22:02:14 -0800
Message-ID: <CAADnVQJD_jWCZQ3iMbaNNanagnM2AKDY3VL227D5O2oDVO4TWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a 'unused function' compilation error
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:29=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 1/11/24 8:59 PM, Alexei Starovoitov wrote:
> > On Thu, Jan 11, 2024 at 8:17=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Building the kernel with latest llvm18, I hit the following error:
> >>
> >>   /home/yhs/work/bpf-next/kernel/bpf/verifier.c:4383:13: error: unused=
 function '__is_scalar_unbounded' [-Werror,-Wunused-function]
> >>    4383 | static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
> >>         |             ^~~~~~~~~~~~~~~~~~~~~
> >>   1 error generated.
> >>
> >> Patches [1] and [2] are in the same patch set. Patch [1] removed
> >> the usage of __is_scalar_unbounded(), and patch [2] re-introduced
> >> the usage of the function. Currently patch [1] is merged into
> >> bpf-next while patch [2] does not, hence the above compilation
> >> error is triggered.
> >>
> >> To fix the compilation failure, let us temporarily make
> >> __is_scalar_unbounded() not accessible through macro '#if 0'.
> >> It can be re-introduced later when [2] is ready to merge.
> >>
> >>    [1] https://lore.kernel.org/bpf/20240108205209.838365-11-maxtram95@=
gmail.com/
> >>    [2] https://lore.kernel.org/bpf/20240108205209.838365-15-maxtram95@=
gmail.com/
> > Ouch. Sorry. This interaction between patches was unexpected.
> > Instead of this particular if 0 patch, is there a way to amend pushed
> > patches to avoid this issue?
>
> Another option is that in merged patch [1] removing the function __is_sca=
lar_unbounded().
> And the function can be re-introduced later if needed.

Right. That will work, but it's not a tiny function.
So it's a code churn to remove it in a commit just to add it back
a few commits later.

To fix the build I dropped the last two commits,
but the issue remains.
If they're resend in the same shape later they will
re-introduce a bisect issue. Hence the question,
how we can tweak the patch "bpf: Track spilled unbounded scalars"
so it doesn't leave behind an unused static function.

