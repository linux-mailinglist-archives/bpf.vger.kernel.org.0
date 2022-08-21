Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC059B2ED
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 11:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiHUJYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHUJYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 05:24:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2E1AF12
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 02:24:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so4543603wms.0
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=UCz2WqwkMzW8gZVrVR6Cvi3zXSywiwohhvt1alDQhas=;
        b=GAyrUuExLObcqKPO2DkLP/xSUDbehWjk/JSOy37fsmHIjBVgTLWyg7oZXjwgVk07Sn
         u+A4xiQ+8lsO+jTYeKhHlZNo1r/qED1sMXDzeZlw05lwpC7l4cKnsCYlT+Jk/3tUeHyJ
         /bV6UjQHV0gMwoXLaI9j8RYEqZU5KTJ2LtF90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UCz2WqwkMzW8gZVrVR6Cvi3zXSywiwohhvt1alDQhas=;
        b=xM0PsJGUzFQaMGSgNx/dyN25emqvwH7KoQgObjmgXURrfg8yjjMFWEvaVBpB4E3Wdq
         gAhsw9MdreEZ2tEwLS8TT+mno8IvrkMVcpECVkUbJDp6aFSGwZAHW/HIiS3BVpd5mQJS
         VjoeMeJzn+PctvI9LRwqdjRcWC55ybH/oIwDxLIt9LOOoD2wizLP+IYsLdmXm6kBw0Wn
         7fdxdOAuAyJMzBEgpqtortf5nzVODNLsShfBk807fi7RJy+nMgpXWOWh+ZXok2Ebo65l
         aMLRbnjDVpoRmIa+e9rClkNt6nxdRXh/HxHpG+jiLbtm3Lr9z1DLRMJUYoV39N49Lfhq
         E6uA==
X-Gm-Message-State: ACgBeo15/SNdrZKf1dPPCg9MRDwLVlDv+aUssMecpyqGONWVNCqh/lNm
        un4oAi6VH/Bl7wMguHFkmFfBsQ==
X-Google-Smtp-Source: AA6agR7xaEIm4zn0UJ6OMW++//z6cy6GVUGV0rF4FrfnPMaHHBJT/3O+g603fZlVFP1N5Zk/2RYA+A==
X-Received: by 2002:a05:600c:4f49:b0:3a5:df56:5475 with SMTP id m9-20020a05600c4f4900b003a5df565475mr9387711wmq.116.1661073849644;
        Sun, 21 Aug 2022 02:24:09 -0700 (PDT)
Received: from blondie ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b003a603f96db7sm18828612wmq.36.2022.08.21.02.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 02:24:09 -0700 (PDT)
Date:   Sun, 21 Aug 2022 12:24:03 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf/flow_dissector: Introduce
 BPF_FLOW_DISSECTOR_CONTINUE retcode for flow-dissector bpf progs
Message-ID: <20220821122403.02edc937@blondie>
In-Reply-To: <CAKH8qBsrUL2eV4YcxVYqp+3Fqx+Gx667othK8O-5Lp8r9yM_8w@mail.gmail.com>
References: <20220818062405.947643-1-shmulik.ladkani@gmail.com>
        <20220818062405.947643-3-shmulik.ladkani@gmail.com>
        <CAKH8qBsrUL2eV4YcxVYqp+3Fqx+Gx667othK8O-5Lp8r9yM_8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 18 Aug 2022 09:12:43 -0700
Stanislav Fomichev <sdf@google.com> wrote:

> Some historic perspective: the original goal was to explicitly not
> fallback to the c code.
> It seems like it should be fine with this extra return code.
> But let's also extend tools/testing/selftests/bpf/progs/bpf_flow.c
> with a case that exercises this new return code?

OK, will re-submit with a test.

> Is it too late to also amend verifier's check_return_code to allow
> only a small subset of return types for flow-disccestor program type?

Well, wouldn't that be too late now? there might be progs out there with
different codes. In any case, I don't think adding this is related to this
series.

Best,
Shmulik
