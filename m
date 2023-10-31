Return-Path: <bpf+bounces-13659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF97DC551
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B6C28156C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 04:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248D6AA1;
	Tue, 31 Oct 2023 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rcWlELTG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7C6AA7
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 04:22:13 +0000 (UTC)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFFEC9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 21:22:11 -0700 (PDT)
Message-ID: <c12dc46f-db04-4a7e-be87-1a4de4ffa669@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698726129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2j0WaIECOCx3ysweLloarEOoDOwe2IXjXCAwGdhdn4=;
	b=rcWlELTGuOZqavXYaXQZKlyNY7Tl5Q49aKhVuN5OTLW+v/dlRz1+X8dmAvKMaFWnXGcolh
	HDF0Tt2XDv6NOol6uOQ7rnvIcFtiPkyrGMDjd+r9c3ybM69WaCevf0yxO+FM6D7VOK4M/2
	6h5lF4lnaD6VT4DNAqXUiRAd+TPYkeA=
Date: Tue, 31 Oct 2023 00:22:04 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1
 hierarchy
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 David Vernet <void@manifault.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, kernel test robot
 <lkp@intel.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, tj@kernel.org, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
 sinquersw@gmail.com, longman@redhat.com, oe-kbuild-all@lists.linux.dev,
 cgroups@vger.kernel.org, bpf@vger.kernel.org, oliver.sang@intel.com
References: <20231029061438.4215-7-laoar.shao@gmail.com>
 <202310301605.CGFI0aSW-lkp@intel.com>
 <CALOAHbA51eCYFsfaUVBxRrfKt=z1=77bPO1CPKEyGeph5PztOQ@mail.gmail.com>
 <ZT+2qCc/aXep0/Lf@krava>
 <CALOAHbAFqH1xBVh55yq7Wj+RaSUKKxw9WWQa6FhO1FZw-S1RUQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <CALOAHbAFqH1xBVh55yq7Wj+RaSUKKxw9WWQa6FhO1FZw-S1RUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 10:40 PM, Yafang Shao wrote:
> On Mon, Oct 30, 2023 at 9:59 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Mon, Oct 30, 2023 at 07:35:25PM +0800, Yafang Shao wrote:
>>> On Mon, Oct 30, 2023 at 5:01 PM kernel test robot <lkp@intel.com> wrote:
>>>>
>>>> Hi Yafang,
>>>>
>>>> kernel test robot noticed the following build warnings:
>>>>
>>>> [auto build test WARNING on bpf-next/master]
>>>>
>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cgroup-Remove-unnecessary-list_empty/20231029-143457
>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
>>>> patch link:    https://lore.kernel.org/r/20231029061438.4215-7-laoar.shao%40gmail.com
>>>> patch subject: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1 hierarchy
>>>> config: i386-randconfig-013-20231030 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20231030/202310301605.CGFI0aSW-lkp@intel.com/config__;!!Bt8RZUm9aw!4feH_paRfc92c6DKnIgcbDciELDAOzSoIr66fN3591gkU9ddriq2cqyFm47OezGzvLvXd5Ep4R9ZYmtxrW9dqg$ )
>>>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>>>> reproduce (this is a W=1 build): (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20231030/202310301605.CGFI0aSW-lkp@intel.com/reproduce__;!!Bt8RZUm9aw!4feH_paRfc92c6DKnIgcbDciELDAOzSoIr66fN3591gkU9ddriq2cqyFm47OezGzvLvXd5Ep4R9ZYmsRR5GsUA$ )
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>> the same patch/commit), kindly add following tags
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310301605.CGFI0aSW-lkp@intel.com/
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>    kernel/bpf/helpers.c:1893:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
>>>
>>> -Wmissing-declarations is a known issue and somebody is working on it, right?
>>
>> there's this post [1] from Dave, but seems it never landed
>>
>> jirka
>>
>> [1] https://lore.kernel.org/bpf/20230816150634.1162838-1-void@manifault.com/
> 
> Thanks for your information.
> 
> David, I'd appreciate it if you could share an update on its current status
> 

Hi Yafang,

I had a similar patch in a recent series that I was asked to
split out and submit separately. Did so today after seeing this thread: https://lore.kernel.org/bpf/20231030210638.2415306-1-davemarchevsky@fb.com/
Sorry, should've CC'd you as well as Jiri on that patch.

