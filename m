Return-Path: <bpf+bounces-34025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF678929A81
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 03:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F027A1C20C18
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35669524F;
	Mon,  8 Jul 2024 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="albPMPRo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635504C8C
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720401757; cv=none; b=UvtFLbi9zHixvcWIlvpF4ls39wsEILBXRLRwJXMD0FLlzoJXgRBzySYHS/D31Z7LVFRCh3Wjea9S/qfUUSzBgeyc6XMl/VOWcX610tQ6w9+IcPbUOQI7pjYmQkuNQztdMcM+DtrK3TLvolrgcN++oCpF9XNnqUWTKHtchYlIQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720401757; c=relaxed/simple;
	bh=8+O+wkqXbe/+KJE84v4PzRhen3k+iwR+p/O3gM559wo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dYEKN6xU+pvBhVGEK69h85LhhgrcDgqhwSE6hRw/BldRwCH8gJZG6YP4lbm6D6HujkpcxElKiEqJaGongPHG9Ytd9jJ3N9305yCZ/+tgIMeQxWbqlQ0RZ/frz8h0Vu29t/6qF4Ugpflz2y4sZua3LXp41k86hOkg3jLejYDy1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=albPMPRo; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03c689addcso3629905276.0
        for <bpf@vger.kernel.org>; Sun, 07 Jul 2024 18:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720401755; x=1721006555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+O+wkqXbe/+KJE84v4PzRhen3k+iwR+p/O3gM559wo=;
        b=albPMPRovpEYEUsGph3nzY8HufwqreP/voVmfYD+ZcuC5Ra7/g6y7g2WSvClBZXUS3
         fVDzKLP2DWw4T/fEas2tVPNvP6ctc2ifWBaCKBUYxCHogbTzQuS3/VZE4FUmBr2+Uuo/
         vJT1LpGTCFPWvpeF634jJAEjAIAPlm3I68+6mFHyMAoB896dmV8n19iWNYdLUAgeOigz
         yG64x7Di6fDOhuFvU1hz+HQgbkfA19chKRy/F1P+OwDFv+PJLMvgQtTW8LtOCGY19AxZ
         pQDvXq+svc13gVumQHFc0sOCBYWdknwMBUHjOXuWbqLh6ZVAYP0cI5iVhWp4k7PBihI+
         D4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720401755; x=1721006555;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+O+wkqXbe/+KJE84v4PzRhen3k+iwR+p/O3gM559wo=;
        b=q5NYOZLq8BMmyamr4IT66vT4Y/36Z+Vxm8iP8rJF+LY9Ji4JkO/eu+S7SGu+jz3YAj
         jY2m/iATqjCjnDdZJME44aCXSqqz8Om3hFoOk6HnlDuApcp3e4pKHCGTNiDN4ha5/tgT
         U9zELXXn4U868IVnDAEmYhBFHa01ag0c1hOfMKS2Dz+1x+jCuZlXrdTm31IwIXP1KIsd
         7ZO9y8Vr4rtt4/Ddm1j0Yyrve8i7Vi+O0E3XQgd7dYk0UQjaguzmUWMUwkTTPcde8cGZ
         NUWIzp8pJ9EwclOIWOHClRxk2S3OhJ6Hv515cdeb4Y1KaQyK7MAQrKfrJzyFaUqaLIdM
         Ul0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzxeMGqf/a27gCqlirvY8E4ZymqQcE4y0O/8er1n3fdQHfjK4MT1GfRflOZImdaFTZmbTGTHyhF/yerIncC7WEOiBz
X-Gm-Message-State: AOJu0YzpVpb52iI8atFe04+qfwrCRAzISoRZCKy2xtotPrxE/yURPMZn
	yPx467JjQxAoGINtP1oMACAZ6WXgsVdTTBNGYizjnFypd0Xl9SrnUHVqf7S7xI+Hxv7CCPg9ofg
	Z9lgFwad1ovynkWqGdO7SpVPS0bg=
X-Google-Smtp-Source: AGHT+IEM8WlQH3eV9mEO7lqrq6jSpKipi7CZIlEimryhzRMT57dT5UtzOjWoLGAF5EkBCbH1Bxgyw0oX5+UoBW44q+s=
X-Received: by 2002:a25:f61e:0:b0:e03:5da5:37d1 with SMTP id
 3f1490d57ef6-e03c19426f9mr11763678276.9.1720401755261; Sun, 07 Jul 2024
 18:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Totoro W <tw19881113@gmail.com>
Date: Mon, 8 Jul 2024 09:20:59 +0800
Message-ID: <CAFrM9zueFXyziBjhhSWCj=5C2egwF-CKQPvJEm=2YhQEyyoXDw@mail.gmail.com>
Subject: Re: A question about BTF naming convention
To: andrii.nakryiko@gmail.com
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, 
	Totoro W <tw19881113@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> So, first of all, I'm not sure whether the BPF verifier being so
> strict about BTF names is necessary, but I haven't thought a lot about
> that. Just pointing out I myself wouldn't object lifting any kind of
> restriction there, in principle.
>
> But then for the Zig naming thing. Doesn't Zig have some sort of
> mangling schema, like C++ or Rust do? Would it make sense to store
> mangled names in BTF then?

I'm afraid not. Zig is still in its infancy. So I finally decided to
sort of work
around this issue on the zbpf side by introducing a BTF sanitizer [1].

Thanks Andrii, Eduard and Alan for the help along this thread.

[1] https://github.com/tw4452852/zbpf/commit/866d83cdf57316f63f6c20ee5fbc0880575a0213

