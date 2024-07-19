Return-Path: <bpf+bounces-35088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC093793B
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 16:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D1D282FF2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16D1DDEA;
	Fri, 19 Jul 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZIA3bthm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKMIrVGx"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE348C06;
	Fri, 19 Jul 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399709; cv=none; b=RfYNc9jdLj0aYBQGhmTUKlYWtD6Lw1jDxbrWfqHK62xljgU8QLOqE65rLWyUrUgoqVsp/qEcEre9PGEZQj+oRwCpjIG/WU1ysrLYiEW21WsI6RzbeS7wU8ROZdq9OkIs6ZKrQuXyuNqaPzHNBdlD8pOZxvjrY2/2TOW5e8wlcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399709; c=relaxed/simple;
	bh=tyAQe/EfEJJHcnD5dtL2emqIovHzT7AAIlE7GinW8GU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jcUfo17rNfM7ZqUcS9/ixQTi+UAXSiHcL1WohwHoTZL/8G9pjRvMobg71G0vbbSTam1DfyeLOYCQCWf+p2wsnSBIWvKaBjAbw6S05ujOZpkMpXRVlSNHkTLSBsuOEoQAl7pcqOkcRmWG0q7J+Dz7mn7OULihERD6nafhYW9OncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZIA3bthm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKMIrVGx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8C1D611401E4;
	Fri, 19 Jul 2024 10:35:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 Jul 2024 10:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721399706; x=1721486106; bh=+pDjJzk46X
	NCmLJX63+/UBn/1WFcrH3qIe4s6/MvXE4=; b=ZIA3bthmBOxH5lScItSGfzOG8E
	HlVVQ+dJ6EcOId1ze0fYeTUXpHc9IInafG20JEq16EMYT0mE3dSibNgEbT27FYrn
	/7x1mgCKnXhEOp2drsflnqpayh3bB+dYYQuly41Li9Vbb5WCY9RwUITOrh6c9/5P
	hcEAuoclKHBK0FjZOh+Z1+D2Ozt7bPOQlb3RYjJxOml6StldQcdN8E4hHsNKV+ou
	JdqJgzR2SBS/vYKOyo2WQnJ3RdTWVNFOjjpZVDeOOV6W+AEPQYxoiPzmyw2ij+UE
	Vmumsh/ensOZB+rV2wZzBgapSMbzcA9PsqLg+NStVMGoqh6vq+HvAeQLausg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721399706; x=1721486106; bh=+pDjJzk46XNCmLJX63+/UBn/1WFc
	rH3qIe4s6/MvXE4=; b=EKMIrVGxrjJ1EeLuzMIeie+CqYrd/ObUIBPVQMHOMI9W
	S5cY9dcT1n3SqmypMHE4ZQI3VkikmQTAK5g8ouLm44qO86fX0G5Khv4fNnvtizh1
	6Nlo9FIk7DI7okjwIMWHFMvQMND5/UjzneF0lYVSOyoEXpsMT3wMNtkqyzBLVJ8V
	Mpf0VkZttuGZv7vuBwfIXTYANAeMwhvO4LKTtnKEUr4up5chHoVLg4bHlyaQO9HJ
	1qGXaUSqiSMAUaeMZfMhefVxIYdoBwQV+y23s9mlaM/hVYpGmUijVeltBjLSnYSY
	KHCxUDnGeRD84+ktw86fHo3aGuSAKEsqztq0WhiNRA==
X-ME-Sender: <xms:mnmaZk1iZgV5HcbxaKshfnEqQF2lwb8fnmNo0AKxRNOJwt2rlqMUww>
    <xme:mnmaZvEk2_XYrjpyu5JyWi-6KKhRYuMwM2j9qe6inEK2WV9i7Hd-lj9pqANjUoD6E
    Gr1sHSmUNehaJOq2jY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:mnmaZs6YC5We23Gksx7WXlln3ojfmdBr5ID-5daqaSv_v2p-mipEpA>
    <xmx:mnmaZt2PBKi9bBd5X_NY-KJbopoWXn_1j-fDw5R5KlsSqtjWi85blw>
    <xmx:mnmaZnGTMSUlKImXy-rE1sunRI7q7NccDkXddWYBYVun7cY6x_3uKA>
    <xmx:mnmaZm_ppcucO3DYt4H1Okbg2Jji_LNCVa13t41jBFSd9KLSHyM0tA>
    <xmx:mnmaZs70FEIkW7KrYika46n4gUckf_Eczwwxm-K3yXA8AMtQtmmSW09q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 25751B6008F; Fri, 19 Jul 2024 10:35:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96a00b6f-eb81-4c67-8c4b-6b1f3f045034@app.fastmail.com>
In-Reply-To: 
 <gf7t6iyj3ueewvbbmqo2ypzitiy6bvnzj2l6tgccvi22xe5fgm@xvlbq3vkndgr>
References: <20240719095117.3482509-1-arnd@kernel.org>
 <gf7t6iyj3ueewvbbmqo2ypzitiy6bvnzj2l6tgccvi22xe5fgm@xvlbq3vkndgr>
Date: Fri, 19 Jul 2024 16:34:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Benjamin Tissoires" <bentiss@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jiri Kosina" <jikos@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] hid: bpf: avoid building struct ops without JIT
Content-Type: text/plain

On Fri, Jul 19, 2024, at 15:52, Benjamin Tissoires wrote:
> On Jul 19 2024, Arnd Bergmann wrote:
>> 
>> This could be avoided by making HID-BPF just depend on JIT, but that
>> is probably not what we want here. Checking the other users of struct_ops,
>> I see that those just leave out the struct_ops usage, so do the same here.
>
> Actually, if we make the struct_ops part only depend on JIT HID-BPF is
> kind of moot. All we could do is use HID-BPF to communicate with the
> device, without getting any feedback, so nothing much more than what
> hidraw provides.
>
> The only "interesting" bit we could do is inject a new event on a device
> as if it were originated from the device itself, but I really do not see
> the point without the struct_ops hooks.
>
> So I think struct_ops is now the base for HID-BPF, and if it's not
> available, we should not have HID-BPF at all.
>

Ok, got it. So my original patch was correct after all.
I had tried this version and then discarded it.

    Arnd

8<------
Subject: [PATCH] hid: bpf: add BPF_JIT dependency

The module does not do anything when the JIT is disabled, but instead
causes a warning:

In file included from include/linux/bpf_verifier.h:7,
                 from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
drivers/hid/bpf/hid_bpf_struct_ops.c: In function 'hid_bpf_struct_ops_init':
include/linux/bpf.h:1853:50: error: statement with no effect [-Werror=unused-value]
 1853 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
      |                                                  ^~~~~~~~~~~~~~~~
drivers/hid/bpf/hid_bpf_struct_ops.c:305:16: note: in expansion of macro 'register_bpf_struct_ops'
  305 |         return register_bpf_struct_ops(&bpf_hid_bpf_ops, hid_bpf_ops);
      |                ^~~~~~~~~~~~~~~~~~~~~~~

Add a Kconfig dependency to only allow building the HID-BPF support
when a JIT is enabled.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
diff --git a/drivers/hid/bpf/Kconfig b/drivers/hid/bpf/Kconfig
index 83214bae6768..d65482e02a6c 100644
--- a/drivers/hid/bpf/Kconfig
+++ b/drivers/hid/bpf/Kconfig
@@ -3,7 +3,7 @@ menu "HID-BPF support"
 
 config HID_BPF
        bool "HID-BPF support"
-       depends on BPF
+       depends on BPF_JIT
        depends on BPF_SYSCALL
        depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
        help

