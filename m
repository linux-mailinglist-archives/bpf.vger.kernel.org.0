Return-Path: <bpf+bounces-71058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3862BE0E70
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7801648512B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE843054D7;
	Wed, 15 Oct 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDpfsKMR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A130507B
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566038; cv=none; b=S6ZZDOUWMhyvTVJYSKX2lejFLSQmMqV0I9Jk96MqxPGfAQRlnRtcOuYDUjJmIPAHakg7f9q2hNRxAATaBL1VFkaq4+0Bdk0JD1JxsLSd9ZtKWroVMuXFYd+fL4fJYRBfmTWBDpf6Q20egYPytmG2j9zSWIwAerv8fzBZkomI+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566038; c=relaxed/simple;
	bh=JfoaFnIcuzdTtBRB+Mm2Fw4HuJ1ZNK9kVH8/T/UY2v4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFuwij8eQKme5pSuJmdeP/JGbzYijGjqWYY79qykqyFjoWTR1nHHfK7npMGxkKagtFbLlPLPPWy30ohzDz1SS92byat5+KbeuU6lPvXil1Wv+bKxo7+/VVOZ6tgBn/pheDRvL/c39wOGRASr47QrnaTJary/dEHi2mVgGurPM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDpfsKMR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-267facf9b58so480075ad.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566036; x=1761170836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xPvygEZhODJfVmnHBrLo8oBLSM0h8R3ongR3zk2Kv8w=;
        b=nDpfsKMRLl4XG+arqYCbr84WECaESq5VibJ6bdgMhuKWznY4W/BkfAqUvhLTSvfBM5
         IN54sqksnAsKgCpwuBef7vR56CLioE8l4iqcvJrcU9zrRKICnGnD1HZpeEqjYLqlB7AF
         epFspQNR5Ms3yvgfld9oH8n2K6FkJoJJAdh9issBFTuIhJJmslxg+A9ZB1HfYoiHO/8x
         we7yb/rS7ibc8/fgEORZjkX8B9QgG2h02CtT8i5Xed7vbH7VjZJsa6dSRB2Fq5kKD+GC
         NO24+AdXgkXN9BKXD5N9dY/4fk3p/p1nsuPEBLDR2u7ZslLixgFlxdRtaTMzJ0r0dyp7
         Vpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566036; x=1761170836;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPvygEZhODJfVmnHBrLo8oBLSM0h8R3ongR3zk2Kv8w=;
        b=fdCGg5JxXcECx0yVou65srtHJd4sgTYiwI7IMognvYd+eguOzW41meMT6wtC0i5zyQ
         j+NlD00k/ujA11yTDRJETObXS6z6/Wgue2LPH5RLAMA++Xae/X3HzwPkhSpBVDSfZUTB
         xejQJJe54XYswlhC0Dt98QKbJOofIdpZoxR8NZnCdNDa+lcJzCqk3OT8Hs78E0ShQeWI
         kd2B3e4PD0xLF9bHzKCAoz3OufAmY+XVHI00oqICb0A3JhiXE20VYihA9INqBOtXIz55
         2vSYXwH325gS1qCUrBH6xPpRbyvcKjCBCdU7iGYTcHTAzGg35n5gAyW14Ib8Cs5y6VX7
         uxGg==
X-Forwarded-Encrypted: i=1; AJvYcCUTitaRxXyHVDUuF4ueNxtZxK8CSy1T+W1pDzFSuO1efak/JXLsQtg8qD7CnTmpLL6LK/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbpzx/lzMGR476Vf2rliVpNCHmFomXyzJVj1fYXyYnVu+yPXD1
	sJK2fj/OCnX/i1tH/ZGFtwD5CVYlgEapmZ1IE2g+q/UVCSX+9bkE4q2F
X-Gm-Gg: ASbGncvPYhPTWzCZVwNSWA9wAyOh9qHPyaGmuyJ93/P+Di+9cQU4c7eNxdDfaX5LW1j
	mkARuCsqqbsCRAoLc96avrR0zhiwuIebr7ATkIPUSlqv9QhYLWmfnJG7TLckZiIkzqZauJuEPEG
	uDMI1T9AnHrbFeGVpNka0EwhxMKz1IqJVx82M4JSYUk8A8qgp0wGzqhOYWTjeKUWYlfNY3t6ggN
	WZUpC99nu66mG05iNfq1MhTqc5Xh3rIuRtnPQxlhvI6/IJN5Duq7E5RBH/SUDZjqkVM651UMgfI
	86PZflzOiW2LMNeIHXEsOkUl5O9XquNx9Aenujher9445ffk2W+Li9W2JmhLK8jnU2Hu0qPd9VQ
	s3fBLGIVRbsdjvy/ZiXTUUBmy+VDc6+nIP+/xJoS4kW2D3CROICvf4HryQfOlNRqrvxe1i1rdnZ
	WDewlk/CEH
X-Google-Smtp-Source: AGHT+IFHdYGz7BGDM23L24qFZBXdCdfKIPK049/vU3IobUlZ0+xLEcBAtreaXzylgbl46oUTN0TK2Q==
X-Received: by 2002:a17:903:11cf:b0:269:96db:939 with SMTP id d9443c01a7336-2902741f404mr354258295ad.58.1760566035864;
        Wed, 15 Oct 2025 15:07:15 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099348bfdsm6966015ad.33.2025.10.15.15.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:07:15 -0700 (PDT)
Message-ID: <5ac4f6ed88c9e62fd8ca516e506ac8ab332f7417.camel@gmail.com>
Subject: Re: [RFC PATCH v2 06/11] bpf: mark vm_area_struct as trusted
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 15:07:12 -0700
In-Reply-To: <6f7028a7-4cdf-4800-b43d-985019c02983@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-7-mykyta.yatsenko5@gmail.com>
	 <1cde9d18eaa6ae135c2c6b03c3e97c4d00293aa5.camel@gmail.com>
	 <6f7028a7-4cdf-4800-b43d-985019c02983@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 22:48 +0100, Mykyta Yatsenko wrote:
> On 10/15/25 20:36, Eduard Zingerman wrote:
> > On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > >
> > > Mark vm_area_struct in bpf_find_vma callback as trusted, also mark it=
s
> > > field struct file *vm_file as trusted or NULL.
> > This is because this struct is only returned by:
> >
> >    BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> >
> > and task iterator is RCU protected:
> >
> >    BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
> >
> > or passed to a callback inside bpf_find_vma with a lock being held,
> >
> > right?
> >
> > [...]
> >
> > > @@ -7133,6 +7137,7 @@ static bool type_is_trusted(struct bpf_verifier=
_env *env,
> > >   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
> > >   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
> > >   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
> > > +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
> > >
> > >   	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_=
id, "__safe_trusted");
> > >   }
> > > @@ -7143,6 +7148,7 @@ static bool type_is_trusted_or_null(struct bpf_=
verifier_env *env,
> > >   {
> > >   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
> > >   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> > > +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct))=
;
> > >
> > >   	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_=
id,
> > >   					  "__safe_trusted_or_null");
> > Why changing both type_is_trusted() and type_is_trusted_or_null()?
> > The only place where type_is_trusted_or_null() is called is here:
> this is because type_is_trusted_or_null() check is only executed when:
> ```
> else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
> ```
> condition is hit. I understand this code as vm_area_struct has to be a
> trusted,
> so that its field can be trusted or null (It did not work without adding
> vm_area_struct to trusted).
>  From verifier log I can see that the type for vm_file is correctly set
> by the verifier:
> ```
> ; struct file *file =3D vma->vm_file; @ file_reader.c:117
> 48: (79) r1 =3D *(u64 *)(r2 +88)=C2=A0 =C2=A0 =C2=A0 =C2=A0 ; frame1:
> R1=3Dtrusted_ptr_or_null_file(id=3D1) R2=3Dtrusted_ptr_vm_area_struct() c=
b
> ```

The test cases still verify, if I remove `vm_area_struct` from
type_is_trusted():

  --- a/kernel/bpf/verifier.c
  +++ b/kernel/bpf/verifier.c
  @@ -7143,7 +7143,7 @@ static bool type_is_trusted(struct bpf_verifier_env=
 *env,
          BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
          BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
          BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
  -       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
  +       //BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));

          return btf_nested_type_is_trusted(&env->log, reg, field_name, btf=
_id, "__safe_trusted");
   }


> >    static int check_ptr_to_btf_access(...)
> >    {
> > 		...
> >                  if (type_is_trusted(env, reg, field_name, btf_id)) {
> >                          flag |=3D PTR_TRUSTED;
> >                  } else if (type_is_trusted_or_null(env, reg, field_nam=
e, btf_id)) {
> >                          flag |=3D PTR_TRUSTED | PTR_MAYBE_NULL;
> > 		...
> >    }
> >
> > So, it seems that type_is_trusted() will always return true before
> > type_is_trusted_or_null() is called.
> >
> > [...]

