Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6403040C72C
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 16:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhIOOPq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhIOOPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 10:15:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530FC061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 07:14:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq5so6335726lfb.9
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZZVRkAFkj/fWY1PgjO3Ba5nWvOEjUGewQ8VLp8hNK8=;
        b=UaOgEatDivmfJAoEz+JgGNG0dgC5Y+GayX04BUVdN9JUTj1/YiTcizMcT1kfuEhYw+
         Wv6aoNGyPjD/z5VHbbUHjYHcS6L/dExxe9ijicgu5zVbJaeU2dE/GMFSeDyAI3appiq4
         mPOMEh6k4l9NcZ52dXIwUaQ10b1XS6aLO/wszIF0cSQYraTPt+OerAochDoMuUDbY5Jb
         d6wYrezKnLxB986SQsekxM+P0d120F6T8YookZJv0bFvGG8/FESvehGvd69oTzfufoiN
         MGfQZh91JRoVGYk0uB04NNci/qGYDK+yU3peAeuO7F5b7mrUNN79/NvlyZmdaLiI85dm
         TMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZZVRkAFkj/fWY1PgjO3Ba5nWvOEjUGewQ8VLp8hNK8=;
        b=TflE6G9yXCcc2Gji8hDEVMzlujkRGcZGvyFGVDCBOtRrkLhtbhSE62WtK3tjZkC1EB
         8SadJMU+lKcgBKq8Jbco2upT7y9PT7TO9fUYmZce3cz9HlqExoaGwiDuPRj99iwQ7w4h
         KTDriuH4qgW2WgYesrfbcvSDjpV/YcwWd4+ubXuFkKMSjvojePFAD+CAcaasRvDyV1am
         5E4JNvaP8/OHChqpUlklPR2poi9rjGes2yvV2E34vKutvoDdevlAHRthGZXPqW+MAdlS
         KTdSZJN9vVly5mbEUSGEjPz46WWNscCKnCfKt3kxg9grRiSbADyeyRv8vEw20LtAkpwH
         z8CA==
X-Gm-Message-State: AOAM532mKIKB+pbqVkmGYnMjXcCsY5lBRcN3cooiGIhevbxHfkfLyRml
        cnfzk6MI4J7f4G4k3/WSnWgF075Qp5If6mtQkNk=
X-Google-Smtp-Source: ABdhPJwt7w7/p2ard+npT+kWaZFHVTzZa8rVpkFBVzvk7Z9BJlU50F3lwKwp/oAkggk0GOCbSfhuzcN8HBN5KzHZCa8=
X-Received: by 2002:ac2:4297:: with SMTP id m23mr88002lfh.487.1631715261490;
 Wed, 15 Sep 2021 07:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
 <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com>
 <CAM_iQpUG30QL03Uh9D_ACy_29TLWG+YfDO9_GvcqzW2f0TbpYw@mail.gmail.com>
 <CAJygYd2f8S5Oq_B8724p-3rQvXaJKMBGgBKLS_0R7fxTew2oeA@mail.gmail.com>
 <CAM_iQpWt8F18_B5b9cYyT7Ri3sua2T2B5ztEGg2h3v9u2-i+Fg@mail.gmail.com> <CAJygYd2uJNEvX4MWruAZ2a3uJ2HJbnoCmMkuS2fFY59S6x=Sww@mail.gmail.com>
In-Reply-To: <CAJygYd2uJNEvX4MWruAZ2a3uJ2HJbnoCmMkuS2fFY59S6x=Sww@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Wed, 15 Sep 2021 10:13:55 -0400
Message-ID: <CAJygYd0vk-Caef1yvghz7qj7X42gkHvMtLcd1dZaoOypeMgnmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Cong,

want to make sure this doesn't fall through, any thoughts on this?

Cheers.
