Return-Path: <bpf+bounces-44573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21339C4BD9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724CD1F23EDE
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AB3209687;
	Tue, 12 Nov 2024 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LvyrQW83"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673C20493F
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374989; cv=none; b=K+wgtNqGSeXUwaGn8cAzo1aIJ1A0Q1eSuVgaM0hBm7+X2k4toJI8bkbkE7zFAPcVEsdJwPxL7Vy1XUFG/yLNKistpCHf0glY/aDPdlWCf/kKxH6S6rxi5wdajyK/hYqbSxqLVk/qrljAsCdfXiG4Agn2jxrW+2P0xgh5edhClls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374989; c=relaxed/simple;
	bh=nkYT3n8m61RRJRpuhf9G/elVoMHFWHCcU/BpZUpeHeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd2AnSbj4PQHo6ImcsEZqzgXOcLSMrxGaAn1xrnUmOwxFgXM/ekuL72wEr/32vb2UBM6gxT2n5dGKO4XOraJvsUTlWu1YC1bUXQcpha4zo7TyA3+NGN5YiTEMaSVWlcnnzFupKqwu8rNTezAxFGm9LICfRLS8DIapwm4nKyB4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LvyrQW83; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5130832aso3934650b3a.0
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 17:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731374987; x=1731979787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unMes6tk+yAGpxvui8SQySSJdgFoHnSMIQwrPN8JKpM=;
        b=LvyrQW83Ai33ruMiKHFEk1ExpJVxTimWCFg3Ct3JtoF2XVO9b9A0goFPv0LUQKRJfM
         nIizvW6qf+IW7SjACiMwiTEicQnJikeKGvwLoZQeOGXymTVITz9snNj5VScubbcU/RLv
         UXVK4bUVLEfSsaAMKGSOgEv9L9AOPKPIZUths=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731374987; x=1731979787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unMes6tk+yAGpxvui8SQySSJdgFoHnSMIQwrPN8JKpM=;
        b=KnyZmbUitcUBDZVKXw3o/rixWOS+wXU3qADJB3BVIwNkHeMno7QhunH6Abj3GVJkCT
         Q7jhZ2YVRDJSLWMlQKtQRT7LaptnyDnxME+NDfDvr/MfWyUB/wS8g93MATVA6oiUSWY3
         2JknxF0hzJ4GsLTHaREhVwGsMtMxogNxGviuJLJaiFVXiBIQHUWOkjnyquFr+f9begDJ
         V0ZYM+SjVl3zFcEhIAvqtvCr/8QkjrDhRjl9L3P9hoVaAeafFEL3vpkLFgySf8XTHOXy
         dT3x5EAzhhr3s/yWiFPxq9eAYnarE/hgo/kBdy0JlWLfdNGCOIL2yuNVflzx8NtTKsa9
         Ykbg==
X-Forwarded-Encrypted: i=1; AJvYcCUUgk9gZJwkfHr0oNpZ7ksQ5twsAm5OT7hfZbJYFp+FVW7BsUnJeUHMHio3olYcmd6eWsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfspXchhFs/MSlcefzgVkn9Pp8a/NqrHfbhvK5e3iN68N40cV
	nEkEl/4JwDn0NhewunmSkGEpZr6RaeXtePRk65+YVft2G122miw+3pfqb2Uuxw==
X-Google-Smtp-Source: AGHT+IF1Dmx7codECfSiIexmKZDkdrD7kqBfP8QQ6WUWW43AnX7ZXdcoXYQtfAUKOWms8jZxU6Dykw==
X-Received: by 2002:a05:6a21:205:b0:1db:ec2b:7322 with SMTP id adf61e73a8af0-1dc22b8c05cmr10818183637.46.1731374987152;
        Mon, 11 Nov 2024 17:29:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a43c:b34:8b29:4f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7f22sm9820976b3a.56.2024.11.11.17.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 17:29:46 -0800 (PST)
Date: Tue, 12 Nov 2024 10:29:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, ak@linux.intel.com,
	osandov@osandov.com, song@kernel.org, jannh@google.com,
	linux-fsdevel@vger.kernel.org, willy@infradead.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
Message-ID: <20241112012941.GC1458936@google.com>
References: <20240829174232.3133883-1-andrii@kernel.org>
 <20240829174232.3133883-10-andrii@kernel.org>
 <20241111055146.GA1458936@google.com>
 <CAEf4BzZz_L5yc8OE21x93zb2RU+bujNsyQJTmvOvpm3Y--Uwpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZz_L5yc8OE21x93zb2RU+bujNsyQJTmvOvpm3Y--Uwpw@mail.gmail.com>

On (24/11/11 09:49), Andrii Nakryiko wrote:
> > On (24/08/29 10:42), Andrii Nakryiko wrote:
> > > Now that build ID related internals in kernel/bpf/stackmap.c can be used
> > > both in sleepable and non-sleepable contexts, we need to add additional
> > > rcu_read_lock()/rcu_read_unlock() protection around fetching
> > > perf_callchain_entry, but with the refactoring in previous commit it's
> > > now pretty straightforward. We make sure to do rcu_read_unlock (in
> > > sleepable mode only) right before stack_map_get_build_id_offset() call
> > > which can sleep. By that time we don't have any more use of
> > > perf_callchain_entry.
> >
> > Shouldn't this be backported to stable kernels?  It seems that those still
> > do suspicious-RCU deference:
> >
> > __bpf_get_stack()
> >   get_perf_callchain()
> >     perf_callchain_user()
> >       perf_get_guest_cbs()
> 
> Do you see this issue in practice or have some repro?
> __bpf_get_stack() shouldn't be callable from sleepable BPF programs
> until my patch set, so I don't think there is anything to be
> backported. But maybe I'm missing something, which is why I'm asking
> whether this is a conclusion drawn from source code analysis, or there
> was actually a report somewhere.

I see a syzkaller report (internal) which triggers this call chain
and RCU-usage error.  Not sure how practical that is, but syzkaller
was able to hit it (the report I'm looking at is against 5.15, but
__bpf_get_stack()-wise I don't see any differences between 5.15,
6.1 and 6.6)

