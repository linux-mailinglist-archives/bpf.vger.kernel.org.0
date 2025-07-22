Return-Path: <bpf+bounces-64112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68311B0E5A0
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F5A7B4012
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C627EC7C;
	Tue, 22 Jul 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7iVjyQ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180D27E076
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220323; cv=none; b=OEj620s+KkySFI75iV+bltspiOA+PlIvdb8KnBx8mkCVkMUIqTEDWEJdrqClATQLn+Y0pTG1FUrVNqLvlvt491JwINJQCytaYqeyH31tCV3Sdj7nNZ+3vqcVb/jutzxTKmJC1brgqiTIW3jG5UKhEe0HZAAZNyHlP2zYyiiZ3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220323; c=relaxed/simple;
	bh=fTWXd+6+mx4khVLuwfdkl6bYrIOQP0kvOjItvPZMflc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CLWQfudOV2NYfj6BFw1IDlsHc4Nb5MWcsis6A8qe1fJVBuQglvOMX9KcsJqvlJfZkCFlvOEdX6cEhyU+e5U/UOK0ugsfY7rjv+/aMzg3wDVjlIFQXXe8SKwiPxhOlmQGN7t7F+XlSYgsb7pMm7QcDd04gCuBGts8G2DyxAjIY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7iVjyQ6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31a93a4b399so317703a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753220321; x=1753825121; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDVHP4KJkTKD/V0AzZlOnztJH4HTzmntQSgZyMusVeU=;
        b=R7iVjyQ6BHazoxAClgZShvo4xtz61plJJHj2swu0+6OBJsNiOPJFe9MptvJOahAg7I
         BfrA7p4Sck6V5Yeo0aDqCTNMu8cY60q7n3TPFBJs1lEEtto3HZoWbmZIa9dHsNiGaI4Z
         DwCe98Vl5l3quarXkx2zdAYe85/meTuG1SSWw3MTP7gGwhZ3ZFShJSf0AMVyDjkfNEOB
         cEpeyMmKRaBWrDp34lzNtwXjnCSJqdeyRwFcnhDl2rmcOA4JFjRAqx8H1pW28JaX1hRV
         Og5JUQ0hxJQ5ZAcDAfLr8dTUX7NkqOb6YFN6Xt7HhqLSJtNKYZr8bJSXolj3zJko1Se9
         pTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753220321; x=1753825121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDVHP4KJkTKD/V0AzZlOnztJH4HTzmntQSgZyMusVeU=;
        b=p69Z4ouhyjacSD2tpR4bElct3cv5TktrgoPeXcQoDZWxBGWAJi4a8T6ZMln86mKNYE
         N2ouqAP1wD2fE5isOq3Q/IZAmWnCWUpcYzsmmwvgr7YQDq/fS/9KDr0F4TBMA3eyxUCB
         feor8iKPLSYwbdpNUUO09D3FNoWlYeJt7qe/qLboHQjIe6XoF5cTyCO8S8oToih4ntX/
         3TxdGeZr0MX8vZadCD5CQ1lDIjiMOQDdO3T74OgvIFWMhKekgK7etW0eaPQw6D5b5osg
         /2dQCgxMbgwLKN3TDkMAfsjY38x8wMaev9jFkchrNralW3jxrxSVqiCekbVN0bDvCo1K
         8Tiw==
X-Forwarded-Encrypted: i=1; AJvYcCVTlRowNoCTYqwZbmumkel78a1lPM+D9xDMN/TTSFF075WtJ55IHwlF64tZfDLtcj85yvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnN75xhmk8c5JP6wU1zuXmZZPH9lPUlXPBr7mD9K6oZxfc5Eo
	zBDkR9tvcGUdbOzS8FmLpi7wxTjtRYukkWhzKdGyQ2PO4tYMI+qQrgUnZUd/ox8O7Uk=
X-Gm-Gg: ASbGncsEZACBYiugJVxeIKBfrTy60N8eGmFntFVuGeuWrQZ4rvPthpV/TfJE2qLYTAA
	/ImMOeNG0uTvYRtvSMCD0mUxBp33vaNF+LOE/vTqjOZ1wuPW0xcTKW9Q7pntgRR0DMIfo3xrxzf
	1WEjxfD0lXMgLotxp8w5HKvHnCA+ezAOn7XE8VtUsdV/fg9g/arlDNjZGr7phL5kgOb9ceYA7zE
	BYeUQoCPBBBTU+oHdD7mheWOy916nUUDtZ/YfUTlyOKebfVe62ALcjeIXHITwo83+O59QUtHKzx
	TSy8bqWyaU2vPqyH99rwTOrydxhUwlIa6OeLcpRHbvoewAl1M+AEziJpW6D8W+atmlZxRHNwnKx
	z6HhUUspPi+YrRwGsGveExCTZGqq7
X-Google-Smtp-Source: AGHT+IEDQZfsBbZgEMh85juQY1uyi9zmpxg74EJQ/oLHLJ052W++0GOZA3Tc1OK8XCkW1ooY1BOmdA==
X-Received: by 2002:a17:90a:e703:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-31e51328b0amr542853a91.5.1753220320937;
        Tue, 22 Jul 2025 14:38:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51a66d1bsm96285a91.27.2025.07.22.14.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:38:40 -0700 (PDT)
Message-ID: <bbb78a937a3be7229d0aeee1578313f8c014d215.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test invalid narrower
 ctx load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Date: Tue, 22 Jul 2025 14:38:38 -0700
In-Reply-To: <44cd83ea9c6868079943f0a436c6efa850528cc1.1753194596.git.paul.chaignon@gmail.com>
References: 
	<3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
	 <44cd83ea9c6868079943f0a436c6efa850528cc1.1753194596.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 16:33 +0200, Paul Chaignon wrote:
> This patch adds selftests to cover invalid narrower loads on the
> context. These used to cause kernel warnings before the previous patch.
> To trigger the warning, the load had to be aligned, to read an affected
> context field (ex., skb->sk), and not starting at the beginning of the
> field.
>=20
> The nine new cases all fail without the previous patch.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
> Changes in v2:
>   - Cover all affected fields, via a macro, as suggested by Eduard.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

