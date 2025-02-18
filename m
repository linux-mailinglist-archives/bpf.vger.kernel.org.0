Return-Path: <bpf+bounces-51820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30001A398AD
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 11:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993403ACB0D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B431233D88;
	Tue, 18 Feb 2025 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUkhK66e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A71B415E
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873772; cv=none; b=k+dGx8HvCrVCSAKv2xdNSjlgz8yt2vZv1ca5G0dMyMnXxeVP7Z2xFmBmoCN4YvX2RzEbYUkFOM6f4quMTikOE5hDxv1tqlR55s5rY9MzzGx9hGcCOFQ+W1bqwjhwLMNHSFfm2aah4HfbLzP5odZPmi5B5kaScq0SG9IGCvTloo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873772; c=relaxed/simple;
	bh=v9w6trZp1DEViIuzMlzloOZhrXv8svwENQoBc8rXvP8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hSVgLdn95KxBYwVIzt6cc+tf5v7kdx5xREeiqYiVKXsqqMEC4aVIQ/DzFsSteb3HREfXVx2C2H8CoNBBj0op27UblX3A3JDyzvynO4EYDQhhtBrH5J/eo+2PgXybJ5aPjXlZqWa/4Dl5K00tuasZjEa+axB1ZwASWnUZ3S5sGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUkhK66e; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471f9d11176so10887271cf.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 02:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873769; x=1740478569; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v9w6trZp1DEViIuzMlzloOZhrXv8svwENQoBc8rXvP8=;
        b=RUkhK66eebmabtPXDWp+TwmBqYe91riEoa25So6FwQnYL+k6PgbTBat4Twl+bNhxfL
         h5L5uxoAvB8X96/Lgc3x/rMBAnrzYUY1QbUjIddoQClzgPK9m6hbQjyEgszmDQJPfdXB
         AT1e/jja0mY202+5n4ht8YJYeFRyz13OVduHJP5709qKuO7C++e5c1ZfRaKffW6xy57U
         /yvgMIdDn9tY3+cCPBMzt4noaOO58pGq5LJCnwUWpmjDCZYtoHPQ4ca3+F0TZfG/hSg8
         QGc5iSkw21ozPVDlxNpU4MVHa1WslLrU2cDRbSkPZTjH5jVOb7+GSivDy5XvZ74jfT8A
         7gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873769; x=1740478569;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9w6trZp1DEViIuzMlzloOZhrXv8svwENQoBc8rXvP8=;
        b=VbAuRps1NlSH29bS6EqD22CLjxXPILGI+0GKuiFPAeMwUzZ1ODnXjCk4fMjYMisWpP
         dgJGQw7bp75cmz73MVzRbC4kTBwZAD6hCDCHfm3ekCdfYUTNpuZG7Xflbs/YHqhpYjF/
         4gqRVq14E7jGH4KXrwaxHCHKS+lcQPablQpKsjBvokLDsy0ni0ah5o/VrjnBoTq8Nfr1
         //7olkrZN2nNqplfWME2NvTbtk0eAqz1p0ZNqwPnb3emloMqyeBVpWwqDccyptgVkapv
         1VRLIlRbpdlWfjl+ixG3cqTfbOWLsIS7UAT10hrStfXxTXNXV1MRy85vCU0bVrPag0Mh
         09qg==
X-Gm-Message-State: AOJu0YzaBr3fxHaMajbio+uN3a9uTbaNRLbgtgca/FUksSN1m6lcitoG
	us8axO7BIB1TTkO3n8TrAUHlqp/cJP6/dJaAniSTecm9uD5v9oFmznjEJcOk6659SrcgnwAZa3d
	6NHQM1wmSJFogJIIlZjgIfkDO3RpSOymUo7g=
X-Gm-Gg: ASbGncsD2YOIAOWBvWLjfx6THCqmaM/DgX/TX6GGeLW8UvSCfm1UHK26g6mXMjeITqw
	aUFJnjE5omGV7kssphAVuhVsm1pkYyKIC6ZZNvtDd3nEM+XczDQysq2swgbiM3QQBcYJAFxe8vA
	==
X-Google-Smtp-Source: AGHT+IHVp6LAe5wUQfHAyWhXi2PVNrMINRIMKUJ1dktezp6Sho1t82qbTDZ50jba52Jt91a8X3WZZXgvlIDNA2K9TmY=
X-Received: by 2002:ac8:7c47:0:b0:471:97db:60d4 with SMTP id
 d75a77b69052e-471dbe8d755mr148842931cf.45.1739873768963; Tue, 18 Feb 2025
 02:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Egor Egor <xwooffie@gmail.com>
Date: Tue, 18 Feb 2025 13:15:58 +0300
X-Gm-Features: AWEUYZlJXxfZIlJ-y64iKcDwDaADVDHu8N0uZXuyV1E83YNw-r-yUwQw_oeSUGY
Message-ID: <CAHdT9g2Y6eXR4VsjOGk8i3kPukpB4vt5fJyM=B_V5aUgazVhVw@mail.gmail.com>
Subject: Question about possible NULL dereference in linker.c
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In this line we assume that dst_sec can be NULL:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+/refs/heads/master/tools/lib/bpf/linker.c#2160

But after we use it without check:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+/refs/heads/master/tools/lib/bpf/linker.c#2167

Can we get CWE-476 here?

Best regards, Egor.

