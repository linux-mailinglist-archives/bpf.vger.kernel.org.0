Return-Path: <bpf+bounces-15412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3197F1F5D
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05783B213B8
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116F38F95;
	Mon, 20 Nov 2023 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="r/4Eoehs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC89CA
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 13:41:40 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-679dd8d1281so6645946d6.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 13:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1700516499; x=1701121299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4q+hMR3Vn6buxrgiUhrEVNiuT6kNxsSE4tKqqNyrpy8=;
        b=r/4EoehsYkLv37vXNkIerfhzevfwqev5maymqIqe9xiJpUEuCp0bkj/NdBtuBGJEV6
         Hyeca3UPw68b1SoJHseeiNwkcSuURp+Ij+9DkVdDuAqwRxOiSPvCd87vk1gIs/l2nG+E
         J1JbFWfvmGr+sEkKjSPq1DDgHujEcANFfN/hCL+t2FlIFUsRoxmSvLTsBMCrC+QTNq41
         cnmkBsLHLMBobqjWmW24z7YAtAxyWv3s29PMOPVfJXIQM8pwInEVkslr4AtgDE8TPI9M
         YWgk+EqSy9c26pr9P2yx9652zPL9fJ6trYgF86Ee7/cUG3qQRCRImfCQi/nfxtT8qtGV
         ogUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516499; x=1701121299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q+hMR3Vn6buxrgiUhrEVNiuT6kNxsSE4tKqqNyrpy8=;
        b=GqVsWbWrcF69iwGW+X/4oMnwVfaTiQwkpTjnzhnYbMrhUsXSkzGfDkgFEl+cCiItoG
         Zndz/KjVKfLEleFOgZUWIF+2yCu1T7PCiV2rxE2JS+Zo53RM+/Ejftrza+qVTIf3fNqV
         AGRDvEG8xzN9IUbJSMxY6klXdDdMbC3kG4gS6XCTOwEhOdErnOa+Pz06gZ2CvmU1wWIl
         DDXjEKIi2FDROfUmPORG7cEzBDaHExYX8Ib2Llr2la/ylBSs+/haUOSaeF5tDU4faTFF
         ENm+fh6VqnDfpspo3rX6nkDImyORuJBZ3TcYqdTFF0E+bc1Fn0JtihmIhiqPiIY727VF
         AKmA==
X-Gm-Message-State: AOJu0YyuFEj4n6u+TyvOjubLmbrJ0nZ3zhMCKoieG80Lf4NsTa+v0ghS
	fyLxR3fLLHdDSi/m/CO8kF2lXKEBXhT1nw7QFAY=
X-Google-Smtp-Source: AGHT+IFPJIln1M+AXx2i/Q8nOQvdPOri0yPtVD6j6QI1cvRX8kMXHRgaJKRdeKwl0Wd6YKY1Fq+LDw==
X-Received: by 2002:a05:6214:529c:b0:66d:ab4a:dc4e with SMTP id kj28-20020a056214529c00b0066dab4adc4emr7525661qvb.1.1700516499517;
        Mon, 20 Nov 2023 13:41:39 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id m13-20020a0cbf0d000000b0066d04196c3dsm3244676qvi.49.2023.11.20.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:41:39 -0800 (PST)
Date: Mon, 20 Nov 2023 16:41:31 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Message-ID: <20231120214131.GA20984@cmpxchg.org>
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120175925.733167-2-davemarchevsky@fb.com>

On Mon, Nov 20, 2023 at 09:59:24AM -0800, Dave Marchevsky wrote:
> This patch modifies the generic bpf_local_storage infrastructure to
> support mmapable map values and adds mmap() handling to task_local
> storage leveraging this new functionality. A userspace task which
> mmap's a task_local storage map will receive a pointer to the map_value
> corresponding to that tasks' key - mmap'ing in other tasks' mapvals is
> not supported in this patch.
> 
> Currently, struct bpf_local_storage_elem contains both bookkeeping
> information as well as a struct bpf_local_storage_data with additional
> bookkeeping information and the actual mapval data. We can't simply map
> the page containing this struct into userspace. Instead, mmapable
> local_storage uses bpf_local_storage_data's data field to point to the
> actual mapval, which is allocated separately such that it can be
> mmapped. Only the mapval lives on the page(s) allocated for it.
> 
> The lifetime of the actual_data mmapable region is tied to the
> bpf_local_storage_elem which points to it. This doesn't necessarily mean
> that the pages go away when the bpf_local_storage_elem is free'd - if
> they're mapped into some userspace process they will remain until
> unmapped, but are no longer the task_local storage's mapval.

Those bits look good to me. vfree() uses __free_pages(), which
participates in refcounting. remap_vmalloc_range() acquires references
to the individual pages, which will be dropped once the page tables
disappear on munmap(). The vmalloc area doesn't need to stick around.

