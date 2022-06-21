Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8210B553DD7
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 23:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353078AbiFUVeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 17:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351773AbiFUVeG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 17:34:06 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9E7BF4B
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 14:34:05 -0700 (PDT)
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 078007E0748_2B22A38B;
        Tue, 21 Jun 2022 20:29:44 +0000 (GMT)
Received: from mail.tu-berlin.de (mail.tu-berlin.de [141.23.12.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id E67417E4D9E_2B22A35F;
        Tue, 21 Jun 2022 20:29:41 +0000 (GMT)
Received: from [192.168.178.14] (89.12.46.118) by ex-05.svc.tu-berlin.de
 (10.150.18.9) with Microsoft SMTP Server id 15.2.986.22; Tue, 21 Jun 2022
 22:29:41 +0200
Message-ID: <2fb2e2f72f2bead11cf24f9ee2558e2f4169aec9.camel@mailbox.tu-berlin.de>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix rare segfault in
 sock_fields prog test
From:   =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jakub Sitnicki" <jakub@cloudflare.com>
Date:   Tue, 21 Jun 2022 22:29:40 +0200
In-Reply-To: <62b221f3886d0_16274208b@john.notmuch>
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
         <62b221f3886d0_16274208b@john.notmuch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=message-id:subject:from:to:cc:date:in-reply-to:references:content-type:mime-version:content-transfer-encoding; s=dkim-tub; bh=d+9JDkqTdfM5Axm6IFWFnnNswoTAtd+WZZ2tWv8gTvk=; b=iCKmFp2bqC5pWc/6yFU2mVVm95GtW0or1Q9wXncOwrCmdaRLo6yGBbdDTMdTd5ucw+N5gfRZnOstAeCVxrMCEZUJ+ky1PBFw/JDVgtZKHDJyw1+LcikLNLT7ZppNb4QbxTFYOF9oqEiaCypCu2Op7yulVlaZ0ih6AOimixcpYLw=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-06-21 at 12:54 -0700, John Fastabend wrote:
> Jörn-Thorben Hinz wrote:
> > test_sock_fields__detach() got called with a null pointer here when
> > one
> > of the CHECKs or ASSERTs up to the
> > test_sock_fields__open_and_load()
> > call resulted in a jump to the "done" label.
> > 
> > A skeletons *__detach() is not safe to call with a null pointer,
> > though.
> > This led to a segfault.
> > 
> > Go the easy route and only call test_sock_fields__destroy() which
> > is
> > null-pointer safe and includes detaching.
> > 
> > Came across this while looking[1] to introduce the usage of
> > bpf_tcp_helpers.h (included in progs/test_sock_fields.c) together
> > with
> > vmlinux.h.
> > 
> > [1]  
> > https://lore.kernel.org/bpf/629bc069dd807d7ac646f836e9dca28bbc1108e2.camel@mailbox.tu-berlin.de/
> > 
> > Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock
> > tests for dst_port loads")
> > Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/sock_fields.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > index 9d211b5c22c4..7d23166c77af 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > @@ -394,7 +394,6 @@ void serial_test_sock_fields(void)
> >         test();
> >  
> >  done:
> > -       test_sock_fields__detach(skel);
> >         test_sock_fields__destroy(skel);
> >         if (child_cg_fd >= 0)
> >                 close(child_cg_fd);
> > -- 
> > 2.30.2
> > 
> 
> But we should still call __detach(skel) after the !skel check
> is done I assume.
If I’m not mistaken, that’s not necessary for a proper clean-up. It
should be more of a stylistic question. See the parallel message from
Daniel (and replies).

test_sock_fields__detach() directly translates to
bpf_object__detach_skeleton(). test_sock_fields__destroy() basically
translates to bpf_object__destroy_skeleton(), including a null-ptr
check.

But bpf_object__destroy_skeleton() calls bpf_object__detach_skeleton()
as its first step. So calling __detach()/__detach_skeleton() explicitly
and separately is not necessary for a clean exit, if not otherwise
required.


> So rather than remove it should add a new label
> and jump to that,
> 
>   
>  done:
>    test_sock_fields__detach();
>  done_no_skel:
>    test_sock_fields__destroy()


