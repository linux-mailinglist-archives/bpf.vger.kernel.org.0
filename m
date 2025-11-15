Return-Path: <bpf+bounces-74633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF13C5FED9
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37A0F4E7647
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64601221269;
	Sat, 15 Nov 2025 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiGaS10j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4F17C21E
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174737; cv=none; b=uagIH1hwLubk8qi7Zqeo8K3G1FBvFx2dgK871g3mNEQh7f4bv0cv9tqjwnqiuNzajDE78Yxur+iIfKxob2aruaqFlXOwLSPJ5r5VOf6jXf4jkGZyyhZtwXVFjlvoR+5xLs3mb5XMfsVbQcL/6aeeZxQu3FZ66zYmEPNvAhFv6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174737; c=relaxed/simple;
	bh=DV19atzgnPVtT88dK9S1W0tz+51hu2L+tkCKgn5f6N0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/3XGVhDlB7epQ2mf0XeYeSC5BTHwEKDQcNUnrZoJ5I/pNaxO00Kd9jolxoNjcRKz8veVm9oXKqRyjnYEeDYPMUEwwVbzB4w9w6vMB1RgK7jjasBqP/dUoTWkpy7wXOpbAEI6iobky3N6lvX53wMr8/tInkyxppm/ZpoCobVp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiGaS10j; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso648425b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174736; x=1763779536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DV19atzgnPVtT88dK9S1W0tz+51hu2L+tkCKgn5f6N0=;
        b=ZiGaS10j3jCp5ZVQtgXxV4cjB2nxYcwykMjFnC55pRYVgyk/77EiHZqNFFrUme3Q5s
         HVP773FdkvZ+LscOVTdyoJXgakbXCDR5tkZSWBfjxm76HUnDBjd6nXvWY+cn+NDI+zk9
         xvwdEBBXtX10/+WcrnLhe2GII0LXg0lMZCf8SyAspe8lEnTyvsXGBGNqBZQ4aHuj+L0B
         oPrV8npFQqvFvjjU1XRGllVsgVgMpJWJteUv9LKt5N5SDB/tAtx6wenaWdiEcv8h+qyf
         sDtFEx0KV7+qCdXPgXSaOdgNXU7Aa6oAGkm9q+KqA294H7FazjVuOdqR/1gpgXo7gKFC
         cYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174736; x=1763779536;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DV19atzgnPVtT88dK9S1W0tz+51hu2L+tkCKgn5f6N0=;
        b=NqYZJcrtG7eYJcNQD4Whv16fpYCrf66iTRSoIrnIgQISQ0RDK53jzPpjJfXYZGBnxe
         1eU5StBLDqAhIByl9eqdCY8KZXWySs18lL30Xb8OHFM/I8goISIREyRCBr5kDydKopDo
         5THvvzxonZDPeO1jEb/42PMSokYjSUG/S5AJF8x+6+kAXGv+D5V/ZuHJcN9ftWT6f1ZY
         CMWLBy+xpQ11rHvJtRQqStEJMsEZKjMID02pl3Mds6XCNYRJe/qNH6sV/Bb/IX+l+TWl
         aL1tZ7sixXOEXkPkcJsrH00NpdrTVY46FZ0bEC3UnlD9x5U2rjh7tQ0X2Si4Fa0ozDTN
         Pm0Q==
X-Gm-Message-State: AOJu0YxdSx7aSAQQ9RuVe/PYN6hwP9YfPHVMFQN/Rb5RcRNRysvpt7xy
	4cY2dRiZ4leogzDu2eR09k8CVBXRD3wYxUyfF8nEvLiynjXwTXgtXP8V
X-Gm-Gg: ASbGncsmEU1EfZ85dK0gFo0LquVUrF31TmIfP9tox3IPIGtV328GaQBaOvLs2hM/YXz
	6DYjNKbcmkXUlIIVhFuJERZLSMNoAWsXRFtWc0sDsK3tTSw0m8t/BZG8aah9XZdJ57AGHOUG+Nh
	cO/hNm8a7ti/gXbmW5U645Rn6rUHOue+un7jmWsmWAhuXI5BnEIlHR2zK1jqO2o4IFxovrhseEs
	HimoTYsJumc/H9oQn4l2jWr5h3YpjNIFyrz/ldYmuwWqxsOnENd8+ZScKbdjkPI116juJcIEPGD
	LpWxi85pEJKgFOBnt4V4yk9WSN7wyDdtzseMiWf7beOjn6uyugpyoZCEj7/b0C0JLT1TCskFJIT
	ygA43iQWw+vw74p41NvLzQ2Jxg9DUi5g4dYhGSwZAe6D1Qq2JMStERDNDiFEzg5KzhpyqqItmfA
	==
X-Google-Smtp-Source: AGHT+IG2pOV6LSNaXuTlc26/BlskR5yf2gjd0jfWSi8YpxrlMOtzk7XLskhi+Vis9wKfojqFZ//HnA==
X-Received: by 2002:a05:6a20:4329:b0:33e:779e:fa7f with SMTP id adf61e73a8af0-35b9f8851efmr7503240637.1.1763174735919;
        Fri, 14 Nov 2025 18:45:35 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm4258567b3a.21.2025.11.14.18.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:45:35 -0800 (PST)
Message-ID: <4d22c2f6bdf8327a02d6b03b9e19b0e5df2da4c1.camel@gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, Pu Lehui <pulehui@huawei.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire	 <alan.maguire@oracle.com>
Date: Fri, 14 Nov 2025 18:45:32 -0800
In-Reply-To: <2612eeec-8948-41d6-9d41-4f1ec813d514@huaweicloud.com>
References: <20251110092536.4082324-1-pulehui@huaweicloud.com>
	 <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
	 <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com>
	 <fb7f62db-4dc6-4614-a0c4-3b2a1904aadb@huawei.com>
	 <CAADnVQLPJGPwx3CfgXBCZPHi_niGYTy+VFnyd50oNrDSkvyqPw@mail.gmail.com>
	 <2612eeec-8948-41d6-9d41-4f1ec813d514@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-15 at 10:41 +0800, Pu Lehui wrote:

[...]

> Hi Alexei,
>=20
> How about making the stats update a callback function? That is, the=20
> dummy flow does nothing, while the others follow the normal process.

Not Alexei, but am curious.
Is there a performance differnece between "if" check, dummy stats
struct or function pointer?

[...]

