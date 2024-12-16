Return-Path: <bpf+bounces-47050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FFD9F378C
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685BA7A8305
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75572206299;
	Mon, 16 Dec 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUB5ADDX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B381ACA;
	Mon, 16 Dec 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370016; cv=none; b=qt0+AKut8oRvzJrjlZt5fqVM4wP6OY0fM9Sf6d8Z1FSawhO8Ga4ZnCxfw2+c8TAx3ZN3TptP9XDaqfLw487Fj/4ugIhk97nml1fAVp4J80Vknr3RDxAZKhkAFU5wtwtZzNzFSlD2ycYDX6xA1r3wxJpJ3zbqn9M3naQsuqbsPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370016; c=relaxed/simple;
	bh=/t1NRYv4/Q5pN1JG7idM3iLXiuadUz5zwHnKIJiHGNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GamhLwvS1KKfuRe68YaulXARoReucVnOORd2FNgSJeJ8lf7CS+UmCwdaWkhH5KY26SxTmHYAB+/h+k/avb6p8YpmynGJmIVd6QwFZ5MGu3UI2kMFmHmGRZk2wDBIXJh+xZn3kDTcNq4IMyMYrqvavlpcFdR/FPlQbRgxvqtphq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUB5ADDX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436203f1203so3782405e9.2;
        Mon, 16 Dec 2024 09:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734370013; x=1734974813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws62IqXxwOmIXvue6QqDBdu01bZQNbrgvdYcyFWCQ+g=;
        b=KUB5ADDXZH/M5py/ZL53ZgqaeU4U1trfICITuqIw0j+TNNt586cSB3+Sl7/cdV2zDt
         iy8tC2eXjgSjiwC+E12JldkFeLUg2zT5qjEtzXMUsH9bS086gWGXqRng/bEHA/UkXa1I
         KZMWpNibw3gv3hL4mZXurdoLEa7ocW2qCxOxEi7EJ8SaBlJPORJn0voDt9eyiwmiQeHK
         SGoo671aKqlNT/Nhf19PDGW8H4vUoT8EpRtlbb4FGyih/I2VyKLVWEgM2dEJTip0C9QR
         SVZR6/ly9hn5nTqaQZnfsbkt30he667HHxfLALKxmZZtyKP4ij9kyCGKQnTDGfqVCtsl
         eIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370013; x=1734974813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws62IqXxwOmIXvue6QqDBdu01bZQNbrgvdYcyFWCQ+g=;
        b=EqbZCGkVKhputa3JsxSdBCwqSRxozQTtDsyL3ztOXaW0c9pbpGFFHgU6M7eWCFFxSD
         JV+b694tjbF0IUpKrSWfbtLjFYhjsyfEicJ7CYdczuwEkn9fDa6AtsiD4TffEFWJsFmt
         Q0+lQN65PkokDlarBudG6f9A0CITl5J9+1pb7L5RIsuvuxWN9bfsMCsskyjSIlzfQgY1
         QjQ2FZVq/8C2+fn4XIDj0ToJGO6e48yU1cKf2apeKsx544q4E3EfUDizHEK1+R1UZB/U
         r1q6ytMoOI/9tFYQUiwlT81hMNj5g+GBE1hbzMBIm3b/Lal+owYk+AzGTqCbDlUsZiah
         QUdA==
X-Forwarded-Encrypted: i=1; AJvYcCVFGjTEWrLsAQIWCVKaAXmp2YAs36WyjvAmBYIIvkTiZdCz08GJDa6c0ElDcNeapxhNAX8=@vger.kernel.org, AJvYcCWD6D3vhRGqwcSDCes82pR+bRf+9+iJJXsmylVLR72GC4YKl4YZyoL9RtrFt76pi2X8TSZc6+Xm@vger.kernel.org, AJvYcCXlnP58leo1oSCBEC/1fA7dTvN2oDgKwRR8e2Z+UX/Hq3WQcB+6DcaMjTw64f6YeYBWkNvzxS0pNISsdj7Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzfM7T42+1dMIaBSy5/c5w+dQ1Y8FKsS7ii5OoK92iqZ8NAsGiI
	CSIag8Y2TPBX6WMXj+4qc+W3dTpm0zYDA80Nk2HmIYJ7FwjBe+5W
X-Gm-Gg: ASbGncvNh74mEYIB9AZJzdpTrjJaHagTpH3tw6EbRzto7H8Rr1ApJ3/ByaVKKB0gv+w
	7X3v+vC5cHtlyg4gq0TYrgzY2iTAsK3+MyI6CGwtL6C184MpEEWbMfoG2P1ehKzvr6xkQGtn4wG
	1SNbVwsObAOItPDkECypsj/m/2UfWZmUum6NhyAi0Fvn/4fdOw/iLRScWLOcdd1vaiw68nzrekt
	+HKdu3OfwZKB5hXOY0C+7erdlh/SG0WPRWt/0V/5ljw
X-Google-Smtp-Source: AGHT+IHJMEc5NsNfUNm/SdMJ561r1AUdBtJzRijqI4fw/BK5BRf5cPDJKOpc00nhQoFK0zD4hEpV4Q==
X-Received: by 2002:a05:600c:1c14:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-4362aaa97e7mr44822235e9.6.1734370012348;
        Mon, 16 Dec 2024 09:26:52 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801a487sm8902263f8f.45.2024.12.16.09.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:26:51 -0800 (PST)
Date: Mon, 16 Dec 2024 19:26:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 4/9] igc: Add support for receiving frames with
 all zeroes address
Message-ID: <20241216172648.q3fxwaxdkvtjqrfn@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-5-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-5-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216064720.931522-5-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-5-faizal.abdul.rahim@linux.intel.com>

On Mon, Dec 16, 2024 at 01:47:15AM -0500, Faizal Rahim wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> The frame preemption verification (as defined by IEEE 802.3-2018
> Section 99.4.3) handshake is done by the driver, the default
> configuration of the driver is to only receive frames with the driver
> address.
> 
> So, in preparation for that add a second address to the list of
> acceptable addresses.
> 
> Because the frame preemption "verify_enable" toggle only affects the
> transmission of verification frames, this needs to always be enabled.
> As that address is invalid, the impact in practical scenarios should
> be minimal. But still a bummer that we have to do this.

Stuff that happened since this patch was written: "ethtool --set-mm
pmac-enabled on" exists. You don't have to accept verification frames if
the pMAC is disabled. You can enable the reception of 00:00:00:00:00:00
using that, and keep it off by default.

