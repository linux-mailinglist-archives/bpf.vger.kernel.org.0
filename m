Return-Path: <bpf+bounces-37757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CFC95A4C8
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD682B217C7
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA901B3B10;
	Wed, 21 Aug 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJSTpJTR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE71D131A;
	Wed, 21 Aug 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265570; cv=none; b=ZTYiIYtakewy+u24DmwC2jMq54irqA2L7hhIJOKzTcuYFI1TEqTfKI7NUGKP0I3LrzN/05MGYviT3WVFeyJ2leKnCDoyi72Ttb6TP7jgaCit+wJi8H2IUSUiNFg7+XM3yEBT0Ws2aPoeCH1Ro668XQty56jgjIxqbcafMCBKnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265570; c=relaxed/simple;
	bh=WkTiCzpD7T3jDzTals5ZYh4omA4Pa4AjPRfQRvjhdtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mu9B5DQRa+ktVejVjjn2CxJ1OpuNz6Qnqe4PnwE85nr6+x2kXhWX4rjsNTc5R5o9SMqDFzIA1MvJS/90JGiaCHGvfpNUxOudORHhYN9UivKSxaE558gBuLyh1qpkuGRPkVZCtcPpWkjaDq8wnlbsByOpsKEH0LyLaBQcv9HhnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJSTpJTR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367990aaef3so4412217f8f.0;
        Wed, 21 Aug 2024 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724265567; x=1724870367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkTiCzpD7T3jDzTals5ZYh4omA4Pa4AjPRfQRvjhdtw=;
        b=kJSTpJTRk9PIIkuo/2n0SbZY6yi3egKWaQGeMimftueL37Gf4Am73fHSxYV8+ynMHp
         XwcnwbHlE1KQEXa+TLaZhCfssysaNIRntwh90kF1XX9WDvRv569cB5dcQdDDAAfRKeSf
         0bzj5ke126RGXaVqC8UPVkpsNSNV+9RsnCeR01zXokx0z1S5V+7P9sOoBznTHDb/LYaL
         p7QqZrBopBiHZ6HVYDxCCAP3mPzdG8VG7I/LsWTqztMpbeNr8DCoa7jui3zXBbN36e26
         W2szto8xw5kwSS5eGgHqzX0obGmdyV2Lp4IuZJQoCzbovbffZhmNAa5paGICvZTeURXm
         FuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724265567; x=1724870367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkTiCzpD7T3jDzTals5ZYh4omA4Pa4AjPRfQRvjhdtw=;
        b=S42gCIYIZf3epY15kSSHTvUsNokSIyC5+6Ab5sP+8Vv156X512ArwKjv4QLHRr/ry9
         lPL6L69NZ3dbiZHi/st1pii2JdcXGL5OHL7Hd8nGl7BAjptMuBaszKaTVE1otmCObApS
         DChEq2TnqeOBttFmDAh2mbwi8x6FR9EdzVhveXGrWWYvCLac7MsHmMXDIBM6LDLsUJAT
         pvWpK/huy7GhbPBRyDY1Ao1t99oVKyBmGi6YukWRG1z/2M4TfxMpuGXMNdcYUgAsBV56
         YEz7skzeRIRlGKpqo13i+cFQOlYV32C8A3Cl95DvOSnx0zLtP/mqOrA4W3KiBJGJrHef
         5jBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLws0Estw4ieHBZpi7cny07W9mW//8tT5xrUj/Z8fo+mqUH3b9vRfK63TsvS1eNPMJmon7C2f83XXa55Nn@vger.kernel.org, AJvYcCX72zo42VmGt3z8XFBsV74t63o5HbDzFueKBGhqFBwGng+8ksCumZQN/OFKZYGABSX5nRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0EWC11QjGwXaGteZJAlOxduEuJrNIe9kuaLTXRdnuhTicIR7
	9p53wN0t82iIm8para2A2E8JUVnRzy09Z3aUYrZwnfKBmb7s14Esj6sjtaE9aD6NwuDVEgXqHLA
	cvQAftJohZ3oI5/vi+bRUPKj4EwE=
X-Google-Smtp-Source: AGHT+IH1MEr39viVsp5qQiJ7JhazANmumy3JOlEUDyr/ik87ch5umBMqTxXSXkxy9BsIwGomj/jY9hJ6DlFUGT4OgEk=
X-Received: by 2002:a05:6000:1a8e:b0:371:8ea0:e63b with SMTP id
 ffacd0b85a97d-372fd731d8cmr2752661f8f.52.1724265566934; Wed, 21 Aug 2024
 11:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819160758.296567-1-aha310510@gmail.com>
In-Reply-To: <20240819160758.296567-1-aha310510@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 11:39:15 -0700
Message-ID: <CAADnVQLpC3-j1g4On95FnHOsfKYaQpeMp4dx4P-ZQqC56tQ5Lg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Refactoring btf_name_valid_identifier() and btf_name_valid_section()
To: Jeongjun Park <aha310510@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:08=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Currently, btf_name_valid_identifier() and btf_name_valid_section() are
> written in a while loop and use pointer operations, so it takes a long
> time to understand the operation of the code. Therefore, I suggest
> refactoring the code to make it easier to maintain.

imo it's harder to read after refactoring. Pls avoid.

> In addition, btf_name_valid_section() does not check for the case where
> src[0] is a NULL value, resulting in an out-of-bounds vuln. Therefore, a
> check for this should be added.

Hmm. Not sure about it. Pls add a selftest that demonstrates the issue
and produce a patch to fix just that.
Do not mix it with questionable refactoring.

pw-bot: cr

