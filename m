Return-Path: <bpf+bounces-34848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FD931CA2
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B433D1F22552
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F83BBC2;
	Mon, 15 Jul 2024 21:33:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477524C7C
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079235; cv=none; b=WC55YB4cAIGVJ70gPG4Bk13zUOaY4FPc+u9FZ2nm+ryuINgAWNF7IdV/HTZZOT6WGSONOdRAdn8lJ+0qbt0kjQXjIB6EKklC4zi4ip7SeAuWe9i3xPLcfvxtWD/0Oqal+PTRr06ZaWSfp+Ldv979XGbO+8Te4NLV/LSZRZ/GlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079235; c=relaxed/simple;
	bh=/u4+YaVi3VV7SYXVarolp/qHbHmhCZ/CFD9eQjjXEBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBgMBoP4Fs8aNCImiluqZVydHlkSP8+K6G4PppencGKHgrC7ileWbLADNNCmj4M/LrUZYW80eBrtgNZdyOhVzPPgaonT6/A+qXagczZHxKmNOSddu7eEYSW9d6S42O2Sk/O2NLiUfOfKFKouqDlGUMfXMzFkU3sUVKlgJ+X8HUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5caad707f74so2367926eaf.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 14:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721079232; x=1721684032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u4+YaVi3VV7SYXVarolp/qHbHmhCZ/CFD9eQjjXEBI=;
        b=vBSthmlkBTycyNQRCjtQZjQEp9/PBgWC96G3QqJnK/XHb7okRxFsdIhHxxyxuxy6oQ
         F9TCC8/CzaLdlMkVWS34097GpFWUSKvRZyijgR1TOBE5jYgfGjk5seRPr/+nPNXjrMef
         0bS/lMdsDRNvIuFOhPpl0aGF2tL9PETC9xN55X+sylH0xBs/zv0XZu4qiDDF4QL6cF6j
         cbVKPu5zbfmPHdmXg92jA6+TuPweB9SWA0H6GCIzAEBy41v8wPuT0P/oVZZWr7fqwsPF
         HzGhZhkP46LKE2vCWZCBrv9pPG98BU03FDOtcn7Xo1odMFjI/7LN1ZSqIlzUW4tM9KvO
         dP7Q==
X-Gm-Message-State: AOJu0YzKIvULqIcbQTTOCny0IGYBYFR+WDpao7KUyOXdRYSIfvh9f4i2
	RJMy+aaef/7evQE+cVdRdvON8bWDh+P5FNgjjzePck2jDamAq8U=
X-Google-Smtp-Source: AGHT+IGLdCPBmZugUzekjlaSBjIhCXkuxK2Ap+jwHeuqQXQPIvYQ8RAOpxJ1xtKtPx44UidHcfNrZw==
X-Received: by 2002:a05:6870:c69d:b0:254:a917:cb3a with SMTP id 586e51a60fabf-260bd764a5bmr106134fac.28.1721079232253;
        Mon, 15 Jul 2024 14:33:52 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34d2b214sm3823036a12.46.2024.07.15.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 14:33:51 -0700 (PDT)
Date: Mon, 15 Jul 2024 14:33:50 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
Message-ID: <ZpWVvo5ypevlt9AB@mini-arch>
References: <20240713055552.2482367-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240713055552.2482367-1-thinker.li@gmail.com>

On 07/12, Kui-Feng Lee wrote:
> Run tcpdump in the background for flaky test cases related to network
> features.

Have you considered linking against libpcap instead of shelling out
to tcpdump? As long as we have this lib installed on the runners
(likely?) that should be a bit cleaner than doing tcpdump.. WDYT?

