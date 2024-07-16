Return-Path: <bpf+bounces-34901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452C932244
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290FD1F21CC6
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81A19538D;
	Tue, 16 Jul 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PUJ9oacj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A44206A
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120099; cv=none; b=TdNVdruUl52Q3kPlhxCiyZ/DqwU8/83iLRsK+RC/vmV+onFXgwrIdehDAQrsM5QKLtvVFnH614ztwflW/oRPDBBrm7Xv+wsTgQVqCVkZzoZMeiDY8bMv4l3bJQO/x5/WWjhCbXi2Y3vVSqVhYpaJ59gV5s+gOg3lgo93B40v2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120099; c=relaxed/simple;
	bh=SJen/1QT5j9lBSLAkF5vcsbT2VObhXZGBhF55aYD4dA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWLj0Jo4VTSAOVvm/Cjd8OnXP0GtbTPniMirnIhEikhFvwpUBl1df3fqjObbaV0GJdr2S/Ayl56RFLmQeBVd1Kopd791YTqmmOK4E50iR2OycctjbOBiTsNjVPz9RZTPyytwjA96CvqidySoptNKk/g0Eby8pZ3/Vl5PZxemE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PUJ9oacj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso6426915a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721120096; x=1721724896; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJen/1QT5j9lBSLAkF5vcsbT2VObhXZGBhF55aYD4dA=;
        b=PUJ9oacjkJTrKs/+0gGAmB99AJwLGtXY7gl0Vp8YpiFY3VwBnj4p1M6ojKDuN3EX1T
         1VjE3SvGzWvZ4m+oRav+eI+kDOLnJ6x0uOhibsogXZYku6dhav8EHJhNFPUMBOOfpMYN
         j+QK55ddOJVPEIOY7qAm0t0XJEU1KhWdUt0CHPm1UVbLShTu5ReoaqyTrRgJonRVabqU
         rEkehN0tZDYkFgRKCKvtpkTalZyRe4eV83qP7IMUW7Juvrsior1B+eK48YvhjfTGMPHP
         W7Xf+DXHinsmKnrsuhlK4PCsDxFLL15vOo0a33/PYyK39mycdJ+2ZG4SBVsUB059krlk
         x8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721120096; x=1721724896;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJen/1QT5j9lBSLAkF5vcsbT2VObhXZGBhF55aYD4dA=;
        b=T897wURnxWHidQC7F5/dLBhcfFAO8JQiHWtBLHDDxZY3sMp7qERImMr0hrfJjOlLOk
         aZeyspuSoeJJrvknbIO+9uJWk7TKObEKVQn+cdRc9qLqwCcZmSuXao46oEq+DvH/VdLK
         vqADuZYCjM9LaDSDh1CY4L1PO7kIf7Zm2IYhLwMtbfaOEi7NubwF+6ErjoFT01KMTYCj
         OGk/bQttbGpo3kBpU3o9+pOftx5Xp5LUUPmURbSWxXYvUarhTf3q4bEUelqs9LGwt24J
         BnLJPlFZ57dOO+mYcQlC7RaNE7lfPolB9rlFZmmsfQU/zx5QHcice7u7weQCo7H0Q5md
         sVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWV/0e3ktAKJieKuVKB3w+C4yNFqwZQu9MjSGmKdM1akKE2ux0UQp4E0/O+lgDJpvRfpA3k8nx6SEHnlna9fig1DlkS
X-Gm-Message-State: AOJu0YxMWa9ed358DpYDjU8FXFmtHvCBh8SGDX5GVHR4SkLJGVNDtjMm
	GodjWpbGlrKJ9wFUofOKnVKn31vX3X6AtCfODy2+pmuqstOkLANSkTSAImZHYyc=
X-Google-Smtp-Source: AGHT+IHEX3XLbWwFTmlBuVFSbqHwHwV/VNG7yL5ANvbtlfCyppiI9BxcfUOkzXt2VUfh+FC0HMhcjw==
X-Received: by 2002:a50:9b55:0:b0:57c:4875:10a9 with SMTP id 4fb4d7f45d1cf-59eef66c611mr766098a12.24.1721120096477;
        Tue, 16 Jul 2024 01:54:56 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a2705sm4495027a12.60.2024.07.16.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:54:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v4 0/4] af_unix: MSG_OOB handling fix & selftest
In-Reply-To: <cc71d3c5-41f9-4e6a-98d2-7822877b6214@rbox.co> (Michal Luczaj's
	message of "Sat, 13 Jul 2024 22:14:16 +0200")
References: <20240713200218.2140950-1-mhal@rbox.co>
	<cc71d3c5-41f9-4e6a-98d2-7822877b6214@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 10:54:54 +0200
Message-ID: <87jzhl90o1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13, 2024 at 10:14 PM +02, Michal Luczaj wrote:
> Arrgh, forgot the changelog:

Take a look at b4 for managing patch set the cover letter and changelog:

https://b4.docs.kernel.org/en/latest/

