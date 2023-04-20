Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31496E8D6B
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjDTJBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjDTJAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 05:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6474C2B
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681980941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2mMMelpgwahvMECUAYjnWd3nnN8ZP+8v+5/bEntprQ=;
        b=LR4QFjWD9Fnnxx2IV/KfeFfj9l7FLmp/kDmj305wF+l42XVSnyfV8QJnMFk7rjs1X7Rpxp
        vWCy3PpUFZUzpz+LcJtymCp7sZ3h1ln1aOwqrlZsWXH4w8/1YWQKtV8r7cKPEDjNRNuv65
        h2YwzyZUQk4Ht7sb4T9U2YwexkjdqyE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-zxCxu12PNDuaPLqMPPfOXw-1; Thu, 20 Apr 2023 04:55:40 -0400
X-MC-Unique: zxCxu12PNDuaPLqMPPfOXw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74deffa28efso13798185a.1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 01:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980939; x=1684572939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2mMMelpgwahvMECUAYjnWd3nnN8ZP+8v+5/bEntprQ=;
        b=JCetRLhDZDIoed53rmE4q29Ht9/nCSh+MK7TtiEpwbEiGdjkbt+K3zwQFB2AshRgf3
         b9IXCSdSXF5W41v8I1ZSE6yLuH/+zEVsJ1miZteoDl+DkMsxYKNLVWpXNc8OOnxo2f8K
         fkDBUgpRCOAGaI+DWuoQk8iIMsFEkPIa/m6VELqYqe0x/iOW5mLTB9EekixThZ/zUzHq
         kBdIem6udfA/aUYQQeWnjH/0XbWVzHsr4xxTkuluyLN2Qqc768u7yWKaJG1dfOI4rvTi
         2qT3yhqcaC/+yR0DI3nGkCyqZ9ElLV8v6K28uB4aCZmM1HwgSHUZHPtAiEKCByxobb5r
         i02Q==
X-Gm-Message-State: AAQBX9eA51WST9BXN1hlEbptK2iWUFR2rj+3M8VC0LpAgTGMSl4m0QEZ
        wuikLnqr45Me8yIbRwwzcdJZh+7C7GSHdHP7IF4vQwZYYZsByw4hmfwMISm873Jl+1bbyWMYngq
        ozjj+eLg2ywEjAzBJZkl7
X-Received: by 2002:a05:6214:400a:b0:5ef:55d8:7164 with SMTP id kd10-20020a056214400a00b005ef55d87164mr698029qvb.5.1681980939465;
        Thu, 20 Apr 2023 01:55:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ai/EpN2Ey0LrHJhW+cnXFiDuAwKWRwD0JOH8D/lgvKVLvQQQkN3cBsrxdb2cR/iPGtTb5lgg==
X-Received: by 2002:a05:6214:400a:b0:5ef:55d8:7164 with SMTP id kd10-20020a056214400a00b005ef55d87164mr698015qvb.5.1681980939153;
        Thu, 20 Apr 2023 01:55:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-117.dyn.eolo.it. [146.241.230.117])
        by smtp.gmail.com with ESMTPSA id f7-20020a0cf3c7000000b005ef5ba49adesm282840qvm.57.2023.04.20.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:55:38 -0700 (PDT)
Message-ID: <eab6796c7280065c18d042e8c8a5d2ecd6b28527.camel@redhat.com>
Subject: Re: [PATCH 1/7] bpf: tcp: Avoid taking fast sock lock in iterator
From:   Paolo Abeni <pabeni@redhat.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com
Date:   Thu, 20 Apr 2023 10:55:36 +0200
In-Reply-To: <20230418153148.2231644-2-aditi.ghag@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
         <20230418153148.2231644-2-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Tue, 2023-04-18 at 15:31 +0000, Aditi Ghag wrote:
> Previously, BPF TCP iterator was acquiring fast version of sock lock that
> disables the BH. This introduced a circular dependency with code paths th=
at
> later acquire sockets hash table bucket lock.
> Replace the fast version of sock lock with slow that faciliates BPF
> programs executed from the iterator to destroy TCP listening sockets
> using the bpf_sock_destroy kfunc (implemened in follow-up commits).
>=20
> Here is a stack trace that motivated this change:
>=20
> ```
> 1) sock_lock with BH disabled + bucket lock
>=20
> lock_acquire+0xcd/0x330
> _raw_spin_lock_bh+0x38/0x50
> inet_unhash+0x96/0xd0
> tcp_set_state+0x6a/0x210
> tcp_abort+0x12b/0x230
> bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
> bpf_iter_run_prog+0x1ff/0x340
> bpf_iter_tcp_seq_show+0xca/0x190
> bpf_seq_read+0x177/0x450
> vfs_read+0xc6/0x300
> ksys_read+0x69/0xf0
> do_syscall_64+0x3c/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> 2) sock lock with BH enable
>=20
> [    1.499968]   lock_acquire+0xcd/0x330
> [    1.500316]   _raw_spin_lock+0x33/0x40

The above is quite confusing to me, here BH are disabled as well
(otherwise the whole softirq processing would be really broken)

Thanks,

Paolo

