Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8DA6D84EF
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjDER3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjDER3K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED465B2
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:28:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so142957576edc.3
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xje3cEiIE4kWuSR+tjpXzqV3Pu7fQXq+4bxfu4OPt1A=;
        b=dC0sKyTxabHc+Oin32GvaqIkKcu9Jto1Zp5gjDMAfW9DgwadJP+qsNnmDXqGVLO+o9
         Bys1FSWTq5uTPfFBTDYoo6t5bFAFAFC0OcF04Y4aK0mxxkcw33UaYEyk0yD88BSsBMGe
         TJvlhm2gRfPDyg2eF2g4ZkUtF2V7uBkZ4gER4qD6Umb9v4tlSwMwBMCY+xV7QeQLV5aE
         hfWXdPtqfhpZn7b8/fqjkyyj9C9MnXRa4VHYizjYnnZ0TN9/yU7qey8Xakax7tVbGkcw
         6cI1unjz+4esXu2ZKEiqZhSZe0WA4T8ZwViDrs9xT8sGthqyQOT6mNSb/sAHMRFPJ5JN
         5+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xje3cEiIE4kWuSR+tjpXzqV3Pu7fQXq+4bxfu4OPt1A=;
        b=UyrJckqIDw0GZDkkySfjaNIJtpVF78cxVIGFlYSj/4xDNP0LSANi9CwQksMFag0lA+
         Kg6eHH7kpNp/6KtIMbBlF/QHn4BwBjEZvzKc/Q/OethfSWP9296+SQrX3Dj+DHvIQ7Yo
         QmPLC7SpxnIaPzUU8IId0onMuc5pkrCnt7wREKREP8SMyHuIyThtAmA3WoRPgjJjyrDY
         AMRgd01WJmizkr0VEA1YUTLSQNMmPpZag9fF9tv2aaoQqAG0bsM62Tig0ow0eF+7YA6l
         pMJnngoiK+uQcDOGgK74bicvOU/4caSLiVeMBxzNZKcgR/KAUPsnYZnaH3RPu07HUknu
         sCWA==
X-Gm-Message-State: AAQBX9fmiKy4/yCrxM2WojhRT/XlsAp75LqE/XaLTnr3kPrWMuP+JPd6
        QhyvVuyBGjwK0D2NnqXjYXxOFttykVu1GThvJ1KKeEVYi/32v9MA+QhMbQ==
X-Google-Smtp-Source: AKy350adKOTosYW3BcBJdrg3C4bJeA0zVv0l9RlhjjkMkFyZz6vAL0vgp9VM7ggjDBZPZ7RhLd/0DuN/k8ocZt5B1+4=
X-Received: by 2002:a17:906:dcf:b0:932:6a2:ba19 with SMTP id
 p15-20020a1709060dcf00b0093206a2ba19mr1983579eji.14.1680715731874; Wed, 05
 Apr 2023 10:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-13-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-13-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:28:40 +0100
Message-ID: <CAN+4W8gtHrWt_XQBTSvkMxmeuLT4hcUtYMaFRdeZfKyJ_s2QJA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/19] bpf: add log_size_actual output field
 to return log contents size
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add output-only log_size_actual/btf_log_size_actual field to
> BPF_PROG_LOAD and BPF_BTF_LOAD commands, respectively. It will return
> the size of log buffer necessary to fit in all the log contents at
> specified log_level. This is very useful for BPF loader libraries like
> libbpf to be able to size log buffer correctly, but could be used by
> users directly, if necessary, as well.
>
> This patch plumbs all this through the code, taking into account actual
> bpf_attr size provided by user to determine if these new fields are
> expected by users. And if they are, set them from kernel on return.

Can we check that both fields are zero when entering the syscall?
