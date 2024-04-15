Return-Path: <bpf+bounces-26842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC068A580C
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD891C21CCA
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373C823CE;
	Mon, 15 Apr 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z60rwn3B"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F578C90
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199435; cv=none; b=FLsKMxUucKGCpY01n7leRZEb7b0bJ5E03XIXWtf4t/Br5RimtQ5rTkA6/1V9IQ6OhGn/RwK4Ubdj92c1mm5EF26eTVDGriU5qOM8M9gudHcJNVL9CneZ+rl2oZ1sNXDoV2Y3f6jVISG4Oql/cfM/t7htuS4Su2PtIk58fOVV9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199435; c=relaxed/simple;
	bh=bBp+uUmmVDhT832s3JQLyRxP7kGtMXcRWiR69xAgCbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7dRcbd7zG5lNfXfhOBQDozwmjL39RGV8GoKs4ZqkQYjTJ31Ey6JF95ws3YXuBCXHGnJ/nqxD5WfMni8Y8k9plot4LsJ2GfHEgFFIdgB/0qcRFN/DTZxTeorzsVqYG3h7O7T0mquYi8eitRHN+kZa3GKgDdBXkz1AbCEq6YL/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z60rwn3B; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713199430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PuhSZY3KXGUidE5TgEZnuy3C7ySf3U1hECsjHBEsEnY=;
	b=Z60rwn3BuNmHCProBYroqlh8ywXCa5qX50AnhC5xc+pBV+zi3QGGktkk0H+M45PvJTTI0m
	HGq5uKQLOUSB4anwU239nQFdo2fT2JU/NJoCOV3ppV1hXq+tILC9Ono7mxmS4xIrt79Zei
	fTqn6B1sxOoANUbFDU//rTmGnLQNw+A=
Date: Mon, 15 Apr 2024 09:43:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
Content-Language: en-GB
To: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, memxor@gmail.com,
 void@manifault.com, jolsa@kernel.org
References: <ZhkbrM55MKQ0KeIV@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZhkbrM55MKQ0KeIV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/12/24 4:31 AM, Matt Bobrowski wrote:
> Hi,
>
> Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, any
> supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc must
> have it's fixed offset set to zero, or else the BPF program being
> loaded will be outright rejected by the BPF verifier.
>
> This non-zero fixed offset restriction in most cases makes a lot of
> sense, as it's considered to be a robust means of assuring that the
> supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
> upholds it's PTR_TRUSTED property. However, I believe that there are
> also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed
> offset can still be considered as something which posses the
> PTR_TRUSTED property, and could be safely passed to a BPF kfunc that
> is annotated w/ KF_TRUSTED_ARGS. I believe that this can particularly
> hold true for selected embedded data structure members present within
> given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
> task_struct.thread_info, struct file.nf_path.
>
> Take for example the struct thread_info which is embedded within
> struct task_struct. In a BPF program, if we happened to acquire a
> PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
> bpf_get_current_task_btf(), and then constructed a pointer of type
> struct thread_info which was assigned the address of the embedded
> struct task_struct.thread_info member, we'd have ourselves a
> PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
> hypothetically also say that we had a BPF kfunc that took a struct
> thread_info pointer as an argument and the BPF kfunc was also
> annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the constructed
> PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BPF
> kfunc, the BPF program would be rejected by the BPF verifier. This is
> irrespective of the fact that supplying pointers to such embedded data
> structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considered
> to be safe.
>
> One of the ideas that I had in mind to workaround the non-zero fixed
> offset restriction was to simply introduce a new BPF kfunc annotation
> i.e. __offset_allowed that could be applied on selected BPF kfunc
> arguments that are expected to be KF_TRUSTED_ARGS. Such an annotation
> would effectively control whether we enforce the non-zero offset
> restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
> and __check_ptr_off_reg(). Although, now I'm second guessing myself
> and I am wondering whether introducing something like the
> __offset_allowed annotation for BPF kfunc arguments could lead to
> compromising any of the safety guarantees that are provided by the BPF
> verifier. Does anyone see an immediate problem with using such an
> approach? I raise concerns, because it feels like we're effectively
> punching a hole in the BPF verifier, but it may also be perfectly safe
> to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
> i.e. struct thread_info, struct file, and it's just my paranoia
> getting the better of me. Or, maybe someone has another idea to
> support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
> little more generally without the need to actually make use of any
> other BPF kfunc annotations?

In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
a pointer of a particular struct is safe and trusted if the point
of that struct is trusted, e.g.,

BTF_TYPE_SAFE_TRUSTED(struct file) {
         struct inode *f_inode;
};

We do the above since gcc does not support btf_tag yet.

I guess you could do

BTF_TYPE_SAFE_TRUSTED(struct file) {
         struct path f_path;
};

and enhance verifier with the above information.

But the above 'struct path f_path' may unnecessary
consume extra memory since we only care about field
'f_path'. Maybe create a new construct like

/* pointee is a field of the struct */
BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
         struct path *f_path;
};


>
> /M
>

