Return-Path: <bpf+bounces-31507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8868FF138
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC7C1F24212
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45302198E80;
	Thu,  6 Jun 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlWCND6L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F1197A75
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689018; cv=none; b=MjRth4NTXtZGCFPXct73hsr26+xTmy/LdnfGNeCUz6dfvqABIQbnnYbCxktD0FYgaGN28lLk6AolDvKMyGmoLM29qthZLiLEyU6rbkMQsJoUTRU2ghmetnAyXfYTfaemLKKGTWnYHVt8IrFqEoR+kLp7IOuWpjhYeUp464hiqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689018; c=relaxed/simple;
	bh=RFSSHTKcL+s3s8Ee5z0VrJPh/fZqueCa9vVyHyxABGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioWc6YoZ96HyvXrVq1RtxmryWiN2f4fVViWIOWZcFdyuMHGPOtBW+mhtCefGHDlJA3LomfW5BK/o/t6ZyXyghpNuMm3ZIUyq+NQleb/WxrfK6gbFxABJdv8J5DJ+dwJQjdM8ZDMwOEwI3t2bO1tK995KnRd2tjGHa49/8YkRRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlWCND6L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35e1fcd0c0fso1246807f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717689016; x=1718293816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFSSHTKcL+s3s8Ee5z0VrJPh/fZqueCa9vVyHyxABGg=;
        b=nlWCND6Lm64W8snfq1hTg0E/VmSCjUCFOriXVk6geldZTj2ElYCG+qBVEaCVL26IqF
         maETdfSS+QU9wqHugvzYVpOVJQ5rzQWmjjH7l7wEZo3dXeHrccuk4axElkTGNprrmyQt
         CDqn5b1NnVtM0wwEWul52SQFZG4kESvk5NDbutie8xjJuHCG+qGkr7pUIUWWEM0RcI4u
         Tp9pgSUE3438YgLFgg98VQL610W8zrsFUkEZQf+8Biiwh+sNYsJSHfkX9p/M9P19AjFT
         pRyVivAEE9+FzRCcrN9RD2daU8onxoFkIIMwNlxmxT+OXevIg5fTSIk9DbugA8WBJxiZ
         UOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689016; x=1718293816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFSSHTKcL+s3s8Ee5z0VrJPh/fZqueCa9vVyHyxABGg=;
        b=C3ZfQjZGnjgpEmE65yWT6SQbYzkO0bsoBd/kl7NxPzPeQgfxy2bTx0WZYEg2AIyizt
         G5s8+rKI5dT1KBvebYSV6G7p/M0HVdD8hJXGutJs+j5dYshNseOcDPaIlzgbys1YkJoj
         e1VPEwaMgSJVsFZmmXPX/kG+WB8e3PnxD8Zhi+TWsIYCjaC9mGlfZru0OB7dFXuYSZrA
         DVXDoou9bupxErVxO3WzFUIHenhilMlye5V1AbqPeFbZPhsEvTCwX0fRsxmy68r9XviT
         SKaZa9WWmA+XpT93dEKToCOFrnUsyVjBmbRdj95DxfcOp4wr7F8J6mz3CDVufSVwq+7l
         MTsA==
X-Forwarded-Encrypted: i=1; AJvYcCVDR0Sn+1X7ZVM7/kmkL/vAksUrbFdTOJRPGqSHce7yuCHObSL5js9S6EoyoTPKnbAtaPmRjUZ+0n9rkYJQ0f2sbN8G
X-Gm-Message-State: AOJu0YwdmR1DkAf95JjA70QytZcbp/zvpgHcYJ0I9v63JF47jyX4Z3pf
	mGCTjGJoBVfnN7eTgkCFXQwvZeu1zIx0fByoUnLeXL5LOfl8g4rXdUpZmRl7izdLKqE84Im5Xvc
	VkpI0d4l43FMnhLqiwNIy/l2uBgsaC5c6
X-Google-Smtp-Source: AGHT+IG1G952XR5Aed9lC7lGQhAoZqxIm34GoOB2gWxd0IDPF2HjloIE2Lk+Il0mMPnjA6xyokEaM86Jt7G3od5Rhf0=
X-Received: by 2002:a05:6000:154a:b0:354:f7f3:5e60 with SMTP id
 ffacd0b85a97d-35efedcb67amr10215f8f.52.1717689015577; Thu, 06 Jun 2024
 08:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
 <20240603155308.199254-3-cupertino.miranda@oracle.com> <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
 <87ikymz6ol.fsf@oracle.com>
In-Reply-To: <87ikymz6ol.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jun 2024 08:50:04 -0700
Message-ID: <CAADnVQJ8sykfiVbRuV8BSSNCxP2p2huOjORdP-0cgXriXeZVQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular expression.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, David Faust <david.faust@oracle.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:51=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> GCC will allocate variables in a different order then clang and when
> comparing content is not where comparisson is expecting.
>
> Some other test, would expect that struct fields would be in some
> particular order, while GCC decides it would benefit from reordering
> struct fields. For passing those tests I need to disable GCC
> optimization that would make this reordering.
> However reordering of the struct fields is a perfectly valid
> optimization. Maybe disabling for this tests is acceptable, but in any
> case the test itself is prune for any future optimizations that can be
> added to GCC or CLANG.

Not really.
Allocating vars in different order within a section is fine,
but compilers are not allowed to reorder fields within structs.
There is a plugin for gcc that allows opt-in via
__attribute__((randomize_layout)).
But never by default.

