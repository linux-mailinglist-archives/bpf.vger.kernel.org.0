Return-Path: <bpf+bounces-50071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E9A22621
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 23:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A0164E94
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318511AD41F;
	Wed, 29 Jan 2025 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffGRDnGe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E818DF60
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738189081; cv=none; b=MTFAcP3HE1AigTgjJuw66dXYKy/58DwTST0ItVyU+PA0paVS0tKJzOO6J9AKhsFcDLTCBIK3G7ROzoFvCFwv8P/tohP+AI/oH5DWotmTDsy+tr2rj4er1Aad5d6xdiwuvKjsxdT8223hLTVsmD4IMVLUPg6a8wbXGsA9UnQp9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738189081; c=relaxed/simple;
	bh=n9z3XUSbFvE04HwxiWyFEdSgMydYBwmpQpT3oM9h5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow37g72VDrVQXKwbEAFXbMRRl9/yoWmD/0ASsHCC2h+xygBukVmRvGqPyoz6thQLNCsksYF7BZhGMfgUIS/rGMo3v8FdmjSkUJGGutEWibHkC3ZEibUCVXAu0xgD0HeXwI70VXXTVsribMauvyIYT7t+aGqK5xs8g3JGhAkAUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffGRDnGe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215740b7fb8so47735ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 14:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738189079; x=1738793879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIT6WcUwyEo9KeIbj3Ovq3CYT/DZpCtGV9L8fkEOb3I=;
        b=ffGRDnGeGxmXHGHv5AE/1ym74yFogpILI2ozzKtPgXVlXxE/UJWj5xEi/32CeS1hbu
         KwWbQkHbHwCMgleNicK4V6niegwbaQr7Zi7KSaiN9c8ojYkH1dH1IV5US9Z+dQ0+5tf0
         VeebBFfGDBx3JFrXGZhXuQpahzdoEiVotb4koAH+ABynit17obQzYT/kBCaRX1Icfw7q
         YVl4VQeZjl6vEbcNaSF8kJmpdj7hWR+MgPybk9yIFyjO0bo9wr/uVms8WX6vhzEBlRdi
         7XGLr/lBtfECsWDxRwHdlVXI5z0mQO8W1h5iyV1DGPLBFFlEG4Qi5tHl2k9jPgwCgzht
         5cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738189079; x=1738793879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIT6WcUwyEo9KeIbj3Ovq3CYT/DZpCtGV9L8fkEOb3I=;
        b=VupqLdxjw7MT8qBLcfH+R+TNHlDJabWj5da+UsWpIBhybxpktWMxpWtCO1jh7fv1je
         05/rsUrZcnkBtcuHMHy+XvJ86yt9U6urjtFrxNBcIf7G9wVLpXjC2xP5po8U+xF2iQ5w
         v/co4wP4jPR7EZJMjJmccrYWZisVFG3XNup+nl1m9/QZ+gHfx+5rlIYu3tkZVVOMGN5x
         Osmwr8/nBuCe2wzF8HQ0VG95j2S98aE492MY8e2cGE+/vBGgF/I+c0tdphdJ8D16+x3b
         WharP5+hshX3FELo2uob/0JPxV2sGOU+MIaYhU1/HI96ahcsZLBsOvQyxibWl7G00P3/
         Su+g==
X-Gm-Message-State: AOJu0YzODheXzKZKmROl6IAn+jIfOta1x/A5PPk1UV0RbYvon+wbALmO
	f+Xx/s8hDFCmro258VjTZuW52AhRXIAEcfk3zuHgFJ9Nq6HIqEBAXapFTlJY5A==
X-Gm-Gg: ASbGncsaNPFo8Qkx7WBaNFGg+/aok/PIkhz31iczt1RxRmv4hP95O+NMexiMccrtBoG
	xYImn/7oa12f7wme6aAqHgq7aJh0rZVqOJp6dvIBcjR0YQcWJyerwhBHfdBiWhMsj59Jghr8CJm
	lMPS/Y9PDTtA2A59fxGVZrjr/SsUpcQvIFXEk7TaCUNlaDWwuYHblI4hofitpROlZVufOFvTjV6
	KA0lsu+Y17IwF2SNSSI8gHlTOdYDazx5LlWvmo3z9YL8013OpcC6JLfXpXB7lukevZKwmBRTjjN
	lRNIwan9xKVoBJFmBADJhJlkoa5BNiHgAA6bBA5A+/uAiYAG9DU=
X-Google-Smtp-Source: AGHT+IHvBIEyFxy7JJRMnJGTsrg+dQOmuNpHdUPyjnzFG47cwFd2UWayuxvRdqP7ClKKnvOhwvLWAw==
X-Received: by 2002:a17:902:7c87:b0:215:b077:5c21 with SMTP id d9443c01a7336-21de2467d36mr776695ad.26.1738189079445;
        Wed, 29 Jan 2025 14:17:59 -0800 (PST)
Received: from google.com (55.131.16.34.bc.googleusercontent.com. [34.16.131.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d25sm2363395a91.5.2025.01.29.14.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 14:17:58 -0800 (PST)
Date: Wed, 29 Jan 2025 22:17:54 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z5qpEkXq-X6ci9UU@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
 <f5b72fa9460e4eda6e6b36756db855bfec67744a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b72fa9460e4eda6e6b36756db855bfec67744a.camel@gmail.com>

On Tue, Jan 28, 2025 at 05:30:19PM -0800, Eduard Zingerman wrote:
> On Sat, 2025-01-25 at 02:18 +0000, Peilin Ye wrote:
> > +static int check_atomic_store(struct bpf_verifier_env *env, int insn_idx,
> > +			      struct bpf_insn *insn)
> > +{
> > +	int err;
> > +
> > +	err = check_reg_arg(env, insn->src_reg, SRC_OP);
> > +	if (err)
> > +		return err;
> > +
> > +	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
> > +	if (err)
> > +		return err;
> > +
> > +	if (is_pointer_value(env, insn->src_reg)) {
> > +		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
> > +		return -EACCES;
> > +	}
> 
> Nit: this check is done by check_mem_access(), albeit only for
>      PTR_TO_MEM, I think it's better to be consistent with
>      what happens for regular stores and avoid this check here.

Got it.  Unprivileged programs will be able to store-release pointers to
the stack, then.  I'll update selftests accordingly.

Thanks,
Peilin Ye


