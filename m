Return-Path: <bpf+bounces-61491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C8AE75FD
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12E44A0AB9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591BB20C00D;
	Wed, 25 Jun 2025 04:34:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413781E00A0;
	Wed, 25 Jun 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826050; cv=none; b=t4nXRO1Y+Nl00cGOq3m+hYea+C1v/BLeLW1Ps1t99rdRA9BHudDTZ2bFByEIo+FJbdi/hhAnA+YinnM2LB20uYc9D57MyeMU70vLZOITm1UHhCAg4bxHG0hoksbRP96rq1J7O4rV8U0p77ptVV/IYVQCWVzRSF2zI89xwL5uCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826050; c=relaxed/simple;
	bh=fHXd1CHV5Rrj3/flHARgBJsR+7SIqdmHhmh1mD0f75Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuxBi225OiOLamSUzTiYxFZ98zha2s85Vdpy3ffoJVbQHZFfnqvmEfiEozjnKhKOrZfz50U3KyRLsOP9AjwYU9A6/Ng2+xDMuwAMsUL0S9pqb7gIgaisY5b7O1eB61YXxk73dn17E6Ym8vH3F1JeOPI8tbVaILjNrQjI/uVhwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-27-685b7c397fc2
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v7 7/7] netmem: introduce a netmem API, virt_to_head_netmem()
Date: Wed, 25 Jun 2025 13:33:50 +0900
Message-Id: <20250625043350.7939-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250625043350.7939-1-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++9/ds5xuDgtq9NFkmEWiyzL6u2KUMQ/IohuH+xDjjy40Vwy
	02YUzNQicUu6kXPVMrKpk8lcusJuc2pR0TCKlXlh1QryglnLS2WbEvnt4Xl/z/O+H14Wy8rE
	81i19qig0yo1clpCSfqiK5atO3FAtaKoNBYsDjsNNcN6uN3jFoOlugHB95EOBoa8bTTcvBHC
	YHlZSMEPxyiGT60BBmqcO6G7MkhB05lGDIFzT2gwFo5huD/Sz8Apt00EvgaTGC6O3sLQaOhh
	4NU9Cw1d9nExBD1GCp6aqyjoNqVAq3U2hJ71IvA6GkUQKrlKw4V2Kw0fCrsRtDcHKCjPNyFw
	PPCLYWw43FHe0sWkxJPm3gFMXFVvReSuuZMhVmcOqbcpSLG/HRNn9VmaOL+dZ8j7N000eXJl
	jCJ33UMiYizop8ngp3cUGXjwmiYO12uKPLd6mV0zUiUb0wWNOlfQLd+cJlFZO7uZrJYovavC
	hA3IwBajKJbnknnTjz9UMWIn9Gl3RsSmucW83z+CIzqGS+KHAm1hRMJirpbmvfYOJjKYye3n
	62y3JyCKW8TfsgfFES0N9xg6eujJ/oV8Td2jCSaKW81bAgVURMvCTNGbfDzJz+Cfln2cuAGH
	FzuuySI2DkcL7pTjyF6ec7O8sXYcTXbO5R/b/FQp4sxT4ub/cfOUuBXhaiRTa3MzlWpNcqIq
	T6vWJx46kulE4YepPPnrgBt98+3xII5F8mjpiqJUlUyszM3Oy/QgnsXyGOnltWFLmq7MOy7o
	jhzU5WiEbA+az1LyOdKVoWPpMi5DeVQ4LAhZgu7fVMRGzTMgq6lheNXX9dPJloqeUH7TuClp
	/te5X9wuU/Dhhke+ynhF/++iOPFIsK5Tsax9MGGNvSJR3SXs09T5ljPStJJpL2dl7Y7rvef2
	HfNeTHjh3xqXdmmpaFOzLXk7n6iNXVJ23TXQd//sXj2b8vFhSCk17visr27ZtmCwqs/ys3FP
	fY6cylYpkxRYl638C/6lrRosAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUiTcRTG++//fjmavS2tV0OFgZRSppB4Iim7kF6CyrrIMkpHvrXhnLKl
	aRTMz0hy9ik1V01NM11N1soVaqJWSqGiKFPTyVLpQvvSJJ1QWxF59/A8v/Occ3EYLHUTgYxS
	fVbQqOUqGSUmxAd2FmzdceG4IjJf7wtGi5mChp858HDCToKx/jmC+cVRGuY631JQXbmAwdhb
	SMAPyxKGqTcuGhqs+8FZO01A86UmDK6yLgpKC90YWhY/05BvrxNBx91uEvqe60m4uVSDoUk3
	QcPASyMF4+ZfJEy3lxLQbXhEgFMfB29M62Hh3QyCTkuTCBau3KXgRr+Jgo+FTgT9HS4CKvL0
	CCytDhLcPz0dFa/H6bhQvmPmC+Ztj4ZF/AvDGM2brFn807pwvsTRj3lr/WWKt36/TvMfhpop
	vuu2m+Bf2OdEfGnBZ4r/NjVC8F9aBym++tNXEW+xDRIJ0iRxbKqgUmYLmm27UsQK05iTznzt
	k2Or0mMd0jEliGE4djtXbD9TgnwYit3EORyL2Kv92ChuzvWWKEFiBrOPKa7TPEp7g3XsEa6x
	7uEfiGBDuRrzNOnVEk+PbnSC8mqODeEaGtv+MD5sNGd0FRBeLfUwRUN5+C+/luu+M0l4b8Ce
	xZZ7Uq+NPaMFzyrwVSQxrKAM/ynDCsqEcD3yU6qz0+VKVXSENk2Rq1bmRJzKSLciz0vUXly+
	ZkfzA3vbEcsg2WpJZFGSQkrKs7W56e2IY7DMT1Ie47EkqfLc84ImI1mTpRK07WgjQ8g2SPYl
	CilS9oz8rJAmCJmC5l8qYnwCdeiqO7Z4k3220jz8/nARmTzi74p3X8wpb6ulqlRKh+pW6HTX
	8hL+aNuzpifxYF/Q481hA7sl873DJzLVRwOcG4PMVb4Js/e3BAy0TM7GxhWvigmIhuDQyzUh
	trhVPdKTu5LuSx4E7w4TNp+uvH7MdU578hD55FydIWjk1WR82Y5kfxmhVcijwrFGK/8NmtA4
	EQ4DAAA=
X-CFilter-Loop: Reflected

To eliminate the use of struct page in page pool, the page pool code
should use netmem descriptor and APIs instead.

As part of the work, introduce a netmem API to convert a virtual address
to a head netmem allowing the code to use it rather than the existing
API, virt_to_head_page() for struct page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 535cf17b9134..c7b1fc4b6c28 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -314,6 +314,13 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+static inline netmem_ref virt_to_head_netmem(const void *x)
+{
+	netmem_ref netmem = virt_to_netmem(x);
+
+	return netmem_compound_head(netmem);
+}
+
 /**
  * __netmem_address - unsafely get pointer to the memory backing @netmem
  * @netmem: netmem reference to get the pointer for
-- 
2.17.1


