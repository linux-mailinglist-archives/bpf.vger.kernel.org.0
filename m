Return-Path: <bpf+bounces-75562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14769C88D37
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 050033488D7
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD5C30BF74;
	Wed, 26 Nov 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KtqACpxc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C003019CB
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147860; cv=none; b=duP5TWAaCV/rbASC0f//fGK7F8QhwAvzFLUh1sf9tm1mjTM6sdhKdFPi67OjwSs+mSG+LNJF3QbnHXHuWQvdFy+4a4w7THdhns0z0mueEpcoobicO4NjEkAYc4ueIS+zR0qDp1ZXEzD2Z0r2MHcOXhcqx/zEpwyhYfy02n2Mq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147860; c=relaxed/simple;
	bh=t4zOHoDb1XYT6cH9+BNQodpxhffhcA9268AJWPFsTTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OemUlPnJUCYVVcNQoCvRQHqvlV2CeYCq0VqH99QoGUBuXBjMHq/sqOVkKWIAip7gyKg8CLGrFHkHL0VVz7oVLeIwCWS0QookrhnYPDTS0ljqNR7wW2MrWw7/oMUfOYxLjDqHKCDg7BO3do1G1HxF8IA0nFE2T7pUT+cVtWhdCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KtqACpxc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b91680f8so50621185e9.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 01:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764147851; x=1764752651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FupKmerMUOWllqZV7KgoDEqU3FgckHmxVkwtl+flH/c=;
        b=KtqACpxcs33NM4wqhGuPH4fvoX0mnp8PB67dOLRS00OckXnQ6ZZGdqfQrUlDlztTZq
         xErPXwEIH91qfs4ergrHmY/q355GyJNG6XO43eO7FYhluvhyAxkqYet7rPe6CbecBUY5
         5BUTFMitS8OLnYAspPXwn0mixj2HDW3WzNAUWaaAlnpFaDNHKY3k89acL/SV2EdY/tPH
         dUFOBGjnpB6Cgie81dM4HmsZDlXtI9Mn/oOhP9GvGqD86r3nqk8jJprG8aLSzQ9cB+cY
         y5jPlPnL2E4YeER+HQYyFnWvTISSzbKJKWcOgGf4qnEeyqKvC/P2+0fGAIiy9f2yUPfM
         MVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147851; x=1764752651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FupKmerMUOWllqZV7KgoDEqU3FgckHmxVkwtl+flH/c=;
        b=Y3W+1+H/NiNEfov/znDlSD2UK05bGbqb05Gp5Pu5t9kmdECiJf1jaicTreED45lEt1
         +NB4cBuyfXlM1hRtEt615DMaN1Ls4/u7THv51bdhJ5e/APK5lAJ+hdWcSGTUHkTtGjnz
         osTIleK0uNVM75buH4tMBb7QYvDsDbmjJzSCP2V5XFDj4o/czgHcu68ZWKLNW+fREyC+
         olF4lCyJcDtZ6NtpFdBfKDF7NUrNdUi+xQYvf7cQzB67i8uF9iOSnUPK+OkQFGDYkTia
         BXNK/a1CPu8fQTjWA6pJIQazzgGMPM4y4PyHROXJijwRCQGdKDnmFVOmn8m1SAyZhYRE
         ub2Q==
X-Gm-Message-State: AOJu0YzFmMQ5Tj0Oh6ZA+jA+/O08WEdziQ1vl207WA1Dl8JbWC6nWxz3
	bv6Qr7kxlLGElLfpQxajXhYe+E9gmiGMAVFWULixDQupxg6PZXYELnH+yDNLTi48iHI=
X-Gm-Gg: ASbGncsc0qVHL7tUrN0rUCsjL3jAxZuNUBnNwsZ4sMxvl3NkPC/b5kOrnrDcES6IdOK
	qJtbiqJ03VyMKAvbuAWsN66VwzIw5fi5YYjI11Y8roBmyZZecAbkkaaBRtHx6QOirs2dVehTEPw
	pNev1rFKXgqMYS1V1UoQTmtAnmFyR3iJ6mFQd/totCfZIBS58g2mbzQ/D79y5jWdpc4ucDk/CHP
	z3e4gnis3wcFDMihkHT6YojDrerlXOo1MUYriwhsIA1DFysgteKeoJy6pTcLVXFccZw6CSElify
	Xc3dwvhJ5S3CSPeGIK91sP2dFJLAupJp8Li33eJNUw9bRvyhKcGvKwNjvwWTQWclXNIbzq+lbww
	PO60/QBAb/twrg3cxQraeuuzE9Td+EUhUWvI5JVTjsVGf8iQQPCvkgK0hmtf1qh88BAyblSCjr3
	xp0rYzKOQ=
X-Google-Smtp-Source: AGHT+IF08SVDwM+FsUhCoExPKGS6lNLP7/Qw/HxNnBq3PQ6yo++Jswuj02ARZiZAF/v7YkxLMjePEQ==
X-Received: by 2002:a05:600c:6296:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-477c10d7013mr192712295e9.11.1764147850872;
        Wed, 26 Nov 2025 01:04:10 -0800 (PST)
Received: from u94a ([2401:e180:8d00:1d6b:b712:4f62:bc36:6491])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fae9e2sm18673343a12.31.2025.11.26.01.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:04:10 -0800 (PST)
Date: Wed, 26 Nov 2025 17:04:03 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH v1 0/3] Add tnum_scast helper
Message-ID: <dc5my7udql3eobrkglwg4rvqakzl76fz3uydlk5zngj4gjnoa6@b7ej77j2ykk2>
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>

On Tue, Nov 25, 2025 at 02:56:31PM +0200, Dimitar Kanaliev wrote:
[...]
> Changelog:
> 	v0 -> v1:
> 	- Simplified tnum_scast() implementation to use native s64
> 	arithmetic shifts for sign extension instead of manual bit masking.
> 	- Refactored coerce_{reg,subreg}_to_size_sx in verifier to rely
> 	on __update_reg_bounds() instead of the previously introduced
> 	manual logic. Removed some dead code for set_sext{32,64} values.

Nit: you might want to point out who requested the change in the
changelog for clarity, e.g.

 - Simplified tnum_scast() implementation to use native s64 arithmetic
   shifts for sign extension instead of manual bit masking (Eduard)

> 	- Removed irrelevant tests, added one that fails at base without
> 	our changes.
[...]

