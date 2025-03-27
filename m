Return-Path: <bpf+bounces-54828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6DA7364A
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 17:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09A91885CC1
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526C1922D3;
	Thu, 27 Mar 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="itNB9dkP"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037D18FC67
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091419; cv=none; b=sXKzZ4+Mk3mWsVLuTrd9aSy+/shQQ4EBsudhivDBYbUnGkf//amrWvsulaOyKMlxKUrDivrYUCmFgnsRw9gk4AZb4XelYaJOZJADVkCS8cSF5eEa0VZ3HxSND5Iq58q3KfGGnYLze0SeLDIazt8U3+GDIKonZ/hTooYC3DKMZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091419; c=relaxed/simple;
	bh=VjtVu8tJv6QYdZHrXclsVF/l7buSwFAdRcwlXDvkwCk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=R1eXjYeWVLSQ0nOsgSM4M7xgQA8WZW37fvMLpxgC9Mj8S2LSV+fnTPG1RT0kiz2whz10Di45FIlah0yRkMuS7qZJrBBX2f9Uwkyu9MPv2Qn98hLD1nu8Uhvzg6YyzY97/vj5OM84k67JvViTGJMEk4w17jAp/bT3UYMXBmDrcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=itNB9dkP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743091414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OVU+gTaXqFnVpTJimH0L3M1t8uD7RKuOo90/XwTIbzo=;
	b=itNB9dkPo3mMGc/sxwamxky6rut2Jm3IK9X9QSTay/AeLWbqSvRkHR5R0pxlpYFQoDKfp2
	wbp9jtx29SMD6RrHJU5siXgOCzzLX5pRfSReuUoPoGy6J5lWBHlAfsNsgQwzR6t8ehKicH
	J0osL/d/Kuqe5LUr/yjqtmDFDIqzBkU=
Date: Fri, 28 Mar 2025 00:03:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
Subject: Question: fentry on kernel func optimized by compiler
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

I recently encountered a problem when using fentry to trace kernel 
functions optimized by compiler, the specific situation is as follows:
https://github.com/bpftrace/bpftrace/issues/3940

Simply put, some functions have been optimized by the compiler. The 
original function names are found through BTF, but the optimized 
functions are the ones that exist in kallsyms_lookup_name. Therefore, 
the two do not match.

         func_proto = btf_type_by_id(desc_btf, func->type);
         if (!func_proto || !btf_type_is_func_proto(func_proto)) {
                 verbose(env, "kernel function btf_id %u does not have a 
valid func_proto\n",
                         func_id);
                 return -EINVAL;
         }

         func_name = btf_name_by_offset(desc_btf, func->name_off);
         addr = kallsyms_lookup_name(func_name);
         if (!addr) {
                 verbose(env, "cannot find address for kernel function 
%s\n",
                         func_name);
                 return -EINVAL;
         }

I have made a simple statistics and there are approximately more than 
2,000 functions in Ubuntu 24.04.

dylane@2404:~$ cat /proc/kallsyms | grep isra | wc -l
2324

So can we add a judgment from libbpf. If it is an optimized function, 
pass the suffix of the optimized function from the user space to the 
kernel, and then perform a function name concatenation, like:

         func_name = btf_name_by_offset(desc_btf, func->name_off);
	if (optimize) {
		func_name = func_name + ".isra.0"
	}
         addr = kallsyms_lookup_name(func_name);

-- 
Best Regards
Tao Chen


