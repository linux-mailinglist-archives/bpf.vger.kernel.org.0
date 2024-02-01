Return-Path: <bpf+bounces-20965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4213845D22
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768F0285A28
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C95A4F2;
	Thu,  1 Feb 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGyFFnI4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EA5A4E8;
	Thu,  1 Feb 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804402; cv=none; b=E4Ehm6nHtbZ7ATeSDI+lDDeKWMcUYznfp0wIijkObrpbfEQvEYJF+L5JwPkE931a5Zm24Y/eiX3TEszavIztgwioObaWIemOk1YxWv7HavQYEncs0oNj9h6howeMcWA1p18XLyDbEi7qQimGeNeW5qe7KYfhuCyHhbpiunACKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804402; c=relaxed/simple;
	bh=ygH1ANBFQzdbWHqig1KvXevLJTUpUKVJInoERj5H7V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgTfEU6MLJvA2jYC/479AsWeNZzW2FEAYoOj4G9CDq39qASfBdbY5E00OaUOab3hqL/ZEeyHe7psYjygwrwSodmxeEG72WAwFlA3qdcakQA1q7az8kFybCr3UF7ib7vxqjm7ko9aCgB6+NT2zNHaRcfanoKDpbUHiNFVIpBsshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGyFFnI4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso14617111fa.1;
        Thu, 01 Feb 2024 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706804399; x=1707409199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygH1ANBFQzdbWHqig1KvXevLJTUpUKVJInoERj5H7V4=;
        b=EGyFFnI4dm5FcPTEnEsfNc4DFItUBEyfHodEoS70PIGAR9Zr0bC8SGXLshGY2hMI4D
         VTVLMt2KTQzsZrS9k0c1DzTw8dG1bGH0TBsJ6xNIlwgrfWvOkRNHfz4zbT/lXB0moHmv
         AY7ShLG296fXWnILPNN+8c5w8Xy6EdNp12KrgBjB2dzaaZfCTScfaCSpkGVzgmZ30/bI
         MdeDOOFb2ZR7/4fIfF8lzHlodkRJkz1JpkomW3KwvUBBfCq0T5bR9iqPNEm9N+o0O92C
         TDGCBBAIscLEb4LI+tuMZdjVOIs5pGpIUtDQKtnl+47KYArqcD0FiSlp7OA6d6eWLpWx
         thgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804399; x=1707409199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygH1ANBFQzdbWHqig1KvXevLJTUpUKVJInoERj5H7V4=;
        b=jVYx/jyTX8luIS2CR2nuD7qehq0X5HOsoPPoUTKnmTVpHnCgmn/8ZTFToHg5tiTqd3
         xo6HZYHY+Ltw+FgcCTuc9585/zF/J4Eo2kJQT4OCqZ1qXNLyJxOLo+ae0qK+GRTegPhh
         hL/stqIzuEeCVkscFFBgXUiznsq6y2cREqnR71HVGaU5fKOL+gBsaopv5V4xtjh6Db5+
         uPG8NfnsFJ2ZWUNicX2KzyUjTFUVkgtEF8Wqd0qSmF3awJRkJEPTv9xDO4iFlovJTYAU
         9ZR4OOMkRHlEFEDnXcsuV/lzEvmDKiGVPqIw2KIDBUyCiZl69RsAcxVSeI8oElqEg7Rw
         PaAQ==
X-Gm-Message-State: AOJu0YyHzKm/7xRAjiQHvFwUx2v79xU7464KJ22Sg3/ciEPofycZFlPA
	+cZZpVj+yqcdLKJ8bGN7QACFyQqAEHxreLJ2Hej8DUo5Cw7JJEYYQGCaduw63x71Akk6KEPfs3/
	1YKQbmImOZPw2g9v/4cIB3nLJyDM=
X-Google-Smtp-Source: AGHT+IEboM9BU1D2N1zSAOvc+WKlkpgFNHKYIUTTDXV+yPQMssdBnKXS+jMSgdgp9NElwX1iLJcp9P1fdOcXCG6REiQ=
X-Received: by 2002:a2e:9c8d:0:b0:2cd:50a7:12d0 with SMTP id
 x13-20020a2e9c8d000000b002cd50a712d0mr3708974lji.38.1706804398627; Thu, 01
 Feb 2024 08:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201083351.943121-1-pulehui@huaweicloud.com> <1e7181e4-c4c5-d307-2c5c-5bf15016aa8a@iogearbox.net>
In-Reply-To: <1e7181e4-c4c5-d307-2c5c-5bf15016aa8a@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Feb 2024 08:19:47 -0800
Message-ID: <CAADnVQ+rLneO4t=YYmLYtc945Fz0=ucNTWZBxgvs8toFY-onRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] Mixing bpf2bpf and tailcalls for RV64
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, 
	Pu Lehui <pulehui@huawei.com>, Leon Hwang <hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> > will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> > similar to x86_64, i.e. using a non-callee saved register to transfer
...
> Iiuc, this still needs a respin as per the ongoing discussions. Also,
> if you have worked on BPF selftests which exercise the corner case
> around a6, please include them in the series as well for coverage.

Hold on, folks.
I'm not sure it's such a code idea to support tailcalls from subprogs
in risc-v.
They're broken on x86-64 and so far several attempts to fix them
were not successful.
If we don't have a fix soon we will disable this feature completely
in the verifier.
In general tailcalling from subprogs is a niche use case.
If there are users they should transition to tail call from main prog only.

See
https://lore.kernel.org/bpf/CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiC=
Zrpw@mail.gmail.com/

