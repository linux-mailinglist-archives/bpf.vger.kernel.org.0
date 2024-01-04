Return-Path: <bpf+bounces-18992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E2C823A9E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09371C249E8
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D511FB3;
	Thu,  4 Jan 2024 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXEmnOWx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5684C67
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55590da560dso88166a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 18:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335158; x=1704939958; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PygrPivEOTYjBriejg4ZV8MApq2eTuOcW9Fcr6d0yvk=;
        b=BXEmnOWxdX7f/lBPnf+OKVC7avtc+dFGXejsuDGTbg+MuguzndgZUqbIoDYFG7j/TQ
         qZQfDhZpYosxuzcQQOIw6Fkcwqr373ErS9mfne1yQPD8HskSvp2HR4Awlbjoj2tyzoEE
         mqOR9dDKRnKV0KQqaGGaM3IajJaFOneg9EtrF7nr7ppNW25wbwabQxX9YS9EkJo59+7f
         Wjz+8HK0yZ3MF1sA/yAwDbwJPDyzqjcuHbeJHedfVRwLyjPzd/T/npDRtAAT2TFloCiT
         17FO/hf9K+8EZkXksFWuq7N75Jg4pYCK0XpENqp8svToYfLUNgO4Eh7iZtRfrRaXohLq
         eJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335158; x=1704939958;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PygrPivEOTYjBriejg4ZV8MApq2eTuOcW9Fcr6d0yvk=;
        b=l8cqstN+F1nZZ1+RWq8/EDhl0/xiPLMdKOCjWqHVncINVZ0hzz48Ls8uxIR7CDoM/3
         eVnQ0BYqH6X3PQ6mK/lrgVGP+v9GT8i63/LajblY2anEISdlN+MNRbqeTZorEGiwkiNR
         mFQRP9CTuaxp7vEvlHmljznMxywRQpv9nPO39vZC9gmGH5Xcgw9/r9iFPVY2JYPJ42hD
         BwHHc5DgYXKfWlwOpJ49E3yhbvahvhcQ7AYj7DE33EMquMZtsCVQiEAAvAoD0L4UWb2s
         aljzdlntoWLINs7BRMzMAKc3Qhk4lVN3DstnDZU2DHGBDJnMfEVy7pB5Y79SEXDgSpy6
         tyDg==
X-Gm-Message-State: AOJu0YzFRKb0TdUb0/OECymK8HqtPoDOClYZ3vOw5yhppDwqwkhVi2js
	FYt/jO2Ug2KArpdzbiW6EiSDV0WR5Gejow==
X-Google-Smtp-Source: AGHT+IHq60p7bbcKdj2scFsyv3Hvy/3ILXGw23vUopTrgfzewDK2Y1sp9bcanV84M4LzPCM2NJ2abw==
X-Received: by 2002:a17:906:6949:b0:a28:d32d:fa9f with SMTP id c9-20020a170906694900b00a28d32dfa9fmr160605ejs.42.1704335158426;
        Wed, 03 Jan 2024 18:25:58 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709066a9100b00a28badcf367sm505172ejr.54.2024.01.03.18.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 18:25:58 -0800 (PST)
Message-ID: <6c4b611dcfda49c683d847fb11d9e3a60bdaa7b7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/15] selftests/bpf: Add a test case for
 32-bit spill tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 04 Jan 2024 04:25:57 +0200
In-Reply-To: <20231220214013.3327288-6-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
	 <20231220214013.3327288-6-maxtram95@gmail.com>
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

On Wed, 2023-12-20 at 23:40 +0200, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >=20
> > When a range check is performed on a register that was 32-bit spilled t=
o
> > the stack, the IDs of the two instances of the register are the same, s=
o
> > the range should also be the same.
> >=20
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

