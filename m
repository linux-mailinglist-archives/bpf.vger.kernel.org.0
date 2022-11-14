Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026C628B6F
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiKNVkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiKNVka (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:40:30 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3F65D5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:40:27 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id e15so8636852qvo.4
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kayPu/Xe8MEBnYoJ/NVFIazBt3XonVpuJXHoo0b8/lo=;
        b=2hpzpZ/ujK+MtFFvDg1caEdRsighbhIxebZagZNc/1cC+n52F48VbjCEZ/F2/x9Uk+
         CTGygJnNX8c4pH41/rxeNA5cHrfCTC3c3kY9HK7Lf5SR1BxpezgywnMZprW8cMzqQ4q4
         qwTZ3UiCNhSjEu1vACxzxnifdSRuFI/8S4/YSxVALqZB3Q/XLeEm1FscPTsabGpMBD9A
         FLoyNXk0xDJroS/UfS+wcFcDo90z4BsyffO8diuMYYQHlDUW+Da225ruFLnYNu37WoZA
         QQc+29Em6m+AfAl/tlpLfruTk3HOVO+y/5HzOW1hhUb7G5VnYfZ0peGir6yKKfLbExn0
         AqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kayPu/Xe8MEBnYoJ/NVFIazBt3XonVpuJXHoo0b8/lo=;
        b=H2+Ts5ssQ6FSIGaGN8OmllE1toqRFyyE+Zj3xtdhjoqvJFeKo5cFX+rTrIXH117S3V
         2QKBbeOAyaheFU4HRrj4EZ93XKTNlJxmPUGhbMqA77AaCtXfcfSiLDNHyXk/2l7GtmL8
         Uh8Z/JnEBpElOVGL/DmNkHD0wSK9MxiL7ifXaFG+I0XLqG0dxrQ3tAn7PRyX01iLd3DQ
         w/oNnkXWUUyb85pkycxAwUBHivcjtefl69i5aLcteIQOTyTp+SQmZSU+D3JxaXlL0GX1
         jqykGM6WlFNqSF7lbdrpQuKrKSvL0p/fgM+MEuDytOC3/MC3ZpPvgHuwBasDN8QVzNi+
         coQw==
X-Gm-Message-State: ANoB5pkPCkoD0GfBYUtzOVkltxuLAiugE2+WcQNTMNv3abm8NJMPr2A+
        t9gH0Lz+fVWDtF3keZJ0wMUVQzkCzNQuQjOhXAo6JA==
X-Google-Smtp-Source: AA0mqf5AGOse0VR5GJ0Up4XuJz2ZReI5NnqBHGxVzg5LZ31q2nQTKUfKghhUrhqbdNpsmQG3i3sampKriUo8IHWGnX4=
X-Received: by 2002:ad4:4dc9:0:b0:4ba:8938:7d18 with SMTP id
 cw9-20020ad44dc9000000b004ba89387d18mr14474850qvb.54.1668462026592; Mon, 14
 Nov 2022 13:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20221113101438.30910-1-sahid.ferdjaoui@industrialdiscipline.com> <20221113101438.30910-2-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221113101438.30910-2-sahid.ferdjaoui@industrialdiscipline.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 14 Nov 2022 21:40:15 +0000
Message-ID: <CACdoK4KFB3bj_dDGnOhYEqSmZEgaD2Dt8z+0bFBiE5azQvYRMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpftool: remove support of --legacy
 option for bpftool
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 13 Nov 2022 at 10:15, Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> Following:
>   commit bd054102a8c7 ("libbpf: enforce strict libbpf 1.0 behaviors")
>   commit 93b8952d223a ("libbpf: deprecate legacy BPF map definitions")
>
> The --legacy option is no longer relevant as libbpf no longer supports
> it. libbpf_set_strict_mode() is a no-op operation.
>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> Acked-by: Yonghong Song <yhs@fb.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
