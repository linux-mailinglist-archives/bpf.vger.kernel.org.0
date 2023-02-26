Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0646A2CE9
	for <lists+bpf@lfdr.de>; Sun, 26 Feb 2023 02:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBZBDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 20:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBZBDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 20:03:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA512044
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 17:03:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r7so2794702wrz.6
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 17:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vz9Vu72YA4bopzluHl4s3KRkepQZf0czdPcqpnvwX+c=;
        b=IYQ19mzh0ZYcJw3mN+6/7WwPzV2zV01LpYNrW/62LL9h1EluskkWjRyMayqgPAlzyL
         z4DKPtEs71hEGTYMrxNwDttY66U02dP2TCi3zUoGFoJV/fWeOl5FgmQ8oOcst8Qh2OcQ
         tNp9w7Dv4C/cvTpAgkQcDS3s2qOVjEDjq0vivP0h72JgDKHCuCfoWJJILCd6ZVA84FHj
         uxAnyonPNmjtBVOxGiEP80B8Vxl7P+/HfsT4NEdrHcYXC0rQfPVC1QS73BYnFmZxODbN
         sW05nBW54DvDCBBEIp4xmqcaUkQ2FADXyJekJL0ZYrq4T1i8H/qJKMWGRJJatKr93bbV
         hXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vz9Vu72YA4bopzluHl4s3KRkepQZf0czdPcqpnvwX+c=;
        b=UbsJ83REsTYWtQ7+Vrta8NMg73YTd8AobDragiHL3pHzYMWIgcqHRXcFpFKwPX0XnS
         iDb4q2zDHpGtfZALc7WdmKLRCj6etibP+dISFLNwtzKCv85h6BNjqsNkJIVPfU+ReyVm
         ZZZjdn0CW6eXF1kEEktdqH+jYKdtvkbu0kZMyZrRHskpoinvY6uhhx5EMS2Cb1LkHRL6
         98NtMaOrz2yl5opQ+loTqpdRHqID8S5+55v8On3dH7Uc3TtZSUvGiyVyxt8aqXv2VnXf
         2kcC7SzmoSPKsYCRmmfPW3cAjILD8z58mmk+OO3fEoETcA3K7KQHOMY0HOHLCTSiqLRD
         ZSzw==
X-Gm-Message-State: AO0yUKWmq6mMycBLYm2WYCRUBtvKnA/lGHkaAsT5Pbwrjx8pIMiIMn8b
        wCDFpKCt41EVKqrQFGQ+BB47/IrgUxyA8g==
X-Google-Smtp-Source: AK7set8SCdL1PjUOWjdzVSNKbRILiKsMyRQtpV6CZ7wPTgLpO/lanaUtg3WatqUoQsgCmxMJn6cdtQ==
X-Received: by 2002:a5d:4c4b:0:b0:2c9:993a:ec2a with SMTP id n11-20020a5d4c4b000000b002c9993aec2amr1825829wrt.40.1677373431564;
        Sat, 25 Feb 2023 17:03:51 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fj10-20020a05600c0c8a00b003e7c89b3514sm8038969wmb.23.2023.02.25.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 17:03:50 -0800 (PST)
Message-ID: <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Matt Bobrowski <mattbobrowski@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, acme@redhat.com
Date:   Sun, 26 Feb 2023 03:03:50 +0200
In-Reply-To: <Y/p0ryf5PcKIs7uj@google.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
         <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
         <Y/czygarUnMnDF9m@google.com>
         <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
         <Y/hLsgSO3B+2g9iF@google.com>
         <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
         <Y/p0ryf5PcKIs7uj@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2023-02-25 at 20:50 +0000, Matt Bobrowski wrote:
> Sorry Eduard, I replied late last night although the email bounced due
> to exceeding the mail char limit. Let's try attaching a compressed
> variant of the requested files, which includes the compiled kernel's
> BTF and the kernel's config.

Hi Matt,

I tried using your config but still can't reproduce the issue.
Will try to do it using debian 12 chroot tomorrow or on Monday.

Thanks,
Eduard
