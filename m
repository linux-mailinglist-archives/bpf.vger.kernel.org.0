Return-Path: <bpf+bounces-27069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE858A8CD6
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 22:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4153284762
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF25381BA;
	Wed, 17 Apr 2024 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOp/dYbR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFF171A1
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385202; cv=none; b=nFA2Wz1cIEtKxWfSexh/J1sum8KMPYo7qtkBbk0StVnP1/fZd7B+m9ABzkW+ro52Mkr9RJ8xg2pOU4vIEHTrwSj9/QUaNlKUrYUOHmlLfiYELllWdEqA3qbWSlTzea8y5p+IQQ1Ra2IN177j8WtWbxxu826RMwwlfUNmD60l+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385202; c=relaxed/simple;
	bh=1urfb//6cLmUAlycIejakHF/fE5u108SvEMgoakEaVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbL0JASbMGz3Ep5wwB5n9+G5aRilXBEvYXNIpppu6d/sS37fZvCe1wgdBS86F/3QNcBUEWBMxIxRL1Z8Q0fnJmqy2Bw3b8BhrtPqaYwqB5LKvQ8gezdvgQx0cwPi/4ZSdpblF93ADNYu4XxhAH7WaEkxQPfA4krfdR3HTWdh48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOp/dYbR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so110489a12.3
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713385199; x=1713989999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiUtg6sVp9ocxF36e0yybx1YkC8DwKWUzIoDykkOtD0=;
        b=OOp/dYbRpBZ9HW8IeYP0ryp/Dkx+i2hA4hrfwF+GCJkXOOKkLfYPUhw7AjVPqzKb+f
         Q2w4WLycf//+KBpbDN+DKLhbKTDnBnfjibBfLllJ+v0CbviCBGMSudTc5m0SMtJ7hgb7
         mdd2Ubzk4R+Sp4KaWwjJEyb1hb15UgGQaEv8ey4L2vY2Pn9slsdbOn2xDl315/IOtiBQ
         Rpw+hfjRhNzWXAV8EVGWofk4YxIljYPhF8dXefrlQ3ZVagTrIYwROctXSjIm7/6XwKbM
         0AoxNdwN4t3oetuk407HVj5bc67lqNwCPz4K8+vVUUmYt71WW99XyUztuvtmRJHXNTKc
         gQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713385199; x=1713989999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiUtg6sVp9ocxF36e0yybx1YkC8DwKWUzIoDykkOtD0=;
        b=aQEEbLvrQF9PTFmvYN8qfaJBcqMcOfBOJ1BCrxpm/BJRSbcVC4d+6ko7jA5lofRGjV
         w64zGmkeQ6/MxoWd+PkacczKBCJ1bL8X5HqJAD8YAsRPgrENL7Zw8lEcGwXJ9E4k21EZ
         5nv5hZaSFqFqDzJwI2r27P4HzvzGXw/UbuvOg5xH7QVyHHJNInwUMulWVp+0Wy7g63SE
         naKOWAumcOkeKWbBwimdKEQngWCLSX3IEycI4wVLxFmmNapzfZX59ybEDwK1l+As/ZHE
         IfL/0XFKOgT73xeaOu6BnUYjx62A7Q3ucGi222CQB5b31OFdlwAhIxqt6S0/pBz3uFM+
         O6RA==
X-Gm-Message-State: AOJu0YwSs2eBESnTxIL6b9nc/Men1P7G97a7M530bzGdu+nnZxNMcpUP
	E7c/kuvDLkNrkj05X3gC917Qkkl2STcwBXU62Ml1eBSo5j7KMMOrl7NIkhnJ7w==
X-Google-Smtp-Source: AGHT+IHvm3J4Mbfz1cDx2LuiIsXtBh5xzsuh4Mp0eX0TUfKulSOytGOfkpmsns8QDPjMmuKK17U6+w==
X-Received: by 2002:a17:906:1182:b0:a52:58a7:11d1 with SMTP id n2-20020a170906118200b00a5258a711d1mr324318eja.38.1713385198741;
        Wed, 17 Apr 2024 13:19:58 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090657c700b00a4e07760215sm7542ejr.69.2024.04.17.13.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:19:58 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:19:53 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, song@kernel.org, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, memxor@gmail.com,
	void@manifault.com, jolsa@kernel.org
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero
 fixed offset to selected KF_TRUSTED_ARGS BPF kfuncs
Message-ID: <ZiAu6YDi-F_pxLOV@google.com>
References: <ZhkbrM55MKQ0KeIV@google.com>
 <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>

On Mon, Apr 15, 2024 at 09:43:42AM -0700, Yonghong Song wrote:
> 
> On 4/12/24 4:31 AM, Matt Bobrowski wrote:
> > Hi,
> > 
> > Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, any
> > supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc must
> > have it's fixed offset set to zero, or else the BPF program being
> > loaded will be outright rejected by the BPF verifier.
> > 
> > This non-zero fixed offset restriction in most cases makes a lot of
> > sense, as it's considered to be a robust means of assuring that the
> > supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
> > upholds it's PTR_TRUSTED property. However, I believe that there are
> > also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed
> > offset can still be considered as something which posses the
> > PTR_TRUSTED property, and could be safely passed to a BPF kfunc that
> > is annotated w/ KF_TRUSTED_ARGS. I believe that this can particularly
> > hold true for selected embedded data structure members present within
> > given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
> > task_struct.thread_info, struct file.nf_path.
> > 
> > Take for example the struct thread_info which is embedded within
> > struct task_struct. In a BPF program, if we happened to acquire a
> > PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
> > bpf_get_current_task_btf(), and then constructed a pointer of type
> > struct thread_info which was assigned the address of the embedded
> > struct task_struct.thread_info member, we'd have ourselves a
> > PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
> > hypothetically also say that we had a BPF kfunc that took a struct
> > thread_info pointer as an argument and the BPF kfunc was also
> > annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the constructed
> > PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BPF
> > kfunc, the BPF program would be rejected by the BPF verifier. This is
> > irrespective of the fact that supplying pointers to such embedded data
> > structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considered
> > to be safe.
> > 
> > One of the ideas that I had in mind to workaround the non-zero fixed
> > offset restriction was to simply introduce a new BPF kfunc annotation
> > i.e. __offset_allowed that could be applied on selected BPF kfunc
> > arguments that are expected to be KF_TRUSTED_ARGS. Such an annotation
> > would effectively control whether we enforce the non-zero offset
> > restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
> > and __check_ptr_off_reg(). Although, now I'm second guessing myself
> > and I am wondering whether introducing something like the
> > __offset_allowed annotation for BPF kfunc arguments could lead to
> > compromising any of the safety guarantees that are provided by the BPF
> > verifier. Does anyone see an immediate problem with using such an
> > approach? I raise concerns, because it feels like we're effectively
> > punching a hole in the BPF verifier, but it may also be perfectly safe
> > to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
> > i.e. struct thread_info, struct file, and it's just my paranoia
> > getting the better of me. Or, maybe someone has another idea to
> > support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
> > little more generally without the need to actually make use of any
> > other BPF kfunc annotations?
> 
> In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
> a pointer of a particular struct is safe and trusted if the point
> of that struct is trusted, e.g.,
> 
> BTF_TYPE_SAFE_TRUSTED(struct file) {
>         struct inode *f_inode;
> };
> 
> We do the above since gcc does not support btf_tag yet.

Yes, I'm rather familiar with this construct.

> I guess you could do
> 
> BTF_TYPE_SAFE_TRUSTED(struct file) {
>         struct path f_path;
> };
> 
> and enhance verifier with the above information.
> 
> But the above 'struct path f_path' may unnecessary
> consume extra memory since we only care about field
> 'f_path'. Maybe create a new construct like
> 
> /* pointee is a field of the struct */
> BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
>         struct path *f_path;
> };

I don't fully understand how something like
BTF_TYPE_SAFE_FIELD_TRUSTED could work in practice. Do you mind
elaborating on that a little?

What I'm currently thinking is that with something like
BTF_TYPE_SAFE_FIELD_TRUSTED, if the BPF verifier sees a PTR_TO_BTF_ID
| PTR_TRUSTED w/ a fixed offset supplied to a BPF kfunc, then the BPF
verifier can also check that fixed offset for the supplied
PTR_TO_BTF_ID | PTR_TRUSTED actually accesses a member that has been
explicitly annotated as being trusted via
BTF_TYPE_SAFE_FIELD_TRUSTED. Maybe that would be better then making
use of an __offset_allowed annotation, which would solely rely on the
btf_struct_ids_match() check for its safety.

/M

