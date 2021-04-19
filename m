Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DFD364CB2
	for <lists+bpf@lfdr.de>; Mon, 19 Apr 2021 23:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDSVBT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 17:01:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:44900 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhDSVBS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 17:01:18 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lYb0g-0008Tu-0B; Mon, 19 Apr 2021 23:00:46 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lYb0f-000NeK-MZ; Mon, 19 Apr 2021 23:00:45 +0200
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: add low level TC-BPF API
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20210419121811.117400-1-memxor@gmail.com>
 <20210419121811.117400-4-memxor@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6e8b744c-e012-c76b-b55f-7ddc8b7483db@iogearbox.net>
Date:   Mon, 19 Apr 2021 23:00:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210419121811.117400-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26145/Mon Apr 19 13:07:08 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/19/21 2:18 PM, Kumar Kartikeya Dwivedi wrote:
> This adds functions that wrap the netlink API used for adding,
> manipulating, and removing traffic control filters. These functions
> operate directly on the loaded prog's fd, and return a handle to the
> filter using an out parameter named id.
> 
> The basic featureset is covered to allow for attaching, manipulation of
> properties, and removal of filters. Some additional features like
> TCA_BPF_POLICE and TCA_RATE for tc_cls have been omitted. These can
> added on top later by extending the bpf_tc_cls_opts struct.
> 
> Support for binding actions directly to a classifier by passing them in
> during filter creation has also been omitted for now. These actions have
> an auto clean up property because their lifetime is bound to the filter
> they are attached to. This can be added later, but was omitted for now
> as direct action mode is a better alternative to it, which is enabled by
> default.
> 
> An API summary:
> 
> bpf_tc_act_{attach, change, replace} may be used to attach, change, and

typo on bpf_tc_act_{...} ?
                ^^^
> replace SCHED_CLS bpf classifier. The protocol field can be set as 0, in
> which case it is subsitituted as ETH_P_ALL by default.

Do you have an actual user that needs anything other than ETH_P_ALL? Why is it
even needed? Why not stick to just ETH_P_ALL?

> The behavior of the three functions is as follows:
> 
> attach = create filter if it does not exist, fail otherwise
> change = change properties of the classifier of existing filter
> replace = create filter, and replace any existing filter

This touches on tc oddities quite a bit. Why do we need to expose them? Can't we
simplify/abstract this e.g. i) create or update instance, ii) delete instance,
iii) get instance ? What concrete use case do you have that you need those three
above?

> bpf_tc_cls_detach may be used to detach existing SCHED_CLS
> filter. The bpf_tc_cls_attach_id object filled in during attach,
> change, or replace must be passed in to the detach functions for them to
> remove the filter and its attached classififer correctly.
> 
> bpf_tc_cls_get_info is a helper that can be used to obtain attributes
> for the filter and classififer. The opts structure may be used to
> choose the granularity of search, such that info for a specific filter
> corresponding to the same loaded bpf program can be obtained. By
> default, the first match is returned to the user.
> 
> Examples:
> 
> 	struct bpf_tc_cls_attach_id id = {};
> 	struct bpf_object *obj;
> 	struct bpf_program *p;
> 	int fd, r;
> 
> 	obj = bpf_object_open("foo.o");
> 	if (IS_ERR_OR_NULL(obj))
> 		return PTR_ERR(obj);
> 
> 	p = bpf_object__find_program_by_title(obj, "classifier");
> 	if (IS_ERR_OR_NULL(p))
> 		return PTR_ERR(p);
> 
> 	if (bpf_object__load(obj) < 0)
> 		return -1;
> 
> 	fd = bpf_program__fd(p);
> 
> 	r = bpf_tc_cls_attach(fd, if_nametoindex("lo"),
> 			      BPF_TC_CLSACT_INGRESS,
> 			      NULL, &id);
> 	if (r < 0)
> 		return r;
> 
> ... which is roughly equivalent to (after clsact qdisc setup):
>    # tc filter add dev lo ingress bpf obj foo.o sec classifier da
> 
> ... as direct action mode is always enabled.
> 
> If a user wishes to modify existing options on an attached classifier,
> bpf_tc_cls_change API may be used.
> 
> Only parameters class_id can be modified, the rest are filled in to
> identify the correct filter. protocol can be left out if it was not
> chosen explicitly (defaulting to ETH_P_ALL).
> 
> Example:
> 
> 	/* Optional parameters necessary to select the right filter */
> 	DECLARE_LIBBPF_OPTS(bpf_tc_cls_opts, opts,
> 			    .handle = id.handle,
> 			    .priority = id.priority,
> 			    .chain_index = id.chain_index)

Why do we need chain_index as part of the basic API?

> 	opts.class_id = TC_H_MAKE(1UL << 16, 12);
> 	r = bpf_tc_cls_change(fd, if_nametoindex("lo"),
> 			      BPF_TC_CLSACT_INGRESS,
> 			      &opts, &id);

Also, I'm not sure whether the prefix should even be named  bpf_tc_cls_*() tbh,
yes, despite being "low level" api. I think in the context of bpf we should stop
regarding this as 'classifier' and 'action' objects since it's really just a
single entity and not separate ones. It's weird enough to explain this concept
to new users and if a libbpf based api could cleanly abstract it, I would be all
for it. I don't think we need to map 1:1 the old tc legacy even in the low level
api, tbh, as it feels backwards. I think the 'handle' & 'priority' bits are okay,
but I would remove the others.

> 	if (r < 0)
> 		return r;
> 
> 	struct bpf_tc_cls_info info = {};
> 	r = bpf_tc_cls_get_info(fd, if_nametoindex("lo"),
> 			        BPF_TC_CLSACT_INGRESS,
> 				&opts, &info);
> 	if (r < 0)
> 		return r;
> 
> 	assert(info.class_id == TC_H_MAKE(1UL << 16, 12));
> 
> This would be roughly equivalent to doing:
>    # tc filter change dev lo egress prio <p> handle <h> bpf obj foo.o sec \
>      classifier classid 1:12

Why even bother to support !da mode, what are you trying to solve with it? I
don't think official libbpf api should support something that doesn't scale.

> ... except a new bpf program will be loaded and replace existing one.
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
