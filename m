Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1607266CB51
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 18:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjAPRNG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 12:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAPRMX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 12:12:23 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EFD4B18C;
        Mon, 16 Jan 2023 08:52:37 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v19so25037505ybv.1;
        Mon, 16 Jan 2023 08:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFQLhHdyrqER0kuXd0vq345qeGKM+r6w6javqYC8UmQ=;
        b=d2rUgQbwHKmf/RQEz+VVQ7UlN/uijYES7Ka4btbq9t4Q2qnz4jO3SkV+o8s9gCrT73
         GLjk8mOwi5Shsc8L/T8ESuss/uDRwrISTxKuPtO1CPG43dNSVsTIgQPKeTeqWSN4Q6wq
         Brf2TSdEgLf5h45T/NSzQlKxadJD+MOuL5btjb5jbPZqO41sK2rdiNPzDBMqnZHGm7mT
         TGp2Ru2Etm3efi2RgNLPc4RVFPWI7/zDVXeOFvUvfyB58RiEq2UNxxxXS0CAN3mTrZVx
         nsN9iG13YTLM9I3gM/peAUqVoJ5rfG2Hzm7sw9MwhRrrB5gNMZr2eZZKsrmITL3JufLN
         jwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFQLhHdyrqER0kuXd0vq345qeGKM+r6w6javqYC8UmQ=;
        b=VWkwtSlbO3SWmdvxJL9r99pGlVdCN8Ad7/tW3jX09HImB6kQt3q1L4qJ8xJz1dJ68o
         f2JO0u6Y+4zRkPnftZpOZzjnc4uEfvvgZlqSa2/U6M8l+14OAsy1uyTPR4EZskXl8yWy
         769ypnXz2NCnVevdR0v34N3Ooi+qmipTLRLkRgGk/ZIRVHPmcBXvUMld+ji5xoev1nA/
         MSD+ybUMi0rYDl85HpGuM/uFEFHXEvmcCnShk0lsX/n9xtxS1OeQnrnA4W8cRTL9hifc
         o3IGJXpvjy+RUOS8+pAd5olaJQPZjpu7zqoYI7entN1J2NNvOAWEp8xjUjXdlu3DhVQ9
         c5uw==
X-Gm-Message-State: AFqh2kqf+f0yiv13rEh6+XbC700ifmY6lSABS+I/gQcim54UlWprwjtQ
        v2SW4ZVa9KDQMVVc3bz3DpZaYqdn/RYey/ZV8oct4RohGVjcPOCx
X-Google-Smtp-Source: AMrXdXs/yfZTGypDLxLmHNaoAX4jgSfGiwQGCB5/9lYDiWzzkMgSVbdwwlGLCJBT6Oq5AJ8/fegAya9BzRAll0CO+X8=
X-Received: by 2002:a25:cf87:0:b0:7cb:dfbe:3996 with SMTP id
 f129-20020a25cf87000000b007cbdfbe3996mr40668ybg.489.1673887956871; Mon, 16
 Jan 2023 08:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com> <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
In-Reply-To: <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Jan 2023 17:52:25 +0100
Message-ID: <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, Eric Curtin <ecurtin@redhat.com>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 5:37 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> I presume Miguel will pick this up via rust tree? (Either way, would be nice to
> also get an Ack from Arnaldo.)

I am happy to, but I think it would be great if BPF takes it whenever
you think it is a good time. And indeed, let's give time to Arnaldo to
take a look.

Cheers,
Miguel
