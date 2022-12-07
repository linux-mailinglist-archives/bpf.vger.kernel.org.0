Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7774C64615E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGTCG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLGTB6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:01:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8306F0CA
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:01:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p24so17921426plw.1
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P20Yxxec4WiWUWJyVpRv0euSWMuaIGX438nMe6txtNI=;
        b=JdlCtyv+gNevwkaN2a3gK6P3hMurWlguKu6jmaXpXBtQqpNK4H7uuLEX7saW8EaRT1
         Bj3jRNdYMCVbJRRGKQJdKTzulosKSIhhkx4s+4hOEEEXOO0KOwMbu9xvTLZkqD81/zTq
         MAozirFYG0MpbCMFQv3xRj/DEGFfCzvZgWjOTIvr6a4UC/pQYUeGdirSLYUhhUN+NIZO
         1K9DB5OqkFem5I8IO53+SbIOTu+CV5PPfS7PQbN1a/K9QlgGh3M4OvfI9bm271i8FUOo
         5J6vvwYKNwoCDfrLnMonQZ/7dLfCDOvlhzTTmC5qXFV0aKsBj1ZUWWd/0ksWYTPtHJev
         nT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P20Yxxec4WiWUWJyVpRv0euSWMuaIGX438nMe6txtNI=;
        b=DfNLUbj0j3prZSpM4SbAFYmD2j1dN9+o7Z/bp27UWVsh0aD8Ciw97S4EUWWU7B+BNW
         fecGT4GT0ak5VfEveJg7zNrR4lyDuoh89G6PbRcaJo+lUI+Z70X1qaFuDxpjzgv5BKgD
         DmjM4C0BKwLo7iIcOvY/sllt2Huz0aTQGurKeZWIVf8ziaImA4EVsLrLWWybogxpd/4r
         FH1iuaAwkKvWB+KRf/JeYSBGsTZa2SWba85yaoWJ7h9idwYmfPZJC8mY9BpdPtzE+FMg
         LgaD1heXoH0dIVC63uQ/709inN4YpGMWwMSomaC/Fjm4NrdIK7Twi6xGVU9aRBARq4x9
         Ul1Q==
X-Gm-Message-State: ANoB5pnZQa8zFykCQEQmb7vOjWMQyJinWu+RT+OXVxyU9/IhrZQqxBn+
        jQ4NYPTcXThslTjYPUxkM9Y=
X-Google-Smtp-Source: AA0mqf5eSCWCHmhkG80DOSbWA1LgG870cwRsI7bjrUSyS8mZDfB8qMRP/jZmpbgiKhJ2GPIiRtWStA==
X-Received: by 2002:a17:902:f392:b0:189:8329:db82 with SMTP id f18-20020a170902f39200b001898329db82mr699808ple.62.1670439716880;
        Wed, 07 Dec 2022 11:01:56 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902ca0500b00180033438a0sm14964289pld.106.2022.12.07.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:01:56 -0800 (PST)
Date:   Wed, 7 Dec 2022 11:01:54 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 04/13] bpf: rename list_head ->
 datastructure_head in field info types
Message-ID: <20221207190154.rswsfgi4hrxjekkx@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-5-davemarchevsky@fb.com>
 <Y4/vQ11buRVt4CBL@macbook-pro-6.dhcp.thefacebook.com>
 <22579c38-a478-d6e1-d2c6-f79ffa4555aa@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22579c38-a478-d6e1-d2c6-f79ffa4555aa@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 01:52:07PM -0500, Dave Marchevsky wrote:
> On 12/6/22 8:41 PM, Alexei Starovoitov wrote:
> > On Tue, Dec 06, 2022 at 03:09:51PM -0800, Dave Marchevsky wrote:
> >> Many of the structs recently added to track field info for linked-list
> >> head are useful as-is for rbtree root. So let's do a mechanical renaming
> >> of list_head-related types and fields:
> >>
> >> include/linux/bpf.h:
> >>   struct btf_field_list_head -> struct btf_field_datastructure_head
> >>   list_head -> datastructure_head in struct btf_field union
> >> kernel/bpf/btf.c:
> >>   list_head -> datastructure_head in struct btf_field_info
> > 
> > Looking through this patch and others it eventually becomes
> > confusing with 'datastructure head' name.
> > I'm not sure what is 'head' of the data structure.
> > There is head in the link list, but 'head of tree' is odd.
> > 
> > The attemp here is to find a common name that represents programming
> > concept where there is a 'root' and there are 'nodes' that added to that 'root'.
> > The 'data structure' name is too broad in that sense.
> > Especially later it becomes 'datastructure_api' which is even broader.
> > 
> > I was thinking to propose:
> >  struct btf_field_list_head -> struct btf_field_tree_root
> >  list_head -> tree_root in struct btf_field union
> > 
> > and is_kfunc_tree_api later...
> > since link list is a tree too.
> > 
> > But reading 'tree' next to other names like 'field', 'kfunc'
> > it might be mistaken that 'tree' applies to the former.
> > So I think using 'graph' as more general concept to describe both
> > link list and rb-tree would be the best.
> > 
> > So the proposal:
> >  struct btf_field_list_head -> struct btf_field_graph_root
> >  list_head -> graph_root in struct btf_field union
> > 
> > and is_kfunc_graph_api later...
> > 
> > 'graph' is short enough and rarely used in names,
> > so it stands on its own next to 'field' and in combination
> > with other names.
> > wdyt?
> > 
> 
> I'm not a huge fan of 'graph', but it's certainly better than
> 'datastructure_api', and avoids the "all next-gen datastructures must do this"
> implication of a 'ng_ds' name. So will try the rename in v2.

fwiw I don't like 'next-' bit in 'next-gen ds'.
A year from now the 'next' will sound really old.
Just like N in NAPI used to be 'new'.

> (all specific GRAPH naming suggestions in subsequent patches will
> be done as well)
> 
> list 'head' -> list 'root' SGTM as well. Not ideal, but alternatives
> are worse (rbtree 'head'...)

Thanks!
