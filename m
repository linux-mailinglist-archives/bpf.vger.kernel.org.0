Return-Path: <bpf+bounces-26308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB389E00C
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 18:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3928728594E
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E9613D885;
	Tue,  9 Apr 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STelNkvp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D763A1C7
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679008; cv=none; b=oo2NM+0yfEhz2G1QMtHwyib2C6JE9S2lKnvbuA4qcboBQntMNJfmUu/wm3yZyl9aumc9zVOHqrm6Xal7CFAId2HVVzgVZk+gSkUs/MzJoCQViTKe3vzqAzlLaQmyuCTpmbL5QVSwVNEqybj/q1KqmGC4dVaKv46x7vUmcNQnutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679008; c=relaxed/simple;
	bh=L54kcvC7tM5k3CHEDDLLg9GL0uS3slGoj9IlpaeX31c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=olFHfx0IF2DoLnMZPL4ei8He4tFcxVDQxc0rH7Q4tM1UMmMVIjBwY0Yg8moULF9y8oG87RYDiN3guwKOaxp6KBb4Qv/M5E+gA1D8f1+Smk3ZY/ll4F39CM/QPyMIYx5o2pBzD4T4B4H/cOu2H4oV6A0nrv2haMNGP+CWIBasqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STelNkvp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-618409ab1acso186777b3.3
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712679006; x=1713283806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTzBA8vCpg1bQoyDxMrjJAPBioScXieCvpaS67N6E3s=;
        b=STelNkvp2N8Jd5d84GuyhHp6kqSVAW1feJpsZMatiLuhHAU7nAVYJ5bIOpOQRufdAX
         nKrai2HEUa3TCCqEOynm8fh0JFSTzxbMYL/SLmHmXSzhcb5q1/Pwh1odwl5hF3G5CFI1
         /JRa2A3588CE3F+c8RbpETqB+tjE0Dp3CjlHuSQju4mMQr89ZgbXo0g32DUCeq4T/+ny
         bai34qX6u4PnOJ/zP3CFQJD2h9IgIAyxe05mVvhUWbB4iwiIcY4+S0UNroDPHFy3RCMK
         UnWgzK/w0SMsmgc2hJO7HjIi9v8AHNHHX5CpC7AoySgPvNqn/CUtqiphLRICRBgabq4Y
         ur0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679006; x=1713283806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTzBA8vCpg1bQoyDxMrjJAPBioScXieCvpaS67N6E3s=;
        b=fFG2+wsqyU28HB+w+b/r7Mf9+3Dr68sUz+2giUb9ZAuSHiYi4OcBLDa0IgzHupaCAp
         8+3jomVXvsuZbCM/irro96lCBj9iYo15fDQP+ZnztpB8T2D5zk2lxdRTQpbHrfdKfNM4
         O8Xt6J/faOVU/CYxsolDfVFqLtEmxX8IU6l2lzKsKNeZxyaFk1BFKRHUNCUtnBlulfse
         pVS86CmkKHM4+smKMEVOfIwGS/IxtIe6NBzR7Y82hQpHnXmWblPCV0t7zT9RYXHnZBch
         xp4AKvHI8zs9C0E35aASQH8h75aHFWoavXMAXUdw0megfMDVtoyV33lunBpVuIqr9F/H
         XN7A==
X-Forwarded-Encrypted: i=1; AJvYcCWNl37xB4HDBsRp762ZeEiIjbM3oAjKUqZW8lzNP9CgDDs2KcjWYew71DCb8tIdEUPeJAbgymfsVtH7gywDiXyAC0zg
X-Gm-Message-State: AOJu0YysNcyRc6sVg3J3+ouiJX9qRAA7OI2he4Yls5oV4rLVhXo0yBHw
	oKVI9geh8WmSl7FAsJkq4y6iH3S4UTU052ZGNsqXKshZWcgDlK4DSpsBTVo2JzZ/jw==
X-Google-Smtp-Source: AGHT+IE38beRAL/GyZV4u501PGP7OFfQCcNi6umKaAXPP8K0ga6UOvT4QIR9eYTeiccqjAl5Tf1y/Cw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:2b88:b0:dcd:2f3e:4d18 with SMTP id
 fj8-20020a0569022b8800b00dcd2f3e4d18mr14472ybb.12.1712679006109; Tue, 09 Apr
 2024 09:10:06 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:10:04 -0700
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409031549.3531084-1-kuba@kernel.org>
Message-ID: <ZhVoXIE9HhV5LYXV@google.com>
Subject: Re: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf to net
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com, 
	eddyz87@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 04/08, Jakub Kicinski wrote:
> The test_offload.py test fits in networking and bpf equally
> well. We started adding more Python tests in networking
> and some of the code in test_offload.py can be reused,
> so move it to networking. Looks like it bit rotted over
> time and some fixes are needed.
> 
> Admittedly more code could be extracted but I only had
> the time for a minor cleanup :(

Acked-by: Stanislav Fomichev <sdf@google.com>

Far too often I've seen this test broken because it's not in the CI :-(
Hope you can put it in the netdev one so we get a better signal.

