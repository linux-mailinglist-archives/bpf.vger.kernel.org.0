Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF66D5578
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 02:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjDDAPj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 20:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjDDAPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 20:15:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2578AB
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 17:15:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw3so29707404plb.6
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 17:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680567337;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekZZIh+rNpTNF8a/NWCFYWgcutUyzgierucHLkJ0Y9Y=;
        b=GowUsZORlpYV4hLbybd+WlAAZ+HpxiHHPnUxaQgw8aLwf4FD1+JzXdhOPmi9ZOndz6
         lTg9Yb3T+Otkln7nnbEKO8rHuUOrneI6lgDga7OA6wP2jtUqiatP/Bu7qwfnUwGg+Avf
         ZUK0JfOj0gFjzDdjef8afR3scW39HKORhf2lhpwtUUmDGrSTw4cbReFMeEsj4ne95pdv
         cEG7ZPEjgberyhdA5wEC7Gnic7+r8/HDs4uhg8/XKF3H9qaBL+pakhVOOzXyF2yGaer9
         GhwWtU5kMFomeBuD6vkpFkTqsepcJNySdK5RPQzqP2nKmdosWjWnhNt5TkPQcxcZ6Nbw
         OOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680567337;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekZZIh+rNpTNF8a/NWCFYWgcutUyzgierucHLkJ0Y9Y=;
        b=qdfWjfYaSVOr4MmJmstRERfPNiSt2Ozm5P9VHaenZoGpW1xnU59HcvAkjVkfo2neph
         422xGaKLWZ5FgyCv6J0iDMurK8PpFHNDHVO1WpVA6/baxpiTcAz0odVVMK/PJITAEYV/
         1I1qNsFqIIwYLqqMgQHhR00i55mwSVcbrSRluDQLv1KqO8iAnfJyYyAvpyBmRZfLhh+i
         FKJvMPQSo9vuzVQ/FnVhfNubWrfatbBOIH4wMX7petkhgNjBYgaZFyu+xf/Tr3zYnUeg
         imwn83wc8eIZBt+Adovpq2HDyeIxIz2SZmC4Cn+JHIwTPBU78N7jsN69Db8FWWlbTCkD
         us3g==
X-Gm-Message-State: AAQBX9ch2iyAF8I0Sz14TbtSG1NummjMqGqo426YoDl4Znp1p8EKMyS5
        HEnVHPaFr4eS5qn2axlph4xUTA==
X-Google-Smtp-Source: AKy350Z/mS8L9IjDgoiVWr4MRFgKUG/Vb2kVbFO7kt20kcp38xs724RRHxKVidcbUJIJi6gYEhtEow==
X-Received: by 2002:a17:903:1c7:b0:19c:e842:a9e0 with SMTP id e7-20020a17090301c700b0019ce842a9e0mr897236plh.16.1680567337096;
        Mon, 03 Apr 2023 17:15:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15? ([2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001a064282ce5sm7151534pll.294.2023.04.03.17.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2023 17:15:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v5 bpf-next 7/7] selftests/bpf: Test bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <1cad9be4-6c72-0520-8b5b-f6f5222a581b@linux.dev>
Date:   Mon, 3 Apr 2023 17:15:35 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <144D865C-07D6-4665-85F8-A5AF511ED44A@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-8-aditi.ghag@isovalent.com>
 <ZCXY6mOY8pPLhdBF@google.com>
 <869f0a0f-0f43-73fb-a361-76009a21b81d@linux.dev>
 <B7A26EB4-55F4-4FAB-B7A2-D7EC37E1E0DC@isovalent.com>
 <1cad9be4-6c72-0520-8b5b-f6f5222a581b@linux.dev>
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



> On Apr 3, 2023, at 10:35 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 4/3/23 8:55 AM, Aditi Ghag wrote:
>>> On Mar 31, 2023, at 3:32 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>>=20
>>> On 3/30/23 11:46 AM, Stanislav Fomichev wrote:
>>>>> +void test_sock_destroy(void)
>>>>> +{
>>>>> +    struct sock_destroy_prog *skel;
>>>>> +    int cgroup_fd =3D 0;
>>>>> +
>>>>> +    skel =3D sock_destroy_prog__open_and_load();
>>>>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>>>>> +        return;
>>>>> +
>>>>> +    cgroup_fd =3D test__join_cgroup("/sock_destroy");
>>>=20
>>> Please run this test in its own netns also to avoid affecting other =
tests as much as possible.
>> Is it okay if I defer this nit to a follow-up patch? It's not =
conflicting with other tests at the moment.
>=20
> Is it sure it won't affect other tests when running in parallel (test =
-j)?
> This test is iterating all in the current netns and only checks for =
port before aborting.
>=20
> It is easy to add. eg. ~10 lines of codes can be borrowed from =
prog_tests/mptcp.c which has recently done the same in commit =
02d6a057c7be to run the test in its own netns to set a sysctl.

I haven't run the tests in parallel, but the tests are not using =
hard-coded ports anymore. Anyway I'm willing to run it in a separate =
netns as a follow-up for additional guards, but do you still think it's =
a blocker for this patch?=
