Return-Path: <bpf+bounces-59082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C17AC6003
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A414A42BC
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C481E573F;
	Wed, 28 May 2025 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWx9Ie6A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C51DF963
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402540; cv=none; b=JpYX9c9nHlH+/NF+EnFsVbzBBiNtRgzZ1z+KDLklz0bnI84LW5VcENHprokoG0ziLz2c4LTcpzzniP0ljakBgnDn5yoF4/5T3haY7XQzCNJkRr7xuj3zoFMymQLin74SHuOeCQcwgynWijjoBVx8GdlSr6mxS9aScIYGBU+EAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402540; c=relaxed/simple;
	bh=TlL6ea7agKcozcBW85BEZTQlNOOs8G4N0oj9OW3+jEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snXTMwtEkvbbIcg0p63TwY0Uqet1zJGFL6nFgbX/tR1iY/XyukqeFA6PCSh9JivFLepG2RzLXAoIbUTHYsiaCHoF1BtaY0Rf1cEC9YrIIQPriFh8ktJSr1FRXLym10PxKmBGgBIpy+xPm1yhE8Egkd16UFxM0bmsLLm11ORMIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWx9Ie6A; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349068ebc7so135515ad.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402538; x=1749007338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlL6ea7agKcozcBW85BEZTQlNOOs8G4N0oj9OW3+jEw=;
        b=iWx9Ie6AAtxQaXvZupLegK0Od2jG4TBVJ2TZV8Va+YXZwev52fTAueV172U0+04hSy
         jWoX9qLmbwg1RU4v4e/I9qbtOYzxc3Yb16vuI/zeBoVdK7GjIghsofIkVcjgm+bSziPq
         8h/wddHbUu00eW0KBYY3W5GExQcFQNze/XqRanOe1t/ffe8mYMyqdQwmuuHxWFAFUu+9
         V4+vWjErzGKfKG6LlxFfEH8YTwt0IUyT5K0i0La0gi5O4EOc4RcXox+3vgrYObcOLIuQ
         1Es23UHs0cyJkaNTJKRv5nij28d04+PxsRxjDIAY38EZ5gosItgvCU34aMtD9NEFHUqa
         UHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402538; x=1749007338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlL6ea7agKcozcBW85BEZTQlNOOs8G4N0oj9OW3+jEw=;
        b=Qm9PHAxAg1DxTLNxdHSpmJv+i5FpgJBKynJC563QgkV2YAfYXXSRNZTToUVnk79iZ7
         8tdJoypO7KChmaUV/olslM+f6yaat4KjTSvlQeV0q8yUgX+OoYLPgNPiVKD1+qbLY/0R
         1d9HP2V5HZU7PiRrW1MUU9wk2UMqudBzBFtp7uqZubkCBJINXWkmPq8hwuHJ/YV4PKuS
         QySK+zHfzqoGG6tJGaBwgacgpD1/Yg/2/RRsXB9adSoXEVKRHN0XAxufKSDEJti0Vazp
         gUtJGaQCwBaoiG21E7LfvPfeZez71LeNvddlBHddCbr7XpKNIrQ0YJ8f1WgRfgP6sQAJ
         ixgg==
X-Forwarded-Encrypted: i=1; AJvYcCXXsvX6BXhG0R56pqUZDs9kc09H3tqPVkrvqCIO0m5QXapwaJ9Kxi/NiIxqvBk1+6Bt8Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TCS8fr5Hadf9Idl9lc4KHHtzCcnN7nfPsRKjfZQAXEhhJ3S/
	qAB0dtGcQfWjr6uZg62AFpkmPViKNnOuQl/tWVxlFLL0V+5Eu0oGqhBbv2fx85mmHZ7mq+l5mvc
	l8xSciUzwBGKSuxRyGTBpww2G5QzXVDJc+ojvIMWN
X-Gm-Gg: ASbGncsWbPXdWKOKgD5bUThRqMqlcQ/ojAi6LcIzXl36rK5hHHnGFVzNf8PJ8rcC19E
	qiZ4CS9SJgmDaRlyuQ3fXz9yfsVaDbAZx5lk/twkTjtTvqjOO+6vz8xAJ4EGnc1ldXtjkGtjpnL
	wUVMjRJD6kFIWMM8OR0aOm3lDq96I3CdvSGOelACU4PdIl
X-Google-Smtp-Source: AGHT+IFjWMsFjxHEWSd8svaJEVsREhu8uWRJJnik1FgFnC7f0wirbtl0vmRI9Jco+Bo3khu2tiMHY3Xc/icJ/DCXCgg=
X-Received: by 2002:a17:902:d48b:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-234c55ab922mr1985015ad.18.1748402538236; Tue, 27 May 2025
 20:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-10-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-10-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:22:05 -0700
X-Gm-Features: AX0GCFtRcX_EC4PBnTs2d4ZNLeICGbCHPwkYh58-YwsRhc80hGZv7-czylYZ2vw
Message-ID: <CAHS8izP2f8oLFRZ=_NC=W3Ky9fqXJpszNNAiXN_CBYADfz4UwA@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that __page_pool_put_page() puts netmem, not struct page, rename it
> to __page_pool_put_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

