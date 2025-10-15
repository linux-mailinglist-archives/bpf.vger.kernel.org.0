Return-Path: <bpf+bounces-71045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E0BE07D1
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F58C560CFE
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E035309EF2;
	Wed, 15 Oct 2025 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYdViN0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3627E05F
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556996; cv=none; b=RAhrHYKw/whddSZb/VCuYq1z28fwQZdq41N5laSD0fpcP+nnIvLGu3zi8P0ekbMsJ1nr8/AVzKoNHBAA/zz5CZ0/pmvlS5he35JBfMFYTrtVeeFsjoIblDyJRWN78+2V3aoB5d3jNXaVJ5npqtyrZiEd4Bt2/KzLA53UIA5DSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556996; c=relaxed/simple;
	bh=Y9eNmtF86psMoRKbxIKrZM1sPxOTcn3ogsk03u3aSbg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OyID4SYMvYTEHh5HrzzUSJ58obRCjnZawN+CUZduBBkj3Cm/TLlTIffUtBzZVtVE9H8hzjQS46jkVdqyEwZh3SjhyNu4y6w7E5JJyJ7ceheeC0uwSy3xddehn7pn2q/get/OMp32bDTS7l+5DJut2GjpYZQeYTcwLTmnmT4Zky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYdViN0X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-267f0fe72a1so52136715ad.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556993; x=1761161793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SZxqyzlhLnM+F/4mmpcRNwDC0vzPO2Zs4WusVwF+Sv4=;
        b=dYdViN0XG6kkirQB4Vyfs2mMkaIl9+erG9d+DO4dUZmUG9gemybVbTt8vqun1U0QXK
         4U47dpqGbV9aCzTJuXvX31uWsG+Fd54Zf5hZQUsi9vt3r1SntYGvNVUSZ9SP8NQswmhM
         ZbcR9uhBj11MCKsD96nx77twdVGhsPBMdzNrcDLV9hYAQfmtey09adyHX7Efvx9ujFg6
         4d7lwr9DV0ZnddvKsyKCy+HTRkl/BrIiS1zY2/vQDJcA6Iqxrz8mmPqrNPPcgIuba1jU
         6D3hMgrX49f3aHjTTwRbNE1n9rQ3IFCHBumKPpSAElDVkOzVkNI/GFXeBRnOZbfzLGFS
         ofBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556993; x=1761161793;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZxqyzlhLnM+F/4mmpcRNwDC0vzPO2Zs4WusVwF+Sv4=;
        b=ckqnZxc2tBEHj6qodKxiMTCiGh777L6hjldDoCo3ofgUazXs1O7aoa8v1HGnJou02i
         NUEMXJ60ZxEQHg0Wf8VAhpNVw0e+LTjY6Ym2Ln7W89wJhuYEV1O/pinscXXYGFZ7avaU
         m4Gmr9pvNidv65kVwXGcxQd9e6WLU666MonYiHstqxr4HwVtSYq7qEQG9kVjIE9lH5//
         SLH4RD761X0ORC+jXQo3ls0gmbn8OkZvPxgoOuN+ZbbXTFOTZ/aHBWDFRkfY5BwamXrs
         x5/m9KxFAKAwsGO5zMxWlu2mQnvRwB3bemDObYcZpTSbX+YsCIMHoaybHOkaumA4BNp5
         X8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUzggWfRz9mNrqLx5az14CIyGtEQJbnAQdHLii6fpHwNHQfN9EdBtE7BhA/7umig0kz5pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcn1NqVSXjXZkigWNmgyBkG26pd8tOlcyvr6BCJE6JgHQ3121
	YX3AtUW1iEKud0qDi262Zp24ZHJtL3XQCLTdXKC5mefpaQCEe9DbzVxW
X-Gm-Gg: ASbGncvpScr8nWdXW2bkOV4p/cFSWWwejbIILe0wNAkEm9GQlA4QtKN9icPEsKKJfrK
	NL2B41dZbEDB//C0UwzlEud7K049eW2FMhLfT5isuvEwuRFskLD32g88WRlieCglYJAnLuhKmiy
	JqvtaX8pE8m+GiMqiWxuTJ2IuGNz19ZX2bi5AK2XvW4bkxBadO8q7b/VP3NPL8eYCQh9aAC3372
	JhkrXSVIXj1HIgbdisJxEJ2TTrHrMvobao+Zz13w79K1luGK4ftKJIkkwsyIwmLcK9hdxb4Mwoj
	OKpL9uW8ZJY5bUYXNXQLn6O9EKfW4VAJdb9HbbzNWiijKlHj4Pm9ID4FsIN5fVLq6qcKY5ciZ1/
	OQK7Eji94/g6ncSNlPRuFXfCpbt9M/XjTseAqb5FMYwT8CpdZNsEz/ej4QqaXAXkAvoeoUHxLEQ
	==
X-Google-Smtp-Source: AGHT+IF7tF1Au4ExdVOw+1AmcRoStF0uGWfIdp9/Z9Y65El0yFk+aPH2cRCBPaVEzhDh4nfOWLYuyw==
X-Received: by 2002:a17:902:e851:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-2902729031cmr418941515ad.12.1760556992598;
        Wed, 15 Oct 2025 12:36:32 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab9fadsm4219755ad.97.2025.10.15.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:36:32 -0700 (PDT)
Message-ID: <1cde9d18eaa6ae135c2c6b03c3e97c4d00293aa5.camel@gmail.com>
Subject: Re: [RFC PATCH v2 06/11] bpf: mark vm_area_struct as trusted
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 12:36:29 -0700
In-Reply-To: <20251015161155.120148-7-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-7-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Mark vm_area_struct in bpf_find_vma callback as trusted, also mark its
> field struct file *vm_file as trusted or NULL.

This is because this struct is only returned by:

  BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)

and task iterator is RCU protected:

  BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)

or passed to a callback inside bpf_find_vma with a lock being held,

right?

[...]

> @@ -7133,6 +7137,7 @@ static bool type_is_trusted(struct bpf_verifier_env=
 *env,
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
>
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "=
__safe_trusted");
>  }
> @@ -7143,6 +7148,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
>
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>  					  "__safe_trusted_or_null");

Why changing both type_is_trusted() and type_is_trusted_or_null()?
The only place where type_is_trusted_or_null() is called is here:


  static int check_ptr_to_btf_access(...)
  {
		...
                if (type_is_trusted(env, reg, field_name, btf_id)) {
                        flag |=3D PTR_TRUSTED;
                } else if (type_is_trusted_or_null(env, reg, field_name, bt=
f_id)) {
                        flag |=3D PTR_TRUSTED | PTR_MAYBE_NULL;
		...
  }

So, it seems that type_is_trusted() will always return true before
type_is_trusted_or_null() is called.

[...]

