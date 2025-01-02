Return-Path: <bpf+bounces-47752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7919FFD5D
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E77162D5B
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684B190462;
	Thu,  2 Jan 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmfwvlUg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD026281
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841132; cv=none; b=hHoPmkwNkzTQPRUlyLOxNfb+usqXWn7ePEZFhdZzKy2zt+ZjhFXLsCsGMLIFwOfKzHf/+KBqHXFKM+JtALnrQRByNC7S56eZauMrDQJLcat5PmYiiZPABEbbKJNmnLVpazLsYHtigRmtMDAQxUxZsaMQpcQcF3DqFPfTZ5eGl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841132; c=relaxed/simple;
	bh=bMUQfku4lmN0iyrXczaEoDO7/rN0tpVL2eUHgIltoEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2pHWCCPtjTk5aLMWiG3rmYdxL10LEYYV8bBWves72bRAj8/e20dOr8p+MgyKyZ/XiAm/VUEchkdJHzfKO4ZVDc3wTMr87SojCOOhslW+eeRKSK7SSfYma1+j7jQbHGA28VmBJNcy0KAdOuKqtyeeiZm8Vk/NTwfA0lrwfBg5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmfwvlUg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21a1e6fd923so115822935ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 10:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735841130; x=1736445930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMUQfku4lmN0iyrXczaEoDO7/rN0tpVL2eUHgIltoEo=;
        b=nmfwvlUg1Z0Zje2BJCbu2nTdKmbFYffgqMnW2bpIkulTlJBHiBZiYkX2pI/KFo1OOk
         uJKJeYaSgDr4t0ZD1NnHxjySxd1eeP8jsHygsF8snVSnkPwdIn8uHkWgyXd34f6dtniF
         f5mWiMXSNx0//5Kna/lXuoB9/y8dMznWvMZV/CqPNxxcPH7+joKbuBQbu4tJPIuEPnnd
         NAMetYpzLzLY+hYHZ8KpqPHQ4o6bHEdTq6W9IMtmz1gFrcRyF2Zw0yfLPGrzd5zs7xz8
         rr0oaWrCzCvxHjI0iMuiXITd2NZIz7SvaBffzcvTyueHzlIhT8RXwW5xncEm3qMsy65/
         AavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735841130; x=1736445930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMUQfku4lmN0iyrXczaEoDO7/rN0tpVL2eUHgIltoEo=;
        b=crlBDs+0u0R/kd7S+o0nWB9Pmzex0JuhwJyorLFgy1G2ZutyBGRvgh6QkQ0lkC8tBu
         Q00Im8cx2Q/4uXA7G3D8nFlDqEpvgc4sZ5uVnA+CDiYD2GR09lOglo2pJTo6GktwAEb7
         HBKQpuTAKMLPPXa/rtRxqOmpksodGwdPLZQcUsqCC3pycAEpcqPx7kNnYCf+Eh/t6Bxr
         PdsxutMABtGi97sqV+fPwWiZOH/HEymrn97xbb+Js5j4rUZa7q+aQrGVNH8iNLN2bQ9e
         af8ygWM0xIAMjLHtejnVqx39yMKfc/Xj9h/yszicltc48WK7f6XRfPzjVWKi6N7RjYks
         7jkg==
X-Forwarded-Encrypted: i=1; AJvYcCUqXTrGDylv7xbcn59PcrKRzJmek7F7oOXE/sw2/bePaYQrZa5uHj0LHHJpwufcz3cGxMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2bVCgLF9OBAh+JHE774kMci6RD9/mveTPRPZOnOj/GMfWN23
	0b0S8h9N+l2OKT6CHkAvJUhHOy5KZJO3scTFDuIg4E4Z5ayzyCdM
X-Gm-Gg: ASbGncsZrVywFDznfn8z9gKMQOqPj8KfEcVFFhJEn7U6++ryy9st9HXHvjA60QiEKbw
	KW3Kp9gjw2V+AnhIa/qjDYgIFKrgLRY+kenB/JBddJHv+n5AGqQ1FkVpPp97C1uANPCv+rf68vJ
	6WR2VpXU13qlh9OlK3OodFlUZxZ03/KM7KcmrFOj/bRyos6lQ6ZRCBpR+vxI5LzW2bjWxCKgYV1
	ok+o5OuS6fFV/pL4PQGcK2duAZkNK8OG2lC2Gv7BVwInmnq5cidLg==
X-Google-Smtp-Source: AGHT+IGLoE6MmB+sIGQAsnB1/qWZrq7sFWS0fDKi1rvjEsRAXtcirjp0wNIz0MjRQykzsWv/YG038g==
X-Received: by 2002:a05:6a20:c70a:b0:1e0:cc4a:caab with SMTP id adf61e73a8af0-1e5e048151dmr68099871637.19.1735841130284;
        Thu, 02 Jan 2025 10:05:30 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72e61sm22711573a12.3.2025.01.02.10.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 10:05:29 -0800 (PST)
Message-ID: <e607f3c5ccdeb898db7d1e53c71b6df85c4091ed.camel@gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: test bpf_for within spin lock section
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Date: Thu, 02 Jan 2025 10:05:25 -0800
In-Reply-To: <20250101203731.1651981-3-emil@etsalapatis.com>
References: <20250101203731.1651981-1-emil@etsalapatis.com>
	 <20250101203731.1651981-3-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-01 at 15:37 -0500, Emil Tsalapatis wrote:
> Add a selftest to ensure BPF for loops within critical sections are
> accepted by the verifier.
>=20
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


