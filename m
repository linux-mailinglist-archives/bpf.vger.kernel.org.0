Return-Path: <bpf+bounces-67622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12FB46585
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C466C5C6ACA
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40112EFD98;
	Fri,  5 Sep 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1wFgFS3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5825B1D2
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107761; cv=none; b=CYe1BirkDucFiTrpRrmxAg0/41nHMhh90duqSktsijUHHHbm7pXNUPLD8lTHvx/oYYADikq2eQT0CEJrElNNII4dTcPiwgaIw/E4WHwLHWS1vZCs6yRnUi68t9gkAF3utgEydj3u5ngAZUTpcHDfJ555pL9Yk9IDLJq/DNgO+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107761; c=relaxed/simple;
	bh=EKYyGcRVZQqrQFwPX1I4TN5xykuTPT1Xtrv9LlO/ANc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnN1zpQWhxGTeXhX55IuDkDwK3Ux/DIwa5I3sLIhgi0qBLxvS+1uFpSBOxCq/Bwh7V5FB7pPPUvYr0WdkeQDO+Rq59KQc6YLxFPfH1IiBC27X3l7WA7mfoIpldHuiRSt+ceZW8eDpza3RKObeqUckT2dr9fphPrOYzEWfnbGlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1wFgFS3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso1559324a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107759; x=1757712559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLFH2OoDXq6gPw/4k3GBBc3iDnb7bUO7R0SFq+4mQCI=;
        b=l1wFgFS3g2BIKdxK7WgJE+E/Zn9pBaqpac634/TH3jIHMSocGa+CcaClnfmwKP64MJ
         VIR9n/SS6fVVG9VNqOPT6OJP54n7kGRYxCg/Gz6h03CSO4O/kWiO1yjZQD4umxDJqVcI
         ltpCnAAXczSwkNA0IFDJ7NhPP+W/cCohQtlp09q9onPWef/IE/7DRh38wo9tqoOPuBIq
         RV4s9De6qx6AFHHWJfSMibhL9HyWzysE+N6TEwy6TgWIZmQM5yLXwuAc2rAF8KdbXHHs
         DVcyJoYPeA/3CkAJypY5OGDitCXLepNA7/HPteVbpJOyy6UwQEv6jt8oXGV1Y2iC3xNE
         H2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107759; x=1757712559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLFH2OoDXq6gPw/4k3GBBc3iDnb7bUO7R0SFq+4mQCI=;
        b=P0EctqJrAdGOskgTI6ocZDxEi7smhA1PPXI+ayy5PUnyI44zffKSCi7/FT0C3suKix
         ja4lf5HsObDR8EBxR722iIzvvaf5L92HqhrklmabDXQGSBZXs3+cTxAUFUDsQT25PN93
         +JED5UJVGx6a79rMkxSyASiP/n8q6YLf/W+bZ8uj9UeM8a+T0SDnyLFkvreZUYWREPXr
         85BeDvBPcswArRsdJwT6hdeyTGHY25iDXfSJj82zQx+6Vrjun6Oq+3hmfJRHQQOpMNYR
         +MMhWkjuFsHyw5z3rm8emCcBG3cTm+GOINEBY5nRF/OJmivn7vrMGC4B5GTU6J3Fe7/r
         BSvw==
X-Gm-Message-State: AOJu0Yz09tZKpZ8HWRFSYSjoU5ip/VyOpoYvbP07Z/otjPxe66HymqO/
	JFLfWDQMEz902Tl4ezhg21wMsf8kAVe8Ykl8mfjq/7gWpD6IHh0kNx7Cjr2XxWANTB4kERuFGQT
	qS0hJiEfTikTxleFNbzBK8txadsj287Q=
X-Gm-Gg: ASbGncusawoFfR3nZxGgcSpYTy/2izpepmjgB+fOmVs9VgLCYsBGUjb8oa9EMaxur8Y
	QqkMG1blhcVmjwATB04Gg503pLYyk9CcBMoaKf/tgWSDK61ZLK20/UqzJPat9SolZH1LZkYvzi/
	B6ZyVUJQsQsHuTsTcOUAkAF6f4jbo9hufyDWNmuDvxpVW3WzyTPCrrw2iIZErRthUkS4ScCLafZ
	N4h
X-Google-Smtp-Source: AGHT+IFzivqH0zAR+A1ZgH6VScHahUufqmE8hMRLQiHJiyuiYLQnQ8ETtvYnlvvCTsBNeHWY6H+SBOjZSUiCh3fel4Y=
X-Received: by 2002:a17:903:2346:b0:24c:c190:2077 with SMTP id
 d9443c01a7336-25173119212mr1311695ad.38.1757107759305; Fri, 05 Sep 2025
 14:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com> <20250905164508.1489482-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250905164508.1489482-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:29:07 -0700
X-Gm-Features: Ac12FXwkArqqKeQQgFHUmGD3UKa25O2TyZDJzYZ6vnpsQzdx3KbPhEdf_lijjIQ
Message-ID: <CAEf4BzbUQPq82VV4OujRgobyMa74QPFo2USygjS8+yUA+UAr5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: refactor special field-type detection
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:45=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Reduce code duplication in detection of the known special field types in
> map values. This refactoring helps to avoid copying a chunk of code in
> the next patch of the series.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/btf.c | 56 +++++++++++++++++-------------------------------
>  1 file changed, 20 insertions(+), 36 deletions(-)
>

lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

