Return-Path: <bpf+bounces-51912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B3A3B1AC
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 07:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9833AAA2B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3751BBBFD;
	Wed, 19 Feb 2025 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+A7g9tE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483916D9AF;
	Wed, 19 Feb 2025 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946851; cv=none; b=RzR/qsghfvNFb0DBQCQ/6wmUmIztpI+rA55tv5bzRrIlPjZfOEqsMGMUSQjlRLDjgo2w9/hSdkO5ScDV3Sj7xT3ejpgO9LnDNDBHza1zLj+iawxqtPI+2P/G5KEdLj836azvwVadfDEWDFMVVufHxDOLWCXfL41zc/t2JerrNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946851; c=relaxed/simple;
	bh=jQFLhHzwmDxvJ3MMZHIEuHcl5VUmfoHJOCp10P6ZHs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGlo/A3VT28zzOXF/tza89bE4cmb1A8EzvU5N6BsA1YF47NY54As8705//rbYZiqfej2CyKJX+H4eh2AiPZwkKmRALF+9nj0UTSciY46Gl/bxHIwyHsBj0T6xNU2jhjOBFEqlttWQ5B6A0aPSVoKsuzVoLDLeXhgW90UEuH7ot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+A7g9tE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so9134752a91.3;
        Tue, 18 Feb 2025 22:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739946849; x=1740551649; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=idba90JGGblz2dgrS2+u0IJ5Khj50BbgDmDFv43i7z8=;
        b=K+A7g9tEo+1o/DJLtTyVs5O561HPg2tPsHa9KQMDsBWqLhPrQrmmAih0bTXAdsXTkU
         lXmub4xdQBXEpshCGmQz5RyWSq++0UN2ItvZL5I58inI5Ozl8xeSj7zCtVKfm1tLl9NZ
         Jgw7CHqrmGy5Ig9HMFBUM8zsWGktHtbtp7ZJTewi6ig9ZtzO1J00gCW41NxJSnK2YMIv
         uZBlBKjR03Qmc88bTB7JFSS6U2yaj8sf5t9NKl7GcWjh5qpQNePKyuuVPX4cnYNb3hDr
         2cxyGYRUMfy3EUXcBmQf+ije6cfEzTWGi7eOLEB2m7LN7Uia/m9UkHc0TIJffSo06HKn
         mriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739946849; x=1740551649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idba90JGGblz2dgrS2+u0IJ5Khj50BbgDmDFv43i7z8=;
        b=RzRvvaTgM9tmkyxJmiDBGyX9n1D6Mh8qCFQ0IkRaK06qgFSMDuiCnBOmaVRbXZWzJl
         KgDzco8cF8lI/K/SBSckcPyKkiICguqAr2RL5j4dzcSEwtuvZUNf0vsEy77mOfDe5wBM
         ts4yeo10OM79UMYzva/pwwq/Teq5L93uj3+ewAY5uKqUiZ8QATw3nOPPwC/D9Y/sGt9m
         rKAcM+Yk2h/DHuERa7m8gehTjQQAci/QCuZBWkuYmXdMq+8ibwG/i0b+d7S39rSXZHH8
         cCnVzto68DUqWc+VD05Jdc0g6nTJSQz3TWmMFrxFShI+UI/XwNfGNlo7l9RAWffuJ/n4
         uIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+xXah8qrTLYma3o7+SW/852k06VmUDjZGmUrh8k/cdErNxCL37Fk2VS1lsxMlm10Io1Woe+fRzXS3FuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLb6zEPMo/BfssDrAnxrxdgTD7Jb+JkGh91ajyJ/1V/+25zlX
	F8NZuvH1r6HWrpyJIiULLSIO/yutSxGav+RMknGH1eTzKbgAJUVm
X-Gm-Gg: ASbGnctHkLxflZJP0TSFenE9MCOT5oFsrwLpy2Af6z9i8wV4gYysdspvjz3OBRACtvu
	FuwiWSVCdlozYwTZzSTVohitIOGtLWA2VkK2gcraI+MXn6AvkLTOnuLOWEAubCnI4m9tyRMCb6c
	AYtqgw+taWfND3Md4R16lLUVt7DsFZSQ+qYYWhWLUn1tLEgUuQG46a8sCJVzBDqWEDT71/sflVm
	6ux4t6ajMcZYxE0EA8PohgRxRdFgoWafqIfPQm54WnkXmk3oEpr2y4/HLQZYfnDvUeMHPNb0O2o
	N9UJg30307/F
X-Google-Smtp-Source: AGHT+IGZvWA5bKJYI3rnYDqL0FB39cWcX/hwOMqvsj0tsez/YClDG/eFPqo0iG5wGKsMd804O17rEw==
X-Received: by 2002:a05:6a00:3e0c:b0:730:9334:18f3 with SMTP id d2e1a72fcca58-732618c2523mr25914861b3a.19.1739946848810;
        Tue, 18 Feb 2025 22:34:08 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273c8a4sm11112171b3a.85.2025.02.18.22.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 22:34:08 -0800 (PST)
Message-ID: <745bb51eb27835c93e7d4d6f1760c920417ad7f4.camel@gmail.com>
Subject: Re: [PATCH] libbpf: Wrap libbpf API direct err with libbpf_err
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 22:34:03 -0800
In-Reply-To: <9df12336-ca00-4d45-a832-24203c334df7@gmail.com>
References: <20250214141717.26847-1-chen.dylane@gmail.com>
	 <88f0c25cc981f958e46d51560fbf6db7136a3fa0.camel@gmail.com>
	 <9df12336-ca00-4d45-a832-24203c334df7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 14:23 +0800, Tao Chen wrote:
> =E5=9C=A8 2025/2/19 10:08, Eduard Zingerman =E5=86=99=E9=81=93:
> > On Fri, 2025-02-14 at 22:17 +0800, Tao Chen wrote:
> > > Just wrap the direct err with libbpf_err, keep consistency
> > > with other APIs.
> > >=20
> > > Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> > > ---
> >=20
> > While at it, I've noticed two more places that need libbpf_err() calls.
> > Could you please check the following locations:
> >=20
> > bpf_map__set_value_size:
> >    return -EOPNOTSUPP;       tools/lib/bpf/libbpf.c:10309
> >    return err;               tools/lib/bpf/libbpf.c:10317
>=20
> Will change it. Thanks
>=20
> >=20
> > ?
> >=20
> > Other than that, I agree with changes in this patch.
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > [...]
> >=20
>=20
> I use a simple script, other places may also should be added:

Yeah, makes sense :)

>=20
> 9727 line: return NUL; (API:libbpf_bpf_attach_type_str)
> 9735 line: return NULL; (API: libbpf_bpf_link_type_str)
> 9743 line: return NULL; (API: libbpf_bpf_map_type_str)
> 9751 line: return NULL; (API: libbpf_bpf_prog_type_str)
> 10151 line: return NULL; (API: bpf_map__name)

Sort of makes sense for these.
Idk, I'm fine with and without changes to these functions.

> 10458 line: return NULL; (API: bpf_object__prev_map)

This is not an error, I think.

[...]


