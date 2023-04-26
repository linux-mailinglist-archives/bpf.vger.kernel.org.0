Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3196EFC8A
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjDZVfT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 17:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbjDZVfS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 17:35:18 -0400
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDDDE76
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 14:35:14 -0700 (PDT)
Message-ID: <18628833-370d-36da-95e1-09409b886e49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682544912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWwPV5lSC7TTDzG/YmW2lJItFOoey+csk875BswPCuQ=;
        b=F6BMaCjsPjvw9hRveA66p894g0yFe8qPlr+JfiY5MtAcHXd7vXQbqwblhFIn9Gca2YFkK6
        WoCj5/XtnnyjgBhElhFXB+2NuMNg6//gXUWbpdTrdDcO5WRKvP5cEj3MnrgaX8YeIv5UuU
        FSLN5X8smqSYOsW16QZBB72tUPBw2ZE=
Date:   Wed, 26 Apr 2023 14:35:08 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 04/10] bpf: Add BTF_KFUNC_HOOK_SOCK_ADDR
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     kernel-team@meta.com, bpf@vger.kernel.org
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-5-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230421162718.440230-5-daan.j.demeyer@gmail.com>
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
> In preparation for adding a sock addr specific kfunc, let's add the
> necessary hook for it.

Please combine this patch with patch 5.

