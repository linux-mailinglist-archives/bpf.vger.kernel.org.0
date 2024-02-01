Return-Path: <bpf+bounces-20978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E6846023
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 19:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099902827FD
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83B84038;
	Thu,  1 Feb 2024 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPPz81tm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6441757
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812855; cv=none; b=IPnUYvl7Z0Zb6FqQv4f94N2al1Qni8/YqDdWoVeE8CFF9Rua51zxSXUkgLj5qtYnjf0BmR7kixHS0cdZVxHOLUQChoDUYKrGmfvYfuvfBjQLt7WOS4do3RBji/VEbzH+vk0hL1m99F85q9E60QhkYG0t5XViLDh4rlM7++FV9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812855; c=relaxed/simple;
	bh=eqUC6R9b8oapp0tV5cwW/JRkpHIdDzh/SS3T/89W6hM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jW77GhrnneAzEkSAwjnx3lm+NfPhZ36wjSFLs8OQOoOXegmX6i1ZWo7k6qKB9I//M1GyttWQ7sHtYuBzln11geDc+nYKylw1V49QDZghhWFDDGDPALxNffKtjdUJiT5y0MA0PiBIeLl9OkxHIl2mzQI1CqgJQH7eSQZNiZ0yojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPPz81tm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a358ec50b7cso343966b.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706812852; x=1707417652; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJ4X1gZTcpt3Q4P4jnFANawIukgXCpgEZ2Aky95mL6g=;
        b=lPPz81tm6ffaaaU2RhfudzQIeyV6GzfMST5c+9J2gxqpuZVPU0HDQ3GAh5h88HR85q
         oaBPxtBs7Nl+aoATKw0bgjcVjsLZEWJHu/NK68D3mE5XzUW5bwA8THd7hOT1bvx4AblH
         G85bJh8ljMfjDSXXbY4UvQ9ZJ73Mu7Mev8NCmKsw09U0JRMDEO6jXoiQbZMqMZv1Ih0C
         5vA1KkNtRpbM+Bhsn1YKkgISL+jukZyIy7QvOj4tC1lg0iOHpgPSWyIdnlHRKA1DIzBo
         b2TCbwWTbK7rynd5jMt6kSXeu2hywQjAF09W5gHxZu6hnineAoLEIg9MHdeRFJFX287R
         XrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706812852; x=1707417652;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ4X1gZTcpt3Q4P4jnFANawIukgXCpgEZ2Aky95mL6g=;
        b=nKW83jItdqJxKu56JiUxxtBGATxS134axQtiBL59LoyVqkf4kGUpMFrcUalwy/inqK
         J59rRPz0AItq0OK7gv8iSG3/UhtVk3dUh7QQf0PrRDanCR0dqjEJ03jVhOcVdq3lGl1U
         VXIv2Gn74Eop83LQorlkjzzS/XD9GOu27abnEJuuIo9r4LjypwZFngG7vDDKHFzUPLvN
         bHKRLSDS2SKtoqx400gFIEzDuegNRU2f5NGXkSufz7Lgh1iuizyREvzh5aGaKeq5bZam
         lD+BWp84lk/zxXqcqvYWyq+CBUZ2muw3dwft3oN0pY/lDY7BpPr58ANwSdCZzdStmB79
         YDuQ==
X-Gm-Message-State: AOJu0YwzI78CSalr4wEDA6/Fl/Jnd51zx3zYskUU6dpFg1w/jmcFyOeU
	g4bSrpOMFTSI50+FJcevapfN9IhYKOCYaASEFSrWiT/7RxIuLYrAeNoZekdg
X-Google-Smtp-Source: AGHT+IGSX0LwW9yGbU4uqNtujvlg0+HrHwREU+opJxHBafOAIsW7lPuNGM9iJSlaFWJ33WSnjuB0qA==
X-Received: by 2002:a17:907:a4c1:b0:a35:bd6a:60bf with SMTP id vq1-20020a170907a4c100b00a35bd6a60bfmr9286757ejc.17.1706812851837;
        Thu, 01 Feb 2024 10:40:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUxIlK1tgqsaMNrYzvYDhemTWhd2zjYHH39zTfGPrTmcqBXhG8bSYl8z4ofGDy0Ur4pZskEh5eDrSDnRcHjI41/v41doAWoEBsrBaT4gYFeePCAnVtuWpOjiF6635l05enyH+Z3+dxc8SqIiig8md4+SkbBS7afc/tPqiIMWps0TA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i25-20020a1709064ed900b00a2e7d1b6042sm49393ejv.196.2024.02.01.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:40:51 -0800 (PST)
Message-ID: <74e6199fb62313cd04dc3e3736433135a2098564.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/5] Libbpf API and memfd_create() fixes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 01 Feb 2024 20:40:44 +0200
In-Reply-To: <20240201172027.604869-1-andrii@kernel.org>
References: <20240201172027.604869-1-andrii@kernel.org>
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

On Thu, 2024-02-01 at 09:20 -0800, Andrii Nakryiko wrote:
> Few small fixes identified over last few days. Main fix is for memfd_crea=
te()
> which causes problems on Android platforms. See individual patches for
> details.
>=20
> v1->v2:
>   - added extra Fixes tag in patch #2 (Yonghong);
>   - improved commit message in patch #5 (Yonghong).

Full patch-set looks good to me.
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

