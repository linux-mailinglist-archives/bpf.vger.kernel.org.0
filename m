Return-Path: <bpf+bounces-16833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF9806304
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C14281B35
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C14122B;
	Tue,  5 Dec 2023 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USOQkEek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A835122
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:35:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso353223e87.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701819345; x=1702424145; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoN6dBKMO7GyXZIMMm5rpKTIyOK7gi5oNdxOd8/bO0s=;
        b=USOQkEekPRU2h8eBuZyk0Ph+qfQPq68RZgg1GZh1IphmkkQrHx4jOJ1OlaJNoz62qy
         KWiLNCBjjEBoKqByS+KkyOEuIwAJWg3ps6ZRcqz3CeH5VLTjz++lRhQCCPmgc+S1mYMc
         BJYlzVYQLkQVmh0o09crnzmCZuowdL8WS31H7rsMb2EfoVvJR+0WDowegbQHcjg+mGEa
         DNuBwCK35EvHtwz4hC+bempk5S9L/+y+3bTgmEJzgNyOOo/h8uUH/EBny2T2epCrqbVi
         dAhOaHX+FkgSFJO931dNCG3cdzHitxlPG/80Erkz2Z7gcDR3V0PMgtE2CXwn39azjnK2
         5+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701819345; x=1702424145;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoN6dBKMO7GyXZIMMm5rpKTIyOK7gi5oNdxOd8/bO0s=;
        b=XflfLcir/QKajRWYcE6PxjkHr+Ajlluot4eMyzJNWv67G1O5sh9L3J5DShOkPnDC+b
         mtYV1OnE8f/X04Qv7afbE3iRfL9EN99aQK2mC7MESjp3aTGwbqjQ/ustlYJALbgDZ+Ld
         h9FL/PsGb5ofPdmZgGhdKW9FPPKbcjVqQubd54EvmH/JnRsdLhGgIbMD+kkIooX1it0n
         L3ahD4ImTCXL9jp32UoDzsiE2hdH7v0C2fPSlNPrSuclH/3sIuhKDxz6GImNkc9XQjI5
         S+rRZMtfFm3TEle2ABs9nxeqlQuxxnkb7lDEFD6nSvix6al+tZSiC8skwqBefFW9tJGm
         YXNA==
X-Gm-Message-State: AOJu0Yyg+Wz6s9ZnkExDbuNO8g5nkgY44fCwtjfzTkryuyVr4BnqsAGD
	Gz7Rnbsc6xUXIvpryYFNrwA=
X-Google-Smtp-Source: AGHT+IG606fcGwyiIGXmOGNIXysCmCc3TgYOermGGnYf+C/p77RutZoBRualgrI0p84mHWq8QtITAA==
X-Received: by 2002:a05:6512:15a4:b0:50b:d341:4f6c with SMTP id bp36-20020a05651215a400b0050bd3414f6cmr7520lfb.6.1701819345479;
        Tue, 05 Dec 2023 15:35:45 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q2-20020a05651232a200b0050c01bd1984sm366863lfe.87.2023.12.05.15.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:35:44 -0800 (PST)
Message-ID: <e3787b1d4c2d7a6b02ca6561edad92fbc27cb6ba.camel@gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: fix verification of indirect var-off
 stack access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com, sunhao.th@gmail.com
Date: Wed, 06 Dec 2023 01:35:44 +0200
In-Reply-To: <20231205193250.260862-1-andreimatei1@gmail.com>
References: <20231205193250.260862-1-andreimatei1@gmail.com>
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

On Tue, 2023-12-05 at 14:32 -0500, Andrei Matei wrote:
> V2 to V3:
>   - simplify checks for max_off (don't call
>     check_stack_slot_within_bounds for it)
>   - append a commit to protect against overflow in the addition of the
>     register and the offset
>=20
> V1 to V2:
>   - fix max_off calculation for access size =3D 0
>=20
> Andrei Matei (2):
>   bpf: fix verification of indirect var-off stack access
>   bpf: guard stack limits against 32bit overflow
>=20
>  kernel/bpf/verifier.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>=20

I think we also need a selftest, at-least for patch #1.

