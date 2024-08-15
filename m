Return-Path: <bpf+bounces-37325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6021953D39
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915CD287BF7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D558F1547F0;
	Thu, 15 Aug 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVtOXX6V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2F154456
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760074; cv=none; b=mzAMvDvn4ePk2ICAv7gUpk0MzYXsNjSsX6iEHIr6iBHYXR2KVJCdJYNChw4wZke0BWAFFqT1kGSo4Q7FJFimMxpkYdfXyvq38HKsZ5gIa2g8kd46P1ykydO6VS2olnd0u4BRsAB+/xevCDivL7YkRTGFj4vMvi0e/iRM+J0METw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760074; c=relaxed/simple;
	bh=2tARasGGxj1OD8wKavVyQ0eyz9W+KvLa7uHWaRyVI/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOLrif2S5HJpXF9CUAujKQBEtAhosvNk1Zs2Ge4kC6/vZGwo1Q8Mb/VOgr0TCfABHEnvxkhgTHlJB4g7wLdEnXGEa72oEpMPIq0x7jkHNM51en/ZgPPVtYyL2dH6FUJJbVraLCdNEuP6MT0tUR6lpBEb2mVpUiZC/6eKlKxjd+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVtOXX6V; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3e46ba5bcso165509a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760072; x=1724364872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2tARasGGxj1OD8wKavVyQ0eyz9W+KvLa7uHWaRyVI/o=;
        b=LVtOXX6VC9cBzv0Q8uYEKFOYdyvzpZlGsOxQ+OAap70nB+rulUas75OJw75IkkUFMA
         LA6XtnBgCTLZdxhuVjiTTaue0mxiUNrz2UuMuHMYZ/tk+WuJxg4YbVbeZR5apwavy82i
         y9xBRaJxAo5mewjH1EOmVeDL2llRp2ZWXMbmXDJPQAVnJwoDI3OSR4g+d5E8fbQX+eDd
         mNfYpEpfzfjPpECLIWDv8029SH2Qkapz3Y8c8eLzYfYnt0GYWuweCvy8lSeq06cYT/X7
         kj6r/oJyTaIDMH5GW9jM/AnTsbNegQld/cy29laHrjodqzxbvZrzRR/3Dkv7I4Y1W7CL
         Jbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760072; x=1724364872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tARasGGxj1OD8wKavVyQ0eyz9W+KvLa7uHWaRyVI/o=;
        b=ScNAHJiYr+oXnHACcM/MLCY4ap2MFNZsEJihu5mu38B/aEMjg483TJzucDKvs6Rr1S
         VZQhVwegrVFxF/Eh2yONLtwV04xoCX9JaC8SDgZB1eFNw3acKvPrNOnWCCBtIWlxQqTE
         xdItKLJTOtVAuJGgFbJDmCGTixcniG+ALirZNfiRInZ3mGRahWnhGdF3feok5dTdKocD
         O8fCLoxgEfUAyByDJwWMt1G1LyGz0t/UAz5P53AlZ/iq8v2MM4tnPdFWYVTTmyXHZVt+
         oZ85FQ7EQEm43ziCdTny+OWcAuYKAZ0sgtFvFUWvVIH4RcTmI1zuOJzb/o9ClNY/mc33
         c/8Q==
X-Gm-Message-State: AOJu0YzwfhqtRStMpLNeSsQBVGN0eZcDwjCY6C2yS3jD5lwQLlWSr+Rn
	oR0T/zHZFwnWJcPn/Tp+0ag3rDVisqD7/PYRd4o8na5sU5J1vDf1
X-Google-Smtp-Source: AGHT+IFcGu8aE/dxZgv7uPnpDUh3TdWbybKAzC7VmCgec3NVpN4CjipjFwVL8YiQ/CG26lx/oNGIsw==
X-Received: by 2002:a17:90b:814:b0:2c9:5c7c:815d with SMTP id 98e67ed59e1d1-2d3dfc8918dmr1232250a91.22.1723760072499;
        Thu, 15 Aug 2024 15:14:32 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b65a4asm332141a91.11.2024.08.15.15.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:14:32 -0700 (PDT)
Message-ID: <79cdae55d4bbe2c9543e9811997251d80e0d6ace.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: mark bpf_cast_to_kern_ctx and
 bpf_rdonly_cast as KF_NOCSR
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Thu, 15 Aug 2024 15:14:27 -0700
In-Reply-To: <CAEf4BzZp-sqfL-r1GfsODO_Hm7QEO+gu-dNMnFN+_+=66RZCeg@mail.gmail.com>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
	 <20240812234356.2089263-3-eddyz87@gmail.com>
	 <CAEf4BzZDvYEB-qF75vpMbbYLN9rFiTegBsxBXvMxq-UsbANRaQ@mail.gmail.com>
	 <444747beeb37eed1b173bb2fcb9077eaf543e50f.camel@gmail.com>
	 <CAEf4BzZp-sqfL-r1GfsODO_Hm7QEO+gu-dNMnFN+_+=66RZCeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 15:12 -0700, Andrii Nakryiko wrote:

[...]

> > Here is a pull request for LLVM that lands the feature under
> > the new bpf_fastcall name: https://github.com/llvm/llvm-project/pull/10=
1228
> > I hope that it would be approved today or tomorrow (more like tomorrow)=
.
> >=20
> > Kernel side uses NOCSR in all places.
> > I can add a first patch to the series, renaming all NOCSR to bpf_fastca=
ll,
> > now that it looks like llvm upstream won't object the name.
>=20
> Yep, I'd do that. Let's keep terminology consistent throughout.

Ok, will do, thank you.

> I assume you'll also eventually follow up with bpf_helpers_defs.h
> (there is a script that generates it) change to add that bpf_fastcall
> attribute for select helpers, right?

Good point.


