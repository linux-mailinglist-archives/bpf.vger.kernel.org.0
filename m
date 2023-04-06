Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD36D9B16
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbjDFOt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbjDFOtK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 10:49:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECD134;
        Thu,  6 Apr 2023 07:47:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CE8081F8BE;
        Thu,  6 Apr 2023 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680792470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzy026vw3G51S2cFNOMvtPChp1Fc2IDetowMzUM6ByQ=;
        b=OKyhHn9/nrX8lFgQf0FvS8ZSX1BuOy5IaGmdbZH2COjgilmS1Z1hXOa3neeSBbeKnKxrzh
        1DBeo2wzQ3RMxtDq6gwqJiW9vxEscX6MG13Pgq3NyCveDh7/b4KKZ2dK9JcgHSRAk84Syj
        GUBoGYzzPFMwx861aosjJZoUuozSTKE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 21B342C141;
        Thu,  6 Apr 2023 14:47:50 +0000 (UTC)
Date:   Thu, 6 Apr 2023 16:47:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Artem Savkov <asavkov@redhat.com>, bpf@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next] kallsyms: Disable preemption for
 find_kallsyms_symbol_value
Message-ID: <ZC7blVqUwiHWWJOg@alley>
References: <20230403220254.2191240-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403220254.2191240-1-jolsa@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue 2023-04-04 00:02:54, Jiri Olsa wrote:
> Artem reported suspicious RCU usage [1]. The reason is that verifier
> calls find_kallsyms_symbol_value with preemption enabled which will
> trigger suspicious RCU usage warning in rcu_dereference_sched call.
> 
> Disabling preemption in find_kallsyms_symbol_value and adding
> __find_kallsyms_symbol_value function.
> 
> Fixes: 31bf1dbccfb0 ("bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules")
> [1] https://lore.kernel.org/bpf/ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com/
> Reported-by: Artem Savkov <asavkov@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Just for record:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
