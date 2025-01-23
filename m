Return-Path: <bpf+bounces-49605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5CA1AAB6
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2178E3A3C0F
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563F1ADC7D;
	Thu, 23 Jan 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWL4TMq0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8CF1B6CEA
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661897; cv=none; b=HwKDAMjSkRA4mO1uytm+2lVNYFnTiuUKlYpjJ4Axz5iPNvGRDQ8iZpmxmzAyzI+kZvI+WIzVg/ZPD+L8M5b1eXcxXg6G2x84uk0OsYO+XenIwj73n2eoOgMLAEQsGA9BXA1N2hHl2I3Peia0B2Cq6AhS5mQggD1/+JBtZOrNEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661897; c=relaxed/simple;
	bh=n/Rm/uwFmX9rXvWWg19RWGzvrw/hud9/H35We4C3i0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjWmjHd6tKmxm/ExXSLTf40mtovEMwEsf0CbL/A78i2d4j+tehYQOvfauEdKbh5B+6QNwPfn3m7EnNeRlIT3X2P4dAyWtLmrzSuAuMtu7t5aNtXSuldjIQMpsR1E0y4Y8S0DcgJWeNPO38mbQ4DUG9r0uQLurEmWyGTT26MTDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWL4TMq0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso23173085ad.3
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661894; x=1738266694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuoOYlQ8EyfVZfwQwvYBLrh9EM3gB8+fMt9KB/dbQcE=;
        b=mWL4TMq0asYKy1hMCggA95UxH0sthmgE2wIQ6gbaG7ehHE1OL5X+DcQvQXHm5r2h+I
         sW5BLq6nKBpSS2XutlrWOf3E6nX0/mM5R2/3lIIgCOykdWuJuIp+AE1NBHjiuryN8aEe
         pCl57BVawt3BJikRraMa1BwCvznO8LdevA0BwILbmfDughAaZYXmCJl2Gn5arTEQrTQL
         vMk73X3AaVRfrtJfKdyhoaV0/steTPh/BA8Oz2D8EWsGKles2yxpoFQSFPY0iVsSFoLt
         JoUB3K/DuUmKfkontpOg+eSuWV9o1P53IIEr2IAlQTMF6pGBaNwSKRc2WdmH89Naeu1G
         rPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661894; x=1738266694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuoOYlQ8EyfVZfwQwvYBLrh9EM3gB8+fMt9KB/dbQcE=;
        b=inFy/8TORP099O+X7wYM7CXx+S6DRgBNonxlXY/0wGLmNdetk1WqYedatOS6zZQ2aa
         IyVcb0HvkiCbEnGzxAUczLsVlA5rgU5TtGIPCXQv0YVI3UA58NzihH9ZUk0J0C4IkbB2
         96Kx77G6521kiDKtrgCkGcxRx17Xc+txoSfzvgyClidU9mEhjWDEDMlPGaHsvuqdIEG0
         HjoZWhPCdBn64mHgOo1HbXXYxzHughlVS0Xm5l7yhyVi1fMgoA6o2mc9QxoIUyz8378F
         8QtIkVI5gfxqFghTDqtnuB48wknuNM2jI4wfPCz/EOpgZ1cnmz2WVcs5a7CriGRPzeq1
         H2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXmbSsVcgGbskfb+6L2XCyKy5NDwzX6JE0X7dEsb2OZRWFjHeEbPQgIBdaGOM/iBCKyS1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZ/UQLWsv+HRdrj5QuBXV9EnsyLAW8xQAMb2+jKcIi9qbKTDv
	fL1M39QLmBj/jyCH6wQ7LibxRtog2mhRE33uz9h1eSoD5eqoNlc=
X-Gm-Gg: ASbGncsI6f8rTPa1wcgUaghNID+2WyW+i2pnumSBEtbtD7wmIzL28WafpjiSgHSW+2X
	ULKTlPkYPjhqKrqD5V44n5Dsqybq2BNdL1n4BzrldPLPozcVzXSwtoyJu5dkHygzxSYaghoZGXE
	09GpKRvVeWkkHNfuVawTAyaihtVbgAIImJO6G/aGMB2u9i7Mmjq1iwYcBHe8p65Xi4loD811Z5W
	nQNZ4dP8MTWiim14ieliPgMglwDyTw3P26VilZi38Oep3c8OCk7eYO+ZW03+S58Sv4SAbASoOj6
	Z3V/
X-Google-Smtp-Source: AGHT+IEbWx+H6cptmJrMPMe/RQXfLsTeN22GpAC3n4IwLmEZQ6eCieUZ7148QQxkfNxd7iLWcPOugA==
X-Received: by 2002:a05:6a21:78a5:b0:1e1:adfe:c43 with SMTP id adf61e73a8af0-1eb214613bbmr39964887637.9.1737661894510;
        Thu, 23 Jan 2025 11:51:34 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69eb69sm345083b3a.13.2025.01.23.11.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:51:34 -0800 (PST)
Date: Thu, 23 Jan 2025 11:51:33 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org
Subject: Re: RX metadata kfuncs cause kernel panic with XDP generic mode
Message-ID: <Z5KdxTHVFSJSw5FQ@mini-arch>
References: <dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de>
 <87msfhqydl.fsf@toke.dk>
 <74f949dc-7921-4f06-88e1-5b3686839b65@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74f949dc-7921-4f06-88e1-5b3686839b65@hetzner-cloud.de>

On 01/23, Marcus Wichelmann wrote:
> 
> Am 23.01.25 um 17:38 schrieb Toke Høiland-Jørgensen:
> > Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
> > 
> > > There is probably a check missing somewhere that prevents the use of
> > > these kfuncs in the scope of do_xdp_generic?
> > 
> > Heh, yeah, we should definitely block device-bound programs from being
> > attached in generic mode. Something like the below, I guess. Care to
> > test that out?
> > 
> > -Toke
> > 
> Ah, thanks for the quick patch. ;)
> 
> I have tested your patch with the 6.12 branch I'm currently working with and this does the job.
> 
>   # bpftool prog load crash.o /sys/fs/bpf/crash xdpmeta_dev mlx5-conx5-1
>   # bpftool net attach xdpgeneric pinned /sys/fs/bpf/crash dev mlx5-conx5-1
>   libbpf: Kernel error message: Can't attach device-bound programs in generic mode
>   Error: interface xdpgeneric attach failed: Invalid argument
> 
> The do_xdp_generic is also used by the tun driver as a fallback in some cases, so, to my understanding,
> even programs attached in driver-mode may take the generic XDP path. How can this be handled there?

[..]

> Currently, it's not an issue, because the tun driver does not implement the xdp_metadata_ops yet, but
> it may become one in the future.

We can solve it if/when we add metadata_ops to the tun driver, right?
Not sure we need any immediate action right now.

