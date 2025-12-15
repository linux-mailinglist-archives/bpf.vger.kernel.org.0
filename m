Return-Path: <bpf+bounces-76618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0BECBEE67
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B79303B2D6
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4D30FF03;
	Mon, 15 Dec 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klIRRszk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B152F3618
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815817; cv=none; b=dwcbJjDLwO9+NmvAMQ3epIXNQszxWfIWCSn//9LEPs9mIMdAI8ms0CUX1GyAvcIsQYtO7/li1lXh0lPpAnq55PSg5KNJB0MBmlkoWgJSSdur56+5br2ELKjJlfezvxuYjdPi9Uf2ZkTn8pcSaSS8Q0zA0u14/okYoyCmFKg57pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815817; c=relaxed/simple;
	bh=a8B9aer+kv02NZVC98vWpwCJNj3SUFIOu1QAAzLmuxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSSzvn+6v1/3yyDqGb+ZsmXzya4JKHJlbHb6a2J0QjF93NS74cnnSyQrCmRwLlvKEp9c6jccdzoTklLUP4T3ra2/fkagoMkbwp3fkcNFwWeSqhdKvhMZ4QOv7Fh2zZjlA5m172Qgx4fefJJ/bCwZP/MsOUD6OXEzBOfMfzTW9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klIRRszk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso1893487f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765815814; x=1766420614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVBJ/1LQoFSM7O2X0/dThD2AzUKt5AjWR4m0Qd30gfk=;
        b=klIRRszkfiugEyPACy44Ch/ZGnk53MsmbK0jlkmFC+l5R0FCe2jr5Y1dmsxuoiwetz
         5CcIXFjpfQTZBaE66Jflsl1R0zhksdCOzS4YnW/vCHwFMihDK9kb0I8Ns7j6OkGC67Zg
         hYC9gU0mU8WdZCDvHMZysU8rk5P21YTxqY1U4zIo5EqT36sMYcOSdQupAkei+4iMPgdv
         EZTqIWi2nhpFhYgR8LMG/zWXPxB54LiH0JYPyiAVPOGn72gd4BG+XpBK6e+zI1cBywkz
         p6i4mdjRniMpaSOFJVnpI2df33oPS+EGg6Yvl124b5fVH7iubxMEWwK5CL2SWsn/iHIQ
         hwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815814; x=1766420614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVBJ/1LQoFSM7O2X0/dThD2AzUKt5AjWR4m0Qd30gfk=;
        b=UtKSaWkKeCtyAKsa+t2716a6oNrHGgMaHSJ/tyfXiTUQ0fyvgTeJ4ZexUh7zS9Oa41
         mlQbco6I/P/pfsY26SpxbTdm6vWjKObnvGDChWSSKG2nhdwyyMmUTLVem2pzgAKqf7n5
         UqRD3h+6SETGuITL8xX9xxGudYSM3VzKngN7N543SnHgaBL85znzVJjUnCjsD72C8+QT
         /tXGEP7vHaNWrb9hYOIMMaaPaXSpl+q41NIHD1Yhsuecez3cbFP108cj/3HKPKvDel+f
         +l6RBaFegAsaIwCimxtgAZrMxsOFNVJJnrXsk2dAGVPXzW1anubGy9I2QlBw7wxEpqYG
         wRrg==
X-Forwarded-Encrypted: i=1; AJvYcCXNKpYuHPeYypc80yjVdyJzptpAg9ktT44bANvXHVa1xw6OwsPsmUurzVvbGerHxTvCe5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6isDhwF4+w3XlVjlOe9ALOUg6GEdnWFfOckp+JbI9EgXPSGQ
	efjfdYrzWjmVvm+h85lXxAEcwjPmjnezs+BIUGe5PqpJs2qF0SIXvgodXiEkCdi4AwXwiRQZ9xE
	Xh+WBKbHlaJNCB0JIbOFS4T8zCDXV0Dotdg==
X-Gm-Gg: AY/fxX5MpIPgyFyJJKGb7pvyKlmA3C507UCzf0NqjdFqw6vCZuUrj3bVy8VIxJhfypZ
	nePcy+i9j724a6EBcJ51RtGucntuRUD2agoEo59oMQE9ziakoV/HTlOmDubVS2vjb1aHfFtpkdD
	jfRIjCwOW0d1wNkpiuubyXxGLRCT7XtstIyLdmldfsCJ7iXSHn2DEgTntuzbvgFqnzcyu9re32Z
	rfsio2s48bY9xBV2eeAEPrO2R0+T1hIkbiMGWrgl4Iz79YArU+ZPL18tYewSko/hfgiuTdGWz9T
	rdaYzXEqb+Sbm7gTXcvHawzjkxQI5pjcP+wlLIo=
X-Google-Smtp-Source: AGHT+IE4WChQMyJLp2DGI3sN9Cp3FI77PgdjKmiQCx7Uyj2AzOfHAshsVyj2uPioU1YQo4cBCNZo5mxUPXuBL9fdFWM=
X-Received: by 2002:a05:6000:310f:b0:430:f7dc:7e8e with SMTP id
 ffacd0b85a97d-430f7dc809cmr5205551f8f.34.1765815813971; Mon, 15 Dec 2025
 08:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgizos80st3bL3EoEoh0+07u9zRjsw45M+RS-js-bcwag@mail.gmail.com>
 <516deeb7-102d-42ae-b925-64bba6281f14@roeck-us.net>
In-Reply-To: <516deeb7-102d-42ae-b925-64bba6281f14@roeck-us.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 08:23:22 -0800
X-Gm-Features: AQt7F2p6ujoVSFbnGcIqoAIqTT4IIMtyxG4M3UDcBoxMAX0aew5qqxzming_CdM
Message-ID: <CAADnVQKAF8_6zowiC8GpZX2qrRZ==ESL9VyoGsxh0xHBxsE45w@mail.gmail.com>
Subject: Re: Linux 6.19-rc1
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	bpf <bpf@vger.kernel.org>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 6:56=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Error log:
> In file included from include/linux/bpf_verifier.h:7,
>                  from net/smc/smc_hs_bpf.c:13:
> net/smc/smc_hs_bpf.c: In function 'bpf_smc_hs_ctrl_init':
> include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=3Du=
nused-value]
>  2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops)=
; 0; })
>       |                                                  ^~~~~~~~~~~~~~~~
> net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro 'register_bpf_st=
ruct_ops'
>   139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_=
hs_ctrl);
>
> Introduced by commit 15f295f55656 ("net/smc: bpf: Introduce generic hook =
for
> handshake flow").

fyi the fix for this one is already in the bpf tree.

