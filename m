Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC19698753
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 22:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBOV2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 16:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOV2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 16:28:37 -0500
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CBD22A1D
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 13:28:36 -0800 (PST)
Message-ID: <31ab903b-6ba3-8ee8-f7a6-ab2e09b75f7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676496514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GaYU7EJs0nqEq7OhM4ZKuvnLndeRJu4WKwMKJuGCSz0=;
        b=Nwqfyq23p3GRh2d9xubSsjztuc/W9J5skCF1vna3XAGF5BGi9pLNV2VjvvHgg2B3MAeFW+
        RM53dMp6/G6MumQo97NoyIGWv+NLycRbvIMAqqlV8388H5tBisjXtmliaV6kBRgN8dWeL4
        C9s3QmWD5OXnQV/tVUU/fX0y4Q3AGI0=
Date:   Wed, 15 Feb 2023 13:28:31 -0800
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
 <Y+0oF83AqICySV+H@google.com>
 <78cf4151-8544-bc63-eff7-ff763639c118@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <78cf4151-8544-bc63-eff7-ff763639c118@gmail.com>
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

On 2/15/23 12:24 PM, Kui-Feng Lee wrote:
> 
> On 2/15/23 10:44, Stanislav Fomichev wrote:
>> On 02/15, Kui-Feng Lee wrote:
>>> Thank you for the feedback.
>>
>>
>>> On 2/14/23 18:39, Stanislav Fomichev wrote:
>>> > On 02/14, Kui-Feng Lee wrote:
> [..]
>>> >
>>> > > +��� if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
>>> > > +������� return -EINVAL;
>>> > > +
>>> > > +��� link = kzalloc(sizeof(*link), GFP_USER);
>>> > > +��� if (!link) {
>>> > > +������� err = -ENOMEM;
>>> > > +������� goto err_out;
>>> > > +��� }
>>> > > +��� bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS,
>>> > > &bpf_struct_ops_map_lops, NULL);
>>> > > +��� link->map = map;
>>> > > +
>>> > > +��� err = bpf_link_prime(link, &link_primer);
>>> > > +��� if (err)
>>> > > +������� goto err_out;
>>> > > +
>>> > > +��� return bpf_link_settle(&link_primer);
>>> > > +
>>> > > +err_out:
>>> > > +��� bpf_map_put(map);
>>> > > +��� kfree(link);
>>> > > +��� return err;
>>> > > +}
>>> > > +
>>> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> > > index cda8d00f3762..54e172d8f5d1 100644
>>> > > --- a/kernel/bpf/syscall.c
>>> > > +++ b/kernel/bpf/syscall.c
>>> > > @@ -2738,7 +2738,9 @@ static void bpf_link_free(struct bpf_link *link)
>>> > > ����� if (link->prog) {
>>> > > ��������� /* detach BPF program, clean up used resources */
>>> > > ��������� link->ops->release(link);
>>> > > -������� bpf_prog_put(link->prog);
>>> > > +������� if (link->type != BPF_LINK_TYPE_STRUCT_OPS)
>>> > > +����������� bpf_prog_put(link->prog);
>>> > > +������� /* The struct_ops links clean up map by them-selves. */
>>> >
>>> > Why not more generic:
>>> >
>>> > if (link->prog)
>>> > ����bpf_prog_put(link->prog);
>>> >
>>> > ?
>>> The `prog` and `map` functions are now occupying the same space. I'm afraid
>>> this check won't work.
>>
>> Hmm, good point. In this case: why not have separate prog/map pointers
>> instead of a union? Are we 100% sure struct_ops is unique enough
>> and there won't ever be another map-based links?
>>
> Good question!
> 
> bpf_link is used to attach a single BPF program with a hook now. This patch 
> takes things one step further, allowing the attachment of struct_ops. We can 
> think of it as attaching a set of BPF programs to a pre-existing set of hooks. I 
> would say that bpf_link now represents the attachments of a set of BPF programs 
> to a pre-defined set of hooks. The size of a set is one for the case of 
> attaching single BPF program.
> 
> Is creating a new map-based link indicative of introducing an entirely distinct 
> type of map that reflects a set of BPF programs? If so, why doesn't struct_ops 
> work? If it happens, we may need to create a function to validate the 
> attach_type associated with any given map type.
> 

I also prefer separating 'prog' and 'map' in the link. It may be only struct_ops 
link that has no prog now but the future link type may not have prog also, so 
testing link->prog is less tie-up to a specific link type. Once separated, it 
makes sense to push the link's specific field to a new struct, so the following 
(from Stan) makes more sense:

struct bpt_struct_ops_link {
     struct bpf_link link;
     struct bpf_map *map;
};

In bpf_link_free(), there is no need to do an extra check for 'link->type != 
BPF_LINK_TYPE_STRUCT_OPS'. bpf_struct_ops_map_link_release() can be done 
together in bpf_struct_ops_map_link_dealloc().
