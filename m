Return-Path: <bpf+bounces-62182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2583AF6257
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDCC4E82A7
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8D1E489;
	Wed,  2 Jul 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGBMoNtw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9D2F7CF5
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751483042; cv=none; b=HXL6Xdi0AjZIdtgQ7pnxmWuwKhSNxNtzp4n37JFcnNXtjKQvIvq0ZFkNz9OD4dBb5WWXwip0PP0D1+sJjS/o/IxArmbIks0wCMLG1aqWWKwXZzUcM+V0lnsC3+pbVuMm/b3+XV8jYVo2lX8KKH9q3zLonFZd8kgrFaYDAdYQnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751483042; c=relaxed/simple;
	bh=B5hMJwG04bS36U/IXTcamGJKs5cf8gV+qrAPA44Oy44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqU0cQM2g2wqno1+ck050eXn0iwKbHoV2Uni4aQaReKtMOAaFY27xYxG1zOaBFBGuaCzENcPAa09I6aBTAyhE30NfFHMgtO+KNj/S/mkI3upzzaE1LktiO/RgAoTVCGffdx2o3YPFRk9NUpzwkoDm5eXjrEnLxSLj2oWSc1XzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGBMoNtw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-237e6963f63so31519015ad.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751483040; x=1752087840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0tjXrwkBZeYBYJeh2KYL6BGkulJg4NgJQ8BPQbP84Q=;
        b=VGBMoNtwZx32Mb2CNxGcmBVLipKuTavRss1qpepTLtK1g4CpKOZmt9DJCpq5es4aUX
         W9O7mpSwQ7m7bNc7Vhsip8fX53YJv4GXH5fBJbGdfc6C3PTC46SbGx7gBVCqNiYTm1QE
         cp4NqISmx5q+GVX9cQciLK3z4hGPJTjsrZ7HcqEfH3meWFuUnO3T19DP00eouM7622sT
         ynjK6IKLnVK1Z60SxCS2H0uGaWF/2C4+2rSsDzX4EuFzo7+emjYcreS7FMXIsc+KteE5
         KAlzssYgjJuIxsyulg2Y5/ihDoiFFespF2TR2ep5HvUIJIgcBKv9+BCILhqtHVZM3IRf
         lSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751483040; x=1752087840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0tjXrwkBZeYBYJeh2KYL6BGkulJg4NgJQ8BPQbP84Q=;
        b=iAbpCPbVtwnM0fwN/hoouIo046jTHjfV/8hY2LPpXE65XKoCRdx/+dFKLA6Nn1s9cT
         CaEeD1APu8O61Z+F4W83JUoT0L0cnckIZFoppQ0woLKkbCw7vS+bScj401sopMOdBbsK
         N2Lg/qh90FSlKkm/1iiFrKLZX87zMrrtjR6MwQePR7OI/5QogryPnqQQv8RRhtzWR/hQ
         UrYfUWbNyQ7sdjM8plhcHQb5ur1HvqHBlMDK/WBBI/mJuBSans200DFd1/9Q3WeAMGhI
         w29QXnRUUJSi2/PeoshZ2LCPh6xOpSQLqqh5jtB8wXQbPF2S0ar+eGq69h+ut6Yedvk/
         xADg==
X-Forwarded-Encrypted: i=1; AJvYcCV+B9LVvlalU6Iad9CxeFXdlowLM6RguOorTCsCDzeIp/Yg7lXy+rThn46/9nyWMKMTdeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDfRIRHG9S9h3sWvsfwQS/S8y7W925EE03xddBQXQIae+XxOB
	9Qm+REvuGVE70UrjmPcPi21gH6bHsl0yaM76PCOInTFv4uEDAhyoAQSj
X-Gm-Gg: ASbGncutqn4oBZUQaK2QPP/VAJeR3yDvldKA2A5eY03c/d7PdDSYoLiw4yJtF0YnTjL
	P5octp5B9VsKIot4ZWW5RlVOdzd+CvR9rZPr/Z+fDdK/DXL5ZGVXMQVGIEnKgOZxuq0jmWAbQuX
	oVCpugFarEv2BRWNgAJspzxENdl7jAaiF55D1aE6gzGVt5f/xVT3nSeY9vhAm2z7aksj/YC+jEG
	OhDQRAdkHQmEXac85ZNMCCDU+TC6yQRRRCqiLl+t/5Wn7WLCvi+NT40grmFuyw3yjDuNxLMXpkE
	83fLlfP0CJxrYmBwo+aK6+Xl3s3BzVjSGiCZXMwEY6Dtj2xj64i6SpQ5cVGXZtXgGjxAp0A9Q9N
	6d+jY/vA0SnY=
X-Google-Smtp-Source: AGHT+IEUsSLq3r8qFGLZorcnAIxXsumEzilc9KmSMeAx4kHxLuRJh0+mnj9jxGs7sABiGA26ZhB+Tg==
X-Received: by 2002:a17:902:ef10:b0:234:d431:ec6e with SMTP id d9443c01a7336-23c6e48b6b0mr58628795ad.3.1751483040493;
        Wed, 02 Jul 2025 12:04:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ce31:8a4b:8b7d:e055? ([2620:10d:c090:500::5:5e14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e32d3sm131581695ad.8.2025.07.02.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 12:04:00 -0700 (PDT)
Message-ID: <cd208a86a068c70994461066b6d863307a5e0645.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Avoid putting struct
 bpf_scc_callchain variables on the stack
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Arnd Bergmann
	 <arnd@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Date: Wed, 02 Jul 2025 12:03:58 -0700
In-Reply-To: <20250702171149.2370937-1-yonghong.song@linux.dev>
References: <20250702171134.2370432-1-yonghong.song@linux.dev>
	 <20250702171149.2370937-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 10:11 -0700, Yonghong Song wrote:
> Add a 'struct bpf_scc_callchain callchain' field in bpf_verifier_env.
> This way, the previous bpf_scc_callchain local variables can be
> replaced by taking address of env->callchain. This can reduce stack
> usage and fix the following error:
>     kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceed=
s limit (1280) in 'do_check'
>         [-Werror,-Wframe-larger-than]
>=20
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Oh, well.
I liked stack allocation for callchain object, because it emphasized
its ephemeral by-value status.

The changes lgtm, all places with callchain stack allocation replaced.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/verifier.c        | 36 ++++++++++++++++++------------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7e459e839f8b..e2c175d608bb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -841,6 +841,7 @@ struct bpf_verifier_env {
>  	char tmp_str_buf[TMP_STR_BUF_LEN];
>  	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>  	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
> +	struct bpf_scc_callchain callchain;

Nit: maybe a comment here about this being a scratch buffer?

>  	/* array of pointers to bpf_scc_info indexed by SCC id */
>  	struct bpf_scc_info **scc_info;
>  	u32 scc_cnt;

[...]

