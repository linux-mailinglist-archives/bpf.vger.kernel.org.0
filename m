Return-Path: <bpf+bounces-27788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5C8B1ADF
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 08:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCFD1C2117D
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 06:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9D40848;
	Thu, 25 Apr 2024 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="th1DddLb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CD3D549
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026147; cv=none; b=IUFIXs/u1tV50GRpPpMaY6ROFVk6uISlj8x+9/kdhxlqmtF+76hhyDqpEUZHB39Fv+s1Oh8a0tvKv6WbsGGE6BzjaZtxyEv+PAhKqACLVEr5Y/1hhxx5VnGmatjBZnN1KCbVbJJke12r2xLuIC8zYaEkh+qkGG9DB5tY3kJCbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026147; c=relaxed/simple;
	bh=hqlfKxyILHk+W3hOnhD39Klnrf1fSlGlKNzSQVM9RT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONTCpVZyfrmMMmjrKNdnUbZy1I1s8YUkc6LbN1oS2hzGqhNu0+OKZBRfSxOSDv/Ccfz2s1ShSlFLLU7JiyHBEMWmyRr2uyo0vxaCr7Pjc2FQIKoTJvTNvUgHgu8gCYajI3+CbHpN7oGM0v48R89DmxKbJuqHiFEE3IlyCPuEafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=th1DddLb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so5044a12.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 23:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714026144; x=1714630944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqlfKxyILHk+W3hOnhD39Klnrf1fSlGlKNzSQVM9RT4=;
        b=th1DddLb/9LX51ekBPa7HpC10ImjaxCo+FNBn1oxJuCIF85jHAr6sGN0j34ck9QeTk
         WdiC6Z0t25aTD0I/bbF/WxAse3O979dnZC51cRvek9jwjn7G8/hiiK8sORiDckaXZYz3
         1cQywtXS6wylSuKpaI3y666AoOeOmT7iRFM7RO9TNkNypW1IK5J+Mrt3dTz/2rUSwz3Q
         +ZZUioSwcL6svsE5540y6opNaoXCehX/MqXjUaWkEvi1smH0JWzFS+9Z2rih5/RpI0lb
         iF0X64yr5H9MWbjTiVP2SnAZIQKd2fy1vF5lmuJi6qxJ7xhz7h+KqrpeP7uuaBZ/FH7k
         WBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714026144; x=1714630944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqlfKxyILHk+W3hOnhD39Klnrf1fSlGlKNzSQVM9RT4=;
        b=SGraXGRf/EoM4sXChHOst/7Me37UJ5MNLwK1QX7hGO8KhM+OReHWFU9EHeXoO8UNAQ
         2HTJL3CNLXQKcohqGZRKSdBI3icnWlSb15e7AafIA4izIO4jnPkahqkdOwVk9Cs2niYa
         IQ1LjCiq7PULHy+KY+YvPOY51vbayASMQ04ZV2A82yDhchj/d7pQbeBxuRz+NwYbfDhN
         wbahob/UgmdwHzRYb0KNaLlZikX75Bdspuqc8HqguWTTzLlhER2rgKoi/BJhfHedLSqP
         AZighauif14aYofnuncxhi9MP+2fa4zIWmKNgGh9Vip/6NS1d4sNQ/MUWBhBRx9tQYO1
         VPRA==
X-Forwarded-Encrypted: i=1; AJvYcCX0901CBxC1f5xiWGcGBuxYZ1UF2w8JQwwkYXNPv1JDEZ+1wX7JAzX/AowYisFMEwqM2bFDRGrfeh/NYEn5+qxI6iOu
X-Gm-Message-State: AOJu0YyKxo1ND3J4GlsB4D4S2AkUZKHrPUxWECn6r/ur6HjWcKbOSKth
	bpxhK3H9zTz82PODecDic0mn2VBVN65BUJV4dlEMMGzUFAEtluB0zV+jrCGnO8a+VY2Vf0pEuJX
	Gj2jZLY9LQAjTAiJte9V4oUErWXh3avIHo/QP
X-Google-Smtp-Source: AGHT+IGJ4lWF6WXifymD7css8+iEWuOcEB+1CpQx2DAS8NJgjd1LPfRHFY/bJBldQPQyT0V+0adV8V80J6QcnIObYyQ=
X-Received: by 2002:a50:c908:0:b0:572:ca7:989d with SMTP id
 o8-20020a50c908000000b005720ca7989dmr62554edh.3.1714026143778; Wed, 24 Apr
 2024 23:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421042009.28046-1-lulie@linux.alibaba.com> <20240421042009.28046-2-lulie@linux.alibaba.com>
In-Reply-To: <20240421042009.28046-2-lulie@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 08:22:10 +0200
Message-ID: <CANn89i+DHZGG9p4iCqcQExTd6u_6pKe+_OogPxjfEc2rPHyYFA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: move tcp_skb_cb->sacked flags to enum
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 6:20=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Move the flag definitions for tcp_skb_cb->sacked into a new enum named
> tcp_skb_cb_sacked_flags, then we can get access to them in bpf via
> vmlinux.h, e.g., in tracepoints.
>
> This patch does not change any existing functionality.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

