Return-Path: <bpf+bounces-70242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04542BB5264
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5880341D90
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 20:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4A1CDFCA;
	Thu,  2 Oct 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njINWU+R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168879DA
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438070; cv=none; b=pEf6N2TDP0kYCKpfYLSeoRDSXZAQDW0co/daKJywGB9XGcWH/wzZiM23ExN2aQJKUPUSSa8txAJoDnyOnlx3m0l+eh6aEhxy2FgfSh5TC1sQOlTPWjv7/OJOix2/ISPM1dxLItVIQaFs2MBK0wicV+5v1IZMNMQdfvi8zOOhFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438070; c=relaxed/simple;
	bh=E0t8xCh4jlENq4XvHikaO2TfFDAxiphADQFTC9F6aBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4vv/vEWLh4MXUzgQP9IJC+mNYR6E1vk1acN9Vq94kYGmwd0WJR6DgDp5qMuRAwnKYmoSOJFBjC9uV39Z6nxajEYGeAAfa9gYLU+TXq1csaD6gNriEyz/YNU8kHuS3qm+TFIr7k6NoV4jT79blHGzmRdLBkPkw30FHX8mCJpOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njINWU+R; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781db5068b8so1333832b3a.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438068; x=1760042868; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5KaMQpCnPqoZg1fE/e2gQUeWT2Na+jiTyHt8qg3WvpE=;
        b=njINWU+RnAI/Z5MnJGQBjqj2RcbKEb0Hj8raal/Ry6XD8sHVdgt+zSmaaOCaVRbytH
         C/RCLAAo7WUfCw/gwo5L1uDDeqtsRJJrC8g1jiO90RZ+HqNDqmc4X9zy528EgixZUCal
         DZh+l7FbSCAe/oHH5xfJgUrGkVmU4SNTm26yykCt3KS1BpgCiUJitVuAWbsAqz1hDpem
         bmu45vdCP3T0eUAMyHh9uKGW4u7bTLTdeY+Kai8iK6vMo+CoWoDa3lTiZbGw6U/AKFLo
         sRCOY74RVVPNKmOdkGq0oRp1wc/bW5ukKB4p+qF1ugRFj0+FChgWotOBr0BmYtueHe9/
         iJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438068; x=1760042868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KaMQpCnPqoZg1fE/e2gQUeWT2Na+jiTyHt8qg3WvpE=;
        b=jV9BGX5EW+nWgF6PyAs00AgeHfLP8bmrZHiVZtJjBBxDHXa2IQkw8RiLAj3/gobnSo
         kw6ty2cDHZo9PW/tTAY7Ux7IA1aScReqyLL2bDgrMqOf8pZJxza75H0C2P9SHWPRAsrG
         nmmgPgMPFg2BeSTwV6tXdyy+/DIFw++RPW84mv0h+x+IB/I0hw9XovGkAfJLHxqa1bxu
         kpAyRvnIufR/uh19qUIZca/qCQvfuSScdTBwta9pdvKFTr4cICsxBcgOMTrBYTMMNxl1
         yy5XB4MepDJUgqRJ3ac/ZYoxz0IQAE+QxRdd4ObCtgJU4h/3cQFwKYFviabHa0E+GqCG
         LT1g==
X-Forwarded-Encrypted: i=1; AJvYcCUeNhSm5PtEGm2nxwTBqcsOvYgNUS3KH/4Srjqg8wqDM8ZaDvjwv2EvVlpF/isOBw/Pbjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0cbSiLh2yIbBZMO0u3DcKwIKhXrSJ5hpOOKvRmpa5zkNbQ20
	xRhLDeP6gTe/rjq8c4ByOatidrWEx1kacd49kzTPDjsoHdwmifdS6pl5
X-Gm-Gg: ASbGncv+cvnPSPppuwPYbaBbGpVw87YP6gPdezSDJR71cwwJmSxhMAOFptxXxVgovuA
	uasd8heZY25U4IuTKPS0JQwXs3LztY9TRFnPNsc3GruPYvK+sx1pGClVOcVJrkGOuVcczx7vlus
	SA/7mXpGF1zxnIsr0p1gwClLZgCTehmmfX0A9P3yxph1C3LaqycsTdJPfBG0eToEcvny73ohLFs
	VPgUrJerX8NoqVi8TzWcowF5yqFNF86qs/COsms6cVdjLD9qPGN81CFMMbo+OwkhwYyyjVfkTFS
	jY4mLtfPfVCL7xc5fv36NfTFEZCEhL+v1hRbcrB77OoJh3j2L0ncr7TA3SnE/v9cZ3Svs4swDWp
	RcYERjdvWhjBbCdhUC3dt0jkHvi//nTokYkc6gcAiDbEJ
X-Google-Smtp-Source: AGHT+IEV6HrYL0NDYaNo52pPpRy4ioEux91ekTpVhO1yJu7TqyY+cUa8hj1mQNvFfiUkjMQxFYKEiw==
X-Received: by 2002:a05:6a00:124e:b0:780:fb3f:9127 with SMTP id d2e1a72fcca58-78c98dc1afbmr844006b3a.19.1759438067872;
        Thu, 02 Oct 2025 13:47:47 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0208e6ecsm2914819b3a.84.2025.10.02.13.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:47:47 -0700 (PDT)
Message-ID: <269a9dd857907f3eb3cf02e27eace41e8a898744.camel@gmail.com>
Subject: Re: [PATCH bpf v1] libbpf: Fix GCC #pragma usage in libbpf_utils.c
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date: Thu, 02 Oct 2025 13:47:44 -0700
In-Reply-To: <20251002203150.1825678-1-tony.ambardar@gmail.com>
References: <20251002203150.1825678-1-tony.ambardar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 13:31 -0700, Tony Ambardar wrote:
> The recent sha256 patch uses a GCC pragma to suppress compile errors for
> a packed struct, but omits a needed pragma (see related link) and thus
> still raises errors: (e.g. on GCC 12.3 armhf)
>=20
> libbpf_utils.c:153:29: error: packed attribute causes inefficient alignme=
nt for =E2=80=98__val=E2=80=99 [-Werror=3Dattributes]
>   153 | struct __packed_u32 { __u32 __val; } __attribute__((packed));
>       |                             ^~~~~
>=20
> Resolve by adding the GCC diagnostic pragma to ignore "-Wattributes".

Hm, I compiled this locally using GCC 15.1.1 on x86 and didn't see
this warning. Is this an arm specific warning?

> Link: https://lore.kernel.org/bpf/CAP-5=3DfXURWoZu2j6Y8xQy23i7=3DDfgThq3W=
C1RkGFBx-4moQKYQ@mail.gmail.com/
>=20
> Fixes: 4a1c9e544b8d ("libbpf: remove linux/unaligned.h dependency for lib=
bpf_sha256()")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/libbpf_utils.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
> index 2bae8cafc077..5d66bc6ff098 100644
> --- a/tools/lib/bpf/libbpf_utils.c
> +++ b/tools/lib/bpf/libbpf_utils.c
> @@ -150,6 +150,7 @@ const char *libbpf_errstr(int err)
> =20
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wpacked"
> +#pragma GCC diagnostic ignored "-Wattributes"
>  struct __packed_u32 { __u32 __val; } __attribute__((packed));
>  #pragma GCC diagnostic pop
> =20

