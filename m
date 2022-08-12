Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38243590983
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 02:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiHLAUK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 20:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiHLAUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 20:20:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EFFA032A
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 17:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40430B82339
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 00:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3369C433D7
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660263605;
        bh=VcBgOx72SrKAynvtEB4eJUbvGpRlwEh9BrnfUqJELdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h24mYW6Smp0tPJ6xgXWsTD3QXIw7kPqDPwYkneA3hzQRvVvbze5cozomfYkvGy6zQ
         BJDYVZqE2/260gOit/wJe3u2/iSRkTBZdyjo/vRY7lszHpivQm0tNkJASUwN/DAkUr
         c2eJU1S753riEYBeuFQrUGPT5/Ml18B/RQc3Ys3ueKE9bpZ8PWy97M4ZoQL3w+97pc
         qE1Ot/2HpT8UgITsXfghDJ9u4gO9ZC2kXNmhI3ljxtHGCfIkPtzxfTgFsDZKjrTTz7
         bTltCa6Gu7vg8Z8d2nyIbUPfERtmHA6398Q8YAQUj6ZFG4TfV7UtXKWktmo+p/6TJR
         uG86TM+qvHkug==
Received: by mail-ot1-f46.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so7254627otd.12
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 17:20:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo3OzLfhClY/NZ8HFv6MDpmu8FTtN9/WS5A4oHZX2TM/fg3z3tRA
        Wgj+tw1dc586PtPyPgfzExj3YRMIV3uFRQDfib3otg==
X-Google-Smtp-Source: AA6agR6dgH9Z0J57ZbSVmYT07RMNRaN2A8XBE58y1N2O6lsg+5CWO9rMzDJgZiq9KCWy3gOsBt3vlp+7vnloPLKLXnU=
X-Received: by 2002:a0d:d282:0:b0:329:74d3:b0da with SMTP id
 u124-20020a0dd282000000b0032974d3b0damr1809994ywd.340.1660263594446; Thu, 11
 Aug 2022 17:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220810165932.2143413-1-roberto.sassu@huawei.com> <20220810165932.2143413-5-roberto.sassu@huawei.com>
In-Reply-To: <20220810165932.2143413-5-roberto.sassu@huawei.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 12 Aug 2022 02:19:43 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6YC_rkX-DFt28_cbSFU23LV4sqq0PL5F6a=NL8GCRdQQ@mail.gmail.com>
Message-ID: <CACYkzJ6YC_rkX-DFt28_cbSFU23LV4sqq0PL5F6a=NL8GCRdQQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, corbet@lwn.net, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 6:59 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
> kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
> validate the kfunc parameters.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: KP Singh <kpsingh@kernel.org>
