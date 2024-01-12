Return-Path: <bpf+bounces-19493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A70882C6DE
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05511B230F7
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 21:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBBB175A3;
	Fri, 12 Jan 2024 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqxizwqF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBF17722;
	Fri, 12 Jan 2024 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3f8af8297so40975835ad.2;
        Fri, 12 Jan 2024 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705096366; x=1705701166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFcO1qAhlKNYfKOckjMAtcijj/gB3q9a3sxD0aFfu2I=;
        b=LqxizwqFw5aA8wLza328qXqfK/r1jz6XM/Z/dGEEtecc2U1IJmzlocIxhbdaFjUa8o
         6PDbaPCMzzk83caMr3k08KwFz4aMdUI96WZEvxb4+sloubp/Z7sFm+INOvp0Vk3G4drR
         6J4aoq3OSxyDNhi6XhXwAdqu16SWLxr3teUaBm2u3U/5NBKoLDyxHBA1YfvmMnOtflZU
         QiQpxya9meZy+1vI+PT3smW6Rld4qx8bhylaGZL+PztzUFdwB9XPB5cyTsy+g1lvt2I7
         JRItVJfKzByqiWvB5s7N6Jro+mfdLEPyX7O2yesiQt7vNv1au/LsqdloeQZUfLgql2UN
         ZICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705096366; x=1705701166;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DFcO1qAhlKNYfKOckjMAtcijj/gB3q9a3sxD0aFfu2I=;
        b=cStau5tpkwmvX2qxMRUFLOKPylKYPbt4eD+4PYuWkIjaM2SfEc4oXKtNnsfSoAFO9o
         iTgQbOeAlarzQUk8UN65O0Me5GEUZNMkl7AyBeFAftf678+GL40cmCyVFGZv8tKFySqd
         WPii3lvicrxwT9kiKiN7beT4dRqZDI4tqGzENOiJn6nIlg/DFBUgGn8BnpsM+rwANyM+
         5lRodz1wRPRjC9LfbBBhZ62yX6pZ5lXJ3rPuufz/PoiMAX3zkhor7xxYwhtH3V6kl5d5
         Z7I1tTly//nOlSd3RJycxZm8fS81RsI/87RAlFNu6eQWK4g6MwRWphhRUiCswkR9CJ4h
         W41A==
X-Gm-Message-State: AOJu0YzpY+Apa2rhy46jGy9NVGQZox+mYLtpDOmvTleSsTbzwLwVBxX0
	FmqzidaUwq9MVNVT0SnanSBy0ARIGFY=
X-Google-Smtp-Source: AGHT+IHdwp+QHlWw0aGwGr00q+zl/9Hdlv06Mc+QQ+m5LxF5ibXqxrsrhtkmUgS9jhj72fytjdm4VQ==
X-Received: by 2002:a17:902:7209:b0:1d4:9c06:17ec with SMTP id ba9-20020a170902720900b001d49c0617ecmr1478792plb.47.1705096366272;
        Fri, 12 Jan 2024 13:52:46 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902c79200b001d0cfd7f6b9sm3642078pla.54.2024.01.12.13.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 13:52:45 -0800 (PST)
Date: Fri, 12 Jan 2024 13:52:42 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, 
 eadavis@qq.com, 
 bpf@vger.kernel.org, 
 borisp@nvidia.com
Message-ID: <65a1b4aabc0ff_4054208c2@john.notmuch>
In-Reply-To: <20240111170548.59d248f6@kernel.org>
References: <20240110220124.452746-1-john.fastabend@gmail.com>
 <20240110220124.452746-3-john.fastabend@gmail.com>
 <20240111170548.59d248f6@kernel.org>
Subject: Re: [PATCH net 2/2] net: tls, add test to capture error on large
 splice
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 10 Jan 2024 14:01:24 -0800 John Fastabend wrote:
> > +		EXPECT_EQ(splice(p[0], NULL, self->fd, NULL, send_pipe, 0xe), 1);
> 
> Any reason to use 0xe rather than the SPLICE_F_* defines for flags?

No reason I crafted the test first and then forgot to come back
and tidy it much.

I'll send a v2 with readable names.

