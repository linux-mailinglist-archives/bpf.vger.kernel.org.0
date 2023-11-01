Return-Path: <bpf+bounces-13841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED667DE7C7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1472818A0
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4A11BDDB;
	Wed,  1 Nov 2023 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ikJERYTz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AehbrKHU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331B10A09;
	Wed,  1 Nov 2023 21:58:37 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC3110;
	Wed,  1 Nov 2023 14:58:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9C5D332009F4;
	Wed,  1 Nov 2023 17:58:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Nov 2023 17:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1698875909; x=1698962309; bh=iHvV4xCaLT
	5/MQ/ZV/9e1rtl0TLVC998xFKkYBnpOgo=; b=ikJERYTztDLF/1z688Yvxbgwhc
	cnTUVG3+xXOjkUJ8rfYPbw/SByIGsKVnL8ohXE7wYh3vHhgf7rJXiPKyz3fTsEdL
	kBwAo3BhD5730yI2EYIx+LKN+4FrjPPIMvtmjhTbbIh2so3QQq0AJpmR3DhTLsJK
	2k4s7XhCyTbJJ5LTcLWtmv+IyQEPSumNXdQoR8GiR+NBQwoKTMORiPmI2+WcwYtM
	n+f4INyyyvRujvyqwW78gaCajQo/gyCUx7etmQFsP/7C3IW/6hMQy2c/lCVg+u1x
	KhNvtVhIt1qZJHL4rgfGdoiSp16s1AqEJ4JM+K0uxoiJdBX+F09RXsKISiug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698875909; x=1698962309; bh=iHvV4xCaLT5/M
	Q/ZV/9e1rtl0TLVC998xFKkYBnpOgo=; b=AehbrKHUy5roV1YSJo3D6cA/YH1MK
	OxLVS6h8sB+OAQ/BtLA73mgcucQeK5yQHgI2HB9oZrctQHQTT377bLARQh1TlvLw
	xIBVfXsIcHvo0w/jPeNt2HY2mye1jPNCck8W/KqHJ5NvVH97yQwaIPxL9ck4fsfx
	Hv5w98FJB2f1xz0UCYp3QujKM4gfrmrLCQOec06uGiJTaTRYYojec18JCoRRdRHD
	okaKqJbEaLGAillx6eVbO6Q7FTsM0lU6mTvUmBaPSQhoaAhSlwpggRuraEchh0hQ
	ATxU5bF/ha9N6IEMHGsm65jRQNTZn7eA+pL/VJEyghJydbYstm0uUqaMw==
X-ME-Sender: <xms:BMpCZabpuvGDgowagnwnkINVCEyTh5kCQcZzr7fWtMLwQVc_wIJ4TA>
    <xme:BMpCZda7fnt_ngY1qpjMdR5Lu2AcwtZpYl5k7wVrtv5zAKdKrIlDbjVf3k5iJqSEu
    Stuaz5LfsJ-booz0w>
X-ME-Received: <xmr:BMpCZU-WYCalgYkBQsWdys1B03jlgFyeKSoOAnU3gO-BTvOBg3dlDw3DI6cAe3WXaX9OCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:BMpCZcpl4nU_PbMXkDdtxPNogLrfqORT6TtCme3R5r_LKt8w19_A8A>
    <xmx:BMpCZVqXVNdgzF23j_J7mX_Tji2Pi8JjXZmIgZvqhZtT8ct9I-H2NQ>
    <xmx:BMpCZaTp3cI57Xw8gUJJkOaw7dCWDO6cCRN3jPp7KVOShiy45gqmSA>
    <xmx:BcpCZeAM0fDkQA8n0BIffVhHR8UJvDhNqvHjSl10a_eY2vhujgceNw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:58:27 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com
Cc: devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 0/7] Add bpf_xdp_get_xfrm_state() kfunc
Date: Wed,  1 Nov 2023 14:57:44 -0700
Message-ID: <cover.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
xfrm_state_put(). The intent is to support software RSS (via XDP) for
the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
on (hopefully) reproducible AWS testbeds indicate that single tunnel
pcpu ipsec can reach line rate on 100G ENA nics.

Note this patchset only tests/shows generic xfrm_state access. The
"secret sauce" (if you can really even call it that) involves accessing
a soon-to-be-upstreamed pcpu_num field in xfrm_state. Early example is
available here [1].

[0]: https://datatracker.ietf.org/doc/html/draft-ietf-ipsecme-multi-sa-performance-02
[1]: https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406

Changes from RFCv1:
* Add Antony's commit tags
* Add KF_ACQUIRE and KF_RELEASE semantics

Daniel Xu (7):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  bpf: selftests: test_tunnel: Use ping -6 over ping6
  bpf: selftests: test_tunnel: Mount bpffs if necessary
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: test_tunnel: Disable CO-RE relocations
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 ++
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 121 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    |  98 ++++++++------
 tools/testing/selftests/bpf/test_tunnel.sh    |  43 +++++--
 7 files changed, 221 insertions(+), 54 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

-- 
2.42.0


