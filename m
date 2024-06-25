Return-Path: <bpf+bounces-33008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCCD915D58
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B27DB2145F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C86E610;
	Tue, 25 Jun 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwZct2Us"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6B1EA67
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286219; cv=none; b=Zh40OQQdVJ1HPbe/a3Y8onqsJ6B0TrROBssj6eZStybd1psC/Z1g49hvyWEIUD1yz9FIAcb0CKKVskg5NxENgAQOSraHMGEsZ+bojpzd7HFV3wyQtn8FKiGDHxu/QrbDBa3bdvtDtKMhqm7IZGMkyMRzlioozwrLfwzZRedwlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286219; c=relaxed/simple;
	bh=BTDnYEzN5qXc1Ngn+z3ZLjibGsB8yI2L1USwLcH5LhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT7BPtxz/ghHDcsAoujDMbMeViR0gWnPz+mz0f2DiIN6BC+KO9a6UKmDKIjRCLINr93taXbzC8yJfMPM/YQ0pcoYeRSsPaYMAdzEISjtJpJJ6jwtj5Svn3E3U7l7m5AYE/fP+O2BezIhKtEBqPwLO7s5fgVuTiz+fEDHud0M9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwZct2Us; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c7da220252so4050526a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719286218; x=1719891018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTDnYEzN5qXc1Ngn+z3ZLjibGsB8yI2L1USwLcH5LhE=;
        b=lwZct2Usko3EkaQXGX9LnWQPxytAyZo5Nq0OTkbRYdLQL5gkC5w0VEz48c0ZW50byr
         xUOcvazW4eaNukUT/pxu/5dzHj6xu0UIi8Yw/KV4/xJRE+XDJZTkb6DBejlsEiDv6iTr
         SNE/32mS+Q4V8/WPqPGpu9+T9P4ZzpGys9sXLMvpQBoxDVuz7cWeZABbGJ7mlAU3kY61
         rU+jeuNys8WXpJFqKYjvXZKgKSGzzaJ9NavT6TxmLXCjugK756JD9OgKW+IYBzaTUhNV
         TFK0CQ3D9gf1BeprWSoOrcs+Pyb3Qgw7g/KFPaM0J6LbG+jfxTGtNYpa3hxU7T+vGIXa
         MU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719286218; x=1719891018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTDnYEzN5qXc1Ngn+z3ZLjibGsB8yI2L1USwLcH5LhE=;
        b=Nmhv6A/NmA6sV5d/fT0mx5ZWydNT5LFA6jBZirfASOGiqQuDhyI14MivGn4LoLLyAI
         L2FCVlQAOXzRCRDfK0CIDN+hk91oyDIEw+KVzWm30khZlnD+T51gV2byVTxrpDNtFku0
         /lO2nDK91b56AeTAPXosZuJ7cShuyuz7L1mA2WXlCtSdT0koRVhip0tlDgo/6Mh5Id1a
         TaiL17bcxkVR4ZJ5eeBPq4Vuti1x/OO9cqMNZv+CUAPLXpNJyMj0Lr550MdJemkLiPKx
         11C2Pu0MbGYfn/CIbYHCIUQ9EfIPRFKCCQDcechvcfBx6qKpwBqPFadvJXd63pakDQwR
         uAsA==
X-Gm-Message-State: AOJu0Yzygcj0MtTek2fSQFL34z+lSa8AfUcXQgZd24OvYDSZYxuc/Siu
	YiHyIe+dHcjpbxHUm4Q7Uw022klshLixPzIBAg46ruPmhgNALP/7NRaAmNVLOB1uhEvFuw2zLtg
	AkzyANibSWEbevmlSD7lVDtpcYHifjg==
X-Google-Smtp-Source: AGHT+IFa+0A3BFsDLvxlP6/s62/ym3BcThf1gDHrlcyB88y4p3lw5BB+z2SKayfrNg4igiFszbj3Y1rS2mzW/Ty7wIg=
X-Received: by 2002:a17:90a:d397:b0:2bf:9566:7c58 with SMTP id
 98e67ed59e1d1-2c86141c69bmr5512901a91.41.1719286217809; Mon, 24 Jun 2024
 20:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b7fbb-57c8-4e4d-9ca1-119548c4d8a0@oracle.com>
In-Reply-To: <571b7fbb-57c8-4e4d-9ca1-119548c4d8a0@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 20:30:05 -0700
Message-ID: <CAEf4BzZvGzg7in6ViJkpNPb6irOCHrg926ah2eFcQv9t-9RuwA@mail.gmail.com>
Subject: Re: bpf map collision
To: Rao Shoaib <rao.shoaib@oracle.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:22=E2=80=AFAM Rao Shoaib <rao.shoaib@oracle.com> =
wrote:
>
> Hi,
>
> Can someone please explain to me the magic that makes the map accessed
> in the program running in the kernel same as one created in the user
> program. What is the use of the map name? can there be collision if say
> two separate processes load the exact same program.

It's not magic. Map name is just a hint and there is no uniqueness
requirement (and also nothing in the kernel relies on map name).
Everything is working based on file descriptors (FDs). When a BPF map
is created, kernel returns FD to user space. User space uses that FD
to identify the BPF map.

>
> Thanks,
>
> Shoaib
>
>

