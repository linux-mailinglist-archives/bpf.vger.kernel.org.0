Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A506E698592
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBOUaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 15:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBOUay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 15:30:54 -0500
Received: from out-119.mta1.migadu.com (out-119.mta1.migadu.com [IPv6:2001:41d0:203:375::77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C61F924
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 12:30:53 -0800 (PST)
Message-ID: <f45c69b1-1bb6-35a0-9100-bd0df732fa2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676493051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeqvJfxW9aG2icyXoDqw3Yd8qypnZHl0z4/I/bYAWqg=;
        b=Qlw520BJx7wFijYdsWrBhFLW5YbtgEvnRHNm6Aw4Bq5SBRCBI5bV/0XvlotFaokg8s3D/V
        zo1mfNI0X7IhJ5z8Jk2Q9Xl7PnLVEuT3yoVD30KaZw+YiRU6lSGu/NVw3Sk0Q9VmrBkZb7
        TGNaBXqqv5vCBUNNBJzOaptHlLkDlHU=
Date:   Wed, 15 Feb 2023 12:30:47 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
Content-Language: en-US
To:     Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-2-kuifeng@meta.com> <Y+xF8k8RMiG0xBDY@google.com>
 <9204de1c-9d98-fe87-77f8-04554210e479@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <9204de1c-9d98-fe87-77f8-04554210e479@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/15/23 10:04 AM, Kui-Feng Lee wrote:
>>> +    int err;
>>> +
>>> +    map = bpf_map_get(attr->link_create.prog_fd);
>>
>> bpf_map_get can fail here?
> 
> 
> We have already verified the `attach_type` of the link before calling this 
> function, so an error should not occur. If it does happen, however, something 
> truly unusual must be happening. To ensure maximum protection and avoid this 
> issue in the future, I will add a check here as well.

bpf_map_get() could fail. A valid attach_type does not mean prog_fd (actually 
map_fd here) is also valid.
