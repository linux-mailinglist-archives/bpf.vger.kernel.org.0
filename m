Return-Path: <bpf+bounces-20231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98483AB44
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 14:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A11B28134
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197877F3E;
	Wed, 24 Jan 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iFmg4Gvo"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080177F23;
	Wed, 24 Jan 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104767; cv=none; b=EZwIADMRkuAvbLqnvzB0GJ9ZvKUVMUGdUkC1qgVgvTzAbM0ZaAj7U+cN9kWCQjvYdHwKaDPmJV5bbs75WKOp/iibp4TNwEe1qAGWiGyC1fGHO8WmF039faxIA9QercFHyl43gZNC3/Zg1+k3eAgbaDQzQBrdHozAx8FWzVHGV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104767; c=relaxed/simple;
	bh=lm+bpjhjzgGV4EEQAS5BmSl0AKSXB9fk3AvTzcJglNc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZwNX2vVAKQdM4fVZGmciZpuMT7xYEP+92Q71IqG3Buhubhsd55OJMgYS7guU3sFA1L921lp9j0/fDpeSys8kGSoxIjy62Tm3rc2a/WEvSFj/GAfzjJMBvAdcU3VhzaDPISl4V5V+XSdgkNjIwbMrfJOPuDGwsc/EEO536DVfTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=iFmg4Gvo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QXGCl43N49CuKQ6A58mDKLS/yEb8xd/5QbBmdesz/RA=; b=iFmg4Gvow9tqLr1hTDu76BSiqi
	X78bOAmPWlCLOJio0nyTk+ueqddjG6DhLwDpXwdNePa/gkSXirElbotQE4YUtfuuHCCFrw9wYN4ZE
	W2+ooXSrzFuj3ToxISsmNDOCFjZRLPL3GO264RQpV1x9ftg8K4TWvFGGeIVknRA9pTTanyyu5GY1p
	y63jy9tjPtqBMyKNx0xQFnReaDMY91CDMyg8S7H/YNvyQGp+D4oQP4Z7MjpO8yS7rhoSHCvFE48wM
	4Y0DBwgd3g6f5S8/06TUmGGmAaUg1PqYLpmJ/xl7kIjFTihQSHMn5hQU6n3uY9iYnFIIGt7HhuO7G
	SGF4beRg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSdme-000Oc0-7x; Wed, 24 Jan 2024 14:59:16 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSdmd-000WPI-2w; Wed, 24 Jan 2024 14:59:15 +0100
Subject: Re: [PATCH v10 net-next 15/15] p4tc: add P4 classifier
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us,
 xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, bpf@vger.kernel.org
References: <20240122194801.152658-1-jhs@mojatatu.com>
 <20240122194801.152658-16-jhs@mojatatu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net>
Date: Wed, 24 Jan 2024 14:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-16-jhs@mojatatu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

On 1/22/24 8:48 PM, Jamal Hadi Salim wrote:
> Introduce P4 tc classifier. The main task of this classifier is to manage
> the lifetime of pipeline instances across one or more netdev ports.
> Note a pipeline may be instantiated multiple times across one or more tc chains
> and different priorities.
> 
> Note that part or whole of the P4 pipeline could reside in tc, XDP or even
> hardware depending on how the P4 program was compiled.
> To use the P4 classifier you must specify a pipeline name that will be
> associated to the filter instance, a s/w parser (eBPF) and datapath P4
> control block program (eBPF) program. Although this patchset does not deal
> with offloads, it is also possible to load the h/w part using this filter.
> We will illustrate a few examples further below to clarify. Please treat
> the illustrated split as an example - there are probably more pragmatic
> approaches to splitting the pipeline; however, regardless of where the different
> pieces of the pipeline are placed (tc, XDP, HW) and what each layer will
> implement (what part of the pipeline) - these examples are merely showing
> what is possible.
> 
> The pipeline is assumed to have already been created via a template.
> 
> For example, if we were to add a filter to ingress of a group of netdevs
> (tc block 22) and associate it to P4 pipeline simple_l3 we could issue the
> following command:
> 
> tc filter add block 22 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>      action bpf obj $PARSER.o ... \
>      action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> The above uses the classical tc action mechanism in which the first action
> runs the P4 parser and if that goes well then the P4 control block is
> executed. Note, although not shown above, one could also append the command
> line with other traditional tc actions.
> 
> In these patches, we also support two types of loadings of the pipeline
> programs and differentiate between what gets loaded at say tc vs xdp by using
> syntax which specifies location as either "prog type tc obj" or
> "prog type xdp obj". There is an ongoing discussion in the P4TC community
> biweekly meetings which is likely going to have us add another location
> definition "prog type hw" which will specify the hardware object file name
> and other related attributes.
> 
> An example using tc:
> 
> tc filter add block 22 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>      prog type tc obj $PARSER.o ... \
>      action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> For XDP, to illustrate an example:
> 
> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
>      prog type xdp obj $PARSER.o section parser/xdp \
>      pinned_link /sys/fs/bpf/mylink \
>      action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> In this case, the parser will be executed in the XDP layer and the rest of
> P4 control block as a tc action.
> 
> For illustration sake, the hw one looks as follows (please note there's
> still a lot of discussions going on in the meetings - the example is here
> merely to illustrate the tc filter functionality):
> 
> tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3 \
>     prog type hw filename "mypnameprog.o" ... \
>     prog type xdp obj $PARSER.o section parser/xdp pinned_link /sys/fs/bpf/mylink \
>     action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> The theory of operations is as follows:
> 
> ================================1. PARSING================================
> 
> The packet first encounters the parser.
> The parser is implemented in ebpf residing either at the TC or XDP
> level. The parsed header values are stored in a shared eBPF map.
> When the parser runs at XDP level, we load it into XDP using tc filter
> command and pin it to a file.
> 
> =============================2. ACTIONS=============================
> 
> In the above example, the P4 program (minus the parser) is encoded in an
> action($PROGNAME.o). It should be noted that classical tc actions
> continue to work:
> IOW, someone could decide to add a mirred action to mirror all packets
> after or before the ebpf action.
> 
> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>      prog type tc obj $PARSER.o section parser/tc-ingress \
>      action bpf obj $PROGNAME.o section prog/tc-ingress \
>      action mirred egress mirror index 1 dev $P1 \
>      action bpf obj $ANOTHERPROG.o section mysect/section-1
> 
> It should also be noted that it is feasible to split some of the ingress
> datapath into XDP first and more into TC later (as was shown above for
> example where the parser runs at XDP level). YMMV.
> Regardless of choice of which scheme to use, none of these will affect
> UAPI. It will all depend on whether you generate code to load on XDP vs
> tc, etc.
> 
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

My objections from last iterations still stand, and I also added a nak,
so please do not just drop it with new revisions.. from the v10 as you
wrote you added further code but despite the various community feedback
the design still stands as before, therefore:

Nacked-by: Daniel Borkmann <daniel@iogearbox.net>

[...]
> +static int cls_p4_prog_from_efd(struct nlattr **tb,
> +				struct p4tc_bpf_prog *prog, u32 flags,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct bpf_prog *fp;
> +	u32 prog_type;
> +	char *name;
> +	u32 bpf_fd;
> +
> +	bpf_fd = nla_get_u32(tb[TCA_P4_PROG_FD]);
> +	prog_type = nla_get_u32(tb[TCA_P4_PROG_TYPE]);
> +
> +	if (prog_type != BPF_PROG_TYPE_XDP &&
> +	    prog_type != BPF_PROG_TYPE_SCHED_ACT) {

Also as mentioned earlier I don't think tc should hold references on
XDP programs in here. It doesn't make any sense aside from the fact
that the cls_p4 is also not doing anything with it. This is something
that a user space control plane should be doing i.e. managing a XDP
link on the target device.

> +		NL_SET_ERR_MSG(extack,
> +			       "BPF prog type must be BPF_PROG_TYPE_SCHED_ACT or BPF_PROG_TYPE_XDP");
> +		return -EINVAL;
> +	}
> +
> +	fp = bpf_prog_get_type_dev(bpf_fd, prog_type, false);
> +	if (IS_ERR(fp))
> +		return PTR_ERR(fp);
> +
> +	name = nla_memdup(tb[TCA_P4_PROG_NAME], GFP_KERNEL);
> +	if (!name) {
> +		bpf_prog_put(fp);
> +		return -ENOMEM;
> +	}
> +
> +	prog->p4_prog_name = name;
> +	prog->p4_prog = fp;
> +
> +	return 0;
> +}
> +

