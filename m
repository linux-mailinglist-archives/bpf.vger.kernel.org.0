Return-Path: <bpf+bounces-15664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861C7F49FE
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118092815AF
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517C4C3D4;
	Wed, 22 Nov 2023 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7ax5tv3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C012A
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:29 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c83d37a492so85737371fa.3
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700666007; x=1701270807; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h27KhTTj9E8bCmmMhxm/VUlmvcJ1Mf12sUCmIoLgBtQ=;
        b=M7ax5tv3Ay1gtWAUDSSShhlvsKNeK4r79bXvASWX8zE1X2anRwqnNaAjkhY2E4olaO
         8cLbI3FRL5AiB3cMexJZuKPrG10OTr3E1KzPWJpVSYsY54kBmjoEfXPRAlOjQHmQzi3q
         P8vAYcYph4qK7rHJDve6kfsTFgdu03HzLUyzIsbq36m8oyY+EGWPwVTd1x8eywxwsH7Y
         87zxH6qQRcHzRO7TAVTd3jELA7djTfjF/w3q9ksCOGzllq4/4mSswKkMAe5MVZfR9TCw
         6f8sLdnMJwEcjc7ofARwMNXiz6t/zwv0043WqXh92y9A4rOr53sCBx3JRbNQkrhbeKux
         VRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666007; x=1701270807;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h27KhTTj9E8bCmmMhxm/VUlmvcJ1Mf12sUCmIoLgBtQ=;
        b=jVA8hnm4J8CB2WpQCLkPy0ubtB3UZ/o2SE5/QHsTqYObJ/gXd9xj8BdS7MzPyHZAzg
         xCERGIWrteQNNAgOnU2C7CTre60PUxgwZEwgffXEt39qTndWXBJQKBelYJ+ydASudQIJ
         gI1e5LL4SonFMguIFUezICaKkhkNN2Bz68/GvIWiVbwEJVL5mnqBxPFnNXL1J3ufW/j5
         +bIjRWAmeb0ysSfxSO2C/uNDPjgF0YsKmP2z4Z+2AQPVq0wwX0LafOYrpgQkvlY1S37P
         MRxmjb3FiaTMqjoWt6sYkSl5RlC/sNSCp2MGFYr5zfkIIy7SAqiy//y6wrWyE+lP2aqd
         tkmQ==
X-Gm-Message-State: AOJu0YykN+0YO2/3loVbg4v3jWMXCu9Co6lWwhHnZmJdH2DSkr6565Ib
	ScolUbrTQ0bNDQwBsKnTJ6JqFkLF5uQ=
X-Google-Smtp-Source: AGHT+IGyi7HLuhcXgqjT48IJFGDSKuSlkjCwlfMUjyqJvPUaRfe6XeyueEaQCWBiFVUr3/h5ogc9yw==
X-Received: by 2002:ac2:5f63:0:b0:503:1783:d5a9 with SMTP id c3-20020ac25f63000000b005031783d5a9mr1811416lfc.3.1700666006954;
        Wed, 22 Nov 2023 07:13:26 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o4-20020a056512050400b004fb7359ab83sm1859760lfb.80.2023.11.22.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:13:26 -0800 (PST)
Message-ID: <055e1cc08035fc002d9ace9b4c5d84d2d175598a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/10] bpf: unify async callback and program
 retval checks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 22 Nov 2023 17:13:25 +0200
In-Reply-To: <20231122011656.1105943-8-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
	 <20231122011656.1105943-8-andrii@kernel.org>
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

On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> Use common logic to verify program return values and async callback
> return values. This allows to avoid duplication of any extra steps
> necessary, like precision marking, which will be added in the next
> patch.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]



