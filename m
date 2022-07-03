Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C45648D8
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiGCRrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCRrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 13:47:05 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD0C5587;
        Sun,  3 Jul 2022 10:47:04 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-fe023ab520so10318135fac.10;
        Sun, 03 Jul 2022 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=jcDULdfwj57RqmfboKaVRHoy92XsNiPDdj230BX3SXM=;
        b=F547fVI/SUbdG2s1x4Jq1gDFvisVCNF32MqWJcCk/7Xi0vtOenrZ9UYB1xThBQEqb3
         VYr7y0Bp2dylwGK1mcfv84LhCrtny57e7qveYjuY7SC7A4cr1ygaD3Mg4SF8SL8YhCI3
         6PT5G4Kji0VQWeK9x+lsZNuoQHu8IP/85ZvtwYib2e2jHiawumsUQ64mkj5jH7hl/sdg
         g3C2jvjJl3bvTBCjUQ0ACtr308CNmPBsY8MGL0BV1DRhHBMTvjmyBqMUwYNdIiH0Ue24
         HUFMQK1YsnFL7xmIGQDPVmD/SgB10OdnZfVbP2YHzAQXno9pQ2rIsLDB7QrvQXr4BFKq
         R23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=jcDULdfwj57RqmfboKaVRHoy92XsNiPDdj230BX3SXM=;
        b=gTqwNqoMJGi0cCqHMP99qcsCQJCs3atgTEPuLDJBr0WTc7bmxxmDrBD7rVBQOUvYA/
         rvIyTRH0J2Zuz3hSZFVT/6r1t9Ot31es9c2orjUK3F0dsSbfvxZCuaSzvSBp7iZRVlWc
         8J8bK0ICSfR7RzV7ii32KvYQJjOJFZw99ivG2o01xjDLuWo+ILBQQ6OlFjG3bIAKB55+
         uYQcX52mwj7ev40W8LDeqaaaUbW61SvUcoQH70h5XUb+ds1eEdmd4/9XXHCKNHZGqvXO
         HK4U0telks5DmoIJz3ui74fuaX6L2ouzWJF1QNMleeDgVXfZo+eZFrmwdo35ziKGkh0U
         nT8A==
X-Gm-Message-State: AJIora/AGADJX1joRtYF1wYhTmqQiJK6Z0vO+0v33jz0YtOIG/zNr1J4
        R3I906yh6048fAYjJ46K8FtmZ1ZsMcI=
X-Google-Smtp-Source: AGRyM1tIN4j02Xkct2mDNk+YL9s0Zo2E8nu5GMBa5iZ48ivg5Fcvd8rpYyKU5t7bQCPZ9qkbiDyDqg==
X-Received: by 2002:a05:6870:59d:b0:f3:627:e2b0 with SMTP id m29-20020a056870059d00b000f30627e2b0mr14665776oap.47.1656870424247;
        Sun, 03 Jul 2022 10:47:04 -0700 (PDT)
Received: from [127.0.0.1] (user.186-235-147-70.acesso10.net.br. [186.235.147.70])
        by smtp.gmail.com with ESMTPSA id t6-20020a056870f20600b000f33ff285d8sm10381046oao.31.2022.07.03.10.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 10:47:02 -0700 (PDT)
Date:   Sun, 03 Jul 2022 14:46:56 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Andres Freund <andres@anarazel.de>
CC:     sedat.dilek@gmail.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bperf-tools=5D_Build-error_in_too?= =?US-ASCII?Q?ls/perf/util/annotate=2Ec_with_LLVM-14?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220703165448.7d2akxawzdvqigat@awork3.anarazel.de>
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com> <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com> <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com> <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com> <1496A989-23D2-474D-B941-BA2D74761A7E@gmail.com> <20220703165448.7d2akxawzdvqigat@awork3.anarazel.de>
Message-ID: <F7CCD284-0DEF-444F-B58F-930678EC2644@gmail.com>
MIME-Version: 1.0
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



On July 3, 2022 1:54:48 PM GMT-03:00, Andres Freund <andres@anarazel=2Ede>=
 wrote:
>Hi,
>
>On 2022-07-03 10:54:45 -0300, Arnaldo Carvalho de Melo wrote:
>> That series should be split a bit further, so that the
>> new features test is in a separate patch, i=2Ee=2E I don't process bpft=
ool patches, but can process the feature test and the tools/perf part=2E
>
>Ok, will split it further=2E Should I do
>
>1) feature test
>2) introduce compat header header
>3) use feature test, use header in perf/
>4) use feature test, use header in bpf/
>
>Or should 3, 4 be split to separately introduce the feature test and use =
of
>the compat header?

I think 4 patches are ok,=20

- Arnaldo

>
>Greetings,
>
>Andres Freund
