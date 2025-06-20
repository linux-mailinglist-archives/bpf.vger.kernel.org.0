Return-Path: <bpf+bounces-61194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D4AE21C0
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F182167711
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D062EAB6D;
	Fri, 20 Jun 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngV/nZBX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDB2E9ECC
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442783; cv=none; b=uKQs91PfmUc7tssJ93QIeTPbff9s+IvLAhUtGyMukHPvk/F+KZeLG8Iv9UwWFekkzAlIm9H7QGsUCTShQP5eID43dun/ZA+zOt3E/HQX0QIqymMhCBRgaLsI9hPwoqQsLgWi+eNJSfkMLl44oUKn9VAizrzvnUVVbJfnmIqcM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442783; c=relaxed/simple;
	bh=spBr3W8FMjCpOAy2uE2UbNkVTbJRstA39N3TtFttFeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Go30jJMte5JJJ7MtgiPOl7gLvDRkFcaLqMtKgVPCy+h4BGsQbQz1wtq2UdZBTwLnZfnKseLRUr3v2uGaGxcdKoGccYZM4y/g0kSQi7IKn+AZ9UFDw9XzfguwKEL0Vf3EcNiPud7dlgBO4aVhky8VkXkFwwf93y4wQBmdhR3ViFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngV/nZBX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d54214adso16016265e9.3
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750442779; x=1751047579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spBr3W8FMjCpOAy2uE2UbNkVTbJRstA39N3TtFttFeI=;
        b=ngV/nZBXroJXo+Qoe4ynYFzyinjJgNPjBEoyCS7a167ThDgtb3+qcYkf/p72YrMsZP
         zOxFdeuxSe6nY474vNzcNmEHz1VPQIsqf5l7QEew0xLzyA+57PVEHrqTShj5pvcOEg6M
         6bCubDmlDA1ld7H00jyPCnS7VGLeq6lwMBfCJLVC3h50a2AJ7CGXQaBD6TW3eZeW2Evx
         ah0foOFo8g3UV2G6/Dwu1iJUBQ3yJhYU33DC0Mp1TQ0BtaQmzaBgVCAsEEJDN4BzzaiQ
         kcIASxvjDzHnjhysA4Q3637wgsy/kvkTcEbLvGS8llkcBue/2KdKaVxkk7R8j/4rZMwV
         bwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442779; x=1751047579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spBr3W8FMjCpOAy2uE2UbNkVTbJRstA39N3TtFttFeI=;
        b=qzj/pRjHsOJ7ARce09CNPIV/eCW2ZOT2AhyjbXAzToCGSloVvjE4dR2pwCpwpXj+Wu
         pjsjHc+NA1PLw5XsNnQC/B9vHRBWcsMUSBcON+bGQcjOS/9uBiUJMVrPxLrGW/h0RR5n
         Gi8nfp4KUHW3Dhh55b3DmBGSq+SCVMsre7PyihsG2CpcLdafwslTI1kP+0cRrdwKP2fu
         VOJAxH4/ACCtshe89h+/GUMyNnhyIcUTrl/qfqaHhsp7lCj4O13p6Yjb7e/jwDYiLuyw
         HmpVQKe7z0A3m8Flgy8kETbrGVJE5eeexCY4mhJSoixbvkG9aGrlF9rQfEqBr9Ccgg9v
         ZZuw==
X-Gm-Message-State: AOJu0YwmCq68i1CnTBn9Q3bMA0cR46T6a5UFkap4ZYm2o3TWdFEOH4dN
	mZ419DM7++XnGcXppKNF5Y19tw5hB6tVMvhcHIVyPweqX9E0fHRHEWFVZ9ogQVFn2tzl40OKoQx
	1/n7VgC8iDN2+fmzxBepnVkj9HnguX/s=
X-Gm-Gg: ASbGncvHa8ziRT8VRGp5JUnKwE4gsBU37pXunAjvR7ecL0bIvWdO8YYLYElOMVn+0yk
	VAIiBih4ClACa5Jts4X+pcJC6d7qGcXJxrbDw2CO++2/rbVQTp3R9OPJoIj/95Wrf6thOwUzDoe
	CedumxL++m83CniWYCpKGaHvAaTcN6M85jAxKxx9Wn/KzjQCxt+nnm41UeWcj9561IlI2n7bTX
X-Google-Smtp-Source: AGHT+IHWzoo+YfxuVE71ZV6eZkZ+qn6TPRsFAODwysOJfuEH4V+aOzGegSq6MFWWxPYrzCh/uyG9CsMXu3GiE6gzBwQ=
X-Received: by 2002:a05:600c:1e8a:b0:442:f956:53f9 with SMTP id
 5b1f17b1804b1-453659dde93mr42323645e9.18.1750442778959; Fri, 20 Jun 2025
 11:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750402154.git.vmalik@redhat.com> <17543560f4a1e269aec6596e72fe3fff8ef1dd2e.1750402154.git.vmalik@redhat.com>
 <fdbb8caa-77f6-4143-ad0b-4f32d9e6d8e6@redhat.com>
In-Reply-To: <fdbb8caa-77f6-4143-ad0b-4f32d9e6d8e6@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 11:06:07 -0700
X-Gm-Features: Ac12FXy61QKiRWiIUjQ3kaoItY-dC7HTj4DYvjbB1kBe3UW5r53t2VogdMewAuA
Message-ID: <CAADnVQKj3iTJyhXiQbcSo=6rJarfY_uMQi9yhytmjX-y24GXkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add tests for string kfuncs
To: Viktor Malik <vmalik@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 5:33=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> > +SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void =
*ctx) { return bpf_strnstr("hello", user_ptr, 1); }
>
> For some reason, these tests are failing on s390x. I'll investigate.

I suspect this is the reason for failures:

+char *user_ptr =3D (char *)1;
+char *invalid_kern_ptr =3D (char *)-1;

Ilya,

Please suggest user/kern addresses to use for these tests.

