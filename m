Return-Path: <bpf+bounces-73738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D98C382D5
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4024B3B7F0F
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09762F1FC5;
	Wed,  5 Nov 2025 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjUVa7tk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027672E62A2
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381357; cv=none; b=NHiKhgPT90vFJE7tJ0Era3I9k9ALPDJwbYHunsZN2aKUlXzHE0Hi3ScXG5DHjMO9OXrKoi0Xp1UM9LIYy2svKFuBKzfsXIcEqH3acxd0aRcWuzvdTZ6c6LMqLGZFxK1Viu8zuopEvtvk3SUXvE5fwUFCYT+bogHUK+bTYOM/4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381357; c=relaxed/simple;
	bh=RvLX/B9HyZgBFy6vMfMFfbx7Z3GJR59vS3ShKrNuy5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7rXsIILJ+eElLz1jYOs7E/vntPmTa3XHqyECMm6oELgT8UVfLe6vetdaJMYXyJWuSOC0/w0lwvxSeVRfqzRmTnJphO7iyOcwkZfGd0fdEr4U9yEp7/gTcGq73OjpNXxu3vkVnd8i5X8Gnrtz5QokUZRvQb03YbWnTCzdgi+Vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjUVa7tk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ba507fe592dso172741a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762381355; x=1762986155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RvLX/B9HyZgBFy6vMfMFfbx7Z3GJR59vS3ShKrNuy5c=;
        b=XjUVa7tk5vQNbSrCkjSQ21NCTxgLjdenDUJBjiex2/P2nkIpBieQoHuq56b6g/7YrV
         IbmCNcNxbyXOQ2uBCfI489/JZGD6ppFUb/D1I3IHoO2PvAXbny7yg2I6tDlXHrHxxBRA
         kEZ2/2VskiyQHdYKr++cz6LgEFGvxeuArADjw7NXnQUgmWQYcByEvQpKuz1/daiIkr3+
         IiGyk0dSCQyl+YftXEsyHU+/Hm86/h3kbTQ/AvEqCKZPG4GsVnsWR2+YASpwfo5nN2WF
         Vtvj1k0V4w1fUzmfhOTLo925Ylge8fFvwHDKbcDeBNhYGTxo7VHmoqqiBuF3iwznSJFk
         5C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381355; x=1762986155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvLX/B9HyZgBFy6vMfMFfbx7Z3GJR59vS3ShKrNuy5c=;
        b=B17X4COqPhDEoGIpawmljp8uU+X3L+1T6T/syNKVtThXstlB7WaPu2TSI8k9bgSTKu
         6ibSLRRaWCGqNbGde0YNwevY623SilAJ5NthJWhRi352r55ijjgebcg2NVpBU4HWkWbE
         1r32RtPzit8a0MJW4U2Rp6HTLHLn012NM7//W7WSMb3wPPhMe5XhgXg6CrjXuMobpdJF
         2QeR6ybFhefF9nl5lkaNeE4lDqKDlLKJm5zLtRg5ib/0E6B9lfiuuFITCR6rbElL9Hd5
         VE0BpRVPySOcsQbGZGAkk/5V1FVG2r0MKXcSa2OaSmX4i+RRC0dlOqBWGTyGd+dntv15
         T8ig==
X-Forwarded-Encrypted: i=1; AJvYcCXCM4qbtF29QkXpoQ2z5xAosXCTbRq+ANJSpLGl10ygz+DiZrG6xaP+bibxzg5IjMsUCjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4rVBBN1z/E1HmM0rtYpDzOnnFigvqLp5nTpnCPcCftXy0ipQ
	+pgLWwAA8E5QFO3xutM+T19rV68bWvN6w4fZTftLzLsQzd69GCgGRviG
X-Gm-Gg: ASbGnctHXby2BzfD/TirOLxlcZ/EiqhFomVONzNjrPdmmT9C0aVKZw6tYHLWLRSmZFk
	gt7Ab6CcJ98VjE+nfk5Qdfcs1PwzxWf/qJoup6iH5LHLQg9Z2lOvUcPUqmiHL4R2qVLV2g2gLc5
	9FRXd2BBV6wd1Cx7O+DiXqHEKNvjT6rpZUoqVr6P1LKuguM8a+f0BY7YoVaP92EAgojb01hu233
	Qh5N4NA5d7QW4zenogovDOvboINiGB8iCB+HgttkKFei3S0eEIEHLcnb9nlnKFiw7n98g+RLm1q
	QNYaZspkYBp8hevz1nZ6aMFDyWQPAyMw3cSYIgDeQwKALmPHvFihYpo/XaT3snBD3LjM+cko5bg
	g1Sk+7tXwVf1GL0mKFOd8OJ7Tw6QmvME8ZPRIxTs7t48B0/AYVzs9jSDlSEDCXSrgJ0DN3jbrVR
	rQhE/6YucmpI2csqSJ5TvEoGSG
X-Google-Smtp-Source: AGHT+IFNpsrJwWvShOgzTaHvHA8SiGJMawi4S4q7i+YGcAuUdkfNhD0nsFKo1Vh7uDY2cIu5PeeeTA==
X-Received: by 2002:a17:902:d489:b0:295:702e:66e4 with SMTP id d9443c01a7336-2962ad29f31mr59676325ad.19.1762381355250;
        Wed, 05 Nov 2025 14:22:35 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8ef47sm5677345ad.74.2025.11.05.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:22:34 -0800 (PST)
Message-ID: <29784285224aed7ffa9a44434251c75c96c2c26b.camel@gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use
 bpf_strncmp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hoyeon Lee <hoyeon.lee@suse.com>, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Nov 2025 14:22:33 -0800
In-Reply-To: <20251105201415.227144-1-hoyeon.lee@suse.com>
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 05:14 +0900, Hoyeon Lee wrote:
> The netif_receive_skb BPF program used in snprintf_btf test still uses
> a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> available and provides the same functionality.
>=20
> This commit refactors the test to use the bpf_strncmp helper, removing
> the redundant custom implementation.
>=20
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

