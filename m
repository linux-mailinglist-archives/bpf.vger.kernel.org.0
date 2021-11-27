Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7C45FC3E
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 04:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbhK0DEK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 22:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhK0DCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 22:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBAC09B133;
        Fri, 26 Nov 2021 17:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEE4BB829B3;
        Sat, 27 Nov 2021 01:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E65C53FC9;
        Sat, 27 Nov 2021 01:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637977998;
        bh=pngvY9BmN7/mTvr7zxnHowe65NC+KzPQJX8BHpNymIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kuo80bvd8GcQTmOi6KcZ6W37cHytQz025Uk9jW0RyBHP2EgNci5ra7iIOST/d6AVA
         Hmqv772HvMRjv665YIpNHJhCzLYBX2hUcV+TGOQsziJcAX2SFm0cQLblMcra9x7/uG
         T8+JdlqbMa6u9hE84PGVBDUKYrDObjg03KAh8SHNcETzTugb5Ua8ynHXqQvSCy9EPp
         PZa8CzMEKZo2u3FpJIMI1iXKbdH0IT9SH7IXlMXqSrkasoYsc2OcJx5FdcccWBnV+s
         u6gqkIYwG/WA7yppN3hhO108j15XJ/mUr4ZwxhWK9lQVBsjM95S6ZTAlpyQmRGw5v8
         B4u0NTH8T4m+g==
Received: by mail-yb1-f182.google.com with SMTP id g17so24444430ybe.13;
        Fri, 26 Nov 2021 17:53:18 -0800 (PST)
X-Gm-Message-State: AOAM531sBISKXolKmZ3MAMQgM4m8Ijfk+5XUYww6K6ksRaFQQusB80q1
        1zv1HqgUB27qjoU3d07vamFewIV0CGeSBlNHaxI=
X-Google-Smtp-Source: ABdhPJx8JDPiOft5BZu0DjN7blNEA873efOWUHc1bP58SyR86fCSnlbM2C1c/u0ZPE3JLRerHlpmbzQ/TX3jgONq6Sk=
X-Received: by 2002:a25:69cc:: with SMTP id e195mr19853758ybc.456.1637977997463;
 Fri, 26 Nov 2021 17:53:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637682120.git.dave@dtucker.co.uk> <fb36291f5998c98faa1bd02ce282d940813c8efd.1637684071.git.dave@dtucker.co.uk>
In-Reply-To: <fb36291f5998c98faa1bd02ce282d940813c8efd.1637684071.git.dave@dtucker.co.uk>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 Nov 2021 17:53:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4jbVn2FQCDob2bUW1OTnG2P_Rqw-y5mKe9SmzezeF9gA@mail.gmail.com>
Message-ID: <CAPhsuW4jbVn2FQCDob2bUW1OTnG2P_Rqw-y5mKe9SmzezeF9gA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf, docs: add kernel version to map_cgroup_storage
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 8:24 AM Dave Tucker <dave@dtucker.co.uk> wrote:
>
> This adds the version at which this map became available to use in the
> documentation
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>

Acked-by: Song Liu <songliubraving@fb.com>
