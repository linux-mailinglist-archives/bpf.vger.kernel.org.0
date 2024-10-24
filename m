Return-Path: <bpf+bounces-43109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD1E9AF55B
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08E61C21181
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B0E218332;
	Thu, 24 Oct 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aElTx+xy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A722B644;
	Thu, 24 Oct 2024 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808806; cv=none; b=LgXnb1DvK9QEPV52QuvdvQc4aTAryBwJ0M+eqEy6EIZzvwv/84wl/WZfNPN7FLa/cewAXiFwQR9gg0jbn9AJYNYS/6BVp+Ml8WjZ0qMyNcGtio7VWns5nr6Az1oFC4b+sEQ+M56/s5tuf3TeGDaP0kK3VZFfY4AnurOsg2PpTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808806; c=relaxed/simple;
	bh=q4A4Hgq35yFq08NgA4UPolXdO4wtYA7i1yQ/glUKdp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0/Mhgsq6GnMEXZpQpr1Jc1PeCV5sn3+djqCj7N9Fsx/gqoWLJzkFBJk9E8G3Bhk1hWLTYk4VFK33HhltB6yNLc4XrSzmczorvSyRncqZ0ormDvSy9X6yUAJx55K9fd+pt6GCP6/iPoro0pzlIMrdhJa/7Tl6wFCosMQZddikw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aElTx+xy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb7139d9dso11629325ad.1;
        Thu, 24 Oct 2024 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729808804; x=1730413604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NiHzKLQraKioiT/I9azeDUnBUmhw7u8h/i7D9QnPlcY=;
        b=aElTx+xy/Tu2I+TvCO3i8i64C7DfUaXabw1H4VhOjEoZ5hsT5JHxLoz3ZfaKbzYuxd
         8jfW68iUyg0h225O6Y/SwXnPMtIpgX3wHWtpFNdFk2OL7+atx3pURwwase5eBV2sMy7u
         HSWUX2/ME8zoP5VDJkYYuR9nLg/cHBuV8c+7xvKmD/nMNdvYJFEUdPVUKbNf91oLULQC
         LizZsWCulG/KvMjg/tltSPd+FCJtrtsvmuScWWkRGb3ExwppobY1WEwCJAjfJB1kz41g
         aN/PLCzkN05AGi1goCquy8rXf+5YG/lvs8LWJAdQ+p14cpSAwaP8LLYUii+KT7JYRwIz
         1JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808804; x=1730413604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiHzKLQraKioiT/I9azeDUnBUmhw7u8h/i7D9QnPlcY=;
        b=MF7Dxj6Vvle+6AtRHldvbiXlyyirW8XkWJ6rSZI7Ubm9KZH/hTvq2Xub1FLhaGSzcU
         eEv2VJZJmPaICP2cBssJiD57VwsGx1IwmhXN5A8tt0BAD+95EVSySvcADUGZctZeSt14
         QkKSm9HJE1rJDgCFYEuyg4pmZNY+PXxhSw+JZW5JDz/IY/h3rxxKdYsOdBWDXisRQx8B
         4MDbu8vH9jhz24o8vUqifClQnxQjke/ELyc96pTX3R8vm/KK4DQePfAsXh1PZoQgN7E3
         c/yBIGgNz0LfrrXD/qADl4tTyI4iuCmLqkmZaK96FeAtw3JNOTtjbL4RwTuwssF4Ir5P
         Gc/A==
X-Forwarded-Encrypted: i=1; AJvYcCWNeSJNHOGCLuAT1Du2e4UW/7tA1K44F86DFMyCM3zQf8W4OC7cn2/GIlTyNqWDXMoNMIo=@vger.kernel.org, AJvYcCXPTGTC7s8MKC4oEsqFQUIJ0h5ZZIOW2HZQCzT7U6TetCBYJ3jMDGOIlRH9gC6261rX4zWZS30tTNNxvP2G@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8gm1RPPXiIyug57S1LqHe7T5nrQqZ4YPjKv8BxRiIXXWnqzI
	sg2eD9jkOi+UKAb+lmLizAQdZnkkgm6H/npQ1xcibqXsVtKhqvn7
X-Google-Smtp-Source: AGHT+IGSTjw/N6qNmdaDEI10HzLH+IGi1O/MRy2BP2HaTOdPnnLAUdSs2tGDfr6EJKr3q3g9AW0U5w==
X-Received: by 2002:a17:902:d2ca:b0:20c:6bff:fcc2 with SMTP id d9443c01a7336-20fb9b33443mr51916585ad.56.1729808803465;
        Thu, 24 Oct 2024 15:26:43 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd508sm77027135ad.138.2024.10.24.15.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:26:43 -0700 (PDT)
Date: Fri, 25 Oct 2024 07:26:37 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: Add test for trie_get_next_key()
Message-ID: <ZxrJnZ4+hmZ90Mbj@localhost.localdomain>
References: <ZxoOdzdMwvLspZiq@localhost.localdomain>
 <d94bf8c7-b026-4608-83d7-6230f136ee3b@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d94bf8c7-b026-4608-83d7-6230f136ee3b@iogearbox.net>

Hi Daniel,

Okay, I will submit them in a series of patches. Btw, ASSERT_* macros
are not defined for map_tests. Should I add the definitions for them,
or just go with CHECK?

Thanks,
Byeonguk

On Thu, Oct 24, 2024 at 11:41:19AM +0200, Daniel Borkmann wrote:
> Hi Byeonguk,
> 
> On 10/24/24 11:08 AM, Byeonguk Jeong wrote:
> > Add a test for out-of-bounds write in trie_get_next_key() when a full
> > path from root to leaf exists and bpf_map_get_next_key() is called
> > with the leaf node. It may crashes the kernel on failure, so please
> > run in a VM.
> > 
> > Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
> 
> Could you submit the fix + this selftest as a 2-patch series, otherwise BPF CI
> cannot test both in combination (pls make sure subject has [PATCH bpf] so that
> our CI adds this on top of the bpf tree).
> 
> Right now the CI selftest build threw an error:
> 
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c: In function ‘test_lpm_trie_map_get_next_key’:
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c:84:9: error: format not a string literal and no format arguments [-Werror=format-security]
>      84 |         CHECK(map_fd == -1, "bpf_map_create(), error:%s\n",
>         |         ^~~~~
>     TEST-OBJ [test_maps] task_storage_map.test.o
>     TEST-OBJ [test_progs] access_variable_array.test.o
>   cc1: all warnings being treated as errors
>     TEST-OBJ [test_progs] align.test.o
>     TEST-OBJ [test_progs] arena_atomics.test.o
>   make: *** [Makefile:765: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/lpm_trie_map_get_next_key.test.o] Error 1
>   make: *** Waiting for unfinished jobs....
>     GEN-SKEL [test_progs-no_alu32] test_usdt.skel.h
>   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
> 
> Also on quick glance, please use ASSERT_*() macros instead of CHECK() as the
> latter is deprecated.
> 
> Thanks,
> Daniel

