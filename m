Return-Path: <bpf+bounces-52925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BECA4A623
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12971170E7D
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6810F1D7E4F;
	Fri, 28 Feb 2025 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIYMBiuv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561223F372
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782873; cv=none; b=fTIBLyvb1QEtyYafVBH5xUjrsF4OqKfP14b5YA5hQdWAxiYOqRomOen6AGioTwkJ7VHio19+CaIs3Ol1Qjj6FuTznBQBbFVfIUulkYGpb44OIqlNSwHxnrOFgb9yJVctsUInXFDFgjZ9VNcnuhkaCKawCY3dON2/WuGpqqRHsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782873; c=relaxed/simple;
	bh=aF38iQ2CZR5Dox02Xft70J+LAEKcbOhlDATtDtMo90s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAP1v7nYXgN/V9oK8exZDAn9ocdlpvq2E/rr+YXGXJJ98iEyMTFJTJKYw7YH1tWzy8AlPIH3seqjvaKLByqg1SbEXkSLomDt6AoqKQq8PSHwiS5xU0Fime+yyE35qRn/IbBgc+C3NNwJwhoYnWFyQg4dlrWUjO2TiXol3O0FjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIYMBiuv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso3463266a91.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 14:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740782871; x=1741387671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjYWpDxpuae1du6t0jBBmdMnHI7TDs8YUP675ifh3/c=;
        b=BIYMBiuv1LhO+1JYIXSHJQLIejjAAEcarb+OJudhQ6S/6GdyGSsH+iyemglYY+cDx7
         s6PY2XKhexljU9uR9FTHfa4PHotGe9DCqhElJP81dSS3EnocPjWCxZNOnisi+LS3nFDf
         GWf8xE+AjNe27JRuOtZqfm+HdZlSqsJErcIIQyqJj7X1Jvsseun+mCoPe1XxhVgjCW7y
         UgT0qZG8Hg2OwzmVeXSEWJd0OBQdX8bcdwABs4S6Ls4Tmm30N5qlIZxjnLV8/Xy5rlTX
         IBSkXeCzdBSR8O8nya2q8sLNAPPlolpBxzny4YF6wVNrXSFdKrY5zy6NSe6nuJvq4GNw
         8EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782871; x=1741387671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjYWpDxpuae1du6t0jBBmdMnHI7TDs8YUP675ifh3/c=;
        b=VZfnhfk5mcL0HSZuP3Bdl+Waup0w5zDIU8+eEkRkDWu7OvUfCmY6sEnBis+rmfcIca
         lXh7z8Ok9aaXTjuZvQ+4A4zVCsy+6fuWLnVWWQExnIbdjjcVw6wsjyBdfiMzyBq+Rjvt
         CWYsTQ62kDg+YLqcLn4pxyleEDEnzxTpcLRZugr8YiWQHhLk+JznCdMDnLWnea2uLnIX
         wG2LJBW/xUD2VvP7Po+CXfj5lIv6gUbdShCnZfVwGA6OP+53GksrDuMV3g+zXo7LGQdf
         PgbkeTpXZUw89REuZCEzXiN4xbYmrRjFRa3yw8m5dCM2/mKSlrAme2ziANrTQFu8OSW2
         PT3g==
X-Gm-Message-State: AOJu0YytiOq+eXrE0tjJuoZVt0T7WOA8HI9V0PO5G1Wc0Ks+1ZB281t9
	Enku+EWyZLWj/jA6khrnVsmMmWv6L5RWwOWeAENEUDUTfOFpyg6iJDLG/6r3ivKlh6r2w5ckdjp
	JPrZB9bGfMQ64/sXvVm0PcMqLUNI=
X-Gm-Gg: ASbGnctSG0eme7mfRtXEmooz1xsNBcKRkAd9CXzjpkTF5O1hGD4TW9ONs501Tk/vc0W
	tScIxPGyyYqQ/a+wFuFQ9v+DxABI8oBj+LSw2tsWvlfuLf576XFYM7yWQk9zPtTToTaqgRClP7O
	T54j8Ld1Qi6huR/TESWJlZ8/PtkEPpH7kBGDEf6DkHWw==
X-Google-Smtp-Source: AGHT+IGeky644QwRC11e9UUxFrbh2mXZkzn4u9GgefV2xI2eLWINZ61/jyI+IKGTMYA/iagnHuUMhE1scTKHp2SHaIk=
X-Received: by 2002:a17:90b:3a8d:b0:2fe:a292:793 with SMTP id
 98e67ed59e1d1-2febab78826mr7357329a91.21.1740782870902; Fri, 28 Feb 2025
 14:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228191220.1488438-1-eddyz87@gmail.com>
In-Reply-To: <20250228191220.1488438-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 14:47:39 -0800
X-Gm-Features: AQ5f1JpTgxcyiSaCFYelAUO4b7TePZxMJlQqFYC4nNpRO4N0I-lypwtK_TgoBzk
Message-ID: <CAEf4BzY77xkTjKvNE-T0emQWWMuNN-Z6uq16BWs1Waxzx-i-7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] veristat: @files-list.txt notation for
 object files list
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 11:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> A few small veristat improvements:
> - It is possible to hit command line parameters number limit,
>   e.g. when running veristat for all object files generated for
>   test_progs. This patch-set adds an option to read objects files list
>   from a file.
> - Correct usage of strerror() function.
> - Avoid printing log lines to CSV output.
>

All makes sense, and superficially LGTM, but I'd like Mykyta to take a
look when he gets a chance, as he's been working with veristat quite a
lot recently.

One thing I wanted to propose/ask. Do you think it would be useful to
allow <object>:<program> pattern to be specified to allow picking just
one program out of the object file? I normally do `veristat <object>
-f<program>` for this, but being able to do `veristat <obj1>:<prog1>
<obj2>:<prog2> ...` seems useful, no? (-f<program> would apply to all
objects, btw, which isn't a big problem in practice, but still). Oh,
and we could allow globbing in `veristat <obj>:<blah*>`.

Thoughts?

> Eduard Zingerman (3):
>   veristat: @files-list.txt notation for object files list
>   veristat: strerror expects positive number (errno)
>   veristat: report program type guess results to sdterr
>
>  tools/testing/selftests/bpf/veristat.c | 70 +++++++++++++++++++++-----
>  1 file changed, 57 insertions(+), 13 deletions(-)
>
> --
> 2.48.1
>

