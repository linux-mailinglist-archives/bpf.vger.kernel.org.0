Return-Path: <bpf+bounces-33905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD78927C59
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01353B22446
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC73B782;
	Thu,  4 Jul 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqIrrW4A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6883BBE1
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114765; cv=none; b=Is0Q1Xt3ZoM8k0nfqyKlir45T9Og3BbjG++2RbnHPh6/IYaWbubVb1yjm8QRHX9kHu8SgaMy1v4iQgwOm2TEk7rC0TPNho3/FdgxHNHvjoZXw2NVBqEGhUM0cs77d7PXUpcLXKae7U+H0vaj2+Xm3pAwQX5FRC0D0Hkt6S0c4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114765; c=relaxed/simple;
	bh=wyxOSaaSunoc8eFQeTvoAmzfUNBFPC+mnx/D5YKk1hM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owxFq0IkuHBh34+GzyMbk1YjHHBoqSyHFY2y5WwVbL7HQKKoTBObw4okA2KJL8FjsqEdD7KmXS/Bjcw6IN7MR+6nuDb8c4M+olW9WnO/bU4JBXR28hPI2KYwNAvgZ171ieWWdjSlFLIfMbhSec+hHv4GvvNqFA8fgHnTo9peKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqIrrW4A; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25982aa59efso413035fac.3
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114763; x=1720719563; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wyxOSaaSunoc8eFQeTvoAmzfUNBFPC+mnx/D5YKk1hM=;
        b=kqIrrW4A7QqrtLhhhGyS0gQrA5SCpZSkE215IoBhu3YZvuTF8aucWdfa2ctIsqcLpD
         ZQjvGYVhyoBDIdbce6X9B78WEHFUU8jRFUHTbYQ2emt2g8ukzwecklHkuPjseClyGyAt
         wnnPKKIXNY+YWT6Lfe0EML0V/p+gt/anyvzXbGs08moXCoeIwjvLQEQMM0VoUQfoUdGh
         YHfeIRFYAEr5+K8SUVct2s67yzkxSDWNl3eSAjcW8LmVtQJ8m68QoXPf5nS2ObFO6+OA
         19xXHPoxZlkfqcFRvkZgPtEtZT5EsYQIbLRguINg5yQZmfDd0k+HTrow5038uf0XC54H
         vn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114763; x=1720719563;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyxOSaaSunoc8eFQeTvoAmzfUNBFPC+mnx/D5YKk1hM=;
        b=FUSfXQyxtmejJ1kgmhP4t3u5yMPG9fMMafm6QqqyJ/6r57+XpZhdqrkKsZ4saE0P4u
         yE8PpfNDea7oPeR5CYE24QzUPN3uPj+m9ZUxRpJ5XVkNbaO8fyebsQOM+H+vQYLsWDc5
         H64ZIsDEBsKOesa2MtqirPFd/xYi6oTbvEjljPHR9w9gX9Ap0m2b0ivWX4LEIRSCU4pk
         QeCLpSruL+qZNAkZl7xi7iFN2jP52i4pAfphvBPo2Li1DlHKBOgKZk2sz/HElO+CYYDQ
         n/290FWko3i9+NP7gfBRU26t3pMSP8Bl/FAuNtYiAWg6dlb4AnydKs/o4stnwE1GeQls
         HOhA==
X-Gm-Message-State: AOJu0Yw01QVpXRvYEa5WqL7tff+ZabU/bqQ8rObtceDHiwQN4xWh0xVF
	rxFMT1kldKlLy+gjKrXkwimDOiwoHXpycc8ys8CT+Y2xHxsL9258
X-Google-Smtp-Source: AGHT+IGq0mKKLCYpxi04Jo/E/3kGxUY5I4UNCheI8NiNJ96859SY1Xc4D3tMPgiCTwCsxWpXd0tlCA==
X-Received: by 2002:a05:6871:588c:b0:25e:ee5:e46e with SMTP id 586e51a60fabf-25e2b8b8820mr1866473fac.12.1720114763451;
        Thu, 04 Jul 2024 10:39:23 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708042be4e6sm12495330b3a.153.2024.07.04.10.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:39:22 -0700 (PDT)
Message-ID: <6af4ccb6d6e9dff54f13f6bb51a5b908ac82f76d.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Thu, 04 Jul 2024 10:39:18 -0700
In-Reply-To: <mb61pr0c9ax46.fsf@kernel.org>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-4-eddyz87@gmail.com>
	 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
	 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
	 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
	 <mb61ped8ak95g.fsf@kernel.org>
	 <133f0ecd9ecd92268169034d329e87d22118588e.camel@gmail.com>
	 <mb61pr0c9ax46.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 17:24 +0000, Puranjay Mohan wrote:

[...]

> I have qemu setup for risc-v. I will test this and let you know the
> results.

Great, thank you!

