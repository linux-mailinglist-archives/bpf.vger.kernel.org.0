Return-Path: <bpf+bounces-47771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2E9FFF6D
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E99188346D
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64F1A2632;
	Thu,  2 Jan 2025 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cBdzmdO0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6581B4141
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735846234; cv=none; b=A0W43LuWMoiOCgWPbT2YqMD2WpBEaAdsNP+pY5hoiXehnv+KwfNs6ImjXi5lac18Shj/kt6R/NcAmOsrGcIcKD2mwLDtlGr+7fkp2Jq+PnlgjBMNi5A6KeGuozw+3gzkmQHaNSrKK8sSxZq2/MGkIyCcDlUBtGqonnaZfAqvTIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735846234; c=relaxed/simple;
	bh=uovgF/lPK6er1So/gVnn/fh0FzkKPM0lYUu800eNqng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVs29TPWrEaADLWQlJQVZtG1lWNxZLcSwCG2IYgJCzEs9R2L6FauE4i+DC2x2w/kr66Ph1x3wDI9843fSNCXSF3Pgj6P/Gbl6vo2QcXigS3I4Jcgs5jYF/G25KZlt/kjaLzAa0okNTrfXsd8K5k8O8fOa+bXd58VukipNMKL6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cBdzmdO0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso1814790066b.2
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735846230; x=1736451030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IkRRoUTAoPCUhgTT5UTFQy+df5m2Y91ZttoTEhYnYYg=;
        b=cBdzmdO06JIL3NrFFf/mzBLFnKVyrggdVTNJPeZxeuAwTwi3zZ/sFwnsg9+pY79Gqi
         CedvvWCHz9yJJJzHPOXY/voEbumhNTTrjhtubnPlmEgRAX82M/uUX2R/RtReZSVm9AAj
         /LhlCztFs0XQUAdCTjHzIH5KMD1cDS1Ck8SiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735846230; x=1736451030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkRRoUTAoPCUhgTT5UTFQy+df5m2Y91ZttoTEhYnYYg=;
        b=fXbj4MBjMDPrxFAZ9lYc9FshNA4lo7nrk3wyzW2XGS6UeO3Z0qH15pw37JTJ+445Gq
         Cm55ysnYL4gKWfUELpAbFIf/JCQBgfZHBuZcIl3WFZxzlwNzEj3j8lEmUigfNZXSxtw2
         sc6yayDJiwMUkwH2wHI77e+LzvkLlh3ZRDUoo9pnyAu//WofF/TCf8Nh5pAqhPDTujks
         Dcav1Z+/CcQL8flocMTPzUAYxchmd8SKiP8MK6NrV8orptJIgLj8+c+4xILD8erm2F4B
         tVdKE6Te3+XFeDicB+Zg42fgNsxQVG/ihb85xPBSnjHsrhbtYxYKUlf+KX3jEr9iqFVe
         MYxA==
X-Forwarded-Encrypted: i=1; AJvYcCWGMyv6Mr8/FmepJZTLgEDsj19O4DC9VhkakazpQBCp43X++nNCth2zEyY+3fynfCIT61E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAY6+4VTwwB2qZuYI9Zw6qRjodJilJGaICSe0avZyTywE5R12t
	1uy2b91ntXrgjGd9rmky6Kmm9YkhSlZEqCQ/iKv74cHILUCVIFEdXCYipkLLm0dvFkkZ4qxxXOE
	HwxM=
X-Gm-Gg: ASbGncu3oIYp4935yCz4xGyCzY5wZRR0mdszZwKR93JZQJe0cjx6zKClfUeOuf5QK53
	4hats5OKAjHJTH8BWSjforf9sg9pbqCe7N4gzVWzSnKc3ky5LM4BcsRx5FfVJ+AC/PTYk5BrgV+
	VBw8iye/lYCNh7RKfc6jFPuJEnw6S0sA/1Dy8XkgzNiaHPaACp7x5b9IVfsoOYuIBhUtEZYxvgD
	uZhhZYBz0kyV3oSse5k0NPPUfTWztRD0JF6DYPeRkav6Amb1J7EvPxHtQSowNfBdSvlfULlJO3f
	ds1SUVNaSYnFu0djDgnmjzu8/ih6mh0=
X-Google-Smtp-Source: AGHT+IFYCf2FXZRN/XqaYBGS9eitMTmC6CQLPodEdYqid6darwKi8VTwfSfUGkxE/YvlOLYD3kT76w==
X-Received: by 2002:a17:907:318c:b0:aaf:ab6f:da49 with SMTP id a640c23a62f3a-aafab6fdc82mr63352366b.39.1735846230379;
        Thu, 02 Jan 2025 11:30:30 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0159b8sm1818566966b.157.2025.01.02.11.30.29
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 11:30:30 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa689a37dd4so1809439966b.3
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 11:30:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpJZnq3v21Z1SKMl5Q/Ke7HNu6cry1wp35+wNISqmBSV0qTwz32r6inGjERugcrAnsZF8=@vger.kernel.org
X-Received: by 2002:a17:906:c14c:b0:aa6:80fa:f692 with SMTP id
 a640c23a62f3a-aac33691020mr4123756466b.49.1735846228960; Thu, 02 Jan 2025
 11:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102185845.928488650@goodmis.org>
In-Reply-To: <20250102185845.928488650@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Jan 2025 11:30:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
Message-ID: <CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
Subject: Re: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders for
 weak functions in available_filter_functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Jan 2025 at 10:59, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Where the file created by "nm -S" is read, recording the address
> and the associated sizes of each function. It then is sorted, and
> before sorting the mcount_loc table, it is scanned to make sure
> all symbols in the mcounc_loc are within the boundaries of the functions
> defined by nm. If they are not, they are zeroed out, as they are most
> likely weak functions (I don't know what else they would be).

Please just do this by sorting non-existent functions at the end,
instead of just zeroing them out.

That makes the mcount_loc table dense in valid entries. We could then
just rewrite the size of the table (or just add a variable containing
the size, if you don't want to change ELF metadata - but you're
already sorting the table, so why not?)

Because:

> Then on boot up, when creating the ftrace tables from the mcount_loc
> table, it will ignore any function that matches the kaslr_offset()
> value.

Why even do that? Why not just make the mcount_loc table be proper in
the first place.

             Linus

