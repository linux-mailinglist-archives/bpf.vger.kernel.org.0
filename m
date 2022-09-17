Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC25BB4DD
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 02:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIQADz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 20:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIQADy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 20:03:54 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9BB56F9;
        Fri, 16 Sep 2022 17:03:50 -0700 (PDT)
Message-ID: <9b66564e-2582-03b2-56f1-8037f8aca886@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663373028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tR6wInvPk183+mhIgKv2vbvtJK2JcPDWX8U0jw/KuDY=;
        b=brd1JeiPc8ULUl92liskHob9EBfIf0fFcYBqorqjM1XzyiVFcAYi4sDl/MRvK6/uJAEzzj
        ENfbnXUe1oDN+nAcer4/AolUh2hQ+CgKmzS3uL9FAn954Xm2BSUYbRCUbAn0nREP4uGIjJ
        3S4PDzHhTv1JVwLtkH8ZtyymOGQpHaw=
Date:   Fri, 16 Sep 2022 17:03:42 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf, cgroup: Don't populate
 prog_attach_flags array when effective query
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914161742.3180731-1-pulehui@huaweicloud.com>
 <20220914161742.3180731-2-pulehui@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220914161742.3180731-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/14/22 9:17 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Attach flags is only valid for attached progs of this layer cgroup,
> but not for effective progs. For querying with EFFECTIVE flags,
> exporting attach flags does not make sense. so we don't need to
> populate prog_attach_flags array when effective query.

prog_attach_flags has been added to 6.0 which is in rc5.  It is still 
doable (and cleaner) to reject prog_attach_flags when it is an 
effective_query.  This should be done regardless of 'type == 
BPF_LSM_CGROUP' or not.  Something like:

if (effective_query && prog_attach_flags)
     return -EINVAL;

Otherwise, the whole prog_attach_flags needs to be set to 0 during 
effective_query.  Please target the change to the bpf tree instead of 
bpf-next such that this uapi bit can be fixed before 6.0.

Also, the effective_query issue is not limited to the prog_attach_flags? 
For the older uattr->query.attach_flags, it should be set to 0 also when 
it is an effective_query, right?

