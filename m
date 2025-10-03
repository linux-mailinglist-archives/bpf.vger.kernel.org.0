Return-Path: <bpf+bounces-70348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14454BB8275
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 22:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2803F347FB6
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2912561B6;
	Fri,  3 Oct 2025 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bek0Jl8A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C39253951
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524962; cv=none; b=F7YVV27RkV1r0kdxir5ymgX1ty+fC6cqa7D2UX3gaIXV9d5kHCQ2nCggReswzNupgJNoGZvSpj0uoccCNoLLRJSn9Kc7zZ8G8hd6U5auzSY1pj72P2qlu42lychN8pf0VskjeNm3B41V/HNU/jQz+An13kPKD11RbuPMhkEfc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524962; c=relaxed/simple;
	bh=kQKxWsJYWGBiu3r9z+ydgTg6h0I031P2oPHazB8Mav0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYf5uJ/qB/JPRay/TfotkDVewxLNJSyE1tNT4AaS8B1JATpUPcfAMoexKD8rJlP64B+iyNAJqATXa3UDpk9/vKao9Knv0NdylxSQTC8Yg+w1R12eVTuAs0hWyrGNjjU7w6ChEBt0UyvcP04Ejvelc4zxLLI6dno3+x2GdoK0Jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bek0Jl8A; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781001e3846so2597929b3a.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759524960; x=1760129760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P82+Y/Q11F/FW9yN2ByuEoJSA0Xzp0+F6KEgk+frRAY=;
        b=bek0Jl8AICTkJkTHJyKTDVYXqG9czsqiDO8YlnpmHQbRjJIFNKR3EsQLIMIBQC/a1c
         +dwKRMWVF0mEJFOFyUnDXgH7eNtvxtCH4vRDyewhTRkC+cvmQYs/Tc4SWpaSVQnpkU08
         u9GdYm6fLa6HtgtM2CiAn/pbDmCxsHxvohqtGLAklocWGPTyZDs5gZHQhPfXP5Bi4uV2
         oo70+QTbcMb3Yagawt3Fp+cuFQoebQvh5oC08gNXSmDfdhq7xTzYLKqRwy1l5LL4RuxX
         eXRGIORRgJ4WGgCmR/9Y1mdx3HWnMGIzjj5g9YDqvxuAdwnMQwlo4MGLJQDvv9EONBvw
         p51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524960; x=1760129760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P82+Y/Q11F/FW9yN2ByuEoJSA0Xzp0+F6KEgk+frRAY=;
        b=HIkHoLdngavKFM+EPynoR60v4WGxKGAbXHGDD3H2o+fqYw8QifjpSIK8W5d68usxDt
         HxrcZm9OQv+JrKcu24c64nMYIyrKPSe0wMcPypacNs64/QV8z9Qywb5Glbi/aYV5akW6
         QEWLniaI1Qbilp2GxghD4hwe67LwZzpmeP42mHOCXnoiYcuGBgCSZbjWaGjGZXBJ+ub9
         xJMRWzbXFZ8XL9VOmNAwLIxEFIUPt0e5aClm2de47Y/pFmtSxt7Iy9i6whs5eSP7moRE
         kFqHfSJnHlxxONQoFioD4NckYSJZd+LWIjcWXbvzQ5MhgXcfc4qZ3K7oTQFtWG4FJ1/6
         VUog==
X-Forwarded-Encrypted: i=1; AJvYcCXYZZ88veHxgBA0xzn0YMksARuBy8sxRSzhNh0ZAb/AjwyGT2F+RIctlbT2rRDbr4OV498=@vger.kernel.org
X-Gm-Message-State: AOJu0YySU3xREUvZGb2+zdgs8ahoWvMCDzXUbD9n5S0knwY1szirfpfo
	hIqOWmheeZNt/ffDjXhVXgIo3uQPxK3ZBEOXq3/hBHoPpIjXaxxVkp4x
X-Gm-Gg: ASbGncuMFhhbX9GBpwcxJlyLy7qxt7nwADSEMeNCxuIfpRm6EX9AzWAH6aXtiPMzXBK
	WTCWUnJksuUbGbJ2X4e/4thWHVv5C1AsoUdJDVHpw6vf7lepdmkxAhIIYCnsNROFXPoeaX7Jkzj
	lTX7yw1HI8uaSXBP7nNwKrv6Eqg0wRoC9kCns6PJ9r0muemWmu+nnw2mu3aSC1refPdcMUV3TQZ
	OgYdsZHiTsJ8M6MJPyUqvX+sopA5K2YsR038VLb4fAfX/MYmNroiAkJzLqhoGNk07QtWXmvcI5A
	3OSPI86KkG9Ku1UcIMDgvdiJA+LQRWo+2Eb7WarsyyK0HxiVCsIttty3oQ59mXr/FtJei4xBbQc
	hLL+/VTJFk3cVf8fK938m1enGr4aCdTjxyAGb12lJ+4TiCpbu5T9nyKrsPOXPv7w+X/RIL1gyBi
	Xq5WkXS/w=
X-Google-Smtp-Source: AGHT+IGSPhQ1z3pwiDq+ALwv1teQfujoIZTbcAJeeiF4w9A01TRvr7HA3CBokjDttlH8pxXLdnPyRQ==
X-Received: by 2002:a05:6a00:928d:b0:781:1f28:eae9 with SMTP id d2e1a72fcca58-78c98d324admr4834139b3a.3.1759524959880;
        Fri, 03 Oct 2025 13:55:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053b84sm5736073b3a.53.2025.10.03.13.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:55:59 -0700 (PDT)
Message-ID: <e1da3f51c56eb91ef70aadb67f81cea218b090e2.camel@gmail.com>
Subject: Re: [RFC PATCH v1 06/10] bpf: add plumbing for file-backed dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 13:55:58 -0700
In-Reply-To: <20251003160416.585080-7-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-7-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:

[...]

> @@ -13969,7 +13982,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
>  	 */
>  	if (meta.release_regno) {
> -		err =3D release_reference(env, regs[meta.release_regno].ref_obj_id);
> +		struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> +
> +		if (meta.initialized_dynptr.ref_obj_id)
> +			err =3D unmark_stack_slots_dynptr(env, reg);
> +		else
> +			err =3D release_reference(env, reg->ref_obj_id);
>  		if (err) {
>  			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
>  				func_name, meta.func_id);


Nit: unmark_stack_slots_dynptr() assumes that release_reference()
     inside it can't fail, which makes error report above unrelated
     for dynptrs. unmark_stack_slots_dynptr() can fail for other
     reasons, though.  Also, I think that condition should react on
     dynptr, not it's reg->ref_obj_id.
     So, I'd rewrite this hunk as follows:

        if (meta.release_regno) {
                struct bpf_reg_state *reg =3D &regs[meta.release_regno];

                if (meta.initialized_dynptr.type) {
                        err =3D unmark_stack_slots_dynptr(env, reg);
                        if (err)
                                return err;
                } else {
                        err =3D release_reference(env, ref_obj_id: reg->ref=
_obj_id);
                        if (err) {
                                verbose(private_data: env, fmt: "kfunc %s#%=
d reference has not been acquired before\n",
                                        func_name, meta.func_id);
                                return err;
                        }
                }
        }

