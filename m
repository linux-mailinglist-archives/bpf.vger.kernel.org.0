Return-Path: <bpf+bounces-30799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449A8D2850
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453701C26E9A
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42C13E881;
	Tue, 28 May 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp5iy6w4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BE4D59F
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936802; cv=none; b=G7fhNQ47apU/9uJph3i2vIjxqei1EhCcKg5EmgqluNBvwnTn7yXOb1C7Nx6OImoMf/Hz7cK6gOHJ7Yz+7YB1qc1KOEIzfwU5B1+5KVhMjsyKJ+td6VvBQ9d/rvCELsH7OXwBL3IsXcQ/mh0ayDGN7vm9Ex4bUwOpcevdfPVc6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936802; c=relaxed/simple;
	bh=Ian2I2qr87MKWEL6/L7yORw1/BnTFsp6jXSy5W5PHF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hl/YsmUniD/qR7uVNQaRrwYFOxJsqXHhRvFeNh3hVU2RaHuirQZ/qQKraCNKR0RgXqE+r8TtlUwlh611vmZ7DyK8A7hmdGAm1QDCWZc0SNKPFfyAB1k5ecmLzhc5CPJGIhaoBngyIB3Dx/KaZG6LOmX8jGNYxsQqcsg5TCUmNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp5iy6w4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f48bd643a0so11131335ad.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716936800; x=1717541600; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TQ/vkyi7YYsxKJO+CQndLthK9h4X0AqwDJIQK/tIiFM=;
        b=Mp5iy6w44MJTNc0lUbjbuQetWGkro0PhLkUUN+2S1//Rfqxy+0i9/mILQsx7WqcngC
         FMK5CB+VM8Jv22rFHKYKi6dNit8RriuTDhgRMLA8hzMv+B6fvdiWnRok3rsqRzeCL2wy
         S25hJhwVr7BKhV3KsyZ/JlFZS548MEjQGl09r4L2BwlcIz9UZZwKPnkVIrgGueofvb36
         DPEvNot1XS34jeOPAvxk/QCeZ5/wo+fZlyo/kmjGpjKDW8ZWEUhjOqtWZ077UB5VPIOI
         GKhCeqo9r/RNGu9qMGXLxMRTzu246RACdNljcBum+t4p9UetCsNPoET2+YDSjwW3hrUp
         pHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716936800; x=1717541600;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQ/vkyi7YYsxKJO+CQndLthK9h4X0AqwDJIQK/tIiFM=;
        b=T/Gc9IghAsHdJDglmCwTiGGVRDmjfixxow3K5qSY9dyq0yJQBSsuEO/yZ3mXrBYRLB
         NlQxmIDfLuZJ0rkMbyVEkip4z8uZXwJ8Nb9mDvyzFGHqR/P6tSJagEeCrXuEZtugAHVj
         YOCsPwZ44oib/vIi9jsd23dt4L0jZhJvQoqP7WwTBCujb7XT6IOUxSE2Gc/Svfs0SuYM
         J6SsFJEuEJJbSptahuZmlDGwZGJbe78z5Rt1IN8iDOCFSz4as+HwhcEi3V/5BGdMhJiH
         WTMW4gWrOnEmgK8MOXOL9rrMBbIUvtMgPJoWu8+k+EEWtWpLnXhlpKpaYw8n56lWRnfM
         nc5w==
X-Gm-Message-State: AOJu0Yy39s6r7yUP82SEx03p1tHeH7mJT4qWEg0pISsuOL/4X/8IATn9
	qRmrp/IB+yyIw1LgKQWy6m/qE/iR3azhpGIMd/Vh5hK9dXEajMIB
X-Google-Smtp-Source: AGHT+IGvWiIWpDalR5qw0vuaSKqTBbN7l0fTTpiTHGbBcnasI7oSwQPEniuot/bHdNgguAOXDUBYrA==
X-Received: by 2002:a17:903:8cc:b0:1f4:64d6:919d with SMTP id d9443c01a7336-1f464d69460mr127902275ad.66.1716936800265;
        Tue, 28 May 2024 15:53:20 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c760a21sm85870085ad.4.2024.05.28.15.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:53:19 -0700 (PDT)
Message-ID: <dbb51b28cfcecc8461f9fe002869ff3206eaea14.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] libbpf: API to access btf_dump emit
 queue and print single type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, alan.maguire@oracle.com
Date: Tue, 28 May 2024 15:53:18 -0700
In-Reply-To: <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
	 <20240517190555.4032078-3-eddyz87@gmail.com>
	 <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[...]

> > +/* Dumps C language definition or forward declaration for type **id**:
> > + * - returns 1 if type is printable;
> > + * - returns 0 if type is non-printable.
>=20
> does it also return <0 on error?

Right

>=20
> > + */
>=20
> let's follow the format of doc comments, see other APIs. There is
> @brief, @param, @return and so on.

Will do

> pw-bot: cr
>=20
>=20
> > +LIBBPF_API int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, b=
ool fwd);
>=20
> not a fan of a name, how about we do `btf_dump__emit_type(struct
> btf_dump *d, __u32 id, struct btf_dump_emit_type_opts *opts)` and have
> forward declaration flag as options? We have
> btf_dump__emit_type_decl(), this one could be called
> btf_dump__emit_type_def() as well. WDYT?

`btf_dump__emit_type_def` seems good and I can make it accept options
with forward as a flag.

However, in such a case the following is also a contender:

struct btf_dump_type_opts {
	__u32 sz;
        bool skip_deps;		/* flags picked so that by default	 */
        bool forward_only;	/* the behavior matches non-opts variant */
};

LIBBPF_API int btf_dump__dump_type_opts(struct btf_dump *d, __u32 id,
                                        struct btf_dump_type_opts *opts);


I find this contender more ugly but a bit more consistent.
Wdyt?

[...]

