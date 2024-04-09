Return-Path: <bpf+bounces-26276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B49689D8A0
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B316AB22C93
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300312A14C;
	Tue,  9 Apr 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="spjHKH+J"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6B129E7D;
	Tue,  9 Apr 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663960; cv=none; b=GdmPlfhKHs6uPNLQ1JXNto4AfL6dRzT+AMbU6u3VG9nnKW/b5mRERRuSTv7esRZJQ47JiK8or4DvQTir0kYFHX8GkkHsu+sFtSIBW/1ZaJYh63nja5l0uI3gkljLwm0uiVl4DrhqFGF38m7fQDquCInGL42mIVIItWR1/eL0dDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663960; c=relaxed/simple;
	bh=In4ySCQtNTNmF/RKIYRC+UVR5wUKNrk4cFtiqcQYyqk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OP8tDpQzfyAPqFRPTKg3oviFpGVplNcYC9Wrh7CFr1wB5sQmUUwtQEzuFspppzmu72Gw/c7s4Jdrwq3yk2XL5l4nVe6UQboGPET+lAMxaLAh1IvnWFRa40daNT+Uog5nffQWeaQTY7ZhY5i3+8XkcyBAMop+eBbcJtVOxREIXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=spjHKH+J; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712663949; bh=In4ySCQtNTNmF/RKIYRC+UVR5wUKNrk4cFtiqcQYyqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=spjHKH+JwM4B3XuXWyFkzbZPrOUwPJemLl0Fm8FQaKWk7kQC5MOQhBccUjcKqwodJ
	 oMV0Lo3pM01eIz2gYGjXpJfjOWtz5ywZJzOGoQlJphZ3zVPTCE7Gu4Shx2Eyt6CI65
	 mxG/+q9XxM9xP6f1DY1zfejHbKCoewlq/fhzhv/g=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id D3217424; Tue, 09 Apr 2024 19:52:50 +0800
X-QQ-mid: xmsmtpt1712663570t7p4c6isc
Message-ID: <tencent_5799EEDAEEE0CC88E7D506FA12F686584906@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2UwlZ0q6Cy/YMsu6pFBIhEgFPtPxkuKVvGfVQlDpybRgY1BE3mt
	 8ec2U/t4U8OlBc180umpRei7AYMBp9tBDia1n9N7VCFESxnoG8OR9apuEzyD+mkycaLiYcHllgZx
	 iEntrNc62fMM0W5RQERbT3E4CcArUWfJAxvZhMLjMuEvpUKPAJHupZwrcSwdmjeUz3c0N4pK7rX9
	 oNqKHUCj7nJ512ylZYOqJ2onQrDdSEEOFbyaF/qw49/Mvqgx1F7ubkFPNOL/0dqJ0M4eY2KdG5tt
	 wRU1Oczq28KczDGo6uUjQ5Uqttmy1h8qzDZwCbGD0uqxP8WYDTo5umQLuTQoPi9UiOBeo8djYWiM
	 JZOzYI3o9FRYucYkLzZeQ29AHfjhuFe51gNtE11vqwCu6BTODQvpM0TrCvCixQ0LFvAzpYfESAvm
	 7zSfb60PgWLdNgjDmFWyDO5z0VCXDQ5t7FR1ikBJ4Plyj1aC7Db0yYeisdPCUXkXjlQntn3uw+pl
	 cxGnmkdvwZZV6Eq/v5Ai86GepvjZX4IskqLEcM7MD43/be4GJZT5USfI5t093YRer/XnkxxMM/Ko
	 ozf9vF+19IXHNZQlsDU57aIQKD/d3ltAaSSoRf0Lj5BllkI7vkc1/ftc16Fb5mVefGH+aGP5Rxru
	 DLRBnJvodQY45xDN9ifCWDE9LBNvFGysj6IXXuYpEJqJb8U5wQIOVAHQkE52kvZWN7PcHMNSJMCe
	 KO6RuEaFP9htszLYgUp3NHQOO/V68U6i0UrZxbVY2TZbjHNMs7sJNFrsJN+EFCukIHOO4qjhC9Xy
	 zDNrJogLm8OhBaFxIKWiiz6FJdbtvliafgOn4V4j0UVTojqwvgEC7TmBcQNkOUPUMtY/R6+Vd8nn
	 81RSrBWZFH1QZnA4pEONWsbh5N3L4I9ZkTNxQ5KN6MDYmQVk6APrO2TEjyQbheZ7l1FyGmkhYSn7
	 Xb7dr7nk4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: fix uninit-value in strnchr
Date: Tue,  9 Apr 2024 19:52:51 +0800
X-OQ-MSGID: <20240409115250.4070106-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_AABA5D95191FCFD28DB325F58D8212525D07@qq.com>
References: <tencent_AABA5D95191FCFD28DB325F58D8212525D07@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch title is incorrect. It is used to fix errors using strnchr.


