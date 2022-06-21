Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCD553975
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiFUSUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiFUSU3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 14:20:29 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895F62315B
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 11:20:26 -0700 (PDT)
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 96F397DDD72_2B20BE7B;
        Tue, 21 Jun 2022 18:20:23 +0000 (GMT)
Received: from mail.tu-berlin.de (bulkmail.tu-berlin.de [141.23.12.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 2DE827DDB90_2B20BE7F;
        Tue, 21 Jun 2022 18:20:23 +0000 (GMT)
Received: from [192.168.178.14] (89.12.46.118) by ex-04.svc.tu-berlin.de
 (10.150.18.8) with Microsoft SMTP Server id 15.2.986.22; Tue, 21 Jun 2022
 20:20:22 +0200
Message-ID: <b3df1eba7e84a0d938aa42fead201e34b09c7117.camel@mailbox.tu-berlin.de>
Subject: Re: [External] Re: [PATCH bpf-next] selftests/bpf: Fix rare
 segfault in sock_fields prog test
From:   =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
Date:   Tue, 21 Jun 2022 20:20:21 +0200
In-Reply-To: <6f2b2c24-22e8-9fbe-10d3-9347be3ac067@iogearbox.net>
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
         <6f2b2c24-22e8-9fbe-10d3-9347be3ac067@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=message-id:subject:from:to:cc:date:in-reply-to:references:content-type:mime-version:content-transfer-encoding; s=dkim-tub; bh=ZNWN3BLqjBnOglDLw//zswy72YJIW20GwtVBwB8lSpM=; b=f5DpiC2vA6kA3zupnCBADElc1H+e6/JE8Iuic8MElcurUlN3G7yChZqQZWcqENTfcT+32UTs/5FcrK00le8SipdSVEGf97RfREd8atrNgKZVax+x9VQngXyz59PZNHZQ9FiUEHiIOgVlq6RWifrZDUz837R4RF31+ktWt1o2BGc=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-06-21 at 19:00 +0200, Daniel Borkmann wrote:
> On 6/21/22 9:01 AM, Jörn-Thorben Hinz wrote:
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
> >   tools/testing/selftests/bpf/prog_tests/sock_fields.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > index 9d211b5c22c4..7d23166c77af 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> > @@ -394,7 +394,6 @@ void serial_test_sock_fields(void)
> >         test();
> >   
> >   done:
> > -       test_sock_fields__detach(skel);
> >         test_sock_fields__destroy(skel);
> >         if (child_cg_fd >= 0)
> >                 close(child_cg_fd);
> > 
> 
> Great catch! I think we have similar detach & destroy pattern in a
> number
> of places in selftests.
Did a quick grep for other __detach(skel) calls yesterday. I didn’t
find similar places that were too obviously problematic.

> 
> Should we rather just move the label, like:
Sure, if you would prefer that? Let me know.

Since this test—unlike others—does not attach the skel twice (like
prog_tests/test_lsm.c), or reads/asserts values from the skel’s data
sections between detach and destroy (like prog_tests/timer.c), my
thought was to just let __destroy() do all the clean-up.

> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> index 9d211b5c22c4..e8a947241e37 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> @@ -393,8 +393,8 @@ void serial_test_sock_fields(void)
> 
>          test();
> 
> -done:
>          test_sock_fields__detach(skel);
> +done:
>          test_sock_fields__destroy(skel);
>          if (child_cg_fd >= 0)
>                  close(child_cg_fd);


