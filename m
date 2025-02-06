Return-Path: <bpf+bounces-50600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15642A29F59
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 04:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6B57A4823
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD47152E12;
	Thu,  6 Feb 2025 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq0HAPL4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421170838;
	Thu,  6 Feb 2025 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812324; cv=none; b=eykdelLXsVxJcfsyHPp/jtSMb0TwBEjWMbghuK0j3cgafrDabePWc3mvVg1R8I9uu6KEeRS9WCyPEDBNsXBF6BlnufVPNUEXu4eol1VTu4RbIVuv3+Cq9dJYrvLADYd0eg9dG3x5NmDApGzvmIRP7i98fkG/LdVh/tsuqwgirYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812324; c=relaxed/simple;
	bh=+8P9FVoO4rvuilh78gqBCr5kLiWgHL1K1Q3V44XW/AA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ECiJvQK571ozty2GVf6FNiWnMXp2U0b50Ptuni1AvWUOxOxoNG69qxy2WcvI9lhpM70TJ/NtlOVodFTiDPYkpko00Sody84nY1maQmzRufVFVbGEANuU1ALsBq1TmIxSPV2dIJiIpKH/uB/n6NbeadgobGTT+ybpeBrWb6y3U5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq0HAPL4; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e41e17645dso4504216d6.2;
        Wed, 05 Feb 2025 19:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738812322; x=1739417122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydDJ7thwetTZnyq0KueSZoJ5PrsvanWkIWgffBWa1oc=;
        b=mq0HAPL4jjorWCRjiEYk1yFiyrBymqI9LTwwiTBSF1tEPeNuooInco1+l0/MzknExV
         dC/Jb6uFrUhp6d4R818jdVF5C6fb7Q98GRyyxMAbZrR7LijheYVTa1Dqg6Wswq7qoeYP
         5Lc6ClZ81YnUqD9BzQwmSpu343EK8icfkrByEoXLQSQjUqG6fvT6AswsTYlMj3e0stJb
         X1NaqSs+Qxi0rOWc+ZDfTiUUdsYap/rMpZ0MaKWJzvYfH03Hj2Oevg+5nj3kcApE0h0n
         EJrImbcChoydDTz6Sa79RdyZPV9d4tGDIP1DXy8SqrPchuQdsjTHQKrBx/DGQDrzKMBQ
         LOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738812322; x=1739417122;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ydDJ7thwetTZnyq0KueSZoJ5PrsvanWkIWgffBWa1oc=;
        b=QF1gl04CX1RKf3WnOSRDVRBTp7X0C13IHyBySCpbeyuhCfYqOu94EXM7xjfysgO7mP
         2shkpCd8pOCx/F60LmwAB+neV9ON0+sWhdx/V9OSn9pve5fublN0NyFShGvtrPd8ngUY
         V/DUklQbMqChJqqFLG0u24kn7ea6E4ods3siOPRzjrtpUJH1pOoJMlqpYxTwkmdc9bPr
         bZiTrH0XBSGWmGaoirsj8Fcf6HE//2W9qxt0g4iJUV+qG4K4uj9LeMFAgInoHy6YjPbm
         HH01Zla/sNu38PnKWhAQLbgu8Gx1P7C8TUFmGzYh/4UIOiENpAN0tXgpZ+uFgcvezYC9
         0zng==
X-Forwarded-Encrypted: i=1; AJvYcCWto1mluF0Ju6Emg4Ja02rYnqGn5gk49mkp8qTz5+I4atB9DFRiGn1KsUKQg8AsrwvFHZenWfkU@vger.kernel.org, AJvYcCXeNxbbSY5Vc9HLzR8eqgVEE4sUJMiu7TTnepS1Q129xnJtfc6u/lnYcZgaIOVKM/pJqLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzAg+zDCEzc/+/YtuTh2W+N1Tm9rf4ixUvRfRtYZCTWqmRIOY
	Eb+oX6GZNE52GVUoRNdxQN3FNfNEz6UsTQvjxwiZY6VsFtQ1jtME
X-Gm-Gg: ASbGnctLSiGcvYrH/UbD5mqNzcvRAqwF2BoYQP8kbkFmOOVHDHe/zW/lX7EZNGX04Op
	n4BDIPy1j55NNgX0CtEYTSJK9e6BIF3HycCn3LpKOM6LTwU0g9gaAM4euVszu6ytZ1n3F19Vn8R
	3Q2buVip7GIfTW9FjZIrCni/nmQn+BDhaKucEPbh5u4UeavWScwi8oTw7niNg1ZuZ2+kiprXW45
	Cyt/6tj528ySKcGTDuKcs4Q5YG5kiVbdRhN0F1jptHvz5SgXC2bK4g7YifL8MVf+8Kq67taO2Zv
	kdVRVPQda5I1Ib8BjLKROxh6HxIlew3HkbPc9FSDZeYEO+ttYxHZ0WbqxFE988U=
X-Google-Smtp-Source: AGHT+IGoOLwQYF98d9gA7JieDHxgKTHwX1GOfM6V0t/SCnLXE5JZzrzn6fzOHFkOCyGQk8mnmhq6Zw==
X-Received: by 2002:a05:6214:212d:b0:6e4:1e1d:10a7 with SMTP id 6a1803df08f44-6e42fb03ae4mr75519636d6.1.1738812322035;
        Wed, 05 Feb 2025 19:25:22 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba36f85sm1912026d6.44.2025.02.05.19.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 19:25:21 -0800 (PST)
Date: Wed, 05 Feb 2025 22:25:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
 <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
 <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > I think we can split the whole idea into two parts: for now, because
> > > of the current series implementing the same function as SO_TIMETAMPING
> > > does, I will implement the selective sample feature in the series.
> > > After someday we finish tracing all the skb, then we will add the
> > > corresponding selective sample feature.
> >
> > Are you saying that you will include selective sampling now or want to
> > postpone it?
> 
> A few months ago, I planned to do it after this series. Since you all
> ask, it's not complex to have it included in this series :)
> 
> Selective sampling has two kinds of meaning like I mentioned above, so
> in the next re-spin I will implement the cmsg feature for bpf
> extension in this series. 

Great thanks.

> I'm doing the test right now. And leave
> another selective sampling small feature until the feature of tracing
> all the skbs is implemented if possible.

Can you elaborate on this other feature?
 
> >
> > Jakub brought up a great point. Our continuous deployment would not be
> > feasible without sampling. Indeed implemented using cmsg.
> 
> Right, right. I just realized that I misunderstood what Jakub offered.
> 
> >
> > I think it should be included from the initial patch series.
> 
> I agree to include this in this series. Like what I wrote in the
> previous thread, it should be simple :) And it will be manifested in
> the selftests as well.
> 
> Thanks,
> Jason



