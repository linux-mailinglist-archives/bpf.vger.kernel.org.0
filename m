Return-Path: <bpf+bounces-65404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECCFB218C5
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9EC3A6950
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13C22264CE;
	Mon, 11 Aug 2025 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGeXhxr5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C12215789
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952702; cv=none; b=E2WpZVhNLIP/1Ua+3J4OK39QPushotfgTxKa/u+4BvtxdS0v2QsuRg+3JlEWL+B14LyosV6db1woqeQBOSfJnOg8305sAF8xKicUxShkE+cwPAJLIn5jRaz1myCM9+gyv2ejCti/05csspADr4JB4yScT+S7fQ25m5mtJf16z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952702; c=relaxed/simple;
	bh=waoKarsMOone2AEgDV1tF8ewqMukDAW9s8JAlOm7hZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oidg0mvgkZGjtmLjAtnu3maiQ2GAkmdTCCkkV8InnGrOhg5LwLw1takZHISUdH+MA4MKE6DaxYybmbVp2d8jsoeb8jJsIFSrODjQEr7O3g7fiGoeZQBcwXkAr0aCswsBsNqjACqDECLIJWbXFSapiR255biEY3Psd0bGganLnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGeXhxr5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so5734955a91.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952700; x=1755557500; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VB44naj1U0glF0hpoBIq+0hX+359HrSZA2Hg+71/IEo=;
        b=RGeXhxr5em+/ysOfCI/kPoW2XqfsgBAW1zH6LNisF3WvPdNQzaX65y0T57YB0WryKX
         R9udR/wymiQ0OsRJMkhZxrxVDiK9aH/uDhurPYeDomPENEV0/7/uWCWhV0janjIV0uVt
         U7JTtb6651yz6q6qQe/kHSml6+neyhB7QgIG027BR4nhepkkla+FUc41p3SRRkVnrBRq
         M0UbT3firCly4Icx1NnxaqyqvIuJFvW1MOqXjaGTvESn8PFjO0u2K1OPiVZ3KOFGQQon
         2O0Co+HHFQ80fBv9Baw2FwhYkCZRR/UUlc60e1MGVi3apyvBuSvks77iuyAaLCG0X2Or
         rc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952700; x=1755557500;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VB44naj1U0glF0hpoBIq+0hX+359HrSZA2Hg+71/IEo=;
        b=D4jf56vW3v1/A9L2GV8N2LUVQYjqkqXUfkvRPnXCP2/3FdTvb8jU+q2exhRuMSSFSe
         m164D78WhoQx0by+E2vrZ0sIbx2EhnCzdMT5PAI6nP1TYTuqU2ugMqZtjNhuqU85Sy96
         H0PufGKJuMfmnI2uscLk4xdOp5teEHw53ny06RBJHcmWGcjN1hzOsm5kztUsNpmRn40f
         L51bVh87U2DXsCgtCGtt2cMAfNA6776C6MZShRTl1gI7FCQiSL7hhQvEnRqSDQscYHf+
         KHrjQhv2kNF9J17WTRtAIQB5J4A3HrRBESpd4v7B3TmUlqju/Yh2rD1asx57uCWhrMOo
         oG3g==
X-Forwarded-Encrypted: i=1; AJvYcCVP9EKT24Rqw6n4+s5VjQHmyDVL3wBvjsLxhqBINXqhoGWGMlOiFcq72VvP/EfFLSKQ5YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Hh3401nejRV3zJx/71SwyUOh+LFUlc8QYLLA5X1lLZlZRkPp
	KnAjWz6Kjq8+aDONbMyiIPcXDEHrpFW0rktbpgdr9D9mAiTpHpPtuSM7
X-Gm-Gg: ASbGnctW6xT4B8hCDRMsiYP+RG6CIBhuh/AhORlTlWLA+SFTU/Tc7JgxBb9B2B57O+7
	jj+fKMFpaTQGBuxxCTA2R+zIgTWxx7v+KLjOU4AvQlP4Vx1wn8TEWW99dl1y6FWDHW2Zwisy/oR
	YaGy3AzU3KziQeChHcdkqA4+jKyVgvbuAtmgDLnUOCxsYl42GzT1I3HMMfYgiSnuBkNgbWxhvQj
	oceZEwqIDM1WCyCN8h2kEQhOHFedqtxB2boqRsiPtx1mEzn5eibzqInA7QkJn+temFoxSOgQmtJ
	fHZBXR7rFBnEVRJwcxdXmzuNP2u8W0fYIgjjtP8tIMCs2Z0Kjt50OpWymqsF9yq0EzlLeqAUGW+
	kp6vYLeImhgiQihlRruA1kFN4G7q+tEXuSO8sy+of9lWx
X-Google-Smtp-Source: AGHT+IHEToRQ+0b52D5DSsnHcjNRMeGOd1/m2JiyvPcu/85zbmIurYX8r/1w4L1T3SROqAUVijKVpw==
X-Received: by 2002:a17:90b:582c:b0:313:1769:eb49 with SMTP id 98e67ed59e1d1-321839ec278mr23474529a91.8.1754952700218;
        Mon, 11 Aug 2025 15:51:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:129e:4a5c:ec89:efc? ([2620:10d:c090:500::5:43c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32160ae5eb5sm15635149a91.0.2025.08.11.15.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:51:39 -0700 (PDT)
Message-ID: <ad1f513174bcbc48ca3eb21a746e4de8e4dd68a5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test for
 bpf_cgroup_from_id lookup in non-root cgns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	tj@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Dan Schatzberg	 <dschatzberg@meta.com>,
 kkd@meta.com, kernel-team@meta.com
Date: Mon, 11 Aug 2025 15:51:37 -0700
In-Reply-To: <20250811195901.1651800-3-memxor@gmail.com>
References: <20250811195901.1651800-1-memxor@gmail.com>
	 <20250811195901.1651800-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 12:59 -0700, Kumar Kartikeya Dwivedi wrote:

[...]

> +static void test_cgrp_from_id_ns(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct cgrp_kfunc_success *skel;
> +	struct bpf_program *prog;
> +	int fd, pid, pipe_fd[2];
> +
> +	skel =3D open_load_cgrp_kfunc_skel();
> +	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
> +		return;
> +
> +	if (!ASSERT_OK(skel->bss->err, "pre_mkdir_err"))
> +		goto cleanup;
> +
> +	prog =3D bpf_object__find_program_by_name(skel->obj, "test_cgrp_from_id=
_ns");

Nit: skel->test_cgrp_from_id_ns ?

> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(pipe(pipe_fd), "pipe"))
> +		goto cleanup;
> +
> +	pid =3D fork();
> +	if (!ASSERT_GE(pid, 0, "fork result"))
> +		goto pipe_cleanup;
> +
> +	if (pid =3D=3D 0) {
> +		int ret =3D 1;
> +
> +		close(pipe_fd[0]);
> +		fd =3D create_and_get_cgroup("cgrp_from_id_ns");
> +		if (!ASSERT_GE(fd, 0, "cgrp_fd"))
> +			_exit(1);
> +
> +		if (!ASSERT_OK(join_cgroup("cgrp_from_id_ns"), "join cgrp"))
> +			goto fail;
> +
> +		if (!ASSERT_OK(unshare(CLONE_NEWCGROUP), "unshare cgns"))
> +			goto fail;
> +
> +		ret =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +		if (!ASSERT_OK(ret, "test run ret"))
> +			goto fail;
> +
> +		remove_cgroup("cgrp_from_id_ns");

If this test is executed in -vvv mode, the following is printed:

  (cgroup_helpers.c:412: errno: Device or resource busy) rmdiring cgroup cg=
rp_from_id_ns ...

And cgroup is still in place after exit.  As far as I understand,
child process needs to change cgroup again or remove_cgroup needs to
be called in the parent process.

> +
> +		if (!ASSERT_OK(opts.retval, "test run retval"))
> +			_exit(1);

Nit: why not 'exit'? '_exit' does not flush file descriptors.

> +		ret =3D 0;
> +		close(fd);
> +		if (!ASSERT_EQ(write(pipe_fd[1], &ret, sizeof(ret)), sizeof(ret), "wri=
te pipe"))
> +			_exit(1);
> +
> +		_exit(0);
> +fail:
> +		remove_cgroup("cgrp_from_id_ns");
> +		_exit(1);
> +	} else {
> +		int res;
> +
> +		close(pipe_fd[1]);
> +		if (!ASSERT_EQ(read(pipe_fd[0], &res, sizeof(res)), sizeof(res), "read=
 res"))
> +			goto pipe_cleanup;
> +		if (!ASSERT_OK(res, "result from run"))
> +			goto pipe_cleanup;
> +	}
> +
> +pipe_cleanup:
> +	close(pipe_fd[1]);

Nit: should this be pipe_fd[0]?
     in case of a fork() failure, should this be both?

> +cleanup:
> +	cgrp_kfunc_success__destroy(skel);
> +}
> +
>  void test_cgrp_kfunc(void)
>  {
>  	int i, err;

[...]

