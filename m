Return-Path: <bpf+bounces-41446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C21019970FE
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA9B2601C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D01E1A02;
	Wed,  9 Oct 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbKaRvlm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F1198A0D;
	Wed,  9 Oct 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489591; cv=none; b=FnGmQ4lwYUf6RRJXQSR+jm5fNNunMna++Fr+eLt8DLkhSBxjQi6nKnSgyAs9g0PUOxhEvGJqyxsE2AQB940TrSnfXTywhmOY0x3Mv/JJsdpDValvZsFJY03+qe2W9bZ4Ib1cXVMzGT3TuLnSOyj76ZKoZOoJBdbFuXOGirHjur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489591; c=relaxed/simple;
	bh=eGrBxLAv/6USjW9w4nMdGF/MjQAK6v7LnXqEaw4yiJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLiOv3+bYjpHLpDI1Gzd1Wzv9N6Ip0MEkXrbcuV2wb4B5qDvxqL9k0icm+7HACWUNpYTkj/1L7dSPJiuWvYbbHOKOtGlutBxOcQmjVE8JJRlPphzCcE/v3ahWB809fXcIDUC8aBggkxygPdwrgyy/IxXajO4Z/rLFtgB2HuDzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbKaRvlm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398939d29eso8715326e87.0;
        Wed, 09 Oct 2024 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728489588; x=1729094388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGrBxLAv/6USjW9w4nMdGF/MjQAK6v7LnXqEaw4yiJA=;
        b=mbKaRvlmAPK8hHOdcEORvalGMLGUbkgi8QEzvM6NhYpSsIojW75feW/A5PuRZfOiEP
         uUHgGkkTo7LHyl+j5GSA//f6SRnpw8q1s5gnyoydff7htrbMZ5wdcDLxtg1zLoR/1CIi
         zlDqjvrsZfrWOmrrP+lxDr9kMTZXhP/hJwqzeIOFOBktRBYfgjnMssJrb7e7oJzk5J2C
         9Ey0fm89vroJ0nxflZf+1HSQhuH9iOCceyYCdu5TpynoFKDdmClHWlP/leo/MPDHDwGe
         iGLCC3ZLcs2KD7hSPoXLsXKgoz8ijUpPVWGvPKU7mU0kzZPpXFvX2No4C08M17bkqFUz
         suWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489588; x=1729094388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGrBxLAv/6USjW9w4nMdGF/MjQAK6v7LnXqEaw4yiJA=;
        b=sNbauad7rgo8BfNV5WlXrc7Kz/KzmktAuiNNq6QqCCFnMjBsWycaGAzgq3QzDZBDD0
         cIwHXMk2ClTpYf6HEoCgv16IuBS3HNVv+iU/H7kEhjNybIWjQWD7myG2MHqhq5D0s1OY
         Ab4bO3WJvJzrC+eG7ZPFDBNqAlcASlvs4mQ38aGKShaqXz+GOuBFsThqF75XX7Z13QIY
         fWWzYx2X5FnJ+H48Z4ufRBkQcxyRVf9SUk6wSoqUU9mKm/dDPazn6Zp3xzWcreWxEoST
         QdakkFgMm/oaBJ+ToaVDJXCPT64Xoh24Gk/NeRslvJMEOyV+2X7rbns0t0bazxfaUu1G
         OVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8xqF9uAjWsafG7RqL7smnqXFBQieIKqRvYDBkXM2GUnaJQkh6vcyQzfmTUr+HnVSKtME=@vger.kernel.org, AJvYcCWfttYE27yu2f1gDr11DnjI5gOmJayfl0zToM/U9jiaBr9RC4ueLoS9MdGPwicTo/7DYQuY5O9/b8Pueuy0PnDJllIDNS6L@vger.kernel.org, AJvYcCXEF9xT30hpQBxWlb4tghJTvvornrzGaC6Q4EPiPYSJi2a+462jzIaVXcx6ReY/D8Mo2wMgA6gEcKPGGDOK@vger.kernel.org, AJvYcCXTa5LHcYE7MxJXNRAGd+/0milP1fGSgiJiaTgBsLWmXl+D2KJxCBUgOOjhP1MiKto1+NzZ/FxVqZGwOqmXrpwb@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtxEmlaalb+xY+/LC+E9oAdA5D+rT8Inulqc54hyanr1us2Mu
	yl5CuYCTT3DKS25qz67wu2YJ4eeKzUtVKTiUDEB6kB/ptGRKaV8/fimzHHMW6tds6qPEpTC4fhI
	t3TCmhRAYFM/DOfbiT6iz8AsAKMo=
X-Google-Smtp-Source: AGHT+IHP/8XluQFC3uXV9SsZer9jUGe2yRlZngkkLRqD7kJGsD1FSIjxYG1KZ//9kilvXFDEnxa7Bopxwip+fMb0JKo=
X-Received: by 2002:a05:6512:b1d:b0:52c:cc2e:1c45 with SMTP id
 2adb3069b0e04-539c9279498mr561144e87.15.1728489588190; Wed, 09 Oct 2024
 08:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Wed, 9 Oct 2024 23:59:35 +0800
Message-ID: <CAHQche-W2VxB+EJQRHUAWr4=850sX1ZfzzZUFJChUx8j6dW9Hw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

> Finally, expand the critical region in process_measurement() guarded by
> iint->mutex up to where the inode was locked, use only one iint lock in
> __ima_inode_hash(), since the mutex is now in the inode security blob, and
> replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().

I am not familiar with this, so the following statement may be inaccurate:

I suspect that modifying the `i_flags` field through
`inode->i_flags |= S_IMA;` in `ima_inode_get` may cause a
race, as this patch removes the write lock for inodes in
process_measurement().

For example, swapon() adds the S_SWAPFILE tag under inode write lock's
protection.

Perhaps this initialization tag(`S_IMA`) can also be moved into inode's
security blob.

