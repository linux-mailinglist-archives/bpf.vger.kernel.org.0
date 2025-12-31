Return-Path: <bpf+bounces-77647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D0CEC99F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEE0E30111BE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6230C611;
	Wed, 31 Dec 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0P3nP5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE32BD00C
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767217294; cv=none; b=auW+TR/JyGgs3jjrjGPaTNOZmoSOFECG7BQ2+td04yXytqBX0NiPVZDKX03lJuH1W+NTMGqRHhpwveURh3BzKS82fRfZA+LkxGomFLqKLrgHhXscCqQhXeDf4evHceSx9loDY5wSWPd6NQky6f7AxGrRDZ+Iw5ZX0HopKqD0wWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767217294; c=relaxed/simple;
	bh=DJaFpYX2RsV05gGGInCZ5QoyGhJ1vN5L1bJNVzHMI7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th1Cj87CvkXoiFBimzi1HnT8BhNIBp27ELgZm2xyOpL1XVNx81eJEbp3HWsBQtlqrO3od22yhUlMT5h0toqSrAEtWVZKMrbTBjTPvX+ndqURLh1zT53O3Ot49l4VkZR78sxYXWrQxPNqzZx3wVOJRx1TCh+Kh/TJxCOwwO7XTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0P3nP5E; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so117743295e9.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 13:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767217291; x=1767822091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zukw443LFxg8NUWoCZcjDMPNzgM6sprxwKDNktmJ2HU=;
        b=H0P3nP5EbCnNfhlnuYTr/whtyzKderONaULQuqNDgspfUnf2DhreDHqfpMioyA1Q3z
         qtIV20n3mOyE5WyMQP0J2dXVdXs8opuDYjwLTNhDSDxXOd8Y6SAQPouJlM9ur36lH5V/
         GY6kqMsvH0LcOMoRuTzYK1ibGgKM41uAuPa8/jrijOgX2H6e/Ca3gRYMDXGw3R0V86dV
         RzT2acLh8qtoyAhg2kWj7IZp+laqJiOfJBZRw3LwPCHYP5jAhCs8QKdyORxFhQgRgbAj
         4iPWtSWMiJSPaOCCXnWy8zw+j7OrYLC2aqpLdodeA7lJ7INQUw4BEZ++Fxskw+Q8WJ2U
         Ydyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767217291; x=1767822091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zukw443LFxg8NUWoCZcjDMPNzgM6sprxwKDNktmJ2HU=;
        b=sZe2Cxpkbmcof/xqvn88z5FlTZgTCeNpWstuaaAoqZYrqjZnGp28Nu3Jq1Z7aNeLCV
         WkCKZBg/ZNsedWqd3QAMJBSXCBuWjV2tj3gzoKaqQIunnCnaDw3sxPjdwIxmp9tbltwf
         6JNMb4qTKpfIXjLG6LlTIK1f6HhhG5mcb4lTD/kJxS184fP6dQKEdQVpZnmiy4OwETAf
         frdf+WDIFPH88uzsNr6w87dEWs51k/MNpZM+xDZS2n8ROjs8PtPAz0WjOglG/uokIaui
         wKLSiP75b5SWvuDAK5OLQPSqaiUByJ2pBuwMIPSM/7tggeDgAlJdAncuxqJ+7UsT6uHF
         0MHg==
X-Gm-Message-State: AOJu0YypPKoutSksVuDXylMUtPFdsZg4N5jgkZW2sSoZhxfvf89YlKXF
	DDJvtKQ82fayA5iKteIBjNkiIyTxcXy1G4livRN0zEAx/ChP+4oCMSQ/Vytc0Fm2hIGshbV/i9+
	QZfVrIMO+CFpKpaUPXyKol5T9keTgaBE=
X-Gm-Gg: AY/fxX4qE+lc4JTBAMKwUzCPg+OvJzQSDv/9QhyMgyy8SIJnF8WEBFhhxaoReLKLbj6
	SLaScmL9XmL2j9k3dzZHQbGGR4MXnWvJ4FEvX7UEs6NBnG8otQ91m/9wMkhQTseGBfLWxOohurA
	M5aFA78ETa4XvO3puScbOW7w4yufLOi7FgqlsCgxglwXh7e0vJn/HiG3LzH4Yzma9Vby6zlS/iY
	JsxwdTLtXDaV5ELI1BoqIxkZf+wSA28g8L9L9GGOwpVeAnnSQiam7WAkLj4xbMVoM0KTPGjWDwA
	RjXM1MzRw2pJhH0TuR3ju2GvbsC/
X-Google-Smtp-Source: AGHT+IES1f1ORsw9u+zXuoT9TWPS8zMElb0WjJ5tsAxrzdetkYHYqhrFGufXPoFVVY0LSVd9FlzcOpjRM70YQt4vYgA=
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d19593d0dmr578175105e9.32.1767217291265; Wed, 31 Dec 2025
 13:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231195207.2801487-1-puranjay@kernel.org>
In-Reply-To: <20251231195207.2801487-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 13:41:20 -0800
X-Gm-Features: AQt7F2pyNXDqIJVun6NZEsVJFq8zwrehhcKIQpPpS4Fp7RVbH-m7t7K1oaB06k0
Message-ID: <CAADnVQJWJxCKsT7+aaeTYDpNA9oXw6+8Nw_U0QfEY3-HH3hVBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: veristat: fix printing order in output_stats()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 11:52=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> The order of the variables in the printf() doesn't match the text and
> therefore verfistat prints something like this:

typo

> Done. Processed 24 files, 0 programs. Skipped 62 files, 0 programs.
>
> When it should print:
>
> Done. Processed 24 files, 62 programs. Skipped 0 files, 0 programs.
>
> Fix the order of variables in the printf() call.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Is there a fixes tag?
Pls cc Mykyta in respin. He takes care of veristat nowadays.

pw-bot: cr
> ---
>  tools/testing/selftests/bpf/veristat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index e962f133250c..1be1e353d40a 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -2580,7 +2580,7 @@ static void output_stats(const struct verif_stats *=
s, enum resfmt fmt, bool last
>         if (last && fmt =3D=3D RESFMT_TABLE) {
>                 output_header_underlines();
>                 printf("Done. Processed %d files, %d programs. Skipped %d=
 files, %d programs.\n",
> -                      env.files_processed, env.files_skipped, env.progs_=
processed, env.progs_skipped);
> +                      env.files_processed, env.progs_processed, env.file=
s_skipped, env.progs_skipped);
>         }
>  }
>
>
> base-commit: 1a8fa7faf4890d201aad4f5d4943f74d840cd0ba
> --
> 2.47.3
>

