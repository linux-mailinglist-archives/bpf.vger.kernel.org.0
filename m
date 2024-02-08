Return-Path: <bpf+bounces-21501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470F284DFF9
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 12:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BF1281F22
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A871B31;
	Thu,  8 Feb 2024 11:48:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CB6EB70;
	Thu,  8 Feb 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392912; cv=none; b=HT7fm0PU62Mctle1djWSlenHspymfWuCTvOY9JHAtfzgCuIL2evpAoZBfXer87CmFDVwO/ys+agg+JQCZwssBEx8ig6T+QwHYgn7Xigb2y6Wg/ZubT4lXMSSKnEQzk/L01pvGK6jHPzxn0+y0DcEjfveRRJRvGb3hxk8anS6PCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392912; c=relaxed/simple;
	bh=1P2tm3EYDhfOGtF0LkgV060qH1EYIgD1fPpolN912ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ET94NcUGUw1koJQbg3jpaL2f1emV05hOd9p4ZguoWg3eSIonv5Doh0W8XJ3sCGvRHvrYaKaXdFPjTno+JNnXgFBywuP02AtwRjpx4krzE8simAQvEeqGbe9cIssciMy4bUmeQa9woadXQ10HZOXffEjgZ9iAXyNDVpN10IV41jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.233.118])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TVwGq0M5lzfZ1C;
	Thu,  8 Feb 2024 14:48:18 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 0/2] bpf: cpumap: Fix memory leak in cpu_map_update_elem
Date: Thu,  8 Feb 2024 14:47:58 +0300
Message-Id: <20240208114800.27676-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigvhicurfgrnhhovhcuoegrphgrnhhovhesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepudehuefgveehffekleekleetteefvedtveeujeekvdetjedvtdeuueetjedtleeunecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrddujeejrddvfeefrdduudeknecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqdduheeijedtfedrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudejjedrvdeffedruddukeemgeefjedtvddpmhgrihhlfhhrohhmpegrphgrnhhovhesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghprghnohhvsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrd
 hnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrfhgrihesfhgsrdgtohhmpdhrtghpthhtohepshhonhhglhhiuhgsrhgrvhhinhhgsehfsgdrtghomhdprhgtphhtthhopeihhhhssehfsgdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.61.08090, Virus records: 12345016, Updated: 2024-Feb-08 09:34:35 UTC]

Syzkaller reports "memory leak in cpu_map_update_elem" in 5.10 stable release.
The problem has been fixed by the following patches which can be cleanly applied
to the 5.10 branch.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.


