Return-Path: <bpf+bounces-29990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C988C8F60
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 04:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DF51C21338
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885B4A2D;
	Sat, 18 May 2024 02:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1SICUp3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B682804
	for <bpf@vger.kernel.org>; Sat, 18 May 2024 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715999892; cv=none; b=lktDNPl/G2pBahc5Z1UlsSEgsOZqA3B9F2wGaTg/pFBDv0wXIuVL3AWdNTCtCAXoTrDqPQ61KRz/52w9tZN1baiFq0m9kIkH52qLALSGScYu+l64mbil0A2dPcP5j7jihFoNsB7T5WaHLTWN+ahwzdaF07d68T0zwnDG15g94fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715999892; c=relaxed/simple;
	bh=0WHpzRxbMHkzUbB0azQ1iMekKVriTZ9tsfBMqGEAHaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZVmyma+PVBkqYusKa8GzJDtX8yw9W7WAjPkpAlG5NhsER3qo90pdGUSeShZzMcamIyNLZbNyCjsb1qeQmP1SneoseWzKGT++07UCsSyIZLuSeC0UBH1b5RFuiR/Cx03VZq0P4eIDVZZfq/sePKYoFVrdgRsosvZIU5gddOfniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1SICUp3; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9cc681ee4so425333b6e.0
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 19:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715999889; x=1716604689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6J/w7RXhmiey7QmUmvyRbfAEpRqGc1zjez2O/AHRpDg=;
        b=S1SICUp3RmejWt/337GfhOpNX8FHvrx/QYuKlM+v5d3KbP9nlSo8gbqMWWq7WuQBA3
         tNggTX5+KZjX5uph7+UnBu/g+OXPn6TchJg9T1qHA9dzbyEfTnRPzUA+D9aD+CyByAp7
         cu6zU16V1cuCGofh3S61YEniD31+jSfltfhcs5Sae6VEr/3nTnKS2rH39+LHk1b7BQzH
         EPkhEEuhRdAcgOeiXFGdnIV2XlC+bySJZOCU8KS3rp5zVyfdAv70Jo/sB/H1jD5d2nF8
         rzxR1s+Dpbr7AqJpE1I7SYfJzi40QcC1xjdLmbcsE/bY/dITe/juy+BPbmYT2TmLk1YG
         gqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715999889; x=1716604689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6J/w7RXhmiey7QmUmvyRbfAEpRqGc1zjez2O/AHRpDg=;
        b=W+e42yfoIbKw9yEfhlf6QaFiKUDb1lb+qxWXo/uogYWzouDzh9suhvg6PkBX1fKLD+
         pwcUnx/uP7iuzfDwHuizbEtkvI/crV5yrEMg8iH99X/NRh8lYPNWn3eus1NH2htr7g92
         z1+Eu335rxP/O6qCCHIJyVMftdjtk/0MmHiiwE/g3pNgCv568l/uTPHl8L5m5uq1+cGA
         9DrNy7RAXLoi4uxHOGezTSWuoE4k20TXfFAmRxryWQjaElNVTAOvfT89OlI/8qtPia5B
         8vaTzKreuJgKUfKPxxzJAVvMb6bjlT3fphLAVoP5GIKYI0sz2skGt4eWq1J08PvLmsTH
         /www==
X-Forwarded-Encrypted: i=1; AJvYcCWCMPNFcitYPBSPJqhgY9syG96ASlcJDrMQl1j/1VTOa3PZWkU0hBlhjJFprUI4+un6iHcdvsBrOe7wKCi9OzayVoC9
X-Gm-Message-State: AOJu0YwDQXEXh+ilbsJsSnAlhFWyWeSU3MvH2LpdJaBF9SqwpCbis47Y
	SSPeD2qweIn0AX8SqMKfZQzvZuPewRaT1T0YQQ4CXd+HODuBveGg
X-Google-Smtp-Source: AGHT+IGLHRS6TWLqvbXl2r2zC0lCwr1yyh4NIP1R6HB1MZCcJAEwpY2NknpkfgBEwA1mCPibTCySKQ==
X-Received: by 2002:a05:6808:220f:b0:3c9:6a90:caa4 with SMTP id 5614622812f47-3c997023d43mr30695510b6e.10.1715999887577;
        Fri, 17 May 2024 19:38:07 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade2besm15863992b3a.98.2024.05.17.19.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 19:38:07 -0700 (PDT)
Message-ID: <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Fri, 17 May 2024 19:38:06 -0700
In-Reply-To: <20240517102246.4070184-1-alan.maguire@oracle.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-17 at 11:22 +0100, Alan Maguire wrote:

(Also, please note that CI fails for this series).

[...]

> Also explored Eduard's suggestion of doing an implicit fallback
> to checking for .BTF.base section in btf__parse() when it is
> called to get base BTF.  However while it is doable, it turned
> out to be difficult operationally.  Since fallback is implicit
> we do not know the source of the BTF - was it from .BTF or
> .BTF.base? In bpftool, we want to try first standalone BTF,
> then split, then split with distilled base.  Having a way
> to explicitly request .BTF.base via btf__parse_opts() fits
> that model better.

I don't think this is the case. Here is what I mean:
https://github.com/eddyz87/bpf/tree/distilled-base-alternative-parse-elf

The branch above is a modification for btf_parse_elf() and a few
reverts on top of this patch-set.

I modified btf_parse_elf() to follow the logic below:

| base_btf   | .BTF.base | Effect                                      |
| specified? | present?  |                                             |
|------------+-----------+---------------------------------------------|
| no         | no        | load btf from .BTF                          |
|------------+-----------+---------------------------------------------|
| yes        | no        | load btf from .BTF using base_btf as base   |
|            |           |                                             |
|------------+-----------+---------------------------------------------|
| no         | yes       | load btf from .BTF using .BTF.base as base  |
|            |           |                                             |
|------------+-----------+---------------------------------------------|
| yes        | yes       | load btf from .BTF using .BTF.base as base, |
|            |           | relocate btf against base_btf               |

When organized like that, there is no need to modify libbpf clients to
work with split BTF.

The `bpftool btf dump file ./btf_testmod.ko` would print non-relocated BTF.
The `bpftool btf -B ../../../vmlinux dump file ./btf_testmod.ko` would
print relocated BTF, no need for separate -R flag.
Imo, loading split BTF w/o relocation when .BTF.base is present
is interesting only for debug purposes and could be handled separately
as all building blocks are present in the library.

[...]

