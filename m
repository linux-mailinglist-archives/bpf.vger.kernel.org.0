Return-Path: <bpf+bounces-68926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D428EB8944F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B85587F8A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0295E30DD0D;
	Fri, 19 Sep 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cH28JY7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9EC246795
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281301; cv=none; b=VCD2h//nmYYiYiEjqrBfTC4yVT/AiN6w2gQQd1bGNIrQabj3GC7kJ2k3mtjUkaRDv6bzHTKPx46hwHOo9qkno/DTPYK84NYsOW24X62J9+uiyVB8tMkdg2yPxEJeyyVfZUGsMdrciQ/2wyUE0izlZ0zHLSY/2E2Qw1l7Nd+R1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281301; c=relaxed/simple;
	bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kPrNQKIW/SsE0It2WwkZ0K86PqkCNKcJxFb2a7AiurM+Kj9R1pTZDSVTX9yb3n3QbADhdIrxVhW65WwrCqMkUUmrnIyYIa9v6TgHwxcxn+8mkETIV2aknWc/37K2QyWEEdPrGLwuP8upnKIocuTGf1y9ba4ONAETKNCdlwlXB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cH28JY7Y; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6352ba3c35cso112864d50.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758281299; x=1758886099; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
        b=cH28JY7Y1HKiYUVzcZaRuPvKMaKJfqn3fYwNzQg0bDX34f4d+N1e2FzB/ndOjx5b3m
         Q7DjM9oJMy57tcVfQyUGkb2nkXFW6xAWVxS/v/2ZebOy9PVPOHRmoRiG0IxMuOTuG2QJ
         h1tI0jJXBEJquwFN0g5dqwcBQ4QTqKSeaiO4uL++3Yl0hwdyS06ky33eLsLe0sSaUUcp
         +FulWOjw7jPOE+IgU+z0Bxa1L/01XGR3lk92e7qYvMEswj98Z6BjoiGGlsaC3KVbrtzf
         4EgPsouIaMPEdO7QR3qfDYSYcwzrIA29UsyHWpXdkKlqHrp460AwKkHFYODuRM4LQem6
         IMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758281299; x=1758886099;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
        b=VIqS5TENaa3ZNx4sF47WihmcmX1WvTV7Z9r65yvqB1CrtoOuI08trOps7XGnOMoSBn
         15n/WMq8+gfVKEmGckOEVTjYFXQM907RDr85tdH/M1sd3obLWQbmeWEz3h6zT+Ryyssp
         nC18SSCgz8a6XRnuIKY/NH+BInCYF7abYTAjRmWIRK7apFz8tSkb7NY1sOEN6UyFWWA2
         zhPqjfQmuBsepJP4fljGCbP2foHSeurZ4hYyPAnH1K/E9/X76VlavmdacpcY2BvG31GT
         E+Iq5jO05YJbujhvCx6aXtkdwDKLVWgcJFN74sJ7AxVdAtk/0or2C+khiuLaKM0UPcfu
         ai+w==
X-Forwarded-Encrypted: i=1; AJvYcCWLuRgJw8e9Vt33dRwPk5RA9/359jt9K95iUzS9IWj7vmTOxymX3g9/xvmUnT5RLjleD1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYX5G+KYFP8JXvFqrPIKbEfCU3ZpfQdXtci5SbY3AVSJ/J4YUo
	CBh45kvPT52fnbwGJf0K7e8rUkVQRkmTMHmqbofczu4HRr2zlMt7Gn9t+qy/qxdEKmA=
X-Gm-Gg: ASbGnctrox81TvdDctrk32q2HDzKOWEcGIH6AOOms+3LWDyaBp+9U8xTTwLoR7KbXXk
	jCHzZ0P8N+FGlM6Npq6OveigUCfSZxeKpDrQWDZwEnVLIzyBwfpKOiVpSkMGeC7y+m00bEPXOEN
	DpgXoqzOOnXZxWBJBJKyEWwk1xkzClOtxTdnJHKbjAwIROLqdsDYLXDFu9G1PIY2zcvnUe14kZj
	6SW21RKdx/vHzNLppawG27quYf8iew7IVxhBYai7Wgp54YDfGB4V66l8jbVRNd2lhvbNa8DTZfD
	LUib058Wuk7n+WoO1AVgcIRp9txS5JuMKt7/RjjN5/wSE5kV2L8CNfGaj2lqG+kleJLeY07O1EE
	VHKGqD+CJNfQh1sn1rv+E4MajPw==
X-Google-Smtp-Source: AGHT+IGzit9Xl09pvF/y8vcEFtgKSFANQAuy7aNdn4IaGhXGUoBDbxyhkZegsmgt/FbqMid9KfiZtQ==
X-Received: by 2002:a05:690c:9c0d:b0:723:be82:c78a with SMTP id 00721157ae682-73d39d75d6emr24479897b3.31.1758281298949;
        Fri, 19 Sep 2025 04:28:18 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718ba1d7sm13612217b3.65.2025.09.19.04.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:28:18 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jiayuan
 Chen <mrpre@163.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: sockmap_redir: Support
 no-redirect SK_DROP/SK_PASS
In-Reply-To: <20250905-redir-test-pass-drop-v1-5-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:45 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-5-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 13:28:16 +0200
Message-ID: <877bxuu1f3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Add tests that make the BPF programs skip the actual redirect and
> immediately return SK_DROP/SK_PASS.
>
> Suggested-by: Jiayuan Chen <mrpre@163.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

