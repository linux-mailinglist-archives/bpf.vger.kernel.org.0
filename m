Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784106A9AD3
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 16:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCCPkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 10:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCCPki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 10:40:38 -0500
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BAF1B1
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 07:40:34 -0800 (PST)
Message-ID: <ea8736cf-6d25-5e56-0359-6a80593dd3ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677858032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mruoipUBuHorZ6cWtH7wekQGx+tH1zoAbre1Isbonc=;
        b=BT6RbACLrKHYSwFxmUkadc3Cij8bH7vuVecZSBdBJfFZXtLfgchwafwkRVTL24Bbwu03sV
        EtmIM6wQc1CnA8LefL5Oysj0UbNMpULK2WUnIZsjtL02VQ44VG3BcFsuwf1VuOTW9imddH
        RBDDCSObg422Ft1lzgPQhbK0JmJkga8=
Date:   Fri, 3 Mar 2023 07:40:26 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Use separate RCU callbacks for freeing
 selem
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20230303141542.300068-1-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230303141542.300068-1-memxor@gmail.com>
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

On 3/3/23 6:15 AM, Kumar Kartikeya Dwivedi wrote:
> Martin suggested that instead of using a byte in the hole (which he has
> a use for in his future patch) in bpf_local_storage_elem, we can
> dispatch a different call_rcu callback based on whether we need to free
> special fields in bpf_local_storage_elem data. The free path, described
> in commit 9db44fdd8105 ("bpf: Support kptrs in local storage maps"),
> only waits for call_rcu callbacks when there are special (kptrs, etc.)
> fields in the map value, hence it is necessary that we only access
> smap in this case.
> 
> Therefore, dispatch different RCU callbacks based on the BPF map has a
> valid btf_record, which dereference and use smap's btf_record only when
> it is valid.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks for your patch. I have already made a similar change in my local branch 
which has some differences like refactored it a little for my work. The set is 
almost ready. Do you mind if I include your patch in my set and keep your SOB?

