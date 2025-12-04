Return-Path: <bpf+bounces-76086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B139CA5164
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB673061E57
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFA2FE58C;
	Thu,  4 Dec 2025 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fean+DgM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7E27A904
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875647; cv=none; b=dvFLjeNZG3Qbdu4wD7ouNd+Vcb0oZSfil/IdyUXI9jwE0+uPn/Oqf/BcP7zK97sE3Wci8+wXJrQH0zjAGUY6YdxXfcEzohCpcEsv1rhElmMGiIMjRnycOreIJvZtMSduQUEAB9zOgzSiFrK0DuJNYaUK/JxvzckiLGU9ZSKZs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875647; c=relaxed/simple;
	bh=JQ5QxrsW4CdzbsKnoOQvJJ5PzEobus6odwezWhVo0rE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NorDvBYLM7w1JKXgLM5qpp3bRrcxsIcj3E3otgrMGBOmlJ0p4NOFhuHxBnpiQfENAZGGFla/C2AV8Pbww68yJJ7C0oP1QWOVOKqhetMolvX+zY9cIk1oO6Kb2VcMxwA7YaNZ6Vzujz6FmaSx0S3A6iVHHsNI5YYXx4PtwcQAwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fean+DgM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1469443b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 11:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764875645; x=1765480445; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4iLBnCrKDlW6EVT4F6zHi2LCZGQ9e/O7rjq69QuiQOs=;
        b=fean+DgMkJaJWNycsXHznSm/HAYi0/4EqtVBqckRhe4v+TvqpVXWXoQWfA/3+dIw14
         +7t4mUlqEyKfSOri3ATbWqqPjQbEEwQ77cI/nPOAS/tWX0UhYPQkWzdjVTSAIK3MjsL2
         zSUKwT/QKxJqB4jKV5aGBpA5HUdp3n+CLZ4QOiqCcyfHfyHu6DZnVzGTfRsbvLtb7JYO
         Y/CL2WgqhSPHZbh4A7lLMK0CYgf2QZTBt47mZCNoLvWcNbMhhXhiCsfHQp50mUu4TJ3F
         3sRfnoXoU6x5agBdeETGiJskNtaw4vX2/KBXHJc6n8Z3AIqKd1PvSDvnb5d2+4JuqGXy
         o3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764875645; x=1765480445;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iLBnCrKDlW6EVT4F6zHi2LCZGQ9e/O7rjq69QuiQOs=;
        b=O43rWyg6KrmgLQDV1y9y8yra4TYW7xfGiHOZES4/KkG3EeUHzh3z/fQoTXWf7SFvwR
         itLJO3LJYoB+OxafopACexRYAc/wREsUejpWOTsRVAF59qEHf/n8VYg3bZuKxP9imrdl
         TSVf6JxoBy7KgvtO8Ea8uKnFpNem0KdAimRUfe3pC7FYmhubsDjqzurzxH1v3EEBrX3D
         QMvEP9Tb7z46ee6h0TSpivE3hvmg6qb45h76bxZLN9NRPVz4kX6xmZEvce01bI3cRJPA
         xrrcv12/j3YMpuUtPrlVjrHm2hpMHGycrJFSbe8uGD7SKg8CitEKBv01JkVPozX7Nc2M
         KRfA==
X-Gm-Message-State: AOJu0Yz+XEu5gz3AFSKzVVSmpzy9FbUXZnGVIjGS8Mt6tIo0oonON4tF
	zFFvMMJ7tjy4UkVD5kAXRwKL+XjSdE8UDuh/oDUW3TiwStpah7TvEASe
X-Gm-Gg: ASbGncs5ra7KDVsSIshGheMpfKa+/QrlLvLhKiM1rWCDvm/4FVJ2Acn3RPY4wtWWP6G
	hfLBErxgieBQAqYubbDyZ86YsC7lo8LdqTeLCqYFQq5q5YgOcqZQV1QMa/ylwKOcLroSnwUd3UK
	wYQSanpK144OBzFWZwux1HN8gLEolMENDowa4pLLASjZQ1w8wMJwXeQRzPxdr+t7dpNlIaRCNij
	NzohVyOvC1B/vnPAcYYC2+cB+6fyTUeR2XbElFwXmPhOOjeNfis/aoX+WJNyQTpElsc1fAZk+Dc
	wT3tREu8VnnFj4LptxLA5VH+FrA0gDJiR3YmutuZa3DAlrn85SubCAOBjStb029KCbXELAffP4b
	QDH4xNzF7oltbQs3JT1stoqOp0Dn7vrc3E6xLwxtAYRz3BLO13yBg5BCc7Q/ypkFtmeoSa7XvGJ
	nQaUQcfRWX
X-Google-Smtp-Source: AGHT+IHDD2gcPeEJ2VqP0Gvh25ZpaJm4IY72MOY+qLFxj6wemLduQ7TOYEB8DY54v2FdPw9GuEZqCQ==
X-Received: by 2002:a05:6300:210c:b0:35d:a823:2ff7 with SMTP id adf61e73a8af0-363f5d32a43mr9086859637.1.1764875644746;
        Thu, 04 Dec 2025 11:14:04 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a2745cd3sm2509085a12.27.2025.12.04.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:14:04 -0800 (PST)
Message-ID: <6cdae76c99bb74c3389a05e39c34732c2ca172c6.camel@gmail.com>
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
Date: Thu, 04 Dec 2025 11:14:01 -0800
In-Reply-To: <131b4190-9c49-4f79-a99d-c00fac97fa44@linux.dev>
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
	 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
	 <de6d1c8f581fb746ad97b93dbfb054ae7db6b5d8.camel@gmail.com>
	 <e8aacbc8-3702-42e9-b5f0-cfcd71df072e@linux.dev>
	 <763200e4f55197da44789b97fd5379ae8bf32c08.camel@gmail.com>
	 <79031f38-d131-4b78-982c-7ca6ab9de71e@linux.dev>
	 <707080716569c7de7c3cb5869b67d62b55a96b68.camel@gmail.com>
	 <131b4190-9c49-4f79-a99d-c00fac97fa44@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-04 at 11:04 -0800, Ihor Solodrai wrote:
> On 12/4/25 10:06 AM, Eduard Zingerman wrote:
> > On Thu, 2025-12-04 at 09:29 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > Ok, it seems you're conflating two separate issues.
> > >=20
> > > There is a requirement to *link* .BTF section into vmlinux, because i=
t
> > > must have a SHF_ALLOC flag, which makes objcopying the section data
> > > insufficient: linker has to do some magic under the hood.
> > >=20
> > > The patch doesn't change this behavior, and this was (and is) covered
> > > in the script comments.
> > >=20
> > > A separate issue is what resolve_btfids does: updates ELF in-place
> > > (before the patch) or outputs detached section data (after patch).
> > >=20
> > > The paragraph in the commit message attempted to explain the decision
> > > to output raw section data. And apparently I did a bad job of
> > > that. I'll rewrite this part it in the next revision.
> > >=20
> > > And I feel I should clarify that I didn't claim that libelf is buggy.
> > > I meant that using it is complicated, which makes resolve_btfids bugg=
y.
> >=20
> > So, pahole does the following:
> > - elf_begin(fildes: fd, cmd: ELF_C_RDWR, ref: NULL);
> > - selects a section to modify and modifies it
> > - elf_flagdata(data: btf_data, cmd: ELF_C_SET, flags: ELF_F_DIRTY);
> > - elf_update(elf, cmd: ELF_C_WRITE)
> > - elf_end(elf)
> >=20
> > What exactly is complicated about that?
>=20
> Take a look at the resolve_btfids code that is removed in this patch,
> as a consequence of switching to read-only ELF.
>=20
> Also consider that before these changes resolve_btfids had a simple
> job: update data buffer of a single section, importantly, without
> changing its size.
>=20
> Now let's say we keep "update in-place" approach (which I tried to do,
> btw). In addition to previous .BTF_ids data update, resolve_btfids may
> need to either add or update .BTF section changing its size (triggering
> reorg of sections in ELF, depending on the flags) and add .BTF.base
> section. There is also a question of how to do it: do we elf_update()
> multiple times or try to "batch" the updates?
>=20
> All of this is possible, but the alternative is much simpler:
>=20
>     ${OBJCOPY} --add-section .BTF=3D${ELF_FILE}.btf ${ELF_FILE}
>=20
> Why re-implement our own incomplete version of objcopy if we can just
> use it to deal with the details of the ELF update?
>=20
> Note also that even in pahole "add .BTF section" is implemented via
> llvm-objcopy call. My guess is: to avoid the headache of figuring out
> correct libelf usage.

Please put this motivation in the commit message.

