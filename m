Return-Path: <bpf+bounces-76857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F1CC72F0
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 11:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB9F30E4E21
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1283BDA8A;
	Wed, 17 Dec 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g+gODfQu"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A03BDA80
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967902; cv=none; b=GSSPHWdu+Xr4T7qnzlwE0ZmRU7JLa9LYPA2pdQoHNLAu31UxvlK5piFQjA2Khghg9gfDmqzB0TVtZUdiDQ6YyL4dNccWmwab9Ke1/sxAOmWFVCmKIvuLehVHcBy+t3bNfNNOO4HdrdiYilz5AUGweQrdSvKd2fX4OP6gFp0GhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967902; c=relaxed/simple;
	bh=Bi0A5xyQzAzMmvhTPYb84wqht90XVitNk3J6taYf2/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6WN0ELij1lY9LgWFXmLU6gcfEQbT2L4E3egdHsdFkKXpCq9HD3rxaWUfM5p++ecv/XM5Qz7bkaA8+yyTqe5rYKDI6JA9l4BRDMEIlP7NKrGtf1L6M19ULcB7awQ11XLN+xwyV6hdCghEK12S9kcFdodLE+a2B5pNFBqgg+xmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g+gODfQu; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765967891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/UoXNWt64owICESDRDCydShXt+IIujt1eIf5x6/3j4=;
	b=g+gODfQu4MFyoWMUSbLujm7o9X0gkYPZBmTMY21kTnrGX3puyBpr5uleWgKaM/3fHpmlJL
	Kp9Cpi5lOfmD85pWUox+9FuWBdIQnjKg4PtRlQFsAzngNagfB47a9wPDyRVnVh8ikzbnni
	G9fOuzaZZ++o3Lr4/QGU62urGLTXf58=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, andrii@kernel.org,
 bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v4 9/9] selftests/bpf: test fsession mixed with fentry
 and fexit
Date: Wed, 17 Dec 2025 18:37:52 +0800
Message-ID: <5955023.DvuYhMxLoT@7940hx>
In-Reply-To:
 <351b78207e3df166707b3f8c9fe446504167e35819d0dda26559559ebf548e83@mail.kernel.org>
References:
 <20251217095445.218428-10-dongml2@chinatelecom.cn>
 <351b78207e3df166707b3f8c9fe446504167e35819d0dda26559559ebf548e83@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/17 18:24 bot+bpf-ci@kernel.org write:
> > diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> > index f7c96ef1c7a9..223a6ea47888 100644
> > --- a/tools/testing/selftests/bpf/progs/fsession_test.c
> > +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> > @@ -190,3 +190,37 @@ int BPF_PROG(test10, int a)
> >  		test10_exit_ok = *cookie == 0x1111222233334444ull;
> >  	return 0;
> >  }
> > +
> > +__u64 test11_entry_result = 0;
> > +__u64 test11_exit_result = 0;
> > +
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test11, int a, int ret)
> > +{
> > +	__u64 *cookie = bpf_fsession_cookie(ctx);
> > +
> > +	if (!bpf_fsession_is_return(ctx)) {
> > +		test11_entry_result = a == 1 && ret == 0;
> > +		*cookie = 0x123456ULL;
> 
> Should the cookie pointer be checked for NULL before dereferencing?
> 
> Looking at the existing tests in this file, both test9 and test10 (which
> also call bpf_fsession_cookie) explicitly check if the cookie pointer is
> NULL before dereferencing it:
> 
>   test9: if (cookie) { *cookie = 0xAAAA...; }
>   test10: if (cookie) { *cookie = 0x1111...; }

The checking is unnecessary, as bpf_fsession_cookie() can't
return NULL. I'll remove such checking in the test in the next
version.

Thanks!
Menglong Dong

> 
> test11 dereferences cookie without this check. If cookie were NULL or
> invalid, test11 would crash rather than fail gracefully like test9/test10
> do. While the BPF verifier likely ensures cookie is valid when the
> program is loaded, following the established pattern would make the test
> more robust.
> 
> The same issue occurs in the exit path:
> 
> > +		return 0;
> > +	}
> > +
> > +	test11_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
>                                                     ^^^^^^^
> 
> > +	return 0;
> > +}
> > +
> > +__u64 test12_result = 0;
> > +SEC("fexit/bpf_fentry_test1")
> > +int BPF_PROG(test12, int a, int ret)
> > +{
> > +	test12_result = a == 1 && ret == 2;
> > +	return 0;
> > +}
> > +
> > +__u64 test13_result = 0;
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(test13, int a)
> > +{
> > +	test13_result = a == 1;
> > +	return 0;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20299185010
> 





