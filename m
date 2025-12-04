Return-Path: <bpf+bounces-76081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0933CA4D8A
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 19:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075393061687
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65036C590;
	Thu,  4 Dec 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuva/7M2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB431329D
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871586; cv=none; b=YOpgbaqTFI4ZhVYpyi+vczcvvUB564wbBBCLUt5bOY03kxS11v8RRFBoJ9NymcWUWs6OO0j9zRxWBHMO9ig6Quzg3JhoxOdWszU16Mcvn9Mqk47iogsKt5PbCmMFtyRYjUECmMvp/4galLSbQZ/g4ZmJCzf3VVsYx0UKd5Z+lOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871586; c=relaxed/simple;
	bh=IYlPdcQB+qlawwvAMYnbc3ygWE7N3I35+bMQZp+FjW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRoaX8n16AEJugaZbZUMcHYej1c8xmFBbIV13xj8O9u7az8rtpLXZ9vCAZx0QWbaHI2Q29gkm5tY8bt+QIzE9mv3hCPUSJqCeyHKrhCep5uFjfIr2YuBUDrMyuGPDo97UdxvMp1SXC7h8BVpdxpuKCa74KZq2MDuimqR7FbM6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yuva/7M2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso1721213a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 10:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871584; x=1765476384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IYlPdcQB+qlawwvAMYnbc3ygWE7N3I35+bMQZp+FjW8=;
        b=Yuva/7M2CTYCcwYKWn2bSOPOfeswxxCU4WJ0ZLugUyWdAiAigIkDLE041v/dzWuurt
         jtH4JvHq2DiaZ/4j1bV/Ga17rwHNjOjGyj/ebxuwdZolMBNRpbd8XLnAMwrwXimXEBru
         onDY647DmEO0q31pQYiYidVZ4m72B08YR+1dhGJV6VEfJlXvz+bxPRUhjbMACIu/Dg8m
         gIFXeV59a6IE0JKR85uajI8DKS5OT7p/tYFrc8854hCGNZ+xzMroWLTAqgPfz6tlQknu
         FR8+qVKzrkYIUHvs7OcwV4nIdfLA8s/IggdzDAqxUopcEicl8kEG/imGhN4gVnp46Ijp
         cVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871584; x=1765476384;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYlPdcQB+qlawwvAMYnbc3ygWE7N3I35+bMQZp+FjW8=;
        b=YEIAyvYLYPRRHn3sekcg7qL7w7TrJ3tk+4BBMEIRFp6S9+BjtPFYN8X5rvXa3rjzSn
         8rVeW0dDYO+VE9j3zjQLEeCLrqEcqAt67QHQfqsABZuWyjIsUwNRQ8mHgXnGetvYLAhp
         XWeOIjlLcQnRyBG4wvKzqxNGbFAuIvqmHCm0XWlY3SfBgST/TX4X+BGY00p3xK53GA/E
         tLn0p/nRuO8MXdvgBAOec1BoBrGm3TuhO5METoFOUmwhFhpNb4NUI51I7jz7VatZsYba
         FA/nsLYod3Un2A6rRIIANoZOOOzcz8yniL7EfQ22KSq90Skbu+f+HPd9OXGV13P4xMF0
         4g+w==
X-Gm-Message-State: AOJu0YwG98iPM+2HV85HbaLRttPAmt7l6E0h48OubEXr/b342SovGiWK
	iTz1QSLdyE+kdbkHzgwOv+JZguwQtRw6mWG7rjB5/pIXEsfrqnz9lcp+
X-Gm-Gg: ASbGncs2yEecv6yX2sWudoJaPRm3k+Rg0wZ1ju3Sxw1lXx9ALQTcjDdhTM2pWZevy17
	2IRukFmKQw3nCX6PEQ6cvQdBbmKJayhXaezju7JS1kxcBAZqfseO8GGxhPduyqRHD+qUJRLKSXx
	lx8BCOycY/AucdjApTsN7wJ9ASh8hQpX/LTdp/0G0hp79/rOjAqPQCKxi6s5hm7wYBNJniktIGI
	TsYbRfMTUaFZS/OHiVqer3O9j96hElac2l1bVGnTmtiQfeoU6a5ldXfAk/0LBt7DktRuu3jR6O8
	ZaU5TbesPYkkFmhVPnAP1VQdo5jvo6NHOo2bDx3qGQ+qfK2LNd2HQJrrrUFAthmr8cp/So3hRVZ
	aS0prkVXRhzzaWwPyXlGShgV/ylFHiW+p0eZhXomNgxdY+mlJvcUe+8H9TxcDxuKECC2pwfCr7t
	tLl6VkX9vd
X-Google-Smtp-Source: AGHT+IHLCo+72DPRWKONv/JPgaSabOzTBsVk4U00GSBcgCo1zw2Ja1fCMHkVELYZuK7F1CmTW4l48g==
X-Received: by 2002:a17:90a:ec87:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-349125d0973mr7484739a91.14.1764871583726;
        Thu, 04 Dec 2025 10:06:23 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f596810sm2395842a91.10.2025.12.04.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:06:23 -0800 (PST)
Message-ID: <707080716569c7de7c3cb5869b67d62b55a96b68.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Nathan Chancellor	 <nathan@kernel.org>, Nicolas Schier
 <nicolas.schier@linux.dev>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt	 <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>,
 Donglin Peng	 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Thu, 04 Dec 2025 10:06:20 -0800
In-Reply-To: <79031f38-d131-4b78-982c-7ca6ab9de71e@linux.dev>
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
	 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
	 <de6d1c8f581fb746ad97b93dbfb054ae7db6b5d8.camel@gmail.com>
	 <e8aacbc8-3702-42e9-b5f0-cfcd71df072e@linux.dev>
	 <763200e4f55197da44789b97fd5379ae8bf32c08.camel@gmail.com>
	 <79031f38-d131-4b78-982c-7ca6ab9de71e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-04 at 09:29 -0800, Ihor Solodrai wrote:

[...]

> Ok, it seems you're conflating two separate issues.
>=20
> There is a requirement to *link* .BTF section into vmlinux, because it
> must have a SHF_ALLOC flag, which makes objcopying the section data
> insufficient: linker has to do some magic under the hood.
>=20
> The patch doesn't change this behavior, and this was (and is) covered
> in the script comments.
>=20
> A separate issue is what resolve_btfids does: updates ELF in-place
> (before the patch) or outputs detached section data (after patch).
>=20
> The paragraph in the commit message attempted to explain the decision
> to output raw section data. And apparently I did a bad job of
> that. I'll rewrite this part it in the next revision.
>=20
> And I feel I should clarify that I didn't claim that libelf is buggy.
> I meant that using it is complicated, which makes resolve_btfids buggy.

So, pahole does the following:
- elf_begin(fildes: fd, cmd: ELF_C_RDWR, ref: NULL);
- selects a section to modify and modifies it
- elf_flagdata(data: btf_data, cmd: ELF_C_SET, flags: ELF_F_DIRTY);
- elf_update(elf, cmd: ELF_C_WRITE)
- elf_end(elf)

What exactly is complicated about that?

[...]

