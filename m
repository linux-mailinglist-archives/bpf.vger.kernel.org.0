Return-Path: <bpf+bounces-46723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639549EF817
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305BE17B1C8
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7E520A5EE;
	Thu, 12 Dec 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7LcC0hG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6F213E6F
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024621; cv=none; b=dp+0hoKhf/pISWiCldRF5w2lNIgM050yN21S3nwe8JM8RM0fHod/AtlGf1CVnwdwSs8vjFK9pQPvb5//x+7wDS4UoG6aFxQ5UH4TdizJZISeDoJU8W7tcED9rWlD1xUd8YDDJLjKFLO07z5lXXQGEW9x+3/81Gr39xooBk1cBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024621; c=relaxed/simple;
	bh=bpAmspOOviwkBbQ0PHK30vlBGoF3HxfYxjiQcHGqvwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsNUIHwoViPuKhXe4VBJbqSew1mZJJbc1qbuaQs55v/z4jGkPziYt6zohVCHAVRzUYFn+LWLd+jlxsPWWSTlKkNF1FLa/5Y+GwO4DTgRcHViR2k1NjF6NMk8A+fe6mHcgltANrIS2dDxvr5xPiToc2YiOtgEnmle99abFUW1rPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7LcC0hG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38637614567so441192f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734024618; x=1734629418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bpAmspOOviwkBbQ0PHK30vlBGoF3HxfYxjiQcHGqvwQ=;
        b=M7LcC0hGOeqsxDn+BjwwBQwJNK4C8kjNbJBP3vgkyjkw/vN5I6GUsAfQxD9eSL266j
         /LdxdQSGdIKE05T/9HryU7sq6brRm9aFpD09zrIBQIMsR7hCR+JuKzpdebFLhUlLxztU
         JG3RKudHNWs+bybAhwV5X3x8AkCJf2ZMwt19r/b7cDFuQp1o0DyKa8qYMylqR5OuOSgw
         YQOFLPTFlGWYxaSSQQVWDK1/SfLhQBmIew4nPLUZPkZLDQNFo39uH3KYesS+NgvR630b
         069IQ5XzEdcrNJhEGqd4aqbhqmXvYpGqAuRwA4LqCbBjZbGJmn3Ke1Lv5SzfHA9CdcYN
         i1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024618; x=1734629418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpAmspOOviwkBbQ0PHK30vlBGoF3HxfYxjiQcHGqvwQ=;
        b=BbKSfSlc96HEpSGyRDTBIGDOyHAQzjQQsNHemYLKz5qqF7Ux9G9YqBJMaRB6N88oYz
         ULjZ1gn6XOsa8X4b+HEKcQ9G70rXzQ2pmOjTc4tvHTwkcn132bIFiFzKP/baSHEOIj6x
         527vz8+7c+U55wzoZmRcvas+ek4Miin+zXY0IoWwPkmzcqTMRmRliddDDdX1LaMrddkx
         E16IWRvi6+e1zWnl0/T3lWtWz5Ex1hvP58LODMdA1IgDiHExJkzQ4athsUDnzopVHrto
         5JWgLMjW4QOXipiTxULk8+Mgs9YnzmHO1hx1QiR7t/slDOSSvO/4nkF0/1/BBdFbGfK8
         t1eQ==
X-Gm-Message-State: AOJu0YwPmOs4ctACALhs+edoW8tEVzR5J6lJM77U3G9HltWznvZLJ5PI
	kUgWcLuxeG36UTWf0GWM9brkMVXw9kslWbOf8BqCf7OK/MDy/tnDicHr/cPvCV7W2LdXTbcKjbn
	jkhUq2aJX6LwU9/42O+fe5bp3sZM=
X-Gm-Gg: ASbGncuqr5a4v0SKOJh/tlN6MUCTmNr94T7eOdT9MCaX+hckVthJDkLQwjmhH5SKzOK
	r36jX52SasJrZP2VLHaRbLz+HfP7RAYdy5jhJnhyQDpzEhsCkI7/OdQsEboYTADusRbKdEQ==
X-Google-Smtp-Source: AGHT+IHB8mwqIfEraFd4VXRi6mEx2yhK8WbIiOHDVgNGlMRU+Mp5HD0l87jfHy3zvgV8qdAxa9ZASuNzlZbRdTE4VD4=
X-Received: by 2002:a5d:5887:0:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-3864cec5ba6mr5029505f8f.46.1734024618367; Thu, 12 Dec 2024
 09:30:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212070711.427443-1-eddyz87@gmail.com>
In-Reply-To: <20241212070711.427443-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Dec 2024 09:30:07 -0800
Message-ID: <CAADnVQJRFe9EWGFWGtwQJptvnbU4xr+1GC3VO+NcOjx49BZQOg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix NPE when computing changes_pkt_data of
 program w/o subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

What is 'NPE' ?

