Return-Path: <bpf+bounces-15758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD97F62BA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9AAB21094
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E8D37143;
	Thu, 23 Nov 2023 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0EQd1ul"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B2BD54
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 07:26:52 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c72e275d96so13213711fa.2
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700753210; x=1701358010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bq1lv3s4ci1mvg91IxtpTPj1qbvjsZbu+1Yla/5TUKQ=;
        b=O0EQd1ulgKYDXjspGtdGfg8fznkFQaubHq2wGs0XjRH6QUnMgr8KaNzUW8mfwHcPEG
         sE4ntSYsUNkdXJ9OIMjrLAVAZ9GSd0z9bThDcWls5EjWLq6dLDvHXgdiPcCjJkLsJaH4
         5mk3w484Y7lHJ7DiGhUnVE1neKbIQaQz8Rlk95BsmN3ichvm/ajnQJN+C7pmyypsb6lR
         DG62LpZMddN/XxNITnYGc1YTH1Sd3Bu5K6jTsNDyx/A47Fr0JNRbRnVxErdJF6ZOsrBh
         5HkL/qkRloKFhmYndQVvO7iGcf6NSRSgVBv3bF1M5QOYP+LWr3P6ZFUoR7Ezz9vxJe1s
         auFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753210; x=1701358010;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq1lv3s4ci1mvg91IxtpTPj1qbvjsZbu+1Yla/5TUKQ=;
        b=rrtT+xtXzDk9ihEx9D84iWoZnRjzF3J9lu2M8HwXZhbHuSi5zMzp2Y53HVLyI3v6VL
         1cYmzovK34FkhZoNKFJOi18AXR58HAllx5e/by/EaWTQ4iJY0NYvfqqHy9mv8lgZLZSg
         e6QQ8DJDRtvoZJUqMJHOTl6iBt7ZJz79Tx5q7SrzqzGhoMCVrnrMI4355+rRlYWbqplk
         Uyisu/N3WGu/sUebJ75Pz9AxRMUqF6YJJnKHv1SmvDOWPVcFzLnbJWWcUKgqiWfqdxif
         DC4by+L6J22ukW0S3kn5csz6yr+k/zRfDIRvMwCT0eXYaDGBzMRUIzg7TDaSacTHc+lB
         F33Q==
X-Gm-Message-State: AOJu0YxF0tPv83JeqtWi4Q0H4+sXKQfoO0M88aIDex3iD9NRxXKD22Re
	TnZ8jHrJJWTSl8VYuBDgNbQ=
X-Google-Smtp-Source: AGHT+IGcXIrkkJ14NbGTBiEglXXVvToYBBAKqnjqcMNU/+UZI0qkvkiSBHi9usiuIOwrhZzBbxbDwQ==
X-Received: by 2002:a2e:7e0b:0:b0:2c5:1ad0:e2ff with SMTP id z11-20020a2e7e0b000000b002c51ad0e2ffmr4231308ljc.39.1700753210005;
        Thu, 23 Nov 2023 07:26:50 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y17-20020a2e7d11000000b002c6f07e80aasm228567ljc.15.2023.11.23.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:26:49 -0800 (PST)
Message-ID: <800cffdb2e2fc8de9e1f2ed1a185e6a4fd0754b3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: emit global subprog name in verifier
 logs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 23 Nov 2023 17:26:48 +0200
In-Reply-To: <20231122213112.3596548-2-andrii@kernel.org>
References: <20231122213112.3596548-1-andrii@kernel.org>
	 <20231122213112.3596548-2-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 13:31 -0800, Andrii Nakryiko wrote:
> We have the name, instead of emitting just func#N to identify global
> subprog, augment verifier log messages with actual function name to make
> it more user-friendly.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]



