Return-Path: <bpf+bounces-37878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A225295BC86
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D949B21216
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5671CDFB6;
	Thu, 22 Aug 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDT5XYut"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4321CDFAC
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345741; cv=none; b=U3qo74G86SWrOjuVDKpDCUQVlSFXZQDLJot+NFKAmJW44pYXiRUKsuqR4GsKjLx7Na8XA7i+aPeIrptHPlRzn7VSp1+WYQifFK00W/iA9J3lSD6Hf/5OJaOZH3eCN694N3NHGkqZ+ZsH9XOWkn9gsr3WXJNLzQPSHOdcqnR/7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345741; c=relaxed/simple;
	bh=Qd/axUIC6JV4igKPsx1XLpDXw5oUnq4lHICWo+bek+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roeexIZtHx0Cp2bfNsjybxUHvex9cIVgKKukbVnPjxFPYomWjMKnYZyVDVC07QTG6JDJi9G3G9Siykh5sPlybFUXcCJ287s0WZXIiOKx9yX0jNGM/Gf/TpefePsI1gat1FQaeT0IFS62vmoZ92EBDvMyg/l6Ua/l1qObblW7a+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDT5XYut; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso10549715e9.1
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724345738; x=1724950538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd/axUIC6JV4igKPsx1XLpDXw5oUnq4lHICWo+bek+w=;
        b=PDT5XYuteQ6hYsAeAcVoFz5z03Rce9a2h+7xXVUEg5BQ0xJI+1tIIO2EsvP8IJdapk
         pDpw71Wd6ZWEQv9326k3C7wm7mcuJNTl6FDfpq6warPb3bQEkqdpth3VBSGxiu3UcTmk
         kuPG2qBoY+5uu3nC3doYp0jFo98D2Xg8TY5lqc6ScK0wNEn9PrY9w3u4TyNJ83AgOZg/
         aQ6m1P1DNiKswU0IPGMIoUlhxCiD3+FjjmJjHR5HgPJw0/4otPKTpabe/m6SC9H9zXJl
         isYCQYWYBMqhhsU0wfHsFf/BJbvg4tiaXBQFcC4X7+rUEbmut8OWfQcivR9voex0V908
         7HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345738; x=1724950538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd/axUIC6JV4igKPsx1XLpDXw5oUnq4lHICWo+bek+w=;
        b=Qhnjv0BOYw1tLmVbZrX3DS9p52Z0Vkg7Yrrg9D2+bxdkt6Nx/bI/tK2mdnRrcBULhN
         DCP0dxk+PM4SC6nxWWMDhFYpMVPo4Q5JhrJkXVjj+Id8o5+NMexOU3n4oBvgtd9P7PFY
         7m+ToHM833YKz0U722JaZ7HQHG+1hv07WaoKiDX2nzlFJjDhfJeDVMT2FHSH35EMIVin
         h30UjtUvXMdd5J3MhW/dwz/vUbdtCJeLfE+q5dhkTW/hMUPYNOe+FhpVmuSgzFVRi7Ee
         xUZ5FJ6EBLAgknV7eZ8tgIZ7m/NPHDtQ8ES9QShJ4N60sEn5itDhOY0aDwcmqc9RUcqt
         E63A==
X-Forwarded-Encrypted: i=1; AJvYcCXHtHWcm4uWB+B0SBx+3eUFUPGm0K/7qakSeppTIk12JcIBMHQxpu1j9qB8pO2w7TjyC00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEA7DdrTaALQOkLorwDlne7o1wvFh2UFRVNFPVj1vat5Fp2eZ
	BYYab6nYXUtZm1dPznMP8YJzloCzqSNVkI6YxtaeP/b1dbFqSZJSekzq3chM+6O5fcOc1GDRyTR
	YymHuK6xV/3bSKkrHiIU5/BRw6mU=
X-Google-Smtp-Source: AGHT+IGS9wpwY0NGrhIhmO0pcPyn2BaQrKhuRbt9a3iZ7XoYcSfVNjAdh3KgXI5cNy1+fGO6sCmkpk+jBVP4Nf26dMI=
X-Received: by 2002:a5d:4011:0:b0:368:4c38:a668 with SMTP id
 ffacd0b85a97d-37308c00964mr2210205f8f.9.1724345738307; Thu, 22 Aug 2024
 09:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822001837.2715909-1-eddyz87@gmail.com> <20240822001837.2715909-3-eddyz87@gmail.com>
 <CAEf4BzaVjrHSi9eh9-YP37tsH2B5n0ah3m290Y7_v6zBXrEBiw@mail.gmail.com>
 <b058840690d79648405839c2af767a783a41bef8.camel@gmail.com> <CAEf4BzYK9JpdPonHhSARkLRbStMA94URxZ0r5fpaOg693jtLpg@mail.gmail.com>
In-Reply-To: <CAEf4BzYK9JpdPonHhSARkLRbStMA94URxZ0r5fpaOg693jtLpg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 09:55:27 -0700
Message-ID: <CAADnVQ+umPO=jSqv+boTqS_-r_PYJyzhVms4438SxeG1hN0GFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test for malformed
 BPF_CORE_TYPE_ID_LOCAL relocation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Liu RuiTong <cnitlrt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > > I don't see why we can't extend the bpf_prog_load() API to allow to
> > > specify those. (would allow to avoid open-coding this whole bpf_attr
> > > business, but it's fine as is as well)
> >
> > Maybe extend API as a followup?
> > The test won't change much, just options instead of bpf_attr.
>
> yep, follow up is good, thanks

I don't think we want this extension to bpf_prog_load() libbpf api.
This is internal gen_loader use.

