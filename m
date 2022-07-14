Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166E05750F5
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiGNOjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiGNOjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 10:39:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5F227CC3;
        Thu, 14 Jul 2022 07:39:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ez10so3749683ejc.13;
        Thu, 14 Jul 2022 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KgEA5LO4CvmhCgoLBAtNeyJAoBhKeDLP7jeHnXEi3zA=;
        b=EZve3ztQLIzJCb+dNDIqV8+W8zlCf00irGoihkEi7esDNA7KWFmZRqcQWM70deyZUD
         XxNsV2YSKYy4FP2EWv7vi8CJHsi9Wm2F9oEBDifrryFF3QJF65KeC4D6ZMFbSR656smz
         VHbzfjb3q++Qod88OdwMR3W7W1e0Vxc5erB39FRmxzNhBntRGjnt8ztuZIzG/WKZoJvy
         J12ESsFc55cmzFl1GSAmIgEnWJ7pQy/davEV+Nsn80aJ8zK1YEU/BltrO+eCPRpLNF0k
         pKGMENF1EmsPTEo7t6IEctia9EZaHfiCcypqvhTIA9Y4FL/GzWABnZv7sgonj1DaLABm
         bOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KgEA5LO4CvmhCgoLBAtNeyJAoBhKeDLP7jeHnXEi3zA=;
        b=nOrQm51Q4qsib8UjZXQqq0wOd5AYzMJjXfbA1+ay1VFokhOQKOTLE3NhQajvcTj2XV
         m06pmoKFxDKP1xrlNMD7QSg80q+F7U81bTz7kA8QvBz2L0FdYHMDCBibrugIOpheeBjX
         fWBbsbWMUTeXSRT7VVoX8vNza3tfsOAzJjJtko1zKrpWkLQzN62zS0SHnvwT499a4F9q
         IqNrvUAPxNVwBuT0LUO/aeSO1TyqV0ZuBbQQrUY0VXhl3EeY95Ww3SUwMGM4V0Oe9dO/
         yZmgEvveW1UdKIiGeyAPH1ld7uTQ4Ha2/LXvMpS6OtT7jy2czf6m6PfOjqEDFcMzOhds
         rnsA==
X-Gm-Message-State: AJIora+KDuNK8sv8KJrpRkoOxARb1J7b5+oRP5KI/2v0gKs+NQcVlFdm
        JeiUdSOg7802LCI/0BaFGeU=
X-Google-Smtp-Source: AGRyM1vGtr9PJFhfUta5S5Awr4EYiKGFN3/Q/BT9rdbvoUJzfoeso+C97C3qT3uz1KyScaLg8JYRRg==
X-Received: by 2002:a17:907:3e81:b0:726:9615:d14d with SMTP id hs1-20020a1709073e8100b007269615d14dmr8880970ejc.517.1657809584910;
        Thu, 14 Jul 2022 07:39:44 -0700 (PDT)
Received: from ddolgov.remote.csb (dslb-094-222-027-106.094.222.pools.vodafone-ip.de. [94.222.27.106])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b0072b1bb3cc08sm761087ejo.120.2022.07.14.07.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:39:44 -0700 (PDT)
Date:   Thu, 14 Jul 2022 16:39:43 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, peterz@infradead.org, mingo@redhat.com,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220714143943.lens6itw2rtzqszd@ddolgov.remote.csb>
References: <20220625152429.27539-1-9erthalion6@gmail.com>
 <20220627113731.00fa70887d19a163884243fa@kernel.org>
 <20220703093216.5qpxfvza5dhuknru@erthalion.local>
 <20220712122930.277cc5d6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712122930.277cc5d6@gandalf.local.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Tue, Jul 12, 2022 at 12:29:30PM -0400, Steven Rostedt wrote:
> It should go through the perf tree (if it hasn't already).
>
> But you should have Cc'd LKML and not linux-perf-users, as it is a kernel
> change not a user change.
>
> For the tracing parts:
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I see, thanks. Will resend it with linux-kernel@vger.kernel.org in Cc.
