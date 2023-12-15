Return-Path: <bpf+bounces-18009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FDA814D48
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533881C23D91
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA63F8CC;
	Fri, 15 Dec 2023 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="AAaVUGT5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4vjFHVCv"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFB3EA73
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dtucker.co.uk
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id DC2393200BD9;
	Fri, 15 Dec 2023 11:38:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Dec 2023 11:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1702658326; x=1702744726; bh=hMZLeux7SvVhbSpsbUyAxzA/0VfPBoO+
	MkbeN7vJlBE=; b=AAaVUGT5HyU2KuLCntT36iW0eVQVn74+qTOap2IhSiSF/EA0
	9cmt0vAYiPEEHYktxBcXUjt+i3bxss2sDEG8e3Rp5RRPD+qOMepa7wpuGKGJKzks
	UcGcWjv+QxqRklHQCVDUUNa8DI7+JvgtMqHmqRAUafj/2JGBdL4cXDRgKiQfk3Qg
	KuOq4JIXwwPcDf/jg73U+rWZWkAbAqfFVd2mgrbEYhcgY6sEvOgwTQCQYT5n/UeZ
	ajdSbHgWqiErw6fSa7+BssSw2Epp0jDCPolvpokgoQBtliEeOwg40gbloCUaS9ZX
	P/RctSj/gk934zJcODq4EX676W4Y5zyNWWTAqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702658326; x=
	1702744726; bh=hMZLeux7SvVhbSpsbUyAxzA/0VfPBoO+MkbeN7vJlBE=; b=4
	vjFHVCvR+om+DU9p01JxPw1q8XnXLp5DBwJYU2huZ8ZPXuJfy1QZ8rw8Zw7V6ZZS
	v8ZbgeLJnPDQBxDwnIgg4vU/3k6D1nWRtog3N8iY0XNNwF5dgGExdmTXNALAa4k4
	Qs5ytQRr8s0rb13b5mGsH8/KzfcXrS/SK4t2UVhi4/unzzcdcCSCZDqd7PTqN7YR
	f4JC1R+t+J5CdTJJnt+oZzXNeuMDuU7OpuCOzrXlPl9j6R9FBHLMoqzFOPxUTkOb
	lFbMaNlp3+AVmfga0+vWwRH80X8y33x8VFZ2Fqu+AhdGijgu4/BD5KAWqf45ECEZ
	6m4EgfH6+vpdcqNUXZEwQ==
X-ME-Sender: <xms:FoF8ZdDoUDm2h8siz8siCfopqbHISyMvbXGTQW37L6zHXVlZyH2goQ>
    <xme:FoF8ZbgcVGCNQteK6p-vfblMvq3UWiqiO9uNCxrhu4FKUqfUtz02XgIY3ji3clhBE
    34K4_P8_VDvSxI1Jw>
X-ME-Received: <xmr:FoF8ZYninZZPH6gaalw5VMO-QOb3WSngScXIMwElyC3JkJkZhwliq2ShfBFL0k9s8haAHuUA9s02c8pq1qc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeffrghv
    vgcuvfhutghkvghruceouggrvhgvseguthhutghkvghrrdgtohdruhhkqeenucggtffrrg
    htthgvrhhnpeeghfeuudetteevvdduveetveelueeitedugfduudettdfhtdejgfejhfeg
    jeeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvhgvseguthhutghkvghrrdgtohdr
    uhhk
X-ME-Proxy: <xmx:FoF8ZXz27-O0HjGzXrMwSt_8XL2_VjwPKNCtJ7s3ZSXj3i62mkwA6w>
    <xmx:FoF8ZSQfM6N1TpwR-z_95gzlEGLPkFPgeEg-9dlwS4fyKA3jL9mQFA>
    <xmx:FoF8ZaY21dhSB6YFYa86D3a81fYLc6Djg_nScYTbVw-CU_4NcMO5jg>
    <xmx:FoF8ZeY-XvqIGkI1_8MFGItU2jnsy1rbYFgEwexr6FStaBmBxvB23Q>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 11:38:44 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Include pid, uid and comm in audit
 output
From: Dave Tucker <dave@dtucker.co.uk>
In-Reply-To: <db4e55b7-83e1-4ec8-b10d-cfc9be3771c7@linux.dev>
Date: Fri, 15 Dec 2023 16:38:32 +0000
Cc: bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Yafang Shao <laoar.shao@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACEF8947-8BE1-429C-AB6E-FE20CFB8CE8D@dtucker.co.uk>
References: <CAADnVQJi1mezWL6BKn=Vw4quev3pgLOW9q3Yz9GF=LjzZoHp6g@mail.gmail.com>
 <20231215143836.993858-1-dave@dtucker.co.uk>
 <db4e55b7-83e1-4ec8-b10d-cfc9be3771c7@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On 15 Dec 2023, at 15:24, Yonghong Song <yonghong.song@linux.dev> =
wrote:
>=20
>=20
> On 12/15/23 6:38 AM, Dave Tucker wrote:
>> Current output from auditd is as follows:
>>=20
>> time->Wed Dec 13 21:39:24 2023
>> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
>>=20
>> This only tells you that a BPF program was loaded, but without
>> any context. If we include the prog-name, pid, uid and comm we get
>> output as follows:
>>=20
>> time->Wed Dec 13 21:59:59 2023
>> type=3DBPF msg=3Daudit(1702504799.156:99528): op=3DUNLOAD =
prog-id=3D50092
>> prog-name=3D"test" pid=3D27279 uid=3D0 comm=3D"new_name"
>>=20
>> With pid, uid a system administrator has much better context
>> over which processes and user loaded which eBPF programs.
>> comm is useful since processes may be short-lived.
>>=20
>> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
>> ---
>>=20
>> Changes:
>>=20
>> v1->v2:
>>   - Move 'op' to the front of the audit messages
>>   - Add 'prog-name' to the audit messages
>>   - Replace deprecated in_irq() with in_hardirq()
>>   - Remove in_irq() check from bpf_audit_prog since it's always =
called
>>     from the task context
>=20
> Is this true? For condition '(in_hardirq() || irqs_disabled())
> ', the context will be the task context. But what about nmi and
> softirq? The context maynot be the task context, right?

You=E2=80=99re right, my mistake.

> Not sure whether this is relevant or not. There was a discussion
> in the past about the above condition. See
>  =
https://lore.kernel.org/bpf/a93079f2-fcd4-e3ef-3b92-92d443b8e8c6@meta.com/=

>=20
> The recommended change was
>=20
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c index =
a75c54b6f8a3..11df562e481b 100644 --- a/kernel/bpf/syscall.c +++ =
b/kernel/bpf/syscall.c @@ -2147,7 +2147,7 @@ static void =
__bpf_prog_put(struct bpf_prog *prog)           struct bpf_prog_aux *aux =
=3D prog->aux;
>=20
>         if (atomic64_dec_and_test(&aux->refcnt)) {
> - if (in_irq() || irqs_disabled()) { + if (!in_interrupt()) {          =
                 INIT_WORK(&aux->work, bpf_prog_put_deferred);
>                         schedule_work(&aux->work);
>                 } else {

include/linux/preempt.h says that in_interrupt is also deprecated.
The condition could also be expressed as in_task().

> If the above change was true, then audit will not be able to
> get any meaning task specific information, you might need to
> gather such informaiton before hand.

Hmmm. Would storing that information in bpf_prog_aux work?

- Dave

>=20
>=20
>>   - Only populate pid, uid and comm if not in a kthread
>>=20
>>  kernel/bpf/syscall.c | 27 ++++++++++++++++++++++-----
>>  1 file changed, 22 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 06320d9abf33..fbbaf3b8ad48 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/rcupdate_trace.h>
>>  #include <linux/memcontrol.h>
>>  #include <linux/trace_events.h>
>> +#include <linux/uidgid.h>
>>    #include <net/netfilter/nf_bpf_link.h>
>>  #include <net/netkit.h>
>> @@ -2110,18 +2111,34 @@ static void bpf_audit_prog(const struct =
bpf_prog *prog, unsigned int op)
>>  {
>>   struct audit_context *ctx =3D NULL;
>>   struct audit_buffer *ab;
>> + const struct cred *cred;
>> + char comm[sizeof(current->comm)];
>>     if (WARN_ON_ONCE(op >=3D BPF_AUDIT_MAX))
>>   return;
>>   if (audit_enabled =3D=3D AUDIT_OFF)
>>   return;
>> - if (!in_irq() && !irqs_disabled())
>> - ctx =3D audit_context();
>> +
>> + ctx =3D audit_context();
>>   ab =3D audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>>   if (unlikely(!ab))
>>   return;
>> - audit_log_format(ab, "prog-id=3D%u op=3D%s",
>> -  prog->aux->id, bpf_audit_str[op]);
>> +
>> + audit_log_format(ab, "op=3D%s prog-id=3D%u",
>> +  bpf_audit_str[op], prog->aux->id);
>> + audit_log_format(ab, " prog-name=3D");
>> + audit_log_untrustedstring(ab, prog->aux->name ?: "(none)");
>> +
>> + if (current->mm) {
>> + cred =3D current_cred();
>> + audit_log_format(ab, " pid=3D%u uid=3D%u",
>> +  task_pid_nr(current),
>> +  from_kuid(&init_user_ns, cred->uid));
>> + audit_log_format(ab, " comm=3D");
>> + audit_log_untrustedstring(ab, get_task_comm(comm, current));
>> + } else {
>> + audit_log_format(ab, " pid=3D? uid=3D? comm=3D?");
>> + }
>>   audit_log_end(ab);
>>  }
>>  @@ -2212,7 +2229,7 @@ static void __bpf_prog_put(struct bpf_prog =
*prog)
>>   struct bpf_prog_aux *aux =3D prog->aux;
>>     if (atomic64_dec_and_test(&aux->refcnt)) {
>> - if (in_irq() || irqs_disabled()) {
>> + if (in_hardirq() || irqs_disabled()) {
>>   INIT_WORK(&aux->work, bpf_prog_put_deferred);
>>   schedule_work(&aux->work);
>>   } else {



