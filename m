Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91794554258
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 07:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356755AbiFVFt4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 01:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiFVFtz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 01:49:55 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565ED36684
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 22:49:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m13so8375ioj.0
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2sdRNIBMp4J/ke5PtfOoBPyrVOzTH8p4f5BZNj8JRjk=;
        b=WFFHhuIFX4YbQUFUVYK9yQV7NS+em6h1ycvbAPSFz2PLrGNP8ZQeOXezCJG6xXOJ7x
         +Ngy+jrZcDhjSVu+xZ9YvyrLtvGK/l/8FSas3SQjm27qkg4+wN9WZoUJA2SDI4jeWFS7
         l+FHjeX53xWyIsUAWzIbQ0JAWi9+dKzseHQC0G5qFKUMHzsBvp1CJvOdlo4ZMV6AxvsM
         lTiGnBsqoUWNVakxghyRV4PoDkDPr1sMAi32Z7K3vgvSEu0arM5gEdRxdFM0fjW/fztn
         9Tqh9HugAtFrJ0Umvryo5XLClK65JCdryjUj/wW7bqlQgyYGPUGtelvp431a/0tLfHVh
         Pk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2sdRNIBMp4J/ke5PtfOoBPyrVOzTH8p4f5BZNj8JRjk=;
        b=A1X39RSsuZB/0Opt+nRlP4S8bTHubLQ8eDF2A2DsE4uhEn3kR1sN9AQoz2bg5gE5T4
         T5F411yD1O06XQvlaA1qeR31ZvWIHwxLsEL95l8k3q7qi0xrlESNogujb7tybrgGG9ee
         KjcqsGZns4AwGQ3HWJelU4tSGhvBiPO29AbNStVCVmkVlA8zkJhsuutA/RH2L8wWoxvM
         AUhqUhkiORjxQXpRKyWluoJQe53lxN2FtAINkMiJbpVVgj9wQs4mp3tEH1ooLjRcMXew
         nb0PQ+fjSY1112XmUow0mVvs6LJUA4fcaVqpu/cUpvS+5wFWMogoJYWSdsiLvoR4TRGr
         01sw==
X-Gm-Message-State: AJIora/nAY4xuVrEWDeDDrVwjbc6bHjrv20UDX0/Ljehh0Z6LJu17jQ1
        xu/co1AwFyyy588VK7NV20TpZroC6z+lVw==
X-Google-Smtp-Source: AGRyM1s1NaeMz6K4oOtotth03qL8uhjCqHswSiiWklaDmURYVVc79mmHpGdgUOmKiXi1RJErwf62UA==
X-Received: by 2002:a6b:3115:0:b0:660:d5f1:e3b6 with SMTP id j21-20020a6b3115000000b00660d5f1e3b6mr987668ioa.99.1655876993674;
        Tue, 21 Jun 2022 22:49:53 -0700 (PDT)
Received: from localhost ([172.243.153.43])
        by smtp.gmail.com with ESMTPSA id b44-20020a0295af000000b0032b3a7817a7sm8089711jai.107.2022.06.21.22.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 22:49:52 -0700 (PDT)
Date:   Tue, 21 Jun 2022 22:49:46 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Message-ID: <62b2ad7a21e88_34dc820812@john.notmuch>
In-Reply-To: <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
 <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau wrote:
> On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:
> > > Hashmap Control
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >         num keys: 10
> > > hashmap (control) sequential    get:  hits throughput: 20.900 =C2=B1=
 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput: 20=
.900 =C2=B1 0.334 M ops/s
> > > =

> > >         num keys: 1000
> > > hashmap (control) sequential    get:  hits throughput: 13.758 =C2=B1=
 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput: 13=
.758 =C2=B1 0.219 M ops/s
> > > =

> > >         num keys: 10000
> > > hashmap (control) sequential    get:  hits throughput: 6.995 =C2=B1=
 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughput: 6=
.995 =C2=B1 0.034 M ops/s
> > > =

> > >         num keys: 100000
> > > hashmap (control) sequential    get:  hits throughput: 4.452 =C2=B1=
 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughput: 4=
.452 =C2=B1 0.371 M ops/s
> > > =

> > >         num keys: 4194304
> > > hashmap (control) sequential    get:  hits throughput: 3.043 =C2=B1=
 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughput: 3=
.043 =C2=B1 0.033 M ops/s
> > > =

> > =

> > Why is the hashmap lookup not constant with the number of keys? It lo=
oks
> > like its prepopulated without collisions so I wouldn't expect any
> > extra ops on the lookup side after looking at the code quickly.
> It may be due to the cpu-cache misses as the map grows.

Maybe but, values are just ints so even 1k * 4B =3D 4kB should be
inside an otherwise unused server class system. Would be more
believable (to me at least) if the drop off happened at 100k or
more.=
