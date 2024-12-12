Return-Path: <bpf+bounces-46726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339AF9EFA47
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9654287155
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B8223C5A;
	Thu, 12 Dec 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsZv+2tG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F88205517
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026669; cv=none; b=aB/saPa3TyifzZpo7Uz86eYK7GRYknreIXhLnJGJYHnpabMz1g/4koDaw+R6++rJ2c64ZyPpNzp26jczqbQr2c4WMsxj7tilzjC1RvcyQSO5yvlZUUUB0Rm3zE/0ZWepbeX3mwqrO6mILK/f0ee6ZhkyCgxldpxi0eysW7Ocjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026669; c=relaxed/simple;
	bh=tf2JCNaJz3VG8NhcC+BAvC0d9OhCHHUHZtcE5Yt1ZoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDWMSvKEkiP2RApDvGXs8BYdl4qhjsm3eLOg+B6BxI+70xm+Vbuy4lbzgNgP3ye8pMO+i/KkfoP70GoN0BRzVCd4PZRT3JByf8SVmarKOw09g/Epu6GLQZRftRhUMXpncykY5aW8tGChnD8qLEesyib8RH59kZDtlywDJPsVGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsZv+2tG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728f28744c5so812708b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026667; x=1734631467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tf2JCNaJz3VG8NhcC+BAvC0d9OhCHHUHZtcE5Yt1ZoU=;
        b=KsZv+2tG8QbGo94mJwLOPw5NWjiJYd+p+fa2W0/p3x3t65oxXEx835OTvAjrc/lk7W
         42Iu56O7OlH/O/EI0rWTqMZ50uxgZBtVCk6CNVgLdErDK+xMRwnYMVddvQSlFuHMisSl
         G9tSpxv4WibTMgpTQNF5g06gJ6Nuz8uOAL3+z3uWhXKUhWCI9oyf2arYMtGbQqOEI5ks
         AZCdtq37U7ohrSFtuWKlimSfMI4ZAYipUxHox2shj3LV6ehvFZBD0UFlOGUbkeXjMC6g
         8FLOHHfBFMoFfUQ823dQt3au0GeQPfaZs4w6SKCVG++IAGoW7WdcOqMS03NQSz1WnNId
         v+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026667; x=1734631467;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tf2JCNaJz3VG8NhcC+BAvC0d9OhCHHUHZtcE5Yt1ZoU=;
        b=wowbMeIp8TwNBwzZQwStdl8kqAfKDccWb0POuSbLdsF/8vMgdHRpBagIrxYjj0MGjy
         LAW3gfKD+n2D+XXDJehJDmjgxT9NuBBf4tqdycZrAG4zgaB4D9lrEU1LaVr1ezETXz+B
         wg9vEqfOmPjeQJQOXkGI7ZtrJc4L6aei08Qg0z9Bt6E3SGfsrgsFqfWs+65crB2Z1lVs
         Fh7SejjtpzswWbdtOZYRZN3LFODi3jVSZmf76khzuGKamSxi8VbDLVzARS2l6rn1ABgW
         Nc/0QG4K7YctAugoEFJl4WEHLHV9WUnDa89skTaH77WaEcKUz87hd1IoAt3GwL8z6yjR
         n37Q==
X-Gm-Message-State: AOJu0Yz0n4wIkX8SfzH70rLKkCr4KabcivR9tMflQWy/Z/+GttH25ZuA
	a/tp8XjLLjKFhdgYSoGqBCYXF6n58CwnAq6HzRQk1wgRlTKa5dyM
X-Gm-Gg: ASbGncvb48LsNYY2bOHykvERcu47i0kspwt67GnVaVTzuHT+yLC1//JU3MBM3tvw1KE
	LsAiElGmBMEWyg/6PQkhnp4UNca5urNMPDga3TA/cwsXxWa53uLYLBody+JhzKMmstn9Oo75mGV
	BFYsHMJxmxbjlh2NQNKNatRQ5iWFFP74nJYd9RA/pnjUZmLuZwusEtqVsFb4n7nQbLZ7Y81wGnH
	a7ubuLuN9ZLUSHs7JlERK2xKXMMQj1LaoethgLcnVr2lGJdBWVZFw==
X-Google-Smtp-Source: AGHT+IFim6szj9xTmqnfiaVlHON/ACzdTHkgvbDfl5JVulpLlzwIO0+aFB/LP+LrX2p+q53OBfGm5g==
X-Received: by 2002:a05:6a00:c84:b0:726:41e:b310 with SMTP id d2e1a72fcca58-729069c4298mr1345498b3a.12.1734026666671;
        Thu, 12 Dec 2024 10:04:26 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd2f40dc81sm8715841a12.64.2024.12.12.10.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:04:26 -0800 (PST)
Message-ID: <e7f598f990dd596f9a41abdda2684d27c11e8506.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix NPE when computing changes_pkt_data of
 program w/o subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Nick Zavaritsky
 <mejedi@gmail.com>, kernel test robot <lkp@intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Date: Thu, 12 Dec 2024 10:04:21 -0800
In-Reply-To: <CAADnVQJRFe9EWGFWGtwQJptvnbU4xr+1GC3VO+NcOjx49BZQOg@mail.gmail.com>
References: <20241212070711.427443-1-eddyz87@gmail.com>
	 <CAADnVQJRFe9EWGFWGtwQJptvnbU4xr+1GC3VO+NcOjx49BZQOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 09:30 -0800, Alexei Starovoitov wrote:
> What is 'NPE' ?

Null Pointer Exception, java lingo, grepping through the kernel commit
logs does not seem it is used much. Can resubmit with changed subject.


