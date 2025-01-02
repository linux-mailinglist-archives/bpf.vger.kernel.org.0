Return-Path: <bpf+bounces-47751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA39FFD59
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D71162D17
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829314F9F7;
	Thu,  2 Jan 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj4mHCRz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906392114
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735840977; cv=none; b=eDytlHwgYzFBCcg5c3WVEPvMg1AUAu8N63FTTJSYiV9DU0OlHR7ImYIwTE9NdeuB6pP2Hr6suAfhUdN/RItAVyDXcO6glb7opOgfTGWIfzWyba8ANk9BzCAfUqglGyzxebMipCWIWxiqBk8lqnJAabXtRbt/4KMyAnazdFNX0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735840977; c=relaxed/simple;
	bh=PS/YoWq6BlkmydEQJalaeRk8yPq5LtyIAxEqmXgKhNs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jN6F+UPNmhrXo1OY8AZZnVHd900n/k65H7O0WBS2IBUpjqDA32QCBNkrkIXK1sLqgu/oqeQKs/AdzU+16SitV0AlZBioJ4y8dqJGubodJSNs0QhyoxsRDTwAFBZlcnSXg0cLh7r4M7I5BE8AYvDgJ/kEN9yLoc1vpm5iK41Mqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj4mHCRz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166f1e589cso191991335ad.3
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735840975; x=1736445775; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vQCkYIDFNfGeSIPwt59EDpVKL8Fe8RS6qNBfOY28zy4=;
        b=jj4mHCRzJB51fkcdOCV7laQyjoTKgMzycdAWtZMNIF6pyXtFGa1+OS6AUPoTRAAshq
         swj8pBa5FVoS2uE/yaQCvU63bb6AnbqNIxKOoHtFwZVIo/gQavaIL/4I7+68RwhSwKo2
         CE2HukoAGiRcrEqHRtMBa5DhdIKFq0jNo/11LVgaT11ofcRkvVb+Uo8PQBH+W3W/+Qyn
         ch/ZWmftKa1z8UjhxHCT+1/eR/QMViEMzoKQ315BgPMN28G3ABM3RYFtyLxULpUP/74Z
         Gv8d9tTECkIyOz7qUL/AYcRnE+1K0sqIWxyxBjjzFZKvcQGN9V8S/DWktgofZPhTAu2P
         S10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735840975; x=1736445775;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQCkYIDFNfGeSIPwt59EDpVKL8Fe8RS6qNBfOY28zy4=;
        b=TnUEPYzo40GabJWUe9UCr317YGxImExR8uQ5/u67wP9FpANHZmN1Wt/wQk5V65j0kY
         +c0kX/qyp7CzmU5/izaeL/HStHb0ZTYGXa8IrqQSHxk1IQ2JCutX46FY9P/Re/oosTfD
         p6K0CPy4SX+LbkcIQ1EduJ0cYrjUQ/GkTdiEQqLGO97ZaqiSXMfVqr5LlceHRzWqVgh5
         l98oX0RvyGTW2X2IoNTE2eYjIm4x1Fs87lrAI2vH2lq+MQmCvNaRtOdiZEGGT8pRSkHG
         3Qj3KQhLMoSLmoua5TfvJJYfYB583M18fJuanqw2pD1Hzg++J1BTtA29Z5srk2z+QBt4
         j08A==
X-Forwarded-Encrypted: i=1; AJvYcCU0orzg4J+g12fQJJ/TR6/qAw1zm4N4+180PTDmbuZ5vQmXuNw+HOvL4zxBY40ZE2QO+uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGaVaLGiuCwexGiV6Ny/UqwdfRku0vAN1IUs1WEmS5DA/OcjT
	tshA/JMkNn3Q7XZdfEtACgAMFeWkOwG9OyqXVfl7FVJ53rdxJzbuRRviVQ==
X-Gm-Gg: ASbGncuP+Oj0R9CvADbfjzUQiKuQL+RXJOmWEaxXwPyWUmqpHMiWOat+DoKPqkDmmY1
	KtdrIXfuD6XUKJ4fS2h3CkW0heD8U6ImkSVgMR1qFDGqTugTUN4Huf34P1hl5/r2m/2u5HUTadm
	0MEhh/0zUuf9TNjNjHOfYqG6QJUFfDjh7hn/nx5xMMHyGuaf8ZuZo7cn7oyJWCWioa+UiW9988B
	ZeRip6YCu4gbyeIDWJbLbIskPpTKbSHw2IqzZOTq6WWtS2Wvsr0TA==
X-Google-Smtp-Source: AGHT+IGI5K+UkU1MoxhADzo84MIgQv+qBjrtnZxs5rMBJ7//WjGQKW+FWpeOXMem3ogAxJdMMj3roQ==
X-Received: by 2002:a05:6a20:a108:b0:1e1:9bc1:6d6d with SMTP id adf61e73a8af0-1e5e07ee6e4mr90396081637.31.1735840974832;
        Thu, 02 Jan 2025 10:02:54 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbba0sm25459313b3a.107.2025.01.02.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 10:02:54 -0800 (PST)
Message-ID: <ac3eda5992a9fbee296abcbc917d5521da0be83c.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a
 spinlock
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Date: Thu, 02 Jan 2025 10:02:49 -0800
In-Reply-To: <20250101203731.1651981-2-emil@etsalapatis.com>
References: <20250101203731.1651981-1-emil@etsalapatis.com>
	 <20250101203731.1651981-2-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-01 at 15:37 -0500, Emil Tsalapatis wrote:
>  Add the bpf_iter_num_* kfuncs called by bpf_for in special_kfunc_list,
>  and allow the calls even while holding a spin lock.
>=20
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -19048,7 +19066,7 @@ static int do_check(struct bpf_verifier_env *env)
>  				if (env->cur_state->active_locks) {
>  					if ((insn->src_reg =3D=3D BPF_REG_0 && insn->imm !=3D BPF_FUNC_spin=
_unlock) ||
>  					    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> -					     (insn->off !=3D 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
> +					     (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
>  						verbose(env, "function calls are not allowed while holding a lock\=
n");
>  						return -EINVAL;
>  					}


Nit: technically, 'bpf_loop' is a helper function independent of iter_num A=
PI.
     I suggest to change the name to is_bpf_iter_num_api_kfunc.
     Also, if we decide that loops are ok with spin locks,
     the condition above should be adjusted to allow calls to bpf_loop,
     e.g. to make the following test work:

--- 8< -------------------------------------
static int loop_cb(__u64 index, void *ctx)
{
	return 0;
}

SEC("tc")
__success __failure_unpriv __msg_unpriv("")
__retval(0)
int bpf_loop_inside_locked_region2(void)
{
	const int zero =3D 0;
	struct val *val;

	val =3D bpf_map_lookup_elem(&map_spin_lock, &zero);
	if (!val)
		return -1;

	bpf_spin_lock(&val->l);
	bpf_loop(10, loop_cb, NULL, 0);
	bpf_spin_unlock(&val->l);

	return 0;
}
------------------------------------- >8 ---




