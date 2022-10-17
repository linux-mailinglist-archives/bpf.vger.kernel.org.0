Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418996017A3
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJQT1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiJQT0c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EE51CB09
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 12:26:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so11933843pjl.0
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlR+FO16tbGVcDBf5r0oLH6U1TtosIhrNApKgzQXPdI=;
        b=GIEUWSGBrqyEfytaYY+E+QXfGmA4O9Pydpm8CzEFHehz8p1Z8xcjSee90rsNC/pImf
         YJEZCcWoYruoPR+cTz0n/qT7iw6lHRld2aNWdBCK4Pqs0VftRPtDxCUca80LP+wP+iRe
         8FPHNGnY3x+N0QlcnOVLnFLWNZeLAE1CndsWxMaeTYfPuo2svJiNE+9a2gpp/MmNghVs
         LLS9wlHij419dV6UYtNhhDfQK3c+R+lCgU3/uPJlYdZqATKifINsOqGEdL74XceTHGje
         cT4lE03KZup//4oPAHs6zhiyBJoslpbWIpbKd1BI55u+chZSO9nisaCcL6MRlC6CXF5D
         Uiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlR+FO16tbGVcDBf5r0oLH6U1TtosIhrNApKgzQXPdI=;
        b=ip7kO5KEr5PJkWzFc0+U9W1X75JfXsLmzXypix96BuYiHGmXThNmTR7hscPlkmi6+V
         PLgm1TCVUgIqftCviEI8+eJkrQa1ev/qO03xMLxH57lx4UGQ7FQtDXOzNr2FRIL/Bq/F
         Nyxgb7JSftDGo+ka+5Clptsi7TuYcVaQB6x0+Bi1PvD4/kXT92suhTumGyIu1n4QYbq2
         Ld3ftFENyf8TZWuCNF6FHIGZ8pqJlX+rgB1Qe55b0nLvb+AVRdIMU5Ye3VMIUNQ5nIzE
         05ADLeaShIbNIoAvZ6Pen7x0Drp2ttMZK0ajg2ZLQl0uibGOnon0nPjsqhxQqQvx/rir
         b6ag==
X-Gm-Message-State: ACrzQf3VTBCnemseH3qZc3Rd4C9OdHT3ZNR8FTVOEAsKSARTFLqY2RzF
        4aSM/EKTbNea/dxiFOwvF4Gt+TG1HBIlZQ==
X-Google-Smtp-Source: AMsMyM4YNKslTy5FasP2/tduIehqcMqNEAwm8DRBRAUCoW0EL0RN5r1/iHyeTSZugKV6N7VdPTegFw==
X-Received: by 2002:a17:902:ecc5:b0:180:a7ff:9954 with SMTP id a5-20020a170902ecc500b00180a7ff9954mr13639710plh.97.1666034782271;
        Mon, 17 Oct 2022 12:26:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 185-20020a6206c2000000b00562677968aesm7461774pfg.72.2022.10.17.12.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:26:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:26:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Message-ID: <Y02sXE66vK+wRPak@slm.duckdns.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com>
 <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Oct 17, 2022 at 12:11:55PM -0700, Yosry Ahmed wrote:
> I agree that it's not ideal, but it feels like we are comparing two
> non-ideal options anyway, I am just throwing ideas around :)

In the spirit of throwing ideas around, I wonder whether the better way to
about it is keeping them separate with clear documentation and figure out a
way to deprecate the old one as AFAICS the new one should be able to do
everything the old one was doing. Would it be an option to, say, make the
verifier warn the users towards converting to the new one and eventually
remove the old one down the line?

Thanks.

-- 
tejun
