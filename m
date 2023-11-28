Return-Path: <bpf+bounces-16022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7787FB027
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 03:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D7B281CB7
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 02:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5B20F6;
	Tue, 28 Nov 2023 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMO7hcbn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE118E;
	Mon, 27 Nov 2023 18:37:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so64592521fa.1;
        Mon, 27 Nov 2023 18:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139020; x=1701743820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9DehPb+B0avMQIEahya5tFyVOrTp2O4+WIgAS2v9xk=;
        b=FMO7hcbnv3OCuTYDZhns5/GKavPWFd1M2oUl75oFXByMLXpkpM3+JNzPgoU++MtKei
         2KnzR5DbYk/7e9yBi8OaGI4lnykEz/87OtRyVMNtcf3WxksbrObnFSuf8hsorytie4OT
         UR6dcZcm4uUnRhSxEhIBWq5cjLnib54H990xLUfQtmHoIaLohegVY47Gu/PG3SgSUpJB
         YUvlfkxIK6UxtVXcLpVmR2o4GrE65/oLI930N3aYTi5nkoSzmQm7FE428EV/cKbbNHaC
         Vd6Pic8l9RSVK6Y3mQoABTU2Pe5ieGRHSFQf4ReSUjJ3UnjT+AzBWCVWItAYKsHqStbQ
         SCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139020; x=1701743820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9DehPb+B0avMQIEahya5tFyVOrTp2O4+WIgAS2v9xk=;
        b=n9IF974PAVuEyOSUOjSGN6YQgc24ANBiYThbcRYRbvFm91LTEdLKAtLa6SLchdMy0k
         KwbWvTsyqWQxIQJZUlARyolwJSl8iJMtYws5eKz1HsGsUNtOns/J0NwllM7lC7alCP7s
         ger9nH6vy3FRxpwdhgNq+gmhEne6OVDaj9u4uo4xxlP9Z/czcr1jpHXKgn3yY2w8IJ8C
         am3ar3YsFkrGf+BwYZt0ieshuKzLpfKbyTsHquYnr3zEhVpoMPTr7vvUFAKzCFsdJHr5
         h2yts9JO6Sti+5/b6zUhVfsyMEeuCCQc6Ag0pZwewVRYIfhx54ZbwChaYP/qZlhr+FNl
         b7yA==
X-Gm-Message-State: AOJu0YwVOOUEx7IbkQSSJrgBJijW1V1o1hQT0954Cydaih3JNAKPSL3k
	sKh6WtwfEc/wvUzFJ3VBYX700SnndE0MJsAmvjA=
X-Google-Smtp-Source: AGHT+IF6Md78NIt1A4rE+Nxd2qAgloV2QTWu429Ac/B5IF8drR/zassEwyV2rUGEvSdF/ZuusnjIQKQCbQbZcTWYPGU=
X-Received: by 2002:a2e:9490:0:b0:2c8:71d5:abfb with SMTP id
 c16-20020a2e9490000000b002c871d5abfbmr10288257ljh.43.1701139019479; Mon, 27
 Nov 2023 18:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
In-Reply-To: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 27 Nov 2023 21:36:47 -0500
Message-ID: <CABWLseuvzphU7+1BxXnjdbBMbqYzvXH-OSX+2bKi6KMNnFiqcA@mail.gmail.com>
Subject: Re: [Bug Report] bpf: zero access_size of stack causes array indix
 oob in check_stack_range_initialized()
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for another great report, Hao! Will investigate.

