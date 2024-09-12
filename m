Return-Path: <bpf+bounces-39754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA2976FA7
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EBFB23F04
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7191B9850;
	Thu, 12 Sep 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxzRbW16"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED331B1402
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162712; cv=none; b=kdMz1AQNkfxx0tJ2KA35JLCBMrP/5KuuIu5EoXslG+/JRJ/HBd2FvSEcAf0Ft/7whmsznk9quTN/a1IV9t9MwqCfBClhE/6xYAXnY+rQyB9DyYgG/HJQJWt0vvQ7TfxHBHuvTrSut2G2QwGlkGjXA5wBe5RgdUu3DvTFTTpyskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162712; c=relaxed/simple;
	bh=MOyUa1k1u1CWnozqPfppk2/0afQ3LCgD6ew53gDJ0lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VY8BbVdGVaacbJmUMd2hx0pToasbQ/0v8iD6hOv4vLLtodBPn7kfqixRv6PRNfXf9NcGohDN5AB0pfEkjyVLuRIRv3/OpZQNeu0V0xfRjWbyVsTJHvP1FwgPF64CkeaY3JHemRQsWz54zC4xt70+Fshgj0qUaxMOlyuhzPaXNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxzRbW16; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1707685a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726162710; x=1726767510; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MOyUa1k1u1CWnozqPfppk2/0afQ3LCgD6ew53gDJ0lo=;
        b=kxzRbW16whFB5+J2sh2Lpu0b7qrHBfYFx0TF/njtzHwPlWEh7L/DLkjzQRxDku1Gtk
         ABBmXa59+Di/1ia8jPU5nkPRx7NklZ1O5hXO/Lo6RC92CX6Bmfo9YU/V31urfZSqIpsk
         1JaTUGJmQGiHdIco6hnVc6bkS6jcdBkFKmGDJDUoBIOe8OW1lhB1n6EphZUojbcZNtA+
         Qga2TaPLUUTRli1VypyJo0XMQxxbQBbtoxmGjG3ZxypjVyFbZYKR+HXo2HJVYPcbkygA
         ibVkc+BGc/pdQVCyaCZVQZspehAO2v6/kUCPYoht9nDWk1sT33jnPjDsOOcz1v2TWhj2
         TjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162710; x=1726767510;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOyUa1k1u1CWnozqPfppk2/0afQ3LCgD6ew53gDJ0lo=;
        b=Gsz9dMUK7vHWVkUzMtjcYWdBB7PAUjqFiQNd0AAs1mdqjO/KpGSQjPXjFrcoqRSDbq
         kcAVizhxylDO6ALmKu1U41WjfE52xB8mAo3g5z3sIy2BUudJ0jW0eQkKbDtrbx/apUfE
         vEOsYCLmlB1U/za4jIPceyy2gkZq0bSti7iax6xU6SMU7QhAXow0eBA9g7EFaZoH4MpN
         AHjPiAgst1uI/Uahr1dssBt7D/qYdmcdzCaQQpX1R15ic08aVdHX+FRfOG8cx72cm/Zr
         zQHyzGPe3t5iFm4CcrDQZ+fmhrsSzr9ENq3XBTjeafIrQm9Cpn9e8PQTgPLxD8nuye+c
         Cf7w==
X-Gm-Message-State: AOJu0Yz6rzJFw2lNfrOKZFO1r2+gYfjFe9c3jmfpIvSEJPq/qforOZ+i
	89po2dMnYkgrRZxTUhH7v/4NFls7pSJNN/u/EY9ybc3rxRqnQGYE
X-Google-Smtp-Source: AGHT+IHDYCvaLpeAbggNjuZkL2ayOttEnDud7XDg1orpJnkRAzZvBpmdX2m3FIcvddfcKXjiX435cg==
X-Received: by 2002:a17:90b:88f:b0:2d8:73ba:9444 with SMTP id 98e67ed59e1d1-2db9fc54271mr6172459a91.5.1726162709920;
        Thu, 12 Sep 2024 10:38:29 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04966bc0sm10723806a91.45.2024.09.12.10.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:38:29 -0700 (PDT)
Message-ID: <0c614e854d9cb3f6abaeb40016cabec01a4126f7.camel@gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: lonial con <kongln9170@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 12 Sep 2024 10:38:23 -0700
In-Reply-To: <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
	 <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
	 <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
	 <62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com>
	 <CAH6SPwjoACNcNBWCjYauSMYCFOUAys10uH-xM6mF8_Q79D0Yow@mail.gmail.com>
	 <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 22:40 +0800, lonial con wrote:
> Hi,
>=20
> I tried to build this environment, but it seems that it needs kvm
> support. For me, it is very troublesome to prepare a kvm environment.
> So could you please write this selftest?

Ok, no problem.

>=20
> Thanks,
> Lonial Con

[...]


