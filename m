Return-Path: <bpf+bounces-46827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8769F07D5
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 10:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F86281DBF
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5A1B21A6;
	Fri, 13 Dec 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="PgKYW9tR"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD11B0F04;
	Fri, 13 Dec 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081950; cv=pass; b=Xw8FjeTXKkQxs4gT5X7I2tGBo/DIWpD+P7nCn5ej/T0u6WTS/4EG/2v991zfSAP31hjjABNWap44/SOiQCkr8NAJX19j7QbKOzToEUJbxpxx9FnjDBiMQbb4+As+5EcTNjH/8r9mD3K8jcxXLG0oAtohbdq5vizi1BNeF3VaVzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081950; c=relaxed/simple;
	bh=wpZWKto3YUjaWLEDbKUz1Yi+7s3Zag5arrGJ3uJk7Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFqoYJF0/DGJDxUU84IbexFTcUDLBD03oRaXm2CpeYHiHMeEHFjtQHZ0ly8/MbW5MjOrt7Gcou3pyUaPuEUImxBBiDMt8d6SCsRWedwuGUSSmsAxpKh4vph31ggVL1Ouy/sYAvFcC5JGGBHtjtkORs8tk1uB1kEEerMH6bjg+X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=PgKYW9tR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734081928; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HjqkwyGBy8oFpiH2OzBbdgLIjA6J/qJ+Z1tRCrZTgBlKf9fweZBx+lpCzz+ouQURY0eWWu3JaL90KEe68uYm8CwyzJyyYvgiRzMJSSiGzjrUeH9RuI9IACgRKCs1U0UmuBr+3sU0Jj8PTZGoVciWjUboCCD0noHSV8/XVzFpT/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734081928; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YnSfpiMRcV4J4vXvcSY+ixR1XW0AUmLlpepzk/A6xy0=; 
	b=SOrr3tKcIvCFh9e4zcoVhw49t0Y8eTXDC+HrYHiwjEH9Dik1C0BBD9zyXfn4vkXrjTskZEbTOW0AI5I/jUYqfLaencplbOlarQlRO+FnO10fBrMsRTbdljr7Il1bijhnf9dohQTWZZMuZYpdKdxpo0uHT8Wp/aj6U8o2FuDuMw0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734081928;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=YnSfpiMRcV4J4vXvcSY+ixR1XW0AUmLlpepzk/A6xy0=;
	b=PgKYW9tRgcP27jptrUtgW/N7L044UtUVDMmc9SmjC8RI7T+kb16sYU6NEcbRVAVM
	7+N1lrMDCFr213kX5FwRldujDhgDiMum4wERmccIHfx+o37ewO/JQm46bDnsM28/peK
	xV4jhmgljik4IjgBh3dLnmfxJ9scQuTlZDUfUEu8=
Received: by mx.zohomail.com with SMTPS id 1734081926159795.2400700570497;
	Fri, 13 Dec 2024 01:25:26 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: stephen.s.brennan@oracle.com
Cc: alan.maguire@oracle.com,
	bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	olsajiri@gmail.com,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on
Date: Fri, 13 Dec 2024 10:26:03 +0100
Message-Id: <20241213092603.13399-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87zfl0mv0g.fsf@oracle.com>
References: <87zfl0mv0g.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 12/12/24 22:49, Stephen Brennan wrote:
> Jiri Olsa <olsajiri@gmail.com> writes:
>> On Wed, Dec 11, 2024 at 10:10:24PM +0100, Jiri Olsa wrote:
>>> On Tue, Dec 10, 2024 at 02:55:01PM +0100, Laura Nao wrote:
>>>> Hi Jiri,
>>>>
>>>> Thanks for the feedback!
>>>>
>>>> On 12/6/24 13:35, Jiri Olsa wrote:
>>>>> On Fri, Nov 15, 2024 at 06:17:12PM +0100, Laura Nao wrote:
>>>>>> On 11/13/24 10:37, Laura Nao wrote:
>>>>>>>
>>>>>>> Currently, KernelCI only retains the bzImage, not the vmlinux
>>>>>>> binary. The
>>>>>>> bzImage can be downloaded from the same link mentioned above by
>>>>>>> selecting
>>>>>>> 'kernel' from the dropdown menu (modules can also be downloaded
>>>>>>> the
>>>>>>> same
>>>>>>> way). I’ll try to replicate the build on my end and share the
>>>>>>> vmlinux
>>>>>>> with DWARF data stripped for convenience.
>>>>>>>
>>>>>>
>>>>>> I managed to reproduce the issue locally and I've uploaded the
>>>>>> vmlinux[1]
>>>>>> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one
>>>>>> of
>>>>>> the
>>>>>> modules[3] and its btf data[4] extracted with:
>>>>>>
>>>>>> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko >
>>>>>> cros_kbd_led_backlight.ko.raw
>>>>>>
>>>>>> Looking again at the logs[5], I've noticed the following is
>>>>>> reported:
>>>>>>
>>>>>> [    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
>>>>>> [    0.416029] BPF:
>>>>>> [    0.416083] BPF: Invalid offset
>>>>>> [    0.416165] BPF:
>>>>>>
>>>>>> There are two different definitions of rcu_data in
>>>>>> '.data..percpu',
>>>>>> one
>>>>>> is a struct and the other is an integer:
>>>>>>
>>>>>> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
>>>>>> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
>>>>>>
>>>>>> [115801] VAR 'rcu_data' type_id=115572, linkage=static
>>>>>> [115803] VAR 'rcu_data' type_id=1, linkage=static
>>>>>>
>>>>>> [115572] STRUCT 'rcu_data' size=1152 vlen=69
>>>>>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
>>>>>> encoding=(none)
>>>>>>
>>>>>> I assume that's not expected, correct?
>>>>>
>>>>> yes, that seems wrong.. but I can't reproduce with your config
>>>>> together with pahole 1.24 .. could you try with latest one?
>>>>
>>>> I just tested next-20241210 with the latest pahole version (1.28
>>>> from
>>>> the master branch[1]), and the issue does not occur with this
>>>> version
>>>> (I can see only one instance of rcu_data in the BTF data, as
>>>> expected).
>>>>
>>>> I can confirm that the same kernel revision still exhibits the
>>>> issue
>>>> with pahole 1.24.
>>>>
>>>> If helpful, I can also test versions between 1.24 and 1.28 to
>>>> identify
>>>> which ones work.
>>>
>>> I managed to reproduce finally with gcc-12, but had to use pahole
>>> 1.25,
>>> 1.24 failed with unknown attribute
>>>
>>> 	[95096] VAR 'rcu_data' type_id=94868, linkage=static
>>> 	[95098] VAR 'rcu_data' type_id=4, linkage=static
>>> 	type_id=95096 offset=177088 size=1152 (VAR 'rcu_data')
>>> 	type_id=95098 offset=177088 size=1152 (VAR 'rcu_data')
>>
>> so for me the difference seems to be using gcc-12 and this commit in
>> linux tree:
>>    dabddd687c9e percpu: cast percpu pointer in PERCPU_PTR() via
>>    unsigned long
>>
>> which adds extra __pcpu_ptr variable into dwarf, and it has the same
>> address as the per cpu variable and that confuses pahole
>>
>> it ends up with adding per cpu variable twice.. one with real type
>> (type_id=94868) and the other with unsigned long type (type_id=4)
>>
>> however this got fixed in pahole 1.28 commit:
>>    47dcb534e253 btf_encoder: Stop indexing symbols for VARs
>>
>> which filters out __pcpu_ptr variable completely, adding Stephen to
>> the loop
> 
> Thanks for sharing this. Your analysis is spot-on, but I can fill in
> the
> details a bit. I just grabbed 6.13-rc2 and built it with gcc 11 and
> pahole 1.27, and observed the same issue:
> 
>    $ bpftool btf dump file vmlinux | grep "VAR 'rcu_data"
>    [4045] VAR 'rcu_data' type_id=3962, linkage=static
>    [4047] VAR 'rcu_data' type_id=1, linkage=static
>            type_id=4045 offset=196608 size=520 (VAR 'rcu_data')
>            type_id=4047 offset=196608 size=520 (VAR 'rcu_data')
> 
> In pahole 1.27, the (simplified) process for generating variables for
> BTF is:
> 
> 1. Look through the ELF symbol table, and find all symbols whose
> addresses are within the percpu section, and add them to a list.
> 
> 2. Look through the DWARF: for each tag of type DW_TAG_variable,
> determine if the variable is "global". If so, and if the address
> matches
> one of the symbols found in Step 1, continue.
> 
> 3. Except for one special case, pahole doesn't check whether the DWARF
> variable's name matches the symbol name. It simply emits a variable
> using the name of the symbol from Step 1, and the type information
> from
> Step 2.
> 
> The result of this process, in this case, is:
> 
> 1. kernel/rcu/tree.c contains a declaration of "rcu_data". This
> results
> in an ELF symbol in vmlinux of the same name. Great!
> 
>    $ eu-readelf -s vmlinux | grep '\brcu_data\b'
>    12319: 0000000000030000    520 OBJECT  LOCAL  DEFAULT       21
>    rcu_data
> 
> 
> 2. A DWARF entry is emitted for "rcu_data" which has a matching
> location
> (DW_AT_location has value DW_OP_addr 0x30000, matching the ELF
> symbol).
> So far so good - pahole emits a BTF variable with the expected type.
> 
>    $ llvm-dwarfdump --name=rcu_data
>    ...
>    0x01af03f1: DW_TAG_variable
>                  DW_AT_name        ("rcu_data")
>                  DW_AT_decl_file
>                  ("/home/stepbren/repos/linux-upstream/kernel/rcu/tree.c")
>                  DW_AT_decl_line   (80)
>                  DW_AT_decl_column (8)
>                  DW_AT_type        (0x01aefb38 "rcu_data")
>                  DW_AT_alignment   (0x40)
>                  DW_AT_location    (DW_OP_addr 0x30000)
> 
> 3. In kernel/rcu/tree.c, we also have the following declaration at
> line
> 5227 which uses per_cpu_ptr() on &rcu_data:
> 
> 5222 void rcutree_migrate_callbacks(int cpu)
> 5223 {
> 5224 	unsigned long flags;
> 5225 	struct rcu_data *my_rdp;
> 5226 	struct rcu_node *my_rnp;
> 5227 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>                                 ^^^^^^^^^^^
> 
> With the new changes in dabddd687c9e ("percpu: cast percpu pointer in
> PERCPU_PTR() via unsigned long"), this expands to a lexical block
> which
> contains a variable named "__pcpu_ptr", of type unsigned long. The
> compiler emits the following DW_TAG_variable in the DWARF:
> 
> 0x01b05d20:         DW_TAG_variable
>                        DW_AT_name        ("__pcpu_ptr")
>                        DW_AT_decl_file
>                        ("/home/stepbren/repos/linux-upstream/kernel/rcu/tree.c")
>                        DW_AT_decl_line   (5227)
>                        DW_AT_decl_column (25)
>                        DW_AT_type        (0x01adb52e "long unsigned
>                        int")
>                        DW_AT_location    (DW_OP_addr 0x30000,
>                        DW_OP_stack_value)
> 
> Since the DW_AT_location has a DW_OP_addr - pahole understands this to
> mean that the variable is located in global memory, and thus has
> VSCOPE_GLOBAL. But of course, the actual "scope" of this variable is
> not
> global, it is limited to the lexical block, which is completely hidden
> away by the macro. But pahole 1.27 does not consider this, and since
> the
> address matches the "rcu_data" symbol, it emits a variable of type
> "long
> unsigned int" under the name "rcu_data" -- despite the fact that the
> DWARF info has a name of "__pcpu_ptr".
> 
> The changes I made in 1.28 address this (unintentionally) by:
> 
> 1. Requiring global variables be both "in the global scope" (i.e. in
> the
> CU-level, rather than any function or other lexical block.
> 2. Requiring global variables have global memory (some of them could
> be
> register variables, despite having global scope -- e.g.
> current_stack_pointer).
> 3. No longer using the ELF symbol table, and instead using the DWARF
> names for variables.
> 
> With #1, we would filter this variable. And with #3, even if the
> variable were not filtered, we would output (a bunch of) variables
> with
> the correct __pcpu_ptr variable name, which is unhelpful but at least
> helps us understand where these things come from.
> 
> Rebuilding with GCC 14, we can see that the "__pcpu_ptr" variable no
> longer has a DW_AT_location:
> 
> 0x01afa82f:         DW_TAG_variable
>                        DW_AT_name        ("__pcpu_ptr")
>                        DW_AT_decl_file
>                        ("/home/stepbren/repos/linux-upstream/kernel/rcu/tree.c")
>                        DW_AT_decl_line   (5227)
>                        DW_AT_decl_column (25)
>                        DW_AT_type        (0x01ad0267 "long unsigned
>                        int")
> 
> This is the reason that pahole 1.27 now recognizes it as
> VSCOPE_OPTIMIZED. Without a memory location pahole can't do anything
> to
> match it against the "rcu_data" variable so nothing is emitted, and we
> don't get the issue.
> 
> I'm not sure if this adds at all to the discussion, since the overall
> answer is the same, an upgrade of pahole and/or gcc. (Pahole would be
> recommended; GCC just changed the generated DWARF and I could imagine
> other situations popping up elsewhere).
>

Thank you for the help with debugging and for the detailed explanation!  
                                                                         
We'll proceed with updating pahole to v1.28 in the KernelCI build        
environment.                                                             
                                                                         
Best,                                                                    
                                                                         
Laura                                                                    
                                                                         
#regzbot resolve: fixed by changes in pahole 1.28
 
> 
> Thanks,
> Stephen
> 
>> with gcc-14 the __pcpu_ptr variable has VSCOPE_OPTIMIZED scope, so it
>> won't
>> get into btf even without above pahole fix
>>
>> I suggest gcc/pahole upgrade ;-)
>>
>> thanks,
>> jirka


