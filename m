Return-Path: <bpf+bounces-38363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D47963B33
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA7FB24E81
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8214B950;
	Thu, 29 Aug 2024 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2WX25fW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F514A0AA
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912481; cv=none; b=CIisy3awUh7peDs7gmsYzOTyDdBXhfeeYDlLWPHextB/WZaeO6eQ26ymCqk8izqF0cWMU7W4GC0Hzm53qieUT6Zelwvd3nnBxkIVWdCCElKCH549ReFrqdUf96IQu+NXRoBQBsc/5A5MSBEKco3Qv2h6f0nH8LvlOH7ZV/YjoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912481; c=relaxed/simple;
	bh=Vjjjvvb5mHP4PULF2eWurF7CmhN6x/I0alZhH7y/ArM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIRQ8yDEb5zKU9XapikLHBtpJN+jHrog2u8+6Zo0aBNum83Lor2g15q8mBE8Ok9FfAtt+pm6KLaKltLeM0df0mO0RPyKaLucdK7aiKoXXM2jEyr6F0+ZZU0cWoNmfE10vl7URBK0FmHvYa0cxyJ41aP+pj50ZJJCAnebLJPPI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2WX25fW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fee6435a34so2060035ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724912479; x=1725517279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vjjjvvb5mHP4PULF2eWurF7CmhN6x/I0alZhH7y/ArM=;
        b=S2WX25fWIf8DlLnRIcUntT22F+vaDsTPqdnXb++45zDE74A46vlbPKu9GbU8PykANg
         SrZ8MkK69SDRNS3hTR6jlAF/9jPhLviL0SexPjfB4MosEconle97ir+qL8bNZgbZ7a6l
         CGOBqmaTnAKN/zLkguwZBr/sgUfaMlpwWRgKoutFWbOTmO/mD97DHXbfO16sRPvyPffs
         XEbVHQqmUBY6MngLXgxLGjMvwGq9nHCxqbLilX1WqZx1veKl3LcPACt4etnRmV29ooBA
         SMuZuAaTzx7UQCNA+XzYhJd/qgB/XDqitmVwoZSd4jY9nP00QM3k8VJ69p5T7A5vVhlH
         ZIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912479; x=1725517279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vjjjvvb5mHP4PULF2eWurF7CmhN6x/I0alZhH7y/ArM=;
        b=ZI5D3vy8XMmn7CbUShLrP+6w+rGJRvJ4ayn1E66fQAbH7bQOrX/L/1Fgc9MxRjLgpt
         d4kT55+G1FpOFhKurs6FDMtLE4C9y/YcpP5/Ci4/imT6IL03gmKf5Sx2VmOhmrFsF8Hf
         shvlf+gLDBX4l8rWE7RjLgwoGcXqdcsTwra7JERJGSUUcyzaWqrmuP5hQ5c8kBHZl/NJ
         A6zhjS+PEGJOkyoPRxyIUL5fNl13t39t6BY8r2iySMxGb0e2S5/yEUshOZrZWa1aGs3p
         WhkMJPhnAVvJmKceZIojZobrZKqm+DyBIM3Qgv+/lbwtM2y2JD2SqPhoZoFPPpN6/2mQ
         5ssA==
X-Forwarded-Encrypted: i=1; AJvYcCX94IBLH7qZyg8an854UgonLdeAP705nsiotsKoJ0wH5lTY7wEPXYt3qOFpUGkdJtSjJmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/04Sxf6eA9dw6Ng9WKVkY7r6heFvXJ1UySkLOkYEfNhYBE9R
	iS0ktvJX4CVjhRT1DoKOzllCEmtGAYs18kMcLITT2EtwWNDX2qEt
X-Google-Smtp-Source: AGHT+IEb8kVjfZ2ZhvMlKrKKJIBFc16hoBlG7RfeELq2imH6it8Kw1/scUfrVYDJ9iFRaNyTHqTSmw==
X-Received: by 2002:a17:902:e884:b0:202:3dcf:8c46 with SMTP id d9443c01a7336-2050c49f0admr18739655ad.61.1724912479219;
        Wed, 28 Aug 2024 23:21:19 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155557e4sm4498505ad.281.2024.08.28.23.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:21:18 -0700 (PDT)
Message-ID: <b712efe88c1a6a7b7419695d6d7a59db3185ca74.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 8/9] selftests/bpf: A pro/epilogue test when
 the main prog jumps back to the 1st insn
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 28 Aug 2024 23:21:14 -0700
In-Reply-To: <20240827194834.1423815-9-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-9-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> This patch adds a pro/epilogue test when the main prog has a goto insn
> that goes back to the very first instruction of the prog. It is
> to test the correctness of the adjust_jmp_off(prog, 0, delta)
> after the verifier has applied the prologue and/or epilogue patch.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


