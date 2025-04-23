Return-Path: <bpf+bounces-56509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1628A995B3
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20065A25C4
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714C2820AD;
	Wed, 23 Apr 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiR4ddEL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F0DDC3
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426883; cv=none; b=UL3fnF/e1l28k1B7xcwRAhQPORUJwxsST4ADhclTiB/nebPstLovo+6Fnfl8d2V54jYQsY1jRv2Es+FHaNWko4MsgBNgH5bCQyOc59gTOZY2VtTMzWtLlAP4pj+y/uWvEzxividKdQmwzEjxuEgH3QtVYMRVvYvnl234axWZ+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426883; c=relaxed/simple;
	bh=Rv+GvUQwFi08dRxMmeCKYgopKYgY5TTnCq1NKhTSa2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPphlRAbSTJm5RyfmyXxJ7Y45qDJbfg7jrW6W7fouQ72P7vXZgCG7DkKg9mL/KfXQgFc+hXT7q+GfZpWWC2kix/k8nAcWZPeUlgx7FDMWnJ/2TdCvgJ7JkzKEOQ8QOCtPg0HWuRN5KPce6TDi4fve5jwg2VGOSewAlEGmcSpyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiR4ddEL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39bf44be22fso44733f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745426880; x=1746031680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv+GvUQwFi08dRxMmeCKYgopKYgY5TTnCq1NKhTSa2A=;
        b=QiR4ddEL0mwcoUwfeON2cwyTXY8bjksn9sj7ScD/eunQlsUN4l2PkhZJsX+2dS/j7c
         Gg2uJkIiwgnHh91riLa7sURjJ8ImNeenNTGE8ObGX07jVG21NagzvrsghostUDmo+QRZ
         sC7ak6HQhRHE+agdVWGcB92c5O7NR4bd3Mo+qMkwN8QuNQlczjszw8ZrKfwUcYbstB/r
         cm9DWMvSlg8wQJY5ZBLCnvcnGtIPD5AR+/mETbokXVqdHSXtKCadMXlDHNNMKqkfMeVB
         I2tfD3tb6A3G2GV8lh0/ZTXn8GHC/H5N6whwD0y7Z1S5FeyjzMcYmSlbi3GxMh+/lzt9
         O8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426880; x=1746031680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv+GvUQwFi08dRxMmeCKYgopKYgY5TTnCq1NKhTSa2A=;
        b=xBByCgSysRcfkGLht6B9C3DE20rMrjupJcSqnknOBBpeOb6LypiXVlm1ytKJdARNh0
         hDuvUOoo8gJx7H5KMGEEuel1QGU2cTcRPiX5csldb0b5y2gzDRrE82/b6OD0J4gK+jZR
         7bmSF14uGVsmzUWkgDXuv1FVAKAXQJCRfwnu03khrWfZhGc7mJl7uwtCX4kCDu51l2fp
         z7v40McJwb1p/zBe8LG1M8xAWdeRzupdWLeMmW20utwh0j71ehpmKz98uuzbmsDsAfE5
         VKWFUWOjpKRL2Zch5v/Akh7QbNMGqLIhNQk/Hnwhj8eA7m922Ttd9z2/t/fo+HViLf5o
         F+OQ==
X-Gm-Message-State: AOJu0YxGIurImy61PWjFVA9mtvq2y2uHIec48sXISlKtosZG/Sd2xGui
	u/KS2fqcMQ6nd8semCNeVutrUNRLyD+1ey9qDnkUm0LW00bi1Oe68QgK58K3VZl8uTa1r1X33yY
	vadYvY+tLlyemPLj4+hfBrcmgNR50GQ==
X-Gm-Gg: ASbGncuSGAsTG4BkcBNqaPbzKLuSN0qxOLZxSmToL/nKxvci68nfOI3NiPQ2o1LLoD+
	3MykfbWa4LgmRomPkdZdwSb+AUBucw+aUCTsaPorsEvUWflPtvNHSshpqsQ7dS9C4kzIdwN4X++
	NL1YLTMRuFoJad0hJbOXrCmHdqZh4VFts050iJtvwMiwtugQt6
X-Google-Smtp-Source: AGHT+IHrLaKwFVX8AUpr6p6PuENy9nJURbkwXwBe1vRV+hVlAXByLE3o/++Z8vAT7PPWx/BOwR0nMdIdblyMNBMz4QI=
X-Received: by 2002:a5d:648d:0:b0:39e:cbc7:ad38 with SMTP id
 ffacd0b85a97d-3a06c415866mr223130f8f.32.1745426879506; Wed, 23 Apr 2025
 09:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423160116.120118-1-brandon.kammerdiener@intel.com> <20250423160116.120118-2-brandon.kammerdiener@intel.com>
In-Reply-To: <20250423160116.120118-2-brandon.kammerdiener@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Apr 2025 09:47:48 -0700
X-Gm-Features: ATxdqUEHjWOfi-kpwArKCt0zm1m6ididkCrZKIKxGyjYvQtuisoZwqSrKRg-0vs
Message-ID: <CAADnVQJD15Fcrx8jnaj5HB6ad9_sBhFtN77J1bO=Tr7HXiM=QA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix possible endless loop in BPF map iteration
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:19=E2=80=AFAM Brandon Kammerdiener
<brandon.kammerdiener@intel.com> wrote:
>
> The _safe variant used here gets the next element before running the call=
back,
> avoiding the endless loop condition.
>
> ---

SOB is missing.

pw-bot: cr

