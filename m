Return-Path: <bpf+bounces-17646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D98108E8
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 05:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E2BB20B9E
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 04:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82900BE48;
	Wed, 13 Dec 2023 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBHS0mso"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE786BC
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 20:00:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so4643334b3a.1
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 20:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702440020; x=1703044820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Akrc7Si6HdSDRSpfY86kThETWtYCkvAOOd6NMxnSBn8=;
        b=UBHS0msowVMp8QV+FAA7Cinw3QvKCmgHfbEWYVNUVUuJJanowN1MUhCHbsjbUDzdjc
         8MAo7ybWryUACakY9D6Ao/xVCJ21Ixb6BJ9S4vpFFJXq7E/Lgms/CklgPnpSFOLg9+mU
         hJh1lEBQLhGcv9LIpy8nUH8f7T9RjPGq1FZNkbYrT2uNN7Igz1OrO26mmjrsEH7E8Dio
         gYg4j6ly2VudFORvZFOyHP5c3Qq2qDKWdZ89iC+dctddUwiJtEm6AzpXvcjPcJWgxZEj
         TFcvPRFHrPl8UMbzYm1HGtQNyCx4DhCFj8O14R5DicAG6Y6gav004pWBPPBiyT/ZOAYi
         OO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702440020; x=1703044820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akrc7Si6HdSDRSpfY86kThETWtYCkvAOOd6NMxnSBn8=;
        b=cp5yNhKxWprHLuaw49A9kRT1CZOQGPa4rSN5TUXHMD9yXqPBlySmQOuj9OabfaRn7N
         i2jKkLEeCWQw1sHJ48W5fohc1OdpfoUoGBvXQWNV3sVc3cukIPQCbDugAgmOWbvQdmo6
         iBQTrMm8q4O1EUl18l2oh7mYP+cIoTHB0r6fuwiTVL0zdfkswkWOfBAoT1+artcLR2Hm
         16TypaGWAQ18zOHbbC3ACbuVRZF8a2Z9iWFK5KHMNl13C7hPBWXUsKL3C5fa9/H3SDCx
         g7lPnz9c+f0xQbFWN7Dyu53K1TX1lFa3Lz9J2RoDnKdEjnmptEg9o6oyGNehRRw2PdK9
         vJQw==
X-Gm-Message-State: AOJu0Yy5h6IsMzYIevFTAQNsDAPXEUH8YAwU8cujnhuedwco5cB0/wk8
	1kylUrCtzTWO9J6GjgpPOZA=
X-Google-Smtp-Source: AGHT+IGq4kKKNGMpOxFlASpzU0UngYNVOFWXlF/lO6di799ci90HENghXCtq6X/Lfy+kK4NCReWTng==
X-Received: by 2002:a05:6a20:f39c:b0:18f:97c:3853 with SMTP id qr28-20020a056a20f39c00b0018f097c3853mr7887894pzb.45.1702440020061;
        Tue, 12 Dec 2023 20:00:20 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:fd0f])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b006cbb65edcbfsm9173185pfl.12.2023.12.12.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 20:00:19 -0800 (PST)
Date: Tue, 12 Dec 2023 20:00:16 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/8] libbpf: wire up token_fd into feature
 probing logic
Message-ID: <ta3mccaaphwf3ax73lf6x22gu5xymt2mmhmardhj5wh34m55ce@gqdbmfhzexpg>
References: <20231212182547.1873811-1-andrii@kernel.org>
 <20231212182547.1873811-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212182547.1873811-6-andrii@kernel.org>

On Tue, Dec 12, 2023 at 10:25:44AM -0800, Andrii Nakryiko wrote:
>  
> -enum kern_feature_result {
> -	FEAT_UNKNOWN = 0,
> -	FEAT_SUPPORTED = 1,
> -	FEAT_MISSING = 2,
> -};
> -
> -typedef int (*feature_probe_fn)(void);
> -
> -struct kern_feature_cache {
> -	enum kern_feature_result res[__FEAT_CNT];
> -};
> +typedef int (*feature_probe_fn)(int /* token_fd */);

Should have been in the previous patch?

