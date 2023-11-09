Return-Path: <bpf+bounces-14659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76E7E7535
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8491C20B38
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898538FB1;
	Thu,  9 Nov 2023 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYNDa0Sd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22A38F96
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 23:37:41 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF84482
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:37:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso250320266b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 15:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699573059; x=1700177859; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0V+QXdOB4kGPPt2z+g4GClpRz3cZz/UcGtepxRTMh2o=;
        b=dYNDa0SdWMwyIwYPZtI4C9ieWdFrlEJrUeYQOQ2xia4pc0trlZSKAy4CUaDwhTomgD
         x5rfwcPYNnqaydi2+BgLtxODK6UrfZpIEp+w9w6x5iHw1xNOb1TLHgfqioXgVPz91w3c
         0zelhurc0vGH2dElNRlaN9Hb/tbQtueQG4dHQEL+PwMto5ZjpjFkjPlbeiITd+2ts+ya
         jQbUWz/+r8ZPkyN/JI93a/OSebZcER+s1KA6ig6+BLL47K7XpJ6D3QtaTSeLtI0Qis6f
         bRTFWf6K18PnCOfOiQASGdCQUl25cc/xHHwHPFk3fAFnltiB/SjmLgSj703rGxAfITHq
         ek9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699573059; x=1700177859;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V+QXdOB4kGPPt2z+g4GClpRz3cZz/UcGtepxRTMh2o=;
        b=Z3qMLIXHTI6tNAWaJYlJ22iZeBEPHMqB4NM5m1chJHvQTQ9dy/Jhvha92hwvx9KxZD
         Defcz87n/VUVhsAH7RE5+rhXx9q6VIX8Byrr4tly5dScslNTXFLXlbiuBuAFcEFkXYin
         n9yPfvAjDGewvFsYtm0fi+BzBpaJl9Rci6E+K2xRHFbPfOfrOPh0OYDrWcjBDsr/4zOK
         pGJGX3YQVrXhMW42EBx65BxtC/yAWOyXlC4xSHR4z56b3pz4Hmk6daKns1ZLRC5B6nXW
         N8fHp4/6ncWMp0eiDPahV0xS+FLZyRoWdufjo87b7hgXBrohffIWQaQQOUY6q5WVtdGO
         PV7w==
X-Gm-Message-State: AOJu0YxKfHSy1hn0UEg+UVKmx+wjrgHXpatrJ90SaeVcsbHf1X6G8/YP
	QVaEdYj50x4VNqWqVu9MAuU=
X-Google-Smtp-Source: AGHT+IHFL+B6MQR/S96t3WskxuZ8n72ZbyP+Br8OwuPGLv5vxiIHoN85KLhVjLh3c74JTpDizwHmgw==
X-Received: by 2002:a17:906:1b04:b0:9e5:1db7:31b1 with SMTP id o4-20020a1709061b0400b009e51db731b1mr999411ejg.2.1699573059475;
        Thu, 09 Nov 2023 15:37:39 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id pk18-20020a170906d7b200b0099ce188be7fsm3127219ejb.3.2023.11.09.15.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:37:38 -0800 (PST)
Message-ID: <49fe09a850f168af51fac5d020cb3680e6071768.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: fix precision backtracking
 instruction iteration
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Fri, 10 Nov 2023 01:37:37 +0200
In-Reply-To: <CAEf4BzbK1B-mQxS5dH98MjmMMWjVUvzyrwHi5qWNBtPJs384kw@mail.gmail.com>
References: <20231108231152.3583545-1-andrii@kernel.org>
	 <20231108231152.3583545-3-andrii@kernel.org>
	 <3ff0d703846a10d2a84ae5086511793a2aba5c08.camel@gmail.com>
	 <CAEf4BzbDR9S-wQ6vH6Exvv04wU2VPGud=1-_p0v=gEy7Amo_xw@mail.gmail.com>
	 <CAEf4BzbK1B-mQxS5dH98MjmMMWjVUvzyrwHi5qWNBtPJs384kw@mail.gmail.com>
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

On Thu, 2023-11-09 at 15:28 -0800, Andrii Nakryiko wrote:
[...]
> > > I think that this case needs a dedicated test case that would check
> > > precision tracking log.
> >=20
> > ok, will add
> >=20
>=20
> But I will say that it would be much better if verifier/precise.c was
> converted to embedded assembly... Let's see if we can somehow
> negotiate completing test_verifier conversion? ;)

I'll take a look at what can be done for precise.c over the weekend.

