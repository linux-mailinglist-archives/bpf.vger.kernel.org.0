Return-Path: <bpf+bounces-20280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7C83B50F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 23:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94019B24CED
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 22:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606713664A;
	Wed, 24 Jan 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvIf1mv6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB03135403;
	Wed, 24 Jan 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706137137; cv=none; b=b/BaLqmEdLZXKA4ESBuQ2RaJAx/tM1w9mSrOnFpQUPoK8fnvX2wdPplDA5hPskY+4tr+MVkNIfjXQu/NoIPcf1R08pjNPPk66mWxADYRc/LO/vraO8k3aQ3AQA3uGJXdu4K74+CZ2o0A+QXOH5yFDZ/86FaslELNrnHZ49xB8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706137137; c=relaxed/simple;
	bh=s41JkLFi9k1Zs24z7DNQqU1rsYm5rpQ92G33wNodR8U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=khV/6NbNVWk280wPqYyueKNPtRUMw4ccZU1IcM2vRvoJ8aP9mS+0lzqiVvvazTjjUVuabrncXgM9j5fgJpnyTrbabgbDII4sLuBkq53CPh03sqwRVqCzyVHkospef/j+XbrdN1wQp3+7YWhaAQ9sQhe+7LJ2q1RhuipViZ4M2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvIf1mv6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dda0e3600aso776261b3a.2;
        Wed, 24 Jan 2024 14:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706137135; x=1706741935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cJyDwjvG05JVyxaIUfVgiZSovIonkWZX147rTIeaX0=;
        b=hvIf1mv6jiSyDAU5UvnNdFx7gS+JlM0KlrDAqe5Q9JtiozmnV0LLT5NboUUi5qm8VS
         8hgQVlyNQWf8/94is5idJbt9hNFwfwl9/9OVaCXjpxiJuoAO2sso8G7xGaBjeisiJWIp
         P1Djn9xRFDmrzMjs82igE2rGEMok8XmTokIu+CnVxb0Zwz4FlOfvHvEsqUjIHKqWACWm
         DmOhbJxsZBn2V4aXcdJQ4kSDfnzR83BNLqS0FGBo8x5XANg+G0EEgHfMcMhSiWxlivmZ
         JlkW9rWV3tlRZoOUmhtRvRfhonNJejzKdm9/Q6qgR07p5piCl4xS56g5W8YMTyGKJBCT
         jHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706137135; x=1706741935;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cJyDwjvG05JVyxaIUfVgiZSovIonkWZX147rTIeaX0=;
        b=Qgu+gT3RtvcvlJXPumf2k6eS5p6ZyS2NsjQ2kBn9AavCahxLbgt8gGuVjRa53rrlBx
         Muab9IzIHhxsqmaReBRnILInF+OVCWe3wyGbtRmsxl2pvnPUbffFxW5beqS7gGVjcUQK
         SrjpNIIgu5XR1x7jJyO+wW3IauA9BurPQZ+dDuKc9lncZaCXy90pyoRQGHT719Tit8aj
         zq201NNlllnyOWc9cxi2w53wz62jWTeNvGxnGhKd2jXwgQ0xhZ2yXoSLSVTo6GcVRXXo
         c1PByVteWt23jOMDz7081IgV/Ork1NwYaN7XHr4CMhmmuMoNZKxcXn7R2GH3YkdgJrQ3
         1LWA==
X-Gm-Message-State: AOJu0YxJ36cXd1CCeZZnSk4TotNRnoEqGOh1jPRSp7KWoesEUD9cvUQ7
	y12iZsiniFHNZ3d0y6VVyMkQuNE7SXdPpFJ32/8UuaDEuXqHgIKp
X-Google-Smtp-Source: AGHT+IFcagnDsXXd3OJ0w9TQPhPsZAjS8zieeMcY9fUhaJOwev1w+iRa55S/eNuQQWzejJmX0uCxQA==
X-Received: by 2002:a05:6a00:c2:b0:6db:e165:56ea with SMTP id e2-20020a056a0000c200b006dbe16556eamr276628pfj.36.1706137134893;
        Wed, 24 Jan 2024 14:58:54 -0800 (PST)
Received: from localhost ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id y8-20020aa793c8000000b006ce71af841bsm14364429pff.4.2024.01.24.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:58:54 -0800 (PST)
Date: Wed, 24 Jan 2024 14:58:52 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 jakub@cloudflare.com, 
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, 
 john.fastabend@gmail.com, 
 andrii@kernel.org
Message-ID: <65b1962cb633e_12e2dc2089b@john.notmuch>
In-Reply-To: <20240124185403.1104141-1-john.fastabend@gmail.com>
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
Subject: RE: [PATCH bpf-next v2 0/4] transition sockmap testing to test_progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Fastabend wrote:
> Its much easier to write and read tests than it was when sockmap was
> originally created. At that time we created a test_sockmap prog that
> did sockmap tests. But, its showing its age now. For example it reads
> user vars out of maps, is hard to run targetted tests, has a different
> format from the familiar test_progs and so on.
> 
> I recently thought there was an issue with pop helpers so I created
> some tests to try and track it down. It turns out it was a bug in the
> BPF program we had not the kernel. But, I think it makes sense to
> start deprecating test_sockmap and converting these to the nicer
> test_progs.
> 
> So this is a first round of test_prog tests for sockmap cork and
> pop helpers. I'll add push and pull tests shortly. I think its fine,
> maybe preferred to review smaller patchsets, to send these
> incrementally as I get them created.
> 
> Thanks!
> 
> v2: fix unint vars in some branches from `make RELEASE=1`

I'll wait a bit to see if there is any additional feedback, but on
bpf-next these tests were stable. When we backported to 6.1
they became a bit flaky because recv() would sometimes only get
part of the msg. I'll take a look, but this should be fine adding
a retry logic to the recv() so it does a few recv's before giving
up allows it to recv partial messages, but still pass the test.

Thanks,
John

