Return-Path: <bpf+bounces-32588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABDF91020D
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B02B21D4B
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92A1AAE31;
	Thu, 20 Jun 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Vjf6h7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A715B0EE
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881373; cv=none; b=rraYUPysZoHwFBPvKUyx07U2AaiEGE6vCu9pkXxir1c/i9/S0rMsGQOoEcfWRaSpfB4pHGcSmuCWVbNRzsnd4PyN8onyHnJ82sMFWS7EtNAo7DC+LVRirdHEJ3vQAUhsRrAoko4VTPmWA+Mqcc133GRfwSYnbrMnLcCIdc8aNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881373; c=relaxed/simple;
	bh=F9KDvb6EVNhZdPmU0/KwmMDvsCGCLsonnaD646ok9fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnGS6GokXfVcJUve2RyJmkj5Aep3KRw8DZd1ndOFnuqdPcRXk6eHYlBC1qPMr/S024h8Rye+GaQZdWws+2sGFkpRHK8PY5KvM9CVFlsmj7O6G8zrEZgMvrvGnaVCrSt/HTlgrjCrEKuOzAC5uTACORgq35ibmPyYMsZkerlGE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1Vjf6h7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9c2847618so6258855ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718881371; x=1719486171; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F9KDvb6EVNhZdPmU0/KwmMDvsCGCLsonnaD646ok9fw=;
        b=f1Vjf6h7QK3xON925IwKjgFhIwBKb1lyVS8DRHCitJ7y+TF0WlViucRo7abP0d2HBf
         RYUoCxpA5Gv+lDU9NgBbmh0qZ5kiOMCCud9ktEVYxe2UC/HpdhDw0ugRFw+he5Rkg7Nq
         +wNLNYOM1SzF/LcS2p6xQTxwTNrtqo4OG2GRdqtoOHgA6hrQwdTAGl5tj4W2HQhlFiQf
         eL96JWVuva0O+yGIqfnJL60NyZymoHUhiIvaTArdbm6mgMw6DNXlzbRfVgqfh/6FV/k5
         GI1n6CGtBITboAVpGSTVahXdwkyvIBwCdbuHvlhszbfoViWnKMWEH5WVcXR5n7U/iGig
         K1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718881371; x=1719486171;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9KDvb6EVNhZdPmU0/KwmMDvsCGCLsonnaD646ok9fw=;
        b=k/nZuhFSt8dHEQQziTTl6VNHrui9Xdho+Z0epUdHl8hT9lW/toVokeqUNjk7458ivj
         aai0opIFm+XGvLbLav3yUsivewTDxWDKCrGypAqyL1GHdlsgI6VlA2qYES6H+7DD4HDH
         dcUYF40gnLDevLzcimsRTkxFBWTTeB8xb40lKCawYHpyji2zdKT8Y89ubB5lFUtJL2dY
         3chMJxfK4OiJPrNZCe0qIKNkQzQdy4ZGiVm+3P9gGAp9ghoab2PmD6gjX6Okn1QTCUPv
         rz21aiE4nk/iBrC5S4Dpc5/X50377HqGUPgslGhn1xO/zYfN+fDfOpALgyUyyaa7jec+
         UCPw==
X-Forwarded-Encrypted: i=1; AJvYcCUVZmh0SdaUBcVPaqUeJku9buvfwFZOne07qrEzZz5yO0ywEFjnV0joFdCF77gVKCdDwZGqz2M6v1BS6wzsdsGS8Ypg
X-Gm-Message-State: AOJu0YzKVhL20B3b5DQDjzQUAwl7CkYSbLsovJcf7AOLvQh4uI5KdF1V
	rMgGjCRCjoZAkiqI/K52zKM4JTLDQnEm3wNLwz5LzH4GEMtx0ukc
X-Google-Smtp-Source: AGHT+IGY9SlTzTXKCbX7/+ihc1QLqArdDBjQkn5B1MFTLd8PuntnyWIvOHZvQgtYPc+3FKAAXJ2k7Q==
X-Received: by 2002:a17:902:b70f:b0:1f7:1f4c:3f4e with SMTP id d9443c01a7336-1f9aa47cac3mr42493155ad.68.1718881371241;
        Thu, 20 Jun 2024 04:02:51 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9d983d9e2sm4766215ad.36.2024.06.20.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:02:50 -0700 (PDT)
Message-ID: <15ddc0d1b411d5e3dec867fc3f4df2bc14bb09d3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
  martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com,  mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, mykolal@fb.com,  thinker.li@gmail.com,
 bentiss@kernel.org, tanggeliang@kylinos.cn, bpf <bpf@vger.kernel.org>
Date: Thu, 20 Jun 2024 04:02:45 -0700
In-Reply-To: <fd9268b8-994b-4b4f-a4bb-d5852c823152@oracle.com>
References: <20240618160454.801527-1-alan.maguire@oracle.com>
	 <20240618160454.801527-6-alan.maguire@oracle.com>
	 <4321b99db5b362e278b1f37d6bd9b9a43d859d63.camel@gmail.com>
	 <76509fc5411e35a4820c333abca155b3fa4e5b84.camel@gmail.com>
	 <44779d5f-6d54-43cb-b556-d62201765c9d@oracle.com>
	 <3396181b67ff82ba8d25a620a72353989d733fc2.camel@gmail.com>
	 <9359e765-c341-4164-90fd-78feafed89d5@oracle.com>
	 <e17f8c4d644a6f4aa80de092ee29e6c1e5e77c52.camel@gmail.com>
	 <fd9268b8-994b-4b4f-a4bb-d5852c823152@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 10:17 +0100, Alan Maguire wrote:

[...]

> I explored this further. Even adding a separate skeleton with tracing
> prog to catch release is insufficient because the map free is deferred
> and the test can have already run by the time the deferred map free is
> called. Whatever mechanism we use to detect release would be subject to
> the timing of that it seems. This seems like a recipe for a flaky test
> and I'd rather not add sleeps etc so I've stuck with the current
> approach which exercises the dtor codepaths but doesn't verify release.
> Thanks!

Makes sense, thank you for taking a look.

