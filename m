Return-Path: <bpf+bounces-18222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA88177F4
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEAEDB2222C
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EEB498AB;
	Mon, 18 Dec 2023 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="DN2AY0I7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owLqvGbW"
X-Original-To: bpf@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B31D148
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dtucker.co.uk
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 332085C0199;
	Mon, 18 Dec 2023 11:55:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 11:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1702918551; x=1703004951; bh=66MFcIJBxZuJGU0fY3aPB22sMQGNIilm
	F0IRdA5ZISc=; b=DN2AY0I7kziIi8SjWbNSVHHFLh0KakIAEObeHdueJdU4X3HC
	wX2AEwcB8YhXzoVump6vHQaXQJBRDVPNxK8gBbfePlCPmBDGqIEIk5CR9zLezLuJ
	57eBG0uOfLPM6LAm5C2Y/hu4Y6x5GWnHwYAEOAxmC5KDAq5I/rbD1N6fKwK8xSmt
	TXGAfJZUM/iap5lXnHEh8prIe9kNw42MnAsGgBgf+2nxb7cGciLQfbJdXnMw38c/
	V78ul3Mk8lzXOF7qdl8GqA8EwKUKzndkNmld8cKW6ZojU5J7CeWN/kppP1/Uu8RH
	mdqVpBByiJndq3yzXw/V1RFlmJFmHde7cXIRxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702918551; x=
	1703004951; bh=66MFcIJBxZuJGU0fY3aPB22sMQGNIilmF0IRdA5ZISc=; b=o
	wLqvGbWKCPNJwiY7K3UKeEBPq1yakxKRzOR1ojH0WtwgPTp9sDAyJqR5Wf1otvg0
	6CiljIb2538z6ofpNndrrWMjJeZohe2SgodDnQfIgUINfumhQ9iYgp+5jk2xQNbu
	yF+0SnOiYtfHaxlArnA3YP2WRz9iWCMDb4XtUuzQrrPkf09wNSFHrOuEVc31NGCR
	3IKHQrLCKa26S/ptCe+WHk7y2uPI8l7sUGWuXneyjgIsAHFFuHW76F3mnZs3poCp
	z2AU3UPxOeMUuRd6XtA5zOolQ4/EGriwK8G86R/Eg4A7hV2YmVJN5OnUcrUOs/2H
	Wk5xwOk3x3hA7VTjfkFhA==
X-ME-Sender: <xms:lnmAZUx8X2Eg74kTxXbXiTfNTEnBlPJAAmyezwpkgxbJmKtM-HHd4A>
    <xme:lnmAZYRQWgVqsMf6ZnPsy4qulXDTKW2wA8jOUBS04fmAbBkL7o_HHumcVDwZq99SL
    a4MxB3pJSN9_ERjkA>
X-ME-Received: <xmr:lnmAZWU42xQwGpt7ls_dU9EgLEJyWEa_SqkHdE5G0BQtQYPaBkBc-LLkcZEgjA7GI4RlucHmfWF_EuIzdrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeffrghv
    vgcuvfhutghkvghruceouggrvhgvseguthhutghkvghrrdgtohdruhhkqeenucggtffrrg
    htthgvrhhnpeeivefgueeijedtffelhfevleettdfgueetteekfeetvedtveeuteetheeu
    hefggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:lnmAZSgtAa565nVfvAddFgQQA5QoJYxWCgccBb8-9eaGlv5PRYLesQ>
    <xmx:lnmAZWDuNbI70Cj8Hm24hbpV_xo9_iUnxUJMnqZIgW5wV8_x21rRMw>
    <xmx:lnmAZTJbh9Yzfc38VEtiJYTasu2h3wxBxAXTXjJ-Fb8I7NCHl-TQUA>
    <xmx:l3mAZXKeUtiBSv5Mck1JI7zznidLKXSKXYvj5tnuWVxGwmKfp_JpKA>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 11:55:48 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH bpf-next v3] bpf: Include pid, uid and comm in audit
 output
From: Dave Tucker <dave@dtucker.co.uk>
In-Reply-To: <96e41142-1c86-f7ab-67dc-47e6d9da362b@iogearbox.net>
Date: Mon, 18 Dec 2023 16:55:36 +0000
Cc: bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Yafang Shao <laoar.shao@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07CB062F-E7E8-4D6C-A7CC-E20EE34478B8@dtucker.co.uk>
References: <3636f52d-f343-45e5-88c6-3c7e28e87a45@linux.dev>
 <20231215174639.1034164-1-dave@dtucker.co.uk>
 <96e41142-1c86-f7ab-67dc-47e6d9da362b@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On 15 Dec 2023, at 22:20, Daniel Borkmann <daniel@iogearbox.net> =
wrote:
>=20
> On 12/15/23 6:46 PM, Dave Tucker wrote:
>> Current output from auditd is as follows:
>> time->Wed Dec 13 21:39:24 2023
>> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
>> This only tells you that a BPF program was loaded, but without
>> any context. If we include the prog-name, pid, uid and comm we get
>> output as follows:
>> time->Wed Dec 13 21:59:59 2023
>> type=3DBPF msg=3Daudit(1702504799.156:99528): op=3DUNLOAD =
prog-id=3D50092
>> prog-name=3D"test" pid=3D27279 uid=3D0 comm=3D"new_name"
>> With pid, uid a system administrator has much better context
>> over which processes and user loaded which eBPF programs.
>> comm is useful since processes may be short-lived.
>> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
>> ---
>> Changes:
>> v2->v3:
>>   - Revert replacing in_irq() with in_hardirq()
>>   - Revert removal of in_irq() check from bpf_audit_prog since it may
>>     also be called in the sofirq or nmi contexts
>> v1->v2:
>>   - Move 'op' to the front of the audit messages
>>   - Add 'prog-name' to the audit messages
>>   - Replace deprecated in_irq() with in_hardirq()
>>   - Remove in_irq() check from bpf_audit_prog since it's always =
called
>>     from the task context
>>   - Only populate pid, uid and comm if not in a kthread
>=20
> Aside from what Alexei mentioned, looking back at commit bae141f54be83
> ("bpf: Emit audit messages upon successful prog load and unload"), =
don't
> you already have this information at hand? Quote from commit msg:
>=20
> Raw example output:
>=20
>      # auditctl -D
>      # auditctl -a always,exit -F arch=3Dx86_64 -S bpf
>      # ausearch --start recent -m 1334
>      ...
>      ----
>      time->Wed Nov 27 16:04:13 2019
>      type=3DPROCTITLE msg=3Daudit(1574867053.120:84664): =
proctitle=3D"./bpf"
>      type=3DSYSCALL msg=3Daudit(1574867053.120:84664): arch=3Dc000003e =
syscall=3D321   \
>        success=3Dyes exit=3D3 a0=3D5 a1=3D7ffea484fbe0 a2=3D70 a3=3D0 =
items=3D0 ppid=3D7477    \
>        pid=3D12698 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 =
suid=3D1001 fsuid=3D1001    \
>        egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts2 ses=3D4 =
comm=3D"bpf"                \
>        exe=3D"/home/jolsa/auditd/audit-testsuite/tests/bpf/bpf"        =
          \
>        subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
key=3D(null)
>      type=3DUNKNOWN[1334] msg=3Daudit(1574867053.120:84664): =
prog-id=3D76 op=3DLOAD
>      ----
>      time->Wed Nov 27 16:04:13 2019
>      type=3DUNKNOWN[1334] msg=3Daudit(1574867053.120:84665): =
prog-id=3D76 op=3DUNLOAD
>      ...

The information is only there if you=E2=80=99ve added an audit rule like =
the one above
to capture the bpf syscall. With the default rules of `auditctl -a =
task,never`
(at least that=E2=80=99s the default on my system) all you see is:

---
time->Mon Dec 18 13:51:47 2023
type=3DBPF msg=3Daudit(1702907507.727:858492): prog-id=3D965 op=3DLOAD
----
time->Mon Dec 18 13:51:49 2023
type=3DBPF msg=3Daudit(1702907509.031:858493): prog-id=3D965 op=3DUNLOAD
=E2=80=94=E2=80=94

I=E2=80=99d be okay with adding rules to enrich the context if it was =
possible to=20
constrain auditing to only certain bpf_cmds, but I=E2=80=99ve not been =
successful so
far. The rule `always, exit -F arch=3Db64 -S bpf -F a0=3D5` still shows =
map ops in
the audit logs. On a busy system that floods the audit log with noise =
and useful
logs can be lost due to log rotation.


- Dave

> Thanks,
> Daniel



