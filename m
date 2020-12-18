Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED502DE020
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 09:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbgLRIxN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 03:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgLRIxI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 03:53:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24756C0617A7;
        Fri, 18 Dec 2020 00:52:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y23so1702589wmi.1;
        Fri, 18 Dec 2020 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9giW0w6ssDQA0Rg+1pVqNbW5scOYhp5GVMYAzCdZIvw=;
        b=p6Z3znXJkpRNWamd3D/mkP0VyE9F1XVwM5TWHoSRly41l7Q7wwajSa9TxvBCxtNiLS
         4KVsU4ATWtfyNjMXMWpynO60ZtCzzAqefogAR+zrD38TivVxRHGbaRG29LFagZCUgsM/
         cotSBjnZeMGxZ4us9GPgj6MebBtzuk94mJc1JBP1Rlgmfgovx9NIVc3tL7Yiem0F6JKl
         6/OgGxcomJrN1c+Jwy3NNAt1U/PtuCP3eUayG89ZLtTnwNugEfAlH6yJ7cK7SerphyLg
         QgdgFF7IcGxf3JK9gugstCXwf7+TD7kRlfOAxsUiEHd1zGiIaaojurtHiDl7EGlB5FVn
         8sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9giW0w6ssDQA0Rg+1pVqNbW5scOYhp5GVMYAzCdZIvw=;
        b=fnBoY1Jnp5ZLXHICPjJS4q05aNhcsNAIsOM60vxMwUjgij8djz39Zs0oWIP/zl2HTH
         vyzIjR7lHGyx5bO/R0uzbstn+RhCealA6xTyeqEk1IaE1hbliqDxGadrbcMJQyG5W4S+
         hn8qTo4z7rsboYCBackan+rzeBiYe69Eifh2+u4m8pXez5jKRavKo7+y00GqZlNXwB4g
         iiQGDgatIC9J40pXiC/B3M4mIX7y5eL6yjHG1Rbvi3HkFKC8PySEmDkfSs1RWS3Um74f
         GdAQwmEHl5MyJOJ8PLvnalY+kg+hkezFo90upBl6xjRSnMbByDGRotrgjtEyeAkdvzaC
         wN0w==
X-Gm-Message-State: AOAM530JeV38IIkdjT+8Ry7rEpWZldMxsgmqHKRTGP0ekpCBw2p/GeUq
        rZ/2GINPrl98i+H3863aXe5NKME3YreJ+SsJfi8QTkVZnZtDcw==
X-Google-Smtp-Source: ABdhPJzdWnk8vnrFMEEGTO4o/ER8zGa/c2cmSo/njaEMy7RiS1XcfFg+xZeUWL45CsKJ1OKHP4SPntDaL+w3XMRqcUM=
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr3186581wml.106.1608281546580;
 Fri, 18 Dec 2020 00:52:26 -0800 (PST)
MIME-Version: 1.0
From:   Meng Zhuo <mengzhuo1203@gmail.com>
Date:   Fri, 18 Dec 2020 16:52:15 +0800
Message-ID: <CACt3ES2LCfNDq-nskrySJjWD5EO9WCAst_+kJT7UbhYOmD+45g@mail.gmail.com>
Subject: Please remove all bit fields in bpf uapi
To:     linux-api@vger.kernel.org
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, all

I'm tring to port bpf.h to Go, however it's very hard to make it right
with cgo since bit fields some fields didn't match any type of Go.

i.e.
struct bpf_prog_info {
        /* .... */
        __u32 gpl_compatible:1;             <-- boolean ?
        __u32 :31; /* alignment pad */   <--- padding with 31 ?

UAPI(User application interface) not just for GCC only right? If it's
true, I think remove all bit fields is more appropriate.

Thanks. Regards
Meng Zhuo
