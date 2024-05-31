Return-Path: <bpf+bounces-31010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A08D5FD6
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6640228805F
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8660D156238;
	Fri, 31 May 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0mGmhixv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eeeYtSsy"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D95D51E
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151975; cv=none; b=fQQ/N8zQqdkpcQhnmG5zPfOhiylb0X1wKrufZ7qFORJ2GN8JH1Yc+EJoMYXiEXzFS238LyUzj3RHCmD+wqFMWGzUgKOOekl7l4DpSVhnLxMaK9RiZT9+VQ8TJiFVi/pELUcozlY6w9Wv44oKpOyo6k3ZeVE94HbL2vxsMKn05L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151975; c=relaxed/simple;
	bh=EIxJZjvraazsTnTddg9DUYD7c+FPA7anhg17pJcX9xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK1X11mxUX8+UuTwKA/vr2qdGy+q8IpxuGeAs4ivqGtpRdOGQvz935PwqZlOmPCk4rXcUYTPNCWj+VgpGjyJ+4KU5+j2S7emCxxB8uBZmr7rLd0V7EvcxjIJIKKvIsIhzuHY23dQQ/caz2ce3mHwt6oi+dC4q3ZK5enbUbYk6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0mGmhixv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eeeYtSsy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 12:39:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717151972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ljb/PRuVoI9v8+9q0idJ375NWa4F+/SiJVGWDOV0AVo=;
	b=0mGmhixvip2sdJ1hz2GrM7HEHPfJftUc86gYttj/r1uqegnAu/XrsgfIUxLhBZ6yIttvQN
	uO1PDRT0h+41lSY/mm+3gvu9LpqkhJbj/F2i2euNH7l+i+LMj/aBn/b59uzlJkVHtC7T+M
	vcmJwMJt7WGI+MASRbKgJHG7Aw6dHLmzjBRNf6MoFP/fZBsuzxZZxvVWq8YSnPOPXq669V
	QyhpxQs8RweTs2UguVnj7ki1TsIRF1qogU9S8V7DD1LiA34Je/9Se+y2geoeu/HrOMpIre
	zh5K74qz4chZz3W1wFHDL71SXD0eERn8Taqy0TM85pIujNPLzs5qrDYFqTS7HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717151972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ljb/PRuVoI9v8+9q0idJ375NWa4F+/SiJVGWDOV0AVo=;
	b=eeeYtSsyBFA9xQpMcXj3lyL86QiX+DSAdJKGIVxWW6rUg/SL7MNnejVniSVpEHg4i4it2t
	a2MUJdppfXg7xACA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Make session kfuncs global
Message-ID: <20240531103931.p4f3YsBZ@linutronix.de>
References: <20240531101550.2768801-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531101550.2768801-1-jolsa@kernel.org>

On 2024-05-31 12:15:50 [+0200], Jiri Olsa wrote:
> The bpf_session_cookie is unavailable for !CONFIG_FPROBE as reported
> by Sebastian [1].
> 
> Instead of adding more ifdefs, making the session kfuncs globally
> available as suggested by Alexei. It's still allowed only for
> session programs, but it won't fail the build.

but this relies on CONFIG_UPROBE_EVENTS=y
What about CONFIG_UPROBE_EVENTS=n?

Sebastian

