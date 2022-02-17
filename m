Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE954BA8E4
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 19:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiBQS4B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 13:56:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiBQS4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 13:56:00 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1FC58399
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 10:55:45 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e17so853122ljk.5
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vu8A5HA8xXgQWRXtk0eL/iZTbM1NfHkZSIXuMCdz2kg=;
        b=QIAR+MdCpchUk8HUvFVhdqYIRatBHpoLnwR9LxpWFxk+NfR/kMYr2o9qxchCAYWpSA
         a1WQBakOJiFMOrA3gRc2cC9eQlU4YaQPPdZ9ipjjh7mEhZzbtyYScELHrkHMZpZvE5W5
         it6fZSv0B6GGnXjfjUMObodVQXmj13VGx8xnhU008B7MCIOBNYqIFWbXB5yzM+GkF/mO
         RwfmTztRC4ot5KNm1tJWqhXwIkTG6cB2NUtX8EBICwRvHZRxfXYT5HFEWyvk/Yld0o8Y
         siw65cFv0FyXOZKWBEBBCMKEqnwQlR50QBgRAZ35+IZFbTo/cYwpA9oOEy5do5geOEEl
         R1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vu8A5HA8xXgQWRXtk0eL/iZTbM1NfHkZSIXuMCdz2kg=;
        b=qn4Z7114Fnarvn9pBsisnfJCsIjHVXN0DOaNJpcYvY+Y5oyHTcbifDw6lr1kZDqxkk
         M8CAFmtZpZS4MyEoWprpAoJbyrZhcPoRTBjpvAQnhJxdD0JpONHoym4o0pGcU0dtZ7ic
         u40GnEeSH/V7kLxFp/1bDORpoi6NyFpMFVwjPmPGEFpI0DdlKaUHJvEZkqZRmeujdsY5
         yshbERzyd+xCTPZo3ykLMT/5wumQuuHXN32LE3pT71xK8DcZwjz6htV3d9UNqKS2pJ1s
         DXWI3vd8o6bWTEHznRrjamvYiXDYnJ8zandODwgIFcOthuInaXDSDlP7xxWbe0C8eeMJ
         q7wg==
X-Gm-Message-State: AOAM533NV5ZYnzRd3o7XDwrVYSfswi1Um9LepCfAlFY41e8LPYWA4kNJ
        OxtDYg5TudfRhX2ZVOXYh0jYGhzxu21od8f+s/w=
X-Google-Smtp-Source: ABdhPJwWGn2ebHOhi4Y2jxL9kD7oiahZY+aueA8C2vJEclsADcIGUUHygAHobAYiReBgGx3zbZ4rSUGfhrqnEy2WkdQ=
X-Received: by 2002:a05:651c:1411:b0:246:187:4cd2 with SMTP id
 u17-20020a05651c141100b0024601874cd2mr3104951lje.299.1645124143581; Thu, 17
 Feb 2022 10:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20220217180210.2981502-1-fallentree@fb.com> <20220217183253.ihfujgc63rgz7mcj@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220217183253.ihfujgc63rgz7mcj@kafai-mbp.dhcp.thefacebook.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:17 -0500
Message-ID: <CAJygYd3m0_EkqD8DepPLX0rk48BO0TwHkqJ81KRfOvaygMg9_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix crash in core_reloc when
 bpftool btfgen fails
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Should it be:
>                 bpf_object__close(obj);
>                 obj = NULL:

No, the actual crash is caused by this line:
https://github.com/kernel-patches/bpf/blob/bpf-next/tools/testing/selftests/bpf/prog_tests/core_reloc.c#L896

When run_btfgen fails, the obj contains uninitialized data and then
bpf_object__close(obj) crashes.
