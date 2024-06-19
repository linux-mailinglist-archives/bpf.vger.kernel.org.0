Return-Path: <bpf+bounces-32534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1874F90F76C
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2998C1C21365
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24285158DCF;
	Wed, 19 Jun 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfEcsEyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF43A55
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827944; cv=none; b=CsgaHLZrig9Y1Da9w0ACE903RIyAlNyE2qmj3le3MsQ0CUGxtWJhDph2yiNSCf/LkGIAwwjy4KpxTbbUQ9XCOPNDWNQneinco49okduujmb//WOrj5qileCqoUD7BYaenblGjIPSWHZ7/iDSY3tehC/GROJlwmuYzpJ6kqYhFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827944; c=relaxed/simple;
	bh=ePNpb0Zruhpgy4cyPMqr1FgEBqTs7imidwX3E9/AG+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8XVjWYhRnMnx/mwJ3KEzQ0ApIVL9PEGFR544GmeOyYMSi/Ld48zD8J4D8rrCpWLuQSrH8yF1YsrqP/2oS9akKqF/YzAo+1mT58eIA3jd1e0aBvGoWi+8I/QpvOONkZaXjhyQMvS7IgjqztU8nf01PwfkDsQR0dzkGssLwBMVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfEcsEyy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-70df213542bso133329a12.3
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718827943; x=1719432743; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePNpb0Zruhpgy4cyPMqr1FgEBqTs7imidwX3E9/AG+E=;
        b=JfEcsEyygpyj6Oji3BzvPQ5v9eOiegyWWgXR4/6QFD0qkHo9c9HjOa152z5JqM2k/w
         2DeiaKhMDwkUtKIi3y5ZGOf7XL61l6Id/8D0ySN+204hw4khhpYWGYpoPH+dmeSAvPiQ
         sjkb/1rk1ARIUlyXigiM1dIE/05KB+6KVfn3q4vmtkL5nRW4Locxc/nmB/RSJ45aFney
         9URlKiNmU/fIqPXPOd/K9wiT7ijDr0RBM2YicLoZ8Sbrkn0VPPQTndz6RKMkhx+kSaaa
         amPJXwyvnW7stC6DmZsQn4WeRjdasyVTBPj51YZVyp0VTXHd+BKxs/1rM1vlSS+2gDFG
         ILVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718827943; x=1719432743;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePNpb0Zruhpgy4cyPMqr1FgEBqTs7imidwX3E9/AG+E=;
        b=QJpn3okUO5+eBIsXrNlYsU7+o7uvy9jwdSeq2wG+NjhO36h7nF8xyFD4zXdbCPW4eT
         kEVWQQQNiT9wQbh6PQ2pXNCSdFk0yht9FYCX15jvEFfC/zFYoxGItj1w9oPtiwY/LF+E
         XVjZGB+J9mn0jzxtdIAmvFEWWzPdgcTAVy0jAMyVKsOlQTQDYPW+EN1dO8nwy9+b0TtU
         QTkHld8KBDtE4kvfnU0Nf6Ky6velNaHfXxIWGubGgo8VGlfleEdEJlCTaZ3bDMH+KJYl
         HvoXkfttvth40JAz9rGeKyfB5Ic4bRWnvlWBDyHnUD3P40sbcX+zX/orqv/cMMNiM90a
         CvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7fKkkm7DghFQfeh5wJ6vkO6mxkpubcqky2fgQKeQXyc+qcoqHLJrUgICI9jb5f6M/W083LDrSBMar7eVY8ajWZ85g
X-Gm-Message-State: AOJu0YwmYrXQEpPYcwrgreRLM4pcWpM9nNkCTg6Os6U773Pq4w06AhGz
	ZgSJ1XKuwBKR1/Rb2oz982unKjMJP1eSPAcwcBiJZIUSLtVtrgl7
X-Google-Smtp-Source: AGHT+IEA3BQNgbIFtcE1uLmC6Z9UKULIYlVXg6K4cA/XXregW1B2hIwrZ0oMkxGd3k/vhJTPfoC9Og==
X-Received: by 2002:a17:902:e84d:b0:1f9:c1f0:7150 with SMTP id d9443c01a7336-1f9c1f076e7mr11247235ad.8.1718827942653;
        Wed, 19 Jun 2024 13:12:22 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55eb0sm122361945ad.18.2024.06.19.13.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:12:22 -0700 (PDT)
Message-ID: <e17f8c4d644a6f4aa80de092ee29e6c1e5e77c52.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
  martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com,  mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, mykolal@fb.com,  thinker.li@gmail.com,
 bentiss@kernel.org, tanggeliang@kylinos.cn, bpf <bpf@vger.kernel.org>
Date: Wed, 19 Jun 2024 13:12:17 -0700
In-Reply-To: <9359e765-c341-4164-90fd-78feafed89d5@oracle.com>
References: <20240618160454.801527-1-alan.maguire@oracle.com>
	 <20240618160454.801527-6-alan.maguire@oracle.com>
	 <4321b99db5b362e278b1f37d6bd9b9a43d859d63.camel@gmail.com>
	 <76509fc5411e35a4820c333abca155b3fa4e5b84.camel@gmail.com>
	 <44779d5f-6d54-43cb-b556-d62201765c9d@oracle.com>
	 <3396181b67ff82ba8d25a620a72353989d733fc2.camel@gmail.com>
	 <9359e765-c341-4164-90fd-78feafed89d5@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 18:42 +0100, Alan Maguire wrote:

[...]

> Sorry, I'm not following here. So I think what you'd like is a way to
> verify that the dtor actually runs, is that right? The problem there is
> that the map cleanup gets run when the skeleton gets destroyed, but then
> it's too late then to collect a count value via that BPF object.
>=20
> The only thing I can think of is to create an additional tracing object
> that we separately load/attach to bpf_testmod_ctx_release() prior to
> running kfunc call tests to verify that the destructor fires on cleanup
> of the kfunc test skeletons. Is that what you have in mind? Thanks!

Tracing program could be an option, yes.
I was thinking about some map created by the driver program (the one
from prog_tests) that could be updated by destructor.
There is a question of how to pass the map FD to the kfunc,
probably it could be passed in a constructor for the kfunc and stored
in the context. But tracing program sounds good as well.

Again, it might be the case that checking that registration logic
works is sufficient. In such a case bodies of both kfunc and BPF
program could be empty.


