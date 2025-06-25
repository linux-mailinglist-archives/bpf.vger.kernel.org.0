Return-Path: <bpf+bounces-61555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA32AE8BC9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE281898430
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83372D540D;
	Wed, 25 Jun 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+72Ipsk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002C29E0E7
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874105; cv=none; b=MGusjbewVRWtLYS+15HVCTGSg2/8p7xPR5Y0ZCz9cjIZZQd7or+pLKnEcFRVhCqwrWWaHkUHmOClhn8JGGNXkV5yU+LanxfF2WS0r3fbvJttiZLM9uMNmvTxunUmBsMPuumBfCGMS31k+W4lF2jl4hmMoNUJIBSFjhzN/XDXwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874105; c=relaxed/simple;
	bh=hHkpVhmMeoifahoC/2nqGjvV7ikI92Gc9HMJwpFdpU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oiOukP1Abl1KQE2MSMCv3kgN0Qwgf6BRGjSSN6MIDqIrPeZJ5kcMTFnEqWUYal+E57TJtxXLmrDIX1kut34Bmo119tJ6YoxDP9iFXzztt/gBzLAIlKkRFY2U+b1iD59oNi+zvsb9cgDt/qtrstVQjmwxgBTtRCaEFK7O6Fy+lrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+72Ipsk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234c5b57557so1921465ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750874103; x=1751478903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHkpVhmMeoifahoC/2nqGjvV7ikI92Gc9HMJwpFdpU0=;
        b=D+72Ipsk/flUyOx7+rapcfL9BaUJYqPn0dk4/z5O5qoAwWcIU3fbh6IDRTNoH8F3yE
         XpPOVEDD2/Xhj86WVS/nVCYdgtCC+NI9dkxmHyHihi1KVimMIzi606iPmRvmyKhe27jH
         i0WsAmkEt66QEZctA4giQB0W0JHZcvN3Cx+/oXBe6eAIayX2cc0aNYZOzX0/kHB0tKU2
         CYdkrLRcQBu+YlxgXBkcTXfUKrmKWknKX6ms/eoQG/C1LG/aQKj4hEINV6USYh4M4lHL
         /twCWNV3AjkfeedHWYXj+I4p36DoNhLlHgxaz/CqnQz2j7U97OwFA0+6ZbdqUca2ZaNV
         axyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750874103; x=1751478903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHkpVhmMeoifahoC/2nqGjvV7ikI92Gc9HMJwpFdpU0=;
        b=a/KRFWWoB4eUgWUy/mgcJNDU0ZOB9f9VD1okXM4O+DgW/JUhKqM687BuQXVsf6TVjA
         MSMYq+DtGeJ8RKLFXhMpkSLIAQHjKguupxJN7y6UZCJK4UTsl02OkdPXiP9kG7IuqkgV
         mJscvbsryCUFG1A+wUDzw4DclLNlxalmMr6+ag7iBRuhBaMN6qZfknT7ecMD/JJvae2y
         ys83Rkt6G9xUVrgXdzCaXmoP7XXU3IRaU9KMFl8izjZUYv1f90OpfKpm6WIQGYtYZUgJ
         uQMZBxYatgGGGCErrNbxaaM75LBrr3N4NCf6Z8ChBzyFy7cnWjcgfQ/jRdFrhM89YiEN
         MEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcvz4bGmBejD3xAIsn4MrjvjHox8Wg//8Sy8o3IDjUueZ2Jt4LQue3fkNyW7LXwRgYARg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13d63rdrUzDgaoSurZycmi2iFrPrlsOmf5QFRX/E7UUMnJaOf
	5koulE7AKEftUQLV+Q+fTZ2KVRS+oLg3IqVhpyemR3NYQQHIxpIybCdJ
X-Gm-Gg: ASbGncuxvZ1V7XH4mfjaUumvHL69x/q7bvbhzQjIqAKjKTmQBhHd95zlOuPqH6Y3V7/
	QA/W5Dwv4k1Iqi8qC/+LYiGGc8mGXM9Db4Mo/MgwBCMlvFsUXntpfo3ezAVY7XqWtfatMdnX4l/
	YCZkzqmQFolPutUPWTBTCu4UtoKHeKeluwTS/k0g9/Xjsz7DmdDaOHEt7EXfp4NLvURjkp5xZOM
	WfGXOC3l1uftajWsbHl2iKpxkRRCmyELUwqoCaxWuXG30K1mcvCny/q4l7hGPL5JXUgcarui0hR
	YeNjLPP1fBlPN8JU0DKJUMLdf/4pT7Q2DvzUyg2JLDhsZwAyu/d4IBV+1qFVkA2UkImf7OI+uyA
	ZOLnLT+Lz7Zo=
X-Google-Smtp-Source: AGHT+IHrvixLdMRD6LWs3zIe+Lx/kr+yByKIKxamYh/jjMr1EXibqWCdt1CC6Hc++AFqTtepZsH/OA==
X-Received: by 2002:a17:903:244d:b0:237:c8de:f289 with SMTP id d9443c01a7336-2382404744cmr72283965ad.36.1750874103103;
        Wed, 25 Jun 2025 10:55:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861061dsm135755595ad.118.2025.06.25.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 10:55:02 -0700 (PDT)
Message-ID: <df2004a6039c61e8efd05f9836cc00fdee32a458.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG
 range tracking logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Wed, 25 Jun 2025 10:55:01 -0700
In-Reply-To: <20250625164025.3310203-3-song@kernel.org>
References: <20250625164025.3310203-1-song@kernel.org>
	 <20250625164025.3310203-3-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 09:40 -0700, Song Liu wrote:
> BPF_REG now has range tracking logic. Add selftests for BPF_NEG.
> Specifically, return value of LSM hook lsm.s/socket_connect is used to
> show that the verifer tracks BPF_NEG(1) falls in the [-4095, 0] range;
> while BPF_NEG(100000) does not fall in that range.
>=20
> Signed-off-by: Song Liu <song@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

