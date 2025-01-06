Return-Path: <bpf+bounces-48007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36091A031C1
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F330164F98
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35451DFD81;
	Mon,  6 Jan 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3fVmlwv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E11DFDBE
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197365; cv=none; b=a5RhiLMKjZlDpEEJFxhLVfzk3gkJU8KErKOMpJw3KRMQOf0HkoAqsyYrFzvrd2L8R8uGAi6N5SIlBAfXn7qq8pdMhnrHB7zg+II/h+E3YhNTGsOurmUNzFkSgS6+3iar+ejdBkN7kP45d0/D/Q6zNhyXlLm+FS7wmsN65hmaU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197365; c=relaxed/simple;
	bh=WLW9aX9cs3umofLaSpoZ6mmMGf5ObZkJd4+IZE0OmNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCzYWAsiW5f6rhBlNJmR9pLY3UHh/feN+BjUZaA5voIefursZmsBFLbKp874a3K+P73nnH6E4lP2cgqNpIuUwmar6R9rFkL6lYnuXdAclmh8LzjaTCUjj/jgJny2aKxVyo9fc3RRrDcH7n0bOsnsy9RkTbUHhLToEtL8WqVLLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3fVmlwv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165cb60719so218407765ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736197363; x=1736802163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLW9aX9cs3umofLaSpoZ6mmMGf5ObZkJd4+IZE0OmNU=;
        b=H3fVmlwvOSQO0PSxmMi12KNyUNbwSSKa7UFJbulSYT2wzb77YMjVfyKESKPsAolwCF
         v6YMSMMbbzLS2m2X6YHalRqKALT2/nyNenoGx9tTO6DTWm//bmEN357ce0VNFUtioD+A
         KX6ZIlQeIuwL/T0CiJayxOI3mJ8J4s1XS59IRwCAtFgSlnes5dPKd1Xx8r9fQIuEX5os
         B8R/DQlnmJDvaH/xPOx/IU55pRioN9Jl95ATw8V+L9YCs69IGZQMez4w/CBFVXD18aN+
         RK+yf7uAdQ4s/Por/sZGMR7oIhgBGT5gD47tbEBGOfkTacQ8xEzTDsTJLEltIhihSkOj
         HE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736197363; x=1736802163;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLW9aX9cs3umofLaSpoZ6mmMGf5ObZkJd4+IZE0OmNU=;
        b=jdR59cceTK60Ac6epk8p/70xw3G2R8SQhlngU4hINsE52YprHLUvnPCzH5YwXq9zKb
         jKs8+z8sDQblHEFUvm0syTJ50bPnmuwqLL9iSr9wS5Fo/wAHsWc6khbfK4syWCvqpnPg
         9MZIrHsbvyXJ7ftRRxKey7i1xREL49WBOpT6jaJKS786FWdHyyI7IhmLFMM0318KjRZZ
         pzMUoJikzungTp1BLDQGwg35v9IfRcUCRm0nEh/6s/+CCqEzerSN/kDlscW7OBvoxdyv
         3j/idWPeokAm7sFXC9wH5LBcMhND6djELr/hD7Vg7xGJ8hxjglcLBN88ci8tX8eklH1O
         wSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFYmWHjx6GvPlEqaIXlV3ePcq7pAaM2Ng7MQIbMyZm9vADimx4chcU+iXIxCnW5ZGN/jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HGQo5dA/0P4L8V5b1we+gxcQ3+5uxhylsnotX5VeHUnHKLw+
	BpCamIWY7VcGHN3ijpADA3nF7ZzmtmIMfvJOPJn7gtOPPjPhdsoXZLXK1A==
X-Gm-Gg: ASbGncsCh60BV5DOxe1idRj82fBh/rBal9gA58w7mbQJzn/4hSA4CEpwwD//EzrbMyG
	pXdpv1mJh+FmwRlh/OM2/bSFGeY19+Q/zw6qNh2LmKK84omwitT1pFhMManmlbXSsuKC8qWFcJa
	ZWYNCkLEkOUJjAoPKJFTY4M+rZARs19AbQPciD27y4NxO4OxsCAUSqcz/NIR0wX3QsVXI5Je834
	WO9WHSYBq/5aJt+/WGeI0CnDcbibYDn9/rSSoZDS3aPhQjDtVcHYA==
X-Google-Smtp-Source: AGHT+IHKcB5SPfzdqXFULydS4zrD3yWGxTBysZmQ1FOZnfy45kNHcRWuo4rin68jCKN3e/sM60trCQ==
X-Received: by 2002:a05:6a20:a127:b0:1e1:aa24:2e56 with SMTP id adf61e73a8af0-1e5e07ffd4bmr101833213637.30.1736197363171;
        Mon, 06 Jan 2025 13:02:43 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84cf91sm31687637b3a.83.2025.01.06.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 13:02:42 -0800 (PST)
Message-ID: <4ebb32d8c14f61077c839514e193e323c82272b5.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add -fno-strict-aliasing to
 BPF_CFLAGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 	jose.marchesi@oracle.com
Date: Mon, 06 Jan 2025 13:02:38 -0800
In-Reply-To: <20250106201728.1219791-1-ihor.solodrai@pm.me>
References: <20250106201728.1219791-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-06 at 20:17 +0000, Ihor Solodrai wrote:
> Following the discussion at [1], set -fno-strict-aliasing flag for all
> BPF object build rules. Remove now unnecessary <test>-CFLAGS variables.
>=20
> [1] https://lore.kernel.org/bpf/20250106185447.951609-1-ihor.solodrai@pm.=
me/
>=20
> CC: Jose E. Marchesi <jose.marchesi@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>=20
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


