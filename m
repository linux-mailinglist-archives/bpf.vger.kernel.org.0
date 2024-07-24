Return-Path: <bpf+bounces-35518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0093B395
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A191F2170A
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD815B145;
	Wed, 24 Jul 2024 15:26:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF215B102
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834774; cv=none; b=jWJRL9VB3WyhC7QZ/X7KGKfm9FKH/d78ZvYWZZmIfTXjZs0GrXxkwW2a0d7LnPV/2HzrIH5LfAyD40UT0tjOLwUmiQ8rMGJ7WbtlYaBnMe5OfNx6m9ba4EndmvV/TPj2+EbhR0S2RSk/jSiefZXGF0uqJpgBTf+8DD3vPujtmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834774; c=relaxed/simple;
	bh=6hZ11eNQzz5jiCcM1bjwwpeRMquz7Q+zJF/OU97bVFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imcgTGoyfUNofpfUjXUzNohWh73I222b3L1E92tsYZud46hVXzw9QWEeYnFyIHjOAyXgA+Xl+zwwv6VIo3UO3gNFPwGcDNrpd0vxnpcWdKsF/Qccl635GG3/yhYg4cJ9Q8/4JGqKCxvCrKonvB2AQcs+SQcm+FNkFsm6AS0LRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd90c2fc68so17393115ad.1
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 08:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834772; x=1722439572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hZ11eNQzz5jiCcM1bjwwpeRMquz7Q+zJF/OU97bVFs=;
        b=FazaZ2XgizxFNHWR4bFwJIrcivzxF2HBC8XhSgdNfIVNKxquuOtXxlH8YOdfQFh05W
         Q5N2djflz3/zMoVtqdO9/58GdK6OU9ufgXWYGlRjBGimipXjTvruF/iKiJiM90ZNoU3r
         0ZxMQ2syUfrIZLiorQXh5P61KrVNemyJDin9oWbTbrDBOfzGYveDO7CWY007hegokS6e
         Hz2knOrm1TcPQP9e7BSDsa4u5trNicJk6V2zzxe/Z9eZGZSxx49peoZwTwrzfjuwVKUa
         zyoVJypcj//RBGBekBTcmPNAnUBzKZweC2iPfxK0TrADOefLBwtf0L4oLpijJPXm+9Hy
         SKfQ==
X-Gm-Message-State: AOJu0Yz42LJjQj/8ofVqAxv9+5Ab7BhmSj9kz+qv1InrcQXycbAhwj1r
	4Y51YKxqd7EGSK+PZX56NpjrDGJ1JKCmWhqFVRrHOl3g+rlXW7M=
X-Google-Smtp-Source: AGHT+IEQw0KThz00Fyb+EBGkooxMuyIpnRdwYxK9ULTtUzf+8e/2+qtJcGma4MceLqviLEQ86CAelQ==
X-Received: by 2002:a17:903:2a84:b0:1fa:fbe1:284e with SMTP id d9443c01a7336-1fdd540078fmr29685095ad.0.1721834772095;
        Wed, 24 Jul 2024 08:26:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28bc6fsm95225585ad.65.2024.07.24.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:26:11 -0700 (PDT)
Date: Wed, 24 Jul 2024 08:26:11 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Monitor traffic for
 tc_redirect/tc_redirect_dtime.
Message-ID: <ZqEdE94dcBewr9Bu@mini-arch>
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-3-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240723182439.1434795-3-thinker.li@gmail.com>

On 07/23, Kui-Feng Lee wrote:
> Enable traffic monitoring for the test case tc_redirect/tc_redirect_dtime.

Alternatively, we might extend test_progs to have some new generic
arg to enable trafficmon for a given set of tests (and then pass this
flag in the CI):

./test_progs --traffic_monitor=t1,t2,t3...

Might be useful in case we need to debug some other test in the future.

