Return-Path: <bpf+bounces-64844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBDB17876
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F361C25831
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392A526A095;
	Thu, 31 Jul 2025 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcy/Y9je"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39625A620;
	Thu, 31 Jul 2025 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998780; cv=none; b=gDBtUkKvXVZcagInw6NN6z2nfKcAZZRwECz7f3Mol2j7JJHG0YJvVZKHe+Iqr8hMjPRl0tntPgkJuYRRnnEonQXqYOsMhr+PihXaUUE7GqxrhmhsD7Fe1pUu6jyoYTVkWwgISe/Vg1jMmL4R0ZH6C0O7P0ou1szL0GIdOHqqFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998780; c=relaxed/simple;
	bh=vXRT0yl7XFxzR3VfyXSij8tuXcLpumLPbwXPAN3BWtk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmtsyDh/M4fXj2nn9EdXKjhJOsDM5JPfW3V0RD3/s3IJ7Xu5Q+XkUU6S2eMI6GVX/YLzlY/DWuBNdQ7ONDcOz004GsCiGP1KgngTMll7gfHc3U4sfjGHZkYwlsUWUI5D/LpGtHQ4rOfKzxEee7nJOhPrcSovgkoHtPBQP3hDQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcy/Y9je; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so204947466b.3;
        Thu, 31 Jul 2025 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753998777; x=1754603577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pH7sz35AtHRlCnrQDCM7yIzOahLIxp4d2PNik5qtm/A=;
        b=Kcy/Y9je4Q1/gzimyr7+hdRJN9lIpCg/2YYJ1iCtAqNlWGaJhvG7HDDp4MqhiH00jZ
         vUtDUMq+5B0C7/lSrQawZi57MwxLxRm1+KQN4GbmRxgcRj4rO9K/s02oUafRKdyufTP1
         kyNLU20pjWRE7IVUo1aGnKhiXPPMbzl+Rz9AiIZ2/5tH4c8+UqIUHqVi1XeU4JXcCJZ3
         85kKW32eBGWqJ7EEw6Qm7lOEg1FXFliJrAiKrHbAo2rCYlWXw9S6IzeQr9mIEMjFITcG
         /p3FNPPMWPlPPp6nKdtiSDFdtfUJhcwj/w+vF1Zgy+5DMFh2YabWqlc9g+DQ+GMCyNzT
         0VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753998777; x=1754603577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH7sz35AtHRlCnrQDCM7yIzOahLIxp4d2PNik5qtm/A=;
        b=F8xuJHN2z7BBVgBr9ak109E7iHyvYOrmYQesQWXhzsG1npb3H6mXFIRS738XbtCIp3
         F9iKiFpAa5WrrqBkufWq6E/uS52vY/sh8RwHQDT1oWalfmvfCYh/2RtTYXFNHXeeucl7
         55fB9yluvGCNCEBkKswIkeyWh9P+9t0yNhm0BFo4CS0KlSYSrlsRNSamWJdOOrGe9jrL
         BhXacreyTZY+JYtVg+bX7wgC+U0rCAr4fJFkH0ikT48sWNNJlfPzTMNMwv4AyepiIImM
         In7YXw8OBYku7J564tetyiWzGwfJWCptP3QaRFkudN/R1ueaH0B66e1ZzsWqHwA5Cyb5
         j01g==
X-Forwarded-Encrypted: i=1; AJvYcCVSpNAM5aPpWuSkxmELsIBWCOJoOfXnQFC32/YIhn2tVVSOucxcpL/i4oDO9i3+RFlJrSI=@vger.kernel.org, AJvYcCXJSNDv/kTLxPtDy5Wpjmk1dxdqYSl/W5UqyGD/HhvZ8gWgwDKW9KIp1zN5SWesQHLWXf0AURj05TzL7/7scjJmYsJm@vger.kernel.org
X-Gm-Message-State: AOJu0YxlF4DKnDiBeprQJLqArdiHiuzKaJ3fo1vI0HMyf5tCUHWA8Qm5
	On6Yd9BEL5xlHxZpNpGgsoAlIB32A3Z63o16rwHb9xoopOSs9W+zpPc8
X-Gm-Gg: ASbGncvOQV+PZXtPiUEt/X2H09Tqq6yk3dAstMzbltmIyTYBgvQxluh+FmtNJT91y7w
	Ds7qw70r4gJV1hngmlFz2WTvucNVknJRNhQ47l7rmORJteleZ/OyH1su2mfzePtiw4c5Kted3Vs
	r2q3ARv8xfCC4cfd+VyGPDXkvduECkVnfrXEVrTd/hR6l1v82AWKfPYb0KNMXuhM4RhaOCl3EoU
	AQiIy/g+pS5fbhujn9dK0JsodwTXIQQn46+xFe6Os9eDRAVSfk4iu4OYCfJ+fCs50H7CL31L8fb
	5oYlu0rv3dmaB5jXEdo3KTu2BostqdZE+I8SkcJhzygIpVWY5qi5A8qTOAoAvdnZx/0ErvgSbC2
	HrV/C19I5pw==
X-Google-Smtp-Source: AGHT+IGL82FtrUt1Nixu5effk/DO8t4E+terwhdFNL5pzS7lkcztjIWv5o9YiO3+h9HkpAhB7y45qQ==
X-Received: by 2002:a17:907:7f8c:b0:ae0:35fb:5c83 with SMTP id a640c23a62f3a-af8fd940ebfmr1002527266b.28.1753998772766;
        Thu, 31 Jul 2025 14:52:52 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a396fsm182284766b.42.2025.07.31.14.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:52:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Jul 2025 23:52:45 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	Tom Zanussi <zanussi@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, aahringo@redhat.com
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <aIvlrQEZQ6OTZxAY@krava>
References: <20250729113335.2e4f087d@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729113335.2e4f087d@batman.local.home>

On Tue, Jul 29, 2025 at 11:33:35AM -0400, Steven Rostedt wrote:

SNIP

> +/**
> + * btf_find_offset - Find an offset of a member for a structure
> + * @arg: A structure name followed by one or more members
> + * @offset_p: A pointer to where to store the offset
> + *
> + * Will parse @arg with the expected format of: struct.member[[.member]..]
> + * It is delimited by '.'. The first item must be a structure type.
> + * The next are its members. If the member is also of a structure type it
> + * another member may follow ".member".
> + *
> + * Note, @arg is modified but will be put back to what it was on return.
> + *
> + * Returns: 0 on success and -EINVAL if no '.' is present
> + *    or -ENXIO if the structure or member is not found.
> + *    Returns -EINVAL if BTF is not defined.
> + *  On success, @offset_p will contain the offset of the member specified
> + *    by @arg.
> + */
> +int btf_find_offset(char *arg, long *offset_p)
> +{
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	long offset = 0;
> +	char *ptr;
> +	int ret;
> +	s32 id;
> +
> +	ptr = strchr(arg, '.');
> +	if (!ptr)
> +		return -EINVAL;
> +
> +	*ptr = '\0';
> +
> +	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);

hi,
I think you need to call btf_put(btf) before return

jirka


> +	if (id < 0)
> +		goto error;
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(btf, id);
> +
> +	/* May allow more than one member, as long as they are structures */
> +	do {
> +		if (!t || !btf_type_is_struct(t))
> +			goto error;
> +
> +		*ptr++ = '.';
> +		arg = ptr;
> +		ptr = strchr(ptr, '.');
> +		if (ptr)
> +			*ptr = '\0';
> +
> +		ret = find_member(arg, btf, &t, 0);
> +		if (ret < 0)
> +			goto error;
> +
> +		offset += ret;
> +
> +	} while (ptr);
> +
> +	*offset_p = offset;
> +	return 0;
> +
> +error:
> +	if (ptr)
> +		*ptr = '.';
> +	return -ENXIO;
> +}

SNIP

