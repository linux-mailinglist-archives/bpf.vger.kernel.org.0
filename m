Return-Path: <bpf+bounces-45901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B29DF091
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FA9B20C03
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558119CC29;
	Sat, 30 Nov 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtWhyN5S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5D1990C0;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973954; cv=none; b=XzHuedE8GWYTBVfnsGT2piSPC/RHZJUugXrZpTxJWjsViZT6rMbRmo16Oy7lk/OPgbVU7x8cD+XMs6j5BXSf2SI42BTI77PHeEr+jcOADrSmUi137iS35HqDGBthYL4amXSZIY69B8yZWz4Gok0okLlqB4ZlOocZk09Kg03tf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973954; c=relaxed/simple;
	bh=AtoMv+qZEg3Jrjb92TD+QP+vPH9tNZ1fEkpRkBwkvCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iEuMX3UjzHHjwsUepWWxIWbQlhe6yuiebjI6JoNJHKZvlxP19/qeKmCVZHKklgTgIw+OryTiWzS2q1QxuzX3F18mGORJlSb3E4Ftu9ywOM3v5bJSXchuAFMmcd4ueKU6RXia78zLxT/a4G60XNFOel9phI01GCyroDNWBpKXg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtWhyN5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D313C4CECC;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732973954;
	bh=AtoMv+qZEg3Jrjb92TD+QP+vPH9tNZ1fEkpRkBwkvCs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FtWhyN5SGodUWhs/LCaXDVaYgeAgHu957ETyuDh+cqKsAiU/Y/y7ZddQgta4Fr3Kn
	 dFWIT5SwX4Pku9jXBJNqZxzmXAUgu0NzHThNgvek0RVG9thWnhZ5+rj8FjOcxiIr3R
	 hI0ReOZV4veZIAaWmlgz6uh05Fg4gNODOm3BzeaVbzq5W/xUEK/dVLDXwmCA2bGYZw
	 X9QEs+kU0Lz25wJg8ftS7eFe2ukS3CCzWbaI7GPvbc/9uF6Sa6fSFUhfBr7fn3BMaj
	 bCxb8SGx0iNmIAxhg0nuLFG15QqudtXD4JSwNBuncuQ3iE4ABRQTIOJAKsQ2EZOtyJ
	 hq4byjdPNRUTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116ABD73607;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Subject: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
Date: Sat, 30 Nov 2024 21:38:21 +0800
Message-Id: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0VS2cC/x3MQQqAIBBA0avErBvQjMiuEi1Kx5pFJk5EEN09a
 fkW/z8glJkEhuqBTBcLH7FA1xW4bY4rIftiaFTTam0Uni7hkgIKRb/LiiEYZ33fUmcNlCplCnz
 /xxEinTC97wd7UFMuZgAAAA==
X-Change-ID: 20241130-tcp-bpf-sendmsg-ff3c9d84e693
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=AtoMv+qZEg3Jrjb92TD+QP+vPH9tNZ1fEkpRkBwkvCs=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnSxV3VGLEL49AHZ7R/d7EbVg6R8VkrJZM9QKxj
 wCbxoE/uROJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ0sVdwAKCRBvO5jUL8bJ
 2HlIEACiRItsYjOk5RJI2/JZUvDi3jlt5j1sj93UCDJRXYAm7dQQpxq38P+uHO3Iyxuz3kgIYfi
 uZmFtrsoU8/kikiFo+JFV7iMebGXZWugkcZFrZ2TpCWXvpKHd7bU/vwo9KhaeC0gQ2e0wsLI8Ee
 Y3DRi7EZyxX/mKIWzLxogiHDpT6esl6AslnH+sbdkIgeK9dpBtB1Ni+ligxBduKwgQDAKqM0MqX
 T1iQoTEAucGQXrAum66ejeeJ81quXXUKl1S/U+rJ0V1Yz2O3m6KZxy8Igz5nxcjbbe5hOHG3xm1
 JCgRW//D/ixRf4fy75vATRQp9tdQsSD/qp4AYBysk5LeBkvz88im03z2W7INhtzMwoONTwfG9ia
 rFQRjDvjfnXuTQ6v1P/3DGiXxPSK/VxAeScG5YTuUA62DcC1lZ38ToiL2wEdWfeSQmCd4lIBk8T
 aBZnwb3dlzy8eXrx/u6CNGIi8N9MWHuTvrdaEHwnXTZat2oLitWCc7ZT5Nmjw/IX7xWnVGKP/R9
 RmxOW/Xb5tBj2vpmViC61p3JFxeqvVVp4CWp0/3fJ2+pF+5MqusfPNAz17qLUifRFRWvdWFhR5J
 OG69JQPI8jYZnBJk3hqGtAgAo/OVeDy0Jl5TEiwte8qdOrbAwV9xptooTrXljidJ3iIs8FQNU4W
 +SqowYYutsCwnIg==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
test_sockmap.c triggers a kernel NULL pointer dereference:

BUG: kernel NULL pointer dereference, address: 0000000000000008
 ? __die_body+0x6e/0xb0
 ? __die+0x8b/0xa0
 ? page_fault_oops+0x358/0x3c0
 ? local_clock+0x19/0x30
 ? lock_release+0x11b/0x440
 ? kernelmode_fixup_or_oops+0x54/0x60
 ? __bad_area_nosemaphore+0x4f/0x210
 ? mmap_read_unlock+0x13/0x30
 ? bad_area_nosemaphore+0x16/0x20
 ? do_user_addr_fault+0x6fd/0x740
 ? prb_read_valid+0x1d/0x30
 ? exc_page_fault+0x55/0xd0
 ? asm_exc_page_fault+0x2b/0x30
 ? splice_to_socket+0x52e/0x630
 ? shmem_file_splice_read+0x2b1/0x310
 direct_splice_actor+0x47/0x70
 splice_direct_to_actor+0x133/0x300
 ? do_splice_direct+0x90/0x90
 do_splice_direct+0x64/0x90
 ? __ia32_sys_tee+0x30/0x30
 do_sendfile+0x214/0x300
 __se_sys_sendfile64+0x8e/0xb0
 __x64_sys_sendfile64+0x25/0x30
 x64_sys_call+0xb82/0x2840
 do_syscall_64+0x75/0x110
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
size(8192), which causes the while loop in splice_to_socket() to release
an uninitialized pipe buf.

The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
will copy all bytes upon success but it actually might only copy part of
it.

This series change sk_msg_memcopy_from_iter() to return copied bytes on
success and tcp_bpf_sendmsg() to use the real copied bytes instead of
assuming all bytes gets copied.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
Levi Zim (2):
      skmsg: return copied bytes in sk_msg_memcopy_from_iter
      tcp_bpf: fix copied value in tcp_bpf_sendmsg

 net/core/skmsg.c   | 5 +++--
 net/ipv4/tcp_bpf.c | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)
---
base-commit: f1cd565ce57760923d5e0fbd9e9914b415c0620a
change-id: 20241130-tcp-bpf-sendmsg-ff3c9d84e693

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



