Return-Path: <bpf+bounces-32330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E590BBA1
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB4A1F22E85
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD018FC93;
	Mon, 17 Jun 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6xh/Gtn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2C18A944;
	Mon, 17 Jun 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654456; cv=none; b=b4HSh9le3BDXt3eigKtnzteafMbsU5qsMreHUz/Rqah7A+rOW3iE7gDWc/hIsEYOEaj9+CkscWvIKsUcxTtv0rggBzuim7bBr5wib3IS9DTGRNAqSL3tFn0ZgkS05tKi98f2dApHsX4NePAAmY9/wgr1XJigArvOXIFlufsqC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654456; c=relaxed/simple;
	bh=nm0hoih9n+xUQkDXcZ/Jfed4/QJngX7ttcOsQUBzysY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEjPpDxSeUZCOWYmc5YbKRjR/J3kJRcREKPXaPNTk9GGR4AsrOuH4L2ZsdBKvdGKDfZHlFOd6nj6Nk2iMkrMfCVeXezB2Xe8c5xWIRjcvAIdQfm7fTXCZLVQ/dhtVnHN/UDSREqYhoZODCrtTDpWNEGqzUSRKUDv4e0rbTXHHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6xh/Gtn; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-70a365a4532so1131585a12.1;
        Mon, 17 Jun 2024 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718654454; x=1719259254; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMmfxXFfGSBMXQnhmvB2uJwfgVwWQzxCVvTB+E3HX1k=;
        b=Z6xh/Gtn059zqRN/9uykHKJzEtj4BR9kzL1CmHWkyzACWk584YDTZgWc7xM3XYyHYD
         SDvWHRemmweFuff2a+DOyHR+laMK884qiKakTzg3dOLRoXwU3UU6DUVyKLDSkrUbuByW
         WhmBvXbcjf9hOnowgjM5DfFSqRs3NmKkPLk8J349EXYeQqYsNLYLDaBNAqIn/uRaY4zn
         DFmRU6K6Gk/WTzExIe9M7G8hMoqT/zUf2ebM7yMvwHni3dKX6k5Rwl4pF7Tze2Gd9PMr
         6gKuNr7r1sUMp2A/w4W6jALhUlyImTJ6+LeeazR9EkWyu7hQetkbGjFXuHN0vslgNUuy
         gpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654454; x=1719259254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMmfxXFfGSBMXQnhmvB2uJwfgVwWQzxCVvTB+E3HX1k=;
        b=pRe6iiUIOioBuLE/ErVPvoIyHT82+9f54w89gG5GqOGmJV3HXEsk+Z7X/ssc3VmTK1
         BMmNLTOpLKbOLV1pRfqAoxNfmA1gO6AkoqxLotWCZLheaKM3zIw7vKPyFW9Vj35UNxl0
         sfa2JO1S+rjecMz9rc51RIqNCVqGFoS3eXZSxvUZM+zRkpe3XkSwVH1nWleaGlF51DTT
         bJchSyJkYd/01oC2dRJe/Cx6HPz8PVHnvrPdoYPItVlLX8y7dHKoHDzobG36uGZr+3AR
         jCKV3yJMvsx9qPjEe+KstglqLnNfu9w/q6G5ml8jCrLechm6A/ulvlbtIojNLF1IaPRF
         Qc1g==
X-Forwarded-Encrypted: i=1; AJvYcCW+ckiEkm0cOJbmVpIijEZ8k5pbfOwd4LPhT+H4Gix9JltXUh3tGiEVscT0/LkjuZ7x1Ji8FLDpequzmSYZQWdN72VgOxzjpobu8lFm5qLX0fFQGcKjsT3ri83YZXQKCSD/
X-Gm-Message-State: AOJu0YyUG8UlxFs9blv9IRtcJ6tjFegrgy8fOYMKSw4X/O0b7SBgr8qA
	Ek6O7Eciq6C2yQA4FPn1mekaNv+X/Vo6SuVOfCxRIK4So4uSb6vf
X-Google-Smtp-Source: AGHT+IGh95ZSHmL4d73AhycVrIm4QGVmOMKBpUZZggY8itguN5SlqXgbh3hD4eFmwY/oMea+w3Rf2Q==
X-Received: by 2002:a17:902:c401:b0:1f7:3e19:6da4 with SMTP id d9443c01a7336-1f862a0ba11mr122793325ad.69.1718654453980;
        Mon, 17 Jun 2024 13:00:53 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e726a8sm82754275ad.99.2024.06.17.13.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:00:53 -0700 (PDT)
Message-ID: <2404b12b71fb361df262c2838d94f1ee6f35e5c4.camel@gmail.com>
Subject: Re: [PATCH] libbpf: checking the btf_type kind when fixing variable
 offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Donglin Peng
	 <dolinux.peng@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, song@kernel.org, andrii@kernel.org,
 haoluo@google.com,  yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 17 Jun 2024 13:00:48 -0700
In-Reply-To: <0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com>
References: <20240616002958.2095829-1-dolinux.peng@gmail.com>
	 <0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 12:29 +0100, Alan Maguire wrote:

[...]

> The only thing I could come up with is we were usually lucky; when we
> misinterpreted the func as a var and looked its type up, we got
>=20
> 		int var_linkage =3D btf_var(vt)->linkage;
>=20
> ...and were lucky it never equalled 1 (BTF_VAR_GLOBAL_ALLOCATED):
> =09
> 		/* no need to patch up static or extern vars */
>                 if (var_linkage !=3D BTF_VAR_GLOBAL_ALLOCATED)
> 			continue;
>=20
> In the case of a function, the above btf_var(vt) would really be
> pointing at the struct btf_type immediately after the relevant
> function's struct btf_type (since unlike variables, functions don't have
> metadata following them). So the only way we'd trip this bug would be if
> the struct btf_type following the func was had a name_off value that
> happened to equal 1 (BTF_VAR_GLOBAL_ALLOCATED).
>=20
> So maybe the sorting changes to BTF order resulted in us tripping on
> this bug, but regardless the fix seems right to me.

I've added the following debug logging:
=20
                        sym =3D find_sym_by_name(obj, sec->sec_idx, STT_OBJ=
ECT, var_name);
                        if (!sym) {
+                               const struct btf_type *nt;
                                pr_warn("failed to find symbol for variable=
 '%s' in section '%s'\n", var_name, sec_name);
+                               nt =3D btf__type_by_id(obj->btf, vi->type +=
 1);
+                               pr_warn("  vi->type =3D=3D %d\n", vi->type)=
;
+                               pr_warn("  next id %d kind '%s', name '%s' =
off %d\n",
+                                       vi->type + 1,
+                                       btf_kind_str(nt),
+                                       btf__str_by_offset(obj->btf, nt->na=
me_off), nt->name_off);
                                return -ENOENT;
                        }

The output is as follows:

  libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in section =
'.ksyms'
  libbpf:   vi->type =3D=3D 17
  libbpf:   next id 18 kind 'struct', name 'bpf_nf_ctx' off 1

This matches your analysis and hits the unlikely situation when
name_off of the next type is 1.

