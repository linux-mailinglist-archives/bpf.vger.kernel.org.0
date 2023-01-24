Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC8679B53
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjAXOQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjAXOP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:15:56 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23184859E;
        Tue, 24 Jan 2023 06:15:53 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id o5so13090108qtr.11;
        Tue, 24 Jan 2023 06:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtD6aqaqq9Ub+d/Pdc6Gz9vpIQhjd9TFLmn9xXKc1Dw=;
        b=fqJnvQKEN0stiZSsa9FIN9dOD+OQ0izwueDc4/zgq32CNoooJLP4YvshGUWBucbFIL
         jTDCs3pGq+wFWSnC+LU+0K8SnGhbu4enrju0sdEevrXROsq6hombsjtA+Oca3RMOi5mV
         sk1tWBljOvPvMlD0bPDvCRNJChbmNGMZFr6PZfspMJgAS9uotgR75RLejO45IABl37ds
         xSS7tVNNreqDmymyE6FTCZp3uiEZpGOpcUNo337LFA58yCfT4teRQxoAxFLgyuLt144G
         RfQNUcJ0dLFbOa3HWTQUo/qx7yoYC1WV9iE+aqN4x+AvbWi6DX/jWMPiBruF4VbbwY7U
         K8Eg==
X-Gm-Message-State: AFqh2krHzrdeMNNtHyK08qnVvBcc+rPYOigC3RR8Ucj0Cgx+9hm1DOEm
        00O45jR2M+gbKgc8E0Sc+Uo=
X-Google-Smtp-Source: AMrXdXtPgrpktBwfMg3EzCMV2kfiG1IXFprFe+Y+q4NJ6xQkx61WogHyhKZBzwzl4R3yNJND3Xdhhw==
X-Received: by 2002:ac8:5a95:0:b0:3b2:39ee:dcf3 with SMTP id c21-20020ac85a95000000b003b239eedcf3mr55855991qtc.25.1674569752773;
        Tue, 24 Jan 2023 06:15:52 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id g18-20020ac87752000000b003b7ea583c7csm1294495qtu.58.2023.01.24.06.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:15:52 -0800 (PST)
Date:   Tue, 24 Jan 2023 08:15:52 -0600
From:   David Vernet <void@manifault.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <Y8/oGIEjibbbNaE2@maniforge.lan>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <Y8+FeH7rz8jDTubt@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8+FeH7rz8jDTubt@infradead.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 11:15:04PM -0800, Christoph Hellwig wrote:
> I don't think this is the way to go.  For one the syntax looks odd,
> and for another count we had a rough agreement at the kernel summit
> to make BPF kfuncs look more like export symbols.
> 
> So can you please try to instad make this a EXPORT_SYMBOL_BPF that
> looks and feels more like EXPORT_SYMBOL instead?

Yeah, that matches what others (Daniel and Jon) have suggested in
another thread. I'll echo what I said in [0], which is essentially that
I agree with you all that something which more closely resembles
EXPORT_SYMBOL* is a better approach, and am fine with tabling this for
now until I have a bit more bandwidth to work on something that's a more
complete / appropriate solution.

[0]: https://lore.kernel.org/all/Y88sMlmrq0wCFSRP@maniforge.lan/

Thanks for the review! Will CC you on the v3, whenever that is.

- David
