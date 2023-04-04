Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5552C6D6531
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjDDOYd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjDDOYd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 10:24:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29269133
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 07:24:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso36281193pjb.3
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680618271;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNZuRg/N2ODMPf6qZiDzBnc6ZPmoWk1zOlIRmq/DeWc=;
        b=IFJl+FyI+p8YfpeysC6QiNNjPyrb3h2w+si4yHa3ZyNIab0+gaRfeczubxE7Eka/ny
         6oKNKJLZiDgb00LrH4JkJKBie2ed2g9eocD3jUcy9zJTcxvNwWAjrfty4ANf/pRY+xl1
         rbdeUPGz4/WO4INKITRdWJ10x6fH5/gZNk17hhYx+3nONk+vYDdoMfDMB49vAPSPVujf
         ZiIyVgptGLIJwZL61tpimxf9cnK9/FsMSS+91o2ZELuT24Xl9AmX5vWtCqKzlJf8A7kz
         uLd7zxdAM/4wl7LDRBXLPi7eje73ZAIRITiVp0atdywN/xmU/E/xPHjtO2D3iJVlgEzD
         rvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618271;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNZuRg/N2ODMPf6qZiDzBnc6ZPmoWk1zOlIRmq/DeWc=;
        b=Kwme2Mx0evgxMzIQb6AU+o9rlqVvuOs6AdkMeGkbfdbdjU4lHyNK/YIskVzXCL7SHA
         m1lVnA4eZKDyph13C8FGS2TFjx5U/3jy8ur0s0u/KcA1lqzYu2AL8mgF2L74O2SzuP9t
         7wDUaFOfehsjbdKpeoVPbyWavYgAUBdXBIsccDXCcJzzzp26B3928F/KKM01ctctWBln
         oDK08Wg2imEcTJ8eKMU+5xeGWu7PjGTf0ELTA+q1P9KLSFpV20M+SQ0lTsf927UdUzVc
         hF8qMEaZsEPMZmvZeyfUtLhJB9lSu2ikWPB1h+Ed1bQjDl0UONOcn+Y1m0araVnZQCj8
         z3gQ==
X-Gm-Message-State: AAQBX9f2jN3pvm08NMBzrRq3EJg++FlB6p5rzSpM9+/heWv9TQV/wffV
        O8YLOc+oaGEMtp9gBtKJjhbbFoTi55wJbu0v8ag=
X-Google-Smtp-Source: AKy350a6Yyb5mwhOfH48sRpd1A460JPta5Zc4aVE033cALKsEErnThBasjrDBI/07FWdmo5E00ngow==
X-Received: by 2002:a17:90b:3e85:b0:23f:91cf:58e1 with SMTP id rj5-20020a17090b3e8500b0023f91cf58e1mr3251465pjb.7.1680618271067;
        Tue, 04 Apr 2023 07:24:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15? ([2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15])
        by smtp.gmail.com with ESMTPSA id s33-20020a17090a69a400b0023faa95f75csm11432759pjj.36.2023.04.04.07.24.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2023 07:24:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v5 bpf-next 7/7] selftests/bpf: Test bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <4f5913d0-8271-5676-569b-366fc6def385@linux.dev>
Date:   Tue, 4 Apr 2023 07:24:29 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FD5690E-3D1D-45A3-9B26-1A45D95B5B11@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-8-aditi.ghag@isovalent.com>
 <ZCXY6mOY8pPLhdBF@google.com>
 <869f0a0f-0f43-73fb-a361-76009a21b81d@linux.dev>
 <B7A26EB4-55F4-4FAB-B7A2-D7EC37E1E0DC@isovalent.com>
 <1cad9be4-6c72-0520-8b5b-f6f5222a581b@linux.dev>
 <144D865C-07D6-4665-85F8-A5AF511ED44A@isovalent.com>
 <4f5913d0-8271-5676-569b-366fc6def385@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 3, 2023, at 6:41 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 4/3/23 5:15 PM, Aditi Ghag wrote:
>>> On Apr 3, 2023, at 10:35 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>>=20
>>> On 4/3/23 8:55 AM, Aditi Ghag wrote:
>>>>> On Mar 31, 2023, at 3:32 PM, Martin KaFai Lau =
<martin.lau@linux.dev> wrote:
>>>>>=20
>>>>> On 3/30/23 11:46 AM, Stanislav Fomichev wrote:
>>>>>>> +void test_sock_destroy(void)
>>>>>>> +{
>>>>>>> +    struct sock_destroy_prog *skel;
>>>>>>> +    int cgroup_fd =3D 0;
>>>>>>> +
>>>>>>> +    skel =3D sock_destroy_prog__open_and_load();
>>>>>>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>>>>>>> +        return;
>>>>>>> +
>>>>>>> +    cgroup_fd =3D test__join_cgroup("/sock_destroy");
>>>>>=20
>>>>> Please run this test in its own netns also to avoid affecting =
other tests as much as possible.
>>>> Is it okay if I defer this nit to a follow-up patch? It's not =
conflicting with other tests at the moment.
>>>=20
>>> Is it sure it won't affect other tests when running in parallel =
(test -j)?
>>> This test is iterating all in the current netns and only checks for =
port before aborting.
>>>=20
>>> It is easy to add. eg. ~10 lines of codes can be borrowed from =
prog_tests/mptcp.c which has recently done the same in commit =
02d6a057c7be to run the test in its own netns to set a sysctl.
>> I haven't run the tests in parallel, but the tests are not using =
hard-coded ports anymore. Anyway I'm willing to run it in a separate =
netns as a follow-up for additional guards, but do you still think it's =
a blocker for this patch?
>=20
> Testing port is not good enough. It is only like ~10 lines of codes =
that can be borrowed from other existing tests that I mentioned earlier. =
What is the reason to cut corners here? The time spent in replying on =
this topic is more than enough to add the netns support. I don't want to =
spend time to figure out why other tests running in parallel become =
flaky while waiting for the follow up,
> so no.
>=20
> Please run the test in its own netns. All new network tests must run =
in its own netns.

Got it. I'll take care of the test.=20

>=20
> btw, since I don't hear any comment on patch 5 regarding to =
restricting the destroy kfunc to BPF_TRACE_ITER only. It is the major =
piece missing. I am putting some pseudo code that is more flexible than =
adding BTF_KFUNC_HOOK_TRACING_ITER that I mentioned earlier to see how =
it may look like. Will update that patch's thread soon.
>=20

Yes, this was the only open item for now. Thanks, I'll take a look at =
your RFC patch.



