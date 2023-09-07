Return-Path: <bpf+bounces-9443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C2797BED
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5B2817A5
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494112B85;
	Thu,  7 Sep 2023 18:31:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77914010
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:31:48 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45B1BDC
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 11:31:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401da71b7faso14849415e9.2
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1694111454; x=1694716254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNTVI4f7lyrYMJHSa0H1JID0t17YVxVdLEeXgpOF/ZM=;
        b=ItcRfplH1pycUFlEj0Cw1eDir/cNk6pOBU9ulqZGvXp6vXGhwVYgG6RQH6j/pfOQM5
         hvPOlX72o54fVjR5uvYvb0KILGbsQcRF3HsEkjgduCzW2AijxXdDbFtTSdWKUl9G7RgP
         R+fJhX8oASgYhAl3mvW/DwzwVNOqKWfd+aTjVNjBsANf+k/3oY4+FNorKElwT0JGzknx
         EKhjbHysy0F+a2APAFtom7Pg6J/hev3pU2NcSixNg/Mxqp1RO6WIGKhUGFYrAkrU4a5C
         5XzL5ALBhHrzhRLbER2L4JCqOAAdWN2PYC5Hwi6De9VwDHyGzBrsmqYP5dd/YMORhQmw
         ZVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694111454; x=1694716254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNTVI4f7lyrYMJHSa0H1JID0t17YVxVdLEeXgpOF/ZM=;
        b=n0Ogs9PYQSId6qofuF/tyiDtS0rDcZ800HSgX8D6P9nAOjZdj6ZaiKMaZ8+8w8yNL2
         MmNtkih6K82OhdQvof9/IIFKxONacRLdorKbDQqH10iweoYkYc+U887SO+Sl27q1P3zn
         u6bEY3jVE9rRPrj6lT35u/48zE90OUdOu7xOk5ZoN9w4ze326IeOQAVH8Kww6+f4Vxln
         tDs49Mu9vngY+oSUnsvRlP0/ULTd7TCHU3xi8gZI4fzcSHyLOPQ0IwMnp2KFwjwsLYY7
         QsQBDa4Az35tQ+WFOrrKp5jI8lDemdVsIM92RORgAZs5PKpK1HfBZUsSHuuOVB4wZP/m
         a87Q==
X-Gm-Message-State: AOJu0YwqlTV2911DavuRVkJIcxoHHKD6nnVMniQTFm3nmGNugR2Whz0I
	ioZNXAToVAAdTtZdY4lHCl7ifbeqg+Ly56tsJs8Sjw==
X-Google-Smtp-Source: AGHT+IEttfmERxiM/L3KpZSGhjYPzeNtvwYrv9CM30hDkctrjmmkCKyQTfrQDn8E2K4fXRGXb+4GaA==
X-Received: by 2002:a05:600c:2811:b0:3fb:ffa8:6d78 with SMTP id m17-20020a05600c281100b003fbffa86d78mr4162952wmb.36.1694077651881;
        Thu, 07 Sep 2023 02:07:31 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:ace0:3e80:4307:5b4b? ([2a02:8011:e80c:0:ace0:3e80:4307:5b4b])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000180f00b003142ea7a661sm22591889wrh.21.2023.09.07.02.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 02:07:31 -0700 (PDT)
Message-ID: <0fabfdb8-ca27-4f71-8b71-8a8fba45c5d3@isovalent.com>
Date: Thu, 7 Sep 2023 10:07:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpftool: fix -Wcast-qual warning
Content-Language: en-GB
To: Denys Zagorui <dzagorui@cisco.com>, alastorze@fb.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230907090210.968612-1-dzagorui@cisco.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230907090210.968612-1-dzagorui@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/09/2023 10:02, Denys Zagorui wrote:
> This cast was made by purpose for older libbpf where the
> bpf_object_skeleton field is void * instead of const void *
> to eliminate a warning (as i understand
> -Wincompatible-pointer-types-discards-qualifiers) but this
> cast introduces another warning (-Wcast-qual) for libbpf
> where data field is const void *
> 
> It makes sense for bpftool to be in sync with libbpf from
> kernel sources
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>


