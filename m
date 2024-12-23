Return-Path: <bpf+bounces-47535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9D9FA939
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 03:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE447A00FA
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2026ACD;
	Mon, 23 Dec 2024 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t1OSfUua"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0862F3E;
	Mon, 23 Dec 2024 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734919553; cv=none; b=CqrTMY+zkZ1W9F0AV74ZznPLzlE92Y1BrpGyTawChTsdk4aOvoc5BBgyiZ/pcSXiqykJQyQFOi79YlWqJNQqIVfxN0k4WXUEBFaRSTZQsCAtTnJ3ZI+9dWfAhKusRkw6yz3NjbRWjwbWEzbpgw67v62/PTw07mD9RRkxT3ShLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734919553; c=relaxed/simple;
	bh=ogWgtrn3ETuF+S1courSsr0kJR8X475NarqlopzCGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpLsvACmoutYse0cuaUOvFGtcDcpa/TWujc5e3W1782qi9YuQlaxiXewebiY9iPa3r/4rmA9jBrU3LAMvFTPa2XOdDxhXj44sTo3vX26oyYXVUfsZ7rJ+OVN9IMz/D8m49jGqWcozqnBXUfNV34b5uJwHinrJ9KOMHpMJ6TWyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t1OSfUua; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734919547; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=8SX10TJUut73MHa8UPAzH5/j9jFR1OjxKi+QmiPeJzs=;
	b=t1OSfUuagcDsclDWKHhmgzQ0ooNx5Y5NiN1+fdRdoLzOT+tYarrX0TXHi5PwV4uUvMKuXM+jEwCF6vLSmvG/rOWjcdiHnYjsTjXJ4k5EO9hXOCCg9vrGd0SA9hqG6BlcqLEyULUKhPFBo0KmowW6+q8U39TvvJ19USj3FFeK6AI=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLzyd6n_1734919227 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Dec 2024 10:00:28 +0800
Date: Mon, 23 Dec 2024 10:00:27 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
	song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
	edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/5] net/smc: bpf: register smc_ops info
 struct_ops
Message-ID: <20241223020027.GA36000@j66a10360.sqa.eu95>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-4-alibuda@linux.alibaba.com>
 <bfa40af2-e726-477a-bab2-7abebfdd6384@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa40af2-e726-477a-bab2-7abebfdd6384@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 19, 2024 at 02:48:12PM -0800, Martin KaFai Lau wrote:
> On 12/17/24 6:44 PM, D. Wythe wrote:
> >+static int smc_bpf_ops_check_member(const struct btf_type *t,
> >+				    const struct btf_member *member,
> >+				    const struct bpf_prog *prog)
> >+{
> >+	u32 moff = __btf_member_bit_offset(t, member) / 8;
> >+
> >+	switch (moff) {
> >+	case offsetof(struct smc_ops, name):
> >+	case offsetof(struct smc_ops, flags):
> >+	case offsetof(struct smc_ops, set_option):
> >+	case offsetof(struct smc_ops, set_option_cond):
> >+		break;
> >+	default:
> >+		return -EINVAL;
> >+	}
> >+
> >+	return 0;
> >+}
> 
> The whole smc_bpf_ops_check_member() should not be needed.

Got it, thanks for that.

D. Wythe

