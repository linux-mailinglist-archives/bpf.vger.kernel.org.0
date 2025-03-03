Return-Path: <bpf+bounces-53035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C6A4BBC7
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F757A52FC
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C211F30A9;
	Mon,  3 Mar 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA7/PVBT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4E1F237D;
	Mon,  3 Mar 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996903; cv=none; b=sVCS8umDym94aHfVDXScZzS1MrLwZhSkiFVbGNT4but6AoqVDF88cGBAHYc9VW11PoIIpUQkkD7Mdv3o2H3NL02U7R0OzWBDhaSiFXZCZpx7Loxqywcb0sAQMCSC7tJf7SJlyYlmWe7giJ1okf29OOx/q+dxzbT/gbjiJ+gG+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996903; c=relaxed/simple;
	bh=X46IDPT5bSizjOglkihdx7CBx3PDon7yUUnAarb4YYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEEJhhA87Rm+QGY7iRJQdKoCy1i1lvj/epHUGo/uFOO+hnYHJGMF2GcMczh+4slE5IG8XePP8i4hbBqAIe46GYNClsiB5+lSHfzj1/U30DlD9pYNzRLm5MRTrQFEEzTAEtHWopf2SjLO3QYri/cKxUyJ97JxCLrEX7SaflZYmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA7/PVBT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390ddf037ffso2134323f8f.2;
        Mon, 03 Mar 2025 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740996900; x=1741601700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tol5LoF5YKxi3DYyeCcA+EZdRUNMW2s7Mp90wPpPTm4=;
        b=IA7/PVBTA/OQSovCTfW+yqAerlpifuz2JpBU01HV/htsYVO+CEi2HyiwH/nOLHoD94
         DL+/J0eg3St9uQjTd0HjuqMC4wXd5AXNwY/2jBsiqi9TZ44ofOrr1ILtFK7eULru0j/w
         KKmTUdXj0XQQeRtyIwGNESStY8JooLX2czeKnSzMAC91oLQleQa8AHIT/eEqnAqX2hf6
         /ojha8giytPuu6sBGesJMulkgux4OXhadReC0/y701qngF/RVgKgRsHPs04/9J+/Nj6Q
         ogrssp5rgDbfHpL3xkfNxLlaVMY8qfRgSzSYxliXWNxxZZMdmN7biPr9YWpkEq0+gdrw
         Zv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996900; x=1741601700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tol5LoF5YKxi3DYyeCcA+EZdRUNMW2s7Mp90wPpPTm4=;
        b=T8oZ/GxzmFUS0zPu49i5ZYR4HFXOHCbL0q+sC3TMU7rd+EsBEGS1Mo1TR4MRDwkV9j
         HH1sNwKzDJj2sXdKLUhookXV7OnlVz8LL2jbVP9HRUNech5yA8BP42p6RAsclgRrwKpC
         QMZ+1qGEhjb5BKH6pX47FLMqO9ghvYFEOZU3AgiCVdomouwFdJxCDB7V2sfT8n8db/wY
         sJ5IN4YNfR6Ym3V3rv2zpLuhBbxtJc804Nf6sfFgneMmocPhu71rOabyuz+WaGqGLhE3
         orohHj/F1gfRRSclr7IICQZnvu+43O/jWedh+6lH6aTiywBgEnl36opDJTVUzo7TUEAh
         XJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVauk82RCeEDvJlswumSLk9WfQFCaxuz98J+0yqAWuXemfzVSv7gIhXpcWBH8xdEPFWWWg=@vger.kernel.org, AJvYcCVyUUSgGorplHJkmBfIv13tehPmufT20zJawo7cpeyRi0l9dsqHnukpLyJu/mGGxmrQJcjMVinz@vger.kernel.org
X-Gm-Message-State: AOJu0YyJB88ut6RUVkPJtev5A/WJ4EeEBy5+3Z7JaBsu2sA5fOrhZFa5
	nFX4+yCM4HNUQ2YrlQQcnYbrtY1NBUuejiuyHgdMDxerq0qlQ2mT
X-Gm-Gg: ASbGncsr/teIz2jQV6kfp1TL8KWWbBdYrvoEL6c9Q0HCq0o5rSB65tP2nwLkZALDAUI
	wm2xt1oxzdChRt6jxAODOHIgOTLlXeCQA5XVtCBCSP0POI6M6cG+NJ4J2wyYQVOa8sIG6ZS8udH
	Y3FGRBWikcFCDVgcEM7vqemWdSEKv8TK84YR4dMWjRE82g6KiMFTEnJLA7a5mVauqiYi93H4MIa
	GBsGDH/BG+M9sMfMXhaLDhN8plkym9iIHe3EUQUwnOumvFVspYp9425Y1Aj2se4gNf/0m9ec7GR
	67L29eWZAc0/t1nCgR1hBMw5UyoGePe0hmJTHkO1MqtaX/iIR2h087jChczqVvt1HnlVbr76UmN
	1eL6+gfQ=
X-Google-Smtp-Source: AGHT+IEwKfHIQwZGCKj/Q1qIH2G5QePVeGE+TFbByCIPzRFZ4PfkipJn3haaixhk/jO2Uen1J1Ydhw==
X-Received: by 2002:a05:6000:1ac6:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3910ffc2673mr1264869f8f.40.1740996900107;
        Mon, 03 Mar 2025 02:15:00 -0800 (PST)
Received: from MTARDY-M-GJC6 (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844abbsm13870804f8f.70.2025.03.03.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:14:59 -0800 (PST)
Date: Mon, 3 Mar 2025 11:14:57 +0100
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
	andrii@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to tracing
 programs
Message-ID: <Z8WBIR72Zu5x50N9@MTARDY-M-GJC6>
References: <20250227182830.90863-1-mahe.tardy@gmail.com>
 <96dbd7df-1fa7-4caa-a52c-372d696e0f38@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96dbd7df-1fa7-4caa-a52c-372d696e0f38@linux.dev>

On Thu, Feb 27, 2025 at 12:32:43PM -0800, Martin KaFai Lau wrote:
> On 2/27/25 10:28 AM, Mahe Tardy wrote:
> > This is needed in the context of Cilium and Tetragon to retrieve netns
> > cookie from hostns when traffic leaves Pod, so that we can correlate
> > skb->sk's netns cookie.
> > 
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> > This is a follow-up of c221d3744ad3 ("bpf: add get_netns_cookie helper
> > to cgroup_skb programs") and eb62f49de7ec ("bpf: add get_netns_cookie
> > helper to tc programs"), adding this helper respectively to cgroup_skb
> > and tcx programs.
> > 
> > I looked up a patch doing a similar thing c5dbb89fc2ac ("bpf: Expose
> > bpf_get_socket_cookie to tracing programs") and there was an item about
> > "sleepable context". It seems it indeed concerns tracing and LSM progs
> > from reading 1e6c62a88215 ("bpf: Introduce sleepable BPF programs"). Is
> > this needed here?
> 
> Regarding sleepable, I think the bpf_get_netns_cookie_sock is only reading,
> should be fine.

Ok thank you.

> The immediate question is whether sock_net(sk) must be non-NULL for tracing.

We discussed this offline with Daniel Borkmann and we think that it
might not be the question. The get_netns_cookie(NULL) call allows us to
compare against get_netns_cookie(sock) to see whether the sock's netns
is equal to the init netns and thus dispatch different logic.

Given we (in Tetragon) historically used tracing programs when no
appropriate network hook was available on older kernels I can foresee
how it can still be useful in such programs.


