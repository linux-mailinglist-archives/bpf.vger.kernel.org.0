Return-Path: <bpf+bounces-43075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FB9AEE88
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F190282D4F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91261FF608;
	Thu, 24 Oct 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emb5ApYV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C41FDFBB
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792059; cv=none; b=aEPKoVcxTFFfLjgwCkZLEQBrgSD7JpT8oYZo365TdU3ZyC06rnt7+QnNH5BBNULATP7aDwEtvHl4ShTuZw+MHql3GjNl479yYishd/nv6joXIjArI29ukVJM5P6cejknd+pY136gNlOiGLZX+RE/qJfwdrqTwrJM2u8dKUqrpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792059; c=relaxed/simple;
	bh=oNIKAyMNROofqlrAduAhoS3ueuZN7ul/hbLPGBoIC0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJpNf168eBHofSZn4YWeiBo4RnbpcGNSrNMNBaZHXxHjr7ZU8G8V2muT5lIFsFgZkU2pPmIpEmdBeGmVblFcT2OcxVUchgsCzBjxO/lHZbWRMT+Uu3YTsfkL0d4B9sYORc/ZPmpMQLyVW2iyup9NBD57QNlkGjl3HTtzaKs80go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emb5ApYV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so916632a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729792057; x=1730396857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aA64pV+k6mbqWy+MFhjBvAdlSAJgLlGVCvxqUyWyAjo=;
        b=emb5ApYVEyHzFM4/AoeYfAWacEPyg89qUhQlrsVo09FbKQarQCbj33t0iXdEh4M7Pm
         lKlcmKaaXNqhm6jzwsypwysKjedLsUwNuDy/NMTY1D6O4jl+UpHCvEFKuSwaB2Xb1Ouc
         4op06HwCP4pptOoDkONj6RAtElM9YHVPVVjEuY1VQXmqnoyeAJf0q9IFS9tio5acZMb6
         PzmT7Cj8ZqniZ+Q97mqHEF00lbWMZ1xSHq5a7X9ILs6btqal7gYv5MYF8nfkS+dLJY8r
         UWxf5IWUILOiOJj0TVPHSZLpp4S4cQGr1Mqyy2O/irvstZxfN8r0o/ASBu71lpP2MUlM
         /YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792057; x=1730396857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aA64pV+k6mbqWy+MFhjBvAdlSAJgLlGVCvxqUyWyAjo=;
        b=S8O6W2ZPKbZhtk7RhZaWQg6/LOeda49B0+00RNQdRz4ptIvzahR68XKcxPHsvcvN8S
         f/qDn4fCBv0DCueieSPmDXd69doaQxFutfQzcnUPRnFzFF64liRlLAy6gzuR6uf56zMq
         IRsmOOUhPUC0IM5pgFAc3CEZBaxQwHKJEw/AEmCW5Ggb1URi9T/QUVK2rz+SX7Zuy7cr
         F4Mdv8eJCmewKrYrffE2/TGM2hYZ/EXooMKBe2xcwRvPPu46hUlTFwi31ZeX9vVJJMaA
         80SKKylp2fxdqpFc8xIIWYsCiWXtE2uePvZ/07K+3Q0tBcKkv51KGNqhhGz8LyHk2LgJ
         7BGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0KqTgCSW3kHZd7+NDvg8LFBUrmuEDSM6rdtWJBy8bUhIcfQmMGebiKgGaShvhehr0fJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRKPw6AgQPwHYZCYIZyKDbTEH5wWAjh6ikk+BrRCcOaRsM4Wl
	5f/+wochlDgrP/Utlvrx2XFvxpwpOsj+fdXS/ZNTMtPtTf0U5ly8
X-Google-Smtp-Source: AGHT+IG7ZIB+r8aWVdQuGBeF+Pvi8VxuPMR3NfSYkYaD0fqrCpXy+k1vG1a9NXWoPobWd419wrVQEg==
X-Received: by 2002:a05:6a20:d8a:b0:1d8:fd01:52b7 with SMTP id adf61e73a8af0-1d978ad7a8fmr7599960637.2.1729792056946;
        Thu, 24 Oct 2024 10:47:36 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407d8dsm8258335b3a.186.2024.10.24.10.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:47:36 -0700 (PDT)
Message-ID: <41a5ac3dfd72712be027250d20780342265d79ce.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, bpf
 <bpf@vger.kernel.org>
Date: Thu, 24 Oct 2024 10:47:31 -0700
In-Reply-To: <b83c12777cd1980c16da363097aeb8ef6a1def91.camel@gmail.com>
References: <20241023210437.2266063-1-vadfed@meta.com>
	 <CAADnVQ+YRj2_wWYkT20yo+5+G5B11d3NCZ8TBuCKJz+SJo37iw@mail.gmail.com>
	 <4d7f00e6-8fab-4274-8121-620820b99f02@linux.dev>
	 <b83c12777cd1980c16da363097aeb8ef6a1def91.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 10:31 -0700, Eduard Zingerman wrote:

[...]

>     ... r10 - 8 is not used ...

I mean r10 - 256.

[...]


