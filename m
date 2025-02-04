Return-Path: <bpf+bounces-50376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98DA26BA1
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3460116284C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECA1FFC54;
	Tue,  4 Feb 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4mQ2VUR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2A171E43;
	Tue,  4 Feb 2025 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648716; cv=none; b=QfNMFhdzMzgTBBPOEvHkA1Kv0TlXHl5Bb3RMcHcz9UWtPvtu3y3ZwPqHT3L71QqqvFBJvYb6Bm01V/KhR3P14oy4ukE/ua6vIWm35nr+XdUIH27GVPkujAYqp8NbWUXH8sLHcm1enjOKIh38TvxEg18LK+zlsDQqJWRe2ohJiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648716; c=relaxed/simple;
	bh=bpKJFUoMe1QNgs1AMDY1VFgM/JHZZRO58fGiOJIQqOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZH/YFf1pO6U8Qe3XjlzX0Pk5OTTVdWYkdDdR3UxEsffWhzLYugdnzlPW+QLRM8hZrwzycKpmyFnrXjLvuOLJ+e7wf71tg+9rm3REIoZTYAH+5uZ2JSWS8WEJYw8GI4EliMzvs4qOrPHGmlXXbMi08NjmVopflgJdKf9lTFWP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4mQ2VUR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21ddab8800bso72572995ad.3;
        Mon, 03 Feb 2025 21:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648714; x=1739253514; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bpKJFUoMe1QNgs1AMDY1VFgM/JHZZRO58fGiOJIQqOk=;
        b=d4mQ2VURI9ekU+hfwCXJGkSZpRQc//IKAIpaMzd07Z1nSkdRQtKat81TbwCPGEY0Jl
         7hMYhocOthEd4H01WsjbkWwrZqsGnuZKKpqiMObiz+x/nx+owFKlUfTqPMBt8l27mB/0
         uV3sxFsi+6XvVMC/DxT1GLF8g+V8sVR4Rb1gJtTURkFcA+q4RDKgiOZpSRD7SUBqS0H9
         3+/rwZeDlbU/UjFp5u7FpV93GcYX9fiHCVep4dAkq+tIJh5hLidu/R6K0CHyVk0bGp24
         dspQi9SwkjwO5HFL1zo6tchuxgHRmLiLDkFv/mm/MsZ4ylGAO4MR2uTi/GgSjW5PWjZs
         fHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648714; x=1739253514;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpKJFUoMe1QNgs1AMDY1VFgM/JHZZRO58fGiOJIQqOk=;
        b=VLeh9jwcH6P6MrmVqfE6uajpVhbtaqQMVyWro2TctC49fxyAxW6tjJf6frXhXUPm0v
         /a+pFcH7sxhTO1fUBk6BMyJyv1yIUGJ+7db1cFAM36cIp4C0VlrLiot1tb5WaoYUv00o
         NGocyF0TFVslLI+URgKdfgJk+BqlnFhjeJ7iasWvnoJCjhVtI5N8ZbEXE3ep5WufV3uO
         XZVI110HIC61vPM/j9/BTF90aorztvvaop5PToGYPalDw64vwDTv/H2842B3q8wgueYl
         Qx4DmQU4Uk6EdR+5LGrAVnbFsOc+c2O9qPjqF36RF5t6k+blaooPQN4uMKD1sxOg03pa
         xUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0RwF/7ZicG1iw/w0RMdGOxngupYao10H4Ekvt5rxP+i64AwgeyPBgNBkYc7LsOwg48CjZ/cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgx5DKYactax8Bxz/DdLnl4uD9P5JQ+a+gELAkWdvRZ0PsHPJh
	R80TpmnanqivAtBEx0ZWH8YNr/28lulno+8C8SKC9KkY26zvRAmq
X-Gm-Gg: ASbGncvoNbyVp2CGTmmFe1b1/9nUYlL2nA/EVMUyHzXdV5QG3aFLJfpnmPVPzBKwecT
	U1O9zW+/oRgIQ7fDB5awdaXHuOqABXS09yHVNeFwrhmq9ubck+psRDf4484Ols23FmLByNLH8vP
	vdP8m3gejHRbc1sAsswyio/jGoT5L43g5molmtU9vInTiL1R5zcR51JtgWC8CWiCWJgL00XeV1t
	1OnEkEknVkB/CVhK7HaqbeGVs8k+Vmm5SbyAPssT2D59i11pZ/NkSQKhS30uJ2Ebkgg7rB3mA32
	lRK2CKvfOcG1
X-Google-Smtp-Source: AGHT+IHbqQT5pjhJciF/FRYe2crQfJE/zvlsk7KVbZOT5s6xcfP09HlNbnKaIpkkLC5+XV8Nc7x9aQ==
X-Received: by 2002:a05:6a00:3a01:b0:725:9cc4:2354 with SMTP id d2e1a72fcca58-72fd0be1847mr34065438b3a.10.1738648714292;
        Mon, 03 Feb 2025 21:58:34 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba3c1sm9839890b3a.108.2025.02.03.21.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:58:33 -0800 (PST)
Message-ID: <73d244186bdb206c62c62879c11f8139c79dfac9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 04/18] bpf: Allow struct_ops prog to return
 referenced kptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:58:28 -0800
In-Reply-To: <20250131192912.133796-5-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-5-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-31 at 11:28 -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
>=20
> Allow a struct_ops program to return a referenced kptr if the struct_ops
> operator's return type is a struct pointer. To make sure the returned
> pointer continues to be valid in the kernel, several constraints are
> required:
>=20
> 1) The type of the pointer must matches the return type
> 2) The pointer originally comes from the kernel (not locally allocated)
> 3) The pointer is in its unmodified form
>=20
> Implementation wise, a referenced kptr first needs to be allowed to _leak=
_
> in check_reference_leak() if it is in the return register. Then, in
> check_return_code(), constraints 1-3 are checked. During struct_ops
> registration, a check is also added to warn about operators with
> non-struct pointer return.
>=20
> In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
> pointer to be returned when there is no skb to be dequeued, we will allow
> a scalar value with value equals to NULL to be returned.
>=20
> In the future when there is a struct_ops user that always expects a valid
> pointer to be returned from an operator, we may extend tagging to the
> return value. We can tell the verifier to only allow NULL pointer return
> if the return value is tagged with MAY_BE_NULL.
>=20
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


