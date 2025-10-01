Return-Path: <bpf+bounces-70128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1673BB17D0
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DFA1945A8C
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F72D373E;
	Wed,  1 Oct 2025 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4fBgzKe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E72D46DB
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343357; cv=none; b=qWPaPjH3Jk2miULqd9ohRVJ/a+mgGRw8hqEvK0bTnyr4pLte5abO4mbwYUGy6xAMS0jqZg+6c3RxfkUh6JCDUdV1x2B/oNYfZE5RKClfqb4ekIYmVAJWAwkzN5Ug1beoGHMrnY161oidIX3Tc+jgHxqWWsCo1sqht9XuZ/r1KDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343357; c=relaxed/simple;
	bh=j7i885BUIYK7Ahlc3uZPZzWMjBsq8Olqhq31vSDIRD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+MvtGYCO2eWLBgk0r9JWRJnayfQiB/+ufNbNXQhRlJjGr2rAySgrq36U8nfs7xoYC5q1WaEHavhP7it3IokGCZa0dj8vQM7iRTlzP8IfilHrwO9/xJndqOYgtGm5jajsb3SJni3Me9Zd410ReQz9NX0oUqgqMw22bNp7s7ydKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4fBgzKe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28832ad6f64so1220855ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759343355; x=1759948155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HEtC1ejd2zwXZpseILezgJtRXvznbkDw6KY3FPlPFuQ=;
        b=P4fBgzKeIy/VdwvKKVnT2rFMTG2sI+0vZv8byzpE2Nlm4KfbFMvEdzDwS3Y3gXElsW
         t2dZjvHlpbE7zTo+2HtcXxrO5fSCsaqrLzR2MvulYFvvu97OyjFlG2AUogsjB2MRzf2c
         ybWISMkpBchPUqgPjo6CluuF5SnBhvr1kTcYJR/0GjFDUUWpqCh4pwF2hl3GAGLsqO8c
         4sELJQA0bJl1DnU/mtdp2UP/OzuM1NfumRDDKsCEpUce8Bkiz34FaZ6Bg4BZcuoDkZRa
         t9ysR66PXp8R3GsIcPpdN8MxVfbv5caP3aU6sDiRAcm8YLv5IeyuQ9t8f/HQPQ5LXt+Q
         65aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343355; x=1759948155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEtC1ejd2zwXZpseILezgJtRXvznbkDw6KY3FPlPFuQ=;
        b=tG7+5waK3ofNoErBaQdjHwDfKx5KwrEJBdGFCQfV0Xa3FR7jDhaUIwj8rpF07WYqkw
         LhhW8mnOw5ud6PY318dy5UUtedWUDejWWDJPQDK4dN8Co6euP+EN26t0fBIQNb+sIz1o
         yfi1BCbVDxLNo3VX/XvdFYA1VBafNW2EjgfyO8N+J3uCuaF8rIKf1hT/RMZsERByEPjc
         2m+U9iTpfM5KY366uxdaMGeu7BJT21OffrxacRgiATLqaGeeBogrsjFGnTXmlkvas1oG
         fEVtUmJdpLmWRNm/q+WGbQlQddZ/lbgD70Pr+iY0OjGbeUmkiOjVpyvcFyDDt+q9Ym9B
         UL7g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ60d+14AMiJeco4sUBXTX5+r4Sh1ZYfRL+kOGZVELIktmPIxAMKLt1EVZAHokH2bLtwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznoEd7AFiCBHYY858U+sSFRRyH337AIg+9eSGeVBnixUETd/9/
	EjVvwZTtyXi8/+3ArugXCibATEIBaXJriYpV2CKlhrtnvjmUQIpZBS7Z
X-Gm-Gg: ASbGncssj5+YObhJo2afHOxEKGQIvCY+A1nsXMtrmbLvqXfsqrFNtl5IOZTGrhVmhYz
	tZAdxBkLpFaTfzRAMDZh5AG7lGEZVQ6+sgoeVm0OL8D60PwLdMq8Tx63PLGdQT95IpZ3NASqxmj
	Qx0/A5H+vEq2mr/xNffo70EyhoxqEg0pMw4mwGuDl4DLXwGm8KQI6ZzZvJs+YqxXnzQX8nsn1S0
	CSKKRDhDyhvg9NadD75tel4IPEjKV7/idGB7kj+pORN10pWCQBg+mq6abyg5kcREnVY539tKHyF
	ZKVBWk3+R+np87OHE5YFbb6jqgjyrb2fvi9WFexkTAA8xfAPyALvRpEEwrdrAd+AZgPIjRZkYdT
	XReKHTcFw5BfeMk5ZKd3kEfKcOXfoY/KWS/PJXTg2okQaQ97E7HqdTD7LHiN3DbMsDudLqQc=
X-Google-Smtp-Source: AGHT+IHjxc98EvLLxYgVX6wj7cWG6MWtoknxN7328kax/JQPcMwe8LPQoQKsk4jid+pgrkSFmrGKDg==
X-Received: by 2002:a17:903:234c:b0:249:44b5:d5b6 with SMTP id d9443c01a7336-28e7f443f91mr50983455ad.40.1759343355315;
        Wed, 01 Oct 2025 11:29:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31bdsm2670855ad.94.2025.10.01.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:29:14 -0700 (PDT)
Message-ID: <0a2232a7faa9077ba7a837e066bd99bab812e4a6.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst
 is a pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	kafai.wan@linux.dev
Date: Wed, 01 Oct 2025 11:29:12 -0700
In-Reply-To: <20251001095613.267475-2-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20251001095613.267475-1-listout@listout.xyz>
	 <20251001095613.267475-2-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> In check_alu_op(), the verifier currently calls check_reg_arg() and
> adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> However, if the destination register holds a pointer, these scalar
> adjustments are unnecessary and potentially incorrect.
>=20
> This patch adds a check to skip the adjustment logic when the destination
> register contains a pointer.
>=20
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef58
> Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..4b0924c38657 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15645,7 +15645,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  		}
> =20
>  		/* check dest operand */
> -		if (opcode =3D=3D BPF_NEG) {
> +		if (opcode =3D=3D BPF_NEG &&
> +		    !__is_pointer_value(false, &regs[insn->dst_reg])) {

Nit: I'd made this a bit simpler: `regs[insn->dst_reg].type =3D=3D SCALAR_V=
ALUE`,
     instead of __is_pointer_value() call.

>  			err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
>  			err =3D err ?: adjust_scalar_min_max_vals(env, insn,
>  							 &regs[insn->dst_reg],

