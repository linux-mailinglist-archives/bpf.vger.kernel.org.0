Return-Path: <bpf+bounces-64583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F6B14635
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 04:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4113A66C6
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D420C48A;
	Tue, 29 Jul 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSKVnSIm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9D207DFE;
	Tue, 29 Jul 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756245; cv=none; b=eDSUxmj0pDrU4mOs4s38aTTiP/+7Vb2niyDB5PvRmjvInR24FY84cjUrsojY6anAQZ5mXyDC9Rqx3k2oP/zdx93Sw9zolzVpt8ZJ5CCxToF3vXyQVwVfGoFhgxjblZujB4jECop629wbNzLBm4kpc+vdlirVcagOyDV8Lp8I7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756245; c=relaxed/simple;
	bh=VIlt+cPjlH5yGEWbPl2P48kKgLbz97KO7EGeqA2xmFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOBbzhk9yX06tkmKI6qWkVVQfmWnFSF3ZLcZ8YWiZLx2LeJIZBLGjq7HxB9Xfyv3DR0h29XMLLLxoOpHbGzBz/dQ7OOpXUnYWp21R542+EAKMPE8TRuTBHB7fsTNu/AAPXLsl21LMdKN4f1wKryUMS5WY8iYVggPphbvAbktnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSKVnSIm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2372476f8f.1;
        Mon, 28 Jul 2025 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753756242; x=1754361042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIlt+cPjlH5yGEWbPl2P48kKgLbz97KO7EGeqA2xmFU=;
        b=MSKVnSImH10l+i/XMGXd62yn7YAx8l56hQT8XhiRzbNf5fw9biVxfu7GbaY3akiyON
         +k3OrWppEsfec/fXouMzWIDOxmL8S3qHdUKcRLtkB7ShVVyyQWXR7xvaqGLERrTe72R7
         ZllznOh9/GnHIMQFGEj4CcdgwsLDLow5gs24XcEw2USCIvcuEHAN4JdHKnJDqZvnAClM
         DP3gX2JSFEcCYuhv8FHjEbqWvWroR8o9z6bvQ8hnrDpY5xy0qK13uGkdXJfdPo5Y6Kud
         4L6EJVtq1ngUT3YIWFEOZnwgPEn3mB2thWo9uKtVaAY0R2HPO8ivs41GOXRsgZtNMYoc
         TomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756242; x=1754361042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIlt+cPjlH5yGEWbPl2P48kKgLbz97KO7EGeqA2xmFU=;
        b=Io4t0GMBCxNFRQxO5fjeNy+6GZySzWpUs6HJ9PDLgOL6FSUZzQVJsBgDOMPZ3L6LIE
         mc0CwS/ymjUIWz17LyyKDLcfAk7rc/Y6o5Uob8hV9S5twMN+l+Yno6BQhuLBsojdLnDz
         dTAv2XMBf7tV2g9egs/W2ZyYVTPgk1dNf1tBH7zQHrTDkko6rmvUm0w2/wOZKQxZFfeZ
         ONFWHKcyv/qsuVWom1vOr4JSIE2ctJ+NG6WzXrTUtbswUlzfC1J91+scNYty1msJebq/
         c8OSk5uj0W4JsI62hy5rvWWqFzNuEBiCWKd2Z3gOpe24tQpwP8lY7s/YUQMld98lBTxy
         i7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWs9O2nCH4G03vEkzbVMd5zvPV5DcbCt/t6c4LoNI1BclTTQ0rQ3yfmlK0ULBpxBro+z5gXVCvsbPX8jZ4OtnHhtwNSBSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mNDQCx9/DXLPumfwiRjlt2aDNXshK0c0aW0byIZkLrSxEdlK
	AN/5wS5R0nWTFjet6nRHp3SGV2OoLtNq+hkY642y6nAVFrNAhto9u1u3wnGKRRR41T9egXqaeNi
	lb9kB+fJh4leumuC1vuzTHJlvUndtHFo=
X-Gm-Gg: ASbGncsQN7B+5TJ4cwPkjNs1zBjp/PPieDHfKiAXqQUkQ1sY991pe2QpHlhi6F3waQX
	d2OVp5bX9sLbg6qX5h5OgSxi6+X49b7kMlOr6urzq29o7boMy6xJBh9r6rzdvaHtPmHltnBolQq
	FHA4ovrkmeT6FcH1bYy+J30o40TF2Zrsu9YLapMkfBtw5XEAexPr2fr9amLolngoMmdeKR39V/b
	N8hOP7FS8UsAZ20IxEQ/gDeGQg/mQK//Cwr
X-Google-Smtp-Source: AGHT+IEwV6W9dllVcWTqbIRo/UZHNHsRd1gkPY6sQsHZqOp+67ZeRCRvLyKnqU1b35Qwce5AXcC15PXsrJY9LLlB55c=
X-Received: by 2002:a5d:64c4:0:b0:3b7:8b2e:cc5a with SMTP id
 ffacd0b85a97d-3b78b2ecdd4mr2789725f8f.40.1753756242344; Mon, 28 Jul 2025
 19:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-14-kpsingh@kernel.org>
In-Reply-To: <20250721211958.1881379-14-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Jul 2025 19:30:31 -0700
X-Gm-Features: Ac12FXx-z5yBEmEFBhELgLaXQpxI2kivd5Rco0XK1vTq2uWBXUNP6DkCPimj8XI
Message-ID: <CAADnVQ+3XYyJY_zcQtNPt81zyJwK4zv5oA+SLN9ohoLkD9XyZg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] selftests/bpf: Add test for signed programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> +
> +SEC("fexit/bpf_prog_verify_signature")
> +int BPF_PROG(bpf_sign, struct bpf_prog *prog, union bpf_attr *attr, bool=
 is_kernel, int ret)

I don't understand why it needs to peek into the kernel to
verify that it goes well. The exposed uapi should be good enough.
If the signature was specified and it is loaded fine we're good.
Double checking the kernel decisions goes too far.
Especially since this function can be inlined by the compiler.

