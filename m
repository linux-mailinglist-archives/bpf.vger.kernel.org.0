Return-Path: <bpf+bounces-75009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23FC6BE88
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6CB5362864
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4992F83DC;
	Tue, 18 Nov 2025 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icwhPBkH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCA2D8372
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506494; cv=none; b=CBamvzf07Sd/gk8xuHOxDy4b1P8DCZa9nckRGTPyRWQHfQJo4vt95fijecK+dsj6K7uRtG1EL4dAwMIECQUTs5QPsdeDgLd8IGg8m0eLe3BeBpD6TrKdEpCBSrCFvs0LD0whQ/QW1rRExFv/Czuqg9dHGcwoXZsZMMajqGdB8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506494; c=relaxed/simple;
	bh=nqsaiCQB4noHMXL8AJBHd86Xc+dAsrhKg535yi+4rAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCV495u2d3sTVMwuLiubP+IKlJKbDOVagu+yu3Td2yN99S3zQMCh4B0ZfMnHFreQs8eWheUpkqjO3nDOeaXTDsagtA2KFdGHjh2gaazrHHy6OQ9/h6Kgj/qLJE5kBgikSf2CmfiLuqsgaUX9b8D3t6iDFsWDQde7cCQtGdLxq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icwhPBkH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29845b06dd2so69317095ad.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763506493; x=1764111293; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nqsaiCQB4noHMXL8AJBHd86Xc+dAsrhKg535yi+4rAs=;
        b=icwhPBkHK7mECqGxvZyD1IYDRUfk29imku/SMOacQNFyKeysDaQ4zQy90lEvBcib27
         4yXSPND3jrA829bhz3SfaY0sT8QvfkxWHk1/Ux9yEXZGmMwx/dYWu85zrZ3y/E5QeKZZ
         w4sJ0YAj79IxJ7e5xYzprpwZcObapXhRi5NgZXvoZoFb4rWNnyVsXUtsGf04cJNNX7Zj
         odgpEDi3HEtAk0LZEl9ZEZeIeZj2sw5LPDU1LZnt2SdRlbNylxaWOza2cWuV4dqF2GaR
         CUJ/R8pM4Q9nKaIbUPsGg2LgIG459BKDOKIStMaxUaLp03+RgUQciz0AGd8kNlGZrFd1
         KFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763506493; x=1764111293;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqsaiCQB4noHMXL8AJBHd86Xc+dAsrhKg535yi+4rAs=;
        b=AOjIHX0QV7FjjbaBxnL2s175mqRB2md+EZwrL03Pk0nBhfRyNoQMzTgfTmytfSQfls
         xIrd7TpRq4AHaPiDwyQGRick/BtZQNjfWDIJM4nXMd+bmnjb2GfZ1/U4GsnOMjEj90Dj
         5p9EciVJ4HZIUaBUUIhc35QefSz3wrnDzsz79Qt6jq6rWYCGE/7/RYkPLJqTfIlTJwxd
         SsGw04GT1OKWagrDfgTM4pmg6Oe09W0lFBwzIUGsj89JOBj3lQHLPxe/F15EdUZJ41CH
         IfpvYcsMrLS3rKeIg9g2jY4OnF7YlGSTF6osH1PXL4CgeGL+i3kr34i+UA+CuaVZdZ+Y
         yuSw==
X-Forwarded-Encrypted: i=1; AJvYcCXLfNUkxArla70HJMqy+CfXRVj+55LUQCS1snf36ziwrnYfw5d1zS84YUKuW7tczKwPenQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEJx6EZ9cFGTBY3ykZNbOkR/02I+YhGH5m/G//IG0GI8+eYhS
	GrnpMlvpeAj/iaYTSJ06sIL/UdGaARtnypRTBuDdnqL+mBJzU8rEohwk
X-Gm-Gg: ASbGncsQazIWKUqr7TzELMfvw3DWM1kDE+sF1Aonb/kGXARBW1x00CVSNrSu4Bp66cR
	V7XV6SW+u4wAHKmHzQ2bzYn1D4R/m8GyGkR4QTw2d6SpbaMZnxibuptKv/xoXSv6bSn2Fn7ZSRK
	Y9q9nRMi9vjATgAVNvZEPCl/U8RcDg7wsuvjfenipKPf0a22Y9QB/VhERmCXb2sSsfPcieIjIS6
	pZ2IOFOFtZVn4M7IkuMaMTmX4wi2jPaqcJ7o5bjg4qVqWh5X5YZk9fqLsGl1tHwq3XiKLUNokAX
	DC8tbD51sBWuhu5Z0gBErsz6sS08ArkTo88WzHkfFaRg/K6OG/pGy/lO+Y6Wh+bW1IovEVrekeL
	/7dViVw8Y5zjzaaTEok1n2vIuBNB6gYqo2klpn/FrLVM2vQBSWPFL8NecRQxP9vcBLiEKYlv/Ac
	uKFru5ENawaEN8tsMr6iC7xbR007jrdPcvLDhp
X-Google-Smtp-Source: AGHT+IFvEMTPCs+1GRDICBO65kEq7jTHFBFRsWJkFdUqMrS/FX6iEPwV23kdQrOTzJdn/tEb7ltlyA==
X-Received: by 2002:a17:903:3c47:b0:295:6d30:e268 with SMTP id d9443c01a7336-2986a755dfemr206427155ad.59.1763506492625;
        Tue, 18 Nov 2025 14:54:52 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a9d4:ea4c:ca6f:e5fd? ([2620:10d:c090:500::5:ee25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm183861595ad.7.2025.11.18.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:54:52 -0800 (PST)
Message-ID: <80cb706a10d6a4506f423ec4239969d77c5512bd.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/4] bpf: correct stack liveness for tail
 calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Tue, 18 Nov 2025 14:54:51 -0800
In-Reply-To: <20251118133944.979865-4-martin.teichmann@xfel.eu>
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
	 <20251118133944.979865-4-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 14:39 +0100, Martin Teichmann wrote:
> This updates bpf_insn_successors() reflecting that control flow might
> jump over the instructions between tail call and function exit, verifier
> might assume that some writes to parent stack always happen, which is
> not the case.
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Please add your signed-off-by. If you'd like you can put me as a
co-developed-by but that's not a big deal.

[...]

