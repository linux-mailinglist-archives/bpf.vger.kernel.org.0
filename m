Return-Path: <bpf+bounces-55623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DEA83738
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 05:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB101B61794
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375F61F09A8;
	Thu, 10 Apr 2025 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBa7mlap"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF738F80;
	Thu, 10 Apr 2025 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744255739; cv=none; b=fKa5Kxmh0bPwCdUbF9W5Wgo40uPsm169A1GGarCrL0ZNNgg4XciL7GMTKDe/h6/8+jlSuE4j7zLsxLxyrkMvx7dNakt+9tF5u27QZT+zPIP/zsy/DGSeIjJoaV5DsPJsk7eoG84Y6ODRYbYhTx2/WInBI6qEyhJxbEs8HaDOr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744255739; c=relaxed/simple;
	bh=1qT4p9/yASHkVfBVycY5L9QDkHM4BA+IQXyvAReAm0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7hNMKhoF23aIELNjaMt3pGTFwbElweZqLRM1tHefrEuyxK9dh0OqsIOg4+I2KbUvzsvnUwnBhP5s8mdwMiSHJEuKeQmVCho199wk5Sa1MIfaoQMR9EkMpxWtnLq4Ynn9jwjAkY9hbOFlsa9xrra6rik+PJs3x3tFkcV1Ami2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBa7mlap; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso1515135e9.3;
        Wed, 09 Apr 2025 20:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744255736; x=1744860536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qT4p9/yASHkVfBVycY5L9QDkHM4BA+IQXyvAReAm0g=;
        b=KBa7mlapEi+XYZ1G7ob00H/Gj6IZR9kKJIdqFmUo6VVVd8/FQkz1YsC0fu8oaJGJL1
         tedgv52S8CqvFC516b9w3ulePMJ0kn4VG+OD+bA4UcIQJoYPII4zqpzjJmeE7UWl0s+q
         rGuJoxeGQ1e4bCemEY51xPtLZvzvMZV6dYSv174XPnIiIOolVA8H4YLMGHms0QFA2bZx
         XbSHY1MY0O+8pesPoRBY20BP9Zj3qM9vo9QFG4x9UA+FLdP0LUIBe7NER4z7JejZqJzq
         UN16u9W0C3ggnAusQml0NKGOImlOljkrF2Vu6yUXIFI6t5HOdaU+PQtAv5E0QvXlYTUS
         e1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744255736; x=1744860536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qT4p9/yASHkVfBVycY5L9QDkHM4BA+IQXyvAReAm0g=;
        b=RElQqV90WDiuMLP228tLhZE5wnyPZTnM4RQLoXcVFra5vhCp+7pwtBIZDY8a7iwL85
         759vCzmTpztSe8ke+mqp5mgJGw+yOCwkpZidkA0QqzBA2yH3qzawI4plELcney3mUt7d
         KvySYtNa0nPJsyudyXPfKh/mqSZ2Rel2eryG1kkIYMabylc7LAwZBdoaVr75+16McZRX
         B6v0Nhx8F77e6XDckuEGOzQImBwGy6Uag6Ipr3FMiT/PwnBCnYOektrvpC3o72MHAzDo
         Z2YhQ+pROvkZA8KgVAHYSxEZMvnUtilarsDTwaCrhwNCrdBMLn2p8lEOPTvFCFQMCeRl
         Gkeg==
X-Forwarded-Encrypted: i=1; AJvYcCUpE0xz8wZgSL0iUodjVorMlb6IcNiLjPJAcZC0im4sztH5UicDqbbqNbhFI46ZGjBA6Qu2czyATnX7oYA5@vger.kernel.org, AJvYcCV2nlneVOcm71IZmDT5YjXfd30mETWCHV8ubZToGvBRtpy/VWMM1uVSnt2UJV3T2VeOwOo=@vger.kernel.org, AJvYcCXL6En3dPo16G21GwAROZt/xFIlhsQEN9UwbBlJIjNYnri1FfQpPZnoIlUb8w9Pn7epTUQwDA/vL904JcJ3ST1fCwjE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/N9Bm2xWoEQQjVG9VepVyqK9xCygcCUex24iNXfARKaXmxe8
	1EBR3lcrj2objFf6ofCI2KWWYdA3ZjWT9WveDh6+Hcb/3a3V33TXZhwjSV3ue2leQQa7fxyTAmt
	EzPrS6DnWJS8X3KQ5D5QqjlM21Ag=
X-Gm-Gg: ASbGncscjpcKgldVdBUQR4cwzN6wjukgqZV9dPk+sMrab7csXDlM4/9s2KKkFoDk8vV
	63IVcyzuNvVPPunzBKOJnJb9dDOyG9k1BBQ6+J0DxKJ5UXIBbxOGQgUv4a9akD28WUOc/3YSCX4
	wmkfGZzdeAyp2e7GBZlYEZEsjtxipPy23bVm1liQ==
X-Google-Smtp-Source: AGHT+IGaWEojXqplR70DbA9KIqtKUCqO8VdfLfrSloms0d9yOELhm5b7xSv8e9WS2CXXMJ/1dZ+1aka/ieMX4Fqfd8o=
X-Received: by 2002:a05:600c:1c86:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-43f2ff9afa2mr3886615e9.25.1744255735922; Wed, 09 Apr 2025
 20:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408071151.229329-1-yangfeng59949@163.com>
In-Reply-To: <20250408071151.229329-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Apr 2025 20:28:44 -0700
X-Gm-Features: ATxdqUECZ8hBo3V-Su9Z4qQwgeWEVH-SqaCOC-Ef80OY_wkuUAeTqwDGyTS9qH8
Message-ID: <CAADnVQKAUWaiV-D1noBnWvLgvXCr1PNQvby+0arFei+tSwzz1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Remove duplicate judgments
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:13=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Many judgments and bpf_base_func_proto functions are repetitive, remove t=
hem.

Judgments?!

"
A judgment is a court's official ruling that resolves a legal case,
determining the rights and obligations of the parties involved
"

Please use AI or human help to make commit log readable.

English is a second language for lots of developers and maintainers,
but please try harder.

pw-bot: cr

