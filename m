Return-Path: <bpf+bounces-47559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8F9FB51B
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C004168279
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8277E1C5F20;
	Mon, 23 Dec 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBZp4BQ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9E1B0F16
	for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985095; cv=none; b=tJDzCylBZIB0y4vycRxeRpdQmAuxBxSmXuIorWydthth0pZCwleV4GF7A84OYep4kH/kvT6BUUFN0F0al3apvhDS25NFsXA+aUxW+6SM6mRkNiKbFowt4Tw2CTUS3MNRXH2PhK49gMIt0TtaqBHyQfwomRv0Pny9JHIWtQJYRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985095; c=relaxed/simple;
	bh=wrEVLh5NeGYoGui5ocbgaJyr9K02aRsPK7qoZ68wF18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJrjVisvZMpfW1rOBRJ2h+Z6mEj2AYNyzGyTMTkPh34pYL6w+JhwzFAbzBZiOxRO9ND/pSC63825zONNAlHrZj2nWZ3C7lF8ETjoq3gfDM08wn64KlMCczeg/+b82q2I5jpJPbt8LNWfQk8exwGOtdlprFKNhb65mL+6JiLSC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBZp4BQ0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163affd184so452555ad.1
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734985093; x=1735589893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/md9RH+lZJRhxwWxoUhNdQcDiOG8BAv89i51DptP/5I=;
        b=QBZp4BQ09ajvvj1bvSf7Ti4JGYldc98sebSGWrp2HqTIyx5q3QBpl9Qdepray6gI95
         RgwAOk6Duj81V02L+w0SzR4xvrXqO4U51CI5HTXu4xnBljdGwa7pQJSAPi9UoWDu+KZ/
         3SLFwKOYcSbQpUrJJPA3HBm35174Eai6lfHkAz1WYwFFtGzoLCpf0IN/v0nhEc80yUzt
         OYlKOnRd0kCiPIVVRitlEfcXwg3UbqRecZZnJHIuHi1ivNGZjJYwxRPuBDsKsydTacZ+
         uCpm51FTwc/qZw/6NP929qY1U3YCGgwJZ07gnrSoJCES/246iywQurhWyCfIBeMj+rNA
         e6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734985093; x=1735589893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/md9RH+lZJRhxwWxoUhNdQcDiOG8BAv89i51DptP/5I=;
        b=MGs6E1+mAaVOtAD+JhwlvxtzzZrSXG9D7khoEp45vSmCRgs+QQ4ndV71lOceKgCa8x
         spCPFLRlxX1CC4FyG2Tn6iQbEScJBalYtI/E8dhtQXjnUXDdn5K83EAnyV99eTtA6Tds
         7nNDMWRpCc6SffW0JiV+xXF6bL35u2jmsJMlICCOkcdVyUNTLt8cWiBmkemzkEnxHA/x
         e3Z/pCmOGbtQ+/5/ELSAzAEi76S4kMUFfAspNox7bEkuiP2zC8cMijTEVl1Np3X9yeYk
         tMrgkliMTSK+1U00lw2BWnOEcDo8P0x+Yvsp5zIPjOVSzpY/LPdg8shgbUj/18Lwb30f
         KEiA==
X-Gm-Message-State: AOJu0YywSNjKkNP6PQUafvnIlVNBxk902eCLvW+u32rIb+8+Epz/OXcC
	FAJjz77Dew6eFn6DFTZifh3qLw0h6VSuSZRAbFOWkYzYIP/Ux43PyGfHqdMCAZwtQrves6omMNg
	hHRDO
X-Gm-Gg: ASbGncunlHHpg9GR2ZaXtS5QfL7pv5DadvSwkt8LPuhLxM4NJ/S8h82lYsaNDOcPE86
	JKFHv77ExWShWFt0jakDy5kwNKoj6KFHzA5Zl70xawDoiXg2EaK2CKBFTtTeOXPCcbH8BEgZziJ
	zSs3rBdNjdqA5OA4Dlf9YOeAeQXiTjBbHg6W2IwOIaYwh3sMDX+CPHYWKKHcQlS//nINIiC3IP5
	FRGFi4eZGjzLf99aJdsCy8ZW5t5CNsFR47KuziUguducJkU45M02klbl5wXaT0SC6XloLqhRhjL
	F1V67dsHU+iyViH3DVU=
X-Google-Smtp-Source: AGHT+IGhY7nMTrXZAk0yGOvrUlQg3Qt4CxYqiCr3gnrdLKSbnhKzPwbfO7ySItkpYbBhTvR9iNWffQ==
X-Received: by 2002:a17:902:db03:b0:216:5e53:d055 with SMTP id d9443c01a7336-219e770d02amr6111235ad.9.1734985092625;
        Mon, 23 Dec 2024 12:18:12 -0800 (PST)
Received: from google.com (40.155.125.34.bc.googleusercontent.com. [34.125.155.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc972251sm77654385ad.96.2024.12.23.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 12:18:12 -0800 (PST)
Date: Mon, 23 Dec 2024 20:18:08 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 4/4] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
Message-ID: <Z2nFgHqT5zaNd64C@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <114f23ac20d73eeb624a9677e39a87b766f4bcc2.1734742802.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114f23ac20d73eeb624a9677e39a87b766f4bcc2.1734742802.git.yepeilin@google.com>

> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/atomic_load.c
> @@ -0,0 +1,71 @@
> +{
> +	"BPF_ATOMIC load-acquire, 8-bit",
> +	.insns = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		/* Write 1 to stack. */
                         ~
                /* Write 0x12 to stack. */
                         ~~~~
> +		BPF_ST_MEM(BPF_B, BPF_REG_10, -1, 0x12),
> +		/* Load-acquire it from stack to R1. */
> +		BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_1, BPF_REG_10, -1),
> +		/* Check loaded value is 0x12. */

Will be fixed in the next version.

Thanks,
Peilin Ye


