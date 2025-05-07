Return-Path: <bpf+bounces-57657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35FAADFD7
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF77D3AA6BC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93892868A9;
	Wed,  7 May 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cpbc1w0H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959B286886
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622482; cv=none; b=L3tPldXkXJv+sCKdzNcIClYdu4T9fhOb9lY545vgQVAo8XFfh/dryqgLSDwKzlO/5pxRredX5b8oGrVUrRFNzjmZ+0BRGymTiw/WNY7NkyApaVF1C9MeFTozzJFEDsxMDRc0S1E7UWMaHDsLg7hNh7lFMgbEcxORZZf5PNG0ngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622482; c=relaxed/simple;
	bh=rlYkutOJbTy9t4vetbaK1MFW9+WsC8kSGvqRmbg4uTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn95KbHjTBi6YjNj0lbuHXx4L4xdtD/y2hoIrfWcTxt0aWw4iH2NpyQdLWK3VbBdl1AwEZUSbQPGbM1yjoxiRfvyqo59YTcc1WvmyGQL6yeXcxRWGjzhli0jLZiMURAqnOOlXXQBzX1bBUDk+Kv6EVlQkkp1wlbN7FQmscO8Sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cpbc1w0H; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so9335201a12.3
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746622479; x=1747227279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ypa3PBqDtPswGp9XxxvAriQxh6M+XVug4d/DpMvuJqc=;
        b=cpbc1w0HT5jJVcnOIZARwe65ENA/wBt8HAeVVLLGwrET9+DSO4Ct2ym0k4055jrD6V
         C4mvf8jki2Jq8PMjqH4b+ju368Y8yfU26u2/ttxrIeNPWkM0X3GD4s9thvLTlJ4LSZV0
         CkwP4EzhZRhnrdNCI4+KjH+DfGV0pPj0hFSKHkUs+CWRDSoYDV47040U0QuyfK40Kbn6
         LmB6qUpRp1D4pFuIjdOYrAEly0Vz+rrrwVYAJ3zuKv1b0lJTd+xIOCBruHejD5Q1wUuR
         w4W1fj9pYxXr6z/vWbmAX83yat4c9TxP7k3hi7HxCiMYzNedlM/9jxJgjnU3+XRVn4qf
         V7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622479; x=1747227279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypa3PBqDtPswGp9XxxvAriQxh6M+XVug4d/DpMvuJqc=;
        b=OjWDvLsLlnDBHt9tkXewlU3yH/yeUbWtPON3gQdAITQGL2YuZrdUkSiwpaPe0HxPY1
         AUDYifmTe4JTVTMYwrjNpBgzW6hysYROD3k+EIkbc8EHw9zOnypUMRT2SLMjjcZ3RuyO
         rw7IblPeZaCInuFz6Pc3aDnk0ujLw9NK6QyeUjsd2qJ8S8y5xpoq6zwyta+8t9Fc8Jnt
         2wKSgrUODON/SW0iGPBewQ8n8nQfPU08H2JAfIP/8e+5fB2hUY8SFqqVEAkR8giSTnLG
         cisUDkfL0RYxcbvUAaxOIxE2WGAowZK8jayDvY/2BLVEjhd7cNdsT3erhEaUOXT5wSVa
         zZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOWXQ2+PlYXKfjQ53M5eeChfWObkBTYpTeZTFiB3gjicK0t+tFIuWV/Uil0GchYRpWcjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdrk3iHg10Kwp5SQTRn68D1HMF3xCDHnpOumufCaY3nhd5zPmC
	uO91xaACQTBWLq2Rmdgcs0KJPR6oFm8HK5rRZnApdSS30e4aNzM1PLGiYSrZT04=
X-Gm-Gg: ASbGncsusjkTf4m4bU7zxwaaD+bdsXZBBzgdU5+brc13p3qmZPiYi/QnNv7dugkhErY
	OJq5fmbxEohHn5RR49Vi5bsB6E5E2SgLxcr5vgS1oQz1gepFeayA+OXGpIEgb9OlYh023v8bMno
	XgOSOfKcPUqEYMttO4UGFynUpL+pDjj5zJQGRkDqkUnUwlYFl1FfYG/w3onJa9cK0lW0KPM+oqo
	fncZjMvDXmYJ4W3Lviw9DSJzVvwWI66G46IDh+45VFBMuKD0iuh4rDRf4370LFmOv18+spXFYrU
	eyvCRtXmftMjVSpqsdF+ga3qXS460/1Yq2w36Nw/Bxs6jJsQSro=
X-Google-Smtp-Source: AGHT+IEEHI/oSTREUk8HTc9X/nZpZu+JH0JNL8Ix0W8ZxxBaMoWEfgZFH93pE+NmBTNHIMjXerli4Q==
X-Received: by 2002:a05:6402:2547:b0:5f6:252b:f361 with SMTP id 4fb4d7f45d1cf-5fbe9dbbe1amr2731807a12.11.1746622478474;
        Wed, 07 May 2025 05:54:38 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm9354161a12.51.2025.05.07.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:54:38 -0700 (PDT)
Date: Wed, 7 May 2025 14:54:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v3 3/3] exec: Add support for 64 byte 'tsk->real_comm'
Message-ID: <aBtYDGOAVbLHeTHF@pathway.suse.cz>
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507110444.963779-4-bhupesh@igalia.com>

On Wed 2025-05-07 16:34:44, Bhupesh wrote:
> Historically due to the 16-byte length of TASK_COMM_LEN, the
> users of 'tsk->comm' are restricted to use a fixed-size target
> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
> 
> To fix the same, Linus suggested in [1] that we can add the
> following union inside 'task_struct':
>        union {
>                char    comm[TASK_COMM_LEN];
>                char    real_comm[REAL_TASK_COMM_LEN];
>        };

Nit: IMHO, the prefix "real_" is misleading. The buffer size is still
      limited and the name might be shrinked. I would suggest
      something like:

	char    comm_ext[TASK_COMM_EXT_LEN];
or
	char    comm_64[TASK_COMM_64_LEN]

> and then modify '__set_task_comm()' to pass 'tsk->real_comm'
> to the existing users.

Best Regards,
Petr

