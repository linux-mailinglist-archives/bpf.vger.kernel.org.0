Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00355FC066
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 08:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJLGCc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJLGCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 02:02:30 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D7265;
        Tue, 11 Oct 2022 23:02:29 -0700 (PDT)
Message-ID: <e9abe604-2d64-f05a-7e54-c1331bc08c62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665554548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KezwDazUQbJEhBf1T6quWYJ/8M4eKagscnMXp7Dets4=;
        b=UFNStNRexdyeXGfTiEoAeG+8fMHoprqVpfsG4wtXU/NxXKp75AWCbfYL2QP7l//0fHi2qB
        ilI6YudrbHl+yH8v4xsneTqk1sc8+Cz38hgF6SDmaT8bkY5DisiIKmB9TBXDZ/W9/2OBnc
        1I2iapYph6P2GUHH2BqsZEELsiC65gY=
Date:   Tue, 11 Oct 2022 23:02:24 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Alphabetize DENYLISTs
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20221011165255.774014-1-void@manifault.com>
 <20221011171357.dqecmkyjinxy2m7u@muellerd-fedora-MJ0AC3F3>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221011171357.dqecmkyjinxy2m7u@muellerd-fedora-MJ0AC3F3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/11/22 10:13 AM, Daniel Müller wrote:
> On Tue, Oct 11, 2022 at 11:52:55AM -0500, David Vernet wrote:
>> The DENYLIST and DENYLIST.s390x files are used to specify testcases
>> which should not be run on CI. Currently, testcases are appended to the
>> end of these files as needed. This can make it a pain to resolve merge
>> conflicts. This patch alphabetizes the DENYLIST files to ease this
>> burden.

[ ... ]

> Looks good to me, thanks! Not sure if we should add a comment indicating lexical
> ordering or solely watch out for that through review.

Added the ordering comment and applied. Thanks.

