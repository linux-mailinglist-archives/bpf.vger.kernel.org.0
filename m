Return-Path: <bpf+bounces-19093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B6824C2B
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799FB1C21FB0
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0E626;
	Fri,  5 Jan 2024 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRLJ6Py5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC5811
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd1aeb1b02so13123391fa.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704414849; x=1705019649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+fB0dBwSsuUnMxhYkZE9ZCTfNnMQqwnV9ORcwDAkhA=;
        b=SRLJ6Py51So9w1GbHCFIL+IdapCg5gYGa1wpdlH2ZbKvbPOUdlChnbxbqOcG6LLMaC
         7qMxe17bQvb/a5fMXkc1XrOfnu+X7zc9ftcv90H27C7l2347ZWkg0vjHZR2wpeO4aHyT
         IyITEhuEXnCQbf5hlmdhhGyRTGMQiha2t1TxWArwYf8vg5iJVddgiYYDfGORj/4RKzKl
         4C/XnQj+SawLaoM1/EC4HsV1SDZxoaymQY0V5wUj7hSn/MafQs2sR0ysRUQHK6q0zTwH
         YtW/YKPjszNJJDZwOpyh6NX5WpNYCwieIZ4jFfy1f7dZsarHw3II38ZjZqYmv+Ll850a
         BWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704414849; x=1705019649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+fB0dBwSsuUnMxhYkZE9ZCTfNnMQqwnV9ORcwDAkhA=;
        b=VAp3VfLfgP1MrLG9bsHC81JPrErxnYMn4S+a1eLPfQl0ghXPP6eZeiubYcPOeZUPci
         0iCpUK2tvShL/UpaYYOP0xMMzM74mZPSnmymGM08jEaOBz5ToIKA9XfpUIwVqEZea0aK
         hWSdFWnJ1SB6C9jtm9iuNXCjwA0NSegNEMDjO8EGZy8j/RBrhRRZ8QCYcDRiVYx/8hmK
         SVQiuCkNXEVUufCwMDLQXarPvUoH/hXZmyEEFiSw43kptfRwhyqycgbDVbbGJK42c4HS
         JPDyIUdPJ6kccTe0I+uye29y4nNnRJ1qwUyDaoevaITal6g7ElzMq4dktLxe4UD3cKKm
         bUMg==
X-Gm-Message-State: AOJu0Yx0j47DTog3HLCdGgF3uMsbQg9D+s3w3RcFvp4yxi4Rhw2pncgo
	p+A7fopWPYkv60jV9OK01FolWro+Mga120wUjx/pV/KRd9s=
X-Google-Smtp-Source: AGHT+IEBeWSU4UGBfc/GBGSv1UQXJxR7/khdNwjXWixuvYQXh9zyqlR/BgHVVnanhpO5sLFEbd93beffraKvlvrMzHA=
X-Received: by 2002:ac2:530a:0:b0:50e:7dcc:2999 with SMTP id
 c10-20020ac2530a000000b0050e7dcc2999mr722207lfh.61.1704414848994; Thu, 04 Jan
 2024 16:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
 <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
 <CAHo-OowjLmtEPmoo2rQ3i4_3mO0Uy6Sr9+pdcv2qCbahdVVgxg@mail.gmail.com>
 <85731a963139eb226b76069a5422ecbac063dd74.camel@gmail.com>
 <CAHo-OoxanNo=0ppvq940KaUZBMBWjLyMgWCXCMfmyhMR6pmC2g@mail.gmail.com>
 <4e28b260c469164846abc26c1487f565fea98f67.camel@gmail.com> <4c58fcfed2258f92148dc616e41751ff2276bab4.camel@gmail.com>
In-Reply-To: <4c58fcfed2258f92148dc616e41751ff2276bab4.camel@gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Thu, 4 Jan 2024 16:33:57 -0800
Message-ID: <CAHo-OowqMG-xrLOsRbJzv5HNFfZ5xXkXv5gtb=dNaoEqsp4Tgw@mail.gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-01-03 at 01:13 +0200, Eduard Zingerman wrote:
> > On Tue, 2024-01-02 at 12:36 -0800, Maciej =C5=BBenczykowski wrote:
> [...]
> > Suppose Andrii accepts this change, would you want to submit the patch?
> > (or I can wrap-up what I have).
>
> Hi Maciej,
>
> If you don't mind I'll wrap up and submit my local changes today.

Looking forward to seeing the patches.

>
> Thanks,
> Eduard
>

