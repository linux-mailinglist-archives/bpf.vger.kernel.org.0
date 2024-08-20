Return-Path: <bpf+bounces-37572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4A957CAB
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 07:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D431C21347
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 05:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F625EE97;
	Tue, 20 Aug 2024 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UcafYv3+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62528685
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724131035; cv=none; b=LqWngxjMnm2EEGf/To8DIY7TVqRSJvz4VGomQe2qW6+TeZtMmAt/OHFVk6YqkWPYKxfAYclwCKHlwVMuy3vI8DM0Jq7VWgEWSA1mvX0KQMU0yzd7n/bZ545DUQAgi79FdKEOneTGE/4LIMdpI4ANH0KSi1+gYm39XGF2UnPyPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724131035; c=relaxed/simple;
	bh=MuASzcs2JgESdJgHLFM+gVymXMAUi4749BcdAvCqrmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLTp7LHWF9sG7VIrXUit13JLZOakkKlNrsS2LhhTMTGsd320Q4r/g5t/axAwPhjvy1If2v1eLqQVwtrmrbJC13KxvTa48uy0VQvEbyO01RQl8SZLfhL+UcBDY8Bjjv3EWtsnTlGxdqjwQ3/ebNxrQshN278C/2giLt2w/jxjnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UcafYv3+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5164720276.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724131033; x=1724735833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuASzcs2JgESdJgHLFM+gVymXMAUi4749BcdAvCqrmw=;
        b=UcafYv3+PPuYKx+kGb8fAICfQDf6PwnmX12YqV8C5gaEifP/Vkeh/UM/gF7YSueZme
         1pkyWxNVaqgnqZg1FagfwhVGf/qXkmcmVsAxb76HOl8b6D7BSF2jlRHfp8nvbtL3R4hJ
         wHjDHs4gA3EBbbdhTpiZaOcbLYhcDhx/IwIOW3xxSoS2fUP4irdVUvoDjeVBCgB2LZm+
         nkUfiA4F6njasRttEzuxS8meytxqxnSNLQRC6P9B1hQhacSYN523Uf8vH3LzfoPT8Y68
         2jyiHqu8lOrnsGJ53jxpgGjsuNxmcUmxX4eJpiiejMR37BkIHVwtRwXO9CBH22RB3+5g
         VIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724131033; x=1724735833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuASzcs2JgESdJgHLFM+gVymXMAUi4749BcdAvCqrmw=;
        b=K7r/Kc3p2SX3z+OmstKXRKVV7X/W+lKWgTJF5GY9pyGqbDVhGxBbtSHIXOngTD2DwI
         tbNuJEhQVND6spcneQIhVYhbJQP7CXwe+DhWI1zdb2ILmQdRz3QN6R5szy1LAoNeuF0f
         bdqU/JdBs+FKtMLcd3LZNcqhWej6bnOUWMC1GzXRU63Ti5SoD13dIBJILYVMiY/Q46Bc
         lTYi67kJ2vyf1tTQOR+JOTJPOKcXQ6n3hfMFHJ8qcxzIPuXgTkNqsgH7/eAVlAqEquih
         p0Xt8nBxDR0rNbU1B+lO1NDkSnpIHYfQIE4asbhbojZ/dgad2/xHvMQp3qRQodUkNMxg
         5Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCUFamclZoZWq88oDcfCUTxlymhgqF66PaOGfh8AjsvLdLxL1IQnKPqTHo2T1bHKz5lbeJqn2jsYktgd6aw6Av4DgpzK
X-Gm-Message-State: AOJu0Yxpl1fvLozogIhudhEOrAGMgHWOn/LKLEJ82KmTvCig9128JDuk
	QFgL+3Slut3p6a+Q0uP6Ehuuhwq8EtufdE89GQdyNh1myUs799BiJwMmnRhivv+3HLb8nFx0kri
	MHf2B2kjx994A8eaFwjpZ1Y7BEKRMWCQbiahp
X-Google-Smtp-Source: AGHT+IHfrPlvN8+XxJaQBQZz4fzhp/OSucRWlRy0ZXzbPc9/8h1wSiTsGZ2OL54sYgkDKf6jhS2qo1kjmQfJZkv/tnQ=
X-Received: by 2002:a05:6902:200c:b0:e16:5343:ba5a with SMTP id
 3f1490d57ef6-e165343bd48mr927281276.15.1724131032666; Mon, 19 Aug 2024
 22:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org>
In-Reply-To: <20240816154307.3031838-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 01:17:02 -0400
Message-ID: <CAHC9VhQyK=EqZVBduLZCpN3m9pTzPvD_UhMZr92H1BhHbScC8Q@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:43=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> # Background
>
> LSM hooks (callbacks) are currently invoked as indirect function calls. T=
hese
> callbacks are registered into a linked list at boot time as the order of =
the
> LSMs can be configured on the kernel command line with the "lsm=3D" comma=
nd line
> parameter ...

Merged into lsm/dev, thanks all.

--=20
paul-moore.com

