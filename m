Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66A6E6E7F
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjDRVpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 17:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjDRVpO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 17:45:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E79ED2
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 14:44:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dm2so76911037ejc.8
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681854292; x=1684446292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2BRprCc94n88sHGcj6D3ukfLzfxNWCcGeBJ6ckrFC3A=;
        b=jAu5YMj4BfW/kwkWBzxbpet87yUhhOPACFRPtWT1HHUexYqnvrNWkOuy3A215FLrgR
         N6z0RhLtVNuZg2sql/rCUkjJQP1zQXucGC0j3IjVTdo+D0KdsvH3IrkAadID5fYpVZFR
         0SsjvKJtfY5z7ISzRYLlr6hNDUkuznYVSZ37f3d9rPplznPEvG3usUPhy2NvVmTdWRt6
         ooZBP5K2S1t4a9AWzxdAmu2kpC9GQX0Wjo+fb74nrttQNaUApWl+SOQI/c1oj6wHigC+
         BBZ00EekurbusuIZ68obEoiPwQEqaCKOZyGwjxZW5Spno3DoenEu6xTsiTIi2zvjiBwM
         5dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854292; x=1684446292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BRprCc94n88sHGcj6D3ukfLzfxNWCcGeBJ6ckrFC3A=;
        b=hPz65443i2w4H7EBiJg2lcZbkLyJ47DIXNrqZIkqs7SeZV/fER/MN1heg2iU4AgcBI
         F0aLTjWVjjHVlbh8O6wFFQk5sWX3xLRGK/3hsyJqE+dK9q+uTmP54i76LmXImp4hvIfx
         CahfFo9RkxOjcax03X9ExaH81x0EktjCD6ABBMk9580y1ti25Vek5W98SVD6pfvF4wBX
         kLO5ZcExe6HEpZAtkxC+NwZfbgSwCoEX7IvnHUC+AGupQryzeXF7NcUQs5NS1I0SzU4T
         vIaptMWrielW2cbvvHaMQWLgrsTyNt9XddghRcj+Bu3jnsh35Y0maEWlvgqUzgTDvWPY
         FhGA==
X-Gm-Message-State: AAQBX9fJg1FpZq+j8aL0gbO6e3fIHQPHOBm546yfjbdrfKUWbR61q1mQ
        8nz/ilK1VdaBq3/hPriF39ijrtu3Z5PPNlpEhmhNoRaDxjHmg18vlQI=
X-Google-Smtp-Source: AKy350ZTi18jO10mAmnfcNxVJQHXEwdTBP0oRAzIk+E4/1BL8zBGw/ty7YNVga30MwMKQDd3ujvaQiwEkfVLTHrvIXo=
X-Received: by 2002:a17:906:82c9:b0:92b:69cd:34c7 with SMTP id
 a9-20020a17090682c900b0092b69cd34c7mr14023037ejy.40.1681854292495; Tue, 18
 Apr 2023 14:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230418002917.519492-1-kuifeng@meta.com>
In-Reply-To: <20230418002917.519492-1-kuifeng@meta.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 18 Apr 2023 22:44:41 +0100
Message-ID: <CACdoK4+UAtYxncMBveNRgHvv0LW8zGiXfA-gtOqGat-Thsu3vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Show map IDs along with struct_ops links.
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 18 Apr 2023 at 01:29, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>
> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
> struct_ops to links. (226bc6ae6405) It would be helpful for users to
> know which map is associated with the link.
>
> The assumption was that every link is associated with a BPF program,
> but this does not hold true for struct_ops. It would be better to
> display map_id instead of prog_id for struct_ops links. However, some
> tools may rely on the old assumption and need a prog_id displayed in
> the link header line.  By keeping the prog_id unchanged, an extra line
> indicating the map_id is displayed.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks! What does the prog_id correspond to, for this type of links?
If it's not relevant at all we could at least take it out from the
plain output maybe, tools that want to parse the output should stick
to JSON.
