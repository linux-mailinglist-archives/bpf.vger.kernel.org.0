Return-Path: <bpf+bounces-34947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32674933B03
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631821C21AC1
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C217E90F;
	Wed, 17 Jul 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzUWJ1P8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630705FBBA;
	Wed, 17 Jul 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211236; cv=none; b=U+Utg0jzYPkSNfT0/7ZmHf6+gtT1sQ45Y7KO+eubI+GXszqwuXZ9OJlap8z8DoqwDfSk9QQumNA/nLdkKz0tN8vjBUphEm5/OW3tgnzmsVPDBOUHMBPxZj5JcyCDmM9hiAEz2bl0kzRnDhD/SZ/qDbgn855KklpQ2VhPI2tMm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211236; c=relaxed/simple;
	bh=bZohqumUnxUx23tVhFFqBMk5mHhNjzB1zQETaMF7J+g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FXS0mZIn/D0w3wrlaeXwWnRyh3roB4a3x8BApnW0q9P9ogE1/KRVRybnz3qcU95CZssIK2oqreqOwh49MdfAmQK9JQSs4Nhv8SS6TQmpZThhzjlX4lQIG0tWjjhUc/90HA+pZiWYFAPDGwNkX9lH4DBWFIZd/4+qBoQOVLHDLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzUWJ1P8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea1a69624so7039295e87.1;
        Wed, 17 Jul 2024 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721211232; x=1721816032; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZohqumUnxUx23tVhFFqBMk5mHhNjzB1zQETaMF7J+g=;
        b=EzUWJ1P8NWZSYYDQjqkEiQXPaY86uwQI/G+x37Dvdi0a80CwWLU10A4L318F2JellU
         9voJZ+7nzXR0kiexe7qURA5LSoROK4ZYbWrJx9jndCJ1Cvixipev6omSJInLfBuFXqmn
         vs7NjHrK5YDUYKLqXoaRNFu6STAuZw6SsK6Wf3/orOCfSF4S3S4JUIeo76MbXbZ2PIjU
         bd2wPrC1H6CqWLN1KRONGN2mTHCdwXGde6KlMZnoPE573xtZn1wW7tGDiB+frnPyEGEM
         Cug9kg7kXRLE3CPTUxirHI6b+hemOAxWtFN1TzeqraYVaYP03PExFMjbkx+Y1zkniUyw
         7glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721211232; x=1721816032;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZohqumUnxUx23tVhFFqBMk5mHhNjzB1zQETaMF7J+g=;
        b=mvjvMtAeyzB1fZKIRreJTsZ2c1hDloezd9vh8IcVbYjOnZ9zqekU8CKJ+74jzPHEzM
         xI9LYjq4zSIVAhs9+r2U631InIA6ImnM/asaIVjWeqpDg/20Y5J42nZIwyrXKYqGo7lU
         8d8ODZNjB5B/tYLZNZ5Dvvwbwj91MrcX8NIDkS6myvvI/e7tnpIjg+6rKM20lOUv9EMz
         g+5bp3DKflE3wQ+yOjD5zlT+qpEcJm68C9mA3cF6VDQ1nXU6lBlUDcIAGP6zhKIy6mLS
         3buB711d7jHsD+4LMlgJEXrZU9w4Vo2oP4Kn8p7SWBlcn2fsyjYRuXUJ/GS9RvRe6vaZ
         RF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdcq7X6KaA3EzuYsvMKAsHws1henwI8mUNWEW3O7DHrP4bLP57+qzrLOScYI/+CJILiYpai0qtkh3da3pPT+zUpC9a
X-Gm-Message-State: AOJu0Yyz1Cwz3eIJNr+9nTCpLJ8w+6uq0lEmQzfhSXPqiCAOWsQRe7B+
	FWukuGK2DK2iq6IKV9r/Slljh7TKTppc16sgX83g20JmdkhKYUYm
X-Google-Smtp-Source: AGHT+IHBUSIMWDccM70ipVpLwyXAI32LQU6YXGnanCbfMPOdjmovc33HCYqT0uDUdODiqDmaKk5LIA==
X-Received: by 2002:a05:6512:4004:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-52ee5426fa0mr797165e87.49.1721211232127;
        Wed, 17 Jul 2024 03:13:52 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a446:8596:96cf:681b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25b946sm196580425e9.19.2024.07.17.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:13:51 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  yangpeihao@sjtu.edu.cn,
  daniel@iogearbox.net,  andrii@kernel.org,  alexei.starovoitov@gmail.com,
  martin.lau@kernel.org,  sinquersw@gmail.com,  toke@redhat.com,
  jhs@mojatatu.com,  jiri@resnulli.us,  sdf@google.com,
  xiyou.wangcong@gmail.com,  yepeilin.cs@gmail.com
Subject: Re: [RFC PATCH v9 00/11] bpf qdisc
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com> (Amery Hung's
	message of "Sun, 14 Jul 2024 17:51:19 +0000")
Date: Wed, 17 Jul 2024 11:13:45 +0100
Message-ID: <m2bk2wz5pi.fsf@gmail.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amery Hung <ameryhung@gmail.com> writes:

> Hi all,
>
> This patchset aims to support implementing qdisc using bpf struct_ops.
> This version takes a step back and only implements the minimum support
> for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
> directly and 2) classful qdisc are deferred to future patchsets.

How do you build with this patchset?

I had to build with the following to get the selftests to build:

CONFIG_NET_SCH_NETEM=y
CONFIG_NET_FOU=y

> * Miscellaneous notes *
>
> The bpf qdiscs in selftest requires support of exchanging kptr into
> allocated objects (local kptr), which Dave Marchevsky developed and
> kindly sent me as off-list patchset.

It's impossible to try out this patchset without the kptr patches. Can
you include those patches here?

