Return-Path: <bpf+bounces-37746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D695A353
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE22A283957
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1C13635B;
	Wed, 21 Aug 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaVFS2lR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE4192587
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259606; cv=none; b=Kf9DFWjT64X2jVM62wqokBT3bK/RjpMbl/nr6fTw3BR/7XBISFEhQLhlLSKCsgOwNS4tTM5yGzbwy+/paSjJBdciWXu808PVJkx+sLCdenP+nXp0jT4HUP0sU8091YriMNY5L6bHkz8rbx6vKvK9RQR60EIMtULZvLrC1xNoFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259606; c=relaxed/simple;
	bh=+l0BSXuAEIvi2Ml2vxhe37Efufj5YCo/H9neVoMvfb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jb3jPmtz8YVqezkQZKPyT8CnG7rXYPLycTbMv708w2TV2Xym9VONtWmKwUz9ZopX51PKmF0+nv43eMaW493SLJieqskvon6qKkhjHAIhIPB5DHIPCfT3kVaSq0yRcBR8fscE38B13fhbq2YPflRaGXURg3F6or0VcHzSD3Wjmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaVFS2lR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7b594936e9bso4877967a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724259604; x=1724864404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5mJ3eCcKwCNqt56ITom8FRz2Tr/GzzoLi16z/2t7OQ=;
        b=OaVFS2lRGQH2E71K5O5ak36jLlBcBLdl0CJctHOf8ajK9bP4wJQ2QAJELBzfYo2mzM
         ptBLo1g666P8PoNq5/FQPSoLPVF3fd/UbOcvg0eNYDgC1WgI9UpAnEooh6MieC02gnPj
         Luk29mpTbo+AKziW2olsjON8AqQYSNS5uF16sl06/s2EdsMcm73nlVw3AljcS2lTNE7j
         U2ZnqRR+LrSEVZODKeu/ZsA6jKkLCHiOUlrLLwtXToQND31z1AciMEzZ3DB6UgG//lau
         WzTowDwniVK7svnW3aU/hiy1XjQQOGpWa+tagfInrNQ5P5oORuWZ+bDwnWkVnV+oAymp
         ZnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259604; x=1724864404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5mJ3eCcKwCNqt56ITom8FRz2Tr/GzzoLi16z/2t7OQ=;
        b=ozMGoWw9A61dQJMrUEFB8R7+QjzqqJLqzT0GG9+1p1HQkYp3f8wqOMyztuxTXqpYb3
         d1NqEkOGVC0mOWZn7kZJdUfGa4P1sAmSfsvxSJqBxTlTsscImO2kjvLRUhsQ70qWmDt7
         /FBf1rdPkAE20Z921G0STL7738TJYVkqs+BkXnD2n74QuBDclKYwxLsQbpyy6LbKbY/+
         ApeEjVocv1htnrn/esLtPNCA5SwyOIKHwl0MzQFVqbTeSNF0CoknI/jJ/lL8wq+W/hcW
         eKVMCX5/zYxkowlfkubOBsY6XNNGXVTY6cuT5YLz69Yaj7mB4yyEIV/kCuUGO36T5/PK
         X3fg==
X-Gm-Message-State: AOJu0YzRnuK6YsMpd38qwYp/lozglXEHFqMQkpeM3qP5eysC2KoGE0co
	QfLwaaY4CNc3rb7bHpQwZDiwtD3IM4elfLTxDo5h+m4Arc9/YIdo4f55Ba9BcvrxkBhQ26rUj4u
	YjY5KmZiTmSjBXqi9Z3D0kMvGA1E=
X-Google-Smtp-Source: AGHT+IG1hTlpd7D3N/9j2gRP/Dh1gD3ko/R1ZqelFpgdYSES/lzM7YIO/9HlSEx0sxUHiXuyBEycq/tSk1qyfz24/zM=
X-Received: by 2002:a17:90a:68cf:b0:2c9:90f5:cfca with SMTP id
 98e67ed59e1d1-2d5ea9a2c9amr2997633a91.42.1724259603586; Wed, 21 Aug 2024
 10:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821164620.1056362-1-eddyz87@gmail.com>
In-Reply-To: <20240821164620.1056362-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 09:59:51 -0700
Message-ID: <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify
 relocation type id
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Liu RuiTong <cnitlrt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:46=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> In case of malformed relocation record of kind BPF_CORE_TYPE_ID_LOCAL
> referencing a non-existing BTF type, function bpf_core_calc_relo_insn
> would cause a null pointer deference.
>
> Fix this by adding a proper check, as malformed relocation records
> could be passed from user space.
>
> Simplest reproducer is a program:
>
>     r0 =3D 0
>     exit
>
> With a single relocation record:
>
>     .insn_off =3D 0,          /* patch first instruction */
>     .type_id =3D 100500,      /* this type id does not exist */
>     .access_str_off =3D 6,    /* offset of string "0" */
>     .kind =3D BPF_CORE_TYPE_ID_LOCAL,
>
> See the link for original reproducer.
>
> Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type_by_=
id().")
> Reported-by: Liu RuiTong <cnitlrt@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X=
3Y9+p0sWzipFSA@mail.gmail.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/relo_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 63a4d5ad12d1..a04724831ebc 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1297,6 +1297,11 @@ int bpf_core_calc_relo_insn(const char *prog_name,
>
>         local_id =3D relo->type_id;
>         local_type =3D btf_type_by_id(local_btf, local_id);
> +       if (!local_type) {

This is a meaningless check at least for libbpf's implementation of
btf_type_by_id(), it never returns NULL. Commit you point to in Fixes
tag clearly states the differences.

So you'd need to validate local_id directly against number of types in
local_btf.

pw-bot: cr


> +               pr_warn("prog '%s': relo #%d: bad type id %u\n",

nit: this part of CO-RE-related code normally uses [%u] "syntax" to
point to BTF type IDs, please adjust for consistency

> +                       prog_name, relo_idx, local_id);
> +               return -EINVAL;
> +       }
>         local_name =3D btf__name_by_offset(local_btf, local_type->name_of=
f);
>         if (!local_name)
>                 return -EINVAL;
> --
> 2.45.2
>

