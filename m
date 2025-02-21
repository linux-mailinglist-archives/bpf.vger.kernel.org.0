Return-Path: <bpf+bounces-52124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD2A3E95F
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DA019C253A
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FC17BD3;
	Fri, 21 Feb 2025 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBgnPD75"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926E1BDC3
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099063; cv=none; b=PqY9DqeRhdab7x3ksm7pCMXdBQML23jIEy3y3WMV8HIudFF7OA4uTxZVswBEAVt90vM2Jbws4qYmi/eiaAhZeu1XHIlht2Dde083T2goOmv2bRwNhGWQd3Afn5vEgIcQKfW/GYmQXCfTdpxeYN4SBPYrZLvIIMy5alWyLxU0Kkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099063; c=relaxed/simple;
	bh=gNBOglzeuIvhBd3Fp1v34Imf13cOZgCMYohq2JyhRDk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwqOzklG9dV3uwqBlcqie7Kanfnzs3fiJ9bOHai+8RsknNqi7xUsLHt1JMFge/fZnRwXcBU8FjstQKNwQE02F4tMIp8W9lgl9zW2LXt5FfLVcDi477LHXKgOkVVA85P77Nk1K77rEvw38TcuZ/S48YAdCk5nbbHeYIVlySxTCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBgnPD75; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220bfdfb3f4so34118195ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740099061; x=1740703861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNBOglzeuIvhBd3Fp1v34Imf13cOZgCMYohq2JyhRDk=;
        b=OBgnPD75frZOMbjL8J3cBDvv5Re2cNKxHHmgbCGO/p9CE9swiU9L2vpFO/hX1JeKq2
         BcJqisizKymyIQ6V94DYvQBNFBqgf5BRwL7ad6RjJqgnR9JXEhvqbHmP6mH/Ufjs5P6p
         b3OgAlOoRqUFd1mqMp63cURf+Kbl8FD4eO4q7+n2B/xP7Q19gffBT87KqgwlQ5ovcOrl
         dBZowt3Txh+xYDFxuFmq99D9fi/BGqVoFhPC56QqXnUbANeBzMr0qRhiH89zljwdpj3S
         2/4Rx+A/IHotbEltrw0Ary7hoKq/I9plIi1inoNBgaFeKAvmw1DYPQSgGRtAQGU1LPMh
         N9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099061; x=1740703861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNBOglzeuIvhBd3Fp1v34Imf13cOZgCMYohq2JyhRDk=;
        b=tb7ziSvqARlE8llnO8yiATD6CzxCft7Bf/T/PNXXEC4CdPUWea1a9FN43r3js1ibc+
         E2XJmrgZROeSUkDr/gw5h6kZj5/SeGQADjUuIyRopk0D1zxNblX9htsb9H2P+a2uYI3P
         q/EYPP8tnT3RbbIV1Q12crtv6Jenlo5z9phEeUuaulNZhHTUn+GPyrHTl35gFsD/t82Q
         l2udDRMzNWczp+aw0vfyBFg56YhoVKZ5fqCbmOBve7d2h5xRihuJV3Rsjq/SJevcAPHn
         bEiCeushVTQjjmxA/KDEA9+D6gw1G89+2DYtEtFM6Qqhbs9ZRmQ07mZN1AMssZ00xCs3
         yD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnSSSGQMtbVrOemKpTlUC73m+IrzFsHhyKLxRV3RzjMsTHp2yWP0LfoV4ZRe8DDJQRmqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5U3YenWechDz/YOYAi/5/nkq6qxuKt3ouWiNC7ZGewHTxyjm7
	UCSgy+l0RHdJMrvVXBr+76vn3/Rba5vYSg4aC049cmSgi22dHzx/X0FYHuLT
X-Gm-Gg: ASbGnctu4RhDWqOMRzqKA9Hh6QVgAs99A3C2lxUPKLt7uv0c6UjHqH/+sJNCcQh6sB/
	DrfV9FDFVkvdBRJBZa+N7dYD4cm5sIs+l8Pj0ziXPDw21DTzKSLENnCqueOzELbljkUvkZOPTrR
	+kMD0VLvWsJx+fs9CTbrEIo803v1+G9v1yIN1S9MnZKAA0hyYZ+64WyXamBiIPsZ5IY7ZbPOG+x
	3CJjr1oXxIHcPom8myYEkILULLV22/bgTh6nEajfwWtJ00/OC9L9hFy0A5crq1yKIpPwhHP8syQ
	HaPpz4TgTD8r
X-Google-Smtp-Source: AGHT+IFhdSwSeGPz3XV7UIlKi5X9qr3+d82xT6OZuPlENDj9bB0eYo/UgIEynqAJPdd/x2ftOrJ7Mg==
X-Received: by 2002:a05:6a21:3285:b0:1ee:68e3:ff45 with SMTP id adf61e73a8af0-1eef3dccaa8mr2307996637.35.1740099061061;
        Thu, 20 Feb 2025 16:51:01 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e324sm14492549b3a.88.2025.02.20.16.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:51:00 -0800 (PST)
Message-ID: <3022a910ccf6dc0056d36014dd2790e3be58a31b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test struct_ops program
 with __ref arg calling bpf_tail_call
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Date: Thu, 20 Feb 2025 16:50:55 -0800
In-Reply-To: <20250220221532.1079331-2-ameryhung@gmail.com>
References: <20250220221532.1079331-1-ameryhung@gmail.com>
	 <20250220221532.1079331-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 14:15 -0800, Amery Hung wrote:
> Test if the verifier rejects struct_ops program with __ref argument
> calling bpf_tail_call().
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


