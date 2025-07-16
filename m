Return-Path: <bpf+bounces-63492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97180B08006
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893A83A9F5B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450F2ECD1E;
	Wed, 16 Jul 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ+YyqD9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC91C5D5A;
	Wed, 16 Jul 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702857; cv=none; b=U9TFw7KH+p9+LRPf2BHajF8XVoJmwXTTcLYMgZgxzLtFt6f0deLHtx8ukeQ59L6bG332tzsRa677MBcTYcIbW/ZyASPcx6nAvQSTL2/QSO1eROvFrUI1Ti0Ee4Hgb/UzggJL2pzK4UsL801CBuRL4phhcgz96V1tERouHSl7x8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702857; c=relaxed/simple;
	bh=VT7C+TbT0SuSF6qYskH+Yc/+8ijqxJTRUH7fUxHR0c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4bZX2BoN7dXJepe1qqJrFXN7DbWKbVkfP0LUXDK/DU39/0r6oxEG/mgPKlvO8AOGexW134CEuHHrHzgm2iEFSvRJKbsSfrcqUWinG1YuoFU2U7eHbYM+Q2an38fnXrjuNU2UF7K5TIrRexzcg0VkQDWbI6A9wkFyRy/kIFU0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ+YyqD9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235a3dd4f0dso1892875ad.0;
        Wed, 16 Jul 2025 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752702854; x=1753307654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHjBO/GvfnhAzBVDxsgsl7bB2fmePvdL7VHBUAaMZzc=;
        b=IZ+YyqD91yPT7GKju193pYRpgThofk2EcRdG4OzOxUdJzfa0TIE5HLpFI9wJaZ4f5m
         SXThIATF1aJfE5NPQCUEL+P53p3ez6rYQWSMca5KoDLthFukPsFeb5xTC2/ab/psFsU/
         UW+e9kO3gJn1jM5lXDqBAuwbMWqvf1w0U+h8pkgYNB/t6AfIibiaVTBxyVZlZQIRk92o
         ViIs24+9kjmxd2hgb7h/gpomEWuf2xPzBRDpn+mwqV4nsfdqNTDQNQx19MAjLO6RIC86
         OoZjeRE63yieZZRZ8wmwLOJYmszvZXkPlSK4kO/kjT6xpOmkYoaevCIEQI/2LySU7n9G
         tXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752702854; x=1753307654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHjBO/GvfnhAzBVDxsgsl7bB2fmePvdL7VHBUAaMZzc=;
        b=a/qt7Jn5+LGt1Popm4A1yr6klSM+fpZMrjChO2iSsQYDE9AL/Dw0K9dl+D/xO9L6sr
         GUkJQQgpxXC4QD2/OEug1ewhJI+ehIq62T9khMsmXFTlWV4EgOQhyZykXeVaVqKnJ3tf
         RKjp7aj5X13fGOPy7tt6tr3HDKFatT9dg6fUa8fJ0q7aQPHaYTP2Lwh9hUE/9QfB4t8v
         yotJIM5+Ysr+wT3hwxdDUuD/l9ZI39hx55Ui0wbTLmQuGi0jIe9t+8nk6i/E68F1uHqt
         L9gSgzIjqP7maP/wlMtJZ/cj3bEqh9FeFiOM9sOYGKR0C3gw11q7doMc1CNmwFJape9j
         UdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9/rxdgfy8AGqjMo7kcEyJu1lKWif7t8iI+4C5ItRxNL9Y1WnSoAr8A0BBrBhhdDtlPs46wBLfngyOA5u@vger.kernel.org, AJvYcCWEGNA8Z9O1P0Dym4HtL8bbXcvqgfg0EMHFvGozzm0c/UhkoYT/37gblTGaefYzgC67bEI=@vger.kernel.org, AJvYcCWlsaC4r8W7b3aW9OpDEC8j6CvvfxR0ccIPtlT6CN6kDb8bPp5nKX62Pka21atduCXYxEP9g35X@vger.kernel.org, AJvYcCXwREe4WHeAL4IcK/FSGzRUfBPoaKmxvBIHsq8BZpwa/AGC7gGktyKzh9FpIKi6I9Olz8lW93fQGI2S@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7VXtq5s4BDKilHhW9rsFOOcsF85y5kJGW68WosK6jH5ii/R0
	gdZ1hZCP+Ifdzu9+ahIhzycAOGDc2MtUb7IRR7/inPdTGJf0M+qbjKs=
X-Gm-Gg: ASbGncssAFMszJktICIw7beDypfqskgo05z6p0IpeIOZHE4RQq2L4N44rKP4ekPU9A5
	6RhMuhtx8tiWyhFbMSEF2+gz3mYPA6GX7oN7WBp73aF4z1jCxRIXb5w/v6ccH1ch4Yde/BjdKqQ
	k4JwIFJZSkaXJTCx/m8nBmLFR1/rXisnQwmw6niV9gsXBxrUtG2XORCxqHbDTaoUjbJFYAiLRsl
	ADR8piM/r/MgFKuLsiDOvr2ALrJ+P0j/tCxxWdTLbhtOTGnyEqhI2Chg8I9J7wMc2AACxhPPESL
	96E2OzxExtPWxNOBZ6ou+18EQyUbyPtBilqpL/YK4sNTcXRX6r4TGs06RfHF48cKPqgAjJ9yv61
	BaZCSP8QF27WpWD+E95srLdahfSxKj3H4MzJrFSBRALv0sjR2y8fzGFqny88=
X-Google-Smtp-Source: AGHT+IE1OSWzcqfoYgFp7hdp+6Jgtk4/KWpl+FiiVduEAHyyC6Qo2e4FZp+2OIflJzC6cAeYBqB1HA==
X-Received: by 2002:a17:902:e807:b0:235:6aa:1675 with SMTP id d9443c01a7336-23e24f94b60mr67229635ad.52.1752702853772;
        Wed, 16 Jul 2025 14:54:13 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de434d5a7sm128947635ad.204.2025.07.16.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 14:54:13 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:54:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next,v5 1/1] doc: xdp: clarify driver implementation
 for XDP Rx metadata
Message-ID: <aHgfhIUvScQ26-zF@mini-arch>
References: <20250716154846.3513575-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716154846.3513575-1-yoong.siang.song@intel.com>

On 07/16, Song Yoong Siang wrote:
> Clarify that drivers must remove device-reserved metadata from the
> data_meta area before passing frames to XDP programs.
> 
> Additionally, expand the explanation of how userspace and BPF programs
> should coordinate the use of METADATA_SIZE, and add a detailed diagram
> to illustrate pointer adjustments and metadata layout.
> 
> Also describe the requirements and constraints enforced by
> bpf_xdp_adjust_meta().
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
> V5:
>   - create a new section called 'Driver implementation' (Stanislav)
>   - reword 'utilize the data_meta area' to 'prepend metadata to received packets' (Jakub)

Thanks!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

