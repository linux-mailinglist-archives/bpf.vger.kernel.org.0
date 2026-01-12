Return-Path: <bpf+bounces-78524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6464AD10C2C
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 533FD301581E
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D031A55A;
	Mon, 12 Jan 2026 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m67jyqlm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB19314B7C
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200748; cv=none; b=Jt5oIeMTYJEJvBstvW58FJVDKGmbVSaIEH04m5xzy7v+BDRTJKhzClxaMJhacpVeBb4CK9n3QSV85UCDN2eHIKRDSG+QOad/pmWxEO9ERkOnjiakF1QRoNpvFljIe36l3EpMVNpaKQvraZ7PwLmJI7H540C46raWRCrv3nTCXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200748; c=relaxed/simple;
	bh=6Vs9eutlyUalFlEp8jpnBCMGyuuyKr0XHqhsSUUI9D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph7s0SgVaQBSpX+FPcQQJBPRwrwpECr1RpgMQJBwyzrgzKjf6C6xUeJqjI0MzqUgFUl8ITWx2Ov8Vlbe+dGY86JCqOU4hZEf0buPk4vSWgDgsyBvWUfZbpu0mt4LtInMzlNcpQjucr9aUFvHxHjbuYSMz38CnTd1nMKBh3BYr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m67jyqlm; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4327778df7fso3724098f8f.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768200745; x=1768805545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vs9eutlyUalFlEp8jpnBCMGyuuyKr0XHqhsSUUI9D0=;
        b=m67jyqlmnQxlm4W8gHv6YhaehafVOhLL+/o+jkfwwZRLsYjlrmE40MoHhn/saAD7TW
         diplWx9+c3POGXKrFRb10Zz6fIpFFX0TClOV0Iamj0F5KdIBXoznL3Fwg7m0s9lurKrL
         4Qa6VP6cMBFUGLQqmHjn4vCeD7tdR5F+0v29Fwp0VPhRDByMe490sM78NGLLzW1sqLQJ
         s0+GhzneFZ08YiRr8OCb0AeLiZYdusnp/YVkMvFhh609jgv7kqF1Y7RjrNhhDBlRuhDv
         VxTcmGoaNwkLGcHK3IFx+3XyyuboJbUwU35G96tByRlL/hhKgXL46GtJ/jNnlYZEZUC7
         ZaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200745; x=1768805545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vs9eutlyUalFlEp8jpnBCMGyuuyKr0XHqhsSUUI9D0=;
        b=tfS99YCg0T3T5Zli2TPqG+ntxJwm6r331CQWYgdW9xG4A4pC0kn1ActT1paImBv7DC
         C+lFHOt1YSjmdxYUvkRiU0aR2sXbRrf3pi4JP5S62huLxDc3D1TEI0AiehIk0wpFzHvJ
         XxrFsKNZeoJlQevgPbYHLGeyygPvqkDVS4wLS7Awf6L4robjUv0Pwl0E+98tJkp/v/NQ
         PJ9wI9DnNe4Y3x+i2cQiXjmpqJGfyjK3ESnBMdEYdF3dL8L6Z5JyvRpzCRvGV0qfKr1a
         0wEuOeDx77OedzkyMwQOjoAJVdExrG7pUPffILKVd86GV9XfmtUsL48+YnXUuSq2bXvv
         2+Ww==
X-Gm-Message-State: AOJu0YxGuBphQNaNLrBCqmPlNFbcEUfyBg8/LbdTVo7ibRkAhmrAqreI
	gfFtb45VK4I3RJAiKI5RxZmEuPLkxjE4GDhEq70cshfLuuH7iIukekS49jTr0jScnyXMXh8gtqQ
	lxV1MWDR8Jmr/xygrmh7daFakOM6IDlI=
X-Gm-Gg: AY/fxX62iE0IN6XSjlTuNIRRdJmTPfaa9cYuDi3BwBAgpGi5Jq7yFD2Ihw14POEnSfm
	8HZZ+7fT4lN071wId5g4F/YP87WvhBqy1VGRmh/K80f5wA3qovgfZZUdcR8o16kCS34o5UFYyqK
	0jCppQw//0u61pnEcGBsYBB2hZJQ2kFqofN0gQb2WsygZ8wU+w5xWmQi257lqxb2xCjUQmhK2pm
	aCVpvBxdFkgiZh6XVxjhnzbrb/IrY1Pbs0LQttPijf5tHpRG6E7FlLeSPgWOhRAXKXOe3ppkYJZ
	zbuLx5yWznOTQrIf+V4Q8h/R60h8ww==
X-Google-Smtp-Source: AGHT+IEWWCROZ9W2XvupSh0FHs9eo+ngEG6sTxMlknORvN+lv005fT9kAg9rRfr7QkToLile3In7OBAFa3CiWT/gw/w=
X-Received: by 2002:a05:6000:4301:b0:42b:5592:ebe6 with SMTP id
 ffacd0b85a97d-432c32f701cmr16434006f8f.0.1768200745476; Sun, 11 Jan 2026
 22:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-2-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-2-740d3ec3e5f9@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Jan 2026 07:51:48 +0100
X-Gm-Features: AZwV_QhmNxcDfnsblipm-NVjvzOd1RAtFRKLjVZgen2v5s2lxT0Mq6yRr0zRzC4
Message-ID: <CAP01T76ccrFiQ3a8XEw_ZMVpupk+is-3V-se+vVCcsdyx1MVbA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 02/10] bpf: Factor out timer deletion helper
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move the timer deletion logic into a dedicated bpf_timer_delete()
> helper so it can be reused by later patches.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

