Return-Path: <bpf+bounces-45839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F749DBC35
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EF162682
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C11C1F28;
	Thu, 28 Nov 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCpBp966"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5021C1AD0
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818967; cv=none; b=aIa4g9JScthLWc8GdcNvxfvxtio7aYZsFFXpNnIX90+1HPTXGou7lf6e7/hx8JqS9nwxrM3+xJy4RvTS1XdLL7bxYM8PlgM6YWG96crWFsliA2oSW5DHCSVr0rbLyKxaw2GhyA5CDUQhvasgiaeOeStgnKfxKpUASYzEf2RW0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818967; c=relaxed/simple;
	bh=Ubvzn6fX/QlF741vPJbQrgZFw+uou+jS4l+WOSuJ+yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAg/tVbYp1oAoNu8773q4KEM1BteMpnBmhO6Re9y31QrQW+6OeVTJyoWnUQBqnq3LODHsZUpaoTk1JxW3eLyqzN9uMWXMPn8xd37BjzvZoTzTqeGZAyvQbvEpSADusMOBypd5qHAE82im2klj724Mk/aB65B/0vmFHL3vlsh7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCpBp966; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3823e45339bso838479f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732818963; x=1733423763; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM9FRXdQ7XraFHzVrbpJT90ccKW9R2coxeV037cC2L8=;
        b=oCpBp966huI5bIP4qsopxctFxNAT1OOlfWX8ckukYqt1GngDVtk2KSithTW96jROWQ
         LOWP1lcrGffMh2HGIYW2OWq4lk7BEnUsJuCLvTLgf1L/6VhnU6JPu6F1+0p9toDn0V5h
         Ehvcd+S6Scm0RECmXuRZ4vEQjrxmaHwl3eyAoCkbq+B0LZnmC83N/UewelUTnGpYX3Ja
         G6N/RptS21VE2YJszR2iWNFGLvOKMiwONfi/NyTKKNsJoyOe/YDmnUtEJmqgzSVkl6wS
         70HDQTTza5znI9D77Xv9rDsHdqvNYgw4gT+vmKFP2NVaAoen36aJ+7DFyl/MDXn56HZE
         kmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732818963; x=1733423763;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM9FRXdQ7XraFHzVrbpJT90ccKW9R2coxeV037cC2L8=;
        b=bnYQpEOjMn0C6oPgKaBo+F+a+jgdyc3G/HFD9vyeNbGSFEtKVNdYaNgNTkmOklPn1K
         5zxSM7V/n++6kl1o+Y95MW0rICRqaZLN8wQXpmPCkNXjtBBb3eyPvfKQWud5qL/zO860
         p8e9fGGW2HhTEPcoNNWvmaMXmbhcBKZrnRJzZGKPOmCU+8B+iDWwzETj65TWbz9uK6oM
         USi/gM4MZdaFYtUKrqmEtFcyUgSMpMpzlwy8v4Tl2FgoJZmiLIDJhO0gj9QSgIUEy+am
         b64S7DvMRq2ELWkU2opdRSO7skIGH6b/wZ4xMpJwoNUqKnuZwP2u096iHPu3h58RM7DU
         bLHg==
X-Forwarded-Encrypted: i=1; AJvYcCWrgZ0UKhTlo9Kw853vVzfslii7hxu0OiBJZgTaNq01TKcWwYXTk4XtjxwkJPNJ5Bwy6yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMO1dtmn+R9lAvjMWcf/m9tGJijPS5cUAY8+4GazxZI/rPruq
	36E9zYe95/3PbIue8R7+ZNkuX2PL1yhbszO3eoD5HrMrnrgNotOZkD3dRPpMGA==
X-Gm-Gg: ASbGncvLxoxd7h03K3egbDwyUVQf0OxnLTKkGJ5pMP76ANB8grgJIjKrjQsF7HAnmwv
	FbdiNmeYXaB+g+HtYKoS5/nVxBsiSVvIlj2/BfNjzUqDI6G0wQ0D2py9tNnFySMbPYWaUNGCCpw
	GqTszCpUHTrlOT2Dqjx9RTA5SAi0UVGs6Xb0IBjR9uYpes2bInHUwMU2wq3JJkz28sp9e030Bgc
	jay9ZTM4vuIKGH/J4SdhBDI/8aQK+X5rgOiNm9+Fn3GKUIzL40=
X-Google-Smtp-Source: AGHT+IHwtzbrTZQq/kuMHiLgmkAZgYX0W7epxFqD6mJQJjrhi8rq1Sw2X7wHqwlDXUEtFBwWRKMKzQ==
X-Received: by 2002:a5d:6484:0:b0:382:455b:eec6 with SMTP id ffacd0b85a97d-385c6ec0cebmr6068685f8f.35.1732818962651;
        Thu, 28 Nov 2024 10:36:02 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:dce5:a12f:3f52:18d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm2328351f8f.7.2024.11.28.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 10:36:01 -0800 (PST)
Date: Thu, 28 Nov 2024 19:35:56 +0100
From: Marco Elver <elver@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nikola Grcevski <nikola.grcevski@grafana.com>,
	bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Refactor bpf_tracing_func_proto()
 and remove bpf_get_probe_write_proto()
Message-ID: <Z0i4DFnqRxTPOUfJ@elver.google.com>
References: <20241127140958.1828012-1-elver@google.com>
 <20241127140958.1828012-2-elver@google.com>
 <CAADnVQL6yyRRUc1Xee4HOQ0QXEiqQ7M-xJ109w9aztYH4ZWHmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL6yyRRUc1Xee4HOQ0QXEiqQ7M-xJ109w9aztYH4ZWHmA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Nov 28, 2024 at 10:22AM -0800, Alexei Starovoitov wrote:
[..]
> Moving bpf_base_func_proto() all the way to the top was incorrect,
> but here we can move it just above this bpf_token_capable() check
> and remove extra indent like:
> 
> func_proto = bpf_base_func_proto();
> if (func_proto)
>    return func_proto;
> if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
>    return NULL;
> switch (func_id) {
> case BPF_FUNC_probe_write_user:
> 
> that will align it with the style of bpf_base_func_proto().
> 
> pw-bot: cr

Ack, let me change that.

Below is preview of v4 for this bit.

@@ -1417,6 +1409,8 @@ late_initcall(bpf_key_sig_kfuncs_init);
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
@@ -1458,9 +1452,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_event_read_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_write_user:
-		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
-		       NULL : bpf_get_probe_write_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -1539,7 +1530,22 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id, prog);
+		break;
+	}
+
+	func_proto = bpf_base_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
+		return NULL;
+
+	switch (func_id) {
+	case BPF_FUNC_probe_write_user:
+		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
+		       NULL : &bpf_probe_write_user_proto;
+	default:
+		return NULL;
 	}
 }
 

