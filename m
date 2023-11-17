Return-Path: <bpf+bounces-15221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5E7EEC64
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 07:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC441C20AC4
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066FD52F;
	Fri, 17 Nov 2023 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz94nh4f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494EB7;
	Thu, 16 Nov 2023 22:51:48 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c4d06b6ddaso1529025b3a.3;
        Thu, 16 Nov 2023 22:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700203908; x=1700808708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhWs88U6MPRZe0S+hAPo0cZxqSNW0WDEnXMqzKp3mWQ=;
        b=Yz94nh4fgnGLp/LagyHfLlissEbtO190eMIO53Q7U4UbZrfa+6wKA0uw40iZNp6NdG
         EmGaFilYxxaxPWXFYfNA+zmU7Y+vzgcvRzLjIWCmSaJYAIyiEV9PJlABgctRsvsbue4U
         AILmx/Nnu2KfRrHLqI2zRRPx0pGDmg78GyCz5gr9JXtGjRAgvRlgst6Ayhuc3ht8ZVR3
         4NR79TXqV2acexx2udOK48m8Q38ttQ3cWToeVktlsFMjFKVvKx13LEFHZkLcnt4DCj7i
         lKaz5NitYDvhGEp92HNVk5dcZFfGR0n5LQlWnzShc5urq4z+HBbsYqedIYI29ANIyb4T
         MWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700203908; x=1700808708;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhWs88U6MPRZe0S+hAPo0cZxqSNW0WDEnXMqzKp3mWQ=;
        b=nWwvTdYf7HLw8schrp97DMGJx24g7og4C2vWYX4Qi3XLeFwWA6MLxah6TXUcHfkxbk
         JueQTpFie4cxscmxqsjnMEpIoE8kalQrHKGaTvyJJCjwXJMS0djGVzCSajHna1HanMEe
         9Buc8FQcKu8QqpweXvoewv6qBXoyPWESNyCelIyEnoZtfoLigBUHTMKkxV9J4Y41Dvfv
         OZZqHFGWPZaCPsS1+6IHPtzhJNb+ccKj+UttBv6W2sDZTEaVj7NLV1kWZibEeLLSBCVx
         OVigVgoFRjazciZIb0V6G72ow8b4f15fUjxtHklmuLuTEA+W95cpLRap3VjAjGUKrPud
         uslA==
X-Gm-Message-State: AOJu0YwNrIZ1FFeFmRjDfVgI1Nuhjbgy2tcCdiHS6fFIpgAoEzJc4lMz
	KDXq5eqU+VagGmgWpAn7ArE=
X-Google-Smtp-Source: AGHT+IHZ/ljki98Dp5EMoOIgFmx0y22inHV+Gz4sRXRxbMhuIMXbK4kDDBpkquAHF0umEFE2CQ2LAA==
X-Received: by 2002:a05:6a20:6a92:b0:187:ab4:19b9 with SMTP id bi18-20020a056a206a9200b001870ab419b9mr10692294pzb.35.1700203907835;
        Thu, 16 Nov 2023 22:51:47 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:377e:7905:3027:d8fd])
        by smtp.gmail.com with ESMTPSA id bj9-20020a170902850900b001b9e9edbf43sm696908plb.171.2023.11.16.22.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 22:51:46 -0800 (PST)
Date: Thu, 16 Nov 2023 22:51:45 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 daniel@iogearbox.net, 
 bpf@vger.kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 mattyk@nvidia.com
Message-ID: <65570d81e9db_55d732089f@john.notmuch>
In-Reply-To: <20231116145948.203001-11-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-11-jhs@mojatatu.com>
Subject: RE: [PATCH net-next v8 10/15] p4tc: add action template create,
 update, delete, get, flush and dump
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> This commit allows users to create, update, delete, get, flush and dump
> dynamic action kinds based on P4 action definition.
> 
> At the moment dynamic actions are tied to P4 programs only and cannot be
> used outside of a P4 program definition.
> 
> Visualize the following action in a P4 program:
> 
> action ipv4_forward(@tc_type("macaddr) bit<48> dstAddr, @tc_type("dev") bit<8> port)
> {
>      // Action code (generated by the compiler)

So this is BPF or what?

> }
> 
> The above is an action called ipv4_forward which receives as parameters
> a bit<48> dstAddr (a mac address) and a bit<8> port (something close to
> ifindex).
> 
> which is invoked on a P4 table match as such:
> 
> table mytable {
>         key = {
>             hdr.ipv4.dstAddr @tc_type("ipv4"): lpm;
>         }
> 
>         actions = {
>             ipv4_forward;
>             drop;
>             NoAction;
>         }
> 
>         size = 1024;
> }
> 
> We don't have an equivalent built in "ipv4_forward" action in TC. So we
> create this action dynamically.
> 
> The mechanics of dynamic actions follow the CRUD semantics.
> 
> ___DYNAMIC ACTION KIND CREATION___
> 
> In this stage we issue the creation command for the dynamic action which
> specifies the action name, its ID, parameters and the parameter types.
> So for the ipv4_forward action, the creation would look something like
> this:
> 
> tc p4template create action/aP4proggie/ipv4_forward \
>   param dstAddr type macaddr id 1 param port type dev id 2
> 
> Note1: Although the P4 program defined dstAddr as type bit48 we use our
> type called macaddr (likewise for port) - see commit on p4 types for
> details.
> 
> Note2: All the template commands (tc p4template) are generated by the
> p4c compiler.
> 
> Note that in the template creation op we usually just specify the action
> name, the parameters and their respective types. Also see that we specify
> a pipeline name during the template creation command. As an example, the
> above command creates an action template that is bounded to
> pipeline or program named aP4proggie.
> 
> Note, In P4, actions are assumed to pre-exist and have an upper bound
> number of instances. Typically if you have 1M table entries you want to allocate
> enough action instances to cover the 1M entries. However, this is a big waste
> waste of memory if the action instances are not in use. So for our case, we allow
> the user to specify a minimal amount of actions instances in the template and then
> if more dynamic action instances are needed then they will be added on
> demand as in the current approach with tc filter-action relationship.
> For example, if one were to create the action ipv4_forward preallocating
> 128 instances, one would issue the following command:
> 
> tc p4template create action/aP4proggie/ipv4_forward num_prealloc 128 \
>   param dstAddr type macaddr id 1 param port type dev id 2
> 
> By default, 16 action instances will be preallocated.
> If the user wishes to have more actions instances, they will have to be
> created individually by the control plane using the tc actions command.
> For example:
> 
> tc actions add action aP4proggie/ipv4_forward \
> param dstAddr AA:BB:CC:DD:EE:DD param port eth1
> 
> Only then they can issue a table entry creation command using this newly
> created action instance.
> 
> Note, this does not disqualify a user from binding to an existing action
> instances. For example:
> 
> tc p4ctrl create aP4proggie/table/mycontrol/mytable \
>    srcAddr 10.10.10.0/24 action ipv4_forward index 1
> 
> ___ACTION KIND ACTIVATION___
> 
> Once we provided all the necessary information for the new dynamic action,
> we can go to the final stage, which is action activation. In this stage,
> we activate the dynamic action and make it available for instantiation.
> To activate the action template, we issue the following command:
> 
> tc p4template update action aP4proggie/ipv4_forward state active
> 
> After the above the command, the action is ready to be instantiated.
> 
> ___RUNTIME___
> 
> This next section deals with the runtime part of action templates, which
> handle action template instantiation and binding.
> 
> To instantiate a new action that was created from a template, we use the
> following command:
> 
> tc actions add action aP4proggie/ipv4_forward \
> param dstAddr AA:BB:CC:DD:EE:FF param port eth0 index 1
> 
> Observe these are the same semantics as what tc today already provides
> with a caveat that we have a keyword "param" to precede the appropriate
> parameters - as such specifying the index is optional (kernel provides
> one when unspecified).
> 
> As previously stated, we refer to the action by it's "full name"
> (pipeline_name/action_name). Here we are creating an instance of the
> ipv4_forward action specifying as parameter values AA:BB:CC:DD:EE:FF for
> dstAddr and eth0 for port. We can create as many instances for action
> templates as we wish.
> 
> To bind the above instantiated action to a table entry, you can do use the
> same classical approach used to bind ordinary actions to filters, for
> example:
> 
> tc p4ctrl create aP4proggie/table/mycontrol/mytable \
>    srcAddr 10.10.10.0/24 action ipv4_forward index 1
> 
> The above command will bind our newly instantiated action to a table
> entry which is executed if there's a match.
> 
> Of course one could have created the table entry as:
> 
> tc p4ctrl create aP4proggie/table/mycontrol/mytable \
> srcAddr 10.10.10.0/24 \
> action ipv4_forward param dstAddr AA:BB:CC:DD:EE:FF param port eth0
> 
> Actions from other P4 control blocks (in the same pipeline) might be
> referenced as the action index is global within a pipeline.
> 

Where did what the action actually does get defined? It looks like
a label at this point, but without code?

