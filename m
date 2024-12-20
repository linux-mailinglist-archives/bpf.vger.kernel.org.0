Return-Path: <bpf+bounces-47442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31529F9757
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0E016800E
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5621D5AF;
	Fri, 20 Dec 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbxaxhmA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39A21D5A1;
	Fri, 20 Dec 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713821; cv=none; b=XqTi7YykKDbob+7/fwJwyxEvrUKOn0nnPDOUpU+DK4/72EhF92u39Xw8mFkl9qEZDPw+wk3Q3hvywSS9rXXsbaefUFjjZUDB/oM4G9wMR4N6PNGSYSkJluxrNI8K37q5PsSMjIMFZIbOReEMMwuGFH/0BAndJhOzLwuJCfhhrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713821; c=relaxed/simple;
	bh=d+GA7GcPOpp7dHp7E+qaOU6Rta1LCa/juDgxY8+FH7w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pwnQS/Gwey9ofWN1P8Q+DrTioIfYS7F2qIbZdIAT7vg8V+WicqVzTojglacrQ0b7HtvJQex9iaJAnw/M6d2gwX6CepRchw8cFxLOZYEYHBCvKn0pyEws0KoNLLLD+fAvByO1W4W6j7lL5/Eq7nRAR0DXfWy+yxPOB2j7PkBRjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbxaxhmA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so1577899a12.1;
        Fri, 20 Dec 2024 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734713819; x=1735318619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+GA7GcPOpp7dHp7E+qaOU6Rta1LCa/juDgxY8+FH7w=;
        b=BbxaxhmApmLfGU4RHBNa+2mMueNM1GYgXxWATktEAez8iMCZV+6kDVDHefg1oUaVbE
         0xcL7h9nDgYAqo1SPGozWfg2omerzPB85GfT73+N5bpHjWamOeXNTlbY3Py95f6qmHvX
         a0cUhqD3VqstWdRYGCHDPPdzt+Jcon1kXYR9X4Z5lu6L7ICR6MYPdrOBkYFv3ZtCeDTK
         SbNInQOPGbMBCF7CbEeMnzMg5qhLcZFyB+j5WbdPmCRT3bcUdOgAtQ5ZsqhDXnvr0+eb
         aoXx+SRC0UPuIo1Bokzqeen4k6a3K607ll1Y3cMUGKbMwiOTrZFmsa9gNjCHwMLNoHf7
         S8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734713819; x=1735318619;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d+GA7GcPOpp7dHp7E+qaOU6Rta1LCa/juDgxY8+FH7w=;
        b=ZLeIPg6EOlv7ewltHhe/Il2DJLzIw7+HPtSPJHXBRXbSnxO3JvnWMD6A+eHzG9Pz0a
         3II8KRx6HdTPBULjE3FgG8z2cEWeY0UhVVdKa/ZRQ4KVmmvD3hkHJr97GdBSb/MOgLMN
         x7OR7K3cOlQF0NDi60xpP3nafxp+xLYYvw3LYFetBfBvkNCBxedK3NctnfiEmv8gQpZV
         jHbWiUycZGgYqetokpD0jxTVwUEq/Sptnq6+lzeelZv+jyo07MTELZIu2HL8pFOQE3sg
         7CscwifCpYLieC7DCb9YMj3Ne/Gu/3xMFPufz6RQJLH4ZH8uhz8ZLTbD5IwxfO/l+KUj
         WYzg==
X-Forwarded-Encrypted: i=1; AJvYcCU5HeSfvVoQ/xy9ty7Lcm8SOi5Q7USMXInm2jAj97qLRiSULgESOouNVFd++Im24lHDz028I665@vger.kernel.org, AJvYcCUoVWUgI04w7CHI5siDLMtSxTXpzV7xMOI/fZ0oMYPpLbi2CbrESrBInAeBUIDQhDClIMpuxQrCXrQFekvQ@vger.kernel.org, AJvYcCVA+VoLIljS5Tdb89f8wvPNpOzgLzwLsBBv/6NUNWeStGAYYxEQgldUzmo1s5yFage/T60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdrI/eRpgVqyCRXar0nnUGs3ptMSH/Ry8AuFfO5D7ingBs+kW
	N5ahR0OvwVKWG/1jxMKxTmxYjneEOhMXuRYvVwXzJ/RSPgS7LQrC
X-Gm-Gg: ASbGncvrolKYma8pS3XwgW6fIbF59U10qBCy1yKu5HyMHe8qiIVihAZOS2lsZtmA5U1
	N2F5IMCamanVX5ls5Xwh/zRI9iR/W84LGj6VaMTQbRSko/7ZInNaVXuDhFgmRWCF6m711aOYanv
	CO8LEwNGt+Kdt067bLyHwqPmdxfoEP8qGgI2EcUWIaEpIQCnSQel3IGcOkd8ap+vdq6O6jnpfye
	r1aXRr/EnDEyL8As6ovYYh1BEDClQVMaKVIfyCx1KTxbayzMrAwqd4=
X-Google-Smtp-Source: AGHT+IH3b/UpGbIjmzr542Y/GP3VuAaB1OoasMTXSJXqS4CXShcI4clcSjJsbJG8m8lNnm4IDQA9BQ==
X-Received: by 2002:a17:90b:6c6:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2f452ee08f0mr5070541a91.32.1734713819567;
        Fri, 20 Dec 2024 08:56:59 -0800 (PST)
Received: from localhost ([98.97.44.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dd84sm5985955a91.38.2024.12.20.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:56:58 -0800 (PST)
Date: Fri, 20 Dec 2024 08:56:56 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Levi Zim <rsworktech@outlook.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6765a1d89686a_21de220813@john.notmuch>
In-Reply-To: <87h66yafqv.fsf@all.your.base.are.belong.to.us>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
 <MEYP282MB2312EE60BC5A38AEB4D77BA9C6372@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <87y10e1fij.fsf@all.your.base.are.belong.to.us>
 <87msgs9gmp.fsf@all.your.base.are.belong.to.us>
 <6765231ce87bd_4e17208be@john.notmuch>
 <87h66yafqv.fsf@all.your.base.are.belong.to.us>
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel wrote:
> John Fastabend <john.fastabend@gmail.com> writes:
> =

> >> Took the series for a run, and it does solve crash, but I'm getting
> >> additional failures:
> >
> > Thanks! I'm guessing those tests were failing even without the patch
> > though right?
> =

> Correct.

Thanks Bjorn!

> =

> test_sockmap did however pass the full suite in 6.12. So, something
> changed with the addition of [1].

Agree with finding this. I also have a compliance test failing in one
of our nginx/apache/bpf test suites so might be related. I'll dig into
it.

> =

> I guess:
> =

> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Because when I find the bug that gets here I would have stacked this on
top of any fix as well I think lets apply this now.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

> =

> can be added to this series, and not crashing is nice, but it would be
> interesting to know how it got there.
> =

> =

> Bj=C3=B6rn
> =

> =

> [1] https://lore.kernel.org/all/20241106222520.527076-1-zijianzhang@byt=
edance.com/
> =




