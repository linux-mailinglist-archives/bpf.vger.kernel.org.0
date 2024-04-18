Return-Path: <bpf+bounces-27085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C092C8A8FE4
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D621F221A7
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD9384;
	Thu, 18 Apr 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KTP1yUDo"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A2181
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399091; cv=none; b=kVOqSeNC36MOpOB+aXWS/zusUWOvsaJpofOUVrb7PRH4AamjXa3qp/+LPby/1ODQ95aoup/OfkjxYeKKgE47GkWw+bTLC/15w0kX00OLuwYqkNu7tQhjociWjwkX3A6Ey2nQmMAZ9TFcxWvkgh0QhsLoO3unjLb7VeH0NyGke74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399091; c=relaxed/simple;
	bh=LvnzemrN1h4DVJsCgnk8FHAN3zqmD4zd4N/7lSSpxZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ae9rwJ9bYwvauoswRI2FKA9S8vYve03kouGv67ETKIo8h3qGLTlcrLYYV5e0PJoOCgqj6LlYYin1NBf/WUeyQVwPIo3TSbLdQkNIkFEgQZNomw2/GWb2HrSygAn5KSDqHo4g1bn+YDr/aIdGm8xxMnW8cA2v+PVuoSwFRkcHyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KTP1yUDo; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713399087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMqBtc9FOHb9l5xEy1bAUb1ypvNz3uDiAsqNwUVTLcA=;
	b=KTP1yUDokO6Ss8xOaxQ3dU1RAe8Yd5SN/g1XG7atIyRIIuaqkLJhxKrahz046WFm8U7jms
	NSg92qCP++YC1XaeiQ2j5Q2KG4bVPcqITjUKdr9pr3IdkD8AYZKwYLCI24JILeKgqL1gM5
	KOhzIstAwsXw0UMSUkkiC94YcthslK0=
Date: Wed, 17 Apr 2024 17:11:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
Content-Language: en-GB
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, memxor@gmail.com, void@manifault.com, jolsa@kernel.org
References: <ZhkbrM55MKQ0KeIV@google.com>
 <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZiAu6YDi-F_pxLOV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/17/24 1:19 PM, Matt Bobrowski wrote:
> On Mon, Apr 15, 2024 at 09:43:42AM -0700, Yonghong Song wrote:
>> On 4/12/24 4:31 AM, Matt Bobrowski wrote:
>>> Hi,
>>>
>>> Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, any
>>> supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc must
>>> have it's fixed offset set to zero, or else the BPF program being
>>> loaded will be outright rejected by the BPF verifier.
>>>
>>> This non-zero fixed offset restriction in most cases makes a lot of
>>> sense, as it's considered to be a robust means of assuring that the
>>> supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
>>> upholds it's PTR_TRUSTED property. However, I believe that there are
>>> also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed
>>> offset can still be considered as something which posses the
>>> PTR_TRUSTED property, and could be safely passed to a BPF kfunc that
>>> is annotated w/ KF_TRUSTED_ARGS. I believe that this can particularly
>>> hold true for selected embedded data structure members present within
>>> given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
>>> task_struct.thread_info, struct file.nf_path.
>>>
>>> Take for example the struct thread_info which is embedded within
>>> struct task_struct. In a BPF program, if we happened to acquire a
>>> PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
>>> bpf_get_current_task_btf(), and then constructed a pointer of type
>>> struct thread_info which was assigned the address of the embedded
>>> struct task_struct.thread_info member, we'd have ourselves a
>>> PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
>>> hypothetically also say that we had a BPF kfunc that took a struct
>>> thread_info pointer as an argument and the BPF kfunc was also
>>> annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the constructed
>>> PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BPF
>>> kfunc, the BPF program would be rejected by the BPF verifier. This is
>>> irrespective of the fact that supplying pointers to such embedded data
>>> structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considered
>>> to be safe.
>>>
>>> One of the ideas that I had in mind to workaround the non-zero fixed
>>> offset restriction was to simply introduce a new BPF kfunc annotation
>>> i.e. __offset_allowed that could be applied on selected BPF kfunc
>>> arguments that are expected to be KF_TRUSTED_ARGS. Such an annotation
>>> would effectively control whether we enforce the non-zero offset
>>> restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
>>> and __check_ptr_off_reg(). Although, now I'm second guessing myself
>>> and I am wondering whether introducing something like the
>>> __offset_allowed annotation for BPF kfunc arguments could lead to
>>> compromising any of the safety guarantees that are provided by the BPF
>>> verifier. Does anyone see an immediate problem with using such an
>>> approach? I raise concerns, because it feels like we're effectively
>>> punching a hole in the BPF verifier, but it may also be perfectly safe
>>> to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
>>> i.e. struct thread_info, struct file, and it's just my paranoia
>>> getting the better of me. Or, maybe someone has another idea to
>>> support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
>>> little more generally without the need to actually make use of any
>>> other BPF kfunc annotations?
>> In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
>> a pointer of a particular struct is safe and trusted if the point
>> of that struct is trusted, e.g.,
>>
>> BTF_TYPE_SAFE_TRUSTED(struct file) {
>>          struct inode *f_inode;
>> };
>>
>> We do the above since gcc does not support btf_tag yet.
> Yes, I'm rather familiar with this construct.
>
>> I guess you could do
>>
>> BTF_TYPE_SAFE_TRUSTED(struct file) {
>>          struct path f_path;
>> };
>>
>> and enhance verifier with the above information.
>>
>> But the above 'struct path f_path' may unnecessary
>> consume extra memory since we only care about field
>> 'f_path'. Maybe create a new construct like
>>
>> /* pointee is a field of the struct */
>> BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
>>          struct path *f_path;
>> };
> I don't fully understand how something like
> BTF_TYPE_SAFE_FIELD_TRUSTED could work in practice. Do you mind
> elaborating on that a little?
>
> What I'm currently thinking is that with something like
> BTF_TYPE_SAFE_FIELD_TRUSTED, if the BPF verifier sees a PTR_TO_BTF_ID
> | PTR_TRUSTED w/ a fixed offset supplied to a BPF kfunc, then the BPF
> verifier can also check that fixed offset for the supplied
> PTR_TO_BTF_ID | PTR_TRUSTED actually accesses a member that has been
> explicitly annotated as being trusted via
> BTF_TYPE_SAFE_FIELD_TRUSTED. Maybe that would be better then making
> use of an __offset_allowed annotation, which would solely rely on the
> btf_struct_ids_match() check for its safety.
Right. What you described in the above is what I think as well.
>
> /M

