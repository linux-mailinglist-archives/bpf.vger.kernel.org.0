Return-Path: <bpf+bounces-12239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D137C9A2E
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DF728180D
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3965CF508;
	Sun, 15 Oct 2023 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="hoSrR9M/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25BC2DB
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 17:10:46 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE34C1
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 10:10:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c0b8f42409so2614741a34.0
        for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697389844; x=1697994644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcEgPcBDvVyd0XBq0zLbTYcLGmRmfdNUafJKy3Ustms=;
        b=hoSrR9M/uOKskN330EFHAemCo+YkOwgPpnzDnKc2/TeHjigMqu6zVC8mPnE9CCfFRW
         eWmStjygsSlmlm1h+9suoQFkyKy6WyvgS9ahfaMJt/MkqWKHhOmW8xcD90zeIO7olAb3
         jiB9YAsNyYxKJOALQzUK8xZ+S3GV76bEdKjRypW4Zvk8PSHt9NublnbXvnAwFur94zeG
         IPLux44Aw7pMqlf3uD+Sa2CsNFquTQG7pAlM55yO+GCyap9Nn1N1aL7YktGJNjUIe1uL
         Tb2NsWc30yvMifagxmcR3fTYiOcnK8b6oHX5ekUzP5gRDbv7bSFAAqnMzQo+2P5Pn/P+
         KUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697389844; x=1697994644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcEgPcBDvVyd0XBq0zLbTYcLGmRmfdNUafJKy3Ustms=;
        b=OM5u+wNMtDNRwh57BiEhbkqBESqAlGtSk5f+qC57zrUrXF6INySa2yRz0+oNBizv+B
         kQWjvnr4hXe9e3yoGdXwayEhuiBoG5rHn/2QJ66TCXidcFJk5MZaBCw9mXx+afbYDWYJ
         yiPYyAnm8Iw8uECkVum8JlMw351f5qCN/nJdo+HdyWINKJpjqgu8ECD2b9vTPg1UH+mD
         iEPPcd+8iEAaZTcMSZ0wnioplvw6t17PKVAiU+XOM8u2quFYORDdat8uhEf+lt1nDXOJ
         ZJ1y869s43fdmyyZzFAdbt5nzLHr6IVj5vEVqfP9nXMgYV62M0M3d2XNB5UJL2GkU8NM
         acpA==
X-Gm-Message-State: AOJu0Yy2x/X++vNKP+OSZ+IUeHE82t6/PtRS9N8lu84qh3VdJst1zIq3
	a9E5pmd7R9HOyRs0iSwKFeGF0A==
X-Google-Smtp-Source: AGHT+IGcY0haZusyeSRqVSgWCHxm5dAXvs9j0Eq3YRg3ATZYQjdXEfYHDPtaM41tGtML69l3X3o1lw==
X-Received: by 2002:a05:6830:1b6e:b0:6b8:f730:7ab4 with SMTP id d14-20020a0568301b6e00b006b8f7307ab4mr35126540ote.0.1697389843886;
        Sun, 15 Oct 2023 10:10:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b006b3b342f37fsm4498221pfb.178.2023.10.15.10.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 10:10:43 -0700 (PDT)
Message-ID: <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
Date: Mon, 16 Oct 2023 02:10:35 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/16 1:07, Alexei Starovoitov wrote:
> On Sun, Oct 15, 2023 at 7:17 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 0448700890f7..298634556fab 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -988,6 +988,7 @@ enum bpf_prog_type {
>>          BPF_PROG_TYPE_SK_LOOKUP,
>>          BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
>>          BPF_PROG_TYPE_NETFILTER,
>> +       BPF_PROG_TYPE_VNET_HASH,
> 
> Sorry, we do not add new stable program types anymore.
> 
>> @@ -6111,6 +6112,10 @@ struct __sk_buff {
>>          __u8  tstamp_type;
>>          __u32 :24;              /* Padding, future use. */
>>          __u64 hwtstamp;
>> +
>> +       __u32 vnet_hash_value;
>> +       __u16 vnet_hash_report;
>> +       __u16 vnet_rss_queue;
>>   };
> 
> we also do not add anything to uapi __sk_buff.
> 
>> +const struct bpf_verifier_ops vnet_hash_verifier_ops = {
>> +       .get_func_proto         = sk_filter_func_proto,
>> +       .is_valid_access        = sk_filter_is_valid_access,
>> +       .convert_ctx_access     = bpf_convert_ctx_access,
>> +       .gen_ld_abs             = bpf_gen_ld_abs,
>> +};
> 
> and we don't do ctx rewrites like this either.
> 
> Please see how hid-bpf and cgroup rstat are hooking up bpf
> in _unstable_ way.

Can you describe what "stable" and "unstable" mean here? I'm new to BPF 
and I'm worried if it may mean the interface stability.

Let me describe the context. QEMU bundles an eBPF program that is used 
for the "eBPF steering program" feature of tun. Now I'm proposing to 
extend the feature to allow to return some values to the userspace and 
vhost_net. As such, the extension needs to be done in a way that ensures 
interface stability.

