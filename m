Return-Path: <bpf+bounces-35022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A8935295
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CA7282D99
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3219145348;
	Thu, 18 Jul 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbMfBp+/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9C1442E8
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336336; cv=none; b=Ctm/UeModzeu7lubHcNxmow3YuMDX78/79s9afshLS2RQFhnJJENf+64wQk0XfjemN80V1+8G8s3ac7zD8THoS/YTxktw+sBpJw0YHUm39cdKZjljBVQDbMkRE+iChDZBrnBELOfme8N95E3asyHY4a3BPhwyLcONEcaAzVL/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336336; c=relaxed/simple;
	bh=ea4dNCqLpGmreasTt3NGpUGf1GM5ziUjT0YElpoyWWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLzxvJDoXc27GTl7u4/iz8iAFncvuyGLSUniDk+H2huUFjNXBzxp4W6fKu9JBIWIF+/iFl8EzZnaOr/Qv9x+ULUpwhVShX0c19td9+0AZdSWysqteR5LjscM/cSdaC5visR1GmQ3BXDHlAtJVcLZJza9XI1Lh2mGXD/jT6owvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbMfBp+/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso228853b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721336334; x=1721941134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y1rhM6RRKx1YnWjZbCAP+TPxeQyZdbTUwk9+3cdDD3c=;
        b=DbMfBp+/Nq4hUArqem70HrP0LxMSuqcoHUa7RtZ2k6HY5fHt9LnW6rVEOjx3pzonmM
         4pEfGlMiMeOCOZCBryND4yzlin44EXmNKe8YvdKoeZLq37mT30VA7EAiD9QPmJMCd7Ig
         n1UTuRaI5X9L39Qci8EEMqYR4ze5R4oIfss4vk1vRoJFI44ggystuitzGyj3nPJNCyxm
         ai2HtLpGXokE9HyfBRr1H4pIMive2KA1Rdx8sqDXAxYRunb70XiqYAK/oF8W9wyCdmOC
         v6Ih14UlNUr+DUOJqH+b61NN2fInfv8s+6T6AcrtlSbsa0WTPq6B9AjwiTNAbVLue4IE
         2YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336334; x=1721941134;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1rhM6RRKx1YnWjZbCAP+TPxeQyZdbTUwk9+3cdDD3c=;
        b=igFGe9rxMwTJyok4M47PzqElq5cc4osOXxqsCkmKrDBg7vqAip/Mq76dMyw+Ym8bge
         0wUQcDkoxYFATSPSL63Jjtzvq6Ukl5eb8ozcv8opHo3sOL22D2zukjrHmNKYkuq39TUN
         LxiEt30enmGo5zSN/uP/wTWjeslhpt4lWEDlM300tAmipN392m1LE+oeVPnpU7nJqxIC
         LgrqkVugge5D2sXLJAZFeg1vrFTP2sHI5YudGpxCnelb6cBJ2UYE8yWGXyle6MV383Nv
         XFWiOzE22Ldn6vXQwuLhX0r809g+390Un/w4snHSJZFmz02BwxW6y9SAueqrZAjGS7mA
         MyAg==
X-Forwarded-Encrypted: i=1; AJvYcCXHEkF4DNnLEFh0Wyua5zXPZLtWh4KNwyt+Okz9AzWDTwpAQJ6IZrCNI23biYkWUtYw9mbyMd5Jq3NJl0plON73aZNt
X-Gm-Message-State: AOJu0YxvodVb4NOf8KNLBx8EJAnxSDmnO9vse3Iexfzmp5PpQX175QXs
	b3IWZnzLpMH1XdjgeVWU4VhXkq555HzV56Z5o294l2TriOWl8pkB
X-Google-Smtp-Source: AGHT+IFq+TzV1MqNLIOIMfCfW/2SN9fA0GX9A2SpcxxwbHdKrN8fZGJjSYa4Syy4baslcLjdCG8nnw==
X-Received: by 2002:a05:6a00:cc4:b0:706:62b6:cbd3 with SMTP id d2e1a72fcca58-70cfca0befcmr971091b3a.26.1721336334235;
        Thu, 18 Jul 2024 13:58:54 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cfc712756sm255952b3a.81.2024.07.18.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:58:53 -0700 (PDT)
Message-ID: <96b552a47c11488438c7ac189777838826f4415f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for ldsx of
 pkt data/data_end/data_meta accesses
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 18 Jul 2024 13:58:49 -0700
In-Reply-To: <20240718050228.3543663-1-yonghong.song@linux.dev>
References: <20240718050223.3543253-1-yonghong.song@linux.dev>
	 <20240718050228.3543663-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 22:02 -0700, Yonghong Song wrote:
> The following tests are added to verifier_ldsx.c:
>   - sign extension of data/data_end/data_meta for tcx programs.
>     The actual checking is in bpf_skb_is_valid_access() which
>     is called by sk_filter, cg_skb, lwt, tc(tcx) and sk_skb.
>   - sign extension of data/data_end/data_meta for xdp programs.
>   - sign extension of data/data_end for flow_dissector programs.
>=20
> All newly-added tests have verification failure with message
> "invalid bpf_context access". Without previous patch, all these
> tests succeeded verification.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

