Return-Path: <bpf+bounces-60990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1FCADF6CC
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69048189FFA0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4221018A;
	Wed, 18 Jun 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIDnEj7W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3220B215;
	Wed, 18 Jun 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274708; cv=none; b=M0qHjHye8/ZLVU12Bp7IiHR4n5xhUM9PVepNMP+CQi2SSR0+f1cRQ9HmTcNNPL4aP49FQENhsRvnzFFaDrrV/YBtNQ+UH2kl3d1SkLx9tuDqak6N6iYBIDVyxgaUu+zxWaELFvNOG1elqtFSwQTsoKEscWFRd7h8UCmoUmcTiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274708; c=relaxed/simple;
	bh=2U2liX+iqk/wxo1mO4ZkmOe5I/A+HwVTcQfw66c1Bis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWVVqRmO2wI40uVTa9KVEheu2z4r6czdQnWsTqmWNx0CVyifD/9bMUmIc/I6qAFRE7wbvlap9FchAzDXSox9tOOqOgDLMJ7UWaxc8eWHHj/xcvidtynTAfu6Kv/J2OcmFqsoKPeEkvxiP68uCEbYmiFuMTWm1dW+TAhFK1HGsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIDnEj7W; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ddcbe64d0dso225325ab.3;
        Wed, 18 Jun 2025 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750274706; x=1750879506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U2liX+iqk/wxo1mO4ZkmOe5I/A+HwVTcQfw66c1Bis=;
        b=EIDnEj7WFLtuhUzXHJKIOy2snKCZulOiTE5nTNraYaF7z7bOcJL1+RrDg1M4Wrda/W
         5lJkbMlSiOcxAEa/MscDMDHywYS2sCSVdaeqL8Cx/tIkUbmf62xggxpXLUch1xklrdGC
         qvlj2r5lPgQzGA8GBaY/4sGNojkZfpM2Rj3BMMzGNjFLHYF8o7oq6cvKx9wzPL76hobc
         mT5qgMkk+YaCXHw37Ox/nb/P/uOXIMgvoyTj0/EoR0+s32ShvJIPIaJsD5qb2kyCeqSl
         T0wCu8BPV4BRl7oNd5xESNDweUiY3JJnU48yb/UrR/mWxSs/JThdlmNwqMzZL+WlgaCV
         TwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750274706; x=1750879506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U2liX+iqk/wxo1mO4ZkmOe5I/A+HwVTcQfw66c1Bis=;
        b=GUn6TW0uXd8rEcnOHPtyo2cgpN7vIMDHlq/3QBNnfAXf07Km+epJqrywoAgGIF3Fim
         NLkNg5zw6RqmKZ/pDN1nWmlGwGrPB31NYS6nYaVNKNbbZq/+jWMdSTqvB6C4Pflbb+aV
         oMwTXTHpJ1GOKlJKPi4R1YMaw6pgP8Tq9GPZCjfFCKRRrlPhyfGzYyD8ox3M2B5jTQm3
         xageuJ+YRI65H8aRG+zuhpBQufDJcHjNIFFX3CeP5vWX8F9PpL+nCxuVyeRmxr9jEKuP
         YSzBF0OMLMGOEA9xFJBqUpGmZggt342Zy0GQHPQ1eTZBuERFnuWFkCqKK7AAyN1z8a0I
         HH9w==
X-Forwarded-Encrypted: i=1; AJvYcCVkCAv9xnYNRXYYZZlhJlcV0ao6rwLGtjSZGi9aYPL8FBAsAQWJ5sL/gJcs+eE8z1uSteq4GQMA@vger.kernel.org, AJvYcCXI9C65AiGpG9BAyrd5IPp0ZIbICa5hUW7p3/uZ39o9JX6TBtVkD3N9mEsFmkVg9f9yf3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLrV3Xziv7QlCt90ndKki1qvDXpIORagVnq5eth2qKMOpY7xs
	2x0lP+8sxQKLqj81/Im4dkSmXlChEb4nj6/akwryJhZidoKbf5/6SoTmTdsqUuzW4jfWjE7lhD7
	05VR5ILFDJsEGsrljbklBK5BYGpX9S+w=
X-Gm-Gg: ASbGncuXEgOm92eKuheJu2a/mBzX8sjGtc7O9TIYX4shKA3xjcpOTntTQqM7/xlDu6P
	6UKdN7RKAigVNPrZZSTbD1LYpmpxCDLU8n/MG6+DWsSnB5qMDq64k0yvca1M5f0Zzi0bu57qSe1
	ka2X8TJoRV7HxE4UsayoigWaFZ6SIR4Uv3mnwTH1dDrno=
X-Google-Smtp-Source: AGHT+IG+rpDJaUfnaV5m+nBDgXBESL6oV+9kwJ4Ca2V63lF4y+BB32avIF0+VsSEEMjVjxOeB7u0ufczbJ4TjecudkA=
X-Received: by 2002:a05:6e02:1fc3:b0:3dd:d338:5c7a with SMTP id
 e9e14a558f8ab-3de07c53d09mr231042235ab.4.1750274706436; Wed, 18 Jun 2025
 12:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch> <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
 <6852fe267553f_3471a129472@willemb.c.googlers.com.notmuch>
In-Reply-To: <6852fe267553f_3471a129472@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 19 Jun 2025 03:24:30 +0800
X-Gm-Features: AX0GCFuIM8VOQ4eitJGzDuyG7QBuswUwdJGS1iCEwWZafbYh0BXVZf5Mawcf9xw
Message-ID: <CAL+tcoC9_ipqoj_egPJ82sXSrT-g-JM_MrCMm1N0JePd2LGf-Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 1:58=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Hi Stanislav,
> >
> > On Tue, Jun 17, 2025 at 9:11=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 06/17, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Introduce a control method in the xsk path to let users have the ch=
ance
> > > > to tune it manually.
> > >
> > > Can you expand more on why the defaults don't work for you?
> >
> > We use a user-level tcp stack with xsk to transmit packets that have
> > higher priorities than other normal kernel tcp flows. It turns out
> > that enlarging the number can minimize times of triggering sendto
> > sysctl, which contributes to faster transmission. it's very easy to
> > hit the upper bound (namely, 32) if you log the return value of
> > sendto. I mentioned a bit about this in the second patch, saying that
> > we can have a similar knob already appearing in the qdisc layer.
> > Furthermore, exposing important parameters can help applications
> > complete their AI/auto-tuning to judge which one is the best fit in
> > their production workload. That is also one of the promising
> > tendencies :)
>
> It would be informative to include this in the commit.

Sure, I will add more in V3.

>
> Or more broadly: suggestions for when and how to pick good settings
> for these new tunables.

I'm not sure what is a good setting in general. But I will try to
describe how I use it and what my understanding of it is in the commit
message.

Thanks,
Jason

