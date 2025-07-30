Return-Path: <bpf+bounces-64707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08950B16280
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A6F5670BF
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B72D7801;
	Wed, 30 Jul 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME2Rr1Qr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30813217736
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885097; cv=none; b=UYYO6X0Hn650TvSww0AJQHgbfsBwwrGmCMO13OQO/JfITMXdc/JrBTQEwNn93NnZOXzJDKfmAZIYqrKeMEidVTRnfFNDDghdf47Euhh5Qw8ZyH5+FY0K5JAvu1Gj67vz1xa3SEfu34qruugkUERBRx+2cYFQ/qG7IpnhwtPZGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885097; c=relaxed/simple;
	bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u69DVGp5bqDOsWx42MLGr63+sm+zYFjdIpWCBvdSFlWp+r+5+hW5a3th5rk6Fa8yd28iacYfF8YmvP5wx5uqKA+x0OUbn2G/brqR8J9gB6wmDK02+0ZzPBf8sunzi9YCyvqFDNstpPh4D0r2+W6G3jlQjuJ+OzrVfZFxa3vMLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME2Rr1Qr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753885095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
	b=ME2Rr1Qrn36RjrgJMJ2G64oeQaPut2eY+fdOv5qV1TRT/t1u75lXHwOcWLDkMD83y1qJQc
	RzceXj7pFbw2FTGtaXVP0cP4JRjNbWqw3j4yyHc40uNFvpgVZmJzmEglAseRe/W98KZIxu
	b/UyKWAhhC2Z3B2EKHPS6FPJ1bdeX+g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-lElmdNvZM7qga-QNqaCtcQ-1; Wed, 30 Jul 2025 10:18:13 -0400
X-MC-Unique: lElmdNvZM7qga-QNqaCtcQ-1
X-Mimecast-MFC-AGG-ID: lElmdNvZM7qga-QNqaCtcQ_1753885092
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae6f9b15604so540072266b.0
        for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 07:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885092; x=1754489892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
        b=stS8LVz1z2OC8pKtjtcN300DU6Ku2myCZyFC1vAiHh+eHmPxHLlf5zOnvuxvUoZ6fJ
         6tV4riGjzl/cHsyT/HgnSNVhCFh8AqwsT+Hp3FHvqYPX3GkQtJwxyA7OFTRgZ5lQzfvI
         6Cj64QDhzbk4cVPco1Vi/lWpLBtKOUmMxT97cbMeb/qf0x6x3RjS9ff/wMCKN56EpvLy
         vCv1KbYA258Ulb8DmEXiGN2jqsC4Y+IsEJiDGtOgIGhQkwyZ2eVe/T3j04dyyb2DSe93
         4EouoHO+nbmDalvtjdV3GshGHVDfMltJHme5/ro3Ubaknj7Hqx1rpv4jl+pYjE/ho63F
         0J5A==
X-Forwarded-Encrypted: i=1; AJvYcCWpLJbOA+11zu6AFPj0FTqaq41ulxMmT5DsTTSKDuuTLbD7JqAtdMdE62/1EAQOr7WPG5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NNMZr7z3YcYJVki9I9DyxcItI5kHINblxsffXwbRUqTANziJ
	KIqoiJoLHSHo9xW28+uhcwaBO6mrfvzPYGxfen1HrB62ELf5gKni0hIB+/f9c7K9B07Pzi6m5SN
	UMmGorZXjjJXJ2hO1x3jb9i8Ex76nqFBaECFV64p5qBTHFPXlX+2844kWXjeM6RwgoZMe9P5kps
	rpBZx8cFcox2J16WHpDjx3V+rgQ1HT
X-Gm-Gg: ASbGncukkuHfx9y0kklO0vlNyTRbAmg0Wx6qVQ+vkq94w32CGLzY0bhURO4syXOvlPU
	fSJn/4lSiYMH5l4nEroJSUksUszCcpfcNB204iGk1ogjMcHDATXbNsDOWCOAW9G/P+oQprkYTcv
	WKs4CY8YzIq3W7p42FNwCVVoIiGZKBQaMXiHOr6JjkIcCQD8ditBM=
X-Received: by 2002:a17:907:d88:b0:ae0:1883:78ce with SMTP id a640c23a62f3a-af8fd9b15a2mr449199666b.47.1753885092401;
        Wed, 30 Jul 2025 07:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlSNefCMn8VL1asAYFBErw9EQVssdL+ytIqdvxN27jklDKwvouyVj4iHUy3iqQTvHr0jMpgoVmlIpd0cOzuIM=
X-Received: by 2002:a17:907:d88:b0:ae0:1883:78ce with SMTP id
 a640c23a62f3a-af8fd9b15a2mr449195666b.47.1753885091955; Wed, 30 Jul 2025
 07:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726072455.289445-1-costa.shul@redhat.com>
In-Reply-To: <20250726072455.289445-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 30 Jul 2025 16:18:00 +0200
X-Gm-Features: Ac12FXx4xowUzfg1QpHqAj2vPs_ZSJpkqZBvPfLdbkfVkH-lOdJVad_fyktbcHo
Message-ID: <CAP4=nvREsJ=y0F4UhwhvUvK4JUxCKAGXNmDmiDpPB4bdGTs78g@mail.gmail.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into shared structure
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jan Stancek <jstancek@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 26. 7. 2025 v 9:25 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
> ---
> Changes since v1:
> - Rebase on top of recent changes
> - Address Tomas's comments
> - Don't change already not common members: trace_output, runtime
>

Just a clarification: runtime was never a common parameter, it was
just mistakenly added (but unused) in timerlat_params. On the other
hand trace_output used to be common before the actions patchset, when
it was moved to the actions structure for rtla-timerlat, but stayed
separate for rtla-osnoise. If rtla-osnoise also adopt actions, it will
go away there, too.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


