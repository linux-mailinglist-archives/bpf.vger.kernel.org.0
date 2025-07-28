Return-Path: <bpf+bounces-64552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEE4B141E8
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DE418C258D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B82275878;
	Mon, 28 Jul 2025 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vvpqoWH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E2249F9
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726902; cv=none; b=o9tGWR9y1XjgrPFkHYD+741dDCg8QGZ+0Ov70Fe6L/fPxTCG42G/GPb5VdNN4G7f53i2VIxti4QkBfaennpn5mBjCNfZ/wE32eyCd4ZlsNS/krMFoT+IhkoIZ4+i4wEnolrkCaMiRbb1ObPDiCJOPdCdrCtVVGZaUo0wrF842MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726902; c=relaxed/simple;
	bh=dG9bHeLM1xk//tApPMXIJ61OroVAnIbOewqczIzkC8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPBZTt4pzkaaGDIAhqnOhAOwBhzeHiyfhvcNG2gqr9AnV10XFCJrMWGJE7hB38x7F7GHo/PifeOshhe4JM74Bkct5fRCizs6f0tdEW9KlQr6MxQjZyBP6+Km7XnL1WDajdhUUv8bEyn6jU6G6Jlk+m8br5Ouhvl5RDaogllIxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vvpqoWH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dd9ae5aacso22745ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753726900; x=1754331700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3hmyZvfsTHdwJz4dIDqTvttC6a6u3BEsF8dGiWKG2w=;
        b=2vvpqoWHblnKEOj90Avdz3B37jWPurYdeg/lZya7Ptkf23uD8B9wXrLUCOn9F4VkPe
         8beMMMtFJxSVqwiKo5akZZySU1wt0h+avefCmoRVgZJQV/aoifsdajPGiqtjMjctjgK7
         1p67y5w2nhWQdQSlN0Ytu+9DUVQWnURkxSkHZBKtV7nmg0GcF8RASh059DUd6H8pEpAl
         oSuqeBl3qMN1vZRZeAzr3ZAbVFoX2XcYRyvxU3ZGsNdZWXmLx+NLBVPBiU4OuvLvJHWq
         z/Bcq6ipwOyH4fHhMFYgkaZgE72mEN+GLlQD/uYcBXfOT39VF7d9gv6zDbjAnqpdNpnV
         ZVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726900; x=1754331700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3hmyZvfsTHdwJz4dIDqTvttC6a6u3BEsF8dGiWKG2w=;
        b=QEZGBfcVAj6LjwpUNY6dltXgHk7zPYLKub0i0xOHWsEmtmiVr+KwHDPr/yQmTqbXYc
         cOFXCpNx/v2sV5lxVzyUhemz4MwV2Zh1jLifiUkbYbO/95iXx/69Zrf84NLVEttOi/Pp
         AW15VpOEtT3CpovC5guKMRlwqm+7F2mLlIQLy5InKUCS/UzoyLmLWfEbdQYwYcz4nbJV
         OrGiA3uBoGPJ0ZxMfuVPoamwBLbSs3D25sWV+vL+9Tp7uZ86n6TQzZNWJfbjXU2xoN13
         SHZyel2WnfTcvGxVzbzWMHOKo3V7+VII7nQZyeNzzn/oF0CXJdJqLgnBucwULfPLEnLQ
         CQmQ==
X-Gm-Message-State: AOJu0YzPW3YopYzctfYA0CS8Vzh7Qffck3CsVTk3UzAae2l885s0ROJV
	6XuEHxoiA/HL+6wnHyKL9FN7rPDe6oZ3KcBb2bSSnvg5Jmb0UWErqGjJM1/IAtpD3Q==
X-Gm-Gg: ASbGncsnPq7K8P+yGkwGk+S81OwGJSoDcA+mhlRHrIILKjtuI4yv8HYNAV7zG3JvOoJ
	GZYQu2I5nUEr3PvVsHQzWiJKsEOoUHF1A9NMa9bGuAfp3ERg+a7jqMVG11uIgqYPJM7jq1Yyupt
	Jzg4aWcyJO1/99GOkAhs+FF0DdN2FMYh3sX6Pc/BWSxphm7wou7+gQk+a9x3hwK9giu3SR62xN9
	JSxmjH+m182kzlIzfbFBsEkVtd5jyuXYRIytL2A/mrjfE/xHgtJRSSPJOSPMlDaonlOeV9kWd9e
	4apsY5Ax5UMSs63Kd4pc3tdcoeigqHMAF8ELmw7CDYkpJMKGXEq3NNQ1IiQWbjH+TiwW3BXZMum
	d8U3Ow/APyigjy4MIxW5UbS9Rk1o52CJ0lMZS0ABtCvnmKpoqEEpTIpkmr+NtlF2oSDNB
X-Google-Smtp-Source: AGHT+IFcpgJb1R5wQYv4TfO2DcoDyNX+OGPn08Wv51Nbvqxg+j9hq2EXJS/j5nO2oSPzqax8ItBhqg==
X-Received: by 2002:a17:902:e890:b0:240:3c64:8638 with SMTP id d9443c01a7336-2406789b433mr308495ad.6.1753726899944;
        Mon, 28 Jul 2025 11:21:39 -0700 (PDT)
Received: from google.com (111.143.125.34.bc.googleusercontent.com. [34.125.143.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-768cf25edecsm1635674b3a.137.2025.07.28.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:21:39 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:21:34 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] Use correct destructor kfunc types
Message-ID: <20250728182134.GB899009@google.com>
References: <20250725214401.1475224-6-samitolvanen@google.com>
 <5d7d1ff3-14cd-4c18-a180-3c99e784bbeb@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7d1ff3-14cd-4c18-a180-3c99e784bbeb@linux.dev>

On Fri, Jul 25, 2025 at 04:42:29PM -0700, Yonghong Song wrote:
> 
> With this patch set and no CONFIG_CFI_CLANG in .config,
> the bpf selftests work okay. In bpf ci, CONFIG_CFI_CLANG
> is not enabled.
> 
> But if enabling CONFIG_CFI_CLANG, this patch set fixed
> ./test_progs run issue, but there are some test failures
> like
> 
> ===
> test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000d581 - ffffffffa000d558 > 39
> processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> #32/186  btf/line_info (No subprog):FAIL
> 
> test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000dee5 - ffffffffa000debc > 39
> processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> #32/189  btf/line_info (No subprog. zero tailing line_info:FAIL
> 
> ...
> 
> test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000e069 - ffffffffa000e040 > 38
> processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
> #32/202  btf/line_info (dead subprog + dead start w/ move):FAIL
> #32      btf:FAIL
> ===
> 
> The failure probably not related to this patch, but rather related
> to CONFIG_CFI_CLANG itself. I will debug this separately.

Agreed, that looks unrelated to this series.

Sami

