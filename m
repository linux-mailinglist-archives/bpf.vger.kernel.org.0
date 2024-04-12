Return-Path: <bpf+bounces-26617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FC8A2D7E
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDCC281FDE
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CDA54F86;
	Fri, 12 Apr 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gvBr1wA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01755E43
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921529; cv=none; b=fjIT9+TAb42PYNajkw1KmBl0tpieAVIxWP/nafDOcRQu0Q4OzhuP+scSSlBX9W8PIftZyg4wdtbUKSlpppLsPDldKfnZlnYavADt9iFN22KFr3yfcAvj4Ne6KGg7IRMlLBqLKyYR8uhhEpQRnC3WAX4QNsU16bMHlQmM3iJ/yJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921529; c=relaxed/simple;
	bh=HLwmsZsidfNrOf2BDVcQSQS/oZDi+jBWfOJw/1MPcuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H/xKQWj6wEgm2xr7NqcP8PxaLFhx6ZDPpP7fORMDaM6OA+RlwZI34+lsKjAIA+zbaSUZeNSvGdpKcJ5G4m3/UzrbE1db9TY/lhCD7kf4xAabJ8xQlTrwSHkNkluoRUURVa1f5O95iKn+Y68FKDDv2b4cxErx0kTXp99Y1xKJkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0gvBr1wA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a523e1372b2so29062266b.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 04:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712921525; x=1713526325; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLwmsZsidfNrOf2BDVcQSQS/oZDi+jBWfOJw/1MPcuI=;
        b=0gvBr1wAfRXr4pt/CyEb0cEf3rhr6o0HVhP1MVeakNemDdhqkUpOTubqAfkMTxr9MK
         Vbn8dGfLKMnylY/7+ZlaprLj5AyUK4Vimy3nZ1Kewdap7+9ueHbshhkCIzFpL3+xHijP
         bLbRGzjqN41LsVkmzD7gbbr0fqC6f2oDjeADCjrUjc7ixSHqw8JFhCdKw5YYGw8Tix2o
         oRgXRJu3jleeNu9z16IoKdxLlCw/knKTnYZh/DNulwyLA/rLqOMbzkOkeQxiJkFHUAm8
         SSbozapcrWcqbmzl8qp+VfbuZ7kMU41ZoSjMEFm2KpcUpDktC6PUlA2flLTXrYh4Cq/l
         ZFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712921525; x=1713526325;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLwmsZsidfNrOf2BDVcQSQS/oZDi+jBWfOJw/1MPcuI=;
        b=QJCTRoPRZHhTTpWwSedX/TY3unfU3Vd//lMixOiTmoigNGvG47juVa+aBfJysXMNge
         FHgeoeJEu6EPzHY6URy04Izxp3kfJfVe+/Nfh91wjdQXnsDOKHHWQ2LqFnjR0OBco5R4
         dFe0bGjNqpVzOGjkM7uai6090d3u72GCCit0js1hutef3M6qp6RHB+EL6JAzU2PCZpxY
         /pced3W55WuillN0ltlQmMYxAmFy9fcAorfSXlLZgWhvwOh5L5zfE9TH1SooFV1yVl9m
         lcbht8+kgNsbr+vEW4/m0cC+ABaOzly40ZOtHvuGG9FQrQyg/01qPdREtqmS6LskPDLw
         Mkxw==
X-Gm-Message-State: AOJu0YzFI3H9tPfxXBMdF01jfAyfJggPvfcs72YENhCuwN8LU6rZ+jnN
	8rSI/LnmyCUttfIaNRCGKeJbQ6x0KfP+549TmblQISPUd2WvTaZ+y59UZKhLoZhYMZdU7cDody6
	btA==
X-Google-Smtp-Source: AGHT+IGEuGEIJtliT2Gj9l9uHnJKDsqQdg0+mXHyCbUiuVeedDC25thLgiUtbKPsBcYTOM1y1pUe/A==
X-Received: by 2002:a17:907:3609:b0:a52:367b:e4ff with SMTP id bk9-20020a170907360900b00a52367be4ffmr1208301ejc.42.1712921525344;
        Fri, 12 Apr 2024 04:32:05 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709070b0e00b00a518c69c4e3sm1713234ejl.23.2024.04.12.04.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:32:04 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:31:56 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	song@kernel.org, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, memxor@gmail.com, void@manifault.com,
	jolsa@kernel.org
Subject: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
Message-ID: <ZhkbrM55MKQ0KeIV@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, any
supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc must
have it's fixed offset set to zero, or else the BPF program being
loaded will be outright rejected by the BPF verifier.

This non-zero fixed offset restriction in most cases makes a lot of
sense, as it's considered to be a robust means of assuring that the
supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
upholds it's PTR_TRUSTED property. However, I believe that there are
also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed
offset can still be considered as something which posses the
PTR_TRUSTED property, and could be safely passed to a BPF kfunc that
is annotated w/ KF_TRUSTED_ARGS. I believe that this can particularly
hold true for selected embedded data structure members present within
given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
task_struct.thread_info, struct file.f_path.

Take for example the struct thread_info which is embedded within
struct task_struct. In a BPF program, if we happened to acquire a
PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
bpf_get_current_task_btf(), and then constructed a pointer of type
struct thread_info which was assigned the address of the embedded
struct task_struct.thread_info member, we'd have ourselves a
PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
hypothetically also say that we had a BPF kfunc that took a struct
thread_info pointer as an argument and the BPF kfunc was also
annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the constructed
PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BPF
kfunc, the BPF program would be rejected by the BPF verifier. This is
irrespective of the fact that supplying pointers to such embedded data
structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considered
to be safe.

One of the ideas that I had in mind to workaround the non-zero fixed
offset restriction was to simply introduce a new BPF kfunc annotation
i.e. __offset_allowed that could be applied on selected BPF kfunc
arguments that are expected to be KF_TRUSTED_ARGS. Such an annotation
would effectively control whether we enforce the non-zero offset
restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
and __check_ptr_off_reg(). Although, now I'm second guessing myself
and I am wondering whether introducing something like the
__offset_allowed annotation for BPF kfunc arguments could lead to
compromising any of the safety guarantees that are provided by the BPF
verifier. Does anyone see an immediate problem with using such an
approach? I raise concerns, because it feels like we're effectively
punching a hole in the BPF verifier, but it may also be perfectly safe
to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
i.e. struct thread_info, struct file, and it's just my paranoia
getting the better of me. Or, maybe someone has another idea to
support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
little more generally without the need to actually make use of any
other BPF kfunc annotations?

/M

