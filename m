Return-Path: <bpf+bounces-66479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6853DB34FF0
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08F47AFA09
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3302AD04;
	Tue, 26 Aug 2025 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0HKCoZj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537F9476
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166798; cv=none; b=tEbHFnH3BOBY4HLGUaMWIkBhr8zl3sm2F9X1N2jHzaGh2k5SUMb2GNkgMMoBhbi+KBWmPceS2upCDqLWQ+D6Nv2fgqF2+7vxM+xMMFO125hfwb/xCDfcXZH7p1oFWRubpTrmV4Gw9PAeJbjpcopONTCSVHbbfq+yoquz0OIsUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166798; c=relaxed/simple;
	bh=JW66/VC4EgEM6bqlpVpUhLK4IQAtG66uWPoGE9F+2J8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fF/T5kIdEodobGZPXPcQMq5dJfp9AY92kGZt3kQqSowfd0XV48dWEUk/dIqVgG2nZ+0R2xnPDOw4mr31qSbFQpzWB8Ru6VAjWRLCh/sZJ2Fisc6BskBmJop85/7e07jP4Y/2zcDdqloI0k6XmVaOgxDOs+q1iPHlduaB09iONRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0HKCoZj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47174aec0eso3243147a12.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756166796; x=1756771596; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRX2bkEol63rjzEPc0WTJuLG5Iy48sjPCFFmWpYmOJs=;
        b=Q0HKCoZjmAGrxqY/1ggMzTk4T0diuoJ01WX5SNQqgy7XeKdL++2ryKx+nOUJ3qbs5x
         Sr8hClhV6IT3x2AxLluNO2pG2er9tpufiATd0OPwolFlgqHQW01R79UMjs6r8ZcTrWuW
         Xz+daWYCg08S6BkPFs9sAIcjr8KLjySYToNFsSkqe+EiKnrvRb/TPZosYRkF73OHHY5w
         IE2h6CusWT+gHcEqvrkZUpfvAkC58Lr412/1Lq6rjNHmQbGbtMc0GVDHXeIHCZ1lyI8P
         mPxVoYY4VRW7+rZ8krnkRoPqWDRjIIfNYlCjLoWOFrgftohVMSif70CnVJYd7Wom56Ca
         6o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756166796; x=1756771596;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRX2bkEol63rjzEPc0WTJuLG5Iy48sjPCFFmWpYmOJs=;
        b=B/5z3fDpPsjZX1h2aO33uKnukiZo7miVMfCtBuEBneHSKD7zMjahz9XYd0T4+4x8+1
         C3D4+Lnr4BlllqAel2KS/wHiizp8f/wn9z4gC9Hm69E12KSWQLriz87Zt1ssdfnejHxX
         1j4RIlFrusNXyPDMcGfNLNhFdXeEVlJXaK8tZ31bErL+AfVSybK9li5OXu9+SydxS/CC
         xLjzPZw9VmrygD8e9boPrt2uTGrIisLqlPaFzQ8mJinf2QHBs51OIW6iqEhfklySua/6
         9/nUiKXy1q69rzQAl9Pl6+XxvIl6FovViVcmzq4JXmnB5/ySDqmvrDmybp10L6AFdQ8T
         X/ww==
X-Forwarded-Encrypted: i=1; AJvYcCWXAgEFgC74sQxPxUZXMSbu4vh//1LXSQW4iWLeSljUWe6DbRRP6jcY8TJJ2Tyk1E7Vfw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRer4rsG4LEZ3CKNd4UmtVrN2C16/vApUNV8jSsTr+/FBcRHFE
	lz/LwtGJHuC9iPlsx98LFWqxDtJLsDqZDwJ6ob1H4T/5qODNLIT4hDFxerXpTnHF
X-Gm-Gg: ASbGncu7tmgRuCPB2zss47qbPZBlYK417GbIP07pMwjAHbTMIVsvrVeYFmYVJ9s7JVY
	r6MRHyN0VMjkJS4BLXl6MDWRJy4zyC77qoK3Er5gRQAYnYPHhLyzAw7XFYjZikepikgjvYoOvL3
	+rcl7e53tJf6xOah3am3Na2ude8ilUws/ktMSLg+g/OeQDClYCBnqBA/7QAcc+gc3hro3qIGiZa
	64vcxcACGNIIyTIxInYrqQkJIxS2hJEjhf5JRWNkQwtBLBMgrmcqp5mELHlR57jOrSpIaBBE53Y
	QXX9VvhWcb6zj7rAGfHAhucxoU6htY01qmXHm+xDuBVKpwCOrDWQBaMEMeFf41jIahQkmJB3rJL
	i1Zfw1Ijf4dIHhGjDhKvZ1DyqCkZD
X-Google-Smtp-Source: AGHT+IEjGh/GYUfEGvfGcZSyEZ86ZTLnhiWtgAbfMWgxWbgzyhIHo7cUb14g7u/NrfjQ1Gt3UkNb2g==
X-Received: by 2002:a17:902:f54a:b0:246:b285:a3db with SMTP id d9443c01a7336-246b285a4eamr78155245ad.45.1756166796141;
        Mon, 25 Aug 2025 17:06:36 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:299c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254a1e5888sm8351720a91.12.2025.08.25.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 17:06:35 -0700 (PDT)
Message-ID: <69306a9742679ae8439fab4b415e3ca86683e61d.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 25 Aug 2025 17:06:33 -0700
In-Reply-To: <20250816180631.952085-11-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-11-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fe4fc5438678..a5f04544c09c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[...]

> @@ -6101,6 +6124,60 @@ static void poison_kfunc_call(struct bpf_program *=
prog, int relo_idx,
>  	insn->imm =3D POISON_CALL_KFUNC_BASE + ext_idx;
>  }
> =20
> +static int create_jt_map(struct bpf_object *obj, int off, int size, int =
adjust_off)
> +{
> +	static union bpf_attr attr =3D {
> +		.map_type =3D BPF_MAP_TYPE_INSN_ARRAY,
> +		.key_size =3D 4,
> +		.value_size =3D sizeof(struct bpf_insn_array_value),
> +		.max_entries =3D 0,
> +	};
> +	struct bpf_insn_array_value val =3D {};
> +	int map_fd;
> +	int err;
> +	__u32 i;
> +	__u32 *jt;
> +
> +	attr.max_entries =3D size / 8;
> +
> +	map_fd =3D syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> +	if (map_fd < 0)
> +		return map_fd;
> +
> +	jt =3D (__u32 *)(obj->efile.jumptables_data.d_buf + off);
  	     ^^^^^^^^^
    Jump table entries are u64 now, e.g. see test case:
    https://github.com/llvm/llvm-project/blob/39dc3c41e459e6c847c1e45e7e93c=
53aaf74c1de/llvm/test/CodeGen/BPF/jump_table_swith_stmt.ll#L68

[...]

> @@ -6389,36 +6481,58 @@ static int append_subprog_relos(struct bpf_progra=
m *main_prog, struct bpf_progra

[...]

>  static int
>  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
> -				struct bpf_program *subprog)
> +		struct bpf_program *subprog)
>  {
> -       struct bpf_insn *insns;
> -       size_t new_cnt;
> -       int err;
> +	struct bpf_insn *insns;
> +	size_t new_cnt;
> +	int err;

Could you please extract spaces vs tabs fix for this function as a separate=
 commit?
Just to make diff easier to read.

[...]

