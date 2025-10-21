Return-Path: <bpf+bounces-71585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBACBF7885
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF8D5024C4
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389D8342CA2;
	Tue, 21 Oct 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPdf5EBr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAD946A
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062271; cv=none; b=SeTrTW3G2qF48hn60/cEHLH1mtiFFsaAUliQ+hLPB2BaxIrQKqCUUzMbu1gxelIVgZvCPRHPhP3fiQQ9QQz0xwbAkowLvR2VYmyJDq7oS+TRBVhqFphDKu925MQt8Jb84tfkS/bIYBNpGCtDz4vTJ2omMPP39NKnHYCrA8UPAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062271; c=relaxed/simple;
	bh=Z/1v14ONw8upvjPlG+HxTxWPgwSB262WBk6X08dAu7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoqzpHngwxALkNAm5KNZ0RbYrkJ9t0kPQHRSLHnA1G2nSueafuRw+4R5RKY9mYyVZklDTtup/FqgMgn/iBkBKYbUSoDb3VFllBeMrJOFdikUGPow+3yF6a/CDzA6IUGqoJQnNxR4qmxOwmpA51vDEZtHOEJjiZkyJN9p5jN5HFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPdf5EBr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b57bf560703so4095649a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062270; x=1761667070; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/1v14ONw8upvjPlG+HxTxWPgwSB262WBk6X08dAu7w=;
        b=mPdf5EBrUvWOeXPNFd66GJnMEzEmnOeFfmjuAue0bwrFqgaMLzrDqZjhrtrdETgVqq
         FYNed/jN+rzXiLrsARpmm5eGvJhiX23am5HbW8WcGWuP3lo9ww0I/y77N0aq8rTZV/9O
         GcGk81C8FfqGMVYCr5k6XoQJONgxK6eYXEGuKp1pG+fzWAv47JKW4DxO4IcAobYFCa+m
         AKVoR84coBb4Pj6pPedyUFQNKZPKmrOFwsxn4DJkX/99JhUTNLncHp+nENesw2/VVxkS
         703sLnt8MmZAmODoSlT7ItNUIVWsP2mmTlonhNPceHKGU2cotHzl6cUzDhRpBdTEw6ls
         0aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062270; x=1761667070;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/1v14ONw8upvjPlG+HxTxWPgwSB262WBk6X08dAu7w=;
        b=GoWzr2lOuturOyWV5sTy704+e0tfi3lEdfwECSPZ79ALWGXQg3YyTggJb+d7bETVsZ
         A3t2yOfqQG/jull9Mh6SmrdXjeevwKkR1+MqWCiTelKHRlHwk/hPxaSNZs0CfyqReLdY
         YY5CNn1dgOT1XOktFBWFFOhVPXL/na9vSx/6xSNV08fQA9a5ShUx1dNdOvn2cpOCmC9u
         DolziCnGWKWN+NHGFKMDmlo1PMlts1xqn86UJvQoaOxf+Yj4UDrUMPu8SFB1PY/ZFVAd
         ItfhGWuc3au1MHSIrbu3EoNqJEoz1vsKHqyv0i0A2xk5GY1/oH0eUMhFhK/1grTujuFZ
         pdjA==
X-Forwarded-Encrypted: i=1; AJvYcCVzIhOkKJRFGTuKSQlkCxpW3g/kdUaSgwAnnPZLvJDuyIQFgcRxuPHrYvophHB7ou2yFBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIlhhpmNU3l7BzTdglTeOO3z1qc6veLhqy2n/By5DN/ZXRgfR3
	cKH+iyMUOITAzMPuJq0Ud8gF15rvVE5Yb5+mG7Q70BemRALB41zebLPC
X-Gm-Gg: ASbGncsLW0W5PYsaseD231zMf1GJQLZgJmZg57tSWIHJg6F9TOf77GASoDxHzKjCks3
	mQy6FgHQiMGivRcy/hhReRYeWLB/uVhBRJ4B5nYCPdnESMBNE1JpyGLXCyBZzh4Tv5CgGxAAgP+
	H6JtOLKKPvfmkppEXYQp8xySKIWjrzc4y3s4ySWr2Da8xyiA3glcrsnEEm4ogCC/L472/iQ6jlG
	hKsKpzzz+kMhiVKHHormRMk1IGWa2wpQhgg8/tAZsNzk20mB2OQ+NGnf7DGguPYzmQUZ/2Ah+Ss
	dVqV8Yp2LC+jmdtpAEQov651vfi4aVP8+BG5Y+Vv355RzpABHo/5xct6HDRHkBXcwfu8caYrqVj
	WchUYjkkdTnjMoxTPNWWuPts9goPRdOy0LVlwwFbMRoKGBg48H9auDdS54+gREWxgrZ/k1+7IsN
	tOKfgPPTbRw42uVigeZxIN85FWUs3QZxSN9SL6
X-Google-Smtp-Source: AGHT+IFXBM54S/3IPHg/YLriqEWWdSNp+qID7b3KPyfagGS3obpL3xkYxPk+L7+SiGexSO69U2KtUw==
X-Received: by 2002:a17:903:244e:b0:290:56e7:8ca9 with SMTP id d9443c01a7336-290ccaba092mr197957345ad.52.1761062269488;
        Tue, 21 Oct 2025 08:57:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5f45:f3d3:dde4:d0ab? ([2620:10d:c090:500::6:82c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffef8esm112694575ad.51.2025.10.21.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:57:49 -0700 (PDT)
Message-ID: <e2716ad9963403dd0dea37c85d106267659e52bd.camel@gmail.com>
Subject: Re: [PATCH v3 bpf] bpf: liveness: clarify get_outer_instance()
 handling in propagate_to_outer_instance()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list	
 <linux-kernel@vger.kernel.org>
Date: Tue, 21 Oct 2025 08:57:47 -0700
In-Reply-To: <20251021080849.860072-1-shardulsb08@gmail.com>
References: <20251021080849.860072-1-shardulsb08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 13:38 +0530, Shardul Bankar wrote:
> propagate_to_outer_instance() calls get_outer_instance() and uses the
> returned pointer to reset and commit stack write marks. Under normal
> conditions, update_instance() guarantees that an outer instance exists,
> so get_outer_instance() cannot return an ERR_PTR.
>=20
> However, explicitly checking for IS_ERR(outer_instance) makes this code
> more robust and self-documenting. It reduces cognitive load when reading
> the control flow and silences potential false-positive reports from
> static analysis or automated tooling.
>=20
> No functional change intended.
>=20
> Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches=
/bpf/pull/10006#issuecomment-3409419240)
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

