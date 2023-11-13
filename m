Return-Path: <bpf+bounces-15014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429017EA72A
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C39A1C209BA
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11033E477;
	Mon, 13 Nov 2023 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M54/7why"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB13D988
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 23:46:08 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA7599
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 15:46:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso37381765e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699919164; x=1700523964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwb88z++Rw3mw2XNLjgVirCwzCEolZimZ9k7NQsxeWA=;
        b=M54/7whygMF47RlXhY9puukntMmbDdH0PNPHYA5PPnm4uJvkVAGnWtfQbwEnkMNH19
         FJdFCuT7RgHxZy7Vaz71io/jNZuvxWoaeOVbv5Qx93DyqdfDUjXIriZHrwAxgAuFFg62
         FP1GKKQfg8BIWL7Ef8+2SPBaKDiVxnB32s1hR/pymFgYSUInao9EPHGJNz2Z7JPjnDO1
         lKp+og4yyHFlGC8qwngulYEyigFH0sYMp+wAUkW2bdxz55v8fo/GRRlY/IGU2PdSISjd
         wVaWGrSHDtNcQ85X9ZR72GmSYYkt36EB3RvGNyG2KN131rpVft+kQZ3iiwqITtoxZfKW
         BiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699919164; x=1700523964;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwb88z++Rw3mw2XNLjgVirCwzCEolZimZ9k7NQsxeWA=;
        b=CEn5fQgZA66lbQGsgw8oJfBZ6Lc8Xx95S8Uh+Al8YDm6qmMElvD0i28iZtTBUPpzCx
         W7nSgJGcZT9FZ5YGFXzk5RgWD0UqfGkXnaqYJpLNLWOfhEHJmJnxnUnM3SWiBxtr3XhG
         VyEUWpQg487tMv7bLuyQFRux3rXNiMdyX925lbPlHcwzN4i3bX1VuI88VkGylZGksiB9
         VEKI5K7HZA/gjOYS5yc/moPGwc2tIJB6EScUqNjfBGizmXcZuVe3pmIAdFWjdvJKBGXB
         0qaHqedqS6NrE/T14Dz32IgiDIB+kLMGUDRH4lck1tsjjpmAMKZmquaicOkDUKoZOqtr
         ArUA==
X-Gm-Message-State: AOJu0Yx0qY42dJy8KSJL1yii+6pUIy8zDZB3h+k0ztVCR6IpxgaYCwiU
	N+WN7oq8HCrVPGlcZ8Cc9o8=
X-Google-Smtp-Source: AGHT+IEgw54L3OIo+16scpS9oz17IyUrHKPMntaCNvh1r0G0hX7T58XpD8HPINDOqPnGKhb4IHm48Q==
X-Received: by 2002:a05:600c:ad3:b0:3f6:9634:c8d6 with SMTP id c19-20020a05600c0ad300b003f69634c8d6mr6248799wmr.18.1699919163835;
        Mon, 13 Nov 2023 15:46:03 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00401e32b25adsm9554248wmb.4.2023.11.13.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:46:03 -0800 (PST)
Message-ID: <eb050694397f7679c52dcad85153a0d8f2fe7cbc.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/13] selftests/bpf: adjust OP_EQ/OP_NE
 handling to use subranges for branch taken
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 14 Nov 2023 01:46:02 +0200
In-Reply-To: <20231112010609.848406-9-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
	 <20231112010609.848406-9-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-11-11 at 17:06 -0800, Andrii Nakryiko wrote:
> Similar to kernel-side BPF verifier logic enhancements, use 32-bit
> subrange knowledge for is_branch_taken() logic in reg_bounds selftests.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

