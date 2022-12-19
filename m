Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD06511BE
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 19:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiLSSYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 13:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiLSSYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 13:24:15 -0500
Received: from out-105.mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423613D64
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 10:24:14 -0800 (PST)
Message-ID: <38a93791-97f1-2fe1-ba1a-04dde1980d85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671474252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UGPwx94LpKP8jsRIP6cLgR4IAZId/6w5Rhk78q8wkk=;
        b=AU4hiZNIKZUopbCT6qKFNYIQW0Jp/sEZV4+bMwvnte0+7AfNmHU/Op/Ec00KGA/ia3vJrw
        /iaMkV5x/YVdrJ5PPAztKtcxB/ksLOrd644hnMZ/OcF1Gd93dOJGmoMzbJpvi+oNgT2yFu
        srzL3i16ckKxPyS7u6sMpav977bKCQA=
Date:   Mon, 19 Dec 2022 10:24:07 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v2 1/2] bpf: add runtime stats, max cost
Content-Language: en-US
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Song Liu <song@kernel.org>
References: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
 <553c4d32-aac1-f5d2-8f39-86cdca1af0d6@meta.com>
 <CAMDZJNW+c0JkgZ0XOtq674cjXeof+U0D54yd8JBzizuQioDt3A@mail.gmail.com>
 <425c20bd-9e7e-4fc7-9050-7d9e9bfce972@iogearbox.net>
 <CAMDZJNWwiScnqhvhBqDf_neiRimLGmZw-xN0UNLJE_q01K3vkQ@mail.gmail.com>
 <CAPhsuW4ai+ojXTfgfUa+ZXyEfv8siW8Ya9+_oa+Urw=ga+rHKw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAPhsuW4ai+ojXTfgfUa+ZXyEfv8siW8Ya9+_oa+Urw=ga+rHKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/19/22 12:04 AM, Song Liu wrote:
> While max time cost might be useful in some debugging, I don't think
> we should add it with kernel.bpf_stats_enabled. Otherwise, we can
> argue p50/p90/p99 are also useful in some cases, and some other
> metrics are useful in some other cases.  These metrics together will
> make kernel.bpf_stats_enabled too expensive for the use case above.
> 
> Since the use case is for debugging, have you considered using
> some other BPF programs to profile the target BPF program?
> Please refer to "bpftool prog profile" or "perf stat -b " for
> examples of similar solutions.
+1.  Please consider other suggested solutions that the same can be done in a 
more flexible way.

