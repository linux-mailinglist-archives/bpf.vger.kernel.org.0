Return-Path: <bpf+bounces-66330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57446B3257D
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1ED60765B
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C02D7DF7;
	Fri, 22 Aug 2025 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va5AsPZP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E572D027F
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906981; cv=none; b=kSXfD9vXSV56QPxDFxBul9nTpcepGrtyJIgHjlVmG/Zj2DEiVEjIt7M2fWjC6c+7aNpRAKYNj/9FOW20lZ0EMAdocMtBF8zkzih+TyhMkYUCKeO7BtaQ+ZhxKW2w6PJzIjbQphFMOTssZSfcfg1epFww2RIp3/w7j30IQBErAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906981; c=relaxed/simple;
	bh=b01rS542tZKPi172gNoTGD3hbfC+oEC3o2pLVLoJokE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9yQ7AEWebFXXdgcKfRF55OawldZn2UuyCYVTjB4wLNQfzEUZtvv2am7CFbPh68ZTyrX0PHlyf8OY4F2cRWZ77dhk51uvdf1ntT2dnnU/yMCQsK56LXpx6FUjTiglZhJiKw9y1KUW/qt8uo0N8wFVcpy2U5973Swgzia+bAHE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va5AsPZP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso1586062a12.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755906979; x=1756511779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b01rS542tZKPi172gNoTGD3hbfC+oEC3o2pLVLoJokE=;
        b=Va5AsPZP73MLxibe16Tx0aqDDUquri0vZFVlj5NJ9SarJq2wv6JUyxznbz7kdFkxwu
         Hf17N/6UuKhC2asRIYEGS+/sKEbt8eE+tDetX6KGWcpeQ0wlVHwUzFSBA9VDA+SijLhb
         /zW5URn3wo/uLQugTCdF6rtxlhoA9aCDYREP1W/5O3GhVGUrx3l2zcLMM2MQibNjmeeO
         AWkduuue7JQb5BqVQND9mh9Gyl1P7s5+d4oOgGwthOJr3MGC9474mhL7U04I39lUqpCB
         zOglpCUA1XnzDspcBz8BPkdvx+fAw2I0tjQ9JmzRWGfOmfr3P54evYCFmfpQZiVCn5ay
         vVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755906979; x=1756511779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b01rS542tZKPi172gNoTGD3hbfC+oEC3o2pLVLoJokE=;
        b=wi965dlHvPdcDzYsAIP7lDJ205EOjmG3QDGdaVU14cuX23PL4iRx5KMxs0DQHw+O0S
         1+VdaDgBdias3C/+uPn7TCvS52bwjMFaZ9uXxfmLPDM2AaTsZhC0NT/ALbgF3DgCqjMf
         leGwULl/37LGAnCM0uDKGaunPkWxuPV4Tdz1WHlekBMNYfzP4HEp50aLP9zkibxqxa+4
         WEL/pasNbD0VuqgbRjbPcTKOux20BR8IyG5NGWUDGRNwYQzvTchwXibdBrXtV+g/vTcM
         c62ONy4g5AqHkGQ9hrlgH1nnwnLqbZ2c7DYGwmDNtklmcxDJfoZjdxHAPt/pJhxbZw3E
         dD1A==
X-Gm-Message-State: AOJu0YwdtzcZMM2JV2idsapHx/nCgXt019rPVC9GRx5n9Eg01h08I/1E
	OU9aG6SUGfs/sPFbVzK0PDGUe2zQ48Z7FcTfurcldWZ2J0erIkiP9joF
X-Gm-Gg: ASbGnctDwomiiU04hYI4NZIfRZlXD+uVvcLRAkIfG+uNTZNuf/UP8YKMFlkBqSALloK
	foJxV0+etXg571NgBrU5zE9tGpanqnHzZJV4GVtdPkSGnIzt3SERFVuU+d5Tb/ePdRS84DMNcel
	oKMTZwTdrqV08+2nqq1BAAQvlpi5wSeCw4ALEz654r9/JIJY5AsjX24ympd3s+pUvVOM2JxrLQa
	GmtP12Ix3CQxlrKrI1THrhv7PTsrJ+c78YqD9j0NTF6AL1i6hffTGUYKZREud7wZNmI3R2Hc34I
	m6uUTud/UHl5v2cuUbevvn1TO8ogOlLVAwZ3BhBmpOLkvzKWFKD9e5Oxpw5Z+Aeea1n2kvAV3/t
	HgQd/1+tp/FlYVFadMds=
X-Google-Smtp-Source: AGHT+IGvktgVF4kbMtbmrB/4N0SWWXqylXbxXJBpBr4q5Ve0VN2m9VY9VIcTZ7LCgz9iCkRQfgq50A==
X-Received: by 2002:a17:902:ef50:b0:23f:adc0:8cc2 with SMTP id d9443c01a7336-2462eeabf5amr60469175ad.27.1755906978587;
        Fri, 22 Aug 2025 16:56:18 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889a088sm6937925ad.134.2025.08.22.16.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 16:56:18 -0700 (PDT)
Message-ID: <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Fri, 22 Aug 2025 16:56:12 -0700
In-Reply-To: <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
	 <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
	 <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-23 at 05:18 +0530, Nandakumar Edamana wrote:

[...]

> I personally don't think `best(a*b, b*a)` is ugly. What about
> `best(oldprod, newprod)`, where oldprod and newprod are each found
> like this, using the old tnum_mul and the new tnum_mul respectively?

Hm, given that both are correct if we go for a hybrid approach we can
peek known bits from both.

