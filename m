Return-Path: <bpf+bounces-59227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E591AC7570
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688AF3AED28
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95920E31B;
	Thu, 29 May 2025 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3xSHJCr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49E1C6BE;
	Thu, 29 May 2025 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483087; cv=none; b=B3GA4YdFJpcWsQTT7p9J0m3Mh8PEPEKcommiUsCDxUPwVFlCiK4HX8er4PltCldYZ7cLRpGv8/W1uKB6q1iuvIFh66MtiME47KUfF7uZCpN9wFbegcVML6Hh/Q36DbIrNNGOZoebRdsgHX2ucfRpL76g0drApkuQM2zEgpUMZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483087; c=relaxed/simple;
	bh=AIIEkUyB2uGA9bhH1XPerLbcDl1LNfu/KGNuwW8+02w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyeFkFzsZInC29lWiKTZ9BAxYee1YPdhWhkfIT+4UccQHhIe9wf6lRLdk8jT5YSFoF/NM257FC6dbSio2pl5XNwyCFhdIhiH/9TOeqPdnOAosjhCHW6bLCk3hu2r2Uaqu+M7mTAGll3DggdGheHwM2oZB5/iZX+efrayLTmlmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3xSHJCr; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-70e3c6b88dbso3693467b3.0;
        Wed, 28 May 2025 18:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748483084; x=1749087884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIIEkUyB2uGA9bhH1XPerLbcDl1LNfu/KGNuwW8+02w=;
        b=T3xSHJCroW0RR/CH2WNhA0LItOBkDzFK+bgmqEdG5htdgZkA75ykAp/aqX8cd3kh6T
         iGrf5dMxQDZJj6kPkMH6/I9PgZXcLkBRJB/838fzwmFMW4hgCatKBgyaICuDc3eGx0On
         4Lxluo2tjCOUIu1sIQGEw8I47HMf9zSixwRArNvhARiQE+iJ2dA55QueIKgb1wQAnxMr
         1+/tYIqUztoqhoUIDFshGDP/1dMM8oSDr2NRLoytxSgc4soD8mNPy+2/oyqxII9e7dQ7
         7OROipHKFCw5d/M/FSP+vPcKwE1KZCca7bHYaayZgJpxk2mNFVd9Pev5sbxuMCd4a0JV
         XZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748483084; x=1749087884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIIEkUyB2uGA9bhH1XPerLbcDl1LNfu/KGNuwW8+02w=;
        b=nAw7eZX3ymJN2GKfFvd8KCXHSc4Xs/cflFnXxAuHnd8KcMVYj29Wqc+DtKZSbZtEyE
         mlRle2B/D5dnNLkImSvf3ANUmfjekFuf9PKXn+m6MDwO9bFLPgSTY43MKf3l1Qvtavfl
         7lMqdJ99NOknRMlaYWc89j9cmff5n94KkwGGsJLztMLhmbTQ3riMODnMl+MD8ZjqxRyB
         XdzUrbziVAXgOCCan7NXxFmTM0ZCMlsJDoggUDVUi66yANXbeoTzxmomBbOx7bw7HpR4
         zpbZivkPHjtMnW8RMZeALQ0jXGW0xUjiU9TfGt7pygCP3XBVteM4Lt1AhHFwT54aBmnx
         54hg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4B7MgIJO4gfb7TnQlZ0DfXEvtpA4cBQJVERN+9b/QKGOYn9qWfixO6s9wah4rFCVBRs=@vger.kernel.org, AJvYcCWhXnaouW5j2MLNpJebToCJYNNs1OT/NbXwpqcPixRJEua1qy9m65ZwcTT7bCqts3n9yBVpoB0B7OPGpng+@vger.kernel.org
X-Gm-Message-State: AOJu0YwykIK+o/DZS5g9XnduriOgIpzk/rkGbIC/NdjB8hkaQpcwKxKV
	19BbyMEAHiqQVslWbi+2YpkXwdASi2HKeUpEUTosH9/2+RVA9dH5eOfDQlxFeQTTtVX7I/M05KI
	WAYGmHTc2srkryoWzSRIDUOOa0xueUiU=
X-Gm-Gg: ASbGncs7hZ9n5VtRm9CXgijKqsS7nGw0rBSe9Tsy2lsePHvsvIWIrig+JtIXGgAZrmB
	FVYU12GRMVHHnvkCEnydaCzu8zqkFP+4Xu7wjH1+v1RoG+/Mnq735q5e/A6J1+kWnnJsCr10gum
	yEjxHRsc377eLAaFDVka6HRiXgjDNQA/oD
X-Google-Smtp-Source: AGHT+IERviaO1CpHEPZjKdDhxEfIcJxt710vEw3CCF0Mfdlr8P8jY/I/u8SLMRBEy39lzLn2DMfRyXqnsCLoDlf0R64=
X-Received: by 2002:a05:6902:1143:b0:e7d:aa21:1aa6 with SMTP id
 3f1490d57ef6-e7f7442737amr483964276.2.1748483084152; Wed, 28 May 2025
 18:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528034712.138701-1-dongml2@chinatelecom.cn> <20250528095150.02e28aec@gandalf.local.home>
In-Reply-To: <20250528095150.02e28aec@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 29 May 2025 09:44:21 +0800
X-Gm-Features: AX0GCFuJqA3QgOvGz1p-RhbVE131lL51MCP1IaCXGppSynKajkxUHSGNq53j3_0
Message-ID: <CADxym3aSxLg8XvSsEQzi=me7fWmNs7bsWfYYVvcg7U=JL9VY_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/25] bpf: tracing multi-link support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: alexei.starovoitov@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 9:50=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 28 May 2025 11:46:47 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > After four months, I finally finish the coding and testing of this seri=
es.
> > This is my first time to write such a complex series, and it's so hard =
:/
> > Anyway, I finished it.
> > (I'm scared :/)
> >
>
> Note, sending out a complex series like this at the start of the merge
> window is not good timing.
>
> Most kernel maintainers will not be able to even look at this until the
> merge window is closed (in two weeks).

Hi Steven, thank you for letting me know.

(It seems that I need to spend some time learning more about the merge
window and related processes :/)

I plan to resend this patch series in two weeks, which also gives me a
chance to further improve it to make it less shit.

Thanks!
Menglong Dong

>
> That includes myself.
>
> -- Steve

