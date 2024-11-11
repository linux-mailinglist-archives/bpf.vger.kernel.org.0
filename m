Return-Path: <bpf+bounces-44498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA249C37E8
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 06:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A791B2172C
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 05:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0AA14F117;
	Mon, 11 Nov 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fvneTsgv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78414037F
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304314; cv=none; b=BFdiRFR1gqZIYRnYL3ZN630Il47QDJxdvRNV7X7/mq9eTnTV5xsQmdSjpaCJM5hYeftugxcwxYpWHXuUrdgp2YK3XA8RxdeIz07Of7b3hrLJYZTfYYl4yMK0+c+/OOslBXdS6NNG04r4DFeRL9H9aADKhCSI/+Nh6iwiilzhRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304314; c=relaxed/simple;
	bh=YEdfaM3Jd4KS472gYqcc4l9HPKkzSqmWnqgKk628khM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix4YSoYt1w1aPwCZCKj4toCOO7QQVyNgbrJ4Wp+H9swqa30V/RFOuG9UcuqN6brSOhtrNSrz6ppJLA+ns+MD+rFs72u1zRYx26U+kC2jrxRjyXJklRmhN2f6pwjgCOVyV/rO1QpY5mpLJ0Od7XDbaQcDFwEWZw4D4fsH1eU/J80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fvneTsgv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3503126b3a.1
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 21:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731304312; x=1731909112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Foh0UsYIXPUZmsrbDQnaRrOZh3M/3AkXvl3AtEjmLXE=;
        b=fvneTsgvZx2nYMaIPhM7Ncf3+q86NLvyXiDlLtEhYr9ih2KpBInRGvZY+NOnv9RcQE
         zsmNjn+jy/hMPD0VbHK6derUb8cxZlRNIEdwkjisqVQDgZXlM3H3Yz+sfymmlcjlCmhS
         xYHjuOgNaq0+D6dKUZRynhoiPIUSgpHdTAF9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304312; x=1731909112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Foh0UsYIXPUZmsrbDQnaRrOZh3M/3AkXvl3AtEjmLXE=;
        b=Y5xBn/vmjyf5A5bv1V0xWC3NKVPowqBGUjvcqjzrD0xB3cIcvDDQebhVzWzRJ8uQZC
         hcra4aEpfExSe+TOS8wBv1MqiMxSa+t4IBx1joeUfeKqUoJlfZ0jvYq/QRVOYH7CbDDS
         zAqLAD6hLaA7AVNfXE/6a1rFs8VpurLcJ2n/fkJp4NKIjyju4SycktZb6pmp9JvKU7p1
         ZXoWzI+7DnNRy+gikmVkR54uiLZSvrFCCS8U0hONFfi3U62pEmbHbDRFxhuy1dgCi6GS
         cddLYyf39FcWH2Kw3LFXaSE+/7xib1iRUne4+TlFCq6CGYt3AfhOWiFZKVFW5hUrdBJy
         pW1w==
X-Gm-Message-State: AOJu0YxCcdN6v7g2cXRJIsUq5sbx81w9wM7GB1AU/xSVOr/xbjDsGMTq
	J080k6xL3owVcthsdcyI6oNWnfBBb1LMkF1jq6WBKkRv3JrFj+9xFkGFUF2UAg==
X-Google-Smtp-Source: AGHT+IF/+AvkwmPA2wuy0MVZEKqJsApzJ/i3RyTv4BlbJnKa2Sv5Pc2joVr+5WcVWSGIEu5T64xndw==
X-Received: by 2002:a05:6a00:3a14:b0:71e:6a13:9bac with SMTP id d2e1a72fcca58-7241312915emr17467219b3a.0.1731304312323;
        Sun, 10 Nov 2024 21:51:52 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a43c:b34:8b29:4f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a4126sm8396292b3a.102.2024.11.10.21.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 21:51:51 -0800 (PST)
Date: Mon, 11 Nov 2024 14:51:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org,
	jannh@google.com, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
Message-ID: <20241111055146.GA1458936@google.com>
References: <20240829174232.3133883-1-andrii@kernel.org>
 <20240829174232.3133883-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829174232.3133883-10-andrii@kernel.org>

Hi,

On (24/08/29 10:42), Andrii Nakryiko wrote:
> Now that build ID related internals in kernel/bpf/stackmap.c can be used
> both in sleepable and non-sleepable contexts, we need to add additional
> rcu_read_lock()/rcu_read_unlock() protection around fetching
> perf_callchain_entry, but with the refactoring in previous commit it's
> now pretty straightforward. We make sure to do rcu_read_unlock (in
> sleepable mode only) right before stack_map_get_build_id_offset() call
> which can sleep. By that time we don't have any more use of
> perf_callchain_entry.

Shouldn't this be backported to stable kernels?  It seems that those still
do suspicious-RCU deference:

__bpf_get_stack()
  get_perf_callchain()
    perf_callchain_user()
      perf_get_guest_cbs()

