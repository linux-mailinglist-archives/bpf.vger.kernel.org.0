Return-Path: <bpf+bounces-70967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A4BDC339
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 04:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056A83B5D20
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F491E47A8;
	Wed, 15 Oct 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+evYeex"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB917494
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496344; cv=none; b=j0aBiDWX4nu1nlGx2h5EzljoFfQ7e5dSDdMHjPWt8vTbdq/5WsVUni7SgE/gk5HXjLXYRisx8HV7W5MwtdQeDtrSlfHK59xAdrjTVglJh/CyKVYUSZjgkwO8LUozseJwL7hd6yrAIqlzLAlbSzf1Qyyxq1/zQFN4gdFv7NG3Z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496344; c=relaxed/simple;
	bh=ovsT9HzaGAh9fSCPxIjE7Xaf73imND+dmOguXYT91Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJyREJYOhRHo+drsRF9fBZuQxhPfosE1iJpLgV1XctvNdHRMM6gl5fXAtDi24UMAWtkmljJ3YsDAaXxK+6Jr2dEE7RgN0D8oOWmFVprnlWCLPy1+QI+cuySqsEGMY7r5R0bScGg3hcufbSRVBfpVdoydHzsATisCjJv4ncFtv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+evYeex; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so26702115e9.0
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760496341; x=1761101141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovsT9HzaGAh9fSCPxIjE7Xaf73imND+dmOguXYT91Fk=;
        b=N+evYeex+bmOeZNcqzWvaJwzG0irH1zlZXvSTZ9afU2O4EYG0LVYWSjq2QnmoLA/dH
         0Ylp6pTKLtCYDXtOKiyoYGwgXSNTQyQNpzG2z4LLB96fvynNgLq8iy9wQjHtkpOyWkS+
         ltnb3VQNIPbKJWPVzKXcFbrWI50Nk9RFulCg3yNR1VXUiiwGxGBgMZJugVQlyFbX8pTT
         4ju1eXFcsTTP5Q3/sMH55HkG+a2SQY6HWgX/VRk6jVJviA8b8oldVEaTGMefToCPKgxx
         soKOqH41xuiaOwFu9uS5c3q0hZ4fwohLKOGRphee2kXYWiXGzcxgZvCVgrxoLMOlQIpg
         tW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496341; x=1761101141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovsT9HzaGAh9fSCPxIjE7Xaf73imND+dmOguXYT91Fk=;
        b=ax5fX2kj5iJdp7Awbpp38vPI1pDSj8EL5beNLHRDHph0G10bdQUboCXz261ZRsI6R+
         gNZonR3BKHKnHF+nx5gwZLNqIiHhjQhe3Bxq6yRUiFALj9glkxI+qMj5d+pPc++qbQKG
         4j65vMqQQ6W346v0+eKffER/kuAsUJNMoZH5T2oPQLYLDEPiwJjcvELiYze1nt5SRhdR
         ZQraDkcAIkrDKU/Xl4uiQV1T9jufgy4Sf0WtxHdDI+NNRyAl8F9FthyadIOK8HAf3qvR
         SCloLfBJDpyXuO4M+zdxjiUNj90eCuc+odQwKw7I4LMvhb8k0yTFldPVeVLBfoRzFOvQ
         b3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXp2qbQ/yAkeEvVHYVNXx+yI6h43w1LmhL8M7n1Q4mUE/0wKMVo8M7Xl3VkNTCg4nJhgnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnAsSKvyJl+pNUz0OZMI8yTtA8rfVVAmHE8ctR+QgmBwFFieF
	qUOnd7g3Pjcyr0bulAJ8yEX1pg1YcYyXHWYoHEWUKNvxuqwMaQyJKMK/jrTXl1A2GTQunxGx/ET
	BP9R/4NRSvagLihXs90yLMMR5fa/2JVA=
X-Gm-Gg: ASbGncufVlSjy0WfL1dnP4LZwRK+79xTaK5zh2Z1tYDey0aUdwMCU1zBieWY5eAlElj
	hZ+VGNXs68A423M7l0bwvNzjapo3ANKXXg+wb09S77S4a3tPBfcCY337LW3jiKDgtWv4tYPzdNl
	Z0n8yPmYHt0Wq+jIRI5qUU7qJZTPAAgibga6bVC3Zswrk+uZFPO8LE4NITfJwXmTx42X7lIhEYR
	s/XvtMBa7GozPCvWuzo3Wrh9n3aFtfzdfY6Kw0zM2zzpqMG8f6Pl+wzprM=
X-Google-Smtp-Source: AGHT+IF7oNH/E0uNEVekTX3Tm9X3VMO0ZKJWoIby8hf8YOQofSG9E+8zMc0FjQadaJzJ99xoYzLqPJtQe6Jd5d9A4C8=
X-Received: by 2002:a05:6000:2307:b0:426:ee44:6ef with SMTP id
 ffacd0b85a97d-426ee440a47mr3265010f8f.11.1760496341157; Tue, 14 Oct 2025
 19:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZw_YJKdb4D6Vaj7Vg1koMGuKwcYuEbDvTn35i5tDYEug@mail.gmail.com>
 <20251015024307.7924-1-higuoxing@gmail.com>
In-Reply-To: <20251015024307.7924-1-higuoxing@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 19:45:29 -0700
X-Gm-Features: AS18NWC-KA8bcaqPWQ4Wj8xwtDfJJ-Rjy0OCNE0few8rMBzb7rlHXn-lbZShhxw
Message-ID: <CAADnVQL8PWAqzfdaSYwn0JyX4_TBPWZmCunMn8ZRKJYwgb2KAQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
To: Xing Guo <higuoxing@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:43=E2=80=AFPM Xing Guo <higuoxing@gmail.com> wrot=
e:
>
> Thanks for reviewing! Here's the revised patch.

Please send it as a proper patch with SOB, etc.

