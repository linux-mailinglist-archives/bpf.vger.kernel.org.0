Return-Path: <bpf+bounces-78418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C2D0C72B
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051A53019E0E
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886E345CD8;
	Fri,  9 Jan 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Quxb4DcG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F3309EE9
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997196; cv=none; b=VF+tcR9rw/3W/tF+pKz+0dT8sZfRaQWSF3qxGY8p8Mmd4OjuCUPLlO1+ATnTxpq7Qx1ZEl7OL54w0YfT9UNeCF3xqU2aJbkpwuE5lqrWFZa4t+MluS9gTl/ZqlGZFk8OaK0jkc3bBPlFFp963mMQCveX6xvU3J0eo6PSc9S65sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997196; c=relaxed/simple;
	bh=Ne8i7YXeFHHbtqXLBZUSUcbry2cNZf25YM7V9+JlAwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nb5/zeDv4gea3/w5OWxD4pDdRT6xaNALjotLGoDGQxMeC8yZxGwXUEEaLXJPwzsdVdfzRITX8MTFeKhaW/oGeydYTBbJ6ZlAp7/S1ggKif6Iemv++SExwNNdOTm4svTGgdltNH5xp80PNKZRbNR+dWHbPwt05HXFk6NW8vv6Bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Quxb4DcG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc0d7255434so2164367a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997193; x=1768601993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbPWcVBMzVXUFOGyIOPx6vXGBHy/t/RWY588AaGv0us=;
        b=Quxb4DcGsq4lFTc7a8cd5feOyaIW9Y7t85j54aTXzzPPQMKRtNamqG1omXyEleqC+I
         scn7K/0blutBgdiqLAT0JbXTo+M/TvVKzCAGXYZXAAZgYUDdCYPbpEFjZCpaEunwS4j6
         QmcXlyyQE6LWzvNsutIUgUDNu6Sj2yZz7xEgYtnPh0NoUyL740atoMPL3SbjddqVDFep
         t61uwjv9XJHQ3R5DCqLpXX5VUZT0nXCKi70DkMnfQm64pDrZ19JEdG5BmOHb1yBOleGq
         3K5NVJjj5kzlGz3PDm0bnUfCQT+zsnFbZa2cYJABOasFj2udLxW00YPKSMMNrtfQm+xa
         mivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997193; x=1768601993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FbPWcVBMzVXUFOGyIOPx6vXGBHy/t/RWY588AaGv0us=;
        b=cXJSR7ZNFDCap0yPwjjpy97R1huwFSezQGCQeDeTaV9kOzjDjmlgHfJwk5D0BsMfC4
         f/qjv6dDH0cUZvoo0sfNMg85/ZExc0zCtNhicv/scWElgOjpqA8Q76Nio6rdY00SP9CX
         aVcoJC8i6QiqE4eLSbmwCg07po7NyF5gBQ/4RFPIXn/As37GduoOFHC3YThY/tzcMHHs
         6szZzOHJIeKNSmczA8yK752uMxK0Sq7nHIEq7IDbhqAUdvvzt4ffZ1AU3YiSQPLuqBgw
         EHRMVGUga63DavzPlWnBUj0ky1ZxFV9s97McL8CawPyRHivscM6kl9j9nESW3OTroSUi
         7nQw==
X-Gm-Message-State: AOJu0Yy/ri8T8RYkfuiTCLSd35KrK6jeyLjYvoPzHhgWXHZvVlmBnMfN
	Xn6JOJHeJ9d8krKgIqcVq2IrDXfg5ud0Y31nqASEWzyHws8cS2qXc+a/QWpCSoKConeMFca6vlW
	C5Pj0OfCjTY8jDoA5tNHoTXE6pX2ISsM=
X-Gm-Gg: AY/fxX55CpuJI5nsvmqHpq0hTor7xAu7PB3LKIanQOlL0i1L0MYmYKIUEifXzZHGFXF
	+uY5QtIKMQ2hRRYblEXTx/6QC0zSdLkrUCSuNTS1IKPgO3NrXa3R33br+edm6XpB4dqqarL9i1b
	IYzyKJMnz9pt0h9fXw6hrn0gmACe9PITYni95QO9VQ+wd75b/oMRPN2VIIoXZ2Gy+mdKwR2XljW
	rk99h9lWI0vWgDds3zgVLPVVgzSwaRoNYGXamx1D/FWnqZcKtHsGXAFfFgBhbL+UycI631N0DOl
	3HzxiKLS4PpDod2ij68=
X-Google-Smtp-Source: AGHT+IH3vuqgjjW2WAuRgYdnkcaU8n1mipxuShwzdddBX1vd1U+/A+622rG4ZaKhQMfJJpgmVxVfx6hxaRVkbMuESf8=
X-Received: by 2002:a17:90b:3a4f:b0:34c:c514:ee1f with SMTP id
 98e67ed59e1d1-34f68b6628dmr10343568a91.11.1767997192617; Fri, 09 Jan 2026
 14:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-6-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-6-740d3ec3e5f9@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:19:15 -0800
X-Gm-Features: AQt7F2rFEragAz7ZtQCjGKmGIg_QTf2DW1CS_PeDtM-eoLQSEL-Pc97h1bS60XY
Message-ID: <CAEf4BzYy5syWv6P3pDH10+BH0yTJhy9azBEoK2rLKGpnsZ70GA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 06/10] bpf: Add verifier support for bpf_timer
 argument in kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:49=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Extend the verifier to recognize struct bpf_timer as a valid kfunc
> argument type. Previously, bpf_timer was only supported in BPF helpers.
>
> This prepares for adding timer-related kfuncs in subsequent patches.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/verifier.c | 59 +++++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 53 insertions(+), 6 deletions(-)
>

Looks reasonable.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

