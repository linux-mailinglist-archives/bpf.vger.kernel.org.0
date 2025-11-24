Return-Path: <bpf+bounces-75368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB2C81B94
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD23423F0
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF7316189;
	Mon, 24 Nov 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMS5nXPg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F542989B0
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003326; cv=none; b=Sa9VazcRqWitnvK7hX4wjJSgkBz2bGKhV48ZpKlaIEjOnQqy98Pk4IZBsfvZ4gcxV26IdNgOT9Gvzc9DbKPK//hQBePxUW2uWHVNN9AOkeL0Hn2mlZnfZxvz4dCsA596OWV2r6Am5XYVVdZz0myOAuwMMBSGOCn0C+M/wKv7UCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003326; c=relaxed/simple;
	bh=K17SCasxUc9jaD8UV7Pgx2v/3PtQLuQPZolvSD0xQ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlCsdgNWq7ANYZ1/uGuzuGb89OmqXHiaMewu3gBy0yEmSjSsaD4SxG3YWlBX89zDaxzpwrRH9QCU2783GBZJ6bJi8TuLNtvuD03WPT7KaIy1e8SD6poelBZZxeyQe+ho8bd5Y1gC4ku/OCMVOZYe1D+Ca0Ly1dJF3GQzWxMfXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMS5nXPg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b32900c8bso2619752f8f.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764003323; x=1764608123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyagmXztlhbE9LrXH/JA6s7ARhaT9no2tEG7vrOEXIU=;
        b=aMS5nXPgTMLUjpJ726eZaAynJPFuairwmgv1tPdIGstWqjnAKaMdlPLWz5X6I1TErf
         JRnflYeGL+gcNNYOaRs7pxEj+dZTqSrwhETThkqPa+QXDzKyUZtZNtvpAObCxIRTl+Ru
         w7TLVB4RncEWeApx0tN8q+Bv/lbov/0ZcfuJSfQe67I+g9nIachucdVQSBVDidF2AcWh
         AKRK9QFLZRyHi4EMsYO9ZOR0PpvvnphE32oCCEMduyT2+EK+K7BHHFQ3rubkkOZRxKFD
         X7sviInKpJlreSMZDMUsEUS1hYDezL31RQjH1yiCO4TmQ2B8XzeUap3u9+MeFTNVwDid
         Ehtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764003323; x=1764608123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyagmXztlhbE9LrXH/JA6s7ARhaT9no2tEG7vrOEXIU=;
        b=qoZY2HKuwJvHTrpfqKyvYX5ee0OOT91IaRJoycFYtDvfkDeWtOtCNuTWAGEj72lijn
         ofo8fJH+Z7WumIuaHYrTJULKMHnuc25/IMjckQ0t+6hO+x0DRLjh/K1RmLlkf5rVU6da
         py33vqMFTwtT/D+QAIEHkIqElLc91Npfj5RwgwxhcY4uPwCjqxWcM9d/DH35tzraXH+S
         LLJTssstoHI545+vJsyn2hJUm3UYY8F0vRzfLGHOuACR/ygdsyYwSeq42Fhe3oMOlvah
         JbKeYRTg8Pc9VDUa3L1CpG/aaRvOzbsS3Ow4dbAVHyaGDzvXPDCMcVrT2m7j8AW8ag3s
         mq2w==
X-Forwarded-Encrypted: i=1; AJvYcCUSRFjyB7MBXsSG4H/V8EV4UldxZ7E/PIfCAp6l/vn4OlqtkdCTdHMC2WXkbJkUnTcKnWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHvyBnY9FrsyBtpyehYf8pKXlPYy+euLeNxYSA/R2Y5pntB7+
	b8iRpMJ6Q1X6Rur4IqflP16GFPjnUNfw2DHA5vx6FVVMpoApmENfH3glEHI5zgF+3dDQXZwDyEK
	OLLZSjpBjgoRAZ6t6IIqDG33Kh64e2Gc=
X-Gm-Gg: ASbGncuVlBfv1OqzI8odM8LCJ/bXK9yyAXdKIWHuhgXoNwwF0yTG46xGZl6QNMMNLuS
	AjelxEbBlENqSC6ukb5d2fuYo0sqSoac2IPjLux45YbWa4D+kq0i4PGR3Aen1NiiFcmDb9Bijox
	0Lnk8Ywvm7Cd6sqmWNWiEjGHJbWoIdK61aBwN2375CVQfTlOmMgNhGDmR9QuWBpDv/e+HN3QHCl
	zdnDq5YGfWrsOloySnqoiTBNbCRpfLFj8r1MSzg2tyPvdPaWQ9nYwt7YkpOsAV7te5K1ARk8RDa
	yedwEIni5Z8=
X-Google-Smtp-Source: AGHT+IEyzfANp0hbf83OcGNfYadnuGVAXiNnFeDgOc5Y3qTuPggUm46ryCgGr23k7XxNrsg4wdJZp5Rs4yKJAyo+q54=
X-Received: by 2002:a05:6000:2f83:b0:429:c711:22d8 with SMTP id
 ffacd0b85a97d-42cc1cee555mr12833977f8f.15.1764003322740; Mon, 24 Nov 2025
 08:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
 <02181509c0573bc63b5c111cb1dadb0e9d1577ff5465dcaaa902181a0fdedc3c@mail.kernel.org>
 <0b55b083-987c-44d2-a3a0-a4dfa9a078e9@meta.com>
In-Reply-To: <0b55b083-987c-44d2-a3a0-a4dfa9a078e9@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Nov 2025 08:55:11 -0800
X-Gm-Features: AWmQ_bk5f028OehiGupH_90rtqgPpG4Dv3K-y1xcfCSQmdQhJs-mkqejUWu3SGc
Message-ID: <CAADnVQKObG_rRmXW1L+eOzwe5265Gtrz=MLfL+mh4UuiYN_NsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: cleanup aux->used_maps after jit
To: Chris Mason <clm@meta.com>
Cc: bot+bpf-ci@kernel.org, Anton Protopopov <a.s.protopopov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 7:56=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
>
> On 11/24/25 10:30 AM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 2e170be64..766695491 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -22266,6 +22266,15 @@ static int jit_subprogs(struct bpf_verifier_e=
nv *env)
> >>              cond_resched();
> >>      }
> >>
> >> +    /*
> >> +     * Cleanup func[i]->aux fields which aren't required
> >> +     * or can become invalid in future
> >> +     */
> >> +    for (i =3D 0; i < env->subprog_cnt; i++) {
> >> +            func[i]->aux->used_maps =3D NULL;
> >> +            func[i]->aux->used_map_cnt =3D 0;
> >> +    }
> >> +
> >
> > The patch correctly fixes the use-after-free issue. However, this isn't=
 a
> > bug, but should this have a Cc: stable@vger.kernel.org tag? The bug bei=
ng
> > fixed affects released kernels where bpf_prog_free_deferred() will call
> > bpf_free_used_maps() on the dangling func[i]->aux->used_maps pointer,
> > potentially causing kfree() to be called on already-freed or invalid me=
mory.
>
> I took a pull request for the review prompts this morning that adds
> Fixes: suggestions and verification.  If Alexei or others here would
> rather have this disabled for the BPF reviews, I'll make them default to
> off.

Disable it pls.
In this case Fixes tag point to a commit in bpf-next,
so nothing to backport and, in general, we pretty much
never do "cc: stable" unless it's a critical fix.
I believe Greg and Sasha don't rely on cc: stable much.
Automation will figure things out based on Fixes tag.
cc: stable is an additional signal, but not mandatory,
and we prefer to avoid extra lines in the commit log when they
are not necessary.

Fixes tag is a different story. We definitely want it for fixes
and related changes even when they're not necessarily a fix.
But a generic AI comment "should there be a Fixes tag?" will not
be useful. If it can say "Should there be Fixes: sha ("bpf: ..")"
that would be nice.

