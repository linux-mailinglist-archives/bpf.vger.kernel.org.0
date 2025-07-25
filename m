Return-Path: <bpf+bounces-64386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF3B122EB
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0731C8618E
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769852EF9B7;
	Fri, 25 Jul 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9EkWudX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35041FC8
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464062; cv=none; b=p7qYQ+s4Bfo8SYlaBmKYrbyZuvubdMpWt8M7bPfZmHCYbaytDuaRJlg25wtawboKxf2OW1A5lwdI7rK3eVZ80b/EGrlcS4AJg9/0Bho9LdkXKfPP4aYeRQ8MJ4vnZGXkjPce9uSSxqkP6SlPnbtaVLi/9xwuk/RVJRzdZRKeNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464062; c=relaxed/simple;
	bh=ztW5g9Io+DwYXSX5Bjb/sZm/RkMW/CjJ9zOMGyQfjIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTEKl3L5+XOjo8mYOtheHjKhKhMLH1p3DWcn8TGftDK3UGuvATv3zDgjUkr35Wua9hWduS9i4zrbRGAh4YVErA+Sgr2TJtHM/lxY70NNhz/DVZjmwCwTHmqpEqmxAz+OAUTAgMvW2oeKpQgAu20r/j1JVmQCpCUHotm98AzuicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9EkWudX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237f18108d2so11435ad.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753464060; x=1754068860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztW5g9Io+DwYXSX5Bjb/sZm/RkMW/CjJ9zOMGyQfjIw=;
        b=d9EkWudX7JQDV9rHyMYMOYx2hVLOx78xGL/5Lmvt8vg98SD38FMzmIl3LAZZLNZ3++
         7Sac6CNYM8Y9t5IxCz6zh9IaXs5ft7iujKXiJ1Pgdpa3dF5nGTaWUCO6jXB+c1YhchfN
         2nID9+OIx55YNDCxTvL/FZdFVxQFVlySRpXJ65KrYxV9AIFnAwDuX54a93mfbJ4EyXCk
         KUTG8Ud2UG+t8Yuczh7O5an/aU8zYMuXbWDLP/ORQFhVrnddmsKDJ6QTHSLYQPswJZm+
         c4teoeF4BVSWqDHeUs5fvh6x62pVquRiUX7HB4OVB3EcJ1mKN2ifV0Qso7zqsJD75s1u
         6Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464060; x=1754068860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztW5g9Io+DwYXSX5Bjb/sZm/RkMW/CjJ9zOMGyQfjIw=;
        b=j7EkMHSxtWioRfsracH+qivTcbNQ30e/v8PsEoOznmtefiIKinucFQtRTNYICmLn43
         ZgpDZKDu03CCzuEqWImDPXry+FrFjeut/a+ATxHKJswaiV5ZG6YAgLa6p1PE23gbS4A4
         NDPM8aLPEBuXQ6U89FW7hSvWAU5Nm0LOlqrPwUbH/64427l0ljw2+nR3eWsl3EMpoc9w
         SQndBTat932a7ZnXtQONXP3mXb+J5cuj8h2QUWJXHJXTAS6Bi0McuHU4o/jiSraeOx9t
         vxXYG7zBRH8fRlnyFVZqDk2Xu3Kvj9zLSOBlWCYdF5vBP3K/0aGGrDo3xTikJSodiGpH
         v82A==
X-Gm-Message-State: AOJu0Yz+5RUxFpN3822WxLxEBh42CyMoZ5vk+40Ihgmmv7NvlLbL7cT0
	FvfT850rJHVTpb+q1whe2V07DhH74ql1nC84wisrplZYRkVFSmRkb5pf/9tpheJeyX3DBQnz9gx
	np88jGxwBd8uUtxe6SeFhDp5t4TQe/xhTeFh32J/G
X-Gm-Gg: ASbGncu8IkQUK4fEnHefjKGubWq5ukGMdQ+/fTc5Ae7eWFeqxBI1jzgxC98+4MSl4SM
	uqfY7KxlNV2TdU/rf7eEwbuN5IwFfbuyFTgD/E0H8FgDQSGr9N1xrG7UpLIt6e0mwyIwev6MnuI
	JKetsQ4SCfXQYWhXzynrzF6IfunY6qgavqt/7A6QyFntMO/gPPTvOxhLXKVtvuGcDuWu8jtBkC6
	1HB
X-Google-Smtp-Source: AGHT+IG3La2ZTD3NRSPrjHKZQ5evO30wkrLX+Kpt+QdhR94hbkea+gCEFQx5xnAWugOKKY5PaeRMhwgBkwadUW1udNg=
X-Received: by 2002:a17:903:2bcb:b0:234:8eeb:d81a with SMTP id
 d9443c01a7336-23fadb18ed0mr3827435ad.16.1753464059728; Fri, 25 Jul 2025
 10:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com>
 <c7241cc9-2b20-4f32-8ae2-93f40d12fc85@linux.dev> <CABCJKud8u_AF6=gWvvYqMeP71kWG3k88jjozEBmXpW9r4YxGKQ@mail.gmail.com>
 <f82341df-bf2a-4913-a58c-e0acdfb245d2@linux.dev>
In-Reply-To: <f82341df-bf2a-4913-a58c-e0acdfb245d2@linux.dev>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 25 Jul 2025 10:20:21 -0700
X-Gm-Features: Ac12FXwiLGc5GdsZn_qOja2m3m-3Suv_aTBv8aMYUOQDME3DEqdrTQ3FkvdZlpw
Message-ID: <CABCJKueq=a6Y_2YmSDOa-VTCW9jwYPiXq94125EAMoZ5Y6-ypA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Use correct destructor kfunc types
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:54=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> I just tried arm64 with your patch set. CFI crash still happened:
>
> CFI failure at tcp_ack+0xe74/0x13cc (target: bpf__tcp_congestion_ops_in_a=
ck_event+0x0/0x78; expected type: 0x64424
> 87a)

This one should fixed by the other series I posted earlier:

https://lore.kernel.org/bpf/20250722205357.3347626-5-samitolvanen@google.co=
m/

Sami

