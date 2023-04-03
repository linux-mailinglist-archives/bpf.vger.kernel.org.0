Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAC6D4CC9
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjDCP4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjDCP4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 11:56:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DCD359E
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 08:55:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso13976056pjc.1
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680537341;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uUjxQbfvRrJz9NqxouDKnb0rD2q3d3Q03uLKkkDEYA=;
        b=W2clW8kpZ0xGqZDHJmBYhW2C9FUB9OEvCuffLQZmV7gy39VnQQtDYHFchyaqVGKMH/
         9hZCbXpXx07HviRmK55Qk9CTa+rc0tEYyNAx8AshQn30v0eMWviLlDbYfPBDfCrSUFs6
         e47XO1yFI0BF/by/N3iyxiwphD7XL5q4mvOucoYFPRL3NVYSIeDjk1cGYlgGx5tVsCgL
         1lk5GDXW6WGUUtJTMyBmm07yoFLnKg8b8bsYtlyRSaOwZKL0gt2tBL8KihtDT9VeJLG0
         evFKz+W6ZPh/u9pucnwq7XHEfXonx5DuzasxuJyJLhs3wABQTg4YPfv+EECw+2AXOmLm
         1EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537341;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uUjxQbfvRrJz9NqxouDKnb0rD2q3d3Q03uLKkkDEYA=;
        b=xhqLuosskyIy1H3+S14g18tcFbZLSOK6OryeGejRksZiBZaaKCridFtjKIview7S3N
         Qy/GJXOehY3LtsmgaTN2JA9p3bF1dIRJ7FIVAXg0nsdr9C3Aon7sg0l9LVutsvkN1jwB
         l0AkMhffVW0k7vdFgOAd66i8c+mQOCDlx3Tz7wXFw32dxBmW0B/5ET+0tSh98bnzBwBH
         GXodRPDn436avuY3e1N4YTwPcJzinKTjcEDab435+7cokXYnC2wgRCkYiIs2qUm56MpF
         JsWYLd7JCEV3WvYsqZ+4FXvcYWiTL4wxujl32LifZeqiFURFKWxMo+HGi1tvdkglQM0p
         Rbcg==
X-Gm-Message-State: AAQBX9eHA+1zGvEZlOp22MGSyO+lVV4fVfWWiE8/mXQ2Hgs8xMU5Wc6Q
        8I7Q8sXXCIsMD1MuTfGl0wHK2w==
X-Google-Smtp-Source: AKy350YYJHqoYlEUYWazOm3efYlgVT6QODsA7nUSJTybxCgiGAqMLNC0I5bEKqyPIUrqpGutGOazuQ==
X-Received: by 2002:a17:902:f785:b0:19e:b38c:860b with SMTP id q5-20020a170902f78500b0019eb38c860bmr41255632pln.24.1680537340668;
        Mon, 03 Apr 2023 08:55:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15? ([2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15])
        by smtp.gmail.com with ESMTPSA id az6-20020a170902a58600b001a1deff606fsm6773564plb.125.2023.04.03.08.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:55:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v5 bpf-next 7/7] selftests/bpf: Test bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <869f0a0f-0f43-73fb-a361-76009a21b81d@linux.dev>
Date:   Mon, 3 Apr 2023 08:55:39 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7A26EB4-55F4-4FAB-B7A2-D7EC37E1E0DC@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-8-aditi.ghag@isovalent.com>
 <ZCXY6mOY8pPLhdBF@google.com>
 <869f0a0f-0f43-73fb-a361-76009a21b81d@linux.dev>
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



> On Mar 31, 2023, at 3:32 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/30/23 11:46 AM, Stanislav Fomichev wrote:
>>> +void test_sock_destroy(void)
>>> +{
>>> +    struct sock_destroy_prog *skel;
>>> +    int cgroup_fd =3D 0;
>>> +
>>> +    skel =3D sock_destroy_prog__open_and_load();
>>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>>> +        return;
>>> +
>>> +    cgroup_fd =3D test__join_cgroup("/sock_destroy");
>=20
> Please run this test in its own netns also to avoid affecting other =
tests as much as possible.

Is it okay if I defer this nit to a follow-up patch? It's not =
conflicting with other tests at the moment.=20

>=20
>>> +    if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
>>> +        goto close_cgroup_fd;
>>> +
>>> +    skel->links.sock_connect =3D bpf_program__attach_cgroup(
>>> +        skel->progs.sock_connect, cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
>>> +        goto close_cgroup_fd;
>>> +
>>> +    if (test__start_subtest("tcp_client"))
>>> +        test_tcp_client(skel);
>>> +    if (test__start_subtest("tcp_server"))
>>> +        test_tcp_server(skel);
>>> +    if (test__start_subtest("udp_client"))
>>> +        test_udp_client(skel);
>>> +    if (test__start_subtest("udp_server"))
>>> +        test_udp_server(skel);
>>> +
>>> +
>>> +close_cgroup_fd:
>>> +    close(cgroup_fd);
>>> +    sock_destroy_prog__destroy(skel);
>>> +}
>=20

