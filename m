Return-Path: <bpf+bounces-47076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E239F3EDF
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 01:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17F4188A26C
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F671B7F4;
	Tue, 17 Dec 2024 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McPjoLO2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1FEED8;
	Tue, 17 Dec 2024 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395997; cv=none; b=iiwfKJ62Ea6gN3Pp+1yJfAoZhiqEmF4OuIeo/ByVr7vZBvJi50Lj8S3piqwRKvFgdY9iQPtqWD9iIuw56CZ7AfrsPqKgf95LhcGhn3yQ2A55fLPqbBWQZzBlCFkTA1MyOthOKa2ae2fwPunLMKcho9tR80fCLgYE5o9ds3h2y2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395997; c=relaxed/simple;
	bh=A1R9tHLaDf/bgD2B1izePA9NPuQUlRqd+nM4NpGtDMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs50ErxjPDI11JSSqjvFZ54ritTzDzw3jlIODxcnNiy3r27eVML2k0A3eOrnS+SJdewHbgeQq20NxwGWxgwznVu6o1Lkk+5Vtpsr2i3GzysG1S+jotq3G0oVkuWvUuTubb4Hhco6uk/YrrcyE5gN5Si9dxophxLv8bVtjj2L/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McPjoLO2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aab73e995b5so87249766b.0;
        Mon, 16 Dec 2024 16:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734395994; x=1735000794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1R9tHLaDf/bgD2B1izePA9NPuQUlRqd+nM4NpGtDMY=;
        b=McPjoLO2WeXE8mdGSrz1eZtIPsphbiXrYArGLqgZmXU38/3hPJZE7geFy0H2nmRlPb
         Gn/5YQpW4J7g1zAZI3iWPP20u4WaUZsfmGyAeLAhZwUlN+KLIzMt4cskF4LspHDL7aM0
         Z3V7R/RjcSXTO22+fUuTFWQA5kTinAbk0PmmYuVOjEqUuYP/MFfPqcuIsB3lUzgb6Ysm
         IiyWKb4FFGR3CwxsAmqUtv0PbHhSnmhdCkGBb8feCuWaGUfrpSSI8xQ3zf4aJATWKZ4J
         jOTeqEnEi2S0UzzGUsEKQeDSmfK8Vct/hv+J6dkJkAlVGt1dIKXSg6PUMEklWdySMkAK
         P5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734395994; x=1735000794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1R9tHLaDf/bgD2B1izePA9NPuQUlRqd+nM4NpGtDMY=;
        b=OVDGbQPJ0EgNd2ooQMAHCa+7Az5H0HltSRHyuCrhrVq59l9lduBbGp9dhtSVN9K4oM
         JVbCu/YCCfAGJWGL2Wv6KP6YoweeAf+6YHHB00B/tplc06g6+ehv6fTS1nvOVyKcMeAq
         b/QjJ4duAGQe7hnH2JAFSZ7vOVINvHUHqH7tA91/rzdySIS5dhSoIZV9RM5HtWSEaeIs
         Ct8rjnVNgdrLQM0opwdPJV3F9+TT9hoVXyFvxmx4ZlJKKbAHTN+uiMurnJtTa2Pphp19
         0Rj5qGc8+Sj1oalh+pP7JdfIOAUubYKyslOxiXEik82uLUPlnZUlBLPMyPsJIOnZ6vp9
         NZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUtYo8953RjljYElqoVqolHVSLTRM9mF/Kyb7IbNxOKxI8lC5ssp4Cn+Kk2FwQqnuWzgI0LrK+RjcWqT8Pn@vger.kernel.org, AJvYcCVY4E2PI+wBcK1EbcpEqrdPNc/1QpNitPEaqGDPMv7AXxF1stA9XBu8habOW/yM4kzSzIQ=@vger.kernel.org, AJvYcCWE2h1rHADu5PTCurkxTGhCaJ5k74cSUMD73KaKuWqlhPy+eMdmNShuoJ7Qb6fA5MFdUiARR9tf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0N81NRGdTmzzj3EjbYOWVrYidj6K2z8L2BK7LOxX6u4AUGXd3
	6mJ2lZVQKaL+9y8QCqvLCavwDUS5fLezCOG0sFPRJUhetDpI/yoS
X-Gm-Gg: ASbGncs5zPcz5i0Yb+XRy2mYHt821UwoLEPJ4LHt4UcRxHZYjPd7SGafWrVull9Ma1l
	vIKwzzc9JnCQiVgH51kFPE85cPMWx1nv8PV0iaHk/oBWr8PKdh+75H2UDZ5w5feYzWJ0QJZOn35
	7SZpjGILQgU1borVCuRjj1Vq2ybnp5fo3ZfjBMFEBNwC0Ms2CQgRBWorV8Qyd9Ph29aXgqDRzIH
	E4TJ3BVmvACYHQilCtYnt7Xmkh4wObDicWRqb6Kt8nn
X-Google-Smtp-Source: AGHT+IFuN0BX5Q/xTjVsoLVygeo+9aUUnyOxTDy1CIyJYlh0HG50/3fOvQWqbis5B4emJSuPT6oBZA==
X-Received: by 2002:a17:907:3e20:b0:a9a:8216:2f4d with SMTP id a640c23a62f3a-aab778dce60mr521221266b.3.1734395993225;
        Mon, 16 Dec 2024 16:39:53 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963911f3sm382677066b.161.2024.12.16.16.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:39:52 -0800 (PST)
Date: Tue, 17 Dec 2024 02:39:48 +0200
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
Subject: Re: [PATCH iwl-next 5/9] igc: Add support to set MAC Merge data via
 ethtool
Message-ID: <20241217003948.ghnfuns3h7qdjrfr@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216181339.zcnnqna2nc73sdgh@skbuf>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216181339.zcnnqna2nc73sdgh@skbuf>

On Mon, Dec 16, 2024 at 08:13:39PM +0200, Vladimir Oltean wrote:
> Maybe the methodology for calculating these is used here?

I wanted to say: "a different methodology is used here?", sorry.

