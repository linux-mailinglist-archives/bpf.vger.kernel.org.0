Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA65ECCF8
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiI0Tdu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiI0Tdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:33:47 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0961106A08
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:33:45 -0700 (PDT)
Message-ID: <7fb1f18c-a695-494d-0242-b782d410250c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664307224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dzc2IRUS9E1ZlmzvM1Y1rszs5ISP391zHO2/cqMK24=;
        b=miF0jtPm3G6ENQiISXHxYRMUo6l1L0i7wHqOcjtHZ5g2V3Cp0f0rzt6iBVGcKGQZtBqbqI
        I2n2uEjpjha20Pe5q3HB6SdsDDMPMGWG/nqonSrngOIYnDQbd0W8YCelX4PJoR13i7FqHx
        tPm+PSRFjay+s4UqkBWM1R0yVSp5Pe8=
Date:   Tue, 27 Sep 2022 12:33:39 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 0/5] Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
        yhs@fb.com
References: <20220926184957.208194-1-kuifeng@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220926184957.208194-1-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/26/22 11:49 AM, Kui-Feng Lee wrote:
> Allow creating an iterator that loops through resources of one task/thread.
> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested in only the
> resources of a specific task or process.  Passing the additional
> parameters, people can now create an iterator to go through all
> resources or only the resources of a task.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


