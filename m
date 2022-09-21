Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A455E54D4
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 23:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIUVAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIUU7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 16:59:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09796C75D
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 13:59:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p3so6095274iof.13
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5+ZrmmzXHit9yKE1lQC67vC7xK4XEA5+rzvoy4fnyhI=;
        b=XSBHbK8u27HsnDY+swOvoNNqHs+cuIjb2ukXuLbdVQTdoEsVch0LtLUR07EuXkVTT4
         IyYZgBri7ra/vhiZx1vssfJ3PC2mT3aVAfXcICJWnzQEtE7jN6uGEU1Wk+Jv69I7G5GO
         5d21Kn4WKxcBWVMKmw89b7wQwtSQn07yR/haoQcSo2HOc3t/uS8yJoQB6iMbau3JLSAx
         GfhAemdDzSOc4id51lUpA+iUu/6a6Eh+BiQOsiDXmvw5fqww7cOXbitXiG6k6ercamE/
         VAGhBzbFNzNdFmiPqbvMM6xUdiOiUh9bvQ7tDB7FtCeylq60F09aq91xqGotwlbZZk5g
         Q6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5+ZrmmzXHit9yKE1lQC67vC7xK4XEA5+rzvoy4fnyhI=;
        b=qzaTKwN0KrrvS7Im2YUc+GbNiozEdv053o0sMyrWHHh9Vmx8hWeCNtWN+sxiN/Dk/T
         e5HDXKsqMxm9Q3zAadCSfDN6TO54keuwBsyEcePCe+4yS5iRNLsuw7dl7Y+vlUMBhAe5
         S2RD+U/+hRTOsqxjBTKRTK13MJBmSXbaQLjJjVMbz4oei+b4X9Ssbt+gkagQ0HVmtii5
         SZ0nnQNkYxS62QOET7oXJ9oLV2CYUCVEMLVveU3cjiVXpd9Y20hGQG7oYraGE1nI2a9l
         VRmaKZwKOim1l11i5DITeD6QUuYAbpMzdAPX5ZnjBSX2Lwiqb4EVWpyl20vJkxTq/cyM
         8xvg==
X-Gm-Message-State: ACrzQf0JInbHHqiXTbBJ1t8JRtvqqRAXlWOTneZ4jetPRESD2ciB91Oe
        3fdzYj1ZB8CN0wc4lCclvMW79XScdlWGqNBTrA1/+g==
X-Google-Smtp-Source: AMsMyM63dt5mPaR8t6wA/buEo+eUEgx8ZNxfrTZNfZeITkh2HRnghimPmGVDDJ8eVUCcfp/vZ+Vui2ll8CSfSc0Ndnk=
X-Received: by 2002:a05:6638:1407:b0:35a:4d1c:10ef with SMTP id
 k7-20020a056638140700b0035a4d1c10efmr128396jad.119.1663793990169; Wed, 21 Sep
 2022 13:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io> <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com> <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
 <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
In-Reply-To: <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 21 Sep 2022 13:59:39 -0700
Message-ID: <CAKH8qBtcRHU4UyUxSQe2tC0yopCaJ9jXugchuwDibAJc10FJww@mail.gmail.com>
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid pkt_len
To:     shaozhengchao <shaozhengchao@huawei.com>
Cc:     Lorenz Bauer <oss@lmb.io>, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 21, 2022 at 1:48 AM shaozhengchao <shaozhengchao@huawei.com> wrote:
>
>
>
> On 2022/9/20 22:42, Lorenz Bauer wrote:
> > On Mon, 19 Sep 2022, at 11:55, shaozhengchao wrote:
> >> Sorry for the delay. I'm busy testing the TC module recently. I'm very
> >> sorry for the user-space breakage.
> >>
> >> The root cause of this problem is that eth_type_trans() is called when
> >> the protocol type of the SKB is parsed. The len value of the SKB is
> >> reduced to 0. If the user mode requires that the forwarding succeed, or
> >>    if the MAC header is added again after the MAC header is subtracted,
> >> is this appropriate?
> >
> > We don't require forwarding to succeed with a 14 byte input buffer. We also don't look at the MAC header.
> >
> > I think refusing to forward 0 length packets would be OK. Not 100% certain I understood you correctly, let me know if this helps.
> >
> > Best
> > Lorenz
> Hi Lorenz
>         Sorry. But how does the rejection of the 0 length affect the
> test case? Is the return value abnormal, send packet failure or some
> others?

Sorry for the late reply, I'm still traveling.
What we want to avoid is creating invalid skbs via prog_test_run.
We can reject <14 byte packets with ENIVAL, but that might break some
of the existing apps (as Lorenz reported).
So it seems like a safer alternative would be to accept those packets,
but just append missing bytes in the kernel to create the valid
packets? Padding with zeros seems fine?

> Zhengchao Shao
