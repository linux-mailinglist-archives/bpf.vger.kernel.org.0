Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC564D63C
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 06:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLOFlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 00:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLOFle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 00:41:34 -0500
Received: from out-214.mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB972DA93
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 21:41:33 -0800 (PST)
Message-ID: <f06b0219-db2a-8b01-cda2-75f828932d93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671082891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmsWqjQZduwC0L5s0oRb959HTkZyovrAs4D30sY2GeI=;
        b=Rmp8EgkVx7LXg7G+tWemMKCM7Fjfz5mknKzPDRKfFkGkwxqqgvGWR+7KLFgdluLWSkkbyj
        d4Pqh2si0XPzW4BdNFf9Z7PPqYGGnsmDNTV8HJgfPmQdKF+3ox1CGFXnDiYdX0CaJSHog2
        EqcePCghfCtLX8Oeh9FnlX9AJg2xvjY=
Date:   Wed, 14 Dec 2022 21:41:24 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf v5 1/2] bpf: Resolve fext program type when checking
 map compatibility
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <20221214230254.790066-1-toke@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221214230254.790066-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/14/22 3:02 PM, Toke Høiland-Jørgensen wrote:
> This requires constifying the parameter of
> resolve_prog_type() to avoid a compiler warning from the new call site.

Applied with this part removed from the commit message.  This change is not in 
this patch.  The const had already been added a while back.

