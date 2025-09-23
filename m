Return-Path: <bpf+bounces-69385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E90B959EE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CB7171FD7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C1321299;
	Tue, 23 Sep 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXyt+AlG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD972798FE
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626574; cv=none; b=Qlr8n5Xg6YhYp0yOrPMwBnZuAweEWXmbF1mye7aCrvjNO1M4sEb9yrFgQou1ENFnJvm9MRGGrvwQ2AEumTA6HAoG1NgL8/5rQ3ObkEyrWk41zT+lRcb5jT81Xb02OvExp/eLlFOYzH0dABelmNePxsWzRgqMPQg7F1TRc8Qit8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626574; c=relaxed/simple;
	bh=xtwJNpNpxSCvrg16jjKQTVD0gOG4EAflgUyJlvv47A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bOUiBBD1q1YK+42473bjIAh+LI70fblGBFfXhG0+YYT2pBp+FM4tQRiLZFA+/wnf3yYPVeEo+jfKXjLFvKMnQC+xwJOYPV5lzWOkUcUEoURQ5Cn3uDhmfohA4oSqry3QhvGMBDi4GgvZ4w4RvYl6goecBqb+pdRPFE+lq76p1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXyt+AlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60244C4CEF5;
	Tue, 23 Sep 2025 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758626574;
	bh=xtwJNpNpxSCvrg16jjKQTVD0gOG4EAflgUyJlvv47A8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UXyt+AlG5Byi8jY8lr+IOcOvQg4mck8g9JoYvZ+HdWniWAtLu6Fvwv4QSvHbOwfMF
	 8dUg0maqEFj28F6FWvzmv4fomkBzq1CjPN8HejxBgKl2kzanqumx8yYSWHfFImc+eW
	 KGuTDK+zs8IqAKJGTGkziqnhMjm0AbUzA/TrWv9Yw6PqeG1QwfSM5aC6CsmOvrvTO0
	 QnTqxjZDfmf5MvFE1ADPM1pwF8o/5sbwuOVixPJcGy4hsHKHof4waCleYgH0ZUC2/0
	 9BFj7tAp2PJ71rtAG37aFsYCbLHpeMQp2QaejW4upmz9RrKnFP5q344Y5/8Hy+C0Y0
	 xqnp9z4sFI4fQ==
Message-ID: <fccfa1f1-75a6-4094-9389-7e01b20833b2@kernel.org>
Date: Tue, 23 Sep 2025 12:22:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] bpftool: Formatting defined by user:fmt: decl tag
To: Nick Zavaritsky <mejedi@gmail.com>, bpf@vger.kernel.org
References: <20250921132503.9384-1-mejedi@gmail.com>
 <20250921132503.9384-2-mejedi@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250921132503.9384-2-mejedi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Note: For future submissions please make sure to add the maintainers in
copy for your message, "./scripts/get_maintainer.pl tools/bpf/bpftool/"
will give you the list.


2025-09-21 13:24 UTC+0000 ~ Nick Zavaritsky <mejedi@gmail.com>
> Certain data types get exceptionally unwieldy when formatted by bpftool,
> e.g. IP6 addresses.
> 
> Introduce custom formatting in bpftool driven by user:fmt: decl tag.
> When a type is tagged user:fmt:ip, the value is formatted as IP4 or IP6
> address depending on the value size.
> 
> When a type is tagged user:fmt:be, the value is interpreted as a
> big-endian integer (2, 4 or 8 bytes).


Hi, thanks for this!

I'm not sure I understand correctly. The 'user:fmt:*' tags are not used
yet, correct? So you're proposing to add it to existing code to get a
fancier bpftool output. Do you mean adding it to your own executables?
Or to existing kernel structures/types?


> 
> Example:
> 
> typedef struct in6_addr bpf_in6_addr
>     __attribute__((__btf_decl_tag__("user:fmt:ip")));
> bpf_in6_addr in6;
> 
> $ bpftool map dump name .data
> [{
>         "value": {
>             ".data": [{
>                     "in6": "2001:db8:130f::9c0:876a:130b"
>                 }
>             ]
>         }
>     }
> ]
> 
> versus
> 
> $ bpftool map dump name .data
> [{
>         "value": {
>             ".data": [{
>                     "in6": {
>                         "in6_u": {
>                             "u6_addr8": [32,1,13,184,19,15,0,0,0,0,9,192,135,106,19,11
>                             ],
>                             "u6_addr16": [288,47117,3859,0,0,49161,27271,2835
>                             ],
>                             "u6_addr32": [3087860000,3859,3221815296,185821831
>                             ]
>                         }
>                     }
>                 }
>             ]
>         }
>     }
> ]

My concern with the example above is that 1) this may be a breaking
change for existing scripts parsing map dumps, and 2) we lose the
structure and byte representation for in6 (in this example), which means
less post-processing for humans, but potentially more for tooling.

If you mean to use the BTF tags as opt-in in your own maps, then that's
probably OK. If you mean to change it in existing structures, I don't
know - maybe I'd add the custom representation _in addition_ to the
existing one, rather than in place.

Quentin

