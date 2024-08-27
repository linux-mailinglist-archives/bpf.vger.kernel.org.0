Return-Path: <bpf+bounces-38164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F48B960CB1
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953821C20CBC
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE171C3F32;
	Tue, 27 Aug 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2JiwG4a"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193C1A0721
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766955; cv=none; b=JMsGqz5XixpVDDWdApxCAqBFyHDOvPCNi+HzMy9OSdOT/K+hFd5F1RP8pJrdKc5B/ViRF8/yfQZ/cSzIW/Ke5zEr+gWLiTWjcB1gUWD/TuPDHbSm0fR1LKW226Myhu5xS4szu0Z6nkW3rNHM7nm1NK0vf29JtjzfRybhEUSrSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766955; c=relaxed/simple;
	bh=KCnPT2SDfFiZ0z4onLZh2+hje5aZ/T2i7RVeM82gfMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLFeYNb7E7UpLh3CrfSX1R8pu5Y4EJf5Yc8SA4mAIfTXP/fYYUyE6N+e/aib6P7oWtxv7+61J/lSkqCf4d6lJajTG6bxEa05tb5ve78lEtylgsY7uUZwm1ZA/ql5PGL60LdtW+ocbBxNfTwoq+RMFAOqXAz93+SYQVvlr9+UPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2JiwG4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724766953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCnPT2SDfFiZ0z4onLZh2+hje5aZ/T2i7RVeM82gfMY=;
	b=H2JiwG4aQnQLzNhpWsI4foHyMr43cknSkoBmgoJyfIGXijOVXeDjmSU8g8Z55e0CQjPGm5
	FGeZvBhWM39SqQYNMCWERX99WtuJttySRXg4Qqj7Yvp8OL7AOT9us1E3uyElqlJqBFWU8G
	3mRe7a/qi0FVD6hlRpZ0yfG3Kjf5x7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-474y_RQBO5yA4z1Y-f6OVw-1; Tue, 27 Aug 2024 09:55:51 -0400
X-MC-Unique: 474y_RQBO5yA4z1Y-f6OVw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-429e937ed39so51909775e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 06:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766950; x=1725371750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCnPT2SDfFiZ0z4onLZh2+hje5aZ/T2i7RVeM82gfMY=;
        b=PBab4QJCgvz/TH78/s8dk2MVK0c6+FU2hOFGqNxRU+29Dnc3/3Y+cMxZ/joN1kR0o/
         wbbdS2jWUBKpgCWjj3r37sZXaWtEg6QQykficKwAQLYpdVKJWFQ0aDeO37+9xuZK7AKq
         NEMZX/bA6XTBOZQq/KLJgKQuhu9cdRrjOIlWbOlvzhXUeySIeUeOTDWFSKFIB4pEsylg
         a+5UZMNrJfTMbYvBSX6G9uNJylaV3lJDmw2VcSkUrh5L6y5WVC8bMguBJmLDAIa+4rsP
         feU6CPawXJe9q/Jo56HrRPcos6GZ31NXlWbODSdeXjkiCjYQOEatxUjywt88txUbMJZ3
         rJsg==
X-Forwarded-Encrypted: i=1; AJvYcCUgl5YcistJrO7no5aylqgCmZiY0+FmWsSDChukynejHhBfy/EpzMpq6LSgG3OHH+jlMwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnSY3tkHIGy/YdY+gpRMYehM5axkjn5ybEpk4CpalpfYvpxTu
	CSMKrixiv+SQf5vmS+8/i3Uiqe3127zMS+sci9+M4eFrjcdiRCbiaN76/ez1X4I+U/5cF1t2wCs
	QvpSSlGbnX1Qvtzle65630yINTHgKNhL12py/nW5zW14n/iOjiQ==
X-Received: by 2002:a05:600c:3d8e:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42b9adaa3d6mr21710935e9.5.1724766949823;
        Tue, 27 Aug 2024 06:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSAlYi7wUp9WGZSlYdHo2N7jKv0stogLqm3BN4R+RSTMfBAeOmqXMLDiKXD/L9wpodIFaT/g==
X-Received: by 2002:a05:600c:3d8e:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42b9adaa3d6mr21710645e9.5.1724766949163;
        Tue, 27 Aug 2024 06:55:49 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm185624515e9.24.2024.08.27.06.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:55:48 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:55:46 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] ipv4: Unmask upper DSCP bits in
 RTM_GETROUTE output route lookup
Message-ID: <Zs3a4rBpWrfeP7Tc@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-2-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:02PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when looking up an output route via the
> RTM_GETROUTE netlink message so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


