Return-Path: <bpf+bounces-27941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722938B3CB0
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40011C21ECC
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11C15623B;
	Fri, 26 Apr 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzNjVCM6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A21DFED
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148505; cv=none; b=QQDzerVBEp2sA18p7+0mav8JLH2trHKkcKH2z8C2TYNNpB89xWVwL2rf6MMQ+fJbfVkScpoxtWL6TcQlNJz8F5r/hcW9C1u28vZ1/9Vu8KVNIB5jAGjEbOO01uTf8J8n49icagZYOzsyG85+Cr6YhxcobFtAV3RT4eshpSd7iBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148505; c=relaxed/simple;
	bh=HZmfZon3eAJB1tEiw4wnyjfBJPBbqMHM1GFjE34NREs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OikoKn32GDZxOrSTqo4ZEVvjEMWfPwiJeAHCtmlkUVBTu13OKImePhJsno40DvE3Nk6bolarmDZFwr9iLQb9N+cQHNbCUoKylMKfYv1YGT1fYy6sVVhrs0Tsp8Q7ldovankvOnQKJeCtPKRZL12sDexXq+PswThK2UaGFK1AgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzNjVCM6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34a32ba1962so1886046f8f.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714148502; x=1714753302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZmfZon3eAJB1tEiw4wnyjfBJPBbqMHM1GFjE34NREs=;
        b=ZzNjVCM6hYl5eRjvnZHjLo4pvvZC7W6/Vf0CwYVOHG2sz8TzJ9LgUr4BqQdrdIQEut
         y2KPO4T7llqCJhOwT7ms2PVShtPj1OwF/NZlUpOS5iryK1kSYMnmqZWBbaVne5/7z2tm
         mcTVV2DKt5RPXx3geO8rBME6DpWU81DUQMMMt4VlAE0R0RvHmw1CuA9bNGI/mF1VwfU+
         myI3PbsnSBfbdkhRPuOQmuharvhx7uhqokDKWUm2VkCdcd7TQFLBmn1nld82S7wVwDVe
         nttoBniktAQ6uV4b6MnZgNvnnIprVOuKnX5C8bhoM0GxggRT1B0hCzNL0Bfd0d50VdaH
         HF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148502; x=1714753302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZmfZon3eAJB1tEiw4wnyjfBJPBbqMHM1GFjE34NREs=;
        b=IJppDkSsv2AqVPWyMoy/mTYBGPCORmlebJ8iI99wastxo7k1Eo3qwPB5vfJum3xzZ5
         Gib8m9TOyV+o1oTqtx+J/04d/Oe7XRa2eCTG40gStG3aCAbBYCMCa3wIBxMqXVixJdFR
         8rNulKi81DYH90DVx5SPOqWZTuhsq437/kMEXT3KG93xdnveKKrSwmU/9FJ6hd/MgrAu
         /rQ37XxL20qKDMi/I/b+iNpE9xz72F/WN7u0zQCBrYcU4Pcb0RY6qYsHnAChjuhrHPXi
         jAF6V5LKpr0n6nIIcWSUMkOmdDYv28L4ekqOTWzqq+E/4mqiyx9JQu0iZyXHpFGNw+T9
         yzEA==
X-Gm-Message-State: AOJu0YwoNnIVPskC6P9/ZX69pJPMw3ipmw5TlO/UW9VKGgyOVrkaWBWF
	mkxma6aRZ9ywZzoB2WUkMEEgB/3Swf6JReksKPkK98IzV/owp5y+lY+yZFhp8vxENYI2Bc7F0Ot
	hB3lunZiuigycQRjblNgRrb5+9ZoU6LrS
X-Google-Smtp-Source: AGHT+IFVRQ4/ZKXf+nftqxz+AN4Jao8z8P6i4Cfu0L7Dy/oXNp+ztoVRhDkFy9ERd0jErGIUreVmxhAla/syV5cBQ2Q=
X-Received: by 2002:a05:6000:10cb:b0:34c:8bc5:37a6 with SMTP id
 b11-20020a05600010cb00b0034c8bc537a6mr96685wrx.67.1714148502444; Fri, 26 Apr
 2024 09:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426092214.16426-1-jose.marchesi@oracle.com>
In-Reply-To: <20240426092214.16426-1-jose.marchesi@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 09:21:31 -0700
Message-ID: <CAADnVQ+jV_Ls2boXsdCRWSX8DDDVc0VKZ95PwGb4E5NZq6PMFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid casts from pointers to enums in bpf_tracing.h
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	David Faust <david.faust@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:22=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> Tested in bpf-next master.
> No regressions.

CI disagrees :)

The build is failing on all architectures:
https://patchwork.kernel.org/project/netdevbpf/patch/20240426092214.16426-1=
-jose.marchesi@oracle.com/

