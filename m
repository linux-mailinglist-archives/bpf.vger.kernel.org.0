Return-Path: <bpf+bounces-45423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD919D560C
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53BBB21450
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745A1DE2A0;
	Thu, 21 Nov 2024 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4ueFbUD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2B23098E
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230577; cv=none; b=KvUpmPDnPQvoPGAbWg5EOUOx37q275Sp+BvqdRkXpDpeSSkfoemPUx4CT0cnorYm3xncn2L1ndNUfdkW9viEvX+Blk/kb+cDROmadRpScejI8r1/Z4NleQuCjmbKXMgvf3KskcrpIN0t2k1dFQMQkyDhiTpKhRblUbgL2bO6Qr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230577; c=relaxed/simple;
	bh=htdqicJ1jbvSYHjGLAmr/3FoSHN8+GNOShnisVZdoSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzuZ/BB5E6hItnmsHopBqAJ2izDvxwzcvm409OGBsnRrIv7V52FiG4tapixDKyZNTCqtwSJRZxqXBKDm+Hak5PG/6PC4eaFh/J93dV85tnclyZpBNVz3i5oUPz2jKu8bfMehlzbwMWFtrrZKPpPUgYPI+p35Ij7KD4mnGLHhNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4ueFbUD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21288ce11d7so12206585ad.2
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732230575; x=1732835375; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dDhEr+LvJnAy73fEWwOmmxZrvp1vutDND283NQH8rsA=;
        b=W4ueFbUD8KtnOiTo2cLXzu4hlQaAOFDJo2hjzliUFltWSsbuEqNSigJYbSDBOxIwf9
         OWhCYmgC3x8kTQwMwa2MnnlqjD1WD20UjnJOMcialH1yNssJfW+Fg//35BVj2iB7ulL5
         2nYnSg/mBfaBmN73MD7pBK+ZqftTHrp2lev908R6FV2RqdmWY7y8ymgrF/tpDAvn7G+N
         vh/NpfeCBBS2l19C3cqPrML0I3XVrhpFz3TdvUUBdVUSFEJhJx8HfiI6epKZGdKNQO9y
         eDtMtwPHxK/ZSdOJDHb8Ll1LgY7yY8DvqGmQSWDLgzvzm53UVNbv1yLXAJCVwkKyaNkr
         4k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732230575; x=1732835375;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDhEr+LvJnAy73fEWwOmmxZrvp1vutDND283NQH8rsA=;
        b=XJ272COQo2YMPwK6VLwyXQn4JDNSyI71L1abtqhF9bTa5O70Bxwy92iZAv+bRLqo17
         ejdYrwq9TGXorB4v9Br2L5pF3WBV56prRKbrjtCZ2uI3Fiqwj5u5+BhxiL/3wzANlQWE
         8xRLJtc+TaKu8WaqoK2DAmieVb+3aktEAbNTmhr85d6piJyEOBiKXaC1dyHxX+j14kZP
         q2sP4NAHV8eJ0OdvKcOA5uOby2nj2A88eKynn6Otw5Lz2NEsRPmuv/ZRfFxSGj6kaKfX
         lly00sSpib1OCr8+r/+PxB3b+9zBaI/5Fe9lwAb0qAATbmMUIWPcIIJxs+8uLObg4O2G
         GLSA==
X-Gm-Message-State: AOJu0YzAtS0Hm7o/XQM5Yk+qSbMgERYVCuLgEnHOlBOEjDqqMDxvloCl
	WfdVN2Pbt3oXmQRIdk4EwLugkSEiyZpYDhHHnAoQe1xIZXtrybTRNJMXOw==
X-Gm-Gg: ASbGncsM4mzCFlSgUr0lKEMF1yimPOQmnT0mo/PAhT8NRUABKPUD7VYAJVWvsSBXayE
	X+kmMuX2usTeb0DaWllIN80hxBv39ZvZ3g5CvMLxUd9zCuHQy3GMYOzk+Cd4UGvg0g8TeA3zINu
	ct7177GofsrcIESPfVrJdFtrt4iO7D4F4MQpasCGMk3Gp+sAymTbnaNquJlF5oLS9Rnxm9tVOW/
	IJLQI5etEVJdGU0XvDnlNei2DpDVYgDY5jXbd93GBzEH9o=
X-Google-Smtp-Source: AGHT+IH7nSWfSKfRlSfwyHWVmcySi48G6T143pUBWQLEm4tll40zfI0zi31lYseyCLDXiIddTG1dHw==
X-Received: by 2002:a17:902:f608:b0:20c:6bff:fca1 with SMTP id d9443c01a7336-2129f23f12emr12430855ad.23.1732230575256;
        Thu, 21 Nov 2024 15:09:35 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbf9d37sm3574565ad.155.2024.11.21.15.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 15:09:34 -0800 (PST)
Message-ID: <a95e5dbc5ecf93405ccc2ce8e64cd5ae625d1157.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/7] selftests/bpf: Add IRQ save/restore
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Thu, 21 Nov 2024 15:09:30 -0800
In-Reply-To: <CAP01T74Jb02yxHT9x72PVCUtGoWVZ09v4nHq_RDKYQG0489VYQ@mail.gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-8-memxor@gmail.com>
	 <8db8d815dc263edd8d3883a770c0bc0ac511dd77.camel@gmail.com>
	 <CAP01T74Jb02yxHT9x72PVCUtGoWVZ09v4nHq_RDKYQG0489VYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-21 at 23:07 +0100, Kumar Kartikeya Dwivedi wrote:

[...]

> > > +SEC("?tc")
> > > +__success
> > > +int irq_balance_n_subprog(struct __sk_buff *ctx)
> >=20
> > Nit: don't think this test adds much given irq_balance_n()
> >      and irq_balance_subprog().
>=20
> My idea with both of these was to ensure when the state is copied in
> and out on calls and when we're doing one or more than one
> save/restore (which links prev_id into active_irq_id etc.) we don't
> have problems, so they were definitely testing different scenarios.
> But with the move into bpf_verifier_state they will indeed become
> redundant, so I'm going to drop them in v2.

Understood, thank you for explaining.


