Return-Path: <bpf+bounces-79540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB7D3BD64
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 03:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D06FD3006716
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA442B9A4;
	Tue, 20 Jan 2026 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5yPp8oo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F49824BD
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874478; cv=none; b=HNurza2dJc9Cm4soAt/hLwkaazszkfVk1FsgCLcwyed6z5vSlwBS74+iLlgeJZ8FSufOSLc8jc7bIs82nJ3gaDIJczRb/9ztaaxbmJ3iBPlG1w0lz+3LUC5o9ercdoe8WPEO3kN2wLPal8X8QK0spSy9xOc43jNtzm+at+L1Qxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874478; c=relaxed/simple;
	bh=yzo2857juL/G5W4Nvl5biIIxiHg/pGUeqWEkOrOEnRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lx6VpsgH2mLsHYCReVCDse0D0DheA30EjAT3doTIa22jzsednLp7I/BOFLyB5LkZI5+uPb+ZSI9uAdYIzrmQLmafDExUpqLsNjqvaMMYXRc4p7KngVa+re3SMmelYZBdzeD4fjYnaW8xnDAlk8OOzasa0isMN3iX+InXG+yuCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5yPp8oo; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6519495eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 18:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874477; x=1769479277; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzo2857juL/G5W4Nvl5biIIxiHg/pGUeqWEkOrOEnRk=;
        b=b5yPp8oo299dYsD1g/tLbQ3GWaNEV4XGtQgJJf+XyND63hmJY2m6KoDDSug64qvdRh
         fgm/1mrGw06sR8CATjG9npAOb5txtBbRR2P8qNuxLnMOzrSrwMQnBrqZtCUIJYv4cp78
         sOJHblFg4TtMZpJHYsaPFH6/i1Jd1FmIwOnlLG4VBnw3+Q60v2T/3tjNndiFiqkm7Rsd
         c7N4/cQ5LstGeTOXQyos4wVVvxGoB1QFEPtNNF5MlIIQBr/fF18FHk2UQwrvcUVPGBFA
         tn+Ke64Xj2gUj9rmODNUahK63YtbcwRS41aUH8edDFP6OZQQu4gOTmKdLbKUSZxlQ4A7
         wUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874477; x=1769479277;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzo2857juL/G5W4Nvl5biIIxiHg/pGUeqWEkOrOEnRk=;
        b=BTzAdiciikohPTAMx6z8wUhkXWDwYzr9hNZwSnWsyVGDDMqVbiirQuqakvz2Oip8Jy
         FNDPF/e5SUNWopFY/W1pxmyJGTbFXNBGN6y80yT0lTqVTv0tPp66FM+e5t9sCJhVTjRN
         xXJDH17ydefBL69/cCR3jf5ccdrBP+sNgHG2k5kVSvevKvYZk+EeXHiFfFVHOu+xN8cQ
         umnzraBy2nn0oPiftOUqY+Kfd/VLiWUcZzG4iFCDWiyhbico2x/tUScYaRKa1v2rVlpn
         nJ3i6KPV5YzDVW2too/T546PavoevlP+xXKUJGgSvKP/a8WPzI09ejFEfxLI3iPAM/XU
         bmrg==
X-Forwarded-Encrypted: i=1; AJvYcCWa//gX4vioAsbM75IWm1QgOE2kuLCMxdz+J+iFk2WgW8YetnX81e4FXz7q7142gd2yYMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIAU/7hlIzhn7+nj2IyEw/gNwXn16k0ldw3xXZH/mQ5fJj+Py
	YtB6lQpyyQhW+3d7UzbZJlIcXp1r5dtYw05+/cSoZfIMAWBuaqity9C8
X-Gm-Gg: AZuq6aI2J7q4SOWMn5+7GhEV6it/om2MKtjj/MwaUrNkylXXDo443Bjtwd91bPD4SDu
	cAPlF3nlSZvIf1wVwCeUgLPzxU+DUtGNVFb8UGsCDozN9UiaXZCGygzqcvKoNTrWqSYVUZe5L7+
	lSXpilhnL0Eu9gTkED5oA6hE67vTsA50nhXEnfieZ61Qa2MyjeJiNUNaTGdHxsjHfXhfrvLwsDK
	qcLaEdIFynhB1RJywdhldoUHujk+hU/f+UTXRMbsoGjJgq6lcJuLghuuh5HpDCvok9E1GruttvU
	DinkCv45t5nquzFA8aG33TTT1dtTRRU32Zxjob85OopnRV1u+bEmXnmP49bAIoJ/p/D3pI/MDPi
	8ATWZxBDBIttU+5jnTDxtqvW3lzCfczwduFCAhV49isY8Zc8i61w40GQw8hcIi9goghI7TnmCed
	omKZ3NPsD3BU6oUirtkwrn2A6XUkComRdmCaJBVCXJNAW0S2LWjwDexHK7mkviKQnG8Q==
X-Received: by 2002:a05:7300:3b08:b0:2b0:4c33:8e41 with SMTP id 5a478bee46e88-2b6fd79a46fmr221707eec.20.1768874476451;
        Mon, 19 Jan 2026 18:01:16 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3679980sm15529952eec.31.2026.01.19.18.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 18:01:16 -0800 (PST)
Message-ID: <90135b24dcdbfcf0a5e45d49a6c6f0e18ed73986.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/13] bpf: Remove __prog kfunc arg
 annotation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 18:01:13 -0800
In-Reply-To: <20260116201700.864797-13-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-13-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Now that all the __prog suffix users in the kernel tree migrated to
> KF_IMPLICIT_ARGS, remove it from the verifier.
>=20
> See prior discussion for context [1].
>=20
> [1] https://lore.kernel.org/bpf/CAEf4BzbgPfRm9BX=3DTsZm-TsHFAHcwhPY4vTt=
=3D9OT-uhWqf8tqw@mail.gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

