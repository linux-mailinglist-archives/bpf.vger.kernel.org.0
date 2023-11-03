Return-Path: <bpf+bounces-14157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFAE7E0B2F
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4527B21483
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C91E2374D;
	Fri,  3 Nov 2023 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr7vhzJG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3222EE2
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:35:44 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0834D53
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:35:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so161035a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699050941; x=1699655741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dGXcEf2oR01jyv7TH0JaSP+Y5M+DDrMHYZbfw52HhSY=;
        b=Cr7vhzJGj5DGEmRne08QDW4VLT8yBWhCa3r11++TYIefC9JGZh9GLAZGNOvZuivuph
         taF4ZrIk6HfuY2mbMekGBhrK5r49jh58HIztH4ApEUvCPdoMTri9vlF5G3cc9hvMOkKb
         yzY+RMyjnvg3/jzFVjJ358PIJu61f31lVBBnhCPdu9h/y8/jZKxaPGvxl4P5/mK2PsXz
         DEQZcZrH4OuRZbqF/3ry7ZQPfFCeAO3AH9E6B/ZHW6oACmpktNQzJ88+esn8QCBIG7mH
         H77QENzui/DQcpcZnPUAwjbQ8Mbmw9c23jH6JPrIEHJSiqT7HU1KNlrbDrFBdFn1vpET
         j5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699050941; x=1699655741;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGXcEf2oR01jyv7TH0JaSP+Y5M+DDrMHYZbfw52HhSY=;
        b=V5ImfgnqsRQuZm82kdhH8BqGoSLb3K1DZ4F9E/A7M9oe1nYQV8+2d6/MA6lEpgc1eR
         O1L/klJOj7upacboxLVHTQ6vzRv0cXCsv59M74uU6eoy9dOWeEK1mTXX9HF0DXpTSaz6
         j340gM67b2AR85F/AJQ9JtEDbJVqqzdoE7naLRRda+7UVDofpJvJjlW3cEcBwWHzuhc9
         WujKY9gvp1Z0qXTRB2gS/KgGWNItXtFkSVsr3kRb7V67s5Vt7MuLAuSGu0kbD4lwkBft
         RjRWpu3e930bwY8LhhbI52vDLiNPf8n9d34l0tihIl/S7+XJeRMf5CRQJfE+rUoAHJUG
         aKXw==
X-Gm-Message-State: AOJu0YxAfW+8XPUFLy8Owahc6yPzTeeg+zwvOZXB+T5YW5rvGDOTQrQD
	iv5k+PHpMDO1jXlB3u+fufw=
X-Google-Smtp-Source: AGHT+IHr9fRSS4NKM7hyn2lgGh/4BX62jfrWjO0aTG8gNWRCYtdzJvfcwPe03ck0EuVfNYQYulSzrQ==
X-Received: by 2002:a50:aacf:0:b0:543:bf55:248b with SMTP id r15-20020a50aacf000000b00543bf55248bmr7199593edc.13.1699050940996;
        Fri, 03 Nov 2023 15:35:40 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a509510000000b0053e89721d4esm1435241eda.68.2023.11.03.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:35:40 -0700 (PDT)
Message-ID: <d8b0da3e71fb0cdac869b0565d53b6039bf69e99.camel@gmail.com>
Subject: Re: [PATCH bpf-next 11/13] selftests/bpf: set
 BPF_F_TEST_SANITY_SCRIPT by default
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 04 Nov 2023 00:35:39 +0200
In-Reply-To: <20231103000822.2509815-12-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
	 <20231103000822.2509815-12-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> Make sure to set BPF_F_TEST_SANITY_STRICT program flag by default across
> most verifier tests (and a bunch of others that set custom prog flags).
>=20
> There are currently two tests that do fail validation, if enforced
> strictly: verifier_bounds/crossing_64_bit_signed_boundary_2 and
> verifier_bounds/crossing_32_bit_signed_boundary_2. To accommodate them,
> we teach test_loader a flag negation:
>=20
> __flag(!<flagname>) will *clear* specified flag, allowing easy opt-out.
>=20
> We apply __flag(!BPF_F_TEST_SANITY_STRICT) to these to tests.
>=20
> Also sprinkle BPF_F_TEST_SANITY_STRICT everywhere where we already set
> test-only BPF_F_TEST_RND_HI32 flag, for completeness.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

