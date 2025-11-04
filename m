Return-Path: <bpf+bounces-73489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA55C32B18
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01F264E77F0
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64533BBDE;
	Tue,  4 Nov 2025 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8pfsnFV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C67214236
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281741; cv=none; b=VmieVlYNuFavJfVgh4qAKPoWxx1fE7z3SAgeH2ghd0dfz6tbuLKynk+8KEBdHGXOXi2cFKZRLMP4xGKb27yH8wmaFg1/fWEfP8VjAFTbVYrFgEsAyQ0tEEkwu8uRwzY6HsOLPD2+/edOhrGtdE8Xv1zD7hRThdlJSWpQ5nSqUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281741; c=relaxed/simple;
	bh=28b7zrBnH9pgvzCipBbYY7KWkM8FvzvOd5JHWyY9EhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZLZ0taZDlvGywkmyOnGC9nvrWaTLWtmOcde4Br0pJNCckWFZ1DiZkoSqo3j3bVqyO5+2hKqbS2JOiqNZV6iPb1dTFpB4NC1IcPVlCbuuySoAFQCerkRtlrh+omLsAP7jfuK6Em/dNBo/CO2lqmenPAa1WWN0CacED1uCDIooUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8pfsnFV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295f937d4c3so10139535ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762281740; x=1762886540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=28b7zrBnH9pgvzCipBbYY7KWkM8FvzvOd5JHWyY9EhU=;
        b=R8pfsnFVWaqHoHfFQxbSkjiv/5wYrZTvC7RBuAH3t8NwbAa9wD2imEJNhG2f874CBn
         PxfWedBcZFAVptmwmG2fT39ZWNuNjlFoaONth4FOokjqFhhz5xzyh7dN2vsFHpAVQy6K
         u/e93CdaDy9X1bUxqGwzxsOYSl7eJuBpx9bVL2Lj3ZBNYk7m95t2yk2fY/lUTJvE2mQ0
         6TAoHR90h/lMamFsODseanUkkl/K+lvgQUjjFK2Ltc6RxUt9jbEzakiRowwzUSmPm59q
         4pY1YKSaArRU4oGEFPNndsncUhz9Hn84iRnJ59hfmttWKdy7CyUulF5go7RvuAB4/+kP
         tEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762281740; x=1762886540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28b7zrBnH9pgvzCipBbYY7KWkM8FvzvOd5JHWyY9EhU=;
        b=LSRsqZQweZjC1Y8HxR6P4Esy2SQu5+J4cqPSSnMOC8JpwOAoARAyT81I8BTyEao0+W
         rtq2I6KgoBEsP/UUouc1732IH338nAhWUffjD34eME8DZtg0SpQkaymB596pjB0LHsJq
         52yFO0kYf/WsklsPt72Co6QDHb6O7rf0JO4LzjM7WjKlrN7q/W8gOPxOlB8WYsr0mO1E
         cBwNUPl5Hhplv+Mxqbs7wLnKGOUCGYFsEYJFY8epVaKwl4XPaSXkUWSoX04RL3F6HByS
         8MYf0ReQvj8uWCZ2WzYgjVuoRmTrUzwpLWfTdH8ghaNL/Me5J8BUvOLrcxwluhHYZQAg
         fb9g==
X-Forwarded-Encrypted: i=1; AJvYcCXMU7bwnTqXPtI27HwRM2EtA7nXhFdyse14L2w3bqILdhIMRA2cvTNSuS6jlSgDmdFQCzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmy4U5UkEfgjFgVuqELeK0zHJsAIiyhGtZc2/d4bLv7ErPbnn/
	RItebLIAu+kMhs2s6M45CbOvZCY5L3CbeXxuvkozlvoP9wmBHrP8Lfn8
X-Gm-Gg: ASbGncvcBcLGDaCRje0k1MIGmuE6OK6xfQxzBhvocdsVwD7TbC0FltCVUJjpvfXiHVv
	KgE/QqUGm6Ahr84+4bFfxkF5a9ZlXmwRm09IXtD/d4HXKqRrJC9oZ82Nr3Z6rq/H4jgAnPnVt4H
	zaPE6owMQ3tlqsGZywExTxc8EWTApocWzdbxUi8GHPOnkObxJ57SyAb/oj0jYECQR4Ty+fwwK3u
	8hYaGh19S/ZO50EtUl7zvszCTh1lFajWhnCWNxHJwgETDKOsXgSRI8o6TA9T0A0eklhMde6K5qH
	zcVjvhItQjiEfjJbhd4sKQnnVJZKT5WvlghNtdHiWbuwCQGPb6U/0Y1nXzmkicb7f/8HuO4FKJ4
	joR67Ke3BKXOCk9dAr7i2tj5GE5Bvn872Sr9erwWWne5mgnaLh+R6uDVn8yO0qhlEyBsVTtO3T0
	Dsuhw/DCNIkph9Rvds1Nv1W8I=
X-Google-Smtp-Source: AGHT+IEmPI9E2D6qBmO29/BG4eqCCF8EHb4Vrr6Jg+BoZV4JKiwLKzlYpgWuBJO40DNnGgXdSHXL3A==
X-Received: by 2002:a17:902:f707:b0:262:d081:96c with SMTP id d9443c01a7336-2962ad1c9b8mr7131785ad.17.1762281739696;
        Tue, 04 Nov 2025 10:42:19 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f98fb670sm3072498a12.38.2025.11.04.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:42:19 -0800 (PST)
Message-ID: <8091e4260e6fc62e5ff5b3578a31a77527eda1e5.camel@gmail.com>
Subject: Re: [PATCH RFC v1 2/5] bpf: refactor bpf_async_cb prog swap
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 04 Nov 2025 10:42:17 -0800
In-Reply-To: <20251031-timer_nolock-v1-2-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
	 <20251031-timer_nolock-v1-2-bf8266d2fb20@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 21:58 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Move the logic that swaps the bpf_prog in struct bpf_async_cb into a
> dedicated helper to make follow-up patches simpler.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

