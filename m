Return-Path: <bpf+bounces-16015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7027FAF25
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 01:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B410B211B5
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5ED1106;
	Tue, 28 Nov 2023 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHoMmJqx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EAB1B8
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 16:38:29 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cb4d366248so4087366b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 16:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131908; x=1701736708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fNw2eIUtbhcx1uJXLJPbzj/JB70v0tFbSwe06tS98E=;
        b=CHoMmJqx2jS7RlyJHItzIsplrhkC7rN3aK85plOL2Lw2gY+KncgWnls7PVO1wvMEVq
         4aYi5rZbGcaErAxVkuJzQfUjp5xN0qoVe5b4FOh+F+ut/KvxZVVh2oyBIFWYzwGDfMVo
         rfrW6qRFOMcCC5wqPKSovamCLNZYzVlIikCKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131908; x=1701736708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fNw2eIUtbhcx1uJXLJPbzj/JB70v0tFbSwe06tS98E=;
        b=qOZqEyg8KnjAJpmKPxy7hzkTDn5y7M8NntaSkXsRpTG8T/VjA+y2Y4BGgMBlXOw2L+
         +9o9VjY4nwaQSX19IWgwfdpYdzZPZnSi+uI/YEkyC2sKypThQffpgvJFhTX3LAZhBY21
         +G04RBO1ab4TzKdWYds8KlsVsQ+MaGHiyQ0Srf1Lb0XNx0pClk4MKI1uWktBAIPUeGOY
         6+l+boI7WjxUrAraNG2dVn63p+FgiDQYKVmn8R2rykEB7024q7tIJN+MZD87iMtaaVMt
         nnUI7a0aNWl9FTnS9WwLZvOieM2TYIs6YGqKFz2agwSZSu5GNkFwjAVRTTjBDQpvTiQO
         3shg==
X-Gm-Message-State: AOJu0Yy7YbzhWFolWoBqcymq5PC2Rf1A0skh0MoCkr6jLrLt4C/k/+rw
	SRVQ7xWfv2ODNxOfYd2ihpRIoA==
X-Google-Smtp-Source: AGHT+IHAitSTcXoIZlZjvSV2TgClAiDRvzC+m7Xe4lYvQu41xQFuy0SB9v8Un1QuYXWLLWDiwFuTWw==
X-Received: by 2002:a05:6a21:3514:b0:188:1df7:9afe with SMTP id zc20-20020a056a21351400b001881df79afemr15530469pzb.30.1701131908573;
        Mon, 27 Nov 2023 16:38:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b00686b649cdd0sm7815539pfa.86.2023.11.27.16.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:38:28 -0800 (PST)
Date: Mon, 27 Nov 2023 16:38:27 -0800
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kernfs: Convert from strlcpy() to strscpy()
Message-ID: <202311271637.38C4FD46@keescook>
References: <20231116191718.work.246-kees@kernel.org>
 <2023112751-cozy-dangle-3f5a@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112751-cozy-dangle-3f5a@gregkh>

On Mon, Nov 27, 2023 at 01:43:57PM +0000, Greg Kroah-Hartman wrote:
> On Thu, Nov 16, 2023 at 11:21:22AM -0800, Kees Cook wrote:
> > Hi,
> > 
> > One of the last users of strlcpy() is kernfs, which has some complex
> > calling hierarchies that needed to be carefully examined. This series
> > refactors the strlcpy() calls into strscpy() calls, and bubbles up all
> > changes in return value checking for callers.
> 
> Why not work instead to convert kernfs (and by proxy cgroups) to use the
> "safe" string functions based on seq_file?  This should be a simpler
> patch series to review, and implement on a per-function basis, and then
> we would not have any string functions in kernfs anymore.

One thing at a time. :) This lets us finish the strlcpy() removal. But
yes, replacing all of kernfs/sysfs to pass a seq_buf instead of a char *
is on the list. :) I think I see a way to transition to it, too.

-- 
Kees Cook

