Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAAA625CEA
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 15:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiKKOYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 09:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiKKOXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 09:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B73391DB
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668176499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DWk2wYjfyzgUw3+4qFM460g9MsNDyCaBYT71FTjT/zk=;
        b=G7bDH9658+sYkDh1W9KPXBgcZXrE16jjDUgTDzcdP98h6Fe0RbaqhBzrccvYhYLzJS4rQW
        oZm13ivOIbVfJ6Mss3v9vG3cmC3ULiouYxrALuAd0m2ASYuVy9V97bjA9ADzfuzz6LErZN
        Ew7/ILyps53n9Srug7UztLmaf7eY0Io=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-ckY-CDIxNxeIDqNH2Xuf9A-1; Fri, 11 Nov 2022 09:21:38 -0500
X-MC-Unique: ckY-CDIxNxeIDqNH2Xuf9A-1
Received: by mail-ed1-f72.google.com with SMTP id t4-20020a056402524400b004620845ba7bso3688584edd.4
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 06:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWk2wYjfyzgUw3+4qFM460g9MsNDyCaBYT71FTjT/zk=;
        b=SttW8vukodBq3iWO3FXKKAKTaqPTRAz7m2275aUDMgvJ/FkNws5Lo079tj3DBXLJir
         rS3zgpqwcBMiazHnZUKRmM745qQ7jsr0UaOCyJmNOPpf3qj080I0CXG40bx1zNvixPSJ
         igAZtVp7RTwQ2WIAUIKV82T/Jq9GYzu8fBZaRt3JAWA3OIU33ZTeZnfE0fPo0dfsuQ2q
         zvBH6Uk7Dwquj639FTyPUrh8Ci8ItCuQBGdbDRnRBHYdw/ku2IIAm49iqh0NSqBRog8h
         dyGxGHNyaD2GLLp0ivfzxAxKOL1hLku2AxPb4gO4G7Yes8GFfOdo3qP3DFHovoYBAuCU
         gdww==
X-Gm-Message-State: ANoB5plh8pTkx0bFrkt8wCm0zJkIC4/4s9ZouOS4OKStKpH2aoIzIW/h
        W+HJOy1ZdoTx0YmDY0eIcB7J6tofd28Js284w8L4e3ZwUynyguMcC7gLm2YSrL8fKOzc78NZ+nd
        aFz0FNRvafYFp
X-Received: by 2002:aa7:c6d5:0:b0:461:2915:e41d with SMTP id b21-20020aa7c6d5000000b004612915e41dmr1623212eds.184.1668176495417;
        Fri, 11 Nov 2022 06:21:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5W3PWc0FcHrFEjV9papKFAiHrHcoJ8oOvcuGJnwpavihPqimYpAIfeJa6Pfk/FQ0VKgdyqnQ==
X-Received: by 2002:aa7:c6d5:0:b0:461:2915:e41d with SMTP id b21-20020aa7c6d5000000b004612915e41dmr1623092eds.184.1668176493406;
        Fri, 11 Nov 2022 06:21:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b007adf125cde4sm966375ejc.13.2022.11.11.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:21:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C19E47A692C; Fri, 11 Nov 2022 15:21:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lbiancon@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>
Subject: Calling kfuncs in modules - BTF mismatch?
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Nov 2022 15:21:31 +0100
Message-ID: <87leoh372s.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone

There seems to be some issue with BTF mismatch when trying to run the
bpf_ct_set_nat_info() kfunc from a module. I was under the impression
that this is supposed to work, so is there some kind of BTF dedup issue
here or something?

Steps to reproduce:

1. Compile kernel with nf_conntrack built-in and run selftests;
   './test_progs -a bpf_nf' works

2. Change the kernel config so nf_conntrack is build as a module

3. Start the test kernel and manually modprobe nf_conntrack and nf_nat

4. Run ./test_progs -a bpf_nf; this now fails with an error like:

kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT nf_conn___init but R1 has a pointer to STRUCT nf_conn___init

Anyone has any ideas what's going on here, and how to fix it?

-Toke

