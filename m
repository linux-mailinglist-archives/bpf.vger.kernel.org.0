Return-Path: <bpf+bounces-40453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C5E988CEA
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 01:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FE1B21ADF
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C218A93C;
	Fri, 27 Sep 2024 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJZGjf5b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E22C1AE
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727479204; cv=none; b=E8j4cfWMAd0/D/nggIZF937BrwPCYIJZ499RX+aiC/hBhcsbhKeS+ihKGvdSrQBVn0+Gu3HSac2rD+O5Mnv9gpe5Ki1p6bOCGXW0V3p2K13VOg0dCh7jRgpk9ywtQd7ElP7PL5ZOmACMIlo/6lDjBKiErIYPlssXK96ca+s+jBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727479204; c=relaxed/simple;
	bh=PTIHTxTVnFKFXAQbHzS7RZc725Lz4IxARmwRigf1DMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4dLsPyTXwd9WEIcw8wany56PMBB0mncRy9/5M3sEEPos/5sAK73TU6QAxzS5/IYjj8VS/L84c7y5ZyL7ts+o0pncGZL0Q1FFAKW0IhSQCLFcbioIPUFkf44aGjgDG70l8CYXPHlHOr9l2SzkWE1Cn6IP7DPij1ddFTEwIXNkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJZGjf5b; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so1891565a91.2
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727479203; x=1728084003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTIHTxTVnFKFXAQbHzS7RZc725Lz4IxARmwRigf1DMI=;
        b=CJZGjf5b901dGF4/FvykdiUC6JocUayzolCcLfiwTrfrk7AI5Pl0oKHSknMokQlF/G
         xi6/MEaFJQwSsUzYJIXis2HpW8pqrU2fprQLxrIDWVIjehE+sBEvlXBnO9FO7G5ZdRN5
         tXfc2mGxjGfDyqcTsOLmSScrOOjumTsj+g9ketkmQ3yxLWlhX1L3w8Dk3Toe0KVmlOJg
         GvpqdHp/57krcMzARvdqE0Xzrww9amLR8Zs1XdkY/bOioBbUoBghLyo81SCt3wjyOAp2
         X2Ppk7qeYbUIAJeMa+A3oYXzW60yo+DQz0xx5jEt+Mq2a95vh341EU7FNRY4o0dkSbvj
         N95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727479203; x=1728084003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTIHTxTVnFKFXAQbHzS7RZc725Lz4IxARmwRigf1DMI=;
        b=VZejTP/3puFrY2NRW0whWsyShYkas43nx39Dbz4hhPEicdCC3sLygCChpVrvEdxVK/
         UP4x74+wXV5fUWkons2cYle3+isrST3U+AdINcA4gI9bxYRS47STr6i9Zcx7Dn/pHThw
         LraGuQQRLWG9JurIriys20hCMLteWOVwiA2hWGdY2afSoNEyT+YLY3L77sEmo4WVLWh2
         I+V92SY64EElJagef8+gC83ZYHmthnd80o67UEAcV/wVj5nDIB4857E7FxLZZXG8pfMX
         30Us/Kn51lSJxovMl1bbNygyGeEDbS7IN45uE1a78gCf+cASqfngMIH296tM50pzPsdW
         5ILg==
X-Gm-Message-State: AOJu0YyoE8+/a62DRhPFaln33gaMKL4PUstbeWWhRwQTdYNlgGSTJo7R
	5SL1GqMzGZlFdFUH8PODJruNZ+kzJOAcyvS4cJ7nuPxMxEInKys9437y6B5Jtstp7CewY0v5vw/
	syRCeXE7Gt7aLrwaoWddFI96YoWdpSYOM
X-Google-Smtp-Source: AGHT+IEudK5i+tsBNjq/EawbrU+GrvDdW2mUyQZfTDtm+4/Ljf3NbWhqSGy08LHehfby7nAsXpVzSRoV2eYnVAMKR7Y=
X-Received: by 2002:a17:90b:1987:b0:2e0:7d60:759 with SMTP id
 98e67ed59e1d1-2e0b876f31bmr5614195a91.3.1727479202632; Fri, 27 Sep 2024
 16:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+KXx0WsH1en-DNXLf4mc4bC7apK_U9js0KbFSfp8Jdm8K8W9w@mail.gmail.com>
In-Reply-To: <CA+KXx0WsH1en-DNXLf4mc4bC7apK_U9js0KbFSfp8Jdm8K8W9w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 16:19:50 -0700
Message-ID: <CAEf4BzZjmz7dqOe--MYAV8F=h-RAhfnhHmW66W56GZeCKjVOww@mail.gmail.com>
Subject: Re: QUERY: Regarding bpf link cleanup for invalid binary path
To: Abhik Sen <abhikisraina@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 10:18=E2=80=AFPM Abhik Sen <abhikisraina@gmail.com>=
 wrote:
>
> Hello Team!
>
> We were looking into the bpf-link and bpf-program-attach-uprobe-opts

Is the API actually called "bpf-program-attach-uprobe-opts" or we are
talking about libbpf's bpf_program__attach_uprobe_opts()? In the
former case, which library and API are we talking about? In the latter
case, why rewrite API names and cause unnecessary confusion?

> implementation and wanted to know if a bpf-link on a binary path
> resulted out of bpf-program-attach-uprobe-opts([a binary path]),
> remains valid and leaks memory post the binary path getting invalid
> (say due to the file getting deleted or path does not exist anymore).

I'll try to guess what you are asking. If you attached uprobe to some
binary that was present at the time of attachment successfully, and
then binary was removed from the file system *while uprobe is still
attached*, then that binary is still there in the kernel and uprobe is
still, technically active (there could be processes that were loaded
from that binary that are still running). It's not considered a leak,
that's how Linux object refcounting works.

>
> Does calling bpf-link-destroy on that link give any additional safety
> w.r.t the invalid binary path, or is it not needed to invoke and the
> internal implementation of the bpf-link takes care of the essential
> cleanup?

bpf_link__destroy() (that's libbpf API name) will detach uprobe, and
if that uprobe was the last thing to keep reference to that deleted
file, it will be truly removed and destroyed at that point. So you
might want to do that, but it has nothing to do with safety.

>
> Thanks,
> Abhik
>

