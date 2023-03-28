Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB76CC973
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC1RkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjC1RkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:40:06 -0400
Received: from out-5.mta1.migadu.com (out-5.mta1.migadu.com [IPv6:2001:41d0:203:375::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A6AAF09
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:40:03 -0700 (PDT)
Message-ID: <9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680025201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EDNTWrxISYOYIoEfAGDSwne+jv9kD/g+qrtQBlX41/A=;
        b=AxhD17VLkoQymMepXr8iwm34Bf+UW1DZIUUl1zjFcX4nXgFdX3OXlRJgfOFpHrVk941c0+
        ka+dYHs7g6EjTiqkL4UsUUibLyhvWz1BmmT2Ek1XcK+10Ob3rSjIuV7S0qUAqkbluPS7u+
        9i3DYFifjOWvTjOLIkEso44xjjDmECg=
Date:   Tue, 28 Mar 2023 10:39:59 -0700
MIME-Version: 1.0
Content-Language: en-US
To:     YiFei Zhu <zhuyifei@google.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Subject: Flaky bpf cg_storage_* tests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi YiFei and Stan, it is observed that the cg_stroage_* tests fail from time to 
time. A recent example is 
https://github.com/kernel-patches/bpf/actions/runs/4543867424/jobs/8009943115?pr=3924

Could you help to take a look? may be run it under netns and also have better 
filtering by ip/port when counting packets?

Thanks!
