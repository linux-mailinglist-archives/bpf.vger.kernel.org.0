Return-Path: <bpf+bounces-69526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2FB990AA
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1E1885AA8
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D78A2D592F;
	Wed, 24 Sep 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="Qd533E4B"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACF28489A;
	Wed, 24 Sep 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704990; cv=none; b=FIJWurRDXI1HVTSFenosL31owlmTwFInQTtFGHpRmrtR8rORj9DL5V734k5ZHea5DnfYWEsrgmO9g684ojnbDkM1tgnPC6NGQFJfrkGYZIQt1J+btSV8KTgB6LjCC9gdbae238V0zXNAX2zWR2BMHW0AOgq5KFBbm/RHIWrpuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704990; c=relaxed/simple;
	bh=DxOC5F9IpvBeWNXWVDhhsIFZ/wb880yCXv5033VbNeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eud4d+spfX9iknlfe88Cuma5b7TBpjqS+6FXNYu+X6Ey0pLwWrRM2J4BuT6UhwulKEPKhQVwpM5DFfkB+zjYpwk6ZpxvnyKEmDyxnnTEcsU8DIrS1OY6DUs+wPAt5jQK7X12jYZuoQtg0v0xqFkok7m45uRt7K5xQtUz8xF4ll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=Qd533E4B; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cWrdg01Jtz9sTZ;
	Wed, 24 Sep 2025 11:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758704983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+o0dWRbJcjyIeHaoH33sWtRhES8NzIAuHFXyzXbR714=;
	b=Qd533E4BHPUZlzEXHJ880v1Dmvb9GUTRC4spfNwRgCmH9BrGvoknw5Rr1xgYyjQP8OxtU4
	fUNKI9bOQ4VYBfgtJASAWx43QbG53s0f/FChNx77+8gOu6ke7HgFzkzFNweX8RvqccJcyC
	oiAPGwUvypY6VDiZYyec7ZZUaJkOOScvLvADDGEexT5PMdrSsjbRR5BKWAMYB3z0qc54Xf
	nQ3R3LfTwC3urevKbB9pLSGso+NDQRLL/my5gcHzmo7/r7rrxuLQiKK14eXuzBwEjnnwFp
	YmjlUh3O5Dp7CId7GZNB+nrwjXzUzekh7DtKE3KuKIPXvb1KOeMGswCOrHiG8w==
Date: Wed, 24 Sep 2025 14:39:27 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
Message-ID: <7f4lg3hnkue3qcxc6ej6yqeix4cb2scwjlb4rzhrjb4idjnvqb@kpjtqar55jrq>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20250923174738.1713751-1-listout@listout.xyz>
 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>

On 24.09.2025 09:32, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 1:43 AM Brahmajit Das <listout@listout.xyz> wrote:
> >
> > Syzkaller reported a general protection fault due to a NULL pointer
> > dereference in print_reg_state() when accessing reg->map_ptr without
> > checking if it is NULL.
> >
> > The existing code assumes reg->map_ptr is always valid before
> > dereferencing reg->map_ptr->name, reg->map_ptr->key_size, and
> > reg->map_ptr->value_size.
> >
> > Fix this by adding explicit NULL checks before accessing reg->map_ptr
> > and its members. This prevents crashes when reg->map_ptr is NULL,
> > improving the robustness of the BPF verifier's verbose logging.
> >
> > Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> > Signed-off-by: Brahmajit Das <listout@listout.xyz>
> > ---
> >  kernel/bpf/log.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > index f50533169cc3..5ffb8d778b92 100644
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -704,7 +704,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
> >                 verbose_a("ref_obj_id=%d", reg->ref_obj_id);
> >         if (type_is_non_owning_ref(reg->type))
> >                 verbose_a("%s", "non_own_ref");
> > -       if (type_is_map_ptr(t)) {
> > +       if (type_is_map_ptr(t) && reg->map_ptr) {
> 
> You ignored earlier feedback.
> Fix the root cause, not the symptom.
> 
> pw-bot: cr

Alexei, I did not, the patches (v1 and v2) were sent in a very short
timeframe, when you gave me the feedback I had already sent the v2 so
your feedback applies to v2 as well :)

I'm working on fixing/understanding the issue. I went one function lower
from where print_reg_state is being called and added a few debugging
statements like this

--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -758,6 +758,12 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
                        continue;
                if (!print_all && !reg_scratched(env, i))
                        continue;
+               pr_err("&state->regs[%d] = %p\n", i, (void *)&state->regs[i]);
+               pr_err("reg               = %p\n", (void *)reg);
+               pr_err("&reg->map_ptr      = %p\n", (void *)&reg->map_ptr);
+               pr_err("&state->regs[%d].map_ptr = %p\n", i, (void *)&state->regs[i].map_ptr);
+               pr_err("state->regs[%d].map_ptr is NULL %d\n", i, state->regs[i].map_ptr == NULL);
+               pr_err("regs->map_ptr is NULL %d\n", reg->map_ptr == NULL);
                verbose(env, " R%d", i);
                verbose(env, "=");
                print_reg_state(env, state, reg);

Both reg->map_ptr and state->regs[i].map_ptr reports map_ptr is NULL.
For now I'm bit stuck and trying to understand why that would be.
I got the reproducer from
https://syzkaller.appspot.com/text?tag=ReproC&x=1608c27c580000

-- 
Regards,
listout

