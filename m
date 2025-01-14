Return-Path: <bpf+bounces-48757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA235A10489
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738A8169E4D
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362D28EC8E;
	Tue, 14 Jan 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qbk8/KL4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8024022C
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851512; cv=none; b=CCtQG3RT6ImQHxX9zpiKXqxO2ax/9Av9M3OHtQVb2PCBH47tGcCvPXApd315I2c4EzUMrHgMNTGyQ0t3RQ4RWAsvQ0o28EwFJbxDg6KM5RW1UqEajUHDp/tdp8j+NWD8ypPljcBPHzZHZR+TJjCBzc+4QDlUlSMbOoIXHah+qFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851512; c=relaxed/simple;
	bh=JX8BU/UHAINQ03gKNeZE3v64RzFXpUq4unVLUxoDGSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZAgbywiDc/qVBFGW3cbV84PSiqef2RhgQl3FRhXv9DAa9HbK5UJCebas0/cotICqkeY99L0IhlFM6z4ZeuknWqC6lMuMXbC1SKQuNgv5jcBxP8REib5/J/Xka3nt3mRZvMxSetfOgO7EABFZaSom5I5RnIEPSTXFHc0y/nny2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qbk8/KL4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so10272709a12.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736851508; x=1737456308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91oZE8SNrLdkhlSes3IetGvw7SmPXpAR69UBGkhXJZ4=;
        b=Qbk8/KL4SRg/al+lS8lv/WM6SU67elePOE1J+eRi99X1XUPzQHpR75rgG3KSUc9CW1
         hjurkNxuI0gEfFi8muQezyISPXdWLtN29/O5qpiREpNIn3aIN2vcVNzzi264iy0ZkBsB
         Q4SdW70yk27qmFit/zZf3nwwCEwK0gLdxxdR1ki8HgE2L1IpqlbptkljtvCkrXXTnKG2
         zAi9JdNIMWoDG36t/ZKU7q/KvhugeQSjK4iyNj5niEijPRoI0keC2uAPHkUHwNCpJzza
         Rp1hU8ayY8lLZS3bLoljLszd4TwU+xnYD89bkbatjTGTvOtI1NThlGPGa0Bn6yY6j6kY
         QVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736851508; x=1737456308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91oZE8SNrLdkhlSes3IetGvw7SmPXpAR69UBGkhXJZ4=;
        b=M/LTutEiuP+jsl7qGnWSIpbcC2FECI4ceYsfaBrbK2ncqYtTGUf3EDyLm339KZougl
         42ZcJQSrjahiY+8ENzD6uN3k3AVEA5PPOPfY/iHuagjC3srNqIIoJBFnUkX6nCp2Rs7K
         NxUmOqbOLpL1oRyh0lvN8EyaRhzf8fNbQ4fXH5K/Zz66EqGy0jgwamb3JeziUE6EJ9a5
         8ub548WF7P1Ffh+817RzbtC4tUR5gNTsPE31Fwi7v5k+pFMC481YPJc2DcFqedUZxEbx
         sMbZiBfLXQdTIr+vO0mpZbO43ryAWhn47l/KR/adSJVABB2wfPURneeVGXaK4GOFGYlZ
         mc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw1K8jmoMSuluz1HOhqS/Xfx4M4HnFufcCTYgQrdvCFPE9O5VbwzetgQfHZAGB6P6R88E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcqa3ieBPNabMFrZ4s1Iz/S2SrCzWX9NpzNO2bYlxSxILe/c5G
	qmsaVBbP3ss56M6ULJotYyQShe1t+hY5PjKYCpHDhMNpxJDlQt1JbZcmZihx8d0=
X-Gm-Gg: ASbGncspD6ShKwx+SgSqPVeVBQMQqhUDbTj+nJNfzt7LCdKNIP7/qgZEm4uF+7zXbSC
	2kVkyrcKrzYeGxp/RudgjjRA6Yfa3VO0SsO5dKAKXnCnjvWvxjFaAs5smDXcDpqQiqAjlzR43KK
	TMbkmqnWwavvfCKyR5BNf6FBoXz9aSUUUQi4+bVdQ/Acks3hUGqvdqYwqUA9jLdnUPAGWQTq47N
	YoeH1QZqM+CcFbYKHX4VtvDurh2kE6SpkcNmpjXxlr8fW/znOFbaUzqWEAylQ==
X-Google-Smtp-Source: AGHT+IEo3aHs2albkGeyR9BcAkeDWYBoYCWdzhqgjZb2f0VdDSTMfOOHcn07QDxniXBFjvVorqej7g==
X-Received: by 2002:a05:6402:320b:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5d972dfcbcfmr24768732a12.6.1736851508062;
        Tue, 14 Jan 2025 02:45:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a4d49sm5812922a12.78.2025.01.14.02.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:45:07 -0800 (PST)
Date: Tue, 14 Jan 2025 13:45:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
Message-ID: <Z4ZAMCRQW8iiYXAb@stanley.mountain>
References: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
 <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>

[ I tried to send this email yesterday but apparently gmail blocked
  it for security reasons?  So weird. - dan ]

On Mon, Jan 13, 2025 at 01:32:11PM +0100, Alexander Lobakin wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Date: Mon, 13 Jan 2025 09:18:39 +0300
> 
> > The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
> > potentially have an integer wrapping bug on 32bit systems.  Check for
> 
> Not in practice I suppose? Do we need to fix "never" bugs?
> 

No, this is from static analysis.  We don't need to fix never bugs.

This is called from nfp_bpf_ctrl_msg_rx() and nfp_bpf_ctrl_msg_rx_raw()
and I assumed that since pkt_size and data_size come from skb->data on
the rx path then they couldn't be trusted.

Where is the bounds checking?

regards,
dan carpenter


