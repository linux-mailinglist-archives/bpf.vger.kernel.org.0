Return-Path: <bpf+bounces-31685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C99017F1
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E35C1C20C42
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF44D8CC;
	Sun,  9 Jun 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wtNdwUqv"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A11DA23;
	Sun,  9 Jun 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717960267; cv=none; b=gj3Ek+4LaFSp+GL1gDCbtT0973stWHQh3Kuf2hYRPmFhx8CJ7oz76rDniqQAfWypS+tdpKVcP3uYpXOX3kdwyQ0PQdbohGTH/I0D4FApk0+aGPkkTBGVnLHhmNG+z2y27SW1DxWoTak9ztrwYVytabW00DS2Gne44tfDEP47l5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717960267; c=relaxed/simple;
	bh=YnJ6yY0kxkf1yXvMuHok1nLzJNsY6Nscx/FJTwHLG/w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BGMdy7vox1+/M6G4RqIWVgjZE4h1/YHOQ8OGwipDUOlcKnZ7KQBuYpPVQrU2Jjgg9POZdx+QQuLEucu5Mw2jutLKJ22QfIBwCA1+xtrooDcLLwLGh/dzg+jMR4IMjZhLY5NfW27VC2r0+FOoRshnWN+uoa7lg6QgC48BqwKV1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wtNdwUqv; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717960233; x=1718565033; i=markus.elfring@web.de;
	bh=YnJ6yY0kxkf1yXvMuHok1nLzJNsY6Nscx/FJTwHLG/w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wtNdwUqvGO7vuU1E3AgUWCHdAoLpEYY7SUz0KUO5yyBkqbiXPPTU7H1HuONe6Mll
	 1JEcKggM9gnlLXGcqFEvzpu50Xv7AY2UYijFmN8p9L1enXgrZTHVdsI2bXOjoMfzC
	 3PUoXJd6PoemlG8B8GCeH/ZIE1Tz6KAQRo4sKjVSQhn8U/GggGPSCn+mBAVmV6uvE
	 XkyZz/GUkX8+MullBkjRJY23BHxnP3FDLLoH2Qdn9E7x6OGdZ7aGWAczvFDEUBD9R
	 EJVLopDTrQRTHZMpfOG4ShngZNcXPAcyrtXVDzOaWEtSpj5pcZ25iZA8aC1SpPli5
	 HCsl9wCnUhJ1kjm61w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1rqhGf3udp-00NdWW; Sun, 09
 Jun 2024 21:10:33 +0200
Message-ID: <d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de>
Date: Sun, 9 Jun 2024 21:10:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Howard Chu <howardchu95@gmail.com>, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Namhyung Kim <namhyung@kernel.org>
References: <20240608172147.2779890-1-howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Fix syscall untraceable bug
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240608172147.2779890-1-howardchu95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:loiKlUeVG/cvD/6mt7zFwk7DiMngcfkEpvsa9j5Cn8qj94nZXB5
 FEBticdnDFBidkOYQiIs0t5ArX9n6wQ8E/dK7g4xsNGQ2PIix6ZxzBoai3pVBjoYa/gYUJY
 qdjBgV2RBPM/lDkVBH6UixCtaFAZRfT1oXUM4hxsz2oC9Swls+zlhUCadXJYlrPWqD6JCiW
 LlNLGVydHqj0AHgMMVdXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fyQ3HizanSg=;BaqCYqzTT646PfgdVySuUOhIlHj
 qTNb4j59hNxbLFXHPHBAL4asH3TInev08YLW90ZKo9b+mmTjqSPZ1wMFMSFPlT2vTlozZiYfU
 SmX0FDztLbEZSuIR3dswbEJDSJ/scO13Lqd3OXUpu5fpJZN3FkqbetaE3+tPNX6LnOzJaTM+i
 086ds2yM2K7sQsaM1p5nFALvlK7mNRSjgmSOky05b7JkrOmgsTW66fB72t5anMYdmnBn2WRIz
 TksYt54asCPCiF9tPXyT/W8RmYClZ36FFUjvQecPcyLd/03eZqNyL8HezsTa06Z15DyT1pVVZ
 GVQSPUgoTIG3e4DVCK8QZdxMDESEerWi+I6qtvCi5RpK7svH1ToD2kXYW6prQKNpZ8NUgIrnw
 YVAJu9cTV75DA7A3Jkvaf62Uf2PrhWkJnnjQ/kM+TWY3A/tM2AZOwO/c+YuDlOzTkprRsj8Lo
 zUDHCzf6VyBqjVwg3XDL3VmCAv1T++cX6or8KZMDJVZnP5MCdSU0PAoje8IUZ1k4ThmnFwGEM
 HvUED3A5+q5CeNfVk/9xx6b8eFsk2yZk2DerpJpswuGGd0b2EIyqvSlr73CdJ9VEJyyxslENo
 XlRCV3BaGKXZF0GLR4wjmSv2sLeMPl4XMvlqMv7TaGVuOntx0ari6qlKnT8zI/JQJGi7Dpsyx
 Fy3zAwRYugFbRjxtvcjXXCggLgQLYPk1GYV1RrS06fxi4eCNOB9SsP5YkJZaAVLIOX7BTMbHz
 zhkKS5IEi6R/i1Itw18ZYn3ZJ1FWMFC38ITW67pHWCNyuU5DkmYGJHKMXPeA4Zm5sQB8Afchl
 y+3uIVynZB0ZQELsfp2PvG5dLyJJkCahX1iQkjO1/bbfQ=

> This is a bug found when implementing pretty-printing for the
> landlock_add_rule system call, I decided to send this patch separately
> because this is a serious bug that should be fixed fast.
=E2=80=A6

Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

Regards,
Markus

