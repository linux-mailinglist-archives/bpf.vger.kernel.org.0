Return-Path: <bpf+bounces-45961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0339E0F0C
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D73FB23310
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD441DF96B;
	Mon,  2 Dec 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMrNPkZ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A51DB940
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179811; cv=none; b=aT5gV4Y9S2W2ei/gABF3KvC6zRaOkWc9K7VV1ZyVmL5hmWN9imzunHxImMoouq85sdpWIuz2WsEcGHtf7infT3St4dJ+buxZE9eeqw2S9MevCs4u5ZczsFL7oOnzruxQQQ6nrD1V2CJh2TkxQBB9rzxVP+mpnzLptvKpcK1GY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179811; c=relaxed/simple;
	bh=s2wmVxA9r9toBGz9DF6TLRlgsPzwAAVQYqm/kqR6I+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBNLDT3SIc/5pl8Oxh4xKJZIPV2UTbN0wOcmGDwBFVKPOs/Nit8KIBIoYAowRutrek1fLW2YNhjwjnaef3k8V+ZzhM+aXZFu/GGVwoOXA4xp6Agu6qC++KWHu9fyomztieyOelyDlxG2Xxty4sbo20VWJ3VZiAPyYv52mlEAFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMrNPkZ7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7251abe0e69so4163056b3a.0
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733179809; x=1733784609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2wmVxA9r9toBGz9DF6TLRlgsPzwAAVQYqm/kqR6I+Y=;
        b=dMrNPkZ7W9kD5tBdTJnfNPXkxfWwWCDNta8B4pHeIgDUiWblT2ZTU09tJ4HX7wHGhy
         TZCAmjc30Z6bWe+YJG+45SkritsmeG2oKTcdK8eaZbOEXRRrBQMlR3qvb/4LQALgtxLm
         T4SQiDHhdBKCXAYRbNsoMQwfrPgBCXzJyqGGNTGRDa9zGtxs82v+j3c0t1LzDjcH+g0A
         08WgxT04WTouyC2qFJU+zUTGgPP3+AX8Ib7E/71x2W8g17iZ8vaHpa0wOH9/yKLYo9he
         k66CB+JrwuwoQ7LPyS8uq5cfRg5wJ2ZEbsDX8jGJym9F1dqYZ16a9ll8zldC4WBrE58k
         E/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733179809; x=1733784609;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2wmVxA9r9toBGz9DF6TLRlgsPzwAAVQYqm/kqR6I+Y=;
        b=VGXfptIwjA5q60bMPy753qHF5QfLsSuWQfQGpS41IHzVN8LGB+wKhxGP1qFHWrZUTk
         xDs50dt/cP4r1UZBRPl3la2GgI1wfUiz4jnSBFxvjioRR8A1zpks1ZRGEwOuWn0uIklh
         saVzVWj90va/5kM0N9/12DWeZl5VFXcKA/n/8Q5JPTSLYmQbSPOwxr15Vk+2q4uImo92
         BR06gDSe2nLelKvgvoTv/x1QtqtHHWufSknUh22yy3sGp8s82d5kOQ14pjd2QbYG+GmA
         gBzGdQLi1Llor4/wFewrbIxKZpq9MuV382HzNvgvEoYU2OrrzG4ao9sTOc6YKgsSTM2g
         m5fw==
X-Forwarded-Encrypted: i=1; AJvYcCXy01iziJNQfLT1M58TXU/89e/JOiDhdCKBRHYqjvygQyPzuU+yu/OoAfafwWKmyZifV8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzii7/4wzWWQPYfqIU3/Nol2LBDECuEUYvWGxaD/izB7jNgwg1r
	OziK5pWYR4CbueVK4ByQiIB8ZjLPui6MPiMLtHeHbp8ckm/Xye4J
X-Gm-Gg: ASbGnctSNmUvlIPo0UcPmgUklV477YH0aAb5Mltm9aRYgLtKX5oSF6AngOHYE+8yBDR
	fb7L8aGKyNhaq60Yewen01MP/VuAwG1TKlQdwmcpnznLRC+Q27AtX0ZQWe5RsO0X6ZBrwrl77Um
	/zx0YACMsh5phYBv8e05saE2AZu9edcAEXy7+IJ0KUd2zfXISi2V/hfOiMNbDBBADz9bywY+Twi
	w3xhEcYqFd2E6RMNUZ72/ngfqPGZZzYD/dYOuD55IUDYTA=
X-Google-Smtp-Source: AGHT+IFIBqknCXwpQareb1eHcO6KrL0/OdIJMfvzfI/ZanKkWONq44pmyhiqMJdZWmJiaesMo3DmDw==
X-Received: by 2002:a17:90b:4fcf:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2ef0120fa09mr414880a91.19.1733179809260;
        Mon, 02 Dec 2024 14:50:09 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee96627b05sm4247380a91.15.2024.12.02.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 14:50:08 -0800 (PST)
Message-ID: <7350c37532a437fdbad8b881dcb89a6452c4819f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: Add test for reading
 from STACK_INVALID slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>, Mathias Payer	
 <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, Sanidhya
 Kashyap <sanidhya.kashyap@epfl.ch>
Date: Mon, 02 Dec 2024 14:50:03 -0800
In-Reply-To: <20241202083814.1888784-5-memxor@gmail.com>
References: <20241202083814.1888784-1-memxor@gmail.com>
	 <20241202083814.1888784-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 00:38 -0800, Kumar Kartikeya Dwivedi wrote:
> Ensure that when CAP_PERFMON is dropped, and the verifier sees
> allow_ptr_leaks as false, we are not permitted to read from a
> STACK_INVALID slot. Without the fix, the test will report unexpected
> success in loading.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


