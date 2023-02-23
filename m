Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092C56A0E86
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 18:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBWRSM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBWRSL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 12:18:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1F15568
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 09:18:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d30so3534676eda.4
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=au5jpcCTAduRMEcpXj6Uru6Xd2+yhTvXIaB5P6uB/NY=;
        b=T8yd1ig5UiMXuThDAsXVg1a5T+gPf+k5DfpCZCwCHCuLRJK5qkQ6WOi1x0m2Wem5wk
         1MUw1sPb+hmy2xYgiyd+g97wxBLPU9x3N6vxAk/q+pzKDWDGSHCr+R+FCFu74dxU6gPD
         z2ukrmN6Lu7ZhZHGsiD7MFPwlPcjyGV3L+fcGdNKNjxTl+KU53/5y4XHvfPpL8Ivas6F
         1avhJd4bs8hTctRu9P9V+Jw7rLc49YTztYMvqsro4z5+ot/waWJE9rtkoRYV85isTJQJ
         ZTFZ4S1BmuS2cxxuCxP9Gv/GIHoWsSk2IMhw3f/4MTxouLkkpXVPFEnbvd8Eft/VtrFn
         r3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au5jpcCTAduRMEcpXj6Uru6Xd2+yhTvXIaB5P6uB/NY=;
        b=30vPeFPUotHKsM29pddGhLtTb2SPpU/QF5wO6MN19PzNp+hCOdxqLw+5lbj2lMmOUw
         dBdS6d0twg8MM6WQvgp4yUdHvjFh35TPLSo6V3A80uHjDwmSRmzzXKh3ome7HyhBYnsy
         7/gL1Wu2q/nlbc4ncrQIhZGqigWKlpuMUusUKFloeV+SEUwBDHJIG/fdw7jfYCQmu/Gw
         dVshIsbDUaTG3crSbUNFXt8BbMqdPTSU8wG6k+osiZflxI6IR7UjcbBKGUvleWGfnz62
         CyO9By7Qbw8Llg/UVhfP+XX/gzxJf6/ReoOk/UCHm1mui+j5eJ/Z6ZCe+QAXGrLqwG3B
         Q90w==
X-Gm-Message-State: AO0yUKVXsD47QE0GQqLylUEU7zUojxNUrnbQ29pQRsuyWl5XASwVYN5B
        B9gg+iLNLctLsNrgOb2zuFg+h9omUdjW8ieipqyUgItM
X-Google-Smtp-Source: AK7set/u9Fo7GsaiCSV/RHSS4IVl0yV0vY6r1vxNLHluaOtLvH2CDsGG2EtGaVX0gHyIjFFbbJLrhxIS3gfoCp0dUu0=
X-Received: by 2002:a50:d51d:0:b0:4ac:b618:7fb1 with SMTP id
 u29-20020a50d51d000000b004acb6187fb1mr5681177edi.6.1677172686939; Thu, 23 Feb
 2023 09:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20230222223714.80671-1-iii@linux.ibm.com>
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 23 Feb 2023 09:17:55 -0800
Message-ID: <CAADnVQ+c_+sCXgb63_Kqp8Qb_0cMDcHXrDsbtoP60LiWerWpkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/12] bpf: Support 64-bit pointers to kfuncs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 2:37 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> v2: https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/
> v2 -> v3: Drop BPF_HELPER_CALL (Alexei).
>           Drop the merged check_subprogs() cleanup.
>           Adjust arm, sparc and i386 JITs.
>           Fix a few portability issues in test_verifier.
>           Fix a few sparc64 issues.
>           Trim s390x denylist.

I don't think it's a good idea to change a bunch of JITs
that you cannot test just to address the s390 issue.
Please figure out an approach that none of the JITs need changes.
