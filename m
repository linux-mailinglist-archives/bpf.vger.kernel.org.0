Return-Path: <bpf+bounces-29882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E38C7F00
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A782E2832DB
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DC32C68C;
	Thu, 16 May 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T70QQrre"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B124A08;
	Thu, 16 May 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715902659; cv=none; b=PY4UBaQ9Y9aWC+6p3S/Jp0kwS5asgL5PcuKv3cKjK1tAtsb5TkyGGspMFp+N1QPSncNYLPZSTRGpbPerFog00tFyGoJtPwLpsh6BpiZOXgQGLr24gbvXF+eySqvqrxx2ut2Hwac2bEvF2306/4VBavBr8K0g/xa9RoJa3sYzCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715902659; c=relaxed/simple;
	bh=ba6fEHDbMImxiDuLINNOeuiTXyrwLnTUOG11weRAuFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwJaqdvkgGCkRCUrcyZGyj6LVAYp4mYISf705n1WyfaGSflpp6m00HFv8lF9zmO8u4m2PyNyIVOk6cZvqBUmBOJXcnP+iW13JpXbBL8rTVor86djl5r51Fl1yOJ0UEWzkpF9s7WwsLw4qOBAqlYbUS+E0cUi+QEJ8IE9DzZHGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T70QQrre; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de46b113a5dso8528948276.3;
        Thu, 16 May 2024 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715902657; x=1716507457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ba6fEHDbMImxiDuLINNOeuiTXyrwLnTUOG11weRAuFE=;
        b=T70QQrre5IOTnnmYVc0Ku1hy5YE1g2+usjP7n35ZXRCWYWJD1bj/ELs/QoD6pwZ/AP
         fQ+uEs20mqR7QseFwcRl0jgsl2SoZfCzp4BpT1HqGeLB9mFszPv4wTaZzpbNojl9ZP+/
         m73u1H+1OuDD1gKT6bfLLe27Xsh6wX0RIlNf65T4Taf1RIZyf0mlZh1f7Zvd5exdujF0
         L/+UuFb52b6yr3BJX3RdRwCMEO7yd/YVe6cQe74OfxFt/yDO3aSeqUn5uaaDH7aDk41h
         MI1kvFqhdnXvnA5ckhvoZr7Hnh4VXVA6daVztw4sgRojTCzuyx+9FPAPQ8PeQTMjYIh2
         beDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715902657; x=1716507457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ba6fEHDbMImxiDuLINNOeuiTXyrwLnTUOG11weRAuFE=;
        b=bfpbX3E40aLUBTlxfcUi26jmo/ioxTpjXoxQXKXWNOxcPbsGSOeCxCxezSGv54suKH
         XstC0skt8C7W11C0NCgKhnbyUEi2wBmpZOovruQSCYF0+87GfBRqqX8+CmZUnnoqJZjc
         A0lR7k970Tbmqp70Ls1PsgOaJewYA4GD7AolQjC/2YLKEdkOidTvP8lfGpd7z9EdJYQd
         3EUE/pjQ8i/NvfQ9PyC5GuZVp8eaIB62gxsUTzlz8wUEPffSSNRYJ2rR7vsiXiMf6PeM
         a0xG6nFhi26Kae8cMWcOmvYSqn2YsNUKo1l01O+kXIg65mHDdzPregZlEoCxI+nHoZS1
         B86g==
X-Gm-Message-State: AOJu0YxVApU0zobZu37IAYDYtDnoQUCC+jhBUIc6FsDhaurXQiJz+O6e
	AdKzQcEKf4eF+KeWOIgm+ZgZ1Jagedr1e3pbCe5GI1hE6P+LVzDQ0R7STVdyJfy/IdieUsaD1Jq
	0UZu3lOhGtJaup8R1+FngOKF6xqDp0/wL
X-Google-Smtp-Source: AGHT+IHYOANYPoz3miSDViLtRhoi9BUYOzxXwMBEE1TtHastq1ZxZH0y90VMkdWc3x/+Hi5yLfehQ7oKn4Ocr2zTqsw=
X-Received: by 2002:a25:6f87:0:b0:de5:d8d3:e288 with SMTP id
 3f1490d57ef6-dee4f2db0e2mr18305215276.24.1715902657224; Thu, 16 May 2024
 16:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com> <20240510192412.3297104-10-amery.hung@bytedance.com>
In-Reply-To: <20240510192412.3297104-10-amery.hung@bytedance.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 May 2024 16:37:26 -0700
Message-ID: <CAMB2axPv3PgKSBPkN+__AhgGk5wGo2+VtzKroPWGJwDtg5o4eg@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/20] bpf: Find special BTF fields in union
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"

The implementation of supporting adding skb to collections is flaky as
Kui-Feng has pointed out in offline discussion. Basically, supporting
special BTF fields in unions needs more care.

I will defer patch 5-12 to another patchset after the first BPF Qdisc
patchset lands. While the performance of qdiscs implemented with the first
series will not be as good, this will make the patchset easier to review.

