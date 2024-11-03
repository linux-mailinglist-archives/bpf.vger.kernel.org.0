Return-Path: <bpf+bounces-43827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7E9BA439
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 07:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACE51C20B5F
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67C13B791;
	Sun,  3 Nov 2024 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpWNZTRp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C823B0;
	Sun,  3 Nov 2024 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730613862; cv=none; b=bMYvgO8cnyCmW6FN/CJMJyPVFkF7MjQUPbU18qyyXB/x1/f2+WwYhCNTluvncs4SM4a44LSSlVqGdf1522g7hDxe/CBk87beDUdj/q8NnnxaThNMva4zra+eTMQHQWmsrxs7Z6bBrHvtnyB3h7jJ7HBhYFn3qzx67A2Loie3gMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730613862; c=relaxed/simple;
	bh=ZLqQV5TXw93Xk2EwAtGizLmBKf9dIqO/eDTYKRh5JfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sR5IJ/fxMJxDAh+t9CflSEn0OHOpzXcIeib921t7P0jXY++4kljI+GpD4a+aQsMjq4yGSEj5hkP7XV/on2ZRPUKU+AyFeBXQGeZvZyNa9R3v71s7XrMUBLaO/X12Q8a7IcTevUMBBWscQk0t4pbjKimXJr8y4cmwDKAvjTKLzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpWNZTRp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso2164146a12.3;
        Sat, 02 Nov 2024 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730613861; x=1731218661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu3Y4lvGLncvFqytUzaa9pzpUFFZ8eQkwS+oo1aB5E8=;
        b=CpWNZTRpBB7acH2akcjULEvqZc702m3T/MVoPHAyI/vWy7KVvkqo08efcnMhpaP1uN
         M8lCJG18dseWo0RAAS9nf5oWBYJ8lRwobPbhWMLyvairasFm45H5zEpZaPvOUJfiSIZO
         q15W/1XtepCAqELJK2w+F+7XsCQvGkN8h9QLpZMcfxf1rlTgTFp6lZmevNpQQW5W6ODi
         khenO8yFVLn1JN5vpbsT8yCwDSL60r9EOtA8T6kXGOt63qdNrRcJojx+rpizt8eydd/D
         1HBg021ypDO4TEgGurrI7QhhfqrirdR3l8cJpcqyeAq6ZJkpXRyc1vQXVdzjbyseE0a8
         mKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730613861; x=1731218661;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iu3Y4lvGLncvFqytUzaa9pzpUFFZ8eQkwS+oo1aB5E8=;
        b=YajTu2HRhovEVcHY4Gt3HzQMKbYW5qmeN/9sgRGv5PubKgiUNy2RzMF8i1dbAeuvZn
         tprLkQATp3TxYWKbtCVSzsc1e/feYbv7rFgQ2BYsQlOSdJBFad/k7BP4k3pxF3Z9sWoy
         g1ZAPAakUDVsUSiCd8obPuDn5RI7TEKQY3tIW5oySWNRwlM7v6g+O4og+j9eSLa2gJtY
         4XJWZ6qi0pRF7ivRfC99AxkUV6oAxXobxYm7CU3Qj9pDV9q9Zph+MKe/TMI2WGC6gwmm
         bQsXwnZ2KTYQ9QB1hzc2tIrEL3R/2P3B6MlxmrON/6rlqbZ6XPsZVpIcd8xGxLmvJQD9
         iSGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDvz+NWf6SsWGg58aaqEV7HZPrmqy50MoeN6lHo72dM7AHLROGNEVtucMUV71toUF956HzpYSRCuTWsobO@vger.kernel.org, AJvYcCWNHkbHYb0YXh2iA9kq+pX4naY+YGnq3p7Un2dWy9q18cAipwdRSf+5DRAOlFSAyGiClM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzh13s1JAHS3UFEPc+lQjQlLLgxbZst/Hol98TdRhY3e2WBxwZ
	UlWcv8qcU3ubBYmdC1rPySYOuQrKsLJvtvdX5/ataGbZStymA9ja
X-Google-Smtp-Source: AGHT+IFdDQlGrUGnyn1EBjTletOl9wXHMeq+pVWX4QtOtxFAoxkNTMC3eb5rHU8s8IxD28SmNxR3dA==
X-Received: by 2002:a17:903:24d:b0:20b:775f:506d with SMTP id d9443c01a7336-2111af8a7b8mr114374575ad.34.1730613860838;
        Sat, 02 Nov 2024 23:04:20 -0700 (PDT)
Received: from ub22 ([121.137.86.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a1fb1sm41795465ad.158.2024.11.02.23.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 23:04:20 -0700 (PDT)
Date: Sun, 3 Nov 2024 06:04:15 +0000
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Hou Tao <houtao1@huawei.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Add a copyright notice to
 lpm_trie_map_get_next_key
Message-ID: <ZycSXwjH4UTvx-Cn@ub22>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyb6cVpIqmMBld4U@ub22>

Hi,

The selftest "verifier_bits_iter/bad words" has been failed with
retval 115, while I did not touched anything but a comment.

Do you have any idea why it failed? I am not sure whether it indicates
any bugs in the kernel.

Best,
Byeonguk

On Sun, Nov 03, 2024 at 04:41:26AM +0000, bot+bpf-ci@kernel.org wrote:
> Dear patch submitter,
> 
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [bpf] selftests/bpf: Add a copyright notice to lpm_trie_map_get_next_key
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=905730&state=*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/11648453401
> 
> Failed jobs:
> test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/11648453401/job/32434970670
> 
> First test_progs failure (test_progs_no_alu32-s390x-gcc):
> #433 verifier_bits_iter
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> #433/13 verifier_bits_iter/bad words
> run_subtest:PASS:obj_open_mem 0 nsec
> run_subtest:PASS:unexpected_load_failure 0 nsec
> do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
> run_subtest:FAIL:1035 Unexpected retval: 115 != 0
> 
> 
> Please note: this email is coming from an unmonitored mailbox. If you have
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.


