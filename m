Return-Path: <bpf+bounces-28703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8708BD4F9
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593842839D1
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20590158DA4;
	Mon,  6 May 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/tCZ0dx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D37158D99
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021763; cv=none; b=echoiWxNwrhrGC1k7I+IqG2qPL4iDW3YDs33yVi6fHxlFDNF4eRamy6LxCgZ9aDYfQSmrJrt+8mqWvGQ5b8nbmAnqsuU4SXaxG/UclYFLRlB6h43VTBvx7Occ5qIWG1b5l18ZvZ8w+N7AtDT9nLsg1ZgtFsgSNVNF3ku1jtjy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021763; c=relaxed/simple;
	bh=XqrtzgcBEV5YbLEMw+2IN4+q2xbfKEGZwufxIFq4oNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KcSgrBmeri9XFwS1kKq2/dChndGSklcpeF+LbVDs3IXkwqMBe9U/arFe9wMzG78FfJBzFOC80aGFbb3lx69vKCx0aT5zD8HVgOxb90FDK+Szuij31JHMLgyhnFeywMuJv3jgX8+G+GfbJk13PswfKjn1UJ2HO/a+5OSuPISOD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/tCZ0dx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso1563277a12.2
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715021762; x=1715626562; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DuSjLZx0k+gXLvG6GioJ/gS9ZCmzbuvQ5PmqNnJw21Y=;
        b=N/tCZ0dx6UJLw7QG4zHUGdBLBN/LBU/wvpx2KdsDIAylv8pVU9fnjnkVcvaqzHnAT7
         cazVc3FBi97Eb+L/tPkioB+c6agBVEpUUJwHyRayWq9X9bi8WGQZEtxlEMwKnzuw5XuO
         36/M3lE/mqWm+evYGcI8l/MVZUiXjmHrTs1yNPBLnh4jkGBJXTiHD4cJrNS29+ue9Fm0
         ZbYXMtXx6jvP5QqYl+9FygzB/77UsfbJ9LKJv+0KEfmx4zmeKo29P0+ibalw30jzfV+c
         Ki/RU8AgFScTmfeMHa7mUtvEgGmw3ofEPUKGgywnK2bKy2bOGZ+9gA1uD6i9VIcygKFV
         KUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021762; x=1715626562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuSjLZx0k+gXLvG6GioJ/gS9ZCmzbuvQ5PmqNnJw21Y=;
        b=OHOLGMjIqXZDJHUe9HBBJmDPLOhSZPD56sGMJr3ZO0CbkjkFhHONG71uKQbGt9Kp7f
         izf+S3KqkGqRkf5eOkySdZiHMSoorYzw1eGdtcy7TxdrWuTd00uDMQ8Vtau/xPeuTBGc
         i/CAGwg9g3o7//x570ZTenWK4ob0riF05/kSbejCcimlapUQRoF0bHj5ug1Ft6y+U3oH
         939DhqF+dI7VtcVOV2MGhXajag+4V+BtCgRWWuHqLhndwWut8Q6a+ndGbj7tRd82YbOm
         qIfyOnJLgN459OrsgjkaB6Qfri8lg+YbXoChPebSZQzk1jyxE5RZC2LBjhXNdlD0oqaY
         oqXw==
X-Gm-Message-State: AOJu0YxSpCCaD/E9rZdYfXQsWJNVdt481v2yAYkoyMa+nsQSwPUPJxl0
	2qUCiHiKd4sQgBCT2NW05eCCotBljWM4fH8JDOQzHSe0JS+gq5hb
X-Google-Smtp-Source: AGHT+IHq4UVmP0Ga+NTXqLZQSTc6vmh2WD+KoYdxp+FSRY2SVdbFTfrtu2NobLxIp47PDYMhH0+Hpw==
X-Received: by 2002:a05:6a20:3d90:b0:1a3:ae75:d6f5 with SMTP id s16-20020a056a203d9000b001a3ae75d6f5mr13692395pzi.20.1715021761055;
        Mon, 06 May 2024 11:56:01 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:7ee2:7e98:c6c4:56ad? ([2604:3d08:6979:1160:7ee2:7e98:c6c4:56ad])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00170600b006f4586193a4sm4687895pfc.136.2024.05.06.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:56:00 -0700 (PDT)
Message-ID: <14531c3db62da3761e0783d12fa67060171ed722.camel@gmail.com>
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, david.faust@oracle.com,
 cupertino.miranda@oracle.com
Date: Mon, 06 May 2024 11:55:59 -0700
In-Reply-To: <87a5l5jncs.fsf@oracle.com>
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
	 <6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
	 <171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
	 <CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
	 <87a5l5jncs.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-05-04 at 23:09 +0200, Jose E. Marchesi wrote:

[...]

> I have sent a tentative patch that adds the `record_attrs_str'
> configuration parameter to the btf_dump_opts, incorporating a few
> changes after Eduard's suggestions regarding avoiding double negations
> and docstrings.

[...]

> I am not familiar with the particular use cases, but generally speaking
> separating sorting and emission makes sense to me.  I would also prefer
> that to iterators.

Hi Jose,

I've discussed this issue with Andrii today,
and we decided that we want to proceed with API changes,
that introduce two functions: one for sorting ids,
one for printing single type.

I can do this change on Tue or Wed, if that is ok with you.

Thanks,
Eduard

