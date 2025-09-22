Return-Path: <bpf+bounces-69257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B017AB927AE
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6602B2A4CC5
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EAC3168F1;
	Mon, 22 Sep 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXtxJQr3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC23168EA
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563467; cv=none; b=PRPaOrWUXOAPLg87ly0sWWbdNWS5r7Y87lYYjxi/pbrv0A+KWLy55NV4aj4HeuxHc2DEDce67R+nD/XzRQYfHY7o8jDo9JEG7DhH2Kzv45Tk9UuiyOfOsLu3JBkDKcF9cAuKqEjCvxU1BgdrktIhu3IHm9Tj5aSKMtlRjwOS+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563467; c=relaxed/simple;
	bh=c0a6RFSFL244AZExUgaFK/XTq3j9EgV6tyBZrfjl6Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftwlt/SwmyoIqMYqXirBvRqhO7t5cpEXmvhwtkDQhxkql8qFHNMHEkPxsBvoIXqHnctHLSzOkGRSL2HwUM/cmMZeUevEwJTP6d4ohCLhbEcuSurdBJHH/VOMns7iRVfLJPPl+8aUfcw5qcN+9+gGdzm3VYwZmX92NDumhQ4MUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXtxJQr3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f1a79d7e5so2345674b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563465; x=1759168265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Kpp8y4+/qufo5dJZYCrIeeCLKzv+9CNWvBYi7Kz/e8=;
        b=KXtxJQr3DtfVL98Tzr4btcEGluda+xk3qAIu6ot+3TzncFqirkqzOZLjEPznEEc2M8
         2p+JrxZUv6gYubh7SeabOZb9N0AOmG4b/tNeztJ6BtIYNKxGIVY9dLdRn8QAig7Pz8Xu
         vGqkNCuODRSDF9Z27ikN+0tDmLnzyoRJEiQ5ivxd3WgJWzseBX8Hs66Pl+nyefpES0j6
         v0Rz/0VUOa0Hxp4doLXrbLCTEQX0uq4xUI/bEUJnoWWVdZiyOdSOq8wP4uOHEyEFX7x7
         LZ9TwWLzx7a4ThTzrwAedTjhidWny/fJEjgRpBB9JglAgdoJu5DeD11s6lIq4D3oFWFh
         BuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563465; x=1759168265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Kpp8y4+/qufo5dJZYCrIeeCLKzv+9CNWvBYi7Kz/e8=;
        b=ULO7TNXUwludTkUBb4UmlqJ3dNtSNY26Fj3nGnOresSIrPaX7l2/Mh5E3f33jrUvdp
         wvehXdLDKlICyhYr6g8WXZxjTc0wV6BkHqLqO0Wiisf+X3uKYP9+JrLQfnPZ4eXJEizy
         eHkn+ybFR1LSxLtLvi/koYfZ+PNh+3VTmSBD2wbtoEZ9KgH48FgFdMDQOQvMjh7lFhl5
         VZXRv5G76L1CCJCIgYCVMGB1T97sPA2THWnrxIqXPH57G0GhjP+Grb/P94qeMPNmPdlU
         avpEsYM2Z9CgKLZsF2DepAnSEAsdW4ez5q0gSTpgMAdDjANzqFkHuJ13GSEoJQXLXBHA
         If7A==
X-Gm-Message-State: AOJu0Yw1VDGZf0eT9yHEbKqvuMMNXOE1UOAHROs/jx33nTCZumLn6SZn
	Pu+UNL7Dgikgmto5+i0mVyJh8+6XVQXVZiQoO980Jf4klOpOFg37v/c=
X-Gm-Gg: ASbGncvjjlWYz0soKdl8cSUi1t/e2cKeswjUJN1nynF5tfrISwNu9qPeSt7wX0WXJih
	hW8aqAgQpZu5jiA+nzDnckkxjCt7Sa914P2MNB2LrX08C0kXWvMu+o9VzCPMmCWbNwvb3gWvUTK
	+cYI7v2TwAUTlXuChXx06Po5jwzkW6EI5P1h6c1H0+dfQsh4gbwl+zW0LK3RcxBHCmPMizltOpC
	IxqWsvaMj1IZHZ4J+hPmmTK2k20l1kH8XNqZmb/i7JdKUZQAk2ZvpxX8OvB8HgzPbuU6qt9YeIe
	VxweAyFIpBNW4wmcCIWVT9XdpOafAtjQ5OFnBxzvwRT2uYsS0GM9eQiUYvlGA7RcBQGmn71gB9N
	2lbrmcdeFvJNgr/IbGbwXkU6bykuZnYPJwv+0dM7LxV4HrFtTRwvW/gfYJ5SgwpjtGMhJXBsTEV
	ZuViqteGg+Bd7u/6pBKbWTuRKn8d3psCdDdlokVApC/97u3XhZo06JYMK9GADzRfsh2z++Nik68
	OSF
X-Google-Smtp-Source: AGHT+IFpzkffBGVdyl3FepoZ59EN9XZi2pZw2cC261Hr4BtGiCIH//T8bpBiwA3kypUTCERHjE/DDg==
X-Received: by 2002:a05:6a21:99aa:b0:243:f86b:3865 with SMTP id adf61e73a8af0-29270319fc8mr20827440637.36.1758563465349;
        Mon, 22 Sep 2025 10:51:05 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b5516b997b3sm9855293a12.0.2025.09.22.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:51:04 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:51:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH bpf-next 3/3] xsk: wrap generic metadata handling onto
 separate function
Message-ID: <aNGMiNMmNRf1N3e3@mini-arch>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922152600.2455136-4-maciej.fijalkowski@intel.com>

On 09/22, Maciej Fijalkowski wrote:
> xsk_build_skb() has gone wild with its size and one of the things we can
> do about it is to pull out a branch that takes care of metadata handling
> and make it a separate function. Consider this as a good start of
> cleanup.
> 
> No functional changes here.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

