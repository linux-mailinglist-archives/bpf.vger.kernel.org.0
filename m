Return-Path: <bpf+bounces-64982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFFDB19B89
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 08:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E83189812E
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90522FAFD;
	Mon,  4 Aug 2025 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFpTr7z4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428F22B5B8
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288525; cv=none; b=mhTJNvdKtuBUbfOcYt7dKDnwegcjvT6K0tR+4IuNWbYOqxftLcj5534vsmdA6XuYjgvGZaTXxVXJSvTEsL164Q7wm6QUhVeAUoDG26ASpiCKTuyg9W/jBZ+SyPyYYGw8cqyrWeHChdyCW+ybYHe0E/HCrrLpw4dqOZJIKIDG8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288525; c=relaxed/simple;
	bh=ZVTBW5jom+wDo14xqU/nVDagKZZ7c7CrXYvPIvLZROc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=auLH5nHyM1nFcXgBoxJiGMcJ9O9PS8US+kB3NGTNQ2Twp69ukq6z2qCmGDg16zTJWDucEwlER/jryeF+F71L1/DTU3I6MFAGQii7Vyg1OTztSEKRTHu/vi15+6oTRqOvJnVRhUpupShmuxyDfYRwcxqG6wrr5slQ9+1dozG2n5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFpTr7z4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459d7726ee6so4590705e9.2
        for <bpf@vger.kernel.org>; Sun, 03 Aug 2025 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754288521; x=1754893321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeEcVaPruyFJjHGwTwns3V0T483/MZqGWdfOA8z6Bjg=;
        b=VFpTr7z4lSDl+YfvurNCmckFom/oz2xyIMvZ0gd+Hrj+q/CwX7LA8Wv2aWp20BUmsc
         F57UuHJ7mP+ZPOh96rfKGN1e9itJSwJaqb3Idw8jaz88CMwXQz7ksDIhIVYLHFxqbJtF
         N68x/1GyeeSXALygyLIQhwsviGnoiBoDEBcLyTPSrEzQxOfgYIDWz20i/+nVOqptkraJ
         Pnxz3DQ3xt+b2tju6lGLoSIAUChWXgbRIw4QCvV/YOwezbrnBuO4BzWaWY6a4/MrgoLO
         4zOtZ81Wo5RMYvcy8iQfTDF/vibhanXtjFetQUP0N6eYa11u0hD/NOkdEYaLfdHUPVB4
         0p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754288521; x=1754893321;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeEcVaPruyFJjHGwTwns3V0T483/MZqGWdfOA8z6Bjg=;
        b=D6cLyvkNOrG7Rk++9Mvot9h/LLGJVwyO7ukN5DpXx2T7Y+ZLjVZj4j43HDUU3Qap9j
         CuKDhGHjwfXujhEJrwE7BvyiWyNn07+0rPFp1V5wtnbKe/6iIVJidKavP9v+qGo1PHcT
         9M/EuN4nGIEHjyWUixxuhBv5cDdArspwQ/rCRa3oUbR1RQHmRqhtHe207E/auXTRO4nJ
         7U4sB/d88kyU0NZvpqQ8gmDr7AWaw7OxZKgKgf7CWzaAZDAvBvjxqUrO+FEiKlWiox3h
         jGQ5nau/3nzXrA7hSPsdd3tAi4XLXIutu98NPhnM+rL3Dro6PZbnHzOlJuU8lK0nCikZ
         W32Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfZGRRxnruZiWjd/51Wln/fJw5oJVYDGOD0vcLDpkc+Dh6SBO8ob+1X6Qr2QoslHxqODw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhrHkL0sE2ispmnVYHMMCrDlKjXD+HkJNWQs0Pt/snVueP1Lu
	631zX2+tBDITLuA1dG9RVX2WAFsserwBy4Vr/eVNvrqU7g2T/qLiSSE0r4OLewRswQw=
X-Gm-Gg: ASbGnctAPxmkf7F90Z35NUlDCiazJzEKdfaE9dAFsL4ii6ngaxkiJb3e22ZOzjq/Li3
	lhZTEOK07GOJsd2jZOl7g5WIG+owXhITJOu7e0G/7wb1yslPG/fwKErozL8/7nhXxVMTECY4ZrR
	xJ/uXzJWRODYZ1dttXq+RA2FAtiAUjh0eIAyYIAWNfbSWy4WxxGeVOz9mn11ksJYZ2CUjwFEl0W
	BpeCZvm7FqAoEMkHIGEN2+IQN2Uwep8c6dJWxs/Do9e5IVCQkdiOJNu20C1zpk2iAIud3JnR84w
	c4HEzE0UMz2csNTgf1tL5iE9mWgp52tf8IiCl6H8rsv6PnocYKZvubLKNgNkmmGPEZKu14dLM1F
	DhjATyB4raIbc2XyOZbAbZm9C5ro=
X-Google-Smtp-Source: AGHT+IH2T/8BuRm1IuYQ8ZzUxeJrK/gX8hiqAWQjPLCDcfQbPMq9lk1U66LzhxKbxgNFFI75QhHvNg==
X-Received: by 2002:a05:600c:4692:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-458b6b312d9mr64383135e9.17.1754288520939;
        Sun, 03 Aug 2025 23:22:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db3048bdsm21955145e9.29.2025.08.03.23.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:22:00 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:21:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 3/3] bpf: eliminate the allocation of an intermediate
 struct bpf_key
Message-ID: <df5a917b-fa24-42b7-8d71-b70e5156528e@suswa.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730172745.8480-4-James.Bottomley@HansenPartnership.com>

Hi James,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/bpf-make-bpf_key-an-opaque-type/20250731-013040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250730172745.8480-4-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v2 3/3] bpf: eliminate the allocation of an intermediate struct bpf_key
config: i386-randconfig-141-20250803 (https://download.01.org/0day-ci/archive/20250804/202508040803.nwExqJWe-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508040803.nwExqJWe-lkp@intel.com/

smatch warnings:
kernel/trace/bpf_trace.c:1364 bpf_verify_pkcs7_signature() warn: impossible condition '(key == BUILTIN_KEY) => (0-u32max == u64max)'

vim +1364 kernel/trace/bpf_trace.c

cce4c40b960673 Daniel Xu       2024-06-12  1353  __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
cce4c40b960673 Daniel Xu       2024-06-12  1354  			       struct bpf_dynptr *sig_p,
865b0566d8f1a0 Roberto Sassu   2022-09-20  1355  			       struct bpf_key *trusted_keyring)
865b0566d8f1a0 Roberto Sassu   2022-09-20  1356  {
cce4c40b960673 Daniel Xu       2024-06-12  1357  	struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
cce4c40b960673 Daniel Xu       2024-06-12  1358  	struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
9cc2aa8d6b5c93 James Bottomley 2025-07-30  1359  	struct key *key = (struct key *)trusted_keyring;
74523c06ae20b8 Song Liu        2023-11-06  1360  	const void *data, *sig;
74523c06ae20b8 Song Liu        2023-11-06  1361  	u32 data_len, sig_len;
865b0566d8f1a0 Roberto Sassu   2022-09-20  1362  	int ret;
865b0566d8f1a0 Roberto Sassu   2022-09-20  1363  
9cc2aa8d6b5c93 James Bottomley 2025-07-30 @1364  	if ((unsigned long)key == BUILTIN_KEY)

BUILTIN_KEY should be changed to -1L so that this works on 32bit
systems.

9cc2aa8d6b5c93 James Bottomley 2025-07-30  1365  		key = NULL;
9cc2aa8d6b5c93 James Bottomley 2025-07-30  1366  
9cc2aa8d6b5c93 James Bottomley 2025-07-30  1367  	if (system_keyring_id_check((unsigned long)key) < 0) {
865b0566d8f1a0 Roberto Sassu   2022-09-20  1368  		/*
865b0566d8f1a0 Roberto Sassu   2022-09-20  1369  		 * Do the permission check deferred in bpf_lookup_user_key().
865b0566d8f1a0 Roberto Sassu   2022-09-20  1370  		 * See bpf_lookup_user_key() for more details.
865b0566d8f1a0 Roberto Sassu   2022-09-20  1371  		 *
865b0566d8f1a0 Roberto Sassu   2022-09-20  1372  		 * A call to key_task_permission() here would be redundant, as
865b0566d8f1a0 Roberto Sassu   2022-09-20  1373  		 * it is already done by keyring_search() called by
865b0566d8f1a0 Roberto Sassu   2022-09-20  1374  		 * find_asymmetric_key().
865b0566d8f1a0 Roberto Sassu   2022-09-20  1375  		 */
9cc2aa8d6b5c93 James Bottomley 2025-07-30  1376  		ret = key_validate(key);
865b0566d8f1a0 Roberto Sassu   2022-09-20  1377  		if (ret < 0)
865b0566d8f1a0 Roberto Sassu   2022-09-20  1378  			return ret;
865b0566d8f1a0 Roberto Sassu   2022-09-20  1379  	}
865b0566d8f1a0 Roberto Sassu   2022-09-20  1380  
74523c06ae20b8 Song Liu        2023-11-06  1381  	data_len = __bpf_dynptr_size(data_ptr);
74523c06ae20b8 Song Liu        2023-11-06  1382  	data = __bpf_dynptr_data(data_ptr, data_len);
74523c06ae20b8 Song Liu        2023-11-06  1383  	sig_len = __bpf_dynptr_size(sig_ptr);
74523c06ae20b8 Song Liu        2023-11-06  1384  	sig = __bpf_dynptr_data(sig_ptr, sig_len);
74523c06ae20b8 Song Liu        2023-11-06  1385  
9cc2aa8d6b5c93 James Bottomley 2025-07-30  1386  	return verify_pkcs7_signature(data, data_len, sig, sig_len, key,
865b0566d8f1a0 Roberto Sassu   2022-09-20  1387  				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
865b0566d8f1a0 Roberto Sassu   2022-09-20  1388  				      NULL);
865b0566d8f1a0 Roberto Sassu   2022-09-20  1389  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


