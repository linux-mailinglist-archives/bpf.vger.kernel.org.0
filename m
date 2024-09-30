Return-Path: <bpf+bounces-40553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F267798A0B7
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 13:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9587C1F275C0
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519BC19006A;
	Mon, 30 Sep 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id4lBonL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0118E041
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695728; cv=none; b=FlZllRMbjzU6gXMgn5gy/s17Wf9mLi5q6APaR2+3vvkpcKT2Lv5z/tsW26FJhPMyFpkP4yNCCIrQOPf5K6hX0B7mRuzWEo4RD334u0ATrXOmVTMo3S9If6j6BVY26ov7NlXvd1LKu3U/3B14dVWiOjt7HgRirEtoCQLcf2FSQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695728; c=relaxed/simple;
	bh=PsKRY3t+mu9wKzJYi66xinp+sAyo/gqOgS26OaEqmuI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL23LkCgL+0P9J4iaqFueHFVHzG/2gEvJrFcwrReBqsGif8As3IZetYxYOGSyZp3iwniVKAujxw/9ccBZiYI6fZ8pw3+CtipISQlLz8dojZx27I6B9ul5TLmY69Maz1QQKIonIqouU0g0T74/pRGDPWa2odMwEmPsQAdi2KKFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id4lBonL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso1182780f8f.3
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695724; x=1728300524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ESXJjtgsAZu/gcbqpCuiFqe7wRcUYDSjFttF+hggeAI=;
        b=id4lBonLqq54JMcFbjC1MKNxj2ILQle/HHPFQu9bwnm9qzh6wO5lkgjrbuNhFar6bv
         YSEHpHxXpK0bfOUSWOsLDPVvvJhTLHgBlHG8uvLVYU0e6AZ9LRz/lAh0Ouj6mCF5DPvQ
         oJhwI9VGo2E8gnu4tik+EDk/1PzWWsuiB6wosfeC2BOW+zDxcIkW+qnSQ2AEzHhp0hkP
         DETQpHDIZ8d8OVhrtC4mjCMMn4RWvRb3jeAj3skM3aabxjqh/EJHnrNivst1xPGvRS9m
         XX7YQqbEExyA7gL8AK2y8h+c2tYHDz4/iEu56OxAVMST+Il8XN4fYImgPHGWA1S0IoH0
         mgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695724; x=1728300524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESXJjtgsAZu/gcbqpCuiFqe7wRcUYDSjFttF+hggeAI=;
        b=w0ldbE3fzgo1JtTGUHki1ous0U8kkbaOw+4XIgYGHxhqbeZ0dVdrYl4cyuOEjWeH1/
         sBbquvm+w+A4wUE/jol81fmnNTNd4Jw0no5/tPGmnCjQM9JDIEa9d7ZoyXrQHb3T+8uH
         eTYdYPziO8UDKFc0azgfSxZg/q7GS0LMJGcrTd73ZMgRiytyfIGEn3+XKm7f92HjsOPn
         TY1HsQi0gpUi2vO5/c3PtwpsEftlt8cQPQ9snknnRyIQE7PkFg0/NEYlmYvMEu1RTEjM
         fzBEGZLDhoJHcApzDq2wNFzjB8Ltj5K2gFmlz3QzE+699J2aKhblGMEcBOpoybCCr8sI
         CFWw==
X-Forwarded-Encrypted: i=1; AJvYcCUkNzL2GFGZArIB/y8EjqxHMXHPmrU79zJdhvSU5YtjIuZitSzU7eTQ7S6mvUCasqw16hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUXnEuxWDpZKcw/yfj2tBoM4YaiTlZ8WDqWNd9U8uodX4lpcs
	l5uDulUghADIIypZ9EsBWeI6dJT2LXVsz1XJT5ug40wc2eedoFtJ4uZpr5+u
X-Google-Smtp-Source: AGHT+IFIYNeB9vci2wjdzyo4jTxGHJawp/rJDnLOhHHQzs6Znc6ofZzK8m+io2q/TMu+4F5ZedmjfQ==
X-Received: by 2002:adf:fd87:0:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-37cd5a6316bmr5502529f8f.7.1727695724429;
        Mon, 30 Sep 2024 04:28:44 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742602sm8799777f8f.94.2024.09.30.04.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:28:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Sep 2024 13:28:42 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Tyrone Wu <wudevelops@gmail.com>, bpf@vger.kernel.org
Subject: Re: bpf_link_info: perf_event link info name_len field returning zero
Message-ID: <ZvqLanKfaO9dLlf4@krava>
References: <CABVU1kWEHkt+z1c0vu1bXMn81iY8rDjwU=B6KPi2dPVvgeZUPw@mail.gmail.com>
 <CAEf4Bzbeqj3qneOEvKqcMf2XYx-1E=RKcAMo2L2oJz4qqqKbuA@mail.gmail.com>
 <CALOAHbBTLXWJ5EnXUzD-nGFxes-Q+Wu_-KPDZWHUKFfXsvdM0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBTLXWJ5EnXUzD-nGFxes-Q+Wu_-KPDZWHUKFfXsvdM0w@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:35:49AM +0800, Yafang Shao wrote:
> On Sat, Sep 28, 2024 at 7:14 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Sep 22, 2024 at 12:59 PM Tyrone Wu <wudevelops@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > When retrieving bpf_link_info.perf_event kprobe/uprobe/tracepoint
> > > data, I noticed that the name_len field always returns 0. After some
> > > digging, I see that name_len is never actually populated, which
> > > explains the 0 value.
> > >
> > > I expected it to function similarly to
> > > bpf_link_info.raw_tracepoint.tp_name_len, where that field is filled
> > > with the length of tp_name. However, I noticed that the selftest
> > > explicitly asserts that name_len should be 0. I was wondering if
> > > someone could clarify whether it is intended for the
> > > bpf_link_info.perf_event name_len field to not be populated.
> >
> > This sounds like a bug. It should behave consistently with the other
> > users of input/output string buffer size fields: on input we get
> > maximum buffer size, on output we should put an actual size of the
> > string (especially if it was truncated).
> >
> > Yafang, Jiri, WDYT?
> 
> The reason name_len is 0 is that the user did not set both the buffer
> and the length. IOW, this happens when the user buffer is NULL and the
> input length is 0. However, we should make this behavior consistent by
> returning the actual size to the user if both the buffer and length
> are unset.

yep, makes sense the same way rawtp does that

thanks,
jirka

