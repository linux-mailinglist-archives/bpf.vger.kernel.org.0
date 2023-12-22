Return-Path: <bpf+bounces-18610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970781CB17
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7041F229D3
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45C1A5B8;
	Fri, 22 Dec 2023 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5qWxk++"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7431D527
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55462583ae0so532163a12.1
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703253924; x=1703858724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qflNQ/Zextm0wcHnReDhL/TH4zd57h5UnUpGIg5IHzc=;
        b=I5qWxk++7yD0lYA3WyebFDlmP9LpyYIJexeODtqywje24oMH/yAuSsbu8Az8hJ8gXU
         usxoIvJUb26voRiBdJtDKASBE45GIyeKUrEnrZXANlaceSTMBG8AOvcH45vhcUnyl959
         kPbc1wa7B1kIVEEZnxiB7DedSECQSULVajvNzdjWbZV2iYcA14wuJTNNlTzKjcLb+5U3
         Q22szPOpZiFp8LukyhvfmO4RUQ2EW4P6v3ATcrKwtK+11bxeYCSQFckYCFkmysGZSuzS
         tcLAXtxLLS+mn8D3O8QVIFvCMcpsfI8dgZoRCTy9pakz7gxSkjUpKU0rSsX8aYSB5XDi
         1X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703253924; x=1703858724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qflNQ/Zextm0wcHnReDhL/TH4zd57h5UnUpGIg5IHzc=;
        b=pZ9AoDegVOVGFghXqmQSRttyyKpgDY0gSU1IZTjSwcMd1lQsnU+vpCkTU1FYXGyMvm
         0iUnUaixpXwR7lPR3ihrXzxC5kA71fV46ej7YdLnq7Dp6hM2NS+0dzJIyvqTtPBBbKXp
         CAKWcQz4Yu1k3mBtO/sc45jny+aPm2g0NiqlqzcaBDQMyBES7OlT/edl0Qa+HBkQHlIr
         CSgyozQNe98wgN5OV9F1kdEgWLIAgqSDzjY40dAls+/Pe512ymxchZKDcLW+13H/p4A+
         ZsDQmmkIBh++qQyuuuy9/qgdOzwzUEmBDEF8ssQ3XnWGKjftQepm7tuAuNeBzies7mwI
         0QYg==
X-Gm-Message-State: AOJu0YwjtLy/RF1flessj1sQlyJhpkEc87YtM0/BZZ1w55y/e9GnUknh
	zPOFgRu2AlU0v3+Y0+3LdDQ=
X-Google-Smtp-Source: AGHT+IG3cZx8KWmohExfpqhJPd1y8/VfbU+hFjUH03riw63cYHsTIgu1Ptjx4vO26nyBe5CGBlAWjw==
X-Received: by 2002:a17:906:73db:b0:a23:5ad5:27b2 with SMTP id n27-20020a17090673db00b00a235ad527b2mr447116ejl.212.1703253923873;
        Fri, 22 Dec 2023 06:05:23 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id gf13-20020a170906e20d00b00a236cf1e4d0sm2091594ejb.167.2023.12.22.06.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:05:23 -0800 (PST)
Date: Fri, 22 Dec 2023 15:05:21 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v10 1/4] bpf: Relax tracing prog recursive
 attach rules
Message-ID: <20231222140521.2lb3e7udtpiz7ydj@erthalion.local>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
 <20231220180422.8375-2-9erthalion6@gmail.com>
 <ZYR9mrvFargzFlQp@krava>
 <20231221202437.gwpktfli43kdrcbg@erthalion>
 <ZYS4jlTJ0k8z9TMY@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYS4jlTJ0k8z9TMY@krava>

> On Thu, Dec 21, 2023 at 11:13:34PM +0100, Jiri Olsa wrote:
> > As as side note, I find it's generally a good idea to reset
> > attach_tracing_prog in bpf_tracing_prog_attach when the tgt_prog switch
> > happens. It has to do both setting it on and off, if the new target is a
> > tracing/not tracing prog. The flag still will be kept during the whole
> > lifetime, unless switched in bpf_tracing_prog_attach -- meaning no
> > changes in bpf_tracing_link_release. If changing the attachment target
> > would be possible, that would be the way to go.
>
> agreed, you can add my ack to the next version with test fix

Great, thanks! Will post the new version with updated tests and the same
attach_tracing_prog implementation in a moment.

