Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941646260E1
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 19:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKKSJf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 13:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiKKSJe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 13:09:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9510E
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668190114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qL7KWGyJ6F9vY31lSiEsrf+3YWslW3DUyNdiavfNqZw=;
        b=AfzT3NsRzUzZAa76ZV41ZpWbtvSOQtkCqsK85QXHQxSOJ5+iFrYu8LOwQqdsIS8Y1drwjo
        2dau2WUM3aKfSrn1TkorsKWQG9bhmlhJSmjczmkfKlfG0k82J4wKSZrqeEEV63ypk5pa0r
        vRHAnFofzsCG1QR278NJkHdVChTLtwk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-tSNd9l5jNT6XsEH9IKLDHQ-1; Fri, 11 Nov 2022 13:08:33 -0500
X-MC-Unique: tSNd9l5jNT6XsEH9IKLDHQ-1
Received: by mail-wm1-f70.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso2038620wmj.4
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL7KWGyJ6F9vY31lSiEsrf+3YWslW3DUyNdiavfNqZw=;
        b=DvSPNTjguBBwoKqFXucx12Ja0OxH+A0HYSWZqIgvod1OpBIMHbMWwYwW9XaoRFZ9Rj
         VknmurZ8tp+OBUw8tGqlgzrPJjMvbas8m5hyjpMurfOPLdqbQkEwG8tWBpqhGwPobXSi
         PubtxtxATM0RYZGD9seDnWWRH2BAp4Z8n/EGZBFoktRY19VBpEUI71rDPs448ReoE9GV
         +qQev7kCloYAtjH4U6ttPwEW8mbXMYO6v3J2dlhiA8hsc0U85KQIjGxJwXgGXsQ/UTbM
         GnqkDLL39hTNyMOL3VsA9V6t/XQxwFuak6ntstPF+oAsucIRtmBtOO9kP6gweKMDU8cG
         uRJg==
X-Gm-Message-State: ANoB5pl21sJjsEfyj/Km/Vm+GoPLGOrJ3IgOZBKi/kyzmv3Lwxj490fx
        KlRH/VbxvCuc+hCLQd1ZZaoU1uJRH8Q1wsUIUn14Y85TQgddhvlB+PY5N4sk7A74JiEEn0aaTII
        ehOXFaZ53on4FYysFHdMGxNFSNk/D
X-Received: by 2002:a05:600c:4e14:b0:3cf:7194:e0 with SMTP id b20-20020a05600c4e1400b003cf719400e0mr2038689wmq.141.1668190111888;
        Fri, 11 Nov 2022 10:08:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4w2oUJXX9LES8p0j4NAsMLcVI+y+8hKFZAk42nKDXuRfirx3O3JtA1K08hxC5ZILa2G6Kop/MnO63PC3GFOpQ=
X-Received: by 2002:a05:600c:4e14:b0:3cf:7194:e0 with SMTP id
 b20-20020a05600c4e1400b003cf719400e0mr2038678wmq.141.1668190111686; Fri, 11
 Nov 2022 10:08:31 -0800 (PST)
MIME-Version: 1.0
References: <87leoh372s.fsf@toke.dk>
In-Reply-To: <87leoh372s.fsf@toke.dk>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Fri, 11 Nov 2022 19:08:20 +0100
Message-ID: <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> Hi everyone
>
> There seems to be some issue with BTF mismatch when trying to run the
> bpf_ct_set_nat_info() kfunc from a module. I was under the impression
> that this is supposed to work, so is there some kind of BTF dedup issue
> here or something?
>
> Steps to reproduce:
>
> 1. Compile kernel with nf_conntrack built-in and run selftests;
>    './test_progs -a bpf_nf' works
>
> 2. Change the kernel config so nf_conntrack is build as a module
>
> 3. Start the test kernel and manually modprobe nf_conntrack and nf_nat
>
> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
>
> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT nf_conn___init but R1 has a pointer to STRUCT nf_conn___init

This week Kumar and I took a look at this issue and we ended up
identifying a duplication of nf_conn___init structure. In particular:

[~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
[110941] STRUCT 'nf_conn___init' size=248 vlen=1
[~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
net/netfilter/nf_nat.ko format raw | grep nf_conn__
[107488] STRUCT 'nf_conn___init' size=248 vlen=1

Is it the root cause of the problem?

Regards,
Lorenzo

>
> Anyone has any ideas what's going on here, and how to fix it?
>
> -Toke
>

