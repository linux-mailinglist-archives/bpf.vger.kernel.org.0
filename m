Return-Path: <bpf+bounces-38114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B245B95FDEF
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 02:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCD12822B3
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772392107;
	Tue, 27 Aug 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iMkB9JA8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B21FA4
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717790; cv=none; b=o7TeQeF58jE88iIReQKhTjO6Q3AX2xJEXuv3m2qqYMrofqvlJsn98Nk+N+Te7EN+0Q72k+NCSMerNo2RG9OpC59UYAXiHx7Y1HieP1MvO7dF8AReVkBH/XsA0MRlIe+w8vhZOMSB0eLF665q65ZqDAh+BL2ixr/2woV0PT5/T/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717790; c=relaxed/simple;
	bh=MNX9a16kkQeFn5DqUjfgOX3cRGCxUfjm0QpaWgyc7Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TTBzqQ6ClkuRJbxJpvtuT1Mp61Shbi/3BcSRxyVw+EI+y259Djl67LAiJToHULxeMF9Hrh82KIUak/frQONddZ5uRbXtXpQqaC9LO8Ttt9+oIDFpGozS+38SLXBEIft/32nVTvx4vVRdxrJn8q1Zk5DS92hFegNREe5z17BdZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iMkB9JA8; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf9db9740aso22131696d6.2
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724717786; x=1725322586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxqlCIIVPOy80RPgVgWmzEjQn5sLiFmvjQd7bMYBDjE=;
        b=iMkB9JA8BPpM9AqV2tFEyWluXh8moLbqZtKJ9pZ8FI26yzizTTmZrqoWQk4+MaKjNd
         8vsUd0CLdO4z27n+d/nyC0PlV9oABz6RMmSAXhOziZt2GxmElRCK1TmCHfUaEVUwhrUR
         UWDQWL9s7+pliP8H5tthdgA3pFxj8goFCSxIM7NIkDquw1r+VI9tUVanxEhkEtEyW+4d
         KP45T7pzXZwaN4bvE/z/itLTCsLbXrl5+u6watdSt0JyvXS1+9herPzLjg7Fe/lXkpeG
         wJy+UpUaNXW0hJHotkRQUh3zDi/lSZsb/kew5TWqWvq0C1LkImqRPaTkBJfL0Iv3Y+r3
         4sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717786; x=1725322586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxqlCIIVPOy80RPgVgWmzEjQn5sLiFmvjQd7bMYBDjE=;
        b=u8BCbe/gBDGsDjrkOB6+pUTuXHn4ZETSjqEwkQQ/VteWu6DMFQXiaaWPyHmtCA1bad
         MZEsECRdQr5pBjWeq273ifytxKky73XjnfqDWaGo58KO2FmLygvy2yw7koSREA1lNZ+2
         Rebkmb7BtfdGw6OZN9Tb0d62rYuJJnlx14LA9u4SACBvztd5gm5IObtKPkq1SsYcb65f
         N7KAn9cjxBB7hn1BI7mE87L9DKOPcJf/Wmvw9CcTULu98dzP9ksWuGs4DbR3gwTkjaRZ
         OxFoooo43oUQEsdyEXW6M1rKowKqibL5haaoAaC+7iasKwLP46mBGqye19uy7n+VSgze
         feqA==
X-Gm-Message-State: AOJu0YzAsEpM24N17dCgLufqNXsQyxdq5KCJhFfu9kD+/ChI4SpUzTiz
	FqFzeeoPQ4zAmCduiW5Db0na20J2WoXzI9Jyy0BtL4QkB7CkvOefVa8cmAgkAJ1Nl12PVbmXUSK
	W
X-Google-Smtp-Source: AGHT+IFPG6Y1jf7+5BPEFiEK9LFPqtPQh5Q/Dkl6TBuKSEqW4VLlroF06ndzuDQogttxJWwjvVUxhQ==
X-Received: by 2002:a05:6214:4806:b0:6bf:7fba:c829 with SMTP id 6a1803df08f44-6c32b809629mr13308046d6.42.1724717786406;
        Mon, 26 Aug 2024 17:16:26 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcda66sm51387136d6.122.2024.08.26.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 17:16:25 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xiyou.wangcong@gmail.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH bpf-next v1 0/2] prevent bpf_reserve_hdr_opt() from growing skb larger than MTU
Date: Tue, 27 Aug 2024 00:14:05 +0000
Message-Id: <20240827001407.2476854-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

This series prevents sockops users from accidentally causing packet
drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
reserves different option lengths in tcp_sendmsg().

Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
reserve a space in tcp_send_mss(), which will return the MSS for TSO.
Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
again to calculate the actual tcp_option_size and skb_push() the total
header size.

skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
reserved opt size is smaller than the actual header size, the len of the
skb can exceed the MTU. As a result, ip(6)_fragment will drop the
packet if skb->ignore_df is not set.

To prevent this accidental packet drop, we need to make sure the
second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
not more than the first time. Since this cannot be done during
verification time, we add a runtime sanity check to have
bpf_reserve_hdr_opt return an error instead of causing packet drops later.

We also add a selftests to verify the sanity check. If users accidentally
reserve a small size, bpf_reserve_hdr_opt() should return an appropriate
error value and no packet should be dropped.

Amery Hung (1):
  bpf: tcp: prevent bpf_reserve_hdr_opt() from growing skb larger than
    MTU

Zijian Zhang (1):
  bpf: selftests: reserve smaller tcp header options than the actual
    size

 include/net/tcp.h                             |  8 +++
 net/ipv4/tcp_input.c                          |  8 ---
 net/ipv4/tcp_output.c                         | 13 ++++-
 .../bpf/prog_tests/tcp_hdr_options.c          | 51 +++++++++++++++++++
 4 files changed, 70 insertions(+), 10 deletions(-)

-- 
2.20.1


