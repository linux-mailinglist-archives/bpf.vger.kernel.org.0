Return-Path: <bpf+bounces-41827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EAA99B984
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 15:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1971C20AF9
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF213B592;
	Sun, 13 Oct 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zarn0GNj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB559137776
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824901; cv=none; b=EFCxnIRP8HtEgqccTkMGLpGzq1Jh5ipDgeQv1Z/RNgj0EIQn+znk0eTQekKNjVvrj0JE1hVhCDdaUfAvtU87TvrKS2YDBP31bp8nDCUIsgLba2upMEU+jJ81kEHLGs2LnMw4PG+Ue2kNq9x8wYpdlY1pFx5/z0FCdKNfZnhXrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824901; c=relaxed/simple;
	bh=UzwP+v7wSYe0vRug8F7Q/yE+ZrNVEpXmHSGfLFKU8vM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ros5tJgqQoQ1x5zyICWNSEzx/Y3B39FDnvrOx9OLGA/WtkHFO2fRMjbMC3EtqIi3hQzKsp6r3vP+7JFRJ51GHLUukNMquWHT3uVFPTm7MzKVuttFolQO9FWYWIWN3mczETidg2xEAzvle5icVWr1WC+0mk4fQbN9HflE6WciQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zarn0GNj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a994cd82a3bso501946166b.2
        for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728824898; x=1729429698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgHxcpCnt1m28Spmy794S8e8vo0cvEqjskS68PjwE4k=;
        b=zarn0GNjITo4sd9RanLVpdpPzEiyXO/lxsBWr3l89g7zI8rUvN04snT8nQOj16lpTM
         teBlYsoa6gOI3TsA8ybVefPY2FylqeHSf1/SWc3pvKjymoqpTgxca+52L6pcKMwYkSV7
         rAjU9shyR8wvlMWl5qXPv9GmcFhnX+7k9dfQStO3QsJeZtKCtRetMX1W2wl8wMqA9yPS
         HaSTGuyoFbdaoCzk3BXpLg+O4xQuvF7vOev8B08oK0e7PvjeLVymuKKYpPkVnrVjSv4o
         o0dJ7hDCVRbHmwJcM/5wMxwogVKOz2+BRVhFYrkHQ/Ma7s3LW+jEB38Uwf5Z54tbgLdL
         j+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728824898; x=1729429698;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgHxcpCnt1m28Spmy794S8e8vo0cvEqjskS68PjwE4k=;
        b=ZiQnV0P60E9sgUqJ5LZL9KT4enXIpTdixPIxeAGOiaSpFNH6+36fBuhH0cbCbdFB44
         riEZmFLC8dav0p9sNOX32gfBqTcmNRUCBHzczUgVq02P+CkNF0XSk3dYU1a87kTk6JLb
         NfjRDbRG3tmvXAF1LGw35OwJKg7vZqj44ddQ3XN1Ms4Odurc8WXr1h44+/ICB/z6tOed
         pcUi2ZqdAyR1xhGYg6MsB0XL2CPSEw9Uho+3EFMomIZ8TsLUHnqI0akdgW/YmPxChMda
         zHya3ePQVtg25o6CAITyrGbj/S6dFohqJ1zz9c6eI+6IXFcJHoL8TLW9tdORJnF+JvR3
         59wA==
X-Forwarded-Encrypted: i=1; AJvYcCUxUt4MpnyLv8UH/BAGrSkXjzACh0zxFWrY4eyO2n1NbELLkJU/dnSZGwJW/sDZA1S1k5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjkumi+ipzdu7yoc27YZMHxmrUhBoXxQNMGNuK9b6erege0oom
	VCJV3m/Gl16EmoE2pAUI9clsv6K8XqYpDtInJQ3C6HaJljKUNjKorpw+7v5t6YU=
X-Google-Smtp-Source: AGHT+IGwEWE371TARzktggzetrHDP4kTrhJ9brqkPyC9v+9STeYVdsEo8EWbdpgQCfEd+yto1WG10A==
X-Received: by 2002:a17:907:9489:b0:a99:e98f:e73d with SMTP id a640c23a62f3a-a99e9900010mr296287666b.37.1728824898043;
        Sun, 13 Oct 2024 06:08:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937298cc5sm3745677a12.93.2024.10.13.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:08:17 -0700 (PDT)
Date: Sun, 13 Oct 2024 16:08:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Hou Tao <houtao@huaweicloud.com>,
	bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 08/16] bpf: Handle bpf_dynptr_user in bpf
 syscall when it is used as input
Message-ID: <47cda1ac-3d40-415a-a36c-833efbbfa19c@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008091501.8302-9-houtao@huaweicloud.com>

Hi Hou,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/bpf-Introduce-map-flag-BPF_F_DYNPTR_IN_KEY/20241008-171136
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241008091501.8302-9-houtao%40huaweicloud.com
patch subject: [PATCH bpf-next 08/16] bpf: Handle bpf_dynptr_user in bpf syscall when it is used as input
config: x86_64-randconfig-161-20241011 (https://download.01.org/0day-ci/archive/20241012/202410120530.zUoa1scp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410120530.zUoa1scp-lkp@intel.com/

smatch warnings:
kernel/bpf/syscall.c:1557 bpf_copy_from_dynptr_ukey() warn: 'key' is an error pointer or valid

vim +/key +1557 kernel/bpf/syscall.c

e1883aa78ac1fe9 Hou Tao            2024-10-08  1543  static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
e1883aa78ac1fe9 Hou Tao            2024-10-08  1544  {
e1883aa78ac1fe9 Hou Tao            2024-10-08  1545  	const struct btf_record *record;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1546  	const struct btf_field *field;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1547  	struct bpf_dynptr_user *uptr;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1548  	struct bpf_dynptr_kern *kptr;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1549  	void *key, *new_key, *kdata;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1550  	unsigned int key_size, size;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1551  	bpfptr_t udata;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1552  	unsigned int i;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1553  	int err;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1554  
e1883aa78ac1fe9 Hou Tao            2024-10-08  1555  	key_size = map->key_size;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1556  	key = kvmemdup_bpfptr(ukey, key_size);
e1883aa78ac1fe9 Hou Tao            2024-10-08 @1557  	if (!key)

This should be if (IS_ERR(key))

e1883aa78ac1fe9 Hou Tao            2024-10-08  1558  		return ERR_PTR(-ENOMEM);
e1883aa78ac1fe9 Hou Tao            2024-10-08  1559  
e1883aa78ac1fe9 Hou Tao            2024-10-08  1560  	size = key_size;
e1883aa78ac1fe9 Hou Tao            2024-10-08  1561  	record = map->key_record;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


