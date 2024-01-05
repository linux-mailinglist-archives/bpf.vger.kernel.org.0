Return-Path: <bpf+bounces-19142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D35D825BEF
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 21:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B452852E5
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96083219E1;
	Fri,  5 Jan 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ct+78WEs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E477219E5
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a29a4f610b1so51849966b.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704487575; x=1705092375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=ct+78WEsaxtswbrnH0nbA8K18ycZPa8iYHooRrEE1Za6+klL8RUjepj0Tn+zB5tMSc
         am11I5yjssnhLnaH0Bhhyty0fb0D2gWbcYQyT1rQfEZk6/yd+YpqP/ZPj4ifWaxZTuPr
         FFU5NadMx00DuzveSMqN7ZEH4aIGRrkBTu+is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704487575; x=1705092375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=RPu/pUE0T5AFAHERrdAqUYw8UIMK44oPTQtBbUfQTSXZ0A7Nm1jb4er04FrDlwe9SC
         zDNAZxpzrwsE6YzPjN5oks/CukN0U3xR7xRGS1vdDbWg5DYCiYoqRgNL2a8eXsGQa5n5
         x7PPLVA6f8QFNsXOIcYibiX6e47V8V3UCcGNzgHrzWOort0JY8pXKn61u0wQ18vbiLf+
         cR8tjoFtiGs2gVK3Herm7AD5Xa9WoWgJiCP6ZqyirTlKzNUbGHlFP3wbaCExLBgPKuJC
         /D7LVjmFtiCGs27FVQpcYeUHHzbmhv8kQ7uG2fdRzRs549KZpVG9xtA6q3khfJExnAKU
         Qs0Q==
X-Gm-Message-State: AOJu0YyiwwpFCSaWoRRb/0efC5uJ8vpfFgZQo0ZPTHD+T7MRcjzw3sxG
	Hh3pyhRuap+hGBzFj+zrETtLpZZMNPPXc2rtKZsDgUJUvi126aem
X-Google-Smtp-Source: AGHT+IH7N9d81A8k156RBymgvn6VnPHxA0Mrum0EPAfHauKq+tF0FpOGbJiqcGuQpuzvAofszwFD0w==
X-Received: by 2002:a17:906:fd86:b0:a27:f465:298c with SMTP id xa6-20020a170906fd8600b00a27f465298cmr1785075ejb.124.1704487575305;
        Fri, 05 Jan 2024 12:46:15 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id u20-20020a1709067d1400b00a233efe6aa7sm1242870ejo.51.2024.01.05.12.46.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:46:14 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so2229377a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 12:46:14 -0800 (PST)
X-Received: by 2002:a17:906:74c1:b0:a28:fab0:9004 with SMTP id
 z1-20020a17090674c100b00a28fab09004mr943524ejl.86.1704487574561; Fri, 05 Jan
 2024 12:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com> <ZZhncYtRDp/pI+Aa@casper.infradead.org>
In-Reply-To: <ZZhncYtRDp/pI+Aa@casper.infradead.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:45:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 12:32, Matthew Wilcox <willy@infradead.org> wrote:
>
> I can't tell from the description whether there are going to be a lot of
> these.  If there are, it might make sense to create a slab cache for
> them rather than get them from the general-purpose kmalloc caches.

I suspect it's a "count on the fingers of your hand" thing, and having
a slab cache would be more overhead than you'd ever win.

           Linus

