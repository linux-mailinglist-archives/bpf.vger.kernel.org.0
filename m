Return-Path: <bpf+bounces-29887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F018C7F11
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732041F22A6A
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B139652;
	Fri, 17 May 2024 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX9Uo8jp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C6621
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715904125; cv=none; b=RCMO8Ord5DuLIT3gPShAxnG9yNFAnyV0AYhp94rU9N7H2lAUslt1jElaUyU7CGYxUeyzzGBKR95/xVKeAkIIt6/daHwLIKF/eVi27kGPvm7Uts2PF6uh6Pa3Nhd42VXtk4L6HL5JCADaVp9mTuw7zMG3WACmxcfrj3kiVIFdm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715904125; c=relaxed/simple;
	bh=Y9t9gWBNsxMRV8RbvpUyrmpyR5+aYzwW8WD2rBlLOwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPkYnl2+/0d/GM7ogxvHGS/q7KAFGviHqbdJjsT3tQHN5LdWpBOV+/tsr16yV+ZmzxFCnbdC9nYouAOOBTGftRsTCECosVfUNF1N2q4gBKAyU5XJt1YgcGpwhw/Rr0rgua6Uk2GzSPcsvx5o7/2yQUHx1pRYM9WmkkFRQ6gkLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX9Uo8jp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b239b5fedaso676734a91.0
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715904123; x=1716508923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9t9gWBNsxMRV8RbvpUyrmpyR5+aYzwW8WD2rBlLOwE=;
        b=CX9Uo8jpDf0KDXX2mPvi/AO5GehgTQGj7K3KogselBL0sqzBIqeKgywgbPc6N5vX91
         a84yNhTmYCvh6Mnn+Iz3u5qA9B5dBWMyzeQ2PmouZcMC1U7Evs11Npi6JMK1gID0Wmic
         rNlyFYY323YlnyD3Nfo7/FTWgq7dZdBroiYaQSRqwSMdnwA7aHIMUl6g63MoIRulzJey
         AKxV+1qYqIEl+T/5OL13prEYEArgsIZhjX7X5zHmY74m7bbC6Lh+1VQYiyCoaXBs9HIn
         Svc9L1KBog81C1F495fiDjOtni2yrGzNLqmUx6CczbD16/cfu6ONQ7k67fGSvr+0rS5P
         zRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715904123; x=1716508923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9t9gWBNsxMRV8RbvpUyrmpyR5+aYzwW8WD2rBlLOwE=;
        b=LbIPBuE+DGLFewT2IfS8ybAgL3cYcGvLqLWDSwO0bQYrJcOKnKPwswsWdTT2m9ZGdQ
         VR97PF/C2E+kPLt4q+6siO0sxWr0UZMDZxZvGIPk85KUxbiU/kQ8HuESBPf3a7nMU/Gk
         Jpqe/vySqCZl78JcvdV9wI+ENnqB4b6/PIVJ2M8V86pD+lsl2xDGy5OIZuisfUi9SmTY
         PyMN4e7fMLYJMpFjG3xIFWW9uwSw/B+I2P/OjUuCFKHZSN/SIh6aZJ+JNz2mVysOkGvW
         4I+DCQ+bpIA8500LJ1WGtl1kFcD4Y9tsL83zoqmzbD7UN7/cEJ3Bis8unt21PfReeSrW
         +lmg==
X-Gm-Message-State: AOJu0YwM1QFia1WwIWLvFVx0o5n8K5dXe5gwrpA46z57YgGkPfoOyrgy
	X8M/2jUtqJBlG4BTDRP+s5ySB88aeYubOS5OSKfaGWBQiqeTi/nfMXleKA==
X-Google-Smtp-Source: AGHT+IHS6QENrAnijALMuYIAOzO80w+Jo3Np+scrPG8hTa/Nukfzgd+uPiBhhDXTqaHZ81sMbVtJ2Q==
X-Received: by 2002:a17:90b:386:b0:2ae:c590:b06f with SMTP id 98e67ed59e1d1-2b6cc758fc1mr16939407a91.18.1715904123373;
        Thu, 16 May 2024 17:02:03 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6ae7sm16160680a91.51.2024.05.16.17.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 17:02:02 -0700 (PDT)
Message-ID: <15424756c16cb1ace48c1b8de6d99074e31d859c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/3] API to access btf_dump emit queue and
 print single type
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com, 
	alan.maguire@oracle.com
Date: Thu, 16 May 2024 17:02:02 -0700
In-Reply-To: <20240516230443.3436233-1-eddyz87@gmail.com>
References: <20240516230443.3436233-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-16 at 16:04 -0700, Eduard Zingerman wrote:
> This is a follow-up to the following discussion:
> https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.c=
om/
>=20
> As suggested by Andrii, this series adds several API functions to
> allow more flexibility with btf dump:
> - a function to add a type and all its dependencies to the emit queue;
> - functions to provide access to the emit queue owned by btf_dump object;
> - a function to print a given type (skipping any dependencies).

The series fails on the CI despite passing local testing,
I'll submit v2 when ready.

[...]

