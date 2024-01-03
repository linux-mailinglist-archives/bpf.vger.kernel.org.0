Return-Path: <bpf+bounces-18919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E618236DC
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EE72878CE
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3435D1D555;
	Wed,  3 Jan 2024 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SotbwQW/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E31D550
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a27e323fdd3so302889566b.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315463; x=1704920263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jk4E2R/o+9AG6f3bAAIF5AKhm0/o24OdwyjMpvIZ3iQ=;
        b=SotbwQW/MlzANXns590eOQRvkrXiyVm88OUobGl2yHji0uAiDK3vBCU85G+2BzIlcq
         tjVywE3rJPJUsK/5D1iAIoO2oxXaCjts7UzC1OWbk85IR8ITuzmswuYD07lFjJ+dScri
         yBgi6/LO5nMaz4p1daJVcEkjSh2U6kas+dCClbbggts1274a9zaGxc3TPo6sfXy2xMRJ
         Za0faNRZuxuTA+vJm0pDXRl0/GXYjTzAWqIzeeogY4BlFbKkwSmuH06JzvQWIV6wgl/Z
         HPJoDWVPp/+blXoscGIxBHj9hsU9pdq1g8MsdX/BmanchJUUNpX0CgUsyzChgtff74Ud
         Vnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315463; x=1704920263;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk4E2R/o+9AG6f3bAAIF5AKhm0/o24OdwyjMpvIZ3iQ=;
        b=KF8T2XWCOH87E5V+SwNVnOfOASzVVcue1A29y9h0ih0GrvSUZycQi47zBBeEhq63o2
         OBccNHChFy27VYUfK2s15NWXZ3azHHErCO9rGVF9uGWnu4MJ5y6D9YrU25AcXSFqN3M8
         PwM1o2ZgK/o8AliooquBqtOVK/yDZBRoxG93tJ+48CJwdvKEyzYi7oiplCJUCIR7HN+s
         Nu+Bi7IvWi2EAd55sXqNB8CNUdHmAhXDE6G8lqfKg/tfwVn5JUm/y6sb3A25RnP6b+EH
         YvG0SboL8GCH0xjFoHjMrRqpJ7Gh7c0iu1gHryE0iMV7CVZFqUJR+qzFeo91qxNiZ5CG
         LsCg==
X-Gm-Message-State: AOJu0YzByPbOgLugeNJjN3+9lIUSY4ydfpv2ANMjxeIAiNZ/mi++Ss6q
	G0FNE6ufazgXYuXjoITvnEs=
X-Google-Smtp-Source: AGHT+IE+1dmYWHuxfDJnL8hiWuUFH7EObwLpVSLN3YWdsYp5CzapbtJLn90L7SonMGYs+zUv23rtyw==
X-Received: by 2002:a17:906:7384:b0:a28:96d8:7c70 with SMTP id f4-20020a170906738400b00a2896d87c70mr655418ejl.6.1704315463515;
        Wed, 03 Jan 2024 12:57:43 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fu16-20020a170907b01000b00a28a297d47esm748277ejc.73.2024.01.03.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:57:42 -0800 (PST)
Message-ID: <75cad82e8e11b6049c99dcd2170fb445e2d3d2ee.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: implement __arg_ctx fallback
 logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Jiri Olsa <jolsa@kernel.org>
Date: Wed, 03 Jan 2024 22:57:41 +0200
In-Reply-To: <20240102190055.1602698-9-andrii@kernel.org>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-9-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 11:00 -0800, Andrii Nakryiko wrote:

[...]

> +static int clone_func_btf_info(struct btf *btf, int orig_fn_id, struct b=
pf_program *prog)
> +{

[...]

> +	/* clone FUNC first, btf__add_func() enforces
> +	 * non-empty name, so use entry program's name as
> +	 * a placeholder, which we replace immediately
> +	 */
> +	fn_id =3D btf__add_func(btf, prog->name, btf_func_linkage(fn_t), fn_t->=
type);

Nit: Why not call this function near the end, when fn_proto_id is available=
?
     Thus avoiding need to "guess" fn_t->type.

[...]

> +static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bp=
f_program *prog)
> +{

[...]

> +	for (i =3D 1, n =3D btf__type_cnt(btf); i < n; i++) {

[...]

> +
> +		/* clone fn/fn_proto, unless we already did it for another arg */
> +		if (func_rec->type_id =3D=3D orig_fn_id) {
> +			int fn_id;
> +
> +			fn_id =3D clone_func_btf_info(btf, orig_fn_id, prog);
> +			if (fn_id < 0) {
> +				err =3D fn_id;
> +				goto err_out;
> +			}
> +
> +			/* point func_info record to a cloned FUNC type */
> +			func_rec->type_id =3D fn_id;

Would it be helpful to add a log here, saying that BTF for function
so and so is changed before load?

> +		}
> +
> +		/* create PTR -> STRUCT type chain to mark PTR_TO_CTX argument;
> +		 * we do it just once per main BPF program, as all global
> +		 * funcs share the same program type, so need only PTR ->
> +		 * STRUCT type chain
> +		 */
> +		if (ptr_id =3D=3D 0) {
> +			struct_id =3D btf__add_struct(btf, ctx_name, 0);

Nit: Maybe try looking up existing id for type ctx_name first?

> +			ptr_id =3D btf__add_ptr(btf, struct_id);
> +			if (ptr_id < 0 || struct_id < 0) {
> +				err =3D -EINVAL;
> +				goto err_out;
> +			}
> +		}
> +

[...]



