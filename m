Return-Path: <bpf+bounces-26481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1377C8A05D9
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 04:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF64B21C41
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8284A5B;
	Thu, 11 Apr 2024 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="L7PJZMBL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735F83CD5
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802643; cv=none; b=f49JoeSYmKGIYbEvVXGR7IHL76EWn9lYEm7bhDJWZb6eNyTAX624gcMLnRWzv1vdZmd0Hyd/Vp0XrDr0swjnjdDdkvhBGxZZuGEdLrvjymiZv+2Ir1fKQI94SIc6+o3D86ry9S1geJVCuZwbVxt53FJvL4hypgbE56qxpNglrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802643; c=relaxed/simple;
	bh=PcPW/OIMVeZXCRyoeXq8oAFYmKKXUaihPmtYX8Q/b7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctNgWJZunX/n0MeaxxzFzdU86Bb4fjzvoSBWokHtC9elHm2jDmJmA9xSdZOREeFyUD7VfOyn9CKX4GbmlJcvZcaL9jkUf73KuQF+NbnA0EhXTskzSXvO4PVjNnC5Ejwb6JKYAhBv9pP1gOQtc1LKg+cPcKfi9paJ10jtApP8A50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=L7PJZMBL; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-Id: Date: Subject: Cc: To: From; q=dns/txt; s=fe-4ed8c67516;
 t=1712802622; bh=PcPW/OIMVeZXCRyoeXq8oAFYmKKXUaihPmtYX8Q/b7U=;
 b=L7PJZMBLkMN7WDX4YZXd8m6KBjmjsQeClHiYxmTPQweEmHUrsf9CXOfB+Z0lkFGUqSd8Pxv6a
 lh0tNe244JKzHJnDaehpzwy7Su/NzQrHe+kj1mGi+4dSZzGM3NIzK1v/ePwgsf2f1k7HuxNfz4v
 PTldSIt8K3rYh2cfbViY53g=
From: Brad Cowie <brad@faucet.nz>
To: martin.lau@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brad@faucet.nz,
 coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net,
 john.fastabend@gmail.com, jolsa@kernel.org, kuba@kernel.org,
 lorenzo@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org,
 sdf@google.com, song@kernel.org
Subject: Re: [PATCH bpf-next] net: netfilter: Make ct zone id configurable for bpf ct helper functions
Date: Thu, 11 Apr 2024 14:29:33 +1200
Message-Id: <20240411022933.2946226-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <29325462-d001-4cb3-909d-27f7243a5c05@linux.dev>
References: <29325462-d001-4cb3-909d-27f7243a5c05@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; brad@faucet.nz, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66174b3ed27b905a1d2cd455

On Sat, 6 Apr 2024 at 09:01, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> How about the other fields (flags and dir) in the "struct nf_conntrack_zone" and
> would it be useful to have values other than the default?

Good question, it would probably be useful to make these configurable
as well. My reason for only adding ct zone id was to avoid changing
the size of bpf_ct_opts (NF_BPF_CT_OPTS_SZ).

I would be interested in some opinions here on if it's acceptable to
increase the size of bpf_ct_opts, if so, should I also add back some
reserved options to the struct for future use?

> Can it actually test an alloc and lookup of a non default zone id?

Yes, I have a test written now and will include this in my v2 submission.

> Please also separate the selftest into another patch.

Will do.

