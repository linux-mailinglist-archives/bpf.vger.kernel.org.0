Return-Path: <bpf+bounces-53491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D56A5522F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADEE7A56D0
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7382561AB;
	Thu,  6 Mar 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al1J+N82"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB911FC7F9;
	Thu,  6 Mar 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280589; cv=none; b=L43xqVD4W+z81MSmuNWzOZUDVXfZMKdaINgm1a+CoIuRpbuDRWIPwFDGS2bZZ3DaFwS5/jhYPfoExo0OzZpCLGpdyXE9H+bU+6F1xPLJRr1BSCM0b3fxPLOwpljfo96IeZt3dJJVn+tqdldoS3cZ3ty30JEDumpw2cHtw2GyK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280589; c=relaxed/simple;
	bh=qT2FSca1uUOi8PEA56k21cc5NlR2bIY4bwCA2FMiBYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv9nIjFOdsA9nHZoz4y3ucg3NjaNWip/aCf8s2eTnExRiVI9ybewJD9YHLoP+kwnGLpv8h/ZFzOfcEluYn8n/VtEXJI5o//ekV1qgI/i8ToLZwBehb0V+hzDEPfMElPLr86TEgjXjQ9VopTeH4wmzebGlT5t466c1+t0ZGhNvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al1J+N82; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso6188165e9.0;
        Thu, 06 Mar 2025 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741280586; x=1741885386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfE8QcUp7esL6UCjuo2VQWcHIYRhqjFKRPyPGB+H1yU=;
        b=al1J+N82QX3wh45OKBa1YcrClme3cnwbi3fyuJvj8kz7kS3Lus7ftotaANghSV4D3E
         R7DLFULSE+AltALkEB9WQ1RuZvWoE38QbnWEHDugPC+o7NU/ZtquzkFms1uNISHopkZX
         eDXpt1rpQsA/nvyhNkw5qGb7h6Qwwp4G7xw0ZTgHxvkSKswCgCiUUTiuY2Ia46EsC5LT
         8ZL0CYtDIRMm8IGPhfIY44zFpFLgRYz95dQZZrXMkaDAuDUSVhKRA1rEMZ1QRsE+4bML
         SIwOxZ7bQq23bVvFWXkVKO/C+FsbUqqUdlrBKQMYjkX+5Y7+RDp0GfD4zD8GTTbLnnNm
         Toow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280586; x=1741885386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfE8QcUp7esL6UCjuo2VQWcHIYRhqjFKRPyPGB+H1yU=;
        b=egvDLh325uiuR+Bx3nP1nzUc/lONYhbQTFcGjFpXzE3IXyAjV1eDGj71uwnvHAseqs
         GdslVGJ9Yggog8+Jykrp4QWBP/kvrLvm6LOE4AuByiix7J3T4JiYMeppG84YAcNqmwag
         d45vUpeJbXceFNRsgxbwCo4r7d9DzrWKWJrEhYzR5liegknZTS/vSHdm9PxJzt+lb8ev
         J5LUyzPTd87xOslS1TzkCxmnJSnB2OGM9UIlA4ZNU5BKNNqt5PnxYu+4Qwftf8yutQCH
         u0Klysa3aXSoUO9h4wE60hap0JHYECvD2occ+/WiqSDPObU/P9jng4mSIuuKZNTWDTAl
         wx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNp0GkuJ4kFtT3MQrrVgxq1VieKx6o9RcD5ruHXtN1r42Z5ttdlOKHutSiLlaHiqATcwA=@vger.kernel.org, AJvYcCW2gxmlBiq/T13H+xw0rMrGp0//KmLsXK730jB/rTDZ/S4DSQfvyel4VGfvUimpssVCnwMid4cM@vger.kernel.org
X-Gm-Message-State: AOJu0YxbFYpQqcyPE5TMwWvrE+ukfwy4d/BMY2iGH78VNs1Kpxf+ZDEF
	RcIFyjhf/pSJ70J9K4L6PHpBuQYOyMfKbBIp9ZuCN2l0Arry6+0j
X-Gm-Gg: ASbGncvLaojs7fMl3nVG6VKfz5kPNwLlKhXM4fmrRugq5F+y6FWvBb7lLA5epRezgfd
	hwgl0ZouCQPEVpzHyrD0DB3Xd/uUcQkaNsEMuDnx3okac3GN0Xo4+oqNl9a8vVqBHdGFa2YnObU
	gJkHDuBWA2uWj1uTG+sjcX3CW0pFBxRPRQDSDWXTBRKo/YYFrw29DAMQXqWsz+vIMzZKGdC3pla
	nzHWXtfCoBZZpD4ozN0/tIgWWYgYQBWBxLTGSeG5mHwNK2FxB+pY34q2TGDNMHRjUXX/dUiD2uB
	fePT6S7wJM2TfYWuWoR4K5y9lFlXq9zgzxIH+jolf7D2b+43H53STKxgfUvJ7utfj/UMW6FX7oH
	+Xu3J23s=
X-Google-Smtp-Source: AGHT+IFuiqYW5+UvFKNU5DXli7/ibxXNNsYnFNHIAbzAhMYJyECUlpBwL/QvJ3dJxScobXNS6aeg8w==
X-Received: by 2002:a05:600c:4587:b0:43b:cd12:8c92 with SMTP id 5b1f17b1804b1-43c601d07f4mr2203545e9.31.1741280585264;
        Thu, 06 Mar 2025 09:03:05 -0800 (PST)
Received: from MTARDY-M-GJC6 (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8dad73sm26002885e9.19.2025.03.06.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:03:04 -0800 (PST)
Date: Thu, 6 Mar 2025 18:03:02 +0100
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
	andrii@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to tracing
 programs
Message-ID: <Z8nVRtg7XwkOHjuv@MTARDY-M-GJC6>
References: <20250227182830.90863-1-mahe.tardy@gmail.com>
 <96dbd7df-1fa7-4caa-a52c-372d696e0f38@linux.dev>
 <Z8WBIR72Zu5x50N9@MTARDY-M-GJC6>
 <36637c9d-b6bc-4b8c-a2fd-9800c5a7a6dc@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36637c9d-b6bc-4b8c-a2fd-9800c5a7a6dc@linux.dev>

On Mon, Mar 03, 2025 at 11:14:53AM -0800, Martin KaFai Lau wrote:
> On 3/3/25 2:14 AM, Mahe Tardy wrote:
> > On Thu, Feb 27, 2025 at 12:32:43PM -0800, Martin KaFai Lau wrote:
> > > On 2/27/25 10:28 AM, Mahe Tardy wrote:
> > > > This is needed in the context of Cilium and Tetragon to retrieve netns
> > > > cookie from hostns when traffic leaves Pod, so that we can correlate
> > > > skb->sk's netns cookie.
> > > > 
> > > > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > > > ---
> > > > This is a follow-up of c221d3744ad3 ("bpf: add get_netns_cookie helper
> > > > to cgroup_skb programs") and eb62f49de7ec ("bpf: add get_netns_cookie
> > > > helper to tc programs"), adding this helper respectively to cgroup_skb
> > > > and tcx programs.
> > > > 
> > > > I looked up a patch doing a similar thing c5dbb89fc2ac ("bpf: Expose
> > > > bpf_get_socket_cookie to tracing programs") and there was an item about
> > > > "sleepable context". It seems it indeed concerns tracing and LSM progs
> > > > from reading 1e6c62a88215 ("bpf: Introduce sleepable BPF programs"). Is
> > > > this needed here?
> > > 
> > > Regarding sleepable, I think the bpf_get_netns_cookie_sock is only reading,
> > > should be fine.
> > 
> > Ok thank you.
> > 
> > > The immediate question is whether sock_net(sk) must be non-NULL for tracing.
> > 
> > We discussed this offline with Daniel Borkmann and we think that it
> > might not be the question. The get_netns_cookie(NULL) call allows us to
> > compare against get_netns_cookie(sock) to see whether the sock's netns
> > is equal to the init netns and thus dispatch different logic.
> 
> bpf_get_netns_cookie(NULL) should be fine.
> 
> I meant to ask if sock_net(sk) may return NULL for a non NULL sk. Please check.

Oh sorry for the confusion, I investigated with my humble kernel
knowledge: essentially sock_net(sk) is doing sk->sk_net->net, retrieving
the net struct representing the network namespace, to later extract the
cookie, and thus dereference the returned pointer (here is the concern).
The sk_net intermediary (in reality __sk_common.skc_net) is here because
of the possibility of switching on/off network namespaces via
CONFIG_NET_NS. It's a possible_net_t type containing (or not) the struct
net pointer, explaining why we use write/read_pnet to no-op or return
the global net ns. 

Now by adding this helper to tracing progs, it allows to call this
function in any function entry or function exit, but unlike kprobes,
it's not possible to just hook at an obvious arbitrary point in the code
where the net ns would be NULL in the sock struct. With that in mind, I
failed to crash the kernel tracing a function (some candidates were
inlined). I mostly grepped for sock_net_set, but I lack the knowledge to
guarantee that this could not happen right now or in the future. Maybe
that would be just safer to add a check and return 0 in that case if
that's ok? Not sure since the helper returns an 8-byte long opaque
number which thus includes 0 as a valid value.


