Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D028668B1D
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 06:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjAMFOY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 00:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjAMFOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 00:14:14 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C416660871
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 21:14:13 -0800 (PST)
Message-ID: <b05c4042-ee7e-43ad-b518-411bd3afa95e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673586851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCjBifg6k1S0wrcDOQxh9S/ldCQazwMMhaP8Gj/SdBM=;
        b=J0+GAUmgY3R6HJL/4yz9uGsMBxB9UmBcvLZWbSTitc6lWU6A7pqcRHW2C3qpynFn5u7t7w
        EAg0Xvd8IAVfpYBbbSClr/+ANR2tAIZNd0GK4CgrguGJQZ5xyhvytHcCpIhUvxf1LoJU3J
        piY2ITW7fWj0uiNkz/HudkJggvx9b7Y=
Date:   Thu, 12 Jan 2023 21:14:05 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v5 3/3] bpf: hash map, suppress false lockdep warning
Content-Language: en-US
To:     Tonghao Zhang <tong@infragraf.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org
References: <20230111092903.92389-1-tong@infragraf.org>
 <20230111092903.92389-3-tong@infragraf.org>
 <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
 <97068F10-C869-4FF3-8FE0-21FA6DA82D98@infragraf.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <97068F10-C869-4FF3-8FE0-21FA6DA82D98@infragraf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/12/23 6:17 PM, Tonghao Zhang wrote:
>> I am not very sure about the lockdep_off/on. Other than the false warning when using the very same htab map by both NMI and non-NMI context, I think the lockdep will still be useful
> Agree, but there is no good way to fix this warning.

I applied patch 1 to the bpf tree with the 'Fixes: 20b6cc34ea74 ("bpf: Avoid 
hashtab deadlock with map_locked")' tag. Thanks.

The commit message has a link to the test. Not ideal but keeping the lockdep is 
more important.
