Return-Path: <bpf+bounces-27596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B38AFBA3
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD92A1F21558
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A4B14389D;
	Tue, 23 Apr 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SQb2oP+n"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C8143891
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910605; cv=none; b=fZdIwilMA/yZB59AL6LlUB6TQ6K3jO1sqMmN4eFGHuORwGdIeE/M4SXoKayyGZaGDXXqyWpDHHmmG4N8mftQ0a3wZ0H7aq9lXsZRkbD8ewVwilH1yND0nQQgRXM5wFttLASewIrU6t6sJnRpqvAA/YJS5LtS3KJCZzMaOjnivDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910605; c=relaxed/simple;
	bh=UZ5R2uiCPbQHwxUICT1pOR3M3oxOPun14oDrQqcDJoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOJ+uqeTuRb9eH+C1D35YSuPzYPuUWkC2z6OI5Ech4W4T6/AygigsVV97B9Btk+sFcXVdMFdLDy+Cf5kLRZYqZoQi8DEuh9xELQ9qV2kSIc0tT1Jdg9JGRnt7rvBXKJy65fwHUQMff6yZfu1AOv6eIKK5mtHyrpqZFBoqV9cutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SQb2oP+n; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <18bbc8d9-5a6b-4a7f-8805-d7565baf0d7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713910601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpuNK0o/O8VjIiCTXz9KUYY4NQrTfaQ4phkfY83pYb8=;
	b=SQb2oP+nVEUSrzTvev1Q8td6SI91iBFrAfWuJcHmUc0R/D0SO0KHrz4ympt4Xs6wqyqIxI
	yc9+QsQlqshakvsluYfUeRDPbOzrS2SMU8hQ6Tpy2yekKi3oIrwhqRkEfvZNblYNWvETV1
	ND2shfME1SCqRU8pWFA39iRQDpH/Vh0=
Date: Tue, 23 Apr 2024 15:16:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 David Vernet <void@manifault.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <ZhkbrM55MKQ0KeIV@google.com>
 <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com>
 <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
 <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/18/24 8:03 PM, Alexei Starovoitov wrote:
> On Wed, Apr 17, 2024 at 5:11 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 4/17/24 1:19 PM, Matt Bobrowski wrote:
>>> On Mon, Apr 15, 2024 at 09:43:42AM -0700, Yonghong Song wrote:
>>>> On 4/12/24 4:31 AM, Matt Bobrowski wrote:
>>>>> Hi,
>>>>>
>>>>> Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, any
>>>>> supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc must
>>>>> have it's fixed offset set to zero, or else the BPF program being
>>>>> loaded will be outright rejected by the BPF verifier.
>>>>>
>>>>> This non-zero fixed offset restriction in most cases makes a lot of
>>>>> sense, as it's considered to be a robust means of assuring that the
>>>>> supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
>>>>> upholds it's PTR_TRUSTED property. However, I believe that there are
>>>>> also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed
>>>>> offset can still be considered as something which posses the
>>>>> PTR_TRUSTED property, and could be safely passed to a BPF kfunc that
>>>>> is annotated w/ KF_TRUSTED_ARGS. I believe that this can particularly
>>>>> hold true for selected embedded data structure members present within
>>>>> given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
>>>>> task_struct.thread_info, struct file.nf_path.
>>>>>
>>>>> Take for example the struct thread_info which is embedded within
>>>>> struct task_struct. In a BPF program, if we happened to acquire a
>>>>> PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
>>>>> bpf_get_current_task_btf(), and then constructed a pointer of type
>>>>> struct thread_info which was assigned the address of the embedded
>>>>> struct task_struct.thread_info member, we'd have ourselves a
>>>>> PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
>>>>> hypothetically also say that we had a BPF kfunc that took a struct
>>>>> thread_info pointer as an argument and the BPF kfunc was also
>>>>> annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the constructed
>>>>> PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BPF
>>>>> kfunc, the BPF program would be rejected by the BPF verifier. This is
>>>>> irrespective of the fact that supplying pointers to such embedded data
>>>>> structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considered
>>>>> to be safe.
>>>>>
>>>>> One of the ideas that I had in mind to workaround the non-zero fixed
>>>>> offset restriction was to simply introduce a new BPF kfunc annotation
>>>>> i.e. __offset_allowed that could be applied on selected BPF kfunc
>>>>> arguments that are expected to be KF_TRUSTED_ARGS. Such an annotation
>>>>> would effectively control whether we enforce the non-zero offset
>>>>> restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
>>>>> and __check_ptr_off_reg(). Although, now I'm second guessing myself
>>>>> and I am wondering whether introducing something like the
>>>>> __offset_allowed annotation for BPF kfunc arguments could lead to
>>>>> compromising any of the safety guarantees that are provided by the BPF
>>>>> verifier. Does anyone see an immediate problem with using such an
>>>>> approach? I raise concerns, because it feels like we're effectively
>>>>> punching a hole in the BPF verifier, but it may also be perfectly safe
>>>>> to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
>>>>> i.e. struct thread_info, struct file, and it's just my paranoia
>>>>> getting the better of me. Or, maybe someone has another idea to
>>>>> support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
>>>>> little more generally without the need to actually make use of any
>>>>> other BPF kfunc annotations?
>>>> In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
>>>> a pointer of a particular struct is safe and trusted if the point
>>>> of that struct is trusted, e.g.,
>>>>
>>>> BTF_TYPE_SAFE_TRUSTED(struct file) {
>>>>           struct inode *f_inode;
>>>> };
>>>>
>>>> We do the above since gcc does not support btf_tag yet.
>>> Yes, I'm rather familiar with this construct.
>>>
>>>> I guess you could do
>>>>
>>>> BTF_TYPE_SAFE_TRUSTED(struct file) {
>>>>           struct path f_path;
>>>> };
>>>>
>>>> and enhance verifier with the above information.
>>>>
>>>> But the above 'struct path f_path' may unnecessary
>>>> consume extra memory since we only care about field
>>>> 'f_path'. Maybe create a new construct like
>>>>
>>>> /* pointee is a field of the struct */
>>>> BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
>>>>           struct path *f_path;
>>>> };
>>> I don't fully understand how something like
>>> BTF_TYPE_SAFE_FIELD_TRUSTED could work in practice. Do you mind
>>> elaborating on that a little?
>>>
>>> What I'm currently thinking is that with something like
>>> BTF_TYPE_SAFE_FIELD_TRUSTED, if the BPF verifier sees a PTR_TO_BTF_ID
>>> | PTR_TRUSTED w/ a fixed offset supplied to a BPF kfunc, then the BPF
>>> verifier can also check that fixed offset for the supplied
>>> PTR_TO_BTF_ID | PTR_TRUSTED actually accesses a member that has been
>>> explicitly annotated as being trusted via
>>> BTF_TYPE_SAFE_FIELD_TRUSTED. Maybe that would be better then making
>>> use of an __offset_allowed annotation, which would solely rely on the
>>> btf_struct_ids_match() check for its safety.
>> Right. What you described in the above is what I think as well.
> I believe BTF_TYPE_SAFE_* or __offset_allowed annotations
> are not necessary.
>
> In this case thread_info is the first field of struct task_struct
> and I suspect the verifier already allows:
>
> bpf_kfunc void do_stuff_with_thread(struct thread_info *ti) KF_TRUSTED_ARGS
> and use it as:
> task = bpf_get_current_task_btf();
> do_stuff_with_thread(&task->thread_info);
>
> We have similar setup with:
> struct bpf_cpumask {
>          cpumask_t cpumask;
> ...
> };
>
> and kfunc that accepts trusted cpumask_t * will accept
> trusted struct bpf_cpumask *.
> The other way around should be rejected, of course.
> Similar approach should work with file/path.
> The only difference is that the offset will be non-zero.
>
> process_kf_arg_ptr_to_btf_id() needs to get smarter.
>
> David Vernet added that check:
>
> WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
> as part of commit b613d335a743c.
>
> iirc the reg->off==0 check is there, as an extra caution.
>
> We can allow off!=0 and it won't confuse btf_type_ids_nocast_alias.
>
>      struct  nf_conn___init {
>              int another_field_at_off_zero;
>              struct nf_conn ct;
>      };
>
> will still trigger strict_type_match as expected.
>
> Maybe other places in the verifier need to get smarter too
> to allow non-zero offset into kf_trusted_args.

So IIUC, for a trusted pointer, any member or nested member
access (without pointer tracing) is trusted.
For example
    struct p2 {
       struct t1 *s1;
       struct t2 s2;
    };
    struct p {
       struct p1 f1;
       struct p2 f2;
       struct p3 f3;
    }
    struct p *trust_p;

So here &trust_p->f1, &trust_p->f2, &trust_p->f3, &trust_p->f2.s2
are all trusted, right?


