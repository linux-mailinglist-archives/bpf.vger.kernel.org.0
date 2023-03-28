Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6A6CC9E5
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC1SIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC1SIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 14:08:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101EDE6
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 11:08:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so13484134pjt.5
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680026927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chV+5Fx/MWvcf8VWx2WoL9R8km1k5FrqS1vuwa0p5BI=;
        b=mMdUjk+0RvR6nPRFG5KHqDoMOVyUs0ZKCxc8sJ/s9snlLz9RNoCJK3VfTdHdm4+/A6
         DM8uoIgLxhBjN1bufejM3694qUI+WTel0ACWmkkMi4McB4xOf4NvetHRlQbZb4k03RwJ
         eX11BSf9kfbQ2gCW3fYuGIvvWgRBvLDXMElwGqS7nvuAraIQHSBWy2qIb/qXGbUDIPuP
         pnlOinkAzFCPP+AawWdaOWVvprr+Swy7D6uYmh5hG/e+vJtGdMs9bacHSzh35OnBCzF2
         vOj21W8kHn8SYOzs5U4BPtnkvsixfSuYaj/MbMTIi82wnxVOYFepMV2GcbjMIvArVzwO
         aFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chV+5Fx/MWvcf8VWx2WoL9R8km1k5FrqS1vuwa0p5BI=;
        b=6rqeQles0/XTEm+kTAF4xgFNcVmN023wmTM32asvWk4TjkWbOTOYbJxo9mNVZHkIFC
         ic5yMoXUd6W9btezNZjkVJZ47TQtgRG1RrRT0sBPkrWR5CWTiHNJDT8/BHaiYnIaRATF
         Wb/fGlcBx8lKs3jaI7Gw1E/UtfEXXk3o02BtJSLvUkPcOqOtDgOBw29Lmpay1t4kwIR6
         hp/BQM/AsT6tXVYz2Fs7BfLMYun2Q9gzBCYUAWWUMO1XdzHPePu/uGGwq3avH5oiA2xX
         cPYZ2bWt/7+sLQiaEe6fs3JueLin8O4yL0U4Owyvd9K30524jiEcfdU/GoXQq9uwfGVA
         mYLg==
X-Gm-Message-State: AAQBX9dxxNbIIrmlt/Ro6/rIQgtrqYkk3uaAlyQCyGM983Nb0l5bfStc
        3FkOnCGPSm2iyolY8B9aso2MipKWcwBZJPaaq9HLrKV7I++aNeKWB/msIA==
X-Google-Smtp-Source: AK7set8b7Q2qeqlTIyDVhciE4/KVI4qqKR16/GUPGzIDLEWmbg/7N5hw3wRl3TTf2Yh4cIFe/WKRLLfl2UAusc5Qotk=
X-Received: by 2002:a17:90a:4a85:b0:240:2ae6:5eb8 with SMTP id
 f5-20020a17090a4a8500b002402ae65eb8mr5058497pjh.9.1680026927362; Tue, 28 Mar
 2023 11:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev>
In-Reply-To: <9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 28 Mar 2023 11:08:36 -0700
Message-ID: <CAKH8qBvRCBrZz0Cx8w8VsYGJKOLQXf9xzc50ce_nQenhGNdx7w@mail.gmail.com>
Subject: Re: Flaky bpf cg_storage_* tests
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 10:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> Hi YiFei and Stan, it is observed that the cg_stroage_* tests fail from t=
ime to
> time. A recent example is
> https://github.com/kernel-patches/bpf/actions/runs/4543867424/jobs/800994=
3115?pr=3D3924
>
> Could you help to take a look? may be run it under netns and also have be=
tter
> filtering by ip/port when counting packets?

Error: #43/2 cg_storage_multi/isolated
test_isolated:PASS:skel-load 0 nsec
test_isolated:PASS:parent-egress1-cg-attach 0 nsec
test_isolated:PASS:parent-egress2-cg-attach 0 nsec
test_isolated:PASS:parent-ingress-cg-attach 0 nsec
test_isolated:PASS:first-connect-send 0 nsec
test_isolated:FAIL:first-invoke invocations=3D2

Error: #43/3 cg_storage_multi/shared
test_shared:PASS:skel-load 0 nsec
test_shared:PASS:parent-egress1-cg-attach 0 nsec
test_shared:PASS:parent-egress2-cg-attach 0 nsec
test_shared:PASS:parent-ingress-cg-attach 0 nsec
test_shared:PASS:first-connect-send 0 nsec
test_shared:FAIL:first-invoke invocations=3D2

Probably because we're using tcp? And race with syn vs syn+ack
(invocatoins=3D1 vs invocations=3D2)?
YiFei, maybe we should count only pure syns?

> Thanks!
