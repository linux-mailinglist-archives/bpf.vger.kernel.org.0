Return-Path: <bpf+bounces-75426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EDEC84060
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 09:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0333ACD75
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0AB2DBF45;
	Tue, 25 Nov 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApYj7UxA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfg4Q30W"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802F2DCF45
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059781; cv=none; b=Sz8Dw0Qz+ItxFJq9FdUrKAZLXLvK5WUS00U8YQtjkkDuf0ZyEaYIK1ChB+xu5tM9m2MtTmJkK5HHHiNBCBP5IzUvYDNLg0iSnJT/Z6aeiohOgi/rIo+j4kD6gtHfXISsZheHyr0fOOBAcRoWGdfgW6PRLQJ04mKgUguK9lkYUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059781; c=relaxed/simple;
	bh=t3TMJXrcfhLPaewtUx2ZbtBTa4bLRUKMityiB3tQViE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk/HJiRHbY0phEs7SrC7W1ixnic2mWs6v8+GOr65O7NcrnVViRHAOROZHC68GlmkMw3mkT4oV/0aDM7nyhItYSmJVCiP3jlnVpoPL0cwz5+lZYJnYFIp4woIjwa15Ga2bYkFgoVq2CAXUWkSDo8nQIT+uKBYJeqbW+z4mcD7OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApYj7UxA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cfg4Q30W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764059778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3TMJXrcfhLPaewtUx2ZbtBTa4bLRUKMityiB3tQViE=;
	b=ApYj7UxACwcEmeB5Wzp0Uvklaj6GnH2dcNQm2D1dZ/k+Byg+NhYFgmhf9aI0XJ4pFeLEf2
	5/9ZRCmCDOb9y0E1HE+Lq1KIJ1hPmpxx3GTTYPDGq4hTrHMqjWTgCjifVwqYi7YTvzWXiH
	H+/Vw6s8vpfPB/QXygSNvsbg5nmCq/w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-_KudpGGKPHKxD-A17hzhww-1; Tue, 25 Nov 2025 03:36:16 -0500
X-MC-Unique: _KudpGGKPHKxD-A17hzhww-1
X-Mimecast-MFC-AGG-ID: _KudpGGKPHKxD-A17hzhww_1764059775
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6407bd092b6so7362964a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 00:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764059775; x=1764664575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3TMJXrcfhLPaewtUx2ZbtBTa4bLRUKMityiB3tQViE=;
        b=Cfg4Q30WB6U3eX3wnBhhn62L6xyTFQXV1V8xaSGDwqQ4UjCKRtnN322d0uQjONPRlE
         +F9XqDg0CYgKcagMfhWOTbLG23+q3oHTAe/a8NkFxxYnpxH3jVLR/R+RzEbt0AEv6D+l
         0xhVRkqknNIGszj2dTAh6EDf+pv/pmep49Yur1eS5PhPnlZOBGfe6r4zPwaOQxs8iJki
         j2iG1kzmw5iiQqcTTjftULJ1FyOcfDPiG+QSXKTFeh3WyjjP79lESIVevHjKJzUHPFbI
         9e/9PKcFRlF6PT3bhhqLFnKtPffVTKG553rNerLf6u1CTZyUyDr7vGZDVwl6481QvZ1/
         atRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764059775; x=1764664575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3TMJXrcfhLPaewtUx2ZbtBTa4bLRUKMityiB3tQViE=;
        b=cdjQ8mgP2KHVN8QTcq4CKLs+ruv5KctNpVrNMZW5iw+qlN8g3ZUYPBrOn9YbSslAYi
         nKBav++Rix4/CQOrygeFpD5viya3O7S6ArYSPHOoOOYcVesiwz86E8xnkFZeul4amYV4
         4QNiDqBvaNzIoQxwouf/Gbc6D5cMTIkWBCDEU6D57615iZzibqT+TF2xRk7tlVio01cb
         Hwkqseqozj6N3pQnWacTgy0RSCk+OZSTurgbgAKiccu3xEkG+sh7wxSfNYVpLb9aPApH
         n2UcuDLHGBsy7nRLWR+/6dMFDLFeNdilD59Ij4VVTA78vqM4MvE/2mgCuFi+YWbXrvga
         v+6g==
X-Forwarded-Encrypted: i=1; AJvYcCWjlsW+MtuEu9EJvgqjaw2r4GTXWXW7TADNYUwIPZ0bd0HpDM9/46X17Y82bib6aYZ9lPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshMS+ZNpYiI6QUT0kBIjbPey/3ukC5X0iqPR1i0EIxq15QWjr
	qzKvn1jbnEOfB0ZGuqKNXpdARocgSeQueyc8QEd3lexN5hNuoUslc/iIs/2hLfxPwtHdK+D6C2P
	i7Z/j+r8S6m4jAf7yP3ZEBT6BbSsnmvmt3T3v7s1tEtr4s85tuZOUvRYiUV+LiifvGjVQMzPCwj
	c1HKvCqUuC5GBInBFD2BS6Ir+pPOP7
X-Gm-Gg: ASbGncs/zp4T0Ea3oTweahXbAYaCQORAbTpf/dBs/YmeOV5dC5FqYbyoZVsv0T2+AAI
	2mMdZx9gINN89YQOBB9iP2a4QslGv9cI81amQ8xJejIHAne3/XePueDRMoHVkH6gsgKmPkSKIxt
	UqP4CnJTxf6rM9FkwMjM/5TkG/E5L/QSwneRpNkeEVlNMk11s0s6hfY1WPtxGkpMpgM6ZqNjC0w
	s6/mzpznUk7IvQ3gXjO4VdgJTK2
X-Received: by 2002:a05:6402:1d4f:b0:640:9c99:bfac with SMTP id 4fb4d7f45d1cf-64555ba6a54mr14410432a12.13.1764059775287;
        Tue, 25 Nov 2025 00:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbowAw8xnwVcEagQwpLeobunUnRMv2eAt5SqMfHySizIkAd1BHtmXHK8LomFMvzKuYrAliFAr88RJShvATbtw=
X-Received: by 2002:a05:6402:1d4f:b0:640:9c99:bfac with SMTP id
 4fb4d7f45d1cf-64555ba6a54mr14410412a12.13.1764059774895; Tue, 25 Nov 2025
 00:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-5-wander@redhat.com>
In-Reply-To: <20251117184409.42831-5-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 25 Nov 2025 10:35:39 +0200
X-Gm-Features: AWmQ_blFJar_BkG5M8MYHChRGM_It0Cs9uZCDIO8VEBL8HSdYWDh2e3YVpORtOo
Message-ID: <CADDUTFyAAAv641OfGf_U4hVdegyAVyp5rgruF=NSNd+UPkjOzQ@mail.gmail.com>
Subject: Re: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 20:55, Wander Lairson Costa <wander@redhat.com> wrote:
> To address this, introduce a new strtoi() helper function that safely
> converts a string to an integer. This function validates the input and
> checks for overflows, returning a boolean to indicate success or failure.

Why not use sscanf() for this purpose instead of adding a new utility function?

Also, using a boolean to return success or failure does not conform to
POSIX standards and is confusing in Linux/POSIX code.

Costa


