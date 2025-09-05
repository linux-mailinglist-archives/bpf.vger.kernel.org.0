Return-Path: <bpf+bounces-67601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF8AB46308
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03637A6605F
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1488169AE6;
	Fri,  5 Sep 2025 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy9CS1GQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608F315D54
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098855; cv=none; b=qjWbRtLCiPbcWmqLKNw0brpszQL5dHtzp7xji/zu8RKRAyRoJoUEjLYGuMd9BYsrRNtDSLf1XDX8L/AsT8vd7d2CzbegRnAQfZqPp5j+xXEVRxVIhE1VS8fVjMfU/oAK/K/+i7PGm1lMeAMUDfxFJWI86sl2sv/V+DZKv3Tanrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098855; c=relaxed/simple;
	bh=8nX0oZew9Z5R7YNT9kp1PTTUngdRJp6axQh5cSmURFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWYNtdddJP79Ilb6kkAr8lPTDJdey8UzSUZumnJbwozuL1ECs0qkgq8HYG+TIp/H6o+nu3GRoEQr1cdoKdFsBI9yqgq8GJGl8Ba9JfhTBpYAYjbPStwymR0EWPhpd2wtJxQyWrTUE48Jo3X7LOSZk0eThphDZ2UXuopGBPk+XTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy9CS1GQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b471737b347so1612809a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757098853; x=1757703653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ggFjnxYQ+lpmMtnlQk6KEfXdqIoCy7NaBiyhzeA2y6I=;
        b=jy9CS1GQ6z+s4HuSX/p/Uh2Qr5/g5PWYN+26xIwTsAas52UrvLH1e0sV1M0Exsg7j4
         IwUVlNo6tKijRZwmlTgzKxZnDeFDC/YciYLulNCtMn6cAJLU1KI3kYnqFsY2LufvzRw3
         vWTzaL1qFkeQMAY1DLdxJJfQXBVBT5hduQg0rZMnb4xAS+h3BS18FKcyYXN+G0aFJ+G+
         YFBEWJlNgzGn91RN6hX/Z0lYOY/5VccnpX9nporVlPHU90unZulGJveJJJZ62bBk2mlo
         U96TzCu3hjhaES9CTyKp2kaUjM3TIRtrvzoo/WC2JNJEa2znVZlsjYHKXSEsNpuGD6C6
         fFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757098853; x=1757703653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggFjnxYQ+lpmMtnlQk6KEfXdqIoCy7NaBiyhzeA2y6I=;
        b=bQIVlK5Xi/1EWqnSWtO0BLCY3Hyp+PbqU04QDyeFOt5bT+kTz1/RNI6JyIhDb3BQNI
         RXArKqIfZnNLt/eedEV68heEAQ73iIby2MEE+wTHOqqNKjl1jNIfTYdTduwPtyNw6TmM
         +PyrpzyfEdyzG5w0NLjCkkfPCzs1e9KinEm0JYffwRH/iwq2Pn0oSlyL/cZG6sPfukRe
         jbG0Gtj/K//PMSlrHJ86e8g9+K/20HxWnnrvxOT3ZzXmUdilfzQ+UHUuYhnwQMeYz/bn
         Dj27oOJYV9inItXcwCNzl8aFUjQNynUld6aBRn1CJCUw/6DUaut4FCVk0P6lFy2+fCOy
         GcVw==
X-Forwarded-Encrypted: i=1; AJvYcCUuDfvfeNnnTsxcJukW7bbxivJUTLTLt26Lh0WIH8xVKIO3kSuZ5ZCGcG7gGBPtMzZgF28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzst5XzmNDsEm9W6QtjL4BV0V12UzZ3m4WVWUuwp5LjMsvAEm8
	k+74FJPKqhzWZVB/bdc68RBf/mNybbSeDqW8r0npXOCs/c/4xsjA207f
X-Gm-Gg: ASbGncupw++aTs1rNbWmBmguMeepHN1tjpVNE9sVWfPSKhb6GemdQySXYM21ILB8dHu
	b29K5OQpyvo6QT7xwHhhPvfe0xfxWoSjAxSwXR2nYsiHCYpEJHEynbycXN4W+Dh6ssx+VCrObnS
	+UI03YccThP42YmWkeMBH5ZoGXbAU8qH0t/Ps4sUClackzk7SvtKn+MVzwMpCNe8et9KSqLd/I6
	1h3lRztAOP9JrkAzdmLvNAujD6XEAqZxTbrh2o2n2t9+3DHsrn0SmRBEkloY+ikHcoOEdehU7yL
	diai/d5c6JnUefhq6q1Y45SrT6/t1kmz/h5hM9cnPO9/+q/kC4qY7649qIOvilo+Ri5jClnpLNo
	fwZghCnEZeVvg9W2YZQ==
X-Google-Smtp-Source: AGHT+IGELpA2+skSYzHOVOi27/bXmJzkfv/xsOfUKiQGHi157aybG98PZjqkU3VVtvZ4K77+WSg5cQ==
X-Received: by 2002:a17:902:e5c9:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-24b2b076552mr184221735ad.29.1757098852892;
        Fri, 05 Sep 2025 12:00:52 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c965558b8sm76886355ad.68.2025.09.05.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:00:52 -0700 (PDT)
Message-ID: <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 12:00:48 -0700
In-Reply-To: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
References: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 15:08 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Add the ability to dump BPF program instructions directly from veristat.
> Previously, inspecting a program required separate bpftool invocations:
> one to load and another to dump it, which meant running multiple
> commands.
> During active development, it's common for developers to use veristat
> for testing verification. Integrating instruction dumping into veristat
> reduces the need to switch tools and simplifies the workflow.
> By making this information more readily accessible, this change aims
> to streamline the BPF development cycle and improve usability for
> developers.
> This implementation leverages bpftool, by running it directly via popen
> to avoid any code duplication and keep veristat simple.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Lgtm with a small nit.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -1554,6 +1573,35 @@ static int parse_rvalue(const char *val, struct rv=
alue *rvalue)
>  	return 0;
>  }
> =20
> +static void dump(__u32 prog_id, enum dump_mode mode, const char *file_na=
me, const char *prog_name)
> +{
> +	char command[64], buf[4096];
> +	FILE *fp;
> +	int status;
> +
> +	status =3D system("which bpftool > /dev/null 2>&1");

Fun fact: if you do a minimal Fedora install (dnf group install core)
          "which" is not installed by default o.O
          (not suggesting any changes).

> +	if (status !=3D 0) {
> +		fprintf(stderr, "bpftool is not available, can't print program dump\n"=
);
> +		return;
> +	}

[...]

> @@ -1630,8 +1678,13 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
> =20
>  	memset(&info, 0, info_len);
>  	fd =3D bpf_program__fd(prog);
> -	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=3D 0)
> +	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=3D 0) {
>  		stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> +		if (env.dump_mode & DUMP_JITED)
> +			dump(info.id, DUMP_JITED, base_filename, prog_name);
> +		if (env.dump_mode & DUMP_XLATED)
> +			dump(info.id, DUMP_XLATED, base_filename, prog_name);

Nit: if you do `./veristat --dump=3Djited iters.bpf.o` there would be an em=
pty line
     after dump for each program, but not for --dump=3Dxlated.

> +	}
> =20
>  	parse_verif_log(buf, buf_sz, stats);
> =20

