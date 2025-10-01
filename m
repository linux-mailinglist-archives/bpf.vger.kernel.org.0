Return-Path: <bpf+bounces-70069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F46BAF209
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 07:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715551940785
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C252D8364;
	Wed,  1 Oct 2025 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="muuPLZqv"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69D42056
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295314; cv=none; b=h4E03lnsz176z7jGlt4n4OmJPTgsNmT5Vnl+UWjxU2WmNJ/HQBuS/dE1Ji0isUaHkR2pxmMs/LJBXLT9BLdjsGQm8mpAQmsMyhVNhpIzj2sCtTA/a7aJiMQcdSLZSYS0oMHzQtWGJqMe1de4ZDxRM/PszZOMEz1mty/3jyu5oJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295314; c=relaxed/simple;
	bh=B4ee0mDnjMvWj0GmGzIeSMHHAkP8TQZ1uT6MvxjRfdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJpcwvk1OqvIIwY0dSWB/d9nUEk0Jnifl8UwINzNTuQkgcZRjhFZIAzbe9QJ7r6NQDZPKlFGGCSH+z45tcjKCjZyq7h1DTrGHF1JaQdRVS+KLtgG8BQaauIuJJ6iG8GQpio50nxoOQdDbOqZ84xKm9dNlw+b5DzmaqJSLX8yac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=muuPLZqv; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <417a8038817ce69e438a59e6916dc04372a47593.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759295300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/GS1Z8FKMYfUy5nzmiw7Y8FbV9B8BuD7gRV3M+4vJ4=;
	b=muuPLZqv3D3f2kSkx/J01qFEGhnSM636NeCtZHYgYl05XJsOVf7grY3E6MYWEwoimEIipt
	52YLkcu+Aal8zUahpJRYVK5FxS/uG2+yRJfz7XrqxLUFTIqIigUusYWzho6Wb5fm/vjvQz
	kAhG5fhPUQzg7lEsy1T4kRJGRYB5G9c=
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in
 print_reg_state()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Brahmajit Das <listout@listout.xyz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, John Fastabend
 <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh
 <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu
 <song@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 01 Oct 2025 13:08:02 +0800
In-Reply-To: <vgtxqzgqxtyfd3pzfngq4l43eeocpputr5syqstbnw2yibl6bv@3yep75dnifgp>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20250923174738.1713751-1-listout@listout.xyz>
	 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
	 <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
	 <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
	 <wz6god46aom7lfyuvhju67w47czdznzflec3ilqs6f7fpyf3di@k5wliusgqlut>
	 <933a66f3e0e1f642ef53726abe617c4d138a91fa.camel@linux.dev>
	 <5fjhzkvgvbpcm2vvqlxhgcobbkiwvo36aalj5lbqrfbznbpynf@jzokg4ba2mwp>
	 <14a30aa593f8d8c018bf54439261a8f05182aa87.camel@linux.dev>
	 <vgtxqzgqxtyfd3pzfngq4l43eeocpputr5syqstbnw2yibl6bv@3yep75dnifgp>
Content-Type: multipart/mixed; boundary="=-6i2YP6NtZ9D5SofFgrUP"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

--=-6i2YP6NtZ9D5SofFgrUP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-09-30 at 23:51 +0530, Brahmajit Das wrote:
> On 26.09.2025 18:36, KaFai Wan wrote:
> > On Fri, 2025-09-26 at 06:34 +0530, Brahmajit Das wrote:
> > > On 25.09.2025 23:31, KaFai Wan wrote:
> > > > On Wed, 2025-09-24 at 23:58 +0530, Brahmajit Das wrote:
> > > > > On 25.09.2025 01:38, KaFai Wan wrote:
> > > > > > On Wed, 2025-09-24 at 21:10 +0530, Brahmajit Das wrote:
> > > > > > > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > > > > > > On Wed, Sep 24, 2025 at 1:43=E2=80=AFAM Brahmajit Das
> > > > > > > > <listout@listout.xyz>
> > > > > > > > wrote:
> > > > > > > > >=20
> > > > > > > > > Syzkaller reported a general protection fault due to a
> > > > > > > > > NULL
> > > > > > > > > pointer
> > > > > > > > > dereference in print_reg_state() when accessing reg-
> > > > > > > > > > map_ptr
> > > > > > > > > without
> > > > > > > > > checking if it is NULL.
> > > > > > > > >=20
> ...snip...
> >=20
> > You should add a Fixes label in the commit log and add selftest for it
> > in V3.=C2=A0
> > Fixes label is Fixes: aced132599b3 ("bpf: Add range tracking for
> > BPF_NEG")
> > For selftest you may check the test in verifier_value_illegal_alu.c and
> > other files.=C2=A0=20
> >=20
> > The code in your next post would change the behavior of BPF_NEG and=20
> > BPF_END, you can run the selftest to check that.
> >=20
>=20
> KaFai, I'm quite new to kernel development. I'm been trying to write a
> selftest for this unfortunately been having a hard time. I would really
> appreciate some help. For now I tried to create on from the initial test
> you used to verify this bug i.e. r0 -=3D r0.
>=20
> I have tried testing my changes via sending a pull request on the
> kernel-patches/bpf repository, but seems like it's failing.
> My pull request: https://github.com/kernel-patches/bpf/pull/9900
>=20

The attachment is the patch for selftest, you can apply it.

The patch#1 in your PR, Add the Oops call trace or the Closes label in comm=
it
log could be better.=20

Closes: https://lore.kernel.org/all/68d26227.a70a0220.1b52b.02a4.GAE@google=
.com/
--=20
Thanks,
KaFai

--=-6i2YP6NtZ9D5SofFgrUP
Content-Disposition: attachment;
	filename*0=0001-selftests-bpf-Add-test-for-BPF_NEG-alu-on-CONST_PTR_.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-selftests-bpf-Add-test-for-BPF_NEG-alu-on-CONST_PTR_.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyY2I3ZmU1ZDRjNzA3ZDhmNTY2MzgyOWJhY2YyNjA2NjQ4YmUxODVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYUZhaSBXYW4gPGthZmFpLndhbkBsaW51eC5kZXY+CkRhdGU6
IFdlZCwgMSBPY3QgMjAyNSAxMTo1Njo1MSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHNlbGZ0ZXN0
cy9icGY6IEFkZCB0ZXN0IGZvciBCUEZfTkVHIGFsdSBvbiBDT05TVF9QVFJfVE9fTUFQCgpGcm9t
OiBLYUZhaSBXYW4gPGthZmFpLndhbkBsaW51eC5kZXY+CgpBZGQgYSB0ZXN0IGNhc2UgZm9yIEJQ
Rl9ORUcgb3BlcmF0aW9uIG9uIENPTlNUX1BUUl9UT19NQVAuIFRlc3RzIGlmCkJQRl9ORUcgb3Bl
cmF0aW9uIG9uIG1hcF9wdHIgaXMgcmVqZWN0ZWQgaW4gdW5wcml2aWxlZ2VkIG1vZGUgYW5kIGlz
IGEKc2NhbGFyIHZhbHVlIGFuZCBkbyBub3QgdHJpZ2dlciBPb3BzIGluIHByaXZpbGVnZWQgbW9k
ZS4KClNpZ25lZC1vZmYtYnk6IEthRmFpIFdhbiA8a2FmYWkud2FuQGxpbnV4LmRldj4KLS0tCiAu
Li4vYnBmL3Byb2dzL3ZlcmlmaWVyX3ZhbHVlX2lsbGVnYWxfYWx1LmMgICAgIHwgMTggKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy92ZXJpZmllcl92YWx1ZV9pbGxl
Z2FsX2FsdS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX3Zh
bHVlX2lsbGVnYWxfYWx1LmMKaW5kZXggYTk5Yjg2YzUwNmY3Li5hODUwZGRlOTVkMGUgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy92ZXJpZmllcl92YWx1ZV9p
bGxlZ2FsX2FsdS5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy92ZXJp
Zmllcl92YWx1ZV9pbGxlZ2FsX2FsdS5jCkBAIC0xODIsNiArMTgyLDI0IEBAIF9fbmFrZWQgdm9p
ZCBtYXBfcHRyX2lsbGVnYWxfYWx1X29wKHZvaWQpCiAJOiBfX2Nsb2JiZXJfYWxsKTsKIH0KIAor
U0VDKCJzb2NrZXQiKQorX19kZXNjcmlwdGlvbigibWFwX3B0ciBpbGxlZ2FsIGFsdSBvcCwgbWFw
X3B0ciA9IC1tYXBfcHRyIikKK19fZmFpbHVyZSBfX21zZygiUjAgaW52YWxpZCBtZW0gYWNjZXNz
ICdzY2FsYXInIikKK19fZmFpbHVyZV91bnByaXYgX19tc2dfdW5wcml2KCJSMCBwb2ludGVyIGFy
aXRobWV0aWMgcHJvaGliaXRlZCIpCitfX2ZsYWcoQlBGX0ZfQU5ZX0FMSUdOTUVOVCkKK19fbmFr
ZWQgdm9pZCBtYXBfcHRyX2lsbGVnYWxfYWx1X29wKHZvaWQpCit7CisJYXNtIHZvbGF0aWxlICgi
CQkJCQlcCisJcjAgPSAlW21hcF9oYXNoXzQ4Yl0gbGw7CQkJXAorCXIwID0gLXIwOwkJCQkJXAor
CXIxID0gMjI7CQkJCQlcCisJKih1NjQqKShyMCArIDApID0gcjE7CQkJCVwKKwlleGl0OwkJCQkJ
CVwKKyIJOgorCTogX19pbW1fYWRkcihtYXBfaGFzaF80OGIpCisJOiBfX2Nsb2JiZXJfYWxsKTsK
K30KKwogU0VDKCJmbG93X2Rpc3NlY3RvciIpCiBfX2Rlc2NyaXB0aW9uKCJmbG93X2tleXMgaWxs
ZWdhbCBhbHUgb3Agd2l0aCB2YXJpYWJsZSBvZmZzZXQiKQogX19mYWlsdXJlIF9fbXNnKCJSNyBw
b2ludGVyIGFyaXRobWV0aWMgb24gZmxvd19rZXlzIHByb2hpYml0ZWQiKQotLSAKMi40My4wCgo=


--=-6i2YP6NtZ9D5SofFgrUP--

