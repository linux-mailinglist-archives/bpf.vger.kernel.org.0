Return-Path: <bpf+bounces-58756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C19AC15A2
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC21BA0E86
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42582242924;
	Thu, 22 May 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="aO5Nd6mx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B192030A;
	Thu, 22 May 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747946702; cv=none; b=YBAe/4bL8SFVUiP9wMu4uMBznT4bXVAQ7dxywIajPh+gVNv3DGGQeYgBmaeFeHMNW9KuYdVQfw7pBy0jJfBPjgP8BfrDnUqnuUf8M+pWBKMRiZNuoFvlH09Z0sZOnwnCPG3EEt28mAcGJp/Dl2tX7q/zkJSFIR2kWRnTarN56PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747946702; c=relaxed/simple;
	bh=Y+fmJjvDpOzGYYh9qA7FliN0ynEtrVtM10w+/SSHX2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuuEXCHclSHX+g9UCoUqdfGK2oiFHEQHkafi8SNvZ+Dv1ToC9O2kmbzp7OCzrUMKxugBr6eAGQm8/dXV+blo9M9tpYqQ7KmbmL7lTl3sM4r+3/heMB8F2ytbMO0UGSuNSjmN/JYgTI+RofKMB8MbJYy/qMe3ySeFWXITlarTQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=aO5Nd6mx; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747946701; x=1779482701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=etztXbZy5fY3YratMTASxbM/kcmVkrd8hvRRTX8ZFss=;
  b=aO5Nd6mx3N8uP97qIv1AOLDlY78d8XH5UjaE5FvXfRqrElx3ILVvfghn
   0WG+EC830smY2at8CKO0H+XKXX2dWF+7zRJDidx3r8/K8NsEIZNQEMn4h
   iNp/GJhZcuvt1XNIUNBysIl7hfJvxSs1EvXMXcXdGmds4hbVGOLvk+PbP
   EHvmbAL069EhNtCmTfsrEQN/Owaa8G4qccwAJm28QY/2a/V2QNAtUEh/c
   9ECv1xNJnmDH5PCcJsoYC3WpI+YRO7tBtOzTjPTAZSE74cHenSl4RPG6n
   Hfrp+aThK7D7rj/NzVWXD1wb1/tQ69KVvKDAB2fOfc/0WELnzBJck8wnL
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="523472448"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 20:44:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:21470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.147:2525] with esmtp (Farcaster)
 id da345f19-2280-46b0-b4b4-62ec12efce08; Thu, 22 May 2025 20:44:54 +0000 (UTC)
X-Farcaster-Flow-ID: da345f19-2280-46b0-b4b4-62ec12efce08
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 20:44:53 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 20:44:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <alexei.starovoitov@gmail.com>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
Date: Thu, 22 May 2025 13:42:02 -0700
Message-ID: <20250522204443.78455-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <wxqtnfk2nkwfd3lybyyitawusswohp7hkaoszfxpfdsiuluilr@g3zlc3ojxjkv>
References: <wxqtnfk2nkwfd3lybyyitawusswohp7hkaoszfxpfdsiuluilr@g3zlc3ojxjkv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Thu, 22 May 2025 11:16:13 -0700
> > > >  static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
> > > >  {
> > > > -	while (iter->cur_sk < iter->end_sk)
> > > > -		sock_gen_put(iter->batch[iter->cur_sk++]);
> > > > +	unsigned int cur_sk = iter->cur_sk;
> > > > +
> > > > +	while (cur_sk < iter->end_sk)
> > > > +		sock_gen_put(iter->batch[cur_sk++]);
> > > 
> > > Why is this chunk included in this patch ?
> > 
> > This should be in patch 5 to keep cur_sk for find_cookie
> 
> Without this, iter->cur_sk is mutated when iteration stops, and we lose
> our place. When iteration resumes and we call bpf_iter_tcp_batch the
> iter->cur_sk == iter->end_sk condition will always be true, so we will
> skip to the next bucket without seeking to the offset.
> 
> Before, we relied on st_bucket_done to tell us if we had remaining items
> in the current bucket to process but now need to preserve iter->cur_sk
> through iterations to make the behavior equivalent to what we had before.

Thanks for explanation, I was confused by calling tcp_seek_last_pos()
multiple times, and I think we need to preserve/restore st->offset too
in patch 2 and need this change.

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ac00015d5e7a..0816f20bfdff 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2791,6 +2791,7 @@ static void *tcp_seek_last_pos(struct seq_file *seq)
 			break;
 		st->bucket = 0;
 		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		offset = 0;
 		fallthrough;
 	case TCP_SEQ_STATE_ESTABLISHED:
 		if (st->bucket > hinfo->ehash_mask)


Let's say we are resuming at an offset (10) in the last lhash bucket
but a few sockets (3) disappeared, then we go to the ehash part with
a non-zero offset (3), which will overwrite st->offset (3).

If the ehash does not fit into the batch size, we need to allocate
a new batch and retry, but the offset (3) is different from the
first try (10).

