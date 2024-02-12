Return-Path: <bpf+bounces-21771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04444851EE1
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D51B20F7C
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE27487B0;
	Mon, 12 Feb 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNdZ6dTZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA81DDC5
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770896; cv=none; b=JKq8MjVQmijnPKW0rwuzfzTBITRd+Mv1qVKpW7XCH6YSNFsZotm2fzIa1kiDi1ks8zkUkipxnitUYtcjobXAR06+qzicAjsDErETjYP7CK7tlfzA0rtP7S0NueSMoIuKXQoALAdIoZlzBI5RSvEWjh5MRGy9X8zxjh44YHALtE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770896; c=relaxed/simple;
	bh=OHYuAMDC/tKRGl1qenc0257heZnKqFDTTnAVDXk6Mh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LlisxPWNLquJ6coRCRRxlgMjbGVrT/LEFzp4TPYs9LcR49gS5tYTkKFUfHoId5fAo5P9BOzg+1/GvWVa0D3gCl1rwe0BmMhlPR7NkU18yslbJ1uXRE/dqGb5gC1UsSaQLGtasH5bX8iKY+mWLpfQxDuuiTnHfNVT4IniyM0xR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNdZ6dTZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so4156176e87.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707770892; x=1708375692; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHYuAMDC/tKRGl1qenc0257heZnKqFDTTnAVDXk6Mh4=;
        b=lNdZ6dTZPgsa2OdNHn1Ll1/0oBmNeO30k50b2Ckum2/Uu0wwtXYlbeHNKwjULYWHKS
         Opq9bmsHDINqgm8oaak0yUBCjoaLwIY1+M1QXtGgMZdDzGbquXHbemwF3/460kxeiyx9
         RjacWisNHvcKFbZV1JWL8uH7KGpNmDJCPynzLehMmlggMU8lmaWa+bum+1pNl6g9JMnr
         1RUzaKzzRIkAVyA9zlmK1AEXNb841sQAwpjSczwZyKkd0x8R4xqDXmlm90j8D0HtZUz/
         Req/sykJqFTcYDJVbcyaWTkCAMrRLJWGbX8VX8F+c/wqbbYSkoNt8TO1iKb1RPZ6vrZu
         Ku+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770892; x=1708375692;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHYuAMDC/tKRGl1qenc0257heZnKqFDTTnAVDXk6Mh4=;
        b=sf9uvF5oRA0gA+2yAVXzIJuFNbuIa7awIrUF3AtvYn0s3qdVJBWRfPXivz05SNy3ER
         X1qBOMbOSiNcfK7QzIIhEsRFwEg2CoL9Eg+Gbo03kRvivC3uR8UTRmwy+hHSKpKQwTDS
         N6tCKu8qkBz9VdvfYdISBI729J3mguTb1q081Xbp1HBSvT9r3QXeabdPUmCPYH0MtJkD
         Vs/fFfjwYps2zTHCrMANy5nDjBpqSXdUJu+EIAAqnMcy6rJjgKtI6fw6sBlsL/wCzefs
         QMXuLK2CeprMVYkPJ1hvQcTfety0KBSrcQlBpztVwd5XuOmtOzmiWNB/ZmTGMJV2TG56
         ocKw==
X-Gm-Message-State: AOJu0Ywm/9XKUlRPsgnaFeX1UYhDl8y4uV/fArxPX+iboqjAe2APo9ko
	+sQAgv9P6ZHtY8olb+wDkWN1+xhBVf346TseW3bPkpRYpL4oWU+EyCqc0RgMvApnr4rZK0pfUp6
	Veg==
X-Google-Smtp-Source: AGHT+IHv0Dk9mEaWLBMim6UD3L7ykxBNSK8uM3pWYUqxhK2tRzB3m2LiB3WyMqyVIl2IMKdliFEpLA==
X-Received: by 2002:a05:6512:4023:b0:511:9254:de31 with SMTP id br35-20020a056512402300b005119254de31mr2201615lfb.40.1707770891948;
        Mon, 12 Feb 2024 12:48:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlXSvcfalr7s3PO9WucMc1t9yj116lj4z3KrVwD1H0wRTyF6OYkUpk+7TBQgcElypiIJInzCW5tam1AhS76J/VASyVa2QeA0Wy5tdXgfFxOuhYDWIzYYM4IY907GWa70AvKyTn06f4gNM9IWxSDh3W
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id vk1-20020a170907cbc100b00a3cef401a3asm171946ejc.140.2024.02.12.12.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:48:11 -0800 (PST)
Date: Mon, 12 Feb 2024 20:48:07 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev,
	daniel@iogearbox.net
Subject: Generic Data Structure Iterators 
Message-ID: <ZcqEB3REkEKJahQu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In numerous BPF programs, I've found myself needing to iterate over
some in-kernel generic data structure i.e. list_head, hlist_head,
rbtree, etc. The approach that I generally use to do this consists of
using bpf_loop(), container_of(), and BPF_CORE_READ(). The end result
of this approach is always rather messy as it's mostly implementation
specific and bound to a specific in-kernel type i.e. mount, dentry,
inode, etc.

Recently, I came across the newly added bpf_for_each() open-coded
iterator, which could possibly help out a little with trivially
performing such iterations within BPF programs. However, looking into
the usage of this helper a little more, I realized that this too needs
to be backed by the new kfunc iterator framework
i.e. bpf_iter_##type##_new(), bpf_iter_##type##_destroy(),
bpf_iter_##type##_next(). So, in practice it seems like adopting this
approach to solve this specific iterator problem would lead us into a
situation where we'd be having to define iterator kfuncs for each
in-kernel type and respective field.

Now having said this, I'm wondering whether anyone here has considered
possibly solving this iterator based problem a little more
generically? That is, by exposing a set of kfuncs that allow you to
iterate over a list_head, hlist_head, rbtree, etc, independent of an
underlying in-kernel type and similar to your *list_for_each*() based
helpers that you'd typically find for each of these in-kernel generic
data structures. If so, what were your findings when exploring this
problem space?

/M

