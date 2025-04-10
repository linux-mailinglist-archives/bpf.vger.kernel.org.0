Return-Path: <bpf+bounces-55691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6CA84E2A
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 22:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1E74A7CA3
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404828FFD6;
	Thu, 10 Apr 2025 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MWy7gTSc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB701E572F;
	Thu, 10 Apr 2025 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316859; cv=none; b=UBy0eAfqo50+QlIjB+/TGMQIBFE7F79SWNZuDaAL+BK/wVrwWyNhwOUiGWrikAnKceymKqaQXFOXj2jMJFjFJ8ITYwNN2toLk3O/SCVShYBfZYty62c+j5HTWhANa4gbaISOceg5+rizwTbCBp6b7n47mlsGmgB5rPw7mKFa8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316859; c=relaxed/simple;
	bh=cTObNwotxu11Nx1Te+NRPST2pCv6B7KKWQrtPj4ibc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bA3yQZ6EonyFndd+n2MqQIB9DEEcaWmRbmid3fKHkChOmwONfEyLBEjKWh4bPmMJd/Q/KziJXj+4SO08la4GOFi3yzudk0+Vl/ko738GCvsKu+IfDwOWfmGz8UQg+CGtqhe0cH5sQm253AMyEcHoWfK6MEeL8gN7HHuEKlWOUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MWy7gTSc; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744316858; x=1775852858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSU7psxnbMS4SUGASS6CvjvaoPeLAaxluOoQpsqwWPk=;
  b=MWy7gTScSODBiFG7QzUlGuDz9c1f23D3WjdK+w+o8IHgBKFyUqzI+1sx
   dpvOi4lAJMyFk/X2qTwmdDsD6uxxVHiF2U/JaUaC2UJbLzGfaaZoBOlfm
   EXQixo4vyViYyoNZiMTdtUyaep94iNRePGdiKd5JTEn783v/R3WppsKaI
   I=;
X-IronPort-AV: E=Sophos;i="6.15,203,1739836800"; 
   d="scan'208";a="82682153"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 20:27:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:1598]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 62febdba-8fc8-4cb4-ab5c-47169ccf6bd9; Thu, 10 Apr 2025 20:27:34 +0000 (UTC)
X-Farcaster-Flow-ID: 62febdba-8fc8-4cb4-ab5c-47169ccf6bd9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 20:27:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 20:27:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
Date: Thu, 10 Apr 2025 13:27:12 -0700
Message-ID: <20250410202718.7676-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409182237.441532-4-jordan@jrife.io>
References: <20250409182237.441532-4-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Wed,  9 Apr 2025 11:22:32 -0700
> Stop iteration if the current bucket can't be contained in a single
> batch to avoid choosing between skipping or repeating sockets. In cases
> where none of the saved cookies can be found in the current bucket and
> the batch isn't big enough to contain all the sockets in the bucket,
> there are really only two choices, neither of which is desirable:
> 
> 1. Start from the beginning, assuming we haven't seen any sockets in the
>    current bucket, in which case we might repeat a socket we've already
>    seen.
> 2. Go to the next bucket to avoid repeating a socket we may have already
>    seen, in which case we may accidentally skip a socket that we didn't
>    yet visit.
> 
> To avoid this tradeoff, enforce the invariant that the batch always
> contains a full snapshot of the bucket from last time by returning
> -ENOMEM if bpf_iter_udp_realloc_batch() can't grab enough memory to fit
> all sockets in the current bucket.
> 
> To test this code path, I forced bpf_iter_udp_realloc_batch() to return
> -ENOMEM when called from within bpf_iter_udp_batch() and observed that
> read() fails in userspace with errno set to ENOMEM. Otherwise, it's a
> bit hard to test this scenario.
> 
> Link: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

I felt this patch is patch 2 but have no strong preference.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

