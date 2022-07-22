Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2723E57E4E1
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGVQzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGVQzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:55:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9817D2656A
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:55:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m16so6530109edb.11
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmqYXZ5/tLmASJd3I3KP1TN9YLFPew9RCvmTBFxcxoU=;
        b=hFO2Pjvf+MmOkHqCDt+T/pFO52G2pDM2Z6vbrTZ5XMXRNr4ihShNtk+h6N3WJ2+5gu
         YMVIcj7z/RoKPBFeycTUYSEdlrvBUhSozZBKQnafYNZLeCj/Wtljd9KaxvOddsXFB+AL
         imyw7qzwI5S4QN25/tcPmHXpLgsJjISNwlprYMp3vUcHH5ssQHxvLEm+b4vunj5XeEv7
         z4nEKL0vct2YjA0qTW9DkxruSFeCPpgJycJSsbRQLdBaCreH2T7jO/3cVDLXbdmFzzzz
         jNhy8ThhYGMk0shJu0dookCbl1n0bybAUP6XmN/ulscWDD4svQlHBzSJamlSL/aaHZzZ
         8jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmqYXZ5/tLmASJd3I3KP1TN9YLFPew9RCvmTBFxcxoU=;
        b=iSMKtegZcFJeSr80kKQBH/55pc2lQcs80XtmC7MGiznxZcKwaCX3yXRLDZCRSSoFg+
         NPLqKa/FZ53X1w4n/m4S5zY+HUu3c9ekT5aHwKpWHyQ/Y+6czLWypNvg9aZfrYodjwuA
         nd+MVN1szUi3lvFafP4XIiPp5YTv5Mwof3L3CX8b7QHXP1Xdlf1vMahNvh8LiCzNZjDc
         BUNVJuy9/H/YPPndQCXAZKI2Ymmxy1xhdhUjoVek0enkSeVkTWIdI+NPgzuIJvqrghXB
         6g7Q5c5nS1M4nxC6ld7cguUW+U7sYT4bd9PzdczOCrfFQaclkmWIpXnK2VPiXlFk6OZ0
         ag8Q==
X-Gm-Message-State: AJIora+pziCfRSRCG3Wvjz5jUfFhaWFeGujh3iSe/mfpq76MWHttS3cH
        3eCRRSnwnLXRNOz/VhuLGKIs5Ysq6CAouKXa3IY=
X-Google-Smtp-Source: AGRyM1vjy5LONYN7Fz+sQghExkBptorUVdI4LZbNpLDVPDMnNJlXGXac8apYqdepnceiV56mTZ0xy6VPt0/P1fHN2No=
X-Received: by 2002:aa7:c9d3:0:b0:43a:67b9:6eea with SMTP id
 i19-20020aa7c9d3000000b0043a67b96eeamr815881edt.94.1658508902206; Fri, 22 Jul
 2022 09:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220722110811.124515-1-jolsa@kernel.org> <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home> <YtrPocs1X7fKitfE@krava> <20220722123743.4060f40e@gandalf.local.home>
In-Reply-To: <20220722123743.4060f40e@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Jul 2022 09:54:50 -0700
Message-ID: <CAADnVQLMY9Gbipx6Tc4dsRN3YSXo2CF8T=KwAvjU7nRDjYxRgQ@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Fri, Jul 22, 2022 at 9:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 22 Jul 2022 18:26:09 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > > So, why not mark it as notrace? That will prevent ftrace from looking at it.
> >
> > there's still needs to be the instrument jump generated
> > in order to use bpf_arch_text_poke on that
>
> Can you explain the background on this. Why is bpf doing text_poke on
> function entries? What was the direct use case for?

It's a bpf specific dispatcher.
Like static_call but more dynamic and for bpf progs.
