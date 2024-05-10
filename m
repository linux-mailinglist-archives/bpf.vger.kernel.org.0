Return-Path: <bpf+bounces-29490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7D8C297B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9611C22256
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374571CF83;
	Fri, 10 May 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ssdy8x/g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA821B285
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363088; cv=none; b=uqaqPEKWJtEnItwEC6RKAIjETD7D/orNgv4hVAUc3qBq/8Zm1qkM+bXtQmqWtqsjV6aaBQoOr1yk0FuHOpbM68d/poC5ufetQi+0yhnTcqTBKnR+tZ5U9SLAASgEPMfhY+jpsO3WoDImxaCjmiVMM2RVs5HtzzgT3kW3eXT+AGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363088; c=relaxed/simple;
	bh=xJmMGpijLVbfzV1aLbCyIFqmqtVghhRlL3fIAx0Zf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljx7lGrJGVsmTTK/CZpChLDKzINLYblnQXuY92FML43k0iVdXpZoRy9DUHJEB9MTpw661L3TKPH2XMo+PnDPrlDXOCh+7QkeDE0pwpohlU5DJ6J2WANPt7+pq7teBvIqj7wwNWwhg0gqojNAZHCRemXd5/EO59PpHYzoLQCPX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ssdy8x/g; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b27eec1eb1so1876667a91.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715363087; x=1715967887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=Ssdy8x/gu3v6owk4cRKjS558k6DX65Wm05p8vmbUS80yA1nhMtBEJKTlXakydU7iv4
         jz8AfO4nTvtwcQQHM5EqSaU/QOgxMSGVsoDmr4ZGk5pIburKLY11uAn84+0OKXfb5nef
         O8XA4bl+7ytiI5z8A35fyK64yuLYpUa3igqEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363087; x=1715967887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=BaUknd4W+nJ51xbuw4FKNEXgUdQLDsGBHOF9MpLSY/X+owLqOXjbwmTQeTgh4U5vZh
         HPl7kG1sr/Ebxvhl4IuZULJLAz6dNXgVH09G4RpFylzzv0xKVSvn4YZn6OgaL6t8DNQy
         RNl0eKjNYGAHBod7PczE7tlQkU5hVU8a70ZaD+A+ibL/q+L3dAx87K7ADlOagdsQN3oG
         2Napqu8H6quj1LRHtbM3K3mje2pxqqNyQ5OfJh1wugBScGcIcNwwlgmP2kjyMto9YDI6
         H9ejLhjLJEpV/UbQhSppDthSaazL8j+6aPcgKHmktcEBbqfsREz4GdnIG6+oGI0akImO
         y3+A==
X-Forwarded-Encrypted: i=1; AJvYcCVK+rs9EeXxRNJdwm7Y002kkAWSm+BuY4YLQ08ucQOGpsyjhUL4btHiWsO7ME9RdXb3i2F5V/gBmmNhnOLrAQ9TZgu0
X-Gm-Message-State: AOJu0YwzJAXITNz72BEL5OzWSQjnpSOgqTEo6rN/zGJGG/1ftEC0TXTu
	o+AQVw4Yg3vYTlQC+7S4ndKNRlHbzRan5Js76S7fQXw/qHcfFXfKL8d8gIoWig==
X-Google-Smtp-Source: AGHT+IES457OerJ6E+sjpYxMiTqrSeTP8IOKWgMKTpX1LuCp+KnQ+g1iaESf6bNjK6mubIK/EdZwFw==
X-Received: by 2002:a17:90b:46c4:b0:2b1:817d:982b with SMTP id 98e67ed59e1d1-2b6cc777f3cmr3358191a91.14.1715363086792;
        Fri, 10 May 2024 10:44:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53cesm5360572a91.44.2024.05.10.10.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:44:45 -0700 (PDT)
Date: Fri, 10 May 2024 10:44:44 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 13/66] selftests/exec: Drop duplicate -D_GNU_SOURCE
Message-ID: <202405101044.5D2742EC@keescook>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-14-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-14-edliaw@google.com>

On Fri, May 10, 2024 at 12:06:30AM +0000, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

