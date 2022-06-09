Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7B45454FD
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiFITbe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 15:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiFITbd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 15:31:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9043B3F3;
        Thu,  9 Jun 2022 12:31:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso52303wmc.4;
        Thu, 09 Jun 2022 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbKPtmJbRhRn3EAA719J/gFo3OO4cSK0EnKPpp4liAs=;
        b=WIbAp+3ymFvw77b4DaPv3jWw3ackXtvgSzXBpsMS3ssupnYPrL5afw4TkMludBbKtM
         gFtXUBUM06D6Y5Oj1AfWeIBhYFYpKWHzeYb6SFqP8kZeRH6iuOoURdaO7Gzk/Sczw5PN
         HMZgx4rClHAXMvgdNnzQRGx2scn/ftxzdS9htvRDUDuUkSauCLGghZ/Cb8vbOPCWwJJ5
         8rmtXlXOp5SrCvytDim7avMYs3qJRftLdSyGDkJg/fR3mz49pBcoXjFLXsmjjqHSlK6d
         jagJQyRwaIbHFxNFblrl4SfWSO4AR0923NIozCCy0xEFMrQCQHMNFqBhglIsnZgBr7aQ
         FYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbKPtmJbRhRn3EAA719J/gFo3OO4cSK0EnKPpp4liAs=;
        b=HqKUk9tglRDlVBbFUZW+jnNqAhEZhCJ2qHsXP0aw6hgxnnG0T66T6lBfx2NbceUabE
         EVwF0xOURIneyWG9zURy+bdjHyG8dGQi8YsqFuygobTwuu+5RvdwwP7AC/VSS9JkY74/
         U2TfDvrzt0jY3ihLUpIfvVUUKuaAnc7TAZWPDfX6OBsSU9QKM06b4Tr4Wjl/Q4IchnCB
         pcT0d3aAIvXtj4RytltjdXUVyxbp9/bnSSlEmOvPdCW5yApNbY8Y6htF7+a6uwUhOiPB
         0a0UFxOKFGUKDzka2movUF2XJGooO5BJK7wF/as+fGHSMGEonPeXZllsEeorhXhecIyD
         0q6g==
X-Gm-Message-State: AOAM533Xmpua6iKWASEYHe5IUV2Yr/6o7LFNQfRjir5kaR+D2qJp+lq1
        9EAQLa5k3qtE3jnFUqS89oKeHhmeWaM=
X-Google-Smtp-Source: ABdhPJxWpPo6pQKy5JK50NIyX7ZPj4oY4NZz1YawG9saLqtl9bw4p+y+B2Een+dw1DJnNw56ulbuNw==
X-Received: by 2002:a1c:7317:0:b0:399:e654:3c92 with SMTP id d23-20020a1c7317000000b00399e6543c92mr4943140wmb.49.1654803091233;
        Thu, 09 Jun 2022 12:31:31 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c510600b0039748be12dbsm118136wms.47.2022.06.09.12.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:31:30 -0700 (PDT)
Date:   Thu, 9 Jun 2022 21:30:28 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220609193028.zhxpxscawnd3sep6@erthalion.local>
References: <20220609192936.23985-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609192936.23985-1-9erthalion6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, Jun 09, 2022 at 09:29:36PM +0200, Dmitrii Dolgov wrote:
>
> Enable specifying maxactive for fd based kretprobe. This will be useful
> for tracing tools like bcc and bpftrace (see for example discussion [1]).
> Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
>
> The original patch [2] seems to be fallen through the cracks and wasn't
> applied. I've merely rebased the work done by Song Liu and verififed it
> still works.
>
> [1]: https://github.com/iovisor/bpftrace/issues/835
> [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/

I've recently stumbled upon this seemingly lost topic, and wanted to raise it
again. Please let me know if there is a more appropriate way to do so.
