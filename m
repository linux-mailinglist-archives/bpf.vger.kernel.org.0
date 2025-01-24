Return-Path: <bpf+bounces-49664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E0A1B4B8
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4401716A09B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD67C219A89;
	Fri, 24 Jan 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLlF9sHA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0C218EBF
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717823; cv=none; b=cS3XZFHCO39YerTvdiFoiwx/vtV9QqsTIe8O4n+V7DxtuPAlsmdwW00yQOnSwWixhVMpXVcDQ4Y3VsiOdPt6p6Iauv3e4ZVZBZ0FZ/oO5897HLk0PjCHS9rmgHoEwik49PL4N1l9AybTo9VYApcGu1S7+berICMN0KuuhsIPO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717823; c=relaxed/simple;
	bh=iYj4hW0xtnkPbu/vX7ZWHnx75Z4Zj9sR2uPZh8SCMPs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUZTZsPt8H1SdBwKMFyaBzNU7+pnVw0X3QEmzA0I9lrYdDqA3ZJvJ+kbaSSmA61DRJ9cITfLUEIDPcHFA2mMkYLuewzx30ElCxyjBiyaBXiicnDw+nHvoN5UucgUvzxdw2p+zuUlgARg6B0XJyIMyicFvMAfQXlqmYUkJjcEo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLlF9sHA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so316524766b.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737717820; x=1738322620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCUUPtDtcTBte4kXeFFk6AJ03hSo4Zrva4Xq1tAXrgE=;
        b=FLlF9sHAKXtI1qA1b7uEv7CP7mGNU4H6j45xu+qWScLnQ4TVFNSu+cHYxgCxCE0Y53
         jzqgb/FXd4aRgK7WVkrxh4BvpniixnYqAzrXMnYYG8nwcHP9LQWaWinEd5B2WQK56V+0
         KW5qKxgaSm9kz0WdvFrlt1NhEKF/nb0bkVz4/QpXqWnUauzH+FAZRg4vnD9NNDhNiTeb
         SF+syHCJ3mVcsRQwzCFtUDI4W/CxwIdSI+gjT3MpQa7HopJQ0wIuTPG8EwehuZ797oAr
         deuu+yj0052q+veuowZ9kXb9+jw9v37pH8pXqcyFGCeRGkSrRpf122TvLOeyGff0bphe
         0TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717820; x=1738322620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCUUPtDtcTBte4kXeFFk6AJ03hSo4Zrva4Xq1tAXrgE=;
        b=qoJVNA1aMHz9bfsRzBLG+5FgpIWaj8bB95s7DZCUwgT4Iy18oxEy4vY1rr0mkOSlHE
         9ieRfSVfWJ4Hh3VA0N+CNf1vBdWhcX1IioOBS1y2k3e2cWTbX44PbIZqrR2LiZ+81BOP
         Gy5wwYsjRP45punH23I/UryZGwv9kNn94Yqt1RzcVTngTWaCus5GfPu5B9qjPzIKobNL
         jSmSvWwQItGxEsQ1cB9lu0C9a0xuro8cdR9H3RTOMWxPyL6LRjvcl3MvSC3JwNSyezSD
         E3OIiirwS7sZ0F/1lAqe4bHJjKhNcrb0h1WeQ4Cn6L51tNpohsvOnu10HxgkDZ/nNGXn
         KnEA==
X-Forwarded-Encrypted: i=1; AJvYcCXFl60C3dN6LZLW4EAO6F+jCehmxytZ5GRCkkiShDpdvrC3De8FZyW+qeZZPdl/CK3UwiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWeC1ksOaEnETo7DO8EE7B5KlZJNFAtzgHhn9+OTCISdeolX4z
	UomncQ1Cnk8SoaaYk10+qgLIdXSTrzrw/GOPTt8uOaezJbMcWHg81cOCAQ==
X-Gm-Gg: ASbGncsp1cYsH9H/t0vdZzJb9GvjH36TOR2q715w177eQwJ2aC3HTwl0r6sTHf4Ut+d
	5KAPYj3Vuoop4ufPtRTxrqAd6QHyCs2uwpRmnVlsI7t7QMpWCFVpkwNnC2n5ZF1Bflj1f8z9RXA
	w6GynkEkYJtN8mbdhrekB1Syf0OlcLPEWsw0fLJ4O6lOZ74I7v4PuGhm7NHZUHuJH/bH2tbtJPD
	GIH91UwiVBXtq/s5+eVh8g0k2m38hKp34LV2xvLFZziDnAqDdzn3c0YsdZeaT0I3ZjwIjHEpHDq
	igOO72iUJYvwfA==
X-Google-Smtp-Source: AGHT+IH48QoSrwTYEwUWe7wgngw+yae41VCaE0slIkt7AUHooIC5/GEr2LLtKhhdsDZpfMzIEc+a1A==
X-Received: by 2002:a50:bb41:0:b0:5db:f2dd:cb4a with SMTP id 4fb4d7f45d1cf-5dbf2ddcc98mr19149562a12.27.1737717819714;
        Fri, 24 Jan 2025 03:23:39 -0800 (PST)
Received: from krava (37-188-182-96.red.o2.cz. [37.188.182.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fc485sm112075266b.160.2025.01.24.03.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:23:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Jan 2025 12:23:35 +0100
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
Message-ID: <Z5N4N6MUMt8_EwGS@krava>
References: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>

On Thu, Jan 23, 2025 at 02:32:38PM -0800, Martin KaFai Lau wrote:
> Hi Jiri,
> 
> The "missed/kprobe_recursion" fails consistently on s390. It seems to start
> failing after the recent bpf and bpf-next tree ffwd.
> 
> An example:
> https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920
> 
> Can you help to take a look?
> 
> afaict, it only happens on s390 so far, so cc IIya if there is any recent
> change that may ring the bell.

hi,
I need to check more but I wonder it's the:
  7495e179b478 s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC

which seems to add recursion check and bail out before we have
a chance to trigger it in bpf code

jirka

