Return-Path: <bpf+bounces-28309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6D08B8325
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F31C223FC
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B21C0DF8;
	Tue, 30 Apr 2024 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBzBWj7f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E41C0DD2
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521004; cv=none; b=JdSpthr5KtWQpIUtYht8fiR6jNwln9uM5HLzJ2o8vUYNNPWTHA9xgkAw7H5CtFJ24bRelt9t9gomHPz5IEQHyRXsFFDcnvrF0WDZDulEs4iJRXuZQObEFPVpPJXPrHdHvHXeWCNv7Sif3vyxowgCfcjhtIf8TtXAZJE88xsQaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521004; c=relaxed/simple;
	bh=vQ0+6M85ZfSS7WOVaFcgOZn3DCLp8u7aoLAN7eb3um8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RypVI/gnrr2wOIpsmInwftVl/tx6nlt45nK3E83PxynZ1s1/hckxd4Wg3EncgNxPVd8Vs5bhOVFbhqCFbDYgyZdDhwkZOmpx2yx7tee4qEBhqBNb6JwG/vz6SPXk/w93wUTm0+aQPmPIfrVzGosFMU6QKfRdibKnAqVAuN1s3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBzBWj7f; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4487165a12.2
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714521002; x=1715125802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x507l2I/5RIAG0ljDgyxULe3OZL6QgeXamCRbqsfoiU=;
        b=EBzBWj7f0RACrzRZ9dX1YnQQKm/GxTi2kENGWg+8uBRPoWq1cA446+7G4iuV2wKPqi
         DdasYhPMaCz8x4d2f0uDb4zSwVwxxSpoN9XIOsQ92XM/2M7FrP781G9fW2++xM9u5DoG
         bISYXc3bSIhh4Y9siuLKLosDlklWgI2CDIlseEVpFDeM/TWFGwCDRgRRVT8XD499YE9G
         +oa+QrXOySiO0fx2fp8xi0fNRQ3sj82vWjlWJkVyzFNLopHb1RYHvFdR6U40R3+PSmNA
         7q7wostkysrV+A0KFAqYdmAMHRXywZo+EIWSyk42ndscaEkQn/qesN/yUBBcsPvfp29p
         upnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521002; x=1715125802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x507l2I/5RIAG0ljDgyxULe3OZL6QgeXamCRbqsfoiU=;
        b=PByJCXSW08bReqr0u7439rrPD6HGK5P33JoGXyRXRxvP0Lq71t2HI0CKwVVpkV+pGV
         BkeG+i2jJn5WB7fzNqfxZCNN70m8pkkYCmT2qbtPO54qPgJVjLRy3YpVy2fYEon7GVK8
         2VSINjyNRKz4uFuXgJ3AWpidd2toI+MKOCofmgeHRiG/3/AQhPuTjVouGtCn6iStnhZ3
         od5JysEJ7z9Ol6fWb4TZwPvO4vvRor2W+pxWSr3MC+koVkPjGz4p4mNjLo+uD9mhcayy
         SAqyibcKN1mbkAg4t9RXyTQt0nBPHxSdKlxp7V/95ifFFxRwG1/xq6AQ2IFX5z50dslz
         8gcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXknwydTXK8wle2EC0hE0fQQykkIO5ueTBz9LGH9v8orTKiFzX5VvBdRrBQBR8SoNwP45Hd0sO8zdHpYvp5VaxVVjLf
X-Gm-Message-State: AOJu0Yxaq2QslB/EqrM+uTX/tFwQyeGW7wtV4AAJMGa0jgLRVJYDuP5M
	VZexzaCW4oo3EKXq993+EaW2RML8I/kJibyC4xZIO2apE8050uXlL6tdfiP8
X-Google-Smtp-Source: AGHT+IFUxdqsjoRUDzMn9JGVlkseCllsPncgOf0PTiPRolSnhq3WJGnNAdej0szBhSN1NlNHm6HhgA==
X-Received: by 2002:a17:90a:a683:b0:2a0:3dc3:8a8b with SMTP id d3-20020a17090aa68300b002a03dc38a8bmr898780pjq.47.1714521002385;
        Tue, 30 Apr 2024 16:50:02 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:313a:f4fd:13d2:b9eb? ([2604:3d08:6979:1160:313a:f4fd:13d2:b9eb])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm23008938pll.249.2024.04.30.16.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:50:01 -0700 (PDT)
Message-ID: <eaca2f35828c28ec4baebeb07fdcfc2bc67dce80.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/13] selftests/bpf: test distilled base,
 split BTF generation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
 mykolal@fb.com,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Tue, 30 Apr 2024 16:50:00 -0700
In-Reply-To: <20240424154806.3417662-4-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
	 <20240424154806.3417662-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 16:47 +0100, Alan Maguire wrote:

[...]

> +static void test_distilled_base(void)
> +{

[...]

> +	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
> +		       "distilled_base") ||
> +	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
> +	    !ASSERT_OK_PTR(btf4, "distilled_split"))
> +		goto cleanup;

Maybe also assert the value of btf4->start_id?
Otherwise look good.

> +
> +	VALIDATE_RAW_BTF(
> +		btf4,
> +		"[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[2] FWD 's1' fwd_kind=3Dstruct",
> +		"[3] STRUCT '(anon)' size=3D12 vlen=3D2\n"
> +		"\t'f1' type_id=3D1 bits_offset=3D0\n"
> +		"\t'f2' type_id=3D2 bits_offset=3D32",
> +		"[4] FWD 'u1' fwd_kind=3Dunion",
> +		"[5] UNION '(anon)' size=3D4 vlen=3D1\n"
> +		"\t'f1' type_id=3D1 bits_offset=3D0",
> +		"[6] ENUM 'e1' encoding=3DUNSIGNED size=3D4 vlen=3D0",
> +		"[7] ENUM '(anon)' encoding=3DUNSIGNED size=3D4 vlen=3D1\n"
> +		"\t'av1' val=3D2",
> +		"[8] ENUM64 'e641' encoding=3DSIGNED size=3D8 vlen=3D0",
> +		"[9] ENUM64 '(anon)' encoding=3DSIGNED size=3D8 vlen=3D1\n"
> +		"\t'v1' val=3D1025",
> +		"[10] STRUCT 'embedded' size=3D4 vlen=3D0",
> +		"[11] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +		"\t'p1' type_id=3D1",
> +		"[12] ARRAY '(anon)' type_id=3D1 index_type_id=3D1 nr_elems=3D3",
> +		"[13] PTR '(anon)' type_id=3D2",
> +		"[14] PTR '(anon)' type_id=3D3",
> +		"[15] CONST '(anon)' type_id=3D4",
> +		"[16] RESTRICT '(anon)' type_id=3D5",
> +		"[17] VOLATILE '(anon)' type_id=3D6",
> +		"[18] TYPEDEF 'et' type_id=3D7",
> +		"[19] CONST '(anon)' type_id=3D8",
> +		"[20] PTR '(anon)' type_id=3D9",
> +		"[21] STRUCT 'with_embedded' size=3D4 vlen=3D1\n"
> +		"\t'f1' type_id=3D10 bits_offset=3D0",
> +		"[22] FUNC 'fn' type_id=3D11 linkage=3Dstatic",
> +		"[23] TYPEDEF 'arraytype' type_id=3D12");
> +
> +cleanup:
> +	btf__free(btf4);
> +	btf__free(btf3);
> +	btf__free(btf2);
> +	btf__free(btf1);
> +}

[...]

