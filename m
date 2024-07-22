Return-Path: <bpf+bounces-35276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E808E93963B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F63B21394
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C23D96A;
	Mon, 22 Jul 2024 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh0dOOJC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE11849;
	Mon, 22 Jul 2024 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686069; cv=none; b=GVmg155UPrxh0kgupWhPxZrxvLG98Bfn1rP5JO0ks7X8FpA78z5kig3qXzfCmHnLQntnHQLpPSBwQalMpxH1pNntZr5gFQfibU+86+oikW3aRvcYy7vc0xvRi2s83punwc72MfsEbb4RIC1G6wydRCeBR0jCOYVJb1tc/v5U6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686069; c=relaxed/simple;
	bh=o3Pca6/nWFvxsPH/LoOBGMfLo6hyA7L5/ALwx7EaTL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WL5q4UjXAGs2wMLBUZA/Zgb7R0f3uor/EPJKuDVoOktePfizIlgpWGQ38FyaYxQOSS6korEFvOpJq5wFpOJVappvJaWVhQc8RLdgULJIHjTbN/xRLoy8Ot/xxjw9zx8sSgaKsyQ2+ijku1yXXYn1/ADKVQ9AQpmLY1AZy32jrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh0dOOJC; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c669a0b5d1so2872068eaf.3;
        Mon, 22 Jul 2024 15:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721686067; x=1722290867; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9jYVRlY5Jom6MG8i6PFZi0OTtHKBWec2yXb5FBRRi8=;
        b=Eh0dOOJCRvs/OkeO0X8VSsX/KAihXW2QNJ3eSBZ/oC0dvUxSY6Bo/Toj8iAjIeJi1H
         WaTo1g0Q2msM7tOMyNHsEfpu645JEaqgjENV5avnlN5RCTbi5HLKHoOZ3tbtugympyMm
         DSU7NYDeRsZt9e3BLvvGXa3hYVGJ5L1hJm3hi8sgulNoFpRuZvwtgZUh/kHR/zCHWdWj
         jjk6LOpG290Ue21DazFAd2QsGKZL7/i5mo5xt9ARBQMU1moWfDOqh8b4kCZdDWipzbc/
         zCoq0uwiApsBFih0edmpQXlTF9UHfOYejrBmyYYlD+fUgiMuuc6bGTht8oDk3j90+IXJ
         wgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686067; x=1722290867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9jYVRlY5Jom6MG8i6PFZi0OTtHKBWec2yXb5FBRRi8=;
        b=IHNjJShRxOdTcbKawNoT7+GTJNiisu7tpIrbn++WHwBcFJB1hGb+MUe8tuwb60QVCw
         UUj7tC0XAi5pauSvhCOZbMHyxue4dDZIsYUeRGXa/AXz+ySN4OxY13OHpHlvtkh1iP2s
         bU6BXJLWFsJic9UVb5Rx4PJSydxAEW94MUzgoVSFSLAk8CVj7TaSHVpf+2OvvQdgtptj
         e5NqowIa4S33R/HY5soJO8HtRssszwPCzag4W4IeGfQ81AS5M9YGFGd0Vj6Q7/nmw0BJ
         x1TjjIqqsZi4hdNP1sE3TZ3Jc+DlgyyOf1N9vx7s3FP/oBB+f6HD7hlvcgpdFb0TPMte
         Cntg==
X-Forwarded-Encrypted: i=1; AJvYcCXtdnXcDagdnr/xy52u7TqgmQWheOxB97Zv7UozBlPEsHkNa0rXYLrxNW3ggEmOTYHlb1vOAF5lPEBLm0UWIXs92LyQ
X-Gm-Message-State: AOJu0YyE2jQmalnnsLJWz0aM0/Inl/Y6KAU9QogAEPl9YwMuSz6aWCs8
	sctVPZ57sJ3kwHfP4NVgmMkajKjSpYBOQFEGtQbb7BwizfkJAFJX
X-Google-Smtp-Source: AGHT+IFH3aU7Q03ubqj7yL3dombtGXw8/AleHImRaUwZwyIgUkGfiQxvK29Drq4ssgskCFlR+9TpaQ==
X-Received: by 2002:a05:6359:4c23:b0:1a6:1ed1:2366 with SMTP id e5c5f4694b2df-1acc5b09e71mr974330455d.16.1721686067106;
        Mon, 22 Jul 2024 15:07:47 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ba11b1asm5090312a12.47.2024.07.22.15.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:07:46 -0700 (PDT)
Message-ID: <205c38e28799bfe4b78a5e61fd369d5a5588694f.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com,  kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>
Date: Mon, 22 Jul 2024 15:07:41 -0700
In-Reply-To: <87ed7lcjnw.fsf@cloudflare.com>
References: <20240707222842.4119416-1-mhal@rbox.co>
	 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
	 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
	 <87ikx962wm.fsf@cloudflare.com>
	 <2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
	 <87sew57i4v.fsf@cloudflare.com>
	 <027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co>
	 <87ed7lcjnw.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 21:26 +0200, Jakub Sitnicki wrote:
> On Mon, Jul 22, 2024 at 03:07 PM +02, Michal Luczaj wrote:

[...]

> > One more thing: I've noticed changes in sockmap_helpers.h don't trigger
> > test_progs rebuild (seems to be the case for all .h in prog_tests/). No
> > idea if this is the right approach, but adding
> > "$(TRUNNER_TESTS_DIR)/sockmap_helpers.h" to TRUNNER_EXTRA_SOURCES in
> > selftests/bpf/Makefile does the trick.
>=20
> CC'ed BPF selftests reviewers in case they'd like to chip in.

Are you sure this is reproducible?

I tried the following:

$ make clean
$ make -j test_progs
$ touch prog_tests/sockmap_helpers.h
$ make -j test_progs

And I see the following files being remade:

  TEST-OBJ [test_progs] sockmap_basic.test.o
  TEST-OBJ [test_progs] sockmap_listen.test.o
  TEST-OBJ [test_progs] verifier.test.o
  BINARY   test_progs

(Although, there are a few other files,
 that probably should not be remade, need to look into it).

Also, here is some debug output:

$ make -j24 --print-data-base | grep "sockmap_basic.test.o:" | tr ' ' '\n' =
| grep '\(:\|sockmap_helpers.h\)'

/home/eddy/work/bpf-next/tools/testing/selftests/bpf/cpuv4/sockmap_basic.te=
st.o:
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/prog_tests/sockmap_hel=
pers.h

/home/eddy/work/bpf-next/tools/testing/selftests/bpf/sockmap_basic.test.o:
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/prog_tests/sockmap_hel=
pers.h

/home/eddy/work/bpf-next/tools/testing/selftests/bpf/no_alu32/sockmap_basic=
.test.o:
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/prog_tests/sockmap_hel=
pers.h


[...]


