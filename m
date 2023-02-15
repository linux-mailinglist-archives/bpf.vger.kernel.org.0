Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321EF69857D
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBOUYW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 15:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBOUYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 15:24:22 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439AF8A63
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 12:24:21 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 16so55918pfo.8
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTsLuT63unILVF07/qh1xLYdQskYe+F9hZhL7eZI0TI=;
        b=KABSEaOy0bhFhzSOm7VRDZzqpjxgPp8sy4niO04MrBocoUlY1KO7Ew0eYRj+aHto77
         NE3SO05B93u4HC9eIeXYVhxT2toA5MmEoLSnOh+2w6KbYszJAUvfgOuDFyPtTeuJN7LX
         Asu7AlLAf0K3snoS+p4erZnnuG51K0PRG3nmgf5tEbtEX+zM5iaYrHYRUgZBWKfv67vq
         6wF7FPCxwER8hf1nkWQz3KloZ9MQ3rx8AbnoOG7BXJEUGZkxYVuu3Pjr9F/0Hf2XmyEg
         jG3He4gXuuMH5Xv7vqRuAz7r7VbSHYhcrD+ToW3siI+RDxdNOjqOqJS9oNz5ldNKIjOi
         TxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTsLuT63unILVF07/qh1xLYdQskYe+F9hZhL7eZI0TI=;
        b=g15sIDF5tSqfiGU3ZNdCjLbDzrRVkQYrqzVJVBLmqidLmi/TIcjveSuK4At4K8PjVu
         TxNbFafnur6GY2cMYHtQAJMyn18l/DRuceEAI0f5yNV7GOXR+4440VoREFzM7xPLhOyL
         lQ8oFnPsC2/CcjixLJsEiZNJdrWjo0SSN/v4UtgWAmBSbxb5xWJzAAktz0CToluOSKQz
         rZpXiF8/X8My0IeU2F0XjKuZjGrUT1WGxVtk+TN50ZJoxOQgUvGXKZYv/DyKtf+bQT7y
         LBsU5fx2XqhDIK8J3b4roL6e6DPT15AR8zJl7KlJrM6CG6zQKqlYdxBNM47zrofcRlXe
         S9cg==
X-Gm-Message-State: AO0yUKWosDB+vNaGhw3Hti+8H3WerqndBmviZRtjEUlkWGQMF7EGQwO5
        G5rTSlvAz2SswTbJLYxboNQ=
X-Google-Smtp-Source: AK7set8hsnbnZxSKYyvuQydSliW7+CNtWUmkwxyRgQg6uKDUo+Cnl1rpYnm07zYL85oPIJgA1Y/ITw==
X-Received: by 2002:a62:17d2:0:b0:5a8:4db3:266e with SMTP id 201-20020a6217d2000000b005a84db3266emr2524189pfx.10.1676492660645;
        Wed, 15 Feb 2023 12:24:20 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::1452? ([2620:10d:c090:400::5:1af8])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7924d000000b005a77b030b5csm10240381pfp.88.2023.02.15.12.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:24:20 -0800 (PST)
Message-ID: <78cf4151-8544-bc63-eff7-ff763639c118@gmail.com>
Date:   Wed, 15 Feb 2023 12:24:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-2-kuifeng@meta.com> <Y+xF8k8RMiG0xBDY@google.com>
 <9204de1c-9d98-fe87-77f8-04554210e479@gmail.com>
 <Y+0oF83AqICySV+H@google.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Y+0oF83AqICySV+H@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2/15/23 10:44, Stanislav Fomichev wrote:
> On 02/15, Kui-Feng Lee wrote:
>> Thank you for the feedback.
>
>
>> On 2/14/23 18:39, Stanislav Fomichev wrote:
>> > On 02/14, Kui-Feng Lee wrote:
[..]
>> >
>> > > +��� if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
>> > > +������� return -EINVAL;
>> > > +
>> > > +��� link = kzalloc(sizeof(*link), GFP_USER);
>> > > +��� if (!link) {
>> > > +������� err = -ENOMEM;
>> > > +������� goto err_out;
>> > > +��� }
>> > > +��� bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS,
>> > > &bpf_struct_ops_map_lops, NULL);
>> > > +��� link->map = map;
>> > > +
>> > > +��� err = bpf_link_prime(link, &link_primer);
>> > > +��� if (err)
>> > > +������� goto err_out;
>> > > +
>> > > +��� return bpf_link_settle(&link_primer);
>> > > +
>> > > +err_out:
>> > > +��� bpf_map_put(map);
>> > > +��� kfree(link);
>> > > +��� return err;
>> > > +}
>> > > +
>> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> > > index cda8d00f3762..54e172d8f5d1 100644
>> > > --- a/kernel/bpf/syscall.c
>> > > +++ b/kernel/bpf/syscall.c
>> > > @@ -2738,7 +2738,9 @@ static void bpf_link_free(struct bpf_link 
>> *link)
>> > > ����� if (link->prog) {
>> > > ��������� /* detach BPF program, clean up used resources */
>> > > ��������� link->ops->release(link);
>> > > -������� bpf_prog_put(link->prog);
>> > > +������� if (link->type != BPF_LINK_TYPE_STRUCT_OPS)
>> > > +����������� bpf_prog_put(link->prog);
>> > > +������� /* The struct_ops links clean up map by them-selves. */
>> >
>> > Why not more generic:
>> >
>> > if (link->prog)
>> > ����bpf_prog_put(link->prog);
>> >
>> > ?
>> The `prog` and `map` functions are now occupying the same space. I'm 
>> afraid
>> this check won't work.
>
> Hmm, good point. In this case: why not have separate prog/map pointers
> instead of a union? Are we 100% sure struct_ops is unique enough
> and there won't ever be another map-based links?
>
Good question!

bpf_link is used to attach a single BPF program with a hook now. This 
patch takes things one step further, allowing the attachment of 
struct_ops. We can think of it as attaching a set of BPF programs to a 
pre-existing set of hooks. I would say that bpf_link now represents the 
attachments of a set of BPF programs to a pre-defined set of hooks. The 
size of a set is one for the case of attaching single BPF program.

Is creating a new map-based link indicative of introducing an entirely 
distinct type of map that reflects a set of BPF programs? If so, why 
doesn't struct_ops work? If it happens, we may need to create a function 
to validate the attach_type associated with any given map type.

