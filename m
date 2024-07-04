Return-Path: <bpf+bounces-33901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496A927B48
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40CF283B07
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA81B3738;
	Thu,  4 Jul 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4wAfQ7k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E91B373B
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111162; cv=none; b=Zduxal00eigOjG1GerZL4s1LupTTblVJzTc5r4t6/g7xpA3b4LKkB+0MZn/NFQRB6LjVfhQsaYVUKnOHSGqGJYT2nR6S1HgtAXSVMOaI6KGn704JFk0hZ7NgCYGSwLEVRqrDCszBNEjMHzzH5++ZR1jqIXT2haXIjceTpQtxsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111162; c=relaxed/simple;
	bh=rtIpW/5RA9cSnfghrN4/ocBZsfdfSJSLzhg/tnsBBEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cawd9aOTijip9v9+jMMdde1kslrxtxP4S4ASdpcc5PIsjwe5m+oswqChURWnZEKsXqFnXE3NEYpslcEzFP/mCvLtlJ6VfW4R98JIk2tn6nLhFrjATUhuCjeK3qA75CGfSnnTsL+h9zcmDOOYMsuxCu+zhrvJWOfZUk5129XvD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4wAfQ7k; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7067108f2cdso595384b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720111161; x=1720715961; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rtIpW/5RA9cSnfghrN4/ocBZsfdfSJSLzhg/tnsBBEA=;
        b=R4wAfQ7k6Xg9llfhYyFu9VCBU8nwO9uKug+CcMBv8WrzoJWIXqed0Lq9S0p5UX7HXh
         D4uUax6/T3yLaVOtQ4t7PsPpVsr8CQRK7MJyF7NFDVcwLTz7RKpBjqax8zyOpUQlO2qa
         u/dXegqPvOP6/bnw4nfKKiJON1VILDQmLinyurUIwdvPSdZ1lV4b3LoZmfjRhGFFzcHK
         lANBH+YQY114w43Uj/R6+fY8XC9zEapjkZXuswKFq/esTyRHEcaTe9U4DeXdqgpmxxSf
         A1xqSTNHqjMQdtqHQN4z2nClMA/urc4XwyUGOk/Wfj5z0PvZzknRhBpFapYUv5VfOzwM
         daag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720111161; x=1720715961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtIpW/5RA9cSnfghrN4/ocBZsfdfSJSLzhg/tnsBBEA=;
        b=X1kBn1Myuv0FQIwTR2E0T+F9CtRTwMIq6rqAVKumkS4W/21EkaE+WOsz/s/vQn8uxX
         VUAHPM5GsDVGiYVkNqIuqZzYJijLbLCdqd2Rq4dzc/TSZa/FA8++mxBsE9kadTCASNKF
         GwULMmEjbSHwVrsK0prlmZBU6vLnilOGQczD0rDUl3N68JFQAz14uuYj9Yknygoiq7ya
         ZvmZyVHqNfnP7ER8GiPyhwheiJ3ssqOpsT1Up6HySEcmB+ToTuCaPMalouI92OobaIUi
         f4fqj2JGa4hBaO4BFTLan98+mH7q3blx3c8JloZ+nQlpUzcyZ6IdMDEu5QMwr2nEGcWJ
         32TA==
X-Gm-Message-State: AOJu0YxcBaJZVG0TMaLp8kSL8FRqW6igj6MzaE9fByx5dL1rlegXvXCt
	1Nmfyhy6kulXvxHuwIWMv6dGlsVpSwCTbZHn8n7vWs8wHzDovSvz
X-Google-Smtp-Source: AGHT+IEPG9zFnwCt86p73eZvp4zIaoIeH7DY198qJtf3NyCYXjxKv/yVntRBswPuxb2w0y7rDuAJ3w==
X-Received: by 2002:a05:6a00:3a13:b0:70a:ffc7:f921 with SMTP id d2e1a72fcca58-70b00aabfc8mr2412446b3a.22.1720111160716;
        Thu, 04 Jul 2024 09:39:20 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246f656sm12406525b3a.65.2024.07.04.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 09:39:20 -0700 (PDT)
Message-ID: <bbada62650812ad0c015af5cc513f8108369adec.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Thu, 04 Jul 2024 09:39:15 -0700
In-Reply-To: <mb61ptth5be13.fsf@kernel.org>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-4-eddyz87@gmail.com>
	 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
	 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
	 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
	 <mb61ped8ak95g.fsf@kernel.org>
	 <f9f7326c570b6163279a991d71ed0a354ef6f80e.camel@gmail.com>
	 <mb61ptth5be13.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 11:19 +0000, Puranjay Mohan wrote:

[...]

> And when we JIT the 'BPF_JMP | BPF_CALL' we add a mov instruction at the
> end to move A0 to A5 on risc-v and R0 to R7 on arm64.
>=20
> But when inlining the call we can directly put the result in A5 or R7.=
=20

Oh, I see that additional move, thank you for explaining!

Best regards,
Eduard

