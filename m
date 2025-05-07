Return-Path: <bpf+bounces-57645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B4AADB2D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D9C4E5BEC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BE237717;
	Wed,  7 May 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="NbjeaoSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1EC231857
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609256; cv=none; b=T4HCrsrTetv6A8EUDZk40KZV/rdLcqNmQ+JXy2VGrj63tkoK9DjkAtY3sUZAbAP0QTvb01zpCqWurnfW64wLH/9jE3cy0xD7XE2MGJn+AixjlESS+rbaOqS5D3Ikna1Jh75Bo8aavBMKm+sIIS0AIPtp4UEcdcI4vnHOYJNIMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609256; c=relaxed/simple;
	bh=5I48oKIcAHh2GX/ijoBH8labwdpNZfuRysT+WXcajI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za3bImDanhrNDj5Q/Jl40dOVOt/Tyl9UFMyfR+ge4pz026DfsRGZCoCfhJ9wom51EKZqfgH1JqBiP5zPRXS9K3TbzV0QwIqls7bPmUsQ2OQkR9lTaisTkT3zCwTDG7tkrth/V4o3X4qmEq7avEtr8RxUejlcblbesEtIROYeWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=NbjeaoSq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4454571f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746609253; x=1747214053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENAdlxNQCNsPp1Cx5U8ECxKNHpix70L4dcI8KPfbfOg=;
        b=NbjeaoSqEClPkNMCmliMvm9U3cL8CMVHTSSTKQfp4idXY9xotgO2RsiLjHNLDQ5d7z
         mXByncE4JOiTRaqSyyc8Oj5nmGxVxa7Atcwc/gbj3+NidFUeAr8SLD9Th+FB8sjC1oeY
         qepsYXxQLAj9tD2cdshlzHldZTRZBeEbcTHiFnHzhoJmKjH4rAKQNaIscblBBy0Gi0xj
         MbLwb0Bnfxg2ThfYemtwhJ999YePEaQEj6P4kPVLpxHCjgyww5oB8h4qs2pX8FfAScWe
         frJWKIXVBvIIkzL/zB5Uyz7sgEZyjXxcO+aR74KJWczcsrRhpkimnPZQ2ArpFwIqUMXN
         RnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746609253; x=1747214053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENAdlxNQCNsPp1Cx5U8ECxKNHpix70L4dcI8KPfbfOg=;
        b=TJtZ8uOmDAGuyTqHKticg5nCnHHV09gkqqbDXEaGOGRJNA7TYqcfxXnviLiiexZ5HO
         AkPko8bi5Ge681F4WMR4xdEQa/I0oAynvWZCZlEzm6T5es3X9lkQSXrRDm2ua5j5TLb/
         EAfW66QhS3K0g3Qo+yq1sj0sQxCmvqzlzyABiS+ffTlPfSzWXf8dTmiv+P0fYjyO91N0
         MqbJCsWgDfsJF42vsVBxZoaVnFAK3SWst7k6FhmWEFIQdL1AIVcpXzZxJwgQJSSyn8m5
         kshvcBxvZrh+vYGWB7YKALSO2usDKBojUAPT4f+qSLpj3T1Qp2PDr3YoVWKp0hYqGvbD
         m6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXsAPosfbSQACgrJ5bYibJx/VNFC+CpZ5hSfzgGyHkmypAYFriyR+L1PFIkv8DpBg9lJnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/afAAYasiJ7J69pkRGpoVS/Iz5lNuZV2LyB3r/v9D+xMF4QdR
	XDhyEyYlWP5yhXwxnQ8u4f+p2/X9uZ8Ct3qdhBOU5ugzvJk/rr+Kw52lbwcY2LCLNFroWy4I7/G
	+eiUSwNQ1N90otu/o+G7/5sCMXCeHJKxBqaROaA==
X-Gm-Gg: ASbGnctj+TjUJjtP2TycMcvCuw75K1cEc+Em6kA2zSnnQeUe1fUIcKl7X8i4jV68NJZ
	Ojce3MjpUI1hovGeJncc8Alwqt1hHOvQMFZ4tZZIe4Ufj6jb92JQ6QCY7hr1JPGptteNEoO7KWW
	DdsGw81TPKhbF1iO+GH2QsgIhV8cQ/mC14oBk=
X-Google-Smtp-Source: AGHT+IG55r4ND4dVvtN1+EUD95gs+uLnOj8rk8ZPFKEZxOHPG2ZvKCFr/wsjoTjPwlfHjBOMB6jQXJeqBT+RbwDRfOw=
X-Received: by 2002:a5d:64e8:0:b0:39c:1257:ccae with SMTP id
 ffacd0b85a97d-3a0b4a1c722mr1959843f8f.57.1746609253168; Wed, 07 May 2025
 02:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
 <20250505-vmlinux-mmap-v3-2-5d53afa060e8@isovalent.com> <CAEf4BzboH-au2bNCWYk1nYbQ61kGbUXuvTxftDPAEGF1Pc=TLw@mail.gmail.com>
In-Reply-To: <CAEf4BzboH-au2bNCWYk1nYbQ61kGbUXuvTxftDPAEGF1Pc=TLw@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 7 May 2025 10:14:02 +0100
X-Gm-Features: ATxdqUE4g8lO60eqVT-NBjEfrxMu9rtdzVq9hr1BOEdsu4jEty7BLc1dL2Y9oKc
Message-ID: <CAN+4W8gcquJRkZw+Knt=vqwR4YM8w5RbRNO-XyfE+DAyiEWANw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:

> > +       raw_data =3D mmap(NULL, end, PROT_READ, MAP_PRIVATE, fd, 0);
> > +       if (!ASSERT_NEQ(raw_data, MAP_FAILED, "mmap_btf"))
>
> ASSERT_OK_PTR()?

Don't think that mmap follows libbpf_get_error conventions? I'd keep
it as it is.

> > +       btf =3D btf__new_split(raw_data, btf_size, base);
> > +       if (!ASSERT_NEQ(btf, NULL, "parse_btf"))
>
> ASSERT_OK_PTR()

Ack.

> Do you intend to add more subtests? if not, why even using a subtest stru=
cture

The original intention was to add kmod support, but that didn't pan
out, see my discussion with Alexei. I can drop the subtest if you
want, but I'd probably keep the helper as it is.

