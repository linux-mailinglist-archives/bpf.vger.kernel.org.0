Return-Path: <bpf+bounces-22254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C985A3C4
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA191F223F4
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607D2E835;
	Mon, 19 Feb 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQe36+wY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEF2E652
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346938; cv=none; b=QjdF6oQsIQAEiQ1UMoK6EN3DYi4DUKvKhy41h/miU3MkgaAHUiVb0gtVOQt7/BQw7SlqOwFpASlde/4xaaI+L6V76ol1usWSIPQwPi/5S8W1uJm5ZdY4QJfApIA+op331AjElWY7GWNDlQi8N3xQu5FEPIuw6969WfbZGL/p4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346938; c=relaxed/simple;
	bh=Qkg7sOQqxOdjsGnDsMAa3DGYmjv1Ob7Zuop8JyPh2zI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrJHyjdZiZdsGiVCkZEA4NIlZ8FnmWJmOTZpGrvr19pD7XZU5kHe1Q+Y32YFsQU0xf7zpKSoL4fDZsYj8JjijTbic2BONyuTBNcYRz0byiM78SBOKU8Dv7Rss6NGEujjkmdbHnuGkEoSaNcAsWsSAjHoqf8m5vJ+dHDOPl3n4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQe36+wY; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e2d83d2568so2966608a34.3
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 04:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708346936; x=1708951736; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E9s+rFV7uPYkPBqs0sAb2x0+MKi4h+BQn8Ust35LmR0=;
        b=NQe36+wYMn4/y+eDvuCSTDaZ+LK1ya1+VHtbtVdCK+MFTzjooRLfia6Miw2ccc6ibq
         gmpHQgq3GRfuMWR8Q4G7AnZyvFH/HnXopgo2OIS9YRFzmm6M8V2QMnsnKkCRJ7tODAGV
         ihG7HtuEIxLOpJ+qE1U3qB01CzPeadAOwICG9FRDBcSurMoOaTgQttTHr1xUJ0p7DBOq
         Mlh3XPgi/5JVNr305+XxiL4BGECOh2QATe/UphBpJoM1M3C2SYyEVGMZg1LzNNK3vD5U
         XM0S7Nmx2HKL2kwjoYDmaL81nwsqIEzqEyXAJGDY0ah9x8JWdkiQGR6B8hOJ0N+/1bQl
         Zz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346936; x=1708951736;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9s+rFV7uPYkPBqs0sAb2x0+MKi4h+BQn8Ust35LmR0=;
        b=agtUfXUWnrfhe5n23AooaSL4oBqmNrLY2uWPDMqbrJ5xuQEtglmKSj/BfPd6nOgH6t
         eVZqM28+F6p/g9EHJ9NwXQdB2wvDs8ROciT2Eo7d3kaLFlNPTTZzXmeU8hcf2WOTxUJQ
         Ds3qsPunwjfJ97vUdME1TRi4H3vA2sNkIvC9yu0jmenrVWb1LTw+ZjG3o5zAT67tONJA
         aZ7Ww81ffmKvlBRLMtuYaiyAUAbnbSy7m3c/ylDb3Hltt9Zc+CrHgQnz/MrKDm4ZmZBs
         eh1ucPl/u1uJiGlDXSB5gbXKNELnjuJ/4GbuIQngoUBllyMGDuFs2vnwd+6yQAxT5gTq
         Gnvg==
X-Gm-Message-State: AOJu0YyGnwZX3p41s48ua9WSWyDn0VmkrAkFOtGO+J8PYo2x1234qyv+
	gOWqLHbLiGeGF+aix/A6KLyQ05p6px5AsmWQz8fzE9vdlJlMcQht
X-Google-Smtp-Source: AGHT+IFm+32ggTDn6YeIgKHOJkEXHQ3zoCp+MKc3i3tL8rBj9mKKPj9nsTdZ/liyG7ZpX6t1iqYidQ==
X-Received: by 2002:a05:6870:169c:b0:21e:6961:9683 with SMTP id j28-20020a056870169c00b0021e69619683mr10506301oae.0.1708346935911;
        Mon, 19 Feb 2024 04:48:55 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ic5-20020a05622a68c500b0042e16cbd622sm517509qtb.78.2024.02.19.04.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:48:55 -0800 (PST)
Message-ID: <57dbae6ab0ce251221aecc03beb7f1fb90a9ab7c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: check
 bpf_func_state->callback_depth when pruning states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  kuniyu@amazon.com
Date: Mon, 19 Feb 2024 14:48:52 +0200
In-Reply-To: <a5002108e494d8811bf121ae18ed99d3200119a0.camel@gmail.com>
References: <20240216150334.31937-1-eddyz87@gmail.com>
	 <20240216150334.31937-3-eddyz87@gmail.com>
	 <CAEf4BzaF8tEt9aTOhKfst9_LoMX5OCV-9iUxHrbk76oet552=A@mail.gmail.com>
	 <a5002108e494d8811bf121ae18ed99d3200119a0.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-17 at 20:19 +0200, Eduard Zingerman wrote:
[...]

> > Also, shouldn't this go into bpf tree instead of bpf-next?
>=20
> Will re-send v3 with fixes tag to 'bpf'

Sending via 'bpf' tree would require dropping patch #1.
The test_tcp_custom_syncookie is not yet in 'bpf'.
Note that patch #2 breaks syncookie test w/o patch #1.
Should I split this in two parts?
- patch #1   - send via bpf-next
- patch #2,3 - send via bpf

