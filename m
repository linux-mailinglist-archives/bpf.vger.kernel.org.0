Return-Path: <bpf+bounces-65364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876BB21288
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9A23B4FBB
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C429BD8A;
	Mon, 11 Aug 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnGAjB0G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB3C1F3FF8;
	Mon, 11 Aug 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930797; cv=none; b=LZtvC2/AHFUgx9U/dMQrhuaMMtl3qfKjQUuiEPsAQ95D25AnTVE4KmrNGS15IsEjVFiwSWRAtOsNprzM2Ny1jeJ40xBgsRZsD+P/CIs4uP9BVrRJz0lcdVoQXNFaXCj4VxCf0GmeL9Ng4hN78W9Q3vA8aVfbtdFBB4Eb0EuI/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930797; c=relaxed/simple;
	bh=joXflQgfYApyyE87QumiSz5Yi2G1GWbmG8jAHhbaomE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBlSzNwuRxYVJrHjlCfKZcqkKVd+gmkntw55OIsmwOt826VISAc4r1Y2p/xu/AMUwHxq/YAyHm5Z3Q0GYi/eqM4IJZd3nxzc9Rvl+sS3CUPmBfshLn2QTTBYcn9j/E4kjUZCeg0uzD7t7CXr77vM65IZqh2kdMs1/sWS07V4vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnGAjB0G; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5911499b3a.3;
        Mon, 11 Aug 2025 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754930795; x=1755535595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/XB2Ruz07Wi+RhCmNAtu2N4YgR6VtYgzdg2cDhpBEA=;
        b=TnGAjB0G+AnM60AuGE3ozEVjo0dm+pii4Obbs2SlDcx8lJRVC+6JcMl3g7VQFxCZ/I
         U39AXp6SdYWeS34Gih8J1lnJrdgYQaN9BOKVJ+yaUUroAG2g9FyhIs+A3/7hudDhBzKO
         6FJHkDujiM62kzoWyonZ4do68sBaBBv9yXdsv8EvhBqSC9A6hOzJCV45vC1AdRFw0rBe
         psYl7KGeWtYP9RmPkhPLeksSb8F8Ss075+Guda4hiptZuC6p2Ig0NClcWzG4oXQwQQBE
         VJZDZpNKf3AhJ5VO5L8LKmWsCsTdDJQjQX2V4fkMGkqg6aw2zKveDFoEYLAMSnEtZnvw
         H5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754930795; x=1755535595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/XB2Ruz07Wi+RhCmNAtu2N4YgR6VtYgzdg2cDhpBEA=;
        b=Jer3lcJxzpHnITLaDZHdNezi+2rnHBqXWm/knExJZjr8qXIosk0KDMHZtAvxJxbJ4g
         lmDwIHJzpyvbRsTV9QI4aHUx7NpxokBxCrldH0Kyj44hBpamuOeD9R7DGsc5jew/G73P
         8pkRcaMU7vCIscJ+ytiQNC1nP5k1LAADDAxPa8U0X2ijyx3pBgAE51ttIxyI1KpQP1iJ
         WOUAa+TS201pLH6ZwiwjVPyeiOZ+RvHf1A1zwNGEWmt1G6cQI6RIudslPbggHKm088sM
         GS7y4KMfMQQ4inNhmk3sa2VgZAmnuJFENMrxWpDwsU8tuhQtlZ/zGKxMHu4ArziHncO7
         YmAw==
X-Forwarded-Encrypted: i=1; AJvYcCU15NwnJftQAfxFr8de3NJArGg+xnxISdNI96ib4roRqkISYiUG3CU+0bN1I4l+YHZBL2LROzuL59pzyZif@vger.kernel.org, AJvYcCWtzo/0uqtlziAJNws56wdaNnYk7MMfpNB0x7vyKNfmfUZanFuXER6KeDow0L1BFk9n+mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOKmcqwo6RJELIolEF27rb+27EodEa1eJahaa6gavYT9OUQFi
	Gzf+3gSfrPtSsf+h1MJnLsAvu5QX5P1eyDVR0ZSTeqg8qtnIpQ82Iqsz
X-Gm-Gg: ASbGncvh12QUTitiHYb+Y8mJRWx9d4ogGqC0jpJaU0di+Iph3VvQ9GqgJnyBsmlYHxp
	CiMP/LD9MU1QJKx0x3yq0ly27wvYYxtyMTaD+6TPgpXej17Y4gov2PK/ClPSrlDbpL1t//rAc9W
	jN0D+aB3+akiHZv3jto8YnWByA7LFs192Nv6C/DW9H/Rdyrq1dOS0mU1oTUvfrHjRCnTebkFeRk
	18KxISMEMKdq0lKP7b5rfMgaPuTqeVbvHsBeGqg+cCoiQ9Ll5qws+OQ+oi9Wsh9uxstXgEIHFWr
	DZVlHpvsH1QzTHZ7dms+ylgB/mtNHH59RgCOyQSBmmCcbZMEAItczgU2BZtyrLwX2ruFt1EfswR
	F1LwdDhLSsjEpnidFVr7+bfMdJ452qkeDltNDog==
X-Google-Smtp-Source: AGHT+IH/jnPaWTh+Y6hkStQxD5hrTJ9hnc875d6bFBkLJwt6TGqRuJpfXV8AUud8dlmEcwkWb4ccuw==
X-Received: by 2002:a05:6a20:9184:b0:240:489:beab with SMTP id adf61e73a8af0-2409a9714b2mr214634637.34.1754930795541;
        Mon, 11 Aug 2025 09:46:35 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::17? ([2620:10d:c090:600::1:56e6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c0e86f3c6sm18226200b3a.5.2025.08.11.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:46:35 -0700 (PDT)
Message-ID: <6b72f32a9d1b137fb3f3ae0c439b1688fef8dd8d.camel@gmail.com>
Subject: Re: [PATCH] bpf: replace kvfree with kfree for kzalloc memory
From: Eduard Zingerman <eddyz87@gmail.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 09:46:33 -0700
In-Reply-To: <20250811123949.552885-1-rongqianfeng@vivo.com>
References: <20250811123949.552885-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 20:39 +0800, Qianfeng Rong wrote:
> The 'backedge' pointer is allocated with kzalloc(), which returns
> physically contiguous memory. Using kvfree() to deallocate such
> memory is functionally safe but semantically incorrect.
>=20
> Replace kvfree() with kfree() to avoid unnecessary is_vmalloc_addr()
> check in kvfree().
>=20
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..4e5de1ff7e30 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19553,7 +19553,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>  				err =3D err ?: add_scc_backedge(env, &sl->state, backedge);
>  				if (err) {
>  					free_verifier_state(&backedge->state, false);
> -					kvfree(backedge);
> +					kfree(backedge);

The backedge encapsulates verifier state, verifier states are
allocated using kzalloc() and freed using kfreed() in other places in
verifier.c =3D> I think this patch is valid.

>  					return err;
>  				}
>  			}

