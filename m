Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD3619223
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKDHnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKDHnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:43:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE62935E
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:43:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso7516367pjc.0
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyLdCh0zuKyHy4h07xinmt3mDOcW4GVMxzcQTthB/YA=;
        b=X4f66p6FPKm/QKnwwQqrrdMxck8+iRTQTfT4N3RIvx2d2shbWylNS6KxJQN3mCj2Qr
         cloeHNazK0a3L389uC/WsRASsta+Yu0wht22RwnX4wxOy+pPRexz+VUHwmpcbr8s3GmZ
         bUDafu3liKVFiJvkGPVfJMiC30eVf2vZk5UoKNquIk0w9LRXlqaU0SQLeYLeNuZOlvlb
         bm1I2VcIb9+2NjcnHZeZurzESBz6gCVtlKHCjeZmAeHp2SXh1xg0hbhEU33BG3sBFiCl
         OewX3PilXqupAuWSP8k7Jo3/fcErnG1VVfowA4muG/uZNpoHqoq0HoTyMZmo5+YcR4ac
         oghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyLdCh0zuKyHy4h07xinmt3mDOcW4GVMxzcQTthB/YA=;
        b=z4nGQ0FacAYj2yHAHfliaKmH7ixwbHmh36HNi52YDdAtGDwfuFHmtNQrzlshbREeI/
         dfTPYpTguviaRRe0zXxUdyHjLg9TDJXR62sH4kUYaQ3UMcU7S+OTzJ5V8C3fTk8CVgc9
         w9BynMAR2SyEUeLH0zE26Zkg00Q5LC2DyPPM48VEYWWwlWxq/IecabCSIw2ykxB5QCQM
         LuZCJwPpbOSMNUbBIDAZF5KABybAxOmrXg6hS7KyGq89SU3W5GkKVh6FXC5vFmMkyWwG
         9laCOM4VuEuQ74ZyNlLXuQtqDl3tkwS9OBzMcdtAxpnQXuMKDY6Jy7n+PGaPOWvxnUq9
         M1Tg==
X-Gm-Message-State: ACrzQf1ehssmwq/6Pmh3Q4tK7YYuVEhizkNKdFPhuZzRE4A96EAtiNi5
        m6k0AGgKrZrCsdb0SiT9id7oOtJBOsDMAw==
X-Google-Smtp-Source: AMsMyM7BlInVn7LZ/PBXmYjlFG0AmRDnSu2NRRX1sGQ5HXq9VOWzhtbdhlTM8I6cAkcx09sE1b4Ddg==
X-Received: by 2002:a17:90a:1097:b0:213:d7d3:ab8 with SMTP id c23-20020a17090a109700b00213d7d30ab8mr27643483pja.91.1667547791549;
        Fri, 04 Nov 2022 00:43:11 -0700 (PDT)
Received: from localhost ([157.51.134.255])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027e4900b00186a2444a43sm1944791pln.27.2022.11.04.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:43:11 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:12:48 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 22/24] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <20221104074248.olfotqiujxz75hzd@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-23-memxor@gmail.com>
 <d3765c8e-3b1b-3ea4-8612-34b8580bc892@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3765c8e-3b1b-3ea4-8612-34b8580bc892@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 11:26:39AM IST, Dave Marchevsky wrote:
> On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> > Add a linked list API for use in BPF programs, where it expects
> > protection from the bpf_spin_lock in the same allocation as the
> > bpf_list_head. Future patches will extend the same infrastructure to
> > have different flavors with varying protection domains and visibility
> > (e.g. percpu variant with local_t protection, usable in NMI progs).
> >
> > The following functions are added to kick things off:
> >
> > bpf_list_push_front
> > bpf_list_push_back
> > bpf_list_pop_front
> > bpf_list_pop_back
> >
> > The lock protecting the bpf_list_head needs to be taken for all
> > operations.
> >
> > Once a node has been added to the list, it's pointer changes to
> > PTR_UNTRUSTED. However, it is only released once the lock protecting the
> > list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
> > active ref_obj_id, it is still permitted to read and write to them as
> > long as the lock is held.
>
> I think "still permitted to ... write to them" is not accurate
> for this version of the series. In v2 you mentioned [0]:
>
> """
> I have switched things a bit to disallow stores, which is a bug right now in
> this set, because one can do this:
>
> push_front(head, &p->node);
> p2 = container_of(pop_front(head));
> // p2 == p
> bpf_obj_drop(p2);
> p->data = ...;
>
> One can always fully initialize the object _before_ inserting it into the list,
> in some cases that will be the requirement (like adding to RCU protected lists)
> for correctness.
> """
>
> I confirmed this is currently the case by moving data write after
> list_push in the selftest and running it:
>
> @@ -87,8 +87,8 @@ static __always_inline int list_push_pop(struct bpf_spin_lock *lock,
>         }
>
>         bpf_spin_lock(lock);
> -       f->data = 13;
>         bpf_list_push_front(head, &f->node);
> +       f->data = 13;
>         bpf_spin_unlock(lock);
>
> Got "only read is supported" from verifier.
> I think it's fine to punt on supporting writes for now and do it in followups.
>

Thanks for catching it, I'll fix up the commit message.

Also, just to manage the expectations I think enabling writes after pushing the
object won't be possible to make safe, unless the definition of "safe" is
twisted.

As shown in that example, we can reach a point where it has been freed but we
hold an untrusted pointer to it. Once it has been freed the object can be
reallocated and be in use again concurrently, possibly as a different type.

I was contemplating whether to simply drop this whole set_release_on_unlock
logic entirely. Not sure it's worth the added complexity, atleast for now. Once
you push you simply lose ownership of the object and any registers are
immediately killed.
