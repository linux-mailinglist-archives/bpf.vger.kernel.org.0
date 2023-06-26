Return-Path: <bpf+bounces-3462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E973E329
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EACC280DA9
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE4BE64;
	Mon, 26 Jun 2023 15:23:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B86BA4A
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 15:23:30 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA311D;
	Mon, 26 Jun 2023 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iMBHjiX13Jx2K+DUN0zShMC0AlcRS4tKjEDHKV4mywk=; b=UAtm1cxFQMpuZX6cTGkMWX6y8b
	nV/4ausApWc8hcwfgl5hDowvfngHesjWHzni65gu4oQoe6ZZBhp+o9s4jHTrSTM/27UgDlS4dz5z7
	OMcB9DUHy2qCG+W01Pc3qT6K6HHbTbuz+m6v7D1Vfsr5cdHjRnGvN5E6EU6bcE3uDhqUb63jmmw8/
	toSNystTez3MUqRPMdzgzZfm+LzK7Vwxj6rKG8M0FETa/TuhRQKgZshREGFIKJBCsOJMrVBO2J8Xo
	q/7tE99Rc5eKUByu+xyHniPYJ/3Dag32HRoxfHMgSsUSd7SYb1+TDX/GIyvd0B/f/jp1n+FxgBgOl
	7y4hdKSQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qDo3i-0005Kz-0c; Mon, 26 Jun 2023 17:23:18 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qDo3h-000H7M-KP; Mon, 26 Jun 2023 17:23:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
 <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
 <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net>
 <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
 <8340aaf2-8b4c-4f7d-8eed-f72f615f6fd0@app.fastmail.com>
Message-ID: <77fc8c9b-220f-da93-c6b8-a8f36eb1086f@iogearbox.net>
Date: Mon, 26 Jun 2023 17:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8340aaf2-8b4c-4f7d-8eed-f72f615f6fd0@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26951/Mon Jun 26 09:29:31 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/24/23 5:28 PM, Andy Lutomirski wrote:
> On Sat, Jun 24, 2023, at 6:59 AM, Andy Lutomirski wrote:
>> On Fri, Jun 23, 2023, at 4:23 PM, Daniel Borkmann wrote:
>>
>> If this series was about passing a “may load kernel modules” token
>> around, I think it would get an extremely chilly reception, even though
>> we have module signatures.  I don’t see anything about BPF that makes
>> BPF tokens more reasonable unless a real security model is developed
>> first.
> 
> To be clear, I'm not saying that there should not be a mechanism to use BPF from a user namespace.  I'm saying the mechanism should have explicit access control.  It wouldn't need to solve all problems right away, but it should allow incrementally more features to be enabled as the access control solution gets more powerful over time.
> 
> BPF, unlike kernel modules, has a verifier.  While it would be a departure from current practice, permission to use BPF could come with an explicit list of allowed functions and allowed hooks.
> 
> (The hooks wouldn't just be a list, presumably -- premission to install an XDP program would be scoped to networks over which one has CAP_NET_ADMIN, presumably.  Other hooks would have their own scoping.  Attaching to a cgroup should (and maybe already does?) require some kind of permission on the cgroup.  Etc.)
> 
> If new, more restrictive functions are needed, they could be added.

Wasn't this the idea of the BPF tokens proposal, meaning you could create them with
restricted access as you mentioned - allowing an explicit subset of program types to
be loaded, subset of helpers/kfuncs, map types, etc.. Given you pass in this token
context upon program load-time (resp. map creation), the verifier is then extended
for restricted access. For example, see the bpf_token_allow_{cmd,map_type,prog_type}()
in this series. The user namespace relation was part of the use cases, but not strictly
part of the mechanism itself in this series.

With regards to the scoping, are you saying that the current design with the bitmasks
in the token create uapi is not flexible enough? If yes, what concrete alternative do
you propose?

> Alternatively, people could try a limited form of BPF proxying.  It wouldn't need to be a full proxy -- an outside daemon really could approve the attachment of a BPF program, and it could parse the program, examine the list of function it uses and what the proposed attachment is to, and make an educated decision.  This would need some API changes (maybe), but it seems eminently doable.

Thinking about this from an k8s environment angle, I think this wouldn't really be
practical for various reasons.. you now need to maintain two implementations for your
container images which ships BPF one which loads programs as today, and another one
which talks to this proxy if available, then you also need to standardize and support
the various loader libraries for this, you need to deal with yet one more component
in your cluster which could fail (compared to talking to kernel directly), and being
dependent on new proxy functionality becomes similar as with waiting for new kernels
to hit mainstream, it could potentially take a very long time until production upgrades.
What is being proposed here in this regard is less complex given no extra proxy is
involved. I would certainly prefer a kernel-based solution.

Thanks,
Daniel

