Return-Path: <bpf+bounces-63070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A7B022B2
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856A4A45EE6
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07722F1FEF;
	Fri, 11 Jul 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8JZ6VU4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBABA2F1997;
	Fri, 11 Jul 2025 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255487; cv=none; b=qRgIeQW0Hszc5J8N86VU3tRJo9rAobT940SA1dT8wwfe+BJDHbFmBDovfsWKog1tnNqG+TtS0hIhd8gnoF7z8PkDuUUfLs2qoPSojfbAC2GIG6qTrQ3BTwKEZAdxdYw+vu0eDKoV/nJ2Q08GuPFzKYxZ6/CVjXXz2di43iP4vic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255487; c=relaxed/simple;
	bh=VUH6NlLAyCfyhZB52sXzXQruzhIssmN6iMcI+FM7aQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ricgvKgWohfgoylIfNz1QJYoNBKivDl3+poSYxsapgHSYTpnMeq2UK3AHwRl9tWKZYI2oyDJD/bghHGWUNHNlRYNDDG+tr4z0lDxBQfUAcxPSGV37meKm4bmnSufK4eC796Zjt8dK6Ls5OOrAk3qdZqZfgZwFnRENhFpe+5zhgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8JZ6VU4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-749068b9b63so1687924b3a.0;
        Fri, 11 Jul 2025 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752255485; x=1752860285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcp1q3eJtn4RvXXFfNrI5IhZ5HGzP24EtfNVHh3pe30=;
        b=i8JZ6VU4IWJ6yshwGEcKRPVfl9znRyBezDSBZ688IZXrmzWNA6uCTpjsZzGtb8WSk2
         TlKepAxTRbe/YCVpG8gND2Z7rVI47ZS+oF9Kt2qSoE8kX5EkdWnWFZJ5bzXYKIkYop1L
         msPL0A37tBOmhTYczwk6RBc4xDc1PTpdbQI88ow3/WMeYYdUeoWMK21rO/Ba3kRziF8b
         QjbpODM6CZRU3P7MNI/WKg2winw0LS6BkfXcLnUuO6+qcQsv5u1O1x/4gGcdI0jPqqat
         oIn07hMR7RjL6kyKdVlBj4wB0yk0nHwN8JGS6rQ2znk/MgNKrZx10bY4JNoKSFfFTVqS
         XmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255485; x=1752860285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcp1q3eJtn4RvXXFfNrI5IhZ5HGzP24EtfNVHh3pe30=;
        b=R7kme073BJnqUcueQRq5l8vvTYXWzab4Pf9tiGflHdRB3JHW0WuPofmP6JKaQt0b0N
         W5+XkKvs7jVvaUwznILcY9PAUoh3IMx5mtx5HJ/I+se6RtCixP5v1xNg+T4F2D2imisb
         N8yHjbm84y03tdCR5rTF0IqIoLDqzefdZYG6Y5iu5Hsyf9FfHm2aZ6X6l5UdWD8ecuwM
         QnSS9dwO3vJKQWeZbc9fGSr+UmdAbSST8nmGsb9E0Dq8mR/YqpJDbyN7prnPuS/ftuCl
         UHJ9vsuhAMfRKmlVJ7GLeQGVY50cPhfaLTa4EiKvfhUgXLWVXS+7XhDos0reBELTZIak
         M4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUnviGrBIr2jv2HV7kY8fSSAT5Gqy0q1GhOEUn1N1xQOlHLNrwhCsVcOBtcgd+ElXr+GQo=@vger.kernel.org, AJvYcCVy3tNqdQjBra2olkVEXywNZ/ook8pbjk5NlumrebRqnBw3E5Ctw+eNr6fRyw3L0gAEPVoofhkU7r4vg2P6@vger.kernel.org, AJvYcCWENXmtjkXGqWIc2mmSLol5GJpu906kJ4EO1V3rk6OBITfSuJvUkNytYX/zEW9/nQuywL60mivU8RpEf0x461VqXWKQ@vger.kernel.org, AJvYcCWUItiDGJrLxOnIrqRpGgAS+NuVg+oDRtVCIWBPD5tqdLmOwxOYfndrZhDk7Y3qYtM9hPJIg8UGgRoL2S/qMO43@vger.kernel.org, AJvYcCX/utiRvVXxhUDEBbtfr9uEyny6H8XlIuyJ8qxVuG280aRKRCjoMlLi6iyxVZMtFR88C4UmeJJr@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAs4KvD5dHST8S0Qaw4aAMMu01N4d5dk5pRoM8MTFubdx/k6d
	5HYuZfCcKMqqcFO5etx0RmcWaJmU/hqBUthEw+lAYleX4WkeY6ILneTu
X-Gm-Gg: ASbGnctAFkeLVxogtfxnXqLSaf0/SQcCoZWWjbmuOKEtS76bmX+geRkdhyTPByTaaeV
	LXVoCjKcUKLbnnWpFPlbzcp6AlbyjO+PFjs6dPYFyd1qx5IhAQTkNbKo3h8yCmWcLolDoA0Ghoh
	mt8ua1sQG+O6QPpNQUtlm0nq+d5gkY6RvRfsgW6J8s8m6cgwhG/8jtAy0/3VmA3ZjDGDn4LsO/G
	8PBjl8H7ejoJlGBJcDuQ0pDlTvm/cEiKi8RgBVRdRnJ9pMc1wGxfmr1JuViTsoPIQeMSyoy1nlS
	uLz//QG8XsnK2AjP6fiLl8qZo4ESB9CIHgQc0E7Erhg8viGuldJgp3bJ8wiDnvf0llsSfGMZ30Z
	+4B0Uq2V454ZhGoGRK902QhE=
X-Google-Smtp-Source: AGHT+IGJbwFQH56VXL0M9um3HUdIb4haabnjbvaowHGGvlG+5zNyV1YZ+Wpapkx9WznqUu292jb7ww==
X-Received: by 2002:a17:90b:4c0d:b0:315:af43:12ee with SMTP id 98e67ed59e1d1-31c50e1763cmr3739058a91.16.1752255485099;
        Fri, 11 Jul 2025 10:38:05 -0700 (PDT)
Received: from gmail.com ([98.97.39.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb62056sm5764526a91.38.2025.07.11.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:38:04 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:37:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net, razor@blackwall.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, horms@kernel.org,
	willemb@google.com, jakub@cloudflare.com, pablo@netfilter.org,
	kadlec@netfilter.org, hawk@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Remove location field in tcx_link
Message-ID: <20250711173748.ojinljlncddm2c43@gmail.com>
References: <20250710032038.888700-1-chen.dylane@linux.dev>
 <20250710032038.888700-5-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710032038.888700-5-chen.dylane@linux.dev>

On 2025-07-10 11:20:35, Tao Chen wrote:
> Use attach_type in bpf_link to replace the location filed, and
> remove location field in tcx_link.
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

