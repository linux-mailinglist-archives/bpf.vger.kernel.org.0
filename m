Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346C46B06F4
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 13:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCHMWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 07:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjCHMWR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 07:22:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014BCBF380
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 04:21:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h11so15162071wrm.5
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678278082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+hxF791sh3V+bY9edrxSKeJWX6rquUOGNLsOKsa+zc=;
        b=dzPp/WmNjwr7dsN5wn2+zmfR6VxFygdUomBTD4eb/alacv1Pj9VrzTq62Us+B+EHmv
         xvimX6Z087eJowCYWsUmzwc05pJUmQ2/NwD2EZO3vmbxTn6WvSbb3+6ce9HbW2aNrlY4
         B0LaDOeTUpTb9W/g6BBw+vd4CKEqAEmo8Hz1qwmlmyY6kqaPXWhNy7v52KpoGD89GKeD
         dDEAQZBeEChvqrxFhrL78vkwDlDk9BtLvRWv+H4cwrSJPDmbXLBEJmQjlqgQEQkDG6g/
         eWqTs585DGehfUUfP/TwPaVozfidkUmLCT/kpmbXrqvVwdj9Pnf/BlLiqusrMbN8M+NF
         9CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678278082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+hxF791sh3V+bY9edrxSKeJWX6rquUOGNLsOKsa+zc=;
        b=fqsAX0v8z/qxUO5UYO4i0IRqMmDs0OO2NZB52GZQPbIx1ohXSXT6eSd2q8SuNcFj9w
         AC9qUVRDxqP/0HEhRbBSPVZ/F062TtH+CBUciZs5HVLT4wAf6Ui370r34PR9XDQmr++W
         SE78+QvRkrZt9kR0alyJ/zhoI3RyFIfaR9/f5YQqNfniHq4NQLEU23tTq1KpDxGWSs+q
         OyFiGnUULw1nTxCa+NUfOtVMAEGEI1dl31hE+FENfUOwYlwNOLlvf5K4h8yPghCUeTTN
         3B0Ftulx9dd9kUFKjZI2dM9T8Ry0+ceIOtzQhHc0MG+KUu+U/uKCQb0bUMbf3BQcn96E
         zv2g==
X-Gm-Message-State: AO0yUKVRGbtZXhhVNAWQrhIWH1Hx8p4vXNuViAP8cIqOu82K5NHq3bxX
        IkYGFCN6Su+AYAwpkyRHEuy8wiNJGjIfg60YgNcGow==
X-Google-Smtp-Source: AK7set9TIaW1fTZS8vm70GUIiNtqM+rejZQoeVbd8i+NZH2W+095Vv0S01nA1lwNVre04gWGkncyrw==
X-Received: by 2002:a5d:4445:0:b0:2c8:a6ea:c00c with SMTP id x5-20020a5d4445000000b002c8a6eac00cmr11742031wrr.69.1678278081806;
        Wed, 08 Mar 2023 04:21:21 -0800 (PST)
Received: from tpx1.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d58e2000000b002c56af32e8csm15186498wrd.35.2023.03.08.04.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:21:21 -0800 (PST)
From:   Lorenz Bauer <lmb@isovalent.com>
To:     peterz@infradead.org
Cc:     Lorenz Bauer <lmb@isovalent.com>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] perf/core: Add PERF_FORMAT_LOST read_format
Date:   Wed,  8 Mar 2023 12:20:57 +0000
Message-Id: <20230308122057.539055-1-lmb@isovalent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20191028091229.GJ4131@hirez.programming.kicks-ass.net>
References: <20191028091229.GJ4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,

On Mon, 28 Oct 2019 10:12:29 +0100 you wrote:

> But now that I wrote it, I'm a little scared of what I had to do for
> __perf_sw_event(). Let me ponder that a little bit more.

Do you have an idea how to resolve this?

For context, I maintain a Go library that interacts with perf_events
for the purpose of attaching eBPF kprobes. Users keep asking for an
explicit tracefs fallback since the miss counter is so valuable to
them. It'd be great to find a solution!

Best
Lorenz
