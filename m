Return-Path: <bpf+bounces-61769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E8AEBF7D
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 21:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7281739BE
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33B0202C38;
	Fri, 27 Jun 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsXfhXEi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC761B423C
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051565; cv=none; b=m1mz3drXg09rCPmDD2ACqFpNGVzPEAHeIb8N/Y8phON0N7vXb1kh2RmKIIYttfo+fwmCVC4WppHxDCOf7qe4yeiKThxPgZD15NzLKSVFM708ko2qEQyPfTzDG9zwKN7nsWEu5Z+3JeeMvP7ArYiM3AHY/pD1/GjzG8zmrOyjXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051565; c=relaxed/simple;
	bh=1I4hcPF8vL7j8rCuEnvEAsLmRHGMxXWnQoYZQDckyKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plq+hTH4PUj9girDISIkdjn+6Vgq5clUYeqwCzwGs2TppKslB46ZriHKoI7P+kWKdOWekrwgigx49CFvN+U3edEMwmUttpf8o29nK9uY0y4F8vGY/K6C9RQ7B2uKVq6XyHXG5ifKtzUAuDxp/aJIbzToKftx+ULWd1RgcMkPwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsXfhXEi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2758327b3a.1
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751051562; x=1751656362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U7XDGJWbkZWuu1AK/ntS5xDYsAi4X6Wpa0mR1rr9lxE=;
        b=IsXfhXEiZnDQemWCYrMaiJNVJIlgnS3q0JjghOKofeZRV1L1R39RKC60RHUeYhk+Rt
         dXBWgC1PesfQxQAQaDMJUTn1txmbIVpd96fWymM/cK7Dkku/MjyksXp5CSIiMaZcBrAa
         XcrOzhs6JcnzxgoKhmBBb7jRXRjFkV3eB8OEI8CDe854cRV4DBFtmwAno9gHMMl3L2vc
         DU3qVRcrIksTr7JB4NRiwW5qszce7DKMDzkfzIKdWbVAlWa44caWi1OCg1CgQCaGNaix
         NZYIyRlQ9ke4NCS6G/rgZVGC2cE1AgGDWQ/yMPaU5HqFPk9m2CPSHzhwUQuBk+uO9so2
         p3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751051562; x=1751656362;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7XDGJWbkZWuu1AK/ntS5xDYsAi4X6Wpa0mR1rr9lxE=;
        b=Mn65bL4bdAfaqs+F2C155Q6LJmL+EPCtnYnNSEETdXzlZH5xOuozwlUGcdptUMuu1o
         qpSBgFxw9oveQhi1Q6NqB6W2/wpDE8sKCFfNia4IBBZV3kWa5SYtPv3i1dOECC0eNVzQ
         CLKgNi64yAvECJ/wKzUdJl6NYfNXfo+6haqoCJXL46RyzkD9mKsPLdWId60eWatvyP09
         TUacHU98KU0ynsmJcT8WoiiiW2k5lPwZwwV7pm19LlMstHwiPNdS89yHIJTo1tjFGT8Q
         AhL8qS0EINyw7X4fb35GdCp42Ru/+FCXPooXVIYhFtWdyIs1yJILtgvCiv99XmNd/ZOh
         fNXA==
X-Forwarded-Encrypted: i=1; AJvYcCWU0BM0pfglZRrv2vyu/sLVsJYrN4QItPj4JdnRbFTsapRkdUF+y1IE1UWR9C40YWEkP3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmC4b6yTpYjhqd5YXkCwPxy3ezlLq0wyzC4AbQEc+SFp501Rn
	k3V2pm3SE1YH5tnaPeKQNGHqMZVPt8xBXh+YkbifsBaxIct6i4guJ6v7
X-Gm-Gg: ASbGncssS3YPRsjs1Yr1FFTFTPtOBWLo9woTO9RV0ZqznIQMbCwHmkevBtLF2JXCNcO
	zbVNYrMOvX9C8882U01GXhsAo2/us6JxnFkCV5t1VRmqvq/BGFYUrLO5KRq/eDEVYZmamT1zSPA
	5HqpBQwSNJ4ASHqmQGCyU2VtAOeGtSh8QIGF5buB0qzPoErjQB4M6JiTy1ObRDjITBtj+Fqfp57
	BTNfH+plIgq9yfoedm2Cr4I6gFfu9r2s7HX4aIK0Sf9GG/VcZMqyQ/Pi7CbiD97/yvCQL0UPUOi
	edcyWW1ZpXSSFYgBa4dqaELprArncPaOnBvW57LLdpmJT/aQQJI7myHSxOc=
X-Google-Smtp-Source: AGHT+IEfFp1UypttLQOxAv+AfFRnAVTlOjhApTlc3/nVrG9MKjLoZPkLJNkP8cBik/KLE8SQ2E+2MA==
X-Received: by 2002:a05:6a00:88c:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-74ae4130d45mr11919507b3a.12.1751051562007;
        Fri, 27 Jun 2025 12:12:42 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3026c51sm2150813a12.30.2025.06.27.12.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 12:12:41 -0700 (PDT)
Message-ID: <c49fcfaf3b622b8e71e33a3928c6494f29aa486d.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: improve error messages in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 27 Jun 2025 12:12:39 -0700
In-Reply-To: <20250627144342.686896-1-mykyta.yatsenko5@gmail.com>
References: <20250627144342.686896-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-27 at 15:43 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Return error if preset parsing fails. Avoid proceeding with veristat run
> if preset does not parse.
> Before:
> ```
> ./veristat set_global_vars.bpf.o -G "arr[999999999999999999999] =3D 1"
> Failed to parse value '999999999999999999999'
> Processing 'set_global_vars.bpf.o'...
> File                   Program           Verdict  Duration (us)  Insns  S=
tates  Program size  Jited size
> ---------------------  ----------------  -------  -------------  -----  -=
-----  ------------  ----------
> set_global_vars.bpf.o  test_set_globals  success             27     64   =
    0            82           0
> ---------------------  ----------------  -------  -------------  -----  -=
-----  ------------  ----------
> Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
> ```
> After:
> ```
> ./veristat set_global_vars.bpf.o -G "arr[999999999999999999999] =3D 1"
> Failed to parse value '999999999999999999999'
> Failed to parse global variable presets: arr[999999999999999999999] =3D 1
> ```
>=20
> Improve error messages:
>  * If preset struct member can't be found.
>  * Array index out of bounds
>=20
> Extract rtrim function.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -1955,6 +1967,8 @@ static int adjust_var_secinfo(struct btf *btf, cons=
t struct btf_type *t,
>  			break;
>  		case FIELD_NAME:
>  			err =3D adjust_var_secinfo_member(btf, base_type, 0, atom->name, sinf=
o);
> +			if (err =3D=3D -ESRCH)
> +				fprintf(stderr, "Can't find '%s'\n", atom->name);

Nit: adjust_var_secinfo_member() already reports a few errors,
     maybe report this error there as well?

>  			prev_name =3D atom->name;
>  			break;
>  		default:

