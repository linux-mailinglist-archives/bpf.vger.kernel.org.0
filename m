Return-Path: <bpf+bounces-46800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15849F021F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82657284857
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6708502B1;
	Fri, 13 Dec 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="LOs2VIg7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wm+ceT+a"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBE21345;
	Fri, 13 Dec 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053076; cv=none; b=tUN402Z0MfoFNUFR/NNShmY85isB0mGXut9JmOt6Jev5P6GKBV5Vx+ZmjUVRmgKDzX1RS+O0ohxQ1X9E/hlUEgfJtI49tT71gX72TM6MmebXYhpo1Ajcs4NZaWfYH9bIvWL4dFKrakNl00WDspAXjw4fTujO5V4B5Vqh8MJ+plA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053076; c=relaxed/simple;
	bh=xOJhmhJiPT7XucS+JvvOAwbDKJCLQ0uJS5LKiah0erk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC/V2Pv9ZeJ5XCuKhXLkAcp1lSMd08FklcriL8js9KgSiO/5p2eP+NNCmrFxWZH4+f/1hdtAZl66Dvz9tZhngt9y3eCjpapkziI81DTgtBZCxGP/WCBM8Y2UQeBTAz1lxsKwfTiLXu1QQRwG17hich5WLczdgECQ7oW8fFbExSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=LOs2VIg7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wm+ceT+a; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEB221140233;
	Thu, 12 Dec 2024 20:24:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 20:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734053072; x=
	1734139472; bh=1nIfMacAqxf+3GQ6nJo3PSByZmybpP146S5tZBDJZ8g=; b=L
	Os2VIg7DAVg7B5EyRxfr7IpsNHTExRLRIxdZNGxQnW2szVjSgwIUKEwBFVISb3Kp
	TtUczP5hJqDDCF6lf2d0yoOlgAlNkjhMI2uVQlLAcs5orG1e0J7TdiunTTv3yugt
	G8i0NAXdwHF35Lt6s6MzZg1Iwn6aogErT9uSUmVMpzHl1Elbcrgn02akQpqz0ypK
	2xPfuLjYb2YizAdPeqvLw6rQJ0+w7lmPCc+ppn4wtiHmveHxmkiQwl9rkT35DBT3
	uAtscjKIW9kil0o906VNnMQ/VsbycGHguAfqmsiouSDisPAdhL+OekN2EHv1+U3s
	5Vt6KE/IyNxvMhgcgaFGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734053072; x=1734139472; bh=1
	nIfMacAqxf+3GQ6nJo3PSByZmybpP146S5tZBDJZ8g=; b=wm+ceT+azr4sYf3uo
	3JvmiAcqRaFg59MmUpKQMd9u3PCos6pqjYnV2O1CqHk7awRJ0ncdnAY5375LHMd7
	5Hzp3CTpmy6DKMCqpRQsi2vx5Eqlt/Sgq7cqHIIXxW7N6he9nj+pH2ecJ1IEF56p
	SX/jFRaQghF+5hLNLeVe/OlWn0BPd04SifFNksG6zuEvEqXk7Ptg5U77ZAFkPXG7
	ST3fnYAc2+HzbA2Oy0yiqiXqDZc6Wz2vG6Frn/zZpG0IVYRAsLWMLMOKi+ER0r8c
	IAVpFQ2XTQN+QtRJL2Sy3Ah7n9ZTpbmVlpiG4MU0bRJaO9uTOEWH7wL3NjZpdc/z
	H6HSw==
X-ME-Sender: <xms:0IxbZ1kD-GpKKy3lQ_SgwK1eWS1G_B0BeZ2KAWoBDeIMlgoarcWR-Q>
    <xme:0IxbZw1_nepiHdwewtSppJA0gEJTxH9Xdu4jie_tTIuZjSQ-ViOfdNwWGVX5cQWQ7
    928cvCE4-Bj1zGPZw>
X-ME-Received: <xmr:0IxbZ7oekcLzrnuxG2Y2AR7UbBcnz_wov4F6JC99xC8zrzOCNg9r7dWMnN0L8Zb0kkG6PrbBMcGrwsbsTG3xXry7jP0HEn-I_ah0lvYX1qj62F6X9H1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehqmhhosehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehmrg
    hrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0IxbZ1mdwB0qR2RMdHxipdXv763is2JHHnCFyu1u6mtU4D4a0GcBEg>
    <xmx:0IxbZz25sDB8bJ1ccnCI6cJIWtR7Cz6PAVYeJNB4o_d_E6qMHkMoXw>
    <xmx:0IxbZ0tJzqxyOe8oF99dZuc9osD1adAgJ7JJYF4x3EupuJdWej2ztw>
    <xmx:0IxbZ3UocPc4-2rv59sUHTjl39oPEcswQ6wpgyN1qwzqzDVoNIeYRw>
    <xmx:0IxbZ6u05JHd4xoCct2ASxu3ieTLVQ5UC0eVp0UPd-l2k7y0qs7I_K-l>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 20:24:30 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v4 1/4] bpftool: man: Add missing format argument to command description
Date: Thu, 12 Dec 2024 18:24:13 -0700
Message-ID: <d5ca200da5a39f31ed34b9b90772e17476764f50.1734052995.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734052995.git.dxu@dxuuu.xyz>
References: <cover.1734052995.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command description was missing the optional argument. Add it there
for consistency with the rest of the commands.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 3f6bca03ad2e..245569f43035 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
     that hold open file descriptors (FDs) against BTF objects. On such kernels
     bpftool will automatically emit this information as well.
 
-bpftool btf dump *BTF_SRC*
+bpftool btf dump *BTF_SRC* [format *FORMAT*]
     Dump BTF entries from a given *BTF_SRC*.
 
     When **id** is specified, BTF object with that ID will be loaded and all
-- 
2.46.0


