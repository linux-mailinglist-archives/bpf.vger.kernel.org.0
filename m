Return-Path: <bpf+bounces-75578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 87112C89935
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 12:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E741356128
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5DE3233ED;
	Wed, 26 Nov 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8Hruosi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08F258EC2;
	Wed, 26 Nov 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157339; cv=none; b=XAM/JggVZiW/vYZ8jGWJSMPmqpc/tclcnWYtgc7m5bVEHL8G3qADRhq/hix0ODQ2iE443UN4rji1YRtPjNcqcfkQEM4Uy1vu6va+Eoszn1T+BTy4SF5hIK894s6qeAxRHrOpP8g1MXzAkHxsRrsP8eOXQmCudCxst0uXBAPkQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157339; c=relaxed/simple;
	bh=ZnY10zD1Mb41gNbG0bf+pBq1hdEtGoHfH3E9Z9a1sIQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ZkisGvCV6HaNXsah+zFKQspsmIEpxES5oZpRYFNNYxa1WJymMomPOC2caxwNuyQAHyIVGqCegwoOdoQYDufn7u0m4E3Avsj2CgXf5p9DPFKx9QUIQHrheg0l63IRIb70hieH8aoRbRzTkYuwl2UbbR0/M/XsqpmH+Zhz9pV8zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8Hruosi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CEC113D0;
	Wed, 26 Nov 2025 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764157339;
	bh=ZnY10zD1Mb41gNbG0bf+pBq1hdEtGoHfH3E9Z9a1sIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M8HruosiZHZVst5/WS2ES7TmYyAlH3LTb9YCDOC6l5G65y9wN+qIaZ2tQWaUakhER
	 wYuJP0Z1BIl3CZppUjtXxb1SRKXlfCYYvQlqVoXeKOi/L6rcM4N8KJbJHgfHnsy1MD
	 3T6sBOjZ+vlot7cxLB0h9cRKBFhcLLtbULpuMQATjTVDD9OaQvtgLbiYktp7vO+1Zs
	 qSlMLrDv9VcCrsWqQsKurdjajULoSpSvE5vrN0Y/dJleKKzV3edKOnhJOM9NwGi8UF
	 BmWvPw4kL/mKafiyj4dfnjZe4L9oZ72t7+iQ647GtxWhWIpw4eLoXOwZhAmH7rhz86
	 pMrYVUmolOvFQ==
Content-Type: multipart/mixed; boundary="------------UWG0vp2NYMBQVi0Be2Vqk0TQ"
Message-ID: <eb4eee14-7e24-4d1b-b312-e9ea738fefee@kernel.org>
Date: Wed, 26 Nov 2025 12:42:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor
 number: manual merge
Content-Language: en-GB, fr-BE
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: csmate@nop.hu, kerneljasonxing@gmail.com, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 john.fastabend@gmail.com, magnus.karlsson@intel.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
References: <20251124171409.3845-1-fmancera@suse.de>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251124171409.3845-1-fmancera@suse.de>

This is a multi-part message in MIME format.
--------------UWG0vp2NYMBQVi0Be2Vqk0TQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 24/11/2025 18:14, Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
> 
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.

FYI, and as predicted by Jason, we got a small conflict when merging
'net' in 'net-next' in the MPTCP tree due to this patch applied in 'net':

  0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")

and this one from 'net-next':

  8da7bea7db69 ("xsk: add indirect call for xsk_destruct_skb")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side [1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, the patch from 'net' removed two functions
above one that has been applied in 'net-next'. I then combined the two
modifications by removing the two functions and keeping the new
attributes set to xsk_destruct_skb().

Rerere cache is available in [2].

Cheers,
Matt

1: https://github.com/multipath-tcp/mptcp_net-next/commit/1caa6b15d784
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/265e1
-- 
Sponsored by the NGI0 Core fund.

--------------UWG0vp2NYMBQVi0Be2Vqk0TQ
Content-Type: text/x-patch; charset=UTF-8;
 name="1caa6b15d784769d23637d9c5dae18ddc4bd8b39.patch"
Content-Disposition: attachment;
 filename="1caa6b15d784769d23637d9c5dae18ddc4bd8b39.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC94ZHAveHNrLmMKaW5kZXggYmNmZDQwMGU5Y2Y4LDY5YmJjY2E4YWM3
NS4uZjA5M2MzNDUzZjY0Ci0tLSBhL25ldC94ZHAveHNrLmMKKysrIGIvbmV0L3hkcC94c2su
YwpAQEAgLTU2MCw1MCAtNTkxLDQzICs1OTAsNDIgQEBAIHN0YXRpYyB1MzIgeHNrX2dldF9u
dW1fZGVzYyhzdHJ1Y3Qgc2tfYgogIHN0YXRpYyB2b2lkIHhza19jcV9zdWJtaXRfYWRkcl9s
b2NrZWQoc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsCiAgCQkJCSAgICAgIHN0cnVjdCBz
a19idWZmICpza2IpCiAgewotIAlzdHJ1Y3QgeHNrX2FkZHJfbm9kZSAqcG9zLCAqdG1wOwor
IAl1MzIgbnVtX2Rlc2NzID0geHNrX2dldF9udW1fZGVzYyhza2IpOworIAlzdHJ1Y3QgeHNr
X2FkZHJzICp4c2tfYWRkcjsKICAJdTMyIGRlc2NzX3Byb2Nlc3NlZCA9IDA7CiAgCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7Ci0gCXUzMiBpZHg7CisgCXUzMiBpZHgsIGk7CiAgCiAtCXNwaW5f
bG9ja19pcnFzYXZlKCZwb29sLT5jcV9sb2NrLCBmbGFncyk7CiArCXNwaW5fbG9ja19pcnFz
YXZlKCZwb29sLT5jcV9wcm9kX2xvY2ssIGZsYWdzKTsKICAJaWR4ID0geHNrcV9nZXRfcHJv
ZChwb29sLT5jcSk7CiAgCi0gCXhza3FfcHJvZF93cml0ZV9hZGRyKHBvb2wtPmNxLCBpZHgs
Ci0gCQkJICAgICAodTY0KSh1aW50cHRyX3Qpc2tiX3NoaW5mbyhza2IpLT5kZXN0cnVjdG9y
X2FyZyk7Ci0gCWRlc2NzX3Byb2Nlc3NlZCsrOworIAlpZiAodW5saWtlbHkobnVtX2Rlc2Nz
ID4gMSkpIHsKKyAJCXhza19hZGRyID0gKHN0cnVjdCB4c2tfYWRkcnMgKilza2Jfc2hpbmZv
KHNrYiktPmRlc3RydWN0b3JfYXJnOwogIAotIAlpZiAodW5saWtlbHkoWFNLQ0Ioc2tiKS0+
bnVtX2Rlc2NzID4gMSkpIHsKLSAJCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwb3MsIHRt
cCwgJlhTS0NCKHNrYiktPmFkZHJzX2xpc3QsIGFkZHJfbm9kZSkgeworIAkJZm9yIChpID0g
MDsgaSA8IG51bV9kZXNjczsgaSsrKSB7CiAgCQkJeHNrcV9wcm9kX3dyaXRlX2FkZHIocG9v
bC0+Y3EsIGlkeCArIGRlc2NzX3Byb2Nlc3NlZCwKLSAJCQkJCSAgICAgcG9zLT5hZGRyKTsK
KyAJCQkJCSAgICAgeHNrX2FkZHItPmFkZHJzW2ldKTsKICAJCQlkZXNjc19wcm9jZXNzZWQr
KzsKLSAJCQlsaXN0X2RlbCgmcG9zLT5hZGRyX25vZGUpOwotIAkJCWttZW1fY2FjaGVfZnJl
ZSh4c2tfdHhfZ2VuZXJpY19jYWNoZSwgcG9zKTsKICAJCX0KKyAJCWttZW1fY2FjaGVfZnJl
ZSh4c2tfdHhfZ2VuZXJpY19jYWNoZSwgeHNrX2FkZHIpOworIAl9IGVsc2UgeworIAkJeHNr
cV9wcm9kX3dyaXRlX2FkZHIocG9vbC0+Y3EsIGlkeCwKKyAJCQkJICAgICB4c2tfc2tiX2Rl
c3RydWN0b3JfZ2V0X2FkZHIoc2tiKSk7CisgCQlkZXNjc19wcm9jZXNzZWQrKzsKICAJfQog
IAl4c2txX3Byb2Rfc3VibWl0X24ocG9vbC0+Y3EsIGRlc2NzX3Byb2Nlc3NlZCk7CiAtCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvb2wtPmNxX2xvY2ssIGZsYWdzKTsKICsJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmcG9vbC0+Y3FfcHJvZF9sb2NrLCBmbGFncyk7CiAgfQogIAog
IHN0YXRpYyB2b2lkIHhza19jcV9jYW5jZWxfbG9ja2VkKHN0cnVjdCB4c2tfYnVmZl9wb29s
ICpwb29sLCB1MzIgbikKICB7CiAtCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAtCiAtCXNwaW5f
bG9ja19pcnFzYXZlKCZwb29sLT5jcV9sb2NrLCBmbGFncyk7CiArCXNwaW5fbG9jaygmcG9v
bC0+Y3FfY2FjaGVkX3Byb2RfbG9jayk7CiAgCXhza3FfcHJvZF9jYW5jZWxfbihwb29sLT5j
cSwgbik7CiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvb2wtPmNxX2xvY2ssIGZsYWdz
KTsKICsJc3Bpbl91bmxvY2soJnBvb2wtPmNxX2NhY2hlZF9wcm9kX2xvY2spOwogIH0KICAK
LSBzdGF0aWMgdm9pZCB4c2tfaW5jX251bV9kZXNjKHN0cnVjdCBza19idWZmICpza2IpCi0g
ewotIAlYU0tDQihza2IpLT5udW1fZGVzY3MrKzsKLSB9Ci0gCi0gc3RhdGljIHUzMiB4c2tf
Z2V0X251bV9kZXNjKHN0cnVjdCBza19idWZmICpza2IpCi0gewotIAlyZXR1cm4gWFNLQ0Io
c2tiKS0+bnVtX2Rlc2NzOwotIH0KLSAKIC1zdGF0aWMgdm9pZCB4c2tfZGVzdHJ1Y3Rfc2ti
KHN0cnVjdCBza19idWZmICpza2IpCiArSU5ESVJFQ1RfQ0FMTEFCTEVfU0NPUEUKICt2b2lk
IHhza19kZXN0cnVjdF9za2Ioc3RydWN0IHNrX2J1ZmYgKnNrYikKICB7CiAgCXN0cnVjdCB4
c2tfdHhfbWV0YWRhdGFfY29tcGwgKmNvbXBsID0gJnNrYl9zaGluZm8oc2tiKS0+eHNrX21l
dGE7CiAgCg==

--------------UWG0vp2NYMBQVi0Be2Vqk0TQ--

