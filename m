Return-Path: <bpf+bounces-53965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CBA5FBB0
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D525188A0B1
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54067269D09;
	Thu, 13 Mar 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf5EJQiq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF628633F;
	Thu, 13 Mar 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883196; cv=none; b=QJnlNZEIriI46bn+5rPdKhNrIo5O8NV6cGX99vziCixfEcw6vts3GdsoO4eipakQs3RLN4vHvkBUplJ3+bAhxmKey4SVOgpfFcxd7LraD+yfN51BdU1cSzvxtPvHwxvCXVjWKoCfQKIOHcuARd4JpY6qpa2HLVcFDoMu3AbDY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883196; c=relaxed/simple;
	bh=QtQeFXXUyqLXG+oE2hxpLfZohC2eCqSYFWR9RbXR29s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0h9JscqjkKhgLsggA/EhNdMYDZAGoO/K6MGTyo6fX4z96OBkK+7tT2ruOKOuiiGHpPrnUjkyCrYWL7zY6d3T5tVkCFDMA1YPcrhnRnlxYX5yJd6FxuzOj5UjTV3Q8OfWpULDMZXGFX+Qr63uOcToZ1Xe4OOaJnZEfMlrB+g6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf5EJQiq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so2124324a91.0;
        Thu, 13 Mar 2025 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883194; x=1742487994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dj58qb5Fdu7jAiSs8njputJgR05+QajXZnrH30MR1c=;
        b=mf5EJQiqQ8+OohbZIxgzKw4VgejS0dfHWRTzV9HxLuP38mkTye9drfpWqv/TKd4eV4
         t+m01QnXvanD2VbFhkDzDzQDBW6MauUK+1KGeOl4/F7M+xCegOIqlMUn4yxe6PPm4aqc
         Os988q+DpNEoWHrCGop4/JDhjgENuiFqGI0hl7mHGB0Qg71R3EHRgVncGOMsXCcZULID
         V+sUZpIOqe5ltdBDsrFU8DdNMWmpEKM4EA9VnlkaNaJX7xQRYMa+X7zTw5dNAxDwpeMn
         gmMwj60Mz+RXYn6rAqpCU7oT4FQ6jFqGIhB2lMRAU/lCuuL0xKvltCZghFiPEpkWQMAh
         np8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883194; x=1742487994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Dj58qb5Fdu7jAiSs8njputJgR05+QajXZnrH30MR1c=;
        b=fzAbB+QtKO7WGluPgh4Smie6ysRLNDFzX5JoZvhaD1yLcZgvEohPh2z8lMuc6aa3c2
         Hsi7b9ICWgBTaW2KT9cmEu6JMLUpSMLiGA5emxp88drY8/2cbU+zt7iWejhMoADnq4hV
         Y5jSxR8XtT3mqqwK0e4lzz4jGq0ig2RKnWulTpsd9CgCxc4KvumZ+yBlJCYAz7bsmX1z
         pjuVUbE4vS/mUAO6WhYKAyFJ7RHFXIWSuOePN6D8rB62NO47Jgt0qYqKTXY7h5m+7yHi
         0wApn0F02cde0MRC51EqL4pfSilZOtVJu22xCcpYz6XK/CgkcGK3HCVzxQDuKnU0Vfp4
         VAyA==
X-Forwarded-Encrypted: i=1; AJvYcCUPKqUgt96MAnD8qxgpOAWawBykIlacxEKagMTQGJtsepDBP1AyY6sw4Mfri1kgYwV2OKDOXyqzlRM16UMilJw=@vger.kernel.org, AJvYcCUlz8cvj0EF8mksDCcKJJKhl7UkugoyDbzFppBpst5Uh3vaIEYWYdKaXt8glgMsQUX71Zs=@vger.kernel.org, AJvYcCWsuFRYPxe5GcxSKhZj0eEwgCgS8runboRYXPr9QQiLscabLJKdmJizeOR/KJUWPw7sqa4+EwzxlPfIGqY=@vger.kernel.org, AJvYcCX+EH/tkzAiz2IYPZDk8KSPH6/qi4I66aNxVDgPrLh1mJx7NO8+HcqUoZpBdVhCPX9yzZLRaLuyZxnC5IM=@vger.kernel.org, AJvYcCXF1H+o5g/DrezSxDW4CKGI8grvPUgH9nQFuSULwATGztull58foYMJQOYo+rNe1w/OQqCWhVpNA5lqRhW3@vger.kernel.org, AJvYcCXOSywecWgjs2vePQESz0DI1nKA/WyNqJxmU0OMdoxSkW7tKt64yMBgWf1JIsE+EgJ7F4jFEk55kfkenvvI@vger.kernel.org, AJvYcCXbZ2XeenMUvK0ZPwypm18CC4SZjPR3Si07ZEAp/jGfudEG8A47IJQGl1NHOzuMkUdIwNuwhgr+@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGpb1JHFsnqWtFDOfSP8wzrptaES1oQLfu3zmND+x19RwWdPk
	nJsVzffpIDv4xSVRfzafkuFCB66CcPkBmpT/geVLnsNvQ1oxVnLY
X-Gm-Gg: ASbGncvyfIh/Vq7kKSmT63ld06XA83HF+VREX5PifpPXyl4o4Gf5C5NWAvW837w2BPp
	dLCFnNRE8nse7QRIjs6Y1iK+ofenkGSRfIhLCFYonapqr8d4JDvVfTS8PF4v8Wl006J3J9jWACm
	VF4tCYThgm3OthCYbw4Uwl7A4PPe99vcXTeoY1fpVhyjxyXYaMy4yZVW/T8yY/fB3+pU/84cpbq
	npbNDLA/Is4G/QcJT/NOw3bcVWzWcOyxgMUUXHn4zjTX1T7GhCVORyyDs3ypIPMtvvxmLdP28wY
	GuY8LsDj4hxtRxuO/DuQKfjL0/iR4TuJk0e7TtiOANuX
X-Google-Smtp-Source: AGHT+IGQ1B1r23bHH1y7f1P01LiOEnbRiq9HK7MEAu/5nbXG5vCyYer48OQlR5RqnwzzsBUWrNiOAw==
X-Received: by 2002:a17:90b:3906:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-300ff0d6160mr17644409a91.14.1741883194498;
        Thu, 13 Mar 2025 09:26:34 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888a02sm15453765ad.40.2025.03.13.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:26:33 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:26:32 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
	eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, alistair@popple.id.au,
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <Z9MHOOfnHnLsnhxu@thinkpad>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <20250306162541.2633025-2-visitorckw@gmail.com>
 <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
 <Z8ra0s9uRoS35brb@gmail.com>
 <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
 <Z8ri5h-nvNXNp6NB@gmail.com>
 <04AA7852-2D68-4B3F-9AA7-51AA57E3D23D@zytor.com>
 <Z8tJNt83uVBca0cj@thinkpad>
 <783456A8-67F9-47DD-AB15-914622A921CD@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <783456A8-67F9-47DD-AB15-914622A921CD@zytor.com>

On Fri, Mar 07, 2025 at 11:33:40AM -0800, H. Peter Anvin wrote:
> On March 7, 2025 11:30:08 AM PST, Yury Norov <yury.norov@gmail.com> wrote:

[...]

> >> Instead of "bool" think of it as "bit" and it makes more sense
> >
> >So, to help people thinking that way we can introduce a corresponding
> >type:
> >        typedef unsigned _BitInt(1) u1;
> >
> >It already works for clang, and GCC is going to adopt it with std=c23.
> >We can make u1 an alias to bool for GCC for a while. If you guys like
> >it, I can send a patch.
> >
> >For clang it prints quite a nice overflow warning:
> >
> >tst.c:59:9: warning: implicit conversion from 'int' to 'u1' (aka 'unsigned _BitInt(1)') changes value from 2 to 0 [-Wconstant-conversion]
> >   59 |         u1 r = 2;
> >      |            ~   ^
> >
> >Thanks,
> >Yury
> 
> No, for a whole bunch of reasons.

Can you please elaborate?

