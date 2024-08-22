Return-Path: <bpf+bounces-37799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F27095A8F6
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1011F24374
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6663A9;
	Thu, 22 Aug 2024 00:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7tYS1qO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB91D12E0
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287102; cv=none; b=oe9wF98tv37k/oTPzHjIo9BPEvs8bNqjZ0KSH7yDnkYoNLd8gXkGbDNa8FVuB8+HTdLZCrXUSs9q9GIWptUDVNb8QnFB5fjfmX67W7m06kGynIRkqvO7IYyzpfo3T/6ez9DcHxUTdEyR6Klk40UrmxAy4z/KXIjSsUEvWWCs0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287102; c=relaxed/simple;
	bh=JfHRklfHyYcVupgrsSDJxCDGbNDo5D6xJxOBQ2QkLE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hyyo0SSDGxZoaYIGVQExdf7Zer9FhCVa2dOXjmgEl3tfX1vjj+tERavr8PtSLgWfN9Un3dyukKCFAmjvhufiTOj09sDCAeh+beHn2Dlq0TufiVDu+oEA3NFxiZoq5/IvwJFuhqXanLJKlgERr542Dw9sdZelnL1BUlM8pz56SMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7tYS1qO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20223b5c1c0so2062195ad.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724287101; x=1724891901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JfHRklfHyYcVupgrsSDJxCDGbNDo5D6xJxOBQ2QkLE0=;
        b=c7tYS1qOsv77ok8Umot86ety+BfnO1ud9hAEEwKzPv02G0oDKQvaYDrafdDmn3mivy
         ZpC2OMr2UUceuhRCi69hZBhHWhxHBY5aFLYAsw/b4bPk5tq9UwtSEuxvxf+GTzWe2W49
         2wqqpCyWZvDVuNdNqbQ2vcpiyUB6d9FEVtdEKPVwb8+z+4NZFjriIXNKf8SxceHP/CHN
         px3HrpKDtx7R111GFqQUjHDJqvc9nAx5DHs3a+3wMq/bb0Y7VxnKk/K9QYYnPtjLBVzC
         wFfOGzu7yVQN1p2NGya77kcBXWD4q2BfAV1KjTJEdbsMx6+mzS6YH68j3uPnkXCP/LAg
         Dlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287101; x=1724891901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfHRklfHyYcVupgrsSDJxCDGbNDo5D6xJxOBQ2QkLE0=;
        b=YclERJzQs00sXOz3vsoodSk6l6s5op1ApLFP8ceEG17kpKNMbNIdr+MMQ3yTr5tW7O
         wslYIRILn47wmTgMfBETRddHGA3pvJb4Hwu8mWCGXEbY3RGbsVMovZ1Xj8ZixNqi73co
         0HWNV+CqmeUMw7iu6VV4q2jMKoRCV4vUFRcAETrvSWVrYr48sXvGuQHlRmuLyWImTB0b
         7WBnfuz/kMR/fPrItmAw4gFYCckjDJ5xUgx1UiBNWbRybvmGMjZuH2jRWOkfsRT3rEsq
         fkq0Dh7FO0SF6w/hTMr6me3PlYn9nC1QIJqIc0JXw1uvgxIYDhaLaS2obFAc3bIb/EI1
         OXEg==
X-Forwarded-Encrypted: i=1; AJvYcCVsghwdABSAy6t6V3MhZ5fnhbYNTvWvt5NaIAG3ThGKhIw4yiz56I2tn7hktsvknAYuOC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJhERq+CPqdvyy5ThHUCdAxUubEiUHWn0+YJCQQ6wyTeeal25
	+yQrmh/RoOnhUTVaBVNmTsuyz8SCWS5wmwlHK3TT+DWByZTnvhkwebdh1Qbz
X-Google-Smtp-Source: AGHT+IGIdMLx7guCc0G+PP+LC6s8aCjxvIpcW7Rep53LwqRmXXUfNP4H7tKxa3yG/WW8aEqnmR8kuA==
X-Received: by 2002:a17:902:ec90:b0:202:4b65:65c0 with SMTP id d9443c01a7336-20367e606f3mr48776665ad.32.1724287100705;
        Wed, 21 Aug 2024 17:38:20 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609d2csm1725865ad.211.2024.08.21.17.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:38:19 -0700 (PDT)
Message-ID: <c67bb633ced9a345f35e12ee06e29fbc63318024.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: Add gen_epilogue to
 bpf_verifier_ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, Kernel Team
 <kernel-team@meta.com>
Date: Wed, 21 Aug 2024 17:38:14 -0700
In-Reply-To: <CAADnVQ++V49=-_bK_dSvxG-WxYEOT=3m1u8tQH1ArALKDy+WhA@mail.gmail.com>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
	 <20240821233440.1855263-2-martin.lau@linux.dev>
	 <CAADnVQKgT_vJJfOnFdTa6Gpf8s+_D79DwtT8pNzxfw2H4aq1Fg@mail.gmail.com>
	 <958b4d92363729f1bed444bc1f4a7d58a54275b1.camel@gmail.com>
	 <CAADnVQ++V49=-_bK_dSvxG-WxYEOT=3m1u8tQH1ArALKDy+WhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 17:34 -0700, Alexei Starovoitov wrote:

[...]

> Something like
> insn_0
> ...
> r1 =3D 0
> if rX =3D=3D .. goto insn_0
>=20
> this jmp will be rewritten to point to newly added *(u64*)(r10 - ..) =3D =
r1
>=20
> so at run time it will overwrite that slot with zero and
> epilogue will read zero from it instead of ctx.

That's exactly what I tried on paper and jmp target was just moving down.

