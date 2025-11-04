Return-Path: <bpf+bounces-73413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABFC2EE6A
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 02:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AC044E1621
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02E23770A;
	Tue,  4 Nov 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUyy6Ibw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE2237180
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221486; cv=none; b=U5URs6sPP2qH5Zwk52bnenyluBlIcEWKHmnisJDt2bOQoY61XQhUgN9CR0ySse11rHMh6lgaRtlzvSf/tNGA4JaxxspKj8VTdCIX9lgQ3Np1Muy8MxsRrp0pDuqVXQ/QOdd9m+dtUKCQMy05KpVGsPDb8dYrqoX7uMlIbAHnWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221486; c=relaxed/simple;
	bh=33ZZAgdRdC/GzUfOp6zvc6iwDcl7BW78h5UaRfG0phs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8fuQeeG3JS5CUdjj4RYo7m77j8ZxdURrfP9TXTq/LqB7igUP3R3KdTrcGr+kKPfFYUKgnw/aiCXqXnprUg5agFeAl1s+MHCFeNk6SWGUDgWkMohTVulZF5gGgwVl+xNZh24fS/4/ogGrsujtYyaQZweNduz/w2L6SxYvSyEq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUyy6Ibw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4448113a12.3
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 17:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762221483; x=1762826283; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33ZZAgdRdC/GzUfOp6zvc6iwDcl7BW78h5UaRfG0phs=;
        b=bUyy6IbwhFiWXqaYOOX8TiUF7yy4c7Dmqpxr494006ZpOwkIAsduqbmEawjVlAxTAh
         ERjTjFM9DweAKVFHbe8j0Nc+pPAOPHlA9YnznQMmC5Y6rERu8ihj/P9ZKNQexobl0rGU
         /yCpO/M8esDNNSFDnjeTls1Z7UafkfGluM51OGHKN9dHzhC9D8LoPlnn/XS1/QwxSQz5
         VxHkwKzQTh8G3FSk6CeT45buGUNLReFaGkPpg5pctqQ/LP8b4iye6C5wbVaRgCTYhAXr
         R6bJ/kU1T+10uk5B83am6q//9DexrRiJ0rGC1VAAmAG7jv1HoGpFhM5BBB47MHTb/e2M
         h7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762221483; x=1762826283;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33ZZAgdRdC/GzUfOp6zvc6iwDcl7BW78h5UaRfG0phs=;
        b=a+HSACwSAlwAMWAgNiJMlJ3zeZiKTj6ADscpvFrchTGCHAXo70QYXohHCquZy8e2jL
         n6cv2VO23ZJDHtOR0OOG9T0mmphylk0+Hh2rsEimyfUuCqgBot6pUgRUFVHEkGftEU4p
         /1GrObctFfA0wWrEPUTjVTpQ04NLupxgy9EAF0Tyizl4lQZxeHw+GhK3kdfXcSRLKjtq
         W5LVGxMHyDFxOUsghVvm3ta28FSJLrM7hfyKOZYjJ7stASDFYcLSpj5+hGyoAu0Bb3ub
         2tMGl3JLpmvnx7JNXiqB+U9cFQUQAFp8iWZAKYIq1j0HrLlEVGT55okWBT8l1R9EV6cB
         /3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZzkKxvetjSxGiKJjiFadhKY86WvQwZKdHnEbpTS1EddgVP9ubPp5Y0ZGp917+gSr81g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/chsW7Xp2rnAYSdRJ1iYLLS6sfFc7FVTdCIaHfOhLqrwm86q2
	eR07VWnQ38FKreGY7Pvo545CR/ojbFqyyQg1oYDJottHkIIV/rDmWW+w
X-Gm-Gg: ASbGnctjq6z/ITt/AA5SW7eIMbIe+hfMMhnTvMKiUmJUPUxwdQqVrVhqTFVL0cYyk+s
	DV61XpDx0shYelgNl123MJOFN9Nkq9gn20Oze0ukSqBaPSuW85kdabYrrhyWWAhMPUnWlQwGVjR
	S5YQwko2YStU0VoWth+i0UMoU4r82pgA5qk9jyIXD+Z72Q73Mph0GOpynzPBXMJHchOWBdGJriN
	x0av+7h3Fx/heWd2P7b0TylGUoehOTo3JdRngi733DJxkF42Apzlpco0WeUTgjmE/zQ8wlZF3Ah
	7Y7QPm+HI1F2LkyRuBBvVn7Ly22AvOrJjDC+juISDy4b6zcB7fpJxvuGomHOp96t+bDYBiLBOF+
	kMUFfToFge+fd3p98GfP6ryN0xTnA3AxVEAxakm12ylPwH3cHwKBwpEStNBMz64V4ixeG1kyJR4
	exc16hGfRv6OxxdLxtoMz3cp+p9hP2SqE3wawourmRrUUOp+g=
X-Google-Smtp-Source: AGHT+IEmiNkcAIMKrjrz9a0PPI2RTtH1qj4XQ8Hec8gYWUh7IWDjEVejI8TYdnpWrKCiEAEWQVlx0w==
X-Received: by 2002:a17:902:d488:b0:295:9db1:ff3b with SMTP id d9443c01a7336-2959db20847mr77918805ad.6.1762221482794;
        Mon, 03 Nov 2025 17:58:02 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d174sm5874615ad.77.2025.11.03.17.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 17:58:02 -0800 (PST)
Message-ID: <b737e19872345d7a52b58ca3ab01f78aba7e3be5.camel@gmail.com>
Subject: Re: [PATCH RFC v1 1/5] bpf: refactor bpf_async_cb callback update
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 03 Nov 2025 17:58:00 -0800
In-Reply-To: <20251031-timer_nolock-v1-1-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
	 <20251031-timer_nolock-v1-1-bf8266d2fb20@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 21:58 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Move logic for updating callback and prog owning it into a separate
> function: bpf_async_update_callback(). This helps to localize data race
> and will be reused in the next patches.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

