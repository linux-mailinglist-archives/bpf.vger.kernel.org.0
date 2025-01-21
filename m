Return-Path: <bpf+bounces-49386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B28A17F8F
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EECF3AB8E3
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7501F3D34;
	Tue, 21 Jan 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ACp7ShVY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EA1F03DC
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469168; cv=none; b=S0GZUqRU14bqli6E+7vgvc1V6ih6PTmI2RW5W4JZQFsdlH2t10OlESZ+n98rRFNi3gcDf1WRc4JQxlqL5h2AhtPfYC7MiNXyTnfhkpIypO9AJAcT3r/sFXnTBU8nw/6pTbVln0DlfEGD/eedn1jwNBGSHZ5P0UT67b3UONVYAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469168; c=relaxed/simple;
	bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dt9kxfh+Er4ZGGwoBf1BnHH5PXuhLAqo0dyubzuP4NW/kFPKoSXgMK1H25+msP8yRadx7F7mgHRUNsOPFwXQZxvRQ/Iemzd/w/O9MPrHe2/ZB/OWF7xqpJ8DtVk8HouMs6OVphXq5w5L8CJXRQURo8GUIAO9oW+H1DWNkYGh+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ACp7ShVY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa69107179cso1079574566b.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469165; x=1738073965; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
        b=ACp7ShVY8p6wbYZV1w/a9PNrHT4GNgkND/j6PYlNu/rMLaHPfd4IfBosLFdAn861NA
         f6R9shDB2p9bWdKh6jfIAOgPjukJsCoKn0dfAwlk1X8gic4hHPKfs+tXE81XwO8Z6kf+
         zJH29XSGdGveHAITM29sZ5G1xW+wAIeGFeAa+iXm6E6rItVWvP+kjYjveXhc1WYXohPL
         tQC8RfUNyODeJ2wWUuyc4rK1F0Gu3ZYonyLxCrgZKkeS6MZUqHnP9p8MOTNDJ8GVloOS
         m1uSXTPnyAVAYxPGZLx2g2RcQZs/mMjq8ifd62b1MNUQV21ngv0jg98uctqsgslwgZ9F
         aT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469165; x=1738073965;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
        b=XryrmTptO3hc6V2P+O7dlKc8L7TmnYhTZNFWs3D0CBJ8e25f5mT5DRVGpMXm9BMrv9
         aTB06La4Xr5Mbdl0V6CoyWbsTHUup8j09aQE8zch02mTdyzpT+V18ZyGOeePLtUcQB2v
         0H5MFRHGSJVxNfQ4cpIFRaiFWMYOeqT+atvBCE57iAClx/cNZemH6hSRs0baZEAvwYsu
         u4l4zYvrfIlf3H99slMkPPtOPxBtherVQ/y2Wh3z23+UuCkZEGKkpsQhPtPshdN9n289
         sLpfcA5ks+VWE7cE8P5aP1ifQVSRcglO+NVX/J5Hxbf9G1XiRUVPo+135sfv6AbzkU8y
         nP3A==
X-Gm-Message-State: AOJu0YxO1oHMHd1osn1Jir5Vp8uMqwoaWyalKikokX1J9Eh60C7LafSb
	UF7BROYoccwwDPVXzd//u+zyrOhzz4zGumLKY8/+AVIJ72c/2mSbHvfSxJC4gug=
X-Gm-Gg: ASbGncuqIJefVuuheBt3VFcG4ToTVXmWrY4SP27OCcSifM1t06IUExocGFNXfMDn0KT
	kGsUqipTQNRilgDCuoLHpo7TsdG8ZBkShdATO+0DfaHmV5ah05/rVLmRubEhAzFDicq8Qqa1gq3
	DT6Gmwn7rqym7tjwRhXAv9u1//FkvWBb+pOudPEXcjqVC7sCE4AzMi1UW9Niyo8Ieo4PxiiXSqC
	Eeqigg5ttsNDDKl8szSW+58GBWCGyYqym29dbkmyJovf5QtUAelLko9WAlsLgI=
X-Google-Smtp-Source: AGHT+IHqoZlch0NckMiqj2j54cDxGsvFFhBkVOqSDvHro+EPMUw9uzJs74fAnODhJFiV9d7n5h2OUA==
X-Received: by 2002:a17:907:930b:b0:aab:c78c:a705 with SMTP id a640c23a62f3a-ab38b3d4253mr1645512766b.52.1737469165234;
        Tue, 21 Jan 2025 06:19:25 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506c:2387::38a:3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c61388sm753778666b.20.2025.01.21.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:19:24 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v8 1/5] strparser: add read_sock callback
In-Reply-To: <20250121050707.55523-2-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:03 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-2-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:19:23 +0100
Message-ID: <871pwwi710.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> Added a new read_sock handler, allowing users to customize read operations
> instead of relying on the native socket's read_sock.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

