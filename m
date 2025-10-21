Return-Path: <bpf+bounces-71492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2EBF5304
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 10:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96C8F4EE645
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217D2F067E;
	Tue, 21 Oct 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrK18SBc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F679287265
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034254; cv=none; b=HTEl2XfFjW+NoDa7ia4S6xyhqqPlN1H+lyv7ZiOKyyxXrFdmrljms0mVTrEGCgY17yh//Ka+GWGQZfw5lUPuMpw1EggeTxK3qQ0jH6BmAR7bRzlASMOsax0lFzSn1K6IPJR9Nvhoc48T+QpGIF/qlnj7KJvsjtL9DL5ICQ/2jmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034254; c=relaxed/simple;
	bh=DtLRpHYRv4qkYIP3t2raCTM/96A1oiI9zt24A29ECys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwxAMhTHyZxxE6LHxJ0KGglaiq0x2CUKvBP4fcA0/SF0jBYzNGaS1k4bEyFp03gjp//Tm0XkrJHShkTBsSBWnDiWKSqsV1JT0eQ4dRpeti35RBKx1SS9LSvmI3RDJ6iaj8LP6GSEqkBTKGE7k0pnbjBnUD21isNfgbXlf1aVVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrK18SBc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4705261b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761034253; x=1761639053; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DtLRpHYRv4qkYIP3t2raCTM/96A1oiI9zt24A29ECys=;
        b=jrK18SBc2+L5poST4Q+Bq+vNaik19pFjIOuLaLkzNr1rSORswRLo44yZixRm4WzEH+
         FeyyyELzK32bxP0iTTh8Ma+Ney03nfiVp1qlrEoXlke2qM1Qbh6v8NiPgowZygMkJkux
         fqJgfCL/8DK5zk/qjxPoGHkH/ZSJ9fetxOtEGSJLctwbiUt41oh5jDnkGYk0avS4V/wp
         N1GKCUnyyF2/UVZvrdi616IiJUxGB2BnPJznWhknc2NTzL6RWzYyVl18UxgJTzJnKsdR
         mP2D05oDW65kOmj/XrRblpkGWtN2YaGq7jR6hBT35HxfiMr+9NupA/V1S6ByEW1DkiXa
         zDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761034253; x=1761639053;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtLRpHYRv4qkYIP3t2raCTM/96A1oiI9zt24A29ECys=;
        b=t4oitUBNTpNNwVx1l1nfIzKdxWfsFPJJEil+u5JvWlaHv8nuLO664triM5k+xZZHiB
         kcbH0Cjw+Ho3j/M8yNhDbtMxw+M8HC3yXv+yee0bXYocVKiEjlJbzNP/x5iRTBqQ3Z1j
         QGlxHYFUF7xcvRgmfTYMo/1zQRvjbOtI6hQ8mfj+0ae0zHALevJL7eblrTN9RCdLmqOR
         ib1W91Jborjd5txU3eWIZaBmbp1hafiOR1wh4hEtYx4jj5Xnzk16I9Lz4O2U97FE0j9z
         9F92Zp1cYd5a0CrZaRw2V6mjNtTcF6qiXA+v243E2wyakFwYuXqOYbblqiMVphbU9wwX
         0a2A==
X-Forwarded-Encrypted: i=1; AJvYcCV/H6rKwg8TdXacYs6VleNbxSvmZYLCtIjvZpBKmhEmJnJXJA8OdHQ8qijTNnpklvj3bVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatMMXwMOQDAmqJWzWXPmrb6i/akEBItxJARgpItrjAv/lyqVu
	Qx5PM1aIZu5hRO+4Og3XY17bDWYgV3De9adAPHB6aiEsGzU/YMNhzvSvh8chII7Q
X-Gm-Gg: ASbGnctaeDgR6Z1mlWmmcG4nlQK5WHyN/beZSgu8AV5K9METyh12r5hF4T+5wAOXHcG
	14qn5FzfrNS1Le+TVJa/uT3pOZdUSfwkXbtocKpTUPkjWr1Mlh8Fw6TLqo5oe6rcFfzAm840kRv
	pbPuR7SMnS5pK4h+HIYBFDwcM46HwZOvON3nQ/rWuidMpgr7FyDNGYOokjngHbkNRg4WI4zYxy7
	wc6R3+o4s+CTFyRVpD/gP5jEArSwxGvPnYlqFadY16Yf+p5Tlk7OtD4Seg0RhV0jsMB59XP4NN3
	RIDcXYXdcl3N3I9cgeOE5bQzQTiVNVpnNhY5Ial9WJMNti34IrZkNzlAVtJTx2Nl8AlprsaFVja
	NatWx8qGVgUVgPHvDXUrxdb1YqKhGH74yD57jI6q3Spvah4Jae8LhsOVwjrMkGlHqgtLvr9Wtkk
	6inXuodEi4bD+4GFMX
X-Google-Smtp-Source: AGHT+IEjrcOyFtidvEifDfVa+CWuaNe/TYQxfgpZ+uYqRFs3uN+cEKFRQ40ybMwr5sLycdILwXKfcQ==
X-Received: by 2002:a05:6a20:4309:b0:334:a022:d79c with SMTP id adf61e73a8af0-334a8531ba9mr21253208637.13.1761034252802;
        Tue, 21 Oct 2025 01:10:52 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.42.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b77bf6sm9709013a12.41.2025.10.21.01.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:10:52 -0700 (PDT)
Message-ID: <179de8940292950809a1b27a6d37db3772ce42f2.camel@gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: liveness: Handle ERR_PTR from
 get_outer_instance() in propagate_to_outer_instance()
From: Shardul Bankar <shardulsb08@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Tue, 21 Oct 2025 13:40:37 +0530
In-Reply-To: <6cd4bb7732465debf55ef244aaafbc5047323628.camel@gmail.com>
References: <20251020060712.4155702-1-shardulsb08@gmail.com>
	 <6cd4bb7732465debf55ef244aaafbc5047323628.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 20:26 -0700, Eduard Zingerman wrote:
> This description is misleading.
> The only reasons for this patch to land are:
> - reduce cognitive load to avoid thinking about special case;
> - silence the false-positive notices from the tooling.
Thanks, Eduard.
I=E2=80=99ve updated the commit message in v3 to reflect your points =E2=80=
=94 the
patch now clarifies intent and notes that it reduces cognitive load and
silences tooling false positives.
No functional change is claimed.

Link:
https://lore.kernel.org/all/20251021080849.860072-1-shardulsb08@gmail.com/

Thanks again for the detailed review,
Shardul

