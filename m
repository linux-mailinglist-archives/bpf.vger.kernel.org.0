Return-Path: <bpf+bounces-78758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA97D1B77F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 22:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83F2730383A1
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7934F486;
	Tue, 13 Jan 2026 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evvsGCwc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58730F804
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340806; cv=none; b=OZkH9s5qVczuSfUYVvRc/NWexaKq86iHx/wWxVx4N+KdY5agZ323q0BcBFCjtFLE975CRePBkpErlpTtN0pTibtFWJ1dzfsOp08dH/+M1V+/JBGK3kotKCQu9MTAShpjkDBy5TT2NoSKxBpivfTqb1EyxrqHy4LkLDv1PISrl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340806; c=relaxed/simple;
	bh=1jZx4RujrQv0oh++qf8KOC2l8wTKl/TyrVIsGTQ2WCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u2sxwoz0ddAxVRFKQ5De7vkrjPGMbaPwvHavn+7QhSoxBgqPsvFwbuMYRPBhZaYhpJlKmIMXMonlqmuobzXf7gxY0MydAGVuPT/37OI25sxJ4q01pHoF5KjWDEdmynzzFvjlX0leJQ1LO5j68D3eScCLv+w1/Ph+oulHPDG4oNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evvsGCwc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c718c5481so4370495a91.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 13:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768340804; x=1768945604; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1jZx4RujrQv0oh++qf8KOC2l8wTKl/TyrVIsGTQ2WCs=;
        b=evvsGCwcFpYZbHsEE4mPGqT1cju1ZwXEN8uHjzCvX1hO06J7hPR/QLrZza5pqlp8oj
         BRHbSVzNojbr1qYSUcXsJNm7DTmcssbmYLfYmEb+r5XQKNeQdP5w/kxj4RQapkyd4Z3n
         1GhQk6iAhkylpzNvjET/fjyVRk3aOZeXCHtMpxQOP21TGEAUnPHhUilimRop750vYXC4
         TPZtqxCXa1EeL7U9K7JkExkuJmGWisM7+StZlSfn016RrC4MXmRhXDXdhQTOrFBHmlbD
         Eubyk+U/F+udjUYW7jlvx6Ik1nrKG90D3efYtzcQqd4X7L130TUlwisgCPAd70sqwJQp
         eYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768340804; x=1768945604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jZx4RujrQv0oh++qf8KOC2l8wTKl/TyrVIsGTQ2WCs=;
        b=Wt8rvwn7SsqZHl6wXKlDqibQ4p67g9ZY8XiM2eYFCgOvNNheanytHc4Jx90ANXZQdY
         3TwrG1ZfaQuwqe5vhGRAXTP/46UPjpJTVnMp9vvsKxSKgZXbyB8Jy8bUZ4dZjj04o3P4
         9jBN3wysp3OaIwutX3i/tP7VWph/MXpR9J7Vq2Xh9HBhHln1a7UFZb2YnPQpJX79sCEs
         +8t6CrMEC7FdABhZ94FLPgL7qvChPVxTffWU16tkQUT/0O6WOc4hTDx2xLv/62oEjNcU
         V8QUktvQN7UK61zGF1muWqY6eXvjuOchc9/F65MrPC75KI5kaynUa/Pgd6YVGoignLc5
         DMKA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Ibj1cJ76rsMGA7lIqnQImov63WUql57F75dFGF5yLeufsBJuUB+4KrGzH4HZRxII1DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi01lA2H17lP+XybAWaBGZR0pSwOYsmA63EsCRXz3w14l/NTBo
	bxxq3HJq5m0ZHTjD2srR3/jiv/Mkeylp+Yx5z9UJOMznA6dQV42Nvvwx
X-Gm-Gg: AY/fxX48l+D+6oZ1fEgz3M/PnWJbvF3ZFlf4AWMsv5Wc5QndM7D9Ki5Es1u4EUZhFjA
	ce1qgCNq17MAdPvfHvds1GeXN4+6EHRI38jcyATfOfd6qPX2DEC3WJllxl1uUqsxb6KhmeCedS6
	CkvhTxavzy8pXGuwvnB6CmNvn5deYRFjFlcudzdp13iJraX+ul67qOt/mmIVY68qCdKZRkobuys
	MEDMWVswfGubCp3+oDg/WfVlx8UOFQKlUcbYPsbVk+Ai1BhxOdUz+4XGGTPRFvIUfgmfFX6d3Gp
	gxCwMp1BZqeJ8nZpFksRxFtUPmYo18N4UxKUluphCiTYXEkrr7rkqISoAY4yalTs6SPGbpRB7vQ
	JLbPB3jXp736r0ycQDzXVU0ZFaRd0x2w2O7NXaaF2tyUjTye/j4DqItmsZnx+xAg2hDP4bp24/a
	Mm63T+x8RtRscnVpGext9WdJfSUXdvSiM4NEAWT0Hc
X-Received: by 2002:a17:90b:274a:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3510916bbfemr407849a91.36.1768340804404;
        Tue, 13 Jan 2026 13:46:44 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109c5660esm73834a91.10.2026.01.13.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 13:46:43 -0800 (PST)
Message-ID: <eda8a78a2c102751c9726960cf5d7cb24985f23e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/10] bpf: Introduce struct bpf_kfunc_meta
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 13:46:41 -0800
In-Reply-To: <20260109184852.1089786-3-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> There is code duplication between add_kfunc_call() and
> fetch_kfunc_meta() collecting information about a kfunc from BTF.
>=20
> Introduce struct bpf_kfunc_meta to hold common kfunc BTF data and
> implement fetch_kfunc_meta() to fill it in, instead of struct
> bpf_kfunc_call_arg_meta directly.
>=20
> Then use these in add_kfunc_call() and (new) fetch_kfunc_arg_meta()
> functions, and fixup previous usages of fetch_kfunc_meta() to
> fetch_kfunc_arg_meta().
>=20
> Besides the code dedup, this change enables add_kfunc_call() to access
> kfunc->flags.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

