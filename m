Return-Path: <bpf+bounces-20250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AE83B084
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBBE2824E0
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB529129A6D;
	Wed, 24 Jan 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJFqzfm8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304A7A711;
	Wed, 24 Jan 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118748; cv=none; b=p5Rk89/HbXZelz3CnZynThMYKn/UKROLw7mqwuty30W5OhHKTmXfvHUYb3RGlFbGN2RFhf8sC9FRMLRipVPM539y6KvN1y5McyQes1OcljGkrS7gniUZuQpLxh/PhDteSjhAFpEvg+i0qXELuJrIOUekoRwxZUr/iLmpqMuZ7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118748; c=relaxed/simple;
	bh=iaM0f7Mu+VndqV8QTAWSCtIFAiLhckKr1QXjBV9VlbM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ixrr5ywMzFBq1J4pi3d1VROPJjfzhsIF7Ch3bUqwR7P00ne5D/rx88c5Af5ummIHBKTn0z14Qc2cJlQZ1gZgw1fxvkoOa8TV4g55bkPMnELOt/VrXmkSOnMFi5fObpxKGXiZZiCcI1MJJDjJFs2mh393SWweCI+sBjKQfCkSfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJFqzfm8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71cb97937so36287565ad.3;
        Wed, 24 Jan 2024 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118746; x=1706723546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zISETwUy9JllYHs6YyNzxbyZFYMacyxOxCvaHnvxTM=;
        b=XJFqzfm8GB4R7lurYTYuHm0ymkLI9u98F/3S7QVUYvylBsivYQ63JFYgGgN2OI/30X
         6TB8qz/P6tioDhRjJyqViZZrXqJ5Ojlu2WpZSc5Vf0ZmU0+OtTSjWEuX4fiwZXjk5OcR
         yVMMzmPfCvR1IZN2QJf1NbrRIZxKg0qIMWskjmSWtaNJx/s/SmuPzePgqLXqkUMW/jvR
         qg68hITwPakuwSOkLI+xNiPl5rrjGPXZHa3iJnqY/lVEkoL8U6zUXLJZSu5qRF0wQ+Al
         lfjLPYdeU7b9hKps4q6vIVuKCEtCeGxwtgGGd7uZr+B7+I0c0kLX3YXtIhZ2BpzvFhHR
         3Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118746; x=1706723546;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0zISETwUy9JllYHs6YyNzxbyZFYMacyxOxCvaHnvxTM=;
        b=i0oivX4/0dwx5aHNvyy3Ir7uG4/5IoFkvZ/uykk2Vvj1A6hlrCod1hBF3ZvO4qRuN8
         S00Hj0I+Yy6l+rDHSPfKurHLqXp4499zNgvQ0KHsBhAwkFSqAzTFOGDCRWeE1A29GGRh
         l1gXJKt8PKfhWroyBOw3MZTxwNiFAGTrE4BWlQjJz3dM1n99ZUrzCrf9E3er9wSrJFgj
         +YZgTi2+H/kJFmSkVsPDMEX1ZYnb4gNgWDitTngBm7B5dlI6VnSsCMUEvJgSMaYZVQU6
         UryEm9QmiZmSvRXRzdYBSQbe1SKu4A4iU7HgmYynAjgEBpBSbpfqIGKD5klHwxO0KuHD
         18Mw==
X-Gm-Message-State: AOJu0YxXKqaFxvG2Q7DAEx0TpeFeTUAugW9n6zWJpQW/+EPsd1I62w/6
	v8xN/OjPRllGHcq82ok8wghw0DXiEtKmjQreqFUevdH45b21HWvK+FNP4jZa
X-Google-Smtp-Source: AGHT+IHTIgVg35qiFiou5PoLiHwCviuNaDj3LTJKrkkENoAKyEmS1B3tpLwagEe3EtmWwYwQZ4Rf5Q==
X-Received: by 2002:a17:902:e74d:b0:1d3:4860:591b with SMTP id p13-20020a170902e74d00b001d34860591bmr1261930plf.0.1706118746069;
        Wed, 24 Jan 2024 09:52:26 -0800 (PST)
Received: from localhost ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001d4ac8ac969sm10679985plh.275.2024.01.24.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:52:25 -0800 (PST)
Date: Wed, 24 Jan 2024 09:52:24 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, 
 jakub@cloudflare.com, 
 bpf@vger.kernel.org
Message-ID: <65b14e583fb27_1033b520820@john.notmuch>
In-Reply-To: <CAEf4BzbkGuDH91X2KaA=448HoZD0m09qQrBDvBxFwdTLTF7JFw@mail.gmail.com>
References: <20240123223612.1015788-1-john.fastabend@gmail.com>
 <65b0776bd8ee2_fbe42208b8@john.notmuch>
 <CAEf4BzbkGuDH91X2KaA=448HoZD0m09qQrBDvBxFwdTLTF7JFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] transition sockmap testing to test_progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> On Tue, Jan 23, 2024 at 6:35=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> >
> > John Fastabend wrote:
> > > Its much easier to write and read tests than it was when sockmap wa=
s
> > > originally created. At that time we created a test_sockmap prog tha=
t
> > > did sockmap tests. But, its showing its age now. For example it rea=
ds
> > > user vars out of maps, is hard to run targetted tests, has a differ=
ent
> > > format from the familiar test_progs and so on.
> > >
> > > I recently thought there was an issue with pop helpers so I created=

> > > some tests to try and track it down. It turns out it was a bug in t=
he
> > > BPF program we had not the kernel. But, I think it makes sense to
> > > start deprecating test_sockmap and converting these to the nicer
> > > test_progs.
> > >
> > > So this is a first round of test_prog tests for sockmap cork and
> > > pop helpers. I'll add push and pull tests shortly. I think its fine=
,
> > > maybe preferred to review smaller patchsets, to send these
> > > incrementally as I get them created.
> > >
> > > Thanks!
> > >
> > > John Fastabend (4):
> > >   bpf: Add modern test for sk_msg prog pop msg header
> > >   bpf: sockmap, add a sendmsg test so we can check that path
> > >   bpf: sockmap, add a cork to force buffering of the scatterlist
> > >   bpf: sockmap test cork and pop combined
> > >
> > >  .../bpf/prog_tests/sockmap_helpers.h          |  18 +
> > >  .../bpf/prog_tests/sockmap_msg_helpers.c      | 351 ++++++++++++++=
++++
> > >  .../bpf/progs/test_sockmap_msg_helpers.c      |  67 ++++
> > >  3 files changed, 436 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_=
msg_helpers.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_=
msg_helpers.c
> > >
> > > --
> > > 2.33.0
> > >
> >
> > Will need a v2 to fixup a couple things here. Thanks.
> >
> =

> Can you please also try compiling selftests with `make RELEASE=3D1` and=

> making sure the compiler doesn't complain about uninitialized
> variables and such. Unfortunately we don't do this automatically in CI
> yet.

Yep thats what I realized I missed after submitting. Thanks.=

