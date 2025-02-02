Return-Path: <bpf+bounces-50300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E3A24D6B
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07C77A1DD8
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2871D5ADE;
	Sun,  2 Feb 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3RMa4Pf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F3155336;
	Sun,  2 Feb 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738490795; cv=none; b=Oq95r8uOYFfJt6xngy86Sa+ZJmZicvrbL59PjCYQeNiQBFxW76gstvR6gk445KS3IYBThl1dbb3lr6RtxXQYZ+QShGC3J/EmJq/U3w7n8LxMT/OMEvi5V+ZSxsjcfmCRT2m2h/t57++gdNEaaxyrgY0R+U/YHKpJpHhzsfC2kSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738490795; c=relaxed/simple;
	bh=eibt3Lh6er0cl/46qYhA7FxgdPAUMkq76azP7GqyryU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9/rmo9s9pLhPnkWkVA+b6rMbjMycpOqkyGl6qOVvrZRAotjyOAkvANl8pXWysSYwXVGHNUgvFxGAy31hQ1XJEdpOxmhA3wQxpVM2lbgKCDBJKyAsGPkyJfQKfIIJ1btORMRiTXhk1hGmZxXoQgRZOuSbEuR6/6UN7wzF+ObsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3RMa4Pf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so553003966b.1;
        Sun, 02 Feb 2025 02:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738490792; x=1739095592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vP80Ll/PNjgw877UXJRsX5g02CC+j9UoNcZ3BPAo0r0=;
        b=M3RMa4PfDtWbvKfvITB0HKvQXvUUj02LCxqr82t5Uylx/o5Q9+xKJPLmsrkoPeufph
         BbOZiwEgdUZpXl5KFeUOpOl/QkumTsCyonC7wXqKNv+kIZ7mYGbRy6E1GG8a+1KUTwQk
         qYJkpRxVEHSy4lnCiRGLaZcy+jZf6m4bWJfni34AhIhNMBF8he/RAGOH7iBkFwynQ7Ux
         KRoFNXTrY065vmde3A6ArU5c7SQ9Qju5c+B7CIkN0/5LbAeC6kL/aPfvJjDBo+cOErVg
         4SWFEixL6Zlo4UdBmEPgCpEGB0xwBtpnFuWoeC96uEl3W6L4idR7FS1gHZWTUAXOTrMZ
         giDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738490792; x=1739095592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vP80Ll/PNjgw877UXJRsX5g02CC+j9UoNcZ3BPAo0r0=;
        b=X1oLSwFd7vrSnXsbTuWgvRvvSCnldJrjSHQVr2QEc0vWU/Oq+8zyJhcD+33JP0E4Bn
         KWnoyHeS2B8Jq0Ag4UvBlzDRusAhmDwU41PFnSEZExg9v/pfZro1KK4TIeuM8L3suLUW
         szDrR9IyzUYeiqoJ8hQJo7ku4cDqYM/V8ZkHOkZmlWW+rrxR0N0iI+36dVmKRU9V8qG+
         b7ohnRNe5FCLOl+l8ANIS6FiS6jBG0+zE0D54aJ6t5bNMvpvD1c/fnJ/6Ciu/ZKYBqvK
         vZ51cMr1yUBtKVnvHAgF6xLCLfBFTqGmjEG7KwXf8jPeBmEQcXmjMWbgPtAVtvQKuUce
         JdhA==
X-Forwarded-Encrypted: i=1; AJvYcCUgoRUXyl1voMFg3f1WGM6VtAsRuVLacUdpcSM8yWwxV0gtUnZyctlGXlnMB8jl4dgGa4AuyWi3@vger.kernel.org, AJvYcCWsoUQM+r6S116y8ioF5QbqW+qFpYHwCOII+yOEGp+s5168gO2nLN3uYvZ3p7L+TlVIAeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhxA2u+vc+wwx/zJzhxzz4KvU0iSALVt9AHTDTnEX2epaLZ6E
	ch6qKU8fN4ClCP07ELa/KaLGe6mTn4hYLQPeGNRUIJwaR2NJ76wC
X-Gm-Gg: ASbGncvYjOZvGukOuo9a2+EB29jXKFNqs8JBqw4FAIU+z+sp1Hsx1aUyjp43n6s9X2/
	hRnZWDtd1vMMe4NXMYgY++guBMxMhDjWaDnWNwpYGNFdXNdZA7lb+lJCnUmqPtgd3jbGc+1A+Cm
	uEilZO886Ua95fZMQeM7Jn4h3xpGmNqToxJs2/WwIH+R9xQ9fQNnZ1f0lldBkV+lOh8a0M1EG31
	3QxbBFfY8Gt0OkNAsVQlxPyBfoW+QtugGkFjF8ZmQak9MyYbGeh6vSjkKlWjymvtQPhbeVxkqzs
	X85kW+1gm5HdCcXEBA5Oog==
X-Google-Smtp-Source: AGHT+IEVXRaEp77yKVNwR7B7xh5bHwyQs7F+LF8dtiFtrTypQ1ye/9BA4YzULDjz+3kyf3Z5nwjPmw==
X-Received: by 2002:a17:907:948a:b0:aab:f11f:f360 with SMTP id a640c23a62f3a-ab6cfcb39ffmr2052568066b.2.1738490791506;
        Sun, 02 Feb 2025 02:06:31 -0800 (PST)
Received: from krava (37-188-150-0.red.o2.cz. [37.188.150.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab703a41cb1sm328912766b.103.2025.02.02.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 02:06:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Feb 2025 11:06:26 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 bpf] net: Add rx_skb of kfree_skb to
 raw_tp_null_args[].
Message-ID: <Z59Donij6yuw9hvB@krava>
References: <20250201030142.62703-1-kuniyu@amazon.com>
 <Z53Xv-okoj3PDT50@krava>
 <CAADnVQJodt1fBaR5d0wTR2pwipJVVdKSd+7_ou_vE-gRMzbT6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJodt1fBaR5d0wTR2pwipJVVdKSd+7_ou_vE-gRMzbT6w@mail.gmail.com>

On Sat, Feb 01, 2025 at 09:15:28AM +0100, Alexei Starovoitov wrote:
> On Sat, Feb 1, 2025 at 9:13 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > v2:
> > >   * Add kfree_skb to raw_tp_null_args[] instead of annotating
> > >     rx_skb with __nullable
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Jiri, Kumar,
> how come that we missed it earlier?
> Is this a new change in the tracepoint?

must have slipped, sry.. I'll double check tracepoints again

jirka

