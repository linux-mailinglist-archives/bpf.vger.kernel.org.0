Return-Path: <bpf+bounces-3120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FCE73995D
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688EB2817ED
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6D15AF6;
	Thu, 22 Jun 2023 08:23:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A713ADF
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:23:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16961BF4
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687422181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOdV54lATHdQofNik3EiTT9JXn7/yOoqOYzJfK/2WMg=;
	b=ABFcyXYVSKZGfbzbiduIVolRMM49kD/PlURV19Jm2WO+v1rRZP7bwpXJXCBNVTfug3QCSk
	Aop1IMdgMaYQuJyGVLBEEXEQgLZ0dk8G9M00ZDE50qQBjOfCnw3NXMoawyGc3TPUrydD4H
	mo6pNJlDXv1jBwAH+1jE2O2zqNlMAfo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455--Po1PL2dMAGY4hXSf8sQvg-1; Thu, 22 Jun 2023 04:22:59 -0400
X-MC-Unique: -Po1PL2dMAGY4hXSf8sQvg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b46d3eb01fso42107741fa.2
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 01:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422177; x=1690014177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOdV54lATHdQofNik3EiTT9JXn7/yOoqOYzJfK/2WMg=;
        b=Whi2/r163KiRpnz6qpMk8fJstlZ4iodu1dKW/AOy7zD2WWmuiTKnmHooHWAYVwwgRa
         9L8zi6qpuEfsrUQ3YqeEksjES6GJ6b26m97zOa6wYLIFJWHvIRR9JEngaR9qY2+mdzox
         86m5TC+Q5MtZaQGCY3oAJ3oTqfFEcwVwo74w5vCMYJ2QMFfUflhehJx9KLefBssHgMlU
         wmMr9VVLbhVzOxTYFrlZrw+TOQAVJy1udoIsrEvAI+iQjyruOG4r6OmDphWHmTDHyIQJ
         1+XTI/j9+skUk75VpAlZ0Fh7tdsFY0ubW6Vn+7bT02/UkBEyNRo2AB+YxEJ45mai93Ix
         3Dsw==
X-Gm-Message-State: AC+VfDzjpyHBnYUx+UvRA19NIDgRIlALPS39ooYCffv2rnEBwKAWRxw/
	NrN+rSNk1yA7h+oX0NQXIdhsAD1eY6ZProqi5pI+Z9AqTNKWndQ58nB7Wx95HKHxKfPxobfWOSD
	IAcaHby3ghziPwedI3qM1
X-Received: by 2002:a2e:9e1a:0:b0:2b4:6994:4758 with SMTP id e26-20020a2e9e1a000000b002b469944758mr7793319ljk.49.1687422177190;
        Thu, 22 Jun 2023 01:22:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6kL9nO6pSEzVdwiJ9K31Wh1ZkYByiwgzdl6D/jER5AVvmXPVS2TihUDhRl1icluMBU6YPxow==
X-Received: by 2002:a2e:9e1a:0:b0:2b4:6994:4758 with SMTP id e26-20020a2e9e1a000000b002b469944758mr7793302ljk.49.1687422176807;
        Thu, 22 Jun 2023 01:22:56 -0700 (PDT)
Received: from [192.168.0.12] ([78.18.22.70])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003f90067880esm15439072wmk.47.2023.06.22.01.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:22:56 -0700 (PDT)
Message-ID: <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
Date: Thu, 22 Jun 2023 09:22:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andy Lutomirski <luto@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/06/2023 00:48, Andrii Nakryiko wrote:
>
>>>> Giving a way to enable BPF in a container is only a small part of the overall task -- making BPF behave sensibly in that container seems like it should also be necessary.
>>> BPF is still a privileged thing. You can't just say that any
>>> unprivileged application should be able to use BPF. That's why BPF
>>> token is about trusting unpriv application in a controlled environment
>>> (production) to not do something crazy. It can be enforced further
>>> through LSM usage, but in a lot of cases, when dealing with internal
>>> production applications it's enough to have a proper application
>>> design and rely on code review process to avoid any negative effects.
>> We really shouldn’t be creating new kinds of privileged containers that do uncontained things.
>>
>> If you actually want to go this route, I think you would do much better to introduce a way for a container manager to usefully proxy BPF on behalf of the container.
> Please see Hao's reply ([0]) about his and Google's (not so rosy)
> experiences with building and using such BPF proxy. We (Meta)
> internally didn't go this route at all and strongly prefer not to.
> There are lots of downsides and complications to having a BPF proxy.
> In the end, this is just shuffling around where the decision about
> trusting a given application with BPF access is being made. BPF proxy
> adds lots of unnecessary logistical, operational, and development
> complexity, but doesn't magically make anything safer.
>
>    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP16o-uRZ9G0KqCfM4Q@mail.gmail.com/
>
Apologies for being blunt, but  the token approach to me seems to be a 
work around providing the right level/classification for a pod/container 
in order to say you support unprivileged containers using eBPF. I think 
if your container needs to do privileged things it should have and be 
classified with the right permissions (privileges) to do what it needs 
to do.

The  proxy BPF on behalf of the container approach works for containers 
that don't need to do privileged BPF operations.

I have to say that  the `proxy BPF on behalf of the container` meets the 
needs of unprivileged pods and at the same time giving CAP_BPF to the 
applications meets the needs of these PODs that need to do 
privileged/bpf things without any tokens. Ultimately you are trusting 
these apps in the same way as if you were granting a token.


>>> So privileged daemon (container manager) will be configured with the
>>> knowledge of which services/containers are allowed to use BPF, and
>>> will grant BPF token only to those that were explicitly allowlisted.



