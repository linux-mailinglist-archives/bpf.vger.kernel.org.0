Return-Path: <bpf+bounces-76856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E1CC717C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 11:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1330930FDDF1
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60803845C2;
	Wed, 17 Dec 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFn8LSCd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2D3845B5;
	Wed, 17 Dec 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967089; cv=none; b=AMHimARyLA90me4oCYJqeolaL9AcZK/9uJP3+Y3DUQIRfrj/lL8nDfP01WWccFUIJJ2DOBP3jD2DGegS0lptYdThKQFsJ61iPiQgaMNbTRbIKpQkR/1uB52+CuglXcbza0NVjOpX1XEO5Okyk1TYbHsnTTiJ9LFcsTujBY5pdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967089; c=relaxed/simple;
	bh=lFvUuyA71Irbwr12842hnIvR3Jp7AXlFdAFCCOEhLss=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d8PEdshLpJwUHIrEtDCdEKN9BKowayFEfFC6SDtwouw9dTlY/3lpCAuHJ3H6WfbYYHie6AKjSU5bU8UgHIVc5RNPQfgVXCQAgQyK0eBT3fzbG4tQd+rYI7Mb89gYWHykCtscwXoMK1XtHfeDIXs05lv8++/PENnsV4i3C9GvsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFn8LSCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAE6C4CEFB;
	Wed, 17 Dec 2025 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765967088;
	bh=lFvUuyA71Irbwr12842hnIvR3Jp7AXlFdAFCCOEhLss=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=eFn8LSCduFvuaWrm7BFSwYzuAaQBhm8/w9DutVAVgRblfUnX0t0Hw928JjJ2QOaLK
	 1/YOoI47joh8UnatPQMJ91oiyv60V+lcdeST+jG/ETz3bcnCsE6iDAlBfZBYiXln2W
	 g7Dgn5Du2iVYAzj+4TWx/Z9lICYEmQwp9/bl2A0P+ntZH98rZXeHvEc7BTeFp9Nwyw
	 ZekCgfrPycpYnOXTM1CrvD2LUGTQ+eejxHS8JUSlvyddGUq69RLgWuQY9w2j8XgRi7
	 17uXVmJS6dpAcJu9inw8Z/dtAS2ImFYcTo705hNm15jT8YROiw4/GSWaY9J6t9Wxsi
	 WMFCtl5+4/5ng==
Content-Type: multipart/mixed; boundary="===============3599015122214653247=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <351b78207e3df166707b3f8c9fe446504167e35819d0dda26559559ebf548e83@mail.kernel.org>
In-Reply-To: <20251217095445.218428-10-dongml2@chinatelecom.cn>
References: <20251217095445.218428-10-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: test fsession mixed with fentry and fexit
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,andrii@kernel.org
Cc: davem@davemloft.net,dsahern@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tglx@linutronix.de,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Dec 2025 10:24:47 +0000 (UTC)

--===============3599015122214653247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> index f7c96ef1c7a9..223a6ea47888 100644
> --- a/tools/testing/selftests/bpf/progs/fsession_test.c
> +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> @@ -190,3 +190,37 @@ int BPF_PROG(test10, int a)
>  		test10_exit_ok = *cookie == 0x1111222233334444ull;
>  	return 0;
>  }
> +
> +__u64 test11_entry_result = 0;
> +__u64 test11_exit_result = 0;
> +
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test11, int a, int ret)
> +{
> +	__u64 *cookie = bpf_fsession_cookie(ctx);
> +
> +	if (!bpf_fsession_is_return(ctx)) {
> +		test11_entry_result = a == 1 && ret == 0;
> +		*cookie = 0x123456ULL;

Should the cookie pointer be checked for NULL before dereferencing?

Looking at the existing tests in this file, both test9 and test10 (which
also call bpf_fsession_cookie) explicitly check if the cookie pointer is
NULL before dereferencing it:

  test9: if (cookie) { *cookie = 0xAAAA...; }
  test10: if (cookie) { *cookie = 0x1111...; }

test11 dereferences cookie without this check. If cookie were NULL or
invalid, test11 would crash rather than fail gracefully like test9/test10
do. While the BPF verifier likely ensures cookie is valid when the
program is loaded, following the established pattern would make the test
more robust.

The same issue occurs in the exit path:

> +		return 0;
> +	}
> +
> +	test11_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
                                                    ^^^^^^^

> +	return 0;
> +}
> +
> +__u64 test12_result = 0;
> +SEC("fexit/bpf_fentry_test1")
> +int BPF_PROG(test12, int a, int ret)
> +{
> +	test12_result = a == 1 && ret == 2;
> +	return 0;
> +}
> +
> +__u64 test13_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(test13, int a)
> +{
> +	test13_result = a == 1;
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20299185010

--===============3599015122214653247==--

