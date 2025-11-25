Return-Path: <bpf+bounces-75484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7EC863A2
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C88E14E50D4
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 17:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3596329392;
	Tue, 25 Nov 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i76qlwGJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B41VEsxl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E7207A0B
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092137; cv=none; b=Fso65vmLnGy5/95IylGso9Ub3niBFZPkqFyqjXzE9tsMA4Y9Po6EYiVarWTM58v4iNjSn15B/0RGIjvkf9i9t1jHrBZvmInVLDm6wTqKbD0UbvFo7iSQnYWVl+2Yn2WSMqEDf2RFC1OYAO4F/GjmcA0Eg+4umsWO+BmYUabFYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092137; c=relaxed/simple;
	bh=ZJRD93ay2tdPE4YsyhohM/u8pTl4h+slwsZ1hHGrZ9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqpPFr3MUZdgbheIJ4cnOCG/BbFiJlEUxi+/b3Xww2LyFe0SzKKFErSW5AUbjrGyno1pPtcWCIPhcBseEsZF+16P4N0a8EI0SgMZrqN+ckl4BbE7+QYa8c/G+UcxsaxvaOTsf0kyj/eLEZsjCc6QTvqbFQL5GGYjsOJ374ZlUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i76qlwGJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B41VEsxl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764092135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zNoltlboUskJRQ3bOMiSb7Jg1xFgwMkPeBsE8D53FQ=;
	b=i76qlwGJL7IRfQzCCFwcIYLrQBGvfvE5oKGd5Ycc52+4o1+gH1han7bz3YIXfB+a6i26qC
	5wULXHdNIPHc2rtoSBcdhDt9hKzaXp2EdYuzza5cgxZntXL/GaObi35YQY8bowjAaD2r1p
	0JfdmyBp9lvbmIbDLGVzIKvwxWNqIaA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-VKNekm6pPGyG5Dgyl3jyqQ-1; Tue, 25 Nov 2025 12:35:32 -0500
X-MC-Unique: VKNekm6pPGyG5Dgyl3jyqQ-1
X-Mimecast-MFC-AGG-ID: VKNekm6pPGyG5Dgyl3jyqQ_1764092132
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433817220f5so283105ab.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 09:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764092132; x=1764696932; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+zNoltlboUskJRQ3bOMiSb7Jg1xFgwMkPeBsE8D53FQ=;
        b=B41VEsxlbbJop49v+ZPWVHjxEzQjxiJy0feBaHvzHhTPjlSRCUzZNH4I78NZQlyVqI
         DsVElzpbWyBhdY6U8Gi63xxNdYusVySlgiWLzelmtA2+73fTlulHu8ygD7jb4Xen6Ao0
         G3b+ULzrfyCzVo3iFC9N/Dsx37w50Ark9pF9g9vtj2wEZ8AWYBTfK94qUaurBYjrXCsS
         BBveGxos1F7Q4IawR7pNLj17qiAEOXQBo0+Dd+jynG8wP3oYr+Fdy/bobVJyNGb5URl9
         TG0KTP5WvnuPxtkq5Gsm+oW4wSjmPkbef2bn9eo0i0FEacYx0Y98dg95ssHxTXkjwmP+
         H0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092132; x=1764696932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zNoltlboUskJRQ3bOMiSb7Jg1xFgwMkPeBsE8D53FQ=;
        b=oXi1CNfhrumNKUcQOy6+mvKRpP59gd/LPTsNllPmKIvcdLvgJ3+ZvzLpfherAU8Xea
         WVXvPWF1CG2bqK6M1+yF46EgX+1ryUTYb9pevBS0nDS/7d/ruE6d2sxbre56cx5WKvB4
         HVbT+rR8szcscyGk6egDsqm0i1a1xQfw9iYwvo0nWJVfc4AxUNfq7sLqjy5KMZirKqV/
         dtE02wgvhpH83XMpCFpBWqrdDAbG6X/lQucP3jI8NK6MMAJdPRR7BGCUqpW0gYNiBNCe
         yLEUHWPHcbr1jpxRtEBLjIpmvYth8CjswAG2ltK/spFysUDyEwyUpMj0KCkWSlnps6YR
         HsCA==
X-Forwarded-Encrypted: i=1; AJvYcCUJHlxype4uYOUyqX2bAGR4q36tNPb63xhMW5OY1XSeQAyttzCJMgyXhYMx4IGUyQfX7eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0jG5KWqIWeyHit8PlQwOa8ALncDGbnork3POWfhIrSAsfa1E
	jINAFgB6uU1A1kAHUMaciiMpvWXXYiD0h+QS7ayWne1FKZWnjVw7bkm+uD21MxRksbTB9u2mMiG
	Nwp0k/l6itAbZBkBHfNBXVpusbVrGSZ62iOHkFd1FFrjd61m6etZiPQ==
X-Gm-Gg: ASbGnctBtG6cBfTUocsGUfGniZK7+34hKFPBzKtt1l94Q9471VdPgKkciOlzpuKOoLG
	oB9fwIrQFqZNO6a0q3bbSoJR/Q1Ji1b2kwE3CE9R1XiqO09dEuYozIyt3GwwfU7XJ+sIqUDz/HH
	qHcT4eFOEagjUx8vzF5/hyGuNA9OMrhEh1Qop1XNHzAqKX0wbiKs1O1DnmxJw0xx5Jn2HJuFGgi
	zMrZgKz+y5F0Evnmd8KO3doLn5I4UD2wUYYVzDe0jzWKFNxJVdZHRgX25ylI5cGZ+WJG+H7mYOT
	qLoR16EVDVfIkOGHvJ8xGBjN0U6FO4N1XHRc4qJPJor81CqR5aXgnwlT4j+HK+6/3K5bOp0SusP
	7RICyypE6KkSU2ZIpgz3iCYVr/2E=
X-Received: by 2002:a05:6e02:164b:b0:433:794c:8486 with SMTP id e9e14a558f8ab-435b903285emr154304755ab.2.1764092132077;
        Tue, 25 Nov 2025 09:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQpEaWyvqTxiWt6WF7K+P/ZxKH4Z0wrrwRwjmou3enox+OlV+PF9m82sbkyvSiX7SS8Gv+PA==
X-Received: by 2002:a05:6e02:164b:b0:433:794c:8486 with SMTP id e9e14a558f8ab-435b903285emr154304505ab.2.1764092131768;
        Tue, 25 Nov 2025 09:35:31 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9056bdasm77369065ab.4.2025.11.25.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:35:31 -0800 (PST)
Message-ID: <99c2109dd8c4b65be34f5ee00575a267da10b002.camel@redhat.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur
 <jkacur@redhat.com>, Costa Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, "open list:Real-time Linux Analysis (RTLA) tools"
	 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Tue, 25 Nov 2025 11:35:30 -0600
In-Reply-To: <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-8-wander@redhat.com>
	 <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
	 <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 11:20 -0300, Wander Lairson Costa wrote:
> On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com> =
wrote:
> >=20
> > On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
>=20
> > > +
> > > +                     if (timerlat_bpf_restart_tracing()) {
> > > +                             err_msg("Error restarting BPF trace\n")=
;
> > > +                             return -1;
> > > +                     }
> >=20
> > [insert rant about not being able to use exceptions in userspace code i=
n
> > the year 2025]
> >=20
>=20
> I actually find exceptions an anti-pattern. Modern languages like Zig,
> Go and Rust came back to error returning.

Maybe I'm behind the times, but I see exceptions and error returns as
complementary... not everything should be an exception and I can
certainly see how they could be overused in an anti-pattern way, but
they're nice for getting useful information out rather than "something
failed" without having to add a bunch of debug prints.

-Crystal


