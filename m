Return-Path: <bpf+bounces-18990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D691F823A95
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FE42882B7
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9FB1FA1;
	Thu,  4 Jan 2024 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaK3rh22"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE51FB3
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso51868e87.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 18:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704334969; x=1704939769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uts488EnvGsxXEXzJSUeOiVeoEcl43cv+QjARiDYu44=;
        b=GaK3rh224vyciBrB5bb/FKfdkiwVzB05vlgE5DmMXuY1kEULzBp1jgijHQZ/oyi1w1
         HTjqq7k1zcAskeuvpyFsDP+W+dNXIoJZK/JzJDRouUcKh24SRX8eA/q+swVRHumpTVkv
         dRjbJRVo4jiBkMsdaTpBkTZ/J+7bQ62N78WXYiTqIddFhlH9MxNlNydIzqmxiJhQ2cQo
         iUK75T38y0SA0eM8LxjHTRau0yvVIXms+a1kvbIUpROSJu2SyOC/uZxa+m3bCTMYWgW+
         tWvUvvmu9Isf8K00mXYtFYGJYg2ofbIEqfKdS+eSlZrTsd4N9q6zW5zBU3I60OIqViZG
         KFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704334969; x=1704939769;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uts488EnvGsxXEXzJSUeOiVeoEcl43cv+QjARiDYu44=;
        b=I2kijYMfN6R28ljWoFCqtXL4LoqpxAUIM1uz+xNnkNKTFSFvUZ7el8CwfjaOIUFctQ
         Bjv46rAE7kS1Kiv5k9j3/g5HCayAbBwxwe3vC8c8GZB+IlXuvX0NZu+O7F4omS6DSntC
         sps4D7NfMGEu9VLAg4kt94uAKNU5jaPzh9zl4McIK1xbgLYnGnEqNlss30osgs4gEznY
         /RJQ8hfTA/WdbFO+UP7EtVFZVqYoKOnOcWqUTYG59ZhVyK06x5UnFmgPUQQNBXTrf6za
         WZO+iLNRD8GjqfR7P4P2TrCl1KPWAMm77eedzjUIy4meJ6yRNdZ+eaUs2ix/QlQz+2Sn
         UN6w==
X-Gm-Message-State: AOJu0Yyh0oWlMbMu31pjSmADusMo3z7/ZRhXiKa3dFJfFTyfSA5E4AL0
	ROLse8IvsK437aJV+Y0c3Pv4RMB64Z+XiA==
X-Google-Smtp-Source: AGHT+IG1ymyART1AX+Vs+QS5zuunslQPFnUazYf0RoW/1iZRk1h3Sf7DFF/UGlM6lfyL4cqyNZr4Zg==
X-Received: by 2002:ac2:4882:0:b0:50e:50ee:f378 with SMTP id x2-20020ac24882000000b0050e50eef378mr8161701lfc.65.1704334968522;
        Wed, 03 Jan 2024 18:22:48 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640205d000b00556fff169bfsm195132edx.55.2024.01.03.18.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 18:22:48 -0800 (PST)
Message-ID: <f0a54c24995f0e351e7df4c71974a01e42e7aa64.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/15] selftests/bpf: Fix the
 u64_offset_to_skb_data test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 04 Jan 2024 04:22:47 +0200
In-Reply-To: <20231220214013.3327288-2-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
	 <20231220214013.3327288-2-maxtram95@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 23:39 +0200, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >=20
> > The u64_offset_to_skb_data test is supposed to make a 64-bit fill, but
> > instead makes a 16-bit one. Fix the test according to its intention. Th=
e
> > 16-bit fill is covered by u16_offset_to_skb_data.
> >=20
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(Sorry, I messed up batch-sending acks first time,
 accidental HTML emails had been rejected by mailing lists.
 Resending with reduced To/CC to avoid too much spam)

