Return-Path: <bpf+bounces-20091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C9C8390BB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 15:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64F6283B00
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F75F845;
	Tue, 23 Jan 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTGg5H/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC25F841
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018490; cv=none; b=eO1K57WcKV1J3Lq2PSHF9hLSfKfeKMwZX2zSCa1nVWOxd9CihM1RXcJlmI85T5LSB4B4JcVXWJpbHRVpYPA8drAmqTD2SZ8z4SNFw1rIwSmR+ZGZhuDQkLk2GQCVdwktBlO4it0T8864LyX/nTLpKP2mWNWIW734Zqgc/wKmzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018490; c=relaxed/simple;
	bh=eCcz9RfiToOz86+KPL2ZPgkudxsiZtNEtsp7LGtQNEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPs39pnR58t7FQOvllsPaC8Gd+Jeoh02u7VBuQBCcyrhNfB5IpJxR+rwvOqn9bA/l0B+lMphpiHIr7YRwhwTm6u2awvnm0q4KdxA+g/SZfKTXSk4TiLnPqyqfvaUwpw6YnRmAxFF6zeFTt2twAh1n87aIv4DRP9DRAqkmokKwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTGg5H/y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ec34160baso681325e9.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 06:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706018487; x=1706623287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7LYXbKlJfg3s6gJgj9+5UEGknBdHU5OMfVw2Npl2qE=;
        b=tTGg5H/yBhFaU0kRmdRe5iinJzE2QsvD9iUuT+DvOxoqyQFqLsHpBey62KaoClYv1L
         D8ZrdJAGlYVzdiOHFdJaxnrr6rfybjtb4JfqHLNrKcmIXIKmRp+7gOnvnEyoEpUCzL4v
         BcxAvPkW9fiG4iQEUA+mHIrGx7ZSIyfJKMEAhaVQ/6bHlJQTihREh5menlk0jAoVCHF1
         kAKUOFQeNfnTEsTRtutj0CJRhTQzp6f0VsPHcV2N8zd1NasN1yu6puY/tnZ0WYW/HE/w
         3skebTomPQGfXckHmuSMbL3eT1oCQIuPhDqLDwAPMjtaxaD2v8zOmsOYhmVH27S5EKG1
         z4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018487; x=1706623287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7LYXbKlJfg3s6gJgj9+5UEGknBdHU5OMfVw2Npl2qE=;
        b=DXWoz7Llex/ZhOYRsWimHU3uGdYgE9s9W8ULEBywJofvsOilcHLJNluhK5WouSr6UF
         jVTJAjKceTk3MnrX6TujCFEL0d7rL0bOGFl2+OfV5R698Ii4D0jkH1FDCnN8QJ8JNlnJ
         T1dlP3zkiNugxeWS95rKGYZGLsew6Z4ldeYeLNd7iRwsUJatl2SmTEEI3efa+lCpS+rm
         MKNxwe8VY+jgwz5Pl2M/gOegKMUiKU1JPLHhUZFAyQKtRCf9MXhL7Ls4NJU/TN7Lchik
         zTJQbGb3TLPrdfQq8CAdv0b20GZU7jsJ+iTXy09Y1HCSMVshuxs4BWj1BNB+WurKi82f
         iTWQ==
X-Gm-Message-State: AOJu0YwK8rmpaUTdufWYAMBmASO9wVJM9pw2YlhbwwXUiq3tDVQhvnx+
	rKoEqIuyU3gd3ZS3s0rOsRlNet5S+SvzTpk4USjJvHPSCj+EE8c6sf0aIyAR68M=
X-Google-Smtp-Source: AGHT+IG6GSDGfE4t2Gy1Q3pejBnhUUfNBUw7hMfExAkFbyhjw/JueOp2ryd9PTO7fesYMV6CLcVVlg==
X-Received: by 2002:a05:600c:4f87:b0:40d:8810:468b with SMTP id n7-20020a05600c4f8700b0040d8810468bmr644936wmq.88.1706018487415;
        Tue, 23 Jan 2024 06:01:27 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040e5951f199sm42260096wmq.34.2024.01.23.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:01:27 -0800 (PST)
Date: Tue, 23 Jan 2024 17:01:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, bpf@vger.kernel.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: Re: [bug report] bpf: Add fd-based tcx multi-prog infra with link
 support
Message-ID: <c900b111-d0ee-4663-8adb-479e4eb90f3e@moroto.mountain>
References: <c46a511a-0335-44f5-b6ae-6ad71d6ef012@moroto.mountain>
 <d31ca459-5fcf-9e88-03dc-42e9fc10028a@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31ca459-5fcf-9e88-03dc-42e9fc10028a@iogearbox.net>

Thanks Daniel.

Ugh...  This was such a stupid false positive on my part.  I have fixed
the check.  The drivers/hid/bpf/hid_bpf_dispatch.c warning is different
and still triggers.

regards,
dan carpenter


