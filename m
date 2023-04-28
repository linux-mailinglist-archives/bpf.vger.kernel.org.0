Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94A16F1ABF
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbjD1Oqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjD1Oqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 10:46:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F8B4EF4;
        Fri, 28 Apr 2023 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VEmXz+ylVr+WaJKCgmNsQp/Rc39N+DEL3hqlNMcb+RY=; b=DaFcvaX5gVCgJvaEB94d8hXJaW
        9SGmLALmCYdK0lv14NfgRaqWksjyp6oBLvlabKvl+H8qwPT4BJln8WEmsJ214ZAEW0dc+A6m3wP5f
        xMG6E6Yk3fzbb34AjJHxQaR/aqjOr99cwpQy6lG9eC5/927yGCYfAZjG3QtKhZbV35CNogv38XHCq
        5tuV7onoFTwvVb10tNDgYqIkPIa11h5IZL7FuQW9dR7e7xSxH196CCm/1/kC1E7ktLLZuMmaiOtbt
        ptuO9peEdhOEVRnR+PVBHs686x6e3b264xgQBBcYt0aZTWeNtg1XZjO+7rvNdrSSk+/9EFvIVA2Hn
        H5Db0BLQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psPMd-00B1Ia-0P;
        Fri, 28 Apr 2023 14:46:23 +0000
Message-ID: <7a8df04e-ee81-8b4a-152f-1588b8d6cb42@infradead.org>
Date:   Fri, 28 Apr 2023 07:46:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] lsm: move hook comments docs to security/security.c
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20230428030916.2966-1-rdunlap@infradead.org>
 <CAHC9VhQoa5yw2e1jiN844pxNXXT+CosJn9ip7ysFnsnUbQUi2Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHC9VhQoa5yw2e1jiN844pxNXXT+CosJn9ip7ysFnsnUbQUi2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/28/23 07:43, Paul Moore wrote:
> On Thu, Apr 27, 2023 at 11:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix one kernel-doc warning, but invesigating that led to other
>> kernel-doc movement (lsm_hooks.h to security.c) that needs to be
>> fixed also.
>>
>> include/linux/lsm_hooks.h:1: warning: no structured comments found
>>
>> Fixes: e261301c851a ("lsm: move the remaining LSM hook comments to security/security.c")
>> Fixes: 1cd2aca64a5d ("lsm: move the io_uring hook comments to security/security.c")
>> Fixes: 452b670c7222 ("lsm: move the perf hook comments to security/security.c")
>> Fixes: 55e853201a9e ("lsm: move the bpf hook comments to security/security.c")
>> Fixes: b14faf9c94a6 ("lsm: move the audit hook comments to security/security.c")
>> Fixes: 1427ddbe5cc1 ("lsm: move the binder hook comments to security/security.c")
>> Fixes: 43fad2821876 ("lsm: move the sysv hook comments to security/security.c")
>> Fixes: ecc419a44535 ("lsm: move the key hook comments to security/security.c")
>> Fixes: 742b99456e86 ("lsm: move the xfrm hook comments to security/security.c")
>> Fixes: ac318aed5498 ("lsm: move the Infiniband hook comments to security/security.c")
>> Fixes: 4a49f592e931 ("lsm: move the SCTP hook comments to security/security.c")
>> Fixes: 6b6bbe8c02a1 ("lsm: move the socket hook comments to security/security.c")
>> Fixes: 2c2442fd46cd ("lsm: move the AF_UNIX hook comments to security/security.c")
>> Fixes: 2bcf51bf2f03 ("lsm: move the netlink hook comments to security/security.c")
>> Fixes: 130c53bfee4b ("lsm: move the task hook comments to security/security.c")
>> Fixes: a0fd6480de48 ("lsm: move the file hook comments to security/security.c")
>> Fixes: 9348944b775d ("lsm: move the kernfs hook comments to security/security.c")
>> Fixes: 916e32584dfa ("lsm: move the inode hook comments to security/security.c")
>> Fixes: 08526a902cc4 ("lsm: move the filesystem hook comments to security/security.c")
>> Fixes: 36819f185590 ("lsm: move the fs_context hook comments to security/security.c")
>> Fixes: 1661372c912d ("lsm: move the program execution hook comments to security/security.c")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: linux-security-module@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: KP Singh <kpsingh@kernel.org>
>> Cc: bpf@vger.kernel.org
>> ---
>>  Documentation/bpf/prog_lsm.rst             |    2 +-
>>  Documentation/security/lsm-development.rst |    6 +++---
>>  Documentation/security/lsm.rst             |    2 +-
>>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> Thanks Randy.  Did you want to take this via the doc tree, or would
> you prefer if I pulled this into the LSM tree?
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> 

I think that the LSM tree would be appropriate for it.

Thanks.

-- 
~Randy
