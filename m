Return-Path: <bpf+bounces-29048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD68BFAA3
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C6A285708
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB17F7ED;
	Wed,  8 May 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPjYn4lV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A397F7D3;
	Wed,  8 May 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162737; cv=none; b=EbOdsLuiv54xeS6lZCWZqcCUyZ/Hi+uc16Xgcdve8411qLbwHqHajJeYUYHipw9pmFSrihW+cRX+r5NGaMN2YqKCzuV7UN4J4uwQSVyrVnpNj5fIC1979/3jeZ0bq9KKfjF2CHg4t2gDO4YI3vIyK2UWZWHjMj2i1QxE2f0JYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162737; c=relaxed/simple;
	bh=69rPTkrrk+KDC8oVqGxQZvFlCJ9xKMO3lKevbhjOd14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ru/IpzmO3CcMhYb/fAkME60gFO+LKoVhFbePhxtgT5gD6QvLaeCEU2NsGFkVWoFQWM30T1N23S9sKuV+jcWkBmcKHOFOHIj07ZdBld9Euo8yizGdUe7Q716DmCpwsla971o6eiC1/CXpXJZQirsoS9NFNP22mmmkOEVIOVnHuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPjYn4lV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso3687775e9.1;
        Wed, 08 May 2024 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715162734; x=1715767534; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pfrqMs/oV1OywiwI/fbear8P048VZ1F1GZommjWhxc=;
        b=BPjYn4lVlmeT4GXv7BfwlwFa30+q8sl7UdTMtHUOzRpp00/GZdvdLfWq/4Jg3QbtU+
         +eW7rPw1z8EnCXVveQT4NPg2vRBBx+IkTaJMl1X99Lpc3Dd26I1SYAivkVTIW6PPC3ym
         fOra4IZOR0kvYeCF9uy3Q50CszcAXUBI5LPkBX5A0YMdcW9Nk1VGYBmcz8RTuZjBe8EA
         SCBd9Vmphd2VB7VWikICuol3ZmyFCyXrjH3o7uVWXbLuo2Fnc8OnB0Hk90E/OqasQvSh
         8NQTfEb2UnhQy0vgdN9SkcaK6Cki/eFs0aKjAT4G5OmVuUMfv4Y64Ca8fFoTJAkC9cBx
         nRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715162734; x=1715767534;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pfrqMs/oV1OywiwI/fbear8P048VZ1F1GZommjWhxc=;
        b=R/VRojhpp984VBUWk8dVzVNBxot3hJCm8Ua6pePHq+DXfBhCU81fCHbJsvbcjNsrzZ
         LwhQsWVw77NJPmbagXBhQk/6O2QRayoVGtBUQVSS06aI8+6qCyH5JKj1X9qcsQf30+kv
         EAozzHqJx3+1Mj6M9pUsohVvTkz7ldAs5L/QhpKjkrjWmZuV1oQ6HSxa+b+9NKoNTTCx
         O1dY6qi3YPNp4cxBwtASB+uq8x3NG4RmDK/nwmWTcpoxMSafF+eCAw+lqKnmR0CvHVuJ
         l0/dZOpO0ShgvZZZ/yOwh00mXonM5hrnA4p2BO7vlREI33EAgcD5itei6BrqwA3oT4DV
         VUhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvPaPhumbNpZ+mlRHBhhKXNLMtcKCuiw9y9xiULd278fnzxhSl6277R9ULAKsUsTyZbq7E7D33j0Jx2vpXB7y5FazZPf8s0SECcoCUh+amtBvgq2G9V87cIiEdT7dfoQGh
X-Gm-Message-State: AOJu0Yw6ZUQmBjGaw6D4/hjKVi4L5Gqi1bFNX2KEzxPlXwVpItqRzt34
	16mK3oIuSx7aGnVGIF+nBVyizJyMa416lNLaSgmb+t06f+xE+58S
X-Google-Smtp-Source: AGHT+IHbPK8B0S9D/N+c2TUnl34+0ibw3s7SFJOpj8TxqMbt0pndiEbMnr8WkwO+xCns/doklbqPyA==
X-Received: by 2002:a05:600c:35c3:b0:41b:4506:9fd with SMTP id 5b1f17b1804b1-41f71ad0be5mr20497925e9.6.1715162734173;
        Wed, 08 May 2024 03:05:34 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id z18-20020adff752000000b0034e19861891sm14923686wrp.33.2024.05.08.03.05.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2024 03:05:32 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Maxwell Bland <mbland@motorola.com>, "open list:BPF [GENERAL] (Safe
 Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mark
 Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, open
 list <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH bpf-next v3 0/3]  Support kCFI + BPF on arm64
In-Reply-To: <fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud>
References: <fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud>
Date: Wed, 08 May 2024 10:05:30 +0000
Message-ID: <mb61p34qs1uvp.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxwell Bland <mbland@motorola.com> writes:

Hi Maxwell,

> In preparation for the BPF summit, I took a look back on BPF-CFI patches
> to check the status and found that there had been no updates for around
> a month, so I went ahead and made the fixes suggested in v2.
>
> This patchset handles emitting proper CFI hashes during JIT, which
> can cause some of the selftests to fail, and handles removing the
> __nocfi tag from bpf_dispatch_*_func on ARM, meaning Clang CFI 
> checks will be generated:
>
> 0000000000fea1e8 <bpf_dispatcher_xdp_func>:
> paciasp
> stp     x29, x30, [sp, #-0x10]!
> mov     x29, sp
> + ldur    w16, [x2, #-0x4]                           
> + movk    w17, #0x1881                               
> + movk    w17, #0xd942, lsl #16                      
> + cmp     w16, w17                                
> + b.eq    0xffff8000810016a0 <bpf_dispatcher_xdp_func+0x24>
> + brk     #0x8222   
> blr     x2
> ldp     x29, x30, [sp], #0x10
> autiasp
> ret
>
> Where ^+ indicates the additional assembly.
>
> Credit goes to Puranjay Mohan entirely for this, I just did some fixes,
> hopefully that is OK.

Thanks for taking this effort forward.

checkpatch.pl complains about the patches like the following:

ERROR: Missing Signed-off-by: line by nominal patch author 'Maxwell Bland <mbland@motorola.com>'

So, you can change the authorship of the patch like:

git commit --amend --author "Puranjay Mohan <puranjay12@gmail.com>"

similar for the patch by Mark:

git commit --amend --author "Mark Rutland <mark.rutland@arm.com>"

Thanks,
Puranjay

