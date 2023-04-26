Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470A96EFD17
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 00:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjDZWNf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 18:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWNe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 18:13:34 -0400
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [IPv6:2001:41d0:203:375::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACE7DD
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 15:13:32 -0700 (PDT)
Message-ID: <8675df9e-1800-ada4-15d8-c7d97f51c12c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682547211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+2zRvy0Nxe2GVbmAQq4+KRoeiWOFsfHHetOUqVA/sU=;
        b=HDN3ctRfUmawktpMTmltSyNYyFnSHy4qsqjLwDWqKkXe49oKKgdo985SX5qu8jPXWNVNHI
        NF4U0UfBpY/8hsBoHJINfZSSAxlN+GpBM20bqmRH1SXi3yglesnjUqD0Yn+8/Oz0hJpuve
        MYU1+vKjDA4CQsAPSphvtx756CAuKRg=
Date:   Wed, 26 Apr 2023 15:13:29 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 09/10] selftests/bpf: Add tests for cgroup
 unix socket address hooks
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     kernel-team@meta.com, bpf@vger.kernel.org
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-10-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230421162718.440230-10-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/21/23 9:27 AM, Daan De Meyer wrote:
> The unix socket address hooks do not support modifying the source
> address so we skip source address checks when we're running a unix
> socket address hook test.

Another thing came to my mind. The test_sock_addr.c should have been moved to 
the test_progs.c infra. The bpf CI does not run test_sock_addr.sh.

Please at least consider adding the new AF_UNIX tests in this patch to 
test_progs.c infra instead of continue adding them to test_sock_addr.c.

