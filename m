Return-Path: <bpf+bounces-4773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72174F467
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E92281813
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075319BD4;
	Tue, 11 Jul 2023 16:06:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6519BBA
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:06:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB411D
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689091598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHgmi2wwFrPjMP5Rxs8KSVDqK1J+qf75UCdExpa0HJo=;
	b=ENDaHJ/Vv8mI7uMgKK3FkLa7QEI3A5wQWLon3XqttdV42wVrb9YeO4sR8fMctVSW7c0a+o
	EqnawonnmLC4jJMKMohvtw9kw8v9BBCivORrOJlQ1nuVPNQ48PByZwdKG6k7CPxKAu99GK
	GBgTgMokpS/khyRLq6nF70NNf/YffWs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-qeawWiX3Pkekwt3G_-MsmQ-1; Tue, 11 Jul 2023 12:06:37 -0400
X-MC-Unique: qeawWiX3Pkekwt3G_-MsmQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993d5006993so292041266b.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091596; x=1691683596;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHgmi2wwFrPjMP5Rxs8KSVDqK1J+qf75UCdExpa0HJo=;
        b=SmHhnBV7IFfWFXC4FaJeC/CH8Ecp3f2VK7ODnrtUg5VvOajlg/37v7IsOn1kMdORQG
         hbpzKgsdY10ga/UHP3f1j3zczsm0ZnFnFZoLAmcvauadMiHHQT6xieh6b1l149arEp3O
         ucjQ7jyu+IKpYSvvwiFto4+dgg4eekIivCxDwXQAFSTdIkyMBUP03yiRXqdwXM0UD9/0
         aCsxZaIWSke9xOJXoq2sYSuRIaIaHd/eTMFotsXJNTeyQtpVenNv4PBF+YlY97aaDw2a
         O2TXdUetYwurmZwL2pql6BD1HcrOMugh5kqWItrnFDNufwOKKMfUwHLR0N5fOJJfzF/F
         P2oA==
X-Gm-Message-State: ABy/qLZqJKvOfxiZVL0Deo/0rBEW7PLaMnGS5JEtwg6yXUWMTZCgUGbJ
	MJ82Qy2tMLt1h3pvdtSpkN/GfFb4uOrVuwXmCnBoEyWgYZu4vY5rMzQ6jukkx/IlwjmSm8zxkCO
	qVxSrTMqGhul3
X-Received: by 2002:a17:906:73d5:b0:994:577:f9df with SMTP id n21-20020a17090673d500b009940577f9dfmr7195367ejl.4.1689091596089;
        Tue, 11 Jul 2023 09:06:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVb+VnLW+A+oRRKhUDHDJ2ge75t79bT8wF0gNCeIcmMzqWP9QSikucwVt4UtqYjBbKUKQ5GA==
X-Received: by 2002:a17:906:73d5:b0:994:577:f9df with SMTP id n21-20020a17090673d500b009940577f9dfmr7195342ejl.4.1689091595649;
        Tue, 11 Jul 2023 09:06:35 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709060ad300b009934b1eb577sm1340404ejf.77.2023.07.11.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 09:06:35 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <da7ac0a1-5f62-bc0e-8954-d3d1e846fb52@redhat.com>
Date: Tue, 11 Jul 2023 18:06:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huawei.com>,
 Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf] bpf: cpumap: Fix memory leak in cpu_map_update_elem
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711115848.2701559-1-pulehui@huaweicloud.com>
In-Reply-To: <20230711115848.2701559-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 11/07/2023 13.58, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a memory leak as follows:
> 
[...]>
> In the cpu_map_update_elem flow, when kthread_stop is called before
> calling the threadfn of rcpu->kthread, since the KTHREAD_SHOULD_STOP bit
> of kthread has been set by kthread_stop, the threadfn of rcpu->kthread
> will never be executed, and rcpu->refcnt will never be 0, which will
> lead to the allocated rcpu, rcpu->queue and rcpu->queue->queue cannot be
> released.
> 
> Calling kthread_stop before executing kthread's threadfn will return
> -EINTR. We can complete the release of memory resources in this state.
> 
> Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

LGTM, thanks for fixing this.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


