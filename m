Return-Path: <bpf+bounces-31752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEC902AEB
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A6FB21985
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228B823A3;
	Mon, 10 Jun 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZDHQQcN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CEA1879
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056326; cv=none; b=JrDshV/Pangt04J9tMy4pXZu0LM6BNzuKaJt2E0TEPPsc3tkPcAHrjUF09CnncVW3dA1oJ0xxMY/Soj14AAkuHw7YsaH3aZJqu6OdokA1A8VLoWgQGJjVbFfTfEkacnxL0qPC8fnBYMtz4v83GqwSkb7JXUbnwRdJBs9NULsGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056326; c=relaxed/simple;
	bh=gNd0PvFBGnjiNlK3rFqt5Dyv6DQaEpymSyC4+Rwo4vQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHIo+XKkFY0C+2wIiBzpvht/LCZJUaxDDX3nZNNUfluqc2BWMrzB5KmxltiEDtVIWPdPLPKXKH4bP6n1/O/TzW19jMeLEZ7DQ23Tt8p6he7GDYxMh9JjDjR205LJgSzAUNK3so0KmVHe9NYf/SCBKNe37SMVB45UqGWlAGJMHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZDHQQcN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so1589283b3a.0
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718056325; x=1718661125; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNd0PvFBGnjiNlK3rFqt5Dyv6DQaEpymSyC4+Rwo4vQ=;
        b=OZDHQQcNh+6uDsMJMjSj3p2LDDYHjvxGsRwf4Z9MTuDTQsMaVEaEgGv9kURHJOmYFy
         LFn5bw2/O93kTte+RqQOTai2/PUHijFgWYkEff8+s8+TMMtKOk0CwOJu2V6VkrRdlE0C
         nPuiWRER1QkT68oZzlZ026EyxghsQ+5dCyDGgzBYnatxALpxatgkZA8WExC7dI2d8qqT
         +ZeL6lzgqvGofq9xFmq1GIUnLiFQGLveiTbLoyrBVF/CA8pmKoxwazRWPoNs7xnpA3Qy
         U/8B5zwCdrW6sk1r9d2hT3RdN9Q0bk6V/LCmuWf0lXBWlvBC9pg2uraYS9EzuV05fjzC
         Ug/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718056325; x=1718661125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNd0PvFBGnjiNlK3rFqt5Dyv6DQaEpymSyC4+Rwo4vQ=;
        b=mAtTQDXOMGpBO+CrlJd9ZEaBt+2PLYO4s9G+AWtg8aop6uDtlExOx6esoH7CxIwrjO
         pSTRMlBLiem7ztrqZ5Y3Mbvdh/QifHcGyVs+35xOZyYof5K92ypYaxdHEs8veExpCE+w
         Xlc0KhUyW70VrC6oU3NJIOgDqigPO/CqbdIUol/wlAaMYrtvw4oxDCF+DN5zctiHjMNn
         VrjvrH0Co7xW8jnqKeYHnv4cLwivmYtvCuM/ZCPoPOZuFb3K+uPgz/2Rzg9oWfLhiE8H
         GNU3WLCHI5zCWcHfDjEkJ4x7ptQbeQkNQl2zRmuHHIOl4vxol2X0W3UWKnnt/vUjde4A
         I3mA==
X-Gm-Message-State: AOJu0YxQgcoXy2i1u76JZ1kgd7e8YzsXVOodrBsMqnIbkyTonEmkNf9H
	CaZDwJi51ZW/XlO2IfbR6wJ40rxPAtaJterhCLu0dl/+N2xA1PBz
X-Google-Smtp-Source: AGHT+IHxvTMZ+XzMCKTk9f7afAgvze9HOdH8EEkSYHT7rBxnm1//+6C2I7rXpU1AIk6fVOmsa9c/dQ==
X-Received: by 2002:a05:6a20:7350:b0:1a7:aecd:9785 with SMTP id adf61e73a8af0-1b2f9a60732mr11614855637.25.1718056324534;
        Mon, 10 Jun 2024 14:52:04 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7045993dc73sm2718326b3a.7.2024.06.10.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 14:52:04 -0700 (PDT)
Message-ID: <1afca090c23866f25a5b17ebb2df25171ea9c292.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Track delta between "linked"
 registers.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Mon, 10 Jun 2024 14:51:59 -0700
In-Reply-To: <CAADnVQLEGMvA_hNDZ4F-_ZBdbBR=ZYKmQ7cNayLOrYg2GSRJxw@mail.gmail.com>
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
	 <20240608004446.54199-3-alexei.starovoitov@gmail.com>
	 <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
	 <53a25fb040cdda5b794a5f1f5f6ddb73571df837.camel@gmail.com>
	 <CAADnVQLEGMvA_hNDZ4F-_ZBdbBR=ZYKmQ7cNayLOrYg2GSRJxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 13:31 -0700, Alexei Starovoitov wrote:

[...]

> I missed mark_precise_scalar_ids() that needs to match
> what find_equal_scalars() is doing.
>=20
> What's broken in there?

Sorry, missed this question, here is the link:
https://lore.kernel.org/bpf/20240222005005.31784-3-eddyz87@gmail.com/
TLDR: whole function is wrong (only handles a subset of possible situations=
).

