Return-Path: <bpf+bounces-72688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF0C18960
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 08:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B21AD4F1D15
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BDD30BF4F;
	Wed, 29 Oct 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j29ntzDM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8142EA754
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721333; cv=none; b=np4NIeEA1Az/FIB0Fvzj/cJLoEa9G3Ba5AxtObZYtnJRpQbhj47O+IJOBeNA4Fp7Sbhz3UirsJt3vxNuTr64zTdTkG9d+UduSiKOQpLIllOUxk08as5mzWZpZZX2aMHnb6DscW3bBgs3XePDSuOQYz68oxuCwH0i6DHzh7ySYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721333; c=relaxed/simple;
	bh=bOMMbexI6aDIrNtf5vFEnbq7xQbKAIAvzY9lE5k/XRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI40E7IbcpC6c5xdGczifpJ4H1tgWaxSWz0Hnxf41PF+IOvqPrEUX2JHBExYgB7B+21u9oYfukShXy+9qjpyYxYn/ncqdq6om6mmehupwN/dc6oMONd8OlScx+ndqFR9DPyEp2DTrbceauVYu3/RMWsCqWnoOEK7S/AJTP+mx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j29ntzDM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d83bf1077so424226966b.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761721330; x=1762326130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJozr33q7O27eAQclKBlJRIBGxacAxdnJElnx38SopM=;
        b=j29ntzDMrMILNznyMnLaFNonyxUQlkI17x0SAIP+O3S3kkRi6A5wz4D8Sh4N6ipdP5
         bXNJXLez1aVZ9szkbqccEd65LzvkN8QJFNy29rRUEaRL2S1fTqWSrAlNnLNLkx5AG+rk
         Yh9Xg2JEralnbPrlvuVekssLc4/FLAxJBPNLj8K6NLZqJKv2mvsshXtIC+HRo+Hm5EH6
         inOLl3GfFrmR/sEI7AD1KVrW29YDyiHfIUtSQkHRoG3gBQlu9w/RSkS3mLAG0SV4P7ol
         q4O2r8FzF55Z4oFF63Pw/GV2F1psb4ALwL+c6Mqu8zS+Kcmixkt3E349qPGnB8v/pk/T
         rciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721330; x=1762326130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJozr33q7O27eAQclKBlJRIBGxacAxdnJElnx38SopM=;
        b=D952yLfLp+BgOCHublPZuM8ogb4XOWWp8kCtFo16HnW4HuYdyRi5bd5YfgYH5zpTGx
         DdgVXxE/lFJXVEu2wLl40Xl6vf21np8dOWU3MXOfK+6YLFCE9v9h9SYKtKy4tH090MRX
         lyxoo5CWPWMxrBc/g+s7CbYC/KNH94VfFOiu+BSx6A/vLofpRbfdZ65GiyHEfRlQto58
         b4Wb5l9mQd1Rk9U9oNfv5DqYVcmF2wVKAVPKxOTK2kBuSKx+XL/6jDV6nORLXN5vq5Tl
         IuucSvkAy/o1RHfb5KV6PdUn7atlkRzAgJVEOYlBVQLQ7qFDi3xa/Q0ZZj0/uuj/z4pX
         TD9A==
X-Forwarded-Encrypted: i=1; AJvYcCUBfORB2kuBa6SYXktke96QpC3fuveBW2IEAS9EmDuy/iMNWLWRFnasHr1/Z+iR8wzlONU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXhXa07lqPivQPfinuCR940fYUqUNrW/Kgi+SOiCm7dO2VXdN
	1uqGIapI/yhYcCo9L+j7eNj2X9e3AEwvo2abAB/6PSwfIqaosoOirqch
X-Gm-Gg: ASbGncs5O2m3o7KSOo/7xfE0BKBOXToENpYoqdzSbW2ysjbsnZSmtYlr5wJMHV76ee0
	kpXnBFJ97d/s93XvD932qowOz5925s1cdBKlPdjFK7ZzTxIPePHQ5dch7jZuI4OV4H+IsMyEC+t
	58+soRoVBVLWwCl/u3TfJa43Bzo7/Z6TkgE1mz47BdQ0xW+EdlUW+fOoALG1FaEFfPI7RuRYvSs
	Pa919qIWdQ1rSB1w0oFIj6V2IzbmDnzRjBRSJUkJ2sFBZwFM33ZhxSIvGZ0qWhEioy1ZV8RpRNx
	v7SneiADDNkAB62jIrnNdipx0kj+up3C5F/xFyseB8gbHe1FNyrbPvXozlk2kceyJxKmTeDlJVG
	Gh7t6uGDXnFgSGM32YQsqsSIJjSRqijm3ijb4TQGYlO49tHPkOB4yQ8ARKDHjx6HawVJT/kjoQ6
	Uj
X-Google-Smtp-Source: AGHT+IGTI1ZIZClWng4yye7JAJ7wCJzANK4Z/hes/dqfq35lpCLXUzEK0uKqA6TU/xduUI8nwCqpug==
X-Received: by 2002:a17:907:971b:b0:b0d:ee43:d762 with SMTP id a640c23a62f3a-b703d2cdeadmr175477166b.4.1761721329730;
        Wed, 29 Oct 2025 00:02:09 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853386d8sm1318508566b.18.2025.10.29.00.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:02:09 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jannh@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@yhndnzj.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v3 11/70] ns: add active reference count
Date: Wed, 29 Oct 2025 10:02:01 +0300
Message-ID: <20251029070201.2327405-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> Currently namespace file handles allow much broader access to namespaces
> than what is currently possible via (1)-(4). The reason is that

There is no any (4) here.


> On current kernels a namespace is visible to userspace in the
> following cases:
[...]
> (3) The namespace is a hierarchical namespace type and is the parent of
>     a single or multiple child namespaces.
[...]
> To handle this nicely we introduce an active reference count which
> tracks (1)-(3). This is easy to do as all of these things are already
[...]
> + * Inactive -> Active:
> + *   When walking a hierarchical namespace tree upwards and reopening
> + *   parent namespaces via NS_GET_PARENT that only exist because they
> + *   are a parent of an actively used namespace it is possible to
> + *   necrobump an inactive namespace back to the active state.

These quoted parts contradict to each other. You say "we introduce an
active reference count which tracks (1)-(3)", and (3) says "The namespace
is a hierarchical namespace type and is the parent of a single or multiple
child namespaces". I. e. active reference will count such parents. But then
in code you say:

> + * Inactive -> Active:
> + *   When walking a hierarchical namespace tree upwards and reopening
> + *   parent namespaces via NS_GET_PARENT that only exist because they
> + *   are a parent of an actively used namespace it is possible to
> + *   necrobump an inactive namespace back to the active state.

I. e. now you say that such parents are inactive and can become active.




-- 
Askar Safin

