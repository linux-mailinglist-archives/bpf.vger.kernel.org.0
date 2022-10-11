Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3A5FAD1B
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJKG44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 02:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJKG4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 02:56:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB57814D3
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 23:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D284AB811F6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 06:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE72C433C1
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 06:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665471405;
        bh=l03l7G9r+ApNPs+hFq19dM7C4MYy+Pzo2M7sXTT8AnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dKPMaAKKTqzl3+jI0xwQaVoCSzQz7rgWBrBWoHi6AVXLhKnPjEmSjmefRAUv6kpVP
         YcKqU2h96aLkDTTS1GZCZA2mE6t6CkxnMega7eViXXxG1Dr3//Ec0OKu7+DofZSSFf
         VDj9TfTlqCjBaXxMEt0YYGAOHUMenCwB7Guel6z4p6ZgkTlsRKu1jTylYuHFD+w8yz
         sNym2QRrqVTIz3IM0Efp/FUOkdiWhQViYZIsD41hXYVlxgvHguGqMuXv1noB5YtvAL
         +79cz/YlW5PWhP7GvHEzp/wmErjDEk7TIswZjOmKfYS4QX+mfRnvcLNUeSf/bJXJ5U
         yRopZ95zTVyuw==
Received: by mail-ej1-f47.google.com with SMTP id r17so29284213eja.7
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 23:56:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf0PH4QAxxVRVoGEzbOYVx3PlvIF8VgfRWr0GZ9MvmVaMfWhJUR8
        uu6L8TPWernFTIe532QdcNy5b5EjZyz+gRTG2Rw=
X-Google-Smtp-Source: AMsMyM6vqxgKmvKyAHRO8RVhPtXq1FBJ8wqM0BoMooMNw1L1lLdjYfLOztJKrLF8Lo5mhx/gayluHU0PRbKj2Y6R3Ss=
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id
 jg11-20020a170907970b00b0078d8d70e4e8mr13657042ejc.614.1665471403779; Mon, 10
 Oct 2022 23:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-2-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-2-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Oct 2022 23:56:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4VrGxKXb-4AHKk72emOf8kRupEYYLaY0iWgkQv3HxCiQ@mail.gmail.com>
Message-ID: <CAPhsuW4VrGxKXb-4AHKk72emOf8kRupEYYLaY0iWgkQv3HxCiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/8] kallsyms: Make module_kallsyms_on_each_symbol
 generally available
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christoph Hellwig <hch@lst.de>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 2:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Making module_kallsyms_on_each_symbol generally available, so it
> can be used outside CONFIG_LIVEPATCH option in following changes.
>
> Rather than adding another ifdef option let's make the function
> generally available (when CONFIG_KALLSYMS and CONFIG_MODULES
> options are defined).
>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>
