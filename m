Return-Path: <bpf+bounces-60028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF7DAD17E0
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657BF3A9865
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CF3280002;
	Mon,  9 Jun 2025 04:32:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FFA25C813;
	Mon,  9 Jun 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443561; cv=none; b=Uq77KPx5EKndFHJSRq0MJqF0zdn1F/BQ23TuySHgLtC5U9UnESog4yQ2n7HpAa1F+BFTqatmaeZukEANvX7wK3kCi8iFzPdUCc+JzxMCDzxBfeiOqxUNuR1VZrPzMAxDXtzHal/j+Z+37LfMG71eCf1/ez6P7IpybH2KczFX3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443561; c=relaxed/simple;
	bh=aKhPMhEEXLCTOgFuZlDEMCFOmdcuRJ4fgxKfEQzZvCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixapZNmciyDPjHJee1Z/kv0xp8EJgVnPPXSned1Ob2G4pmLHh7HOhVC+73w9L5X9PuFng4QN+YGMWGHG2F+w4N0GyDbLA3jBe9VUps2ROqRz+QVj9DERzaWrKpblI0dTwShcfkzzOXov0oN8lcLZ+Lzg+I8CIfBqvZ+0LaR1TL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-79-684663e3556d
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [PATCH net-next 5/9] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Mon,  9 Jun 2025 13:32:21 +0900
Message-Id: <20250609043225.77229-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/Y8e/e6nLytqDejxIUZXazE5EAXgi4834r6EgnZ0rc2csvm
	JRUCSyOT1NDCnDOmos4LLVa6rautkWlGsdLWVZ0XCrpuNZ0GtWVS3378z/93zpfDYvlZcSSr
	1mYKOq0yTcFIifRTeO3qkZQdqrVnvCIwmNsYaJ3IgaZBmxgMLR0IvgdeS8Dn7GKgvtaPwfCk
	kMAP8ySG0QceCQw0jhG4dcaKwVP2kIGSwikMp2wmETztKBXDhckGDNb8QQk8u2Fg4F3bLzGM
	OUoIdOubCQyUboEHxvngf/QRgdNsFYH/XA0DFS4jA8OFAwhc9z0Eqk+WIjDfcYthasLAbImm
	15tfiqhd/1ZCjZYses20gha7XZhaWs4y1OItl9A3/bcY+vDSFKF2m09ESwo+M/Tb6CtCv9zp
	Y6j5eh+hvUanhPosS3Zx+6QbU4U0dbagW7P5gFTV29ZD0mvCcnpqLDgfDUmKURjLcwn88/HT
	ohl2t7qYEDNcLO92B3CI53HreJ+nixQjKYu5z2J+1DD1R5jL7ecn6nx/mHAx/MvOYRRiGbee
	bx4y/T0Qxbde7QwuYtkwLpEfdGeGYnmw4nhuwtP1OXx31QgJVXDwrvmyPBTjoFnQXo2nt9Sy
	fOGHmGleyN8zucl5xOn/s/X/bP1/thHhFiRXa7M1SnVaQpwqV6vOiUs5qrGg4IM0nviZZEPe
	p3sciGORIlx2oHK7Si5WZmfkahyIZ7Finowb2KqSy1KVuXmC7miyLitNyHCgRSxRLJDF+4+n
	yrnDykzhiCCkC7qZqYgNi8xH5JAnOWrNe/zqyTHvLF/S7vgXllhpnrypu5RG9PujV9U3LFZl
	aUdvBvTD7afaI6LKvwYGvY1VuKu57Eoc7EXVRTcnx/lAR1/ecntR/3hi58qdm1jzRbX1Lj40
	dhAlFkfeXvrxsWYTVxdzuPJ7EaooeFw227/t0+L0crsTb1imIBkq5boVWJeh/A2gjatAHAMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/77pyz1eK0LA8JJouKjLRC44kuCGUeIqL6UhSVww5tqNM2
	NQ0iTSsSNbNAmzOWpm5OWq2LFyRiiuUFlFmxstzcVCrKLtYyLWrrQn778X9+z//58rBY8Y4s
	YjXaDFGnVaUoaRmR7dyQv8qXtE29eqhiLRhtjTRYJ7Oh3tMsAWPDPQSfvw0yMNHxkIaaa34M
	xr4CAl9sUxhGO70MuOvGCLSda8LgvfCIhuKCaQynm80UtFd1SaD/XokELk/VYmjK9TAw0Gqk
	YajxpwTGHMUEugwWAu6SOOg0LQR/z1sEHbYmCvxFVTRccppo8BW4ETjbvQQq80oQ2O67JDA9
	aaTjlMIdyzNKaDG8ZASTPVO4bY4UCl1OLNgbztOC/VMZI7x42kYLjyqmidDSPEEJxfnjtPBx
	9DkR3t9/Qgs1rz5Qgu3OEyL0mjqYXfP2yzYeEVM0WaIuenOiTN3b2E3Sq6TZ3VV2nIuGmUIk
	ZXkuhndZnXSQaW4573J9w0EO4dbwE96HpBDJWMyNS/hR4zQVHMznDvGT1RO/mXBL+WcPfCjI
	ci6Wtwyb/5Yu5q03HwSKWFbKreM9roxgrAgojsdm/Eefx3ddGSFBBQfu2q4qgjEObObfrcSl
	SG6YYRn+W4YZlgnhBhSi0WalqjQpsVH6ZHWOVpMdlZSWakeBJ6g7+f1iM/o8kOBAHIuUc+SJ
	5fFqhUSVpc9JdSCexcoQOefeolbIj6hyToi6tMO6zBRR70BhLFGGyrfvFRMV3FFVhpgsiumi
	7t+UYqWLclGnvy/mZHnLyMCZ41/zah0QetNoqdNWn9oST+2JYJLlc2+PlBI/ZIf3tHdaxdb6
	oll9bQdeL3sznt/CVzDh0Wcpaxml3dHgmb2kRqwePHgjduuFrT57aCVYVkZIM+fX/sy5vuyW
	V3Wqf315MkqY2rfph0eyYLehdcWxsLwpX5SS6NWqNZFYp1f9AnIt69gAAwAA
X-CFilter-Loop: Reflected

The current page_to_netmem() doesn't cover const casting resulting in
trying to cast const struct page * to const netmem_ref fails.

To cover the case, change page_to_netmem() to use macro and _Generic.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 2687c8051ca5..65bb87835664 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -195,10 +195,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
-{
-	return (__force netmem_ref)page;
-}
+#define page_to_netmem(p)	(_Generic((p),			\
+	const struct page * :	(__force const netmem_ref)(p),	\
+	struct page * :		(__force netmem_ref)(p)))
 
 /**
  * virt_to_netmem - convert virtual memory pointer to a netmem reference
-- 
2.17.1


