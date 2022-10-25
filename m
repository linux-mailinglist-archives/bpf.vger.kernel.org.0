Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6760D021
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiJYPRd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiJYPRd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:17:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0952BABD57;
        Tue, 25 Oct 2022 08:17:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy4so13387121ejc.5;
        Tue, 25 Oct 2022 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vd2yITRIwRjJ57r+/GB53Dxs4kpLZQ/80UnNHTKsgm8=;
        b=J5Sgbm9fO6CD6JRFgrkL2PVvtLSy6kmJwa+MRv5J8DD7HIGaWqWqrRMag0OfEpa5Sc
         EsRmSKzERhmryIB4GLFfOrxczdFPqiojnjEOof9fFSF4BSJ26j09hhAQN0poJjwzH5Ck
         Mh98zqO/TO9QV+XU7USHUR6A0tnrUvai+enCRKnethGtcVBtv3LwefeumPj/8QTpOXdq
         cloJ81csoqCfjEcsPLSjZ85ynSg1htpqOUl1yI1UBJwjGq0fyEhX9u9rMuBwp5TO9eWw
         ao2CEa65Nmjct9zmSyrBJNw/h+ZaXB31KdJzZbOqMI5R4+0T9kKo6GyGG13Vi9njqmJ5
         mGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vd2yITRIwRjJ57r+/GB53Dxs4kpLZQ/80UnNHTKsgm8=;
        b=wO1dodM9Sodd2nH57g10C301FgmVBfblPvtJtE5HjUu/Y1EUvzYgY9G5OKtEgkjRo/
         81eFpInbj1e29tfT0WEnNqtxo7A98c4kWTW8ORDrp7cAVtg1Mj4nDgWCUg4EfaWVscCC
         gMiUqFIB4KPZRT9th2UX59JrIfYUAx0Lw0AYFfQ9FNtinbxWvMW+HFzO2JqaMqFgNZSh
         YHfcPb1TN+a9wsFggXQbZM8OM4yLHx8xilb4vkYx2zT4xcb/JLWv62XUvnnh3syCTx3s
         3qi6HlXqGrqQWBg0EQMxOlULSUCBFfHViZLuL8x78UOYbcTvx9S+vbHD38h1x7xL2L0O
         nC4g==
X-Gm-Message-State: ACrzQf2FJ6DbtOB7oXI6hAWoSLUwoaVGgZJcNzZIJT+yzmkIwZTdxIzQ
        LNC1HQGfF+XVF874ygTb9bmsgQdUbi4HBKtk1m5/odIW
X-Google-Smtp-Source: AMsMyM768W05Pd5rupV3u+aVr0iDyaq5SUQnvBzSMJnanemnh6UOQLn8LIgHeAhLqZH50n9g+E21dkWCwe2hioEw4Rc=
X-Received: by 2002:a17:907:1c98:b0:78d:3b06:dc8f with SMTP id
 nb24-20020a1709071c9800b0078d3b06dc8fmr32266611ejc.58.1666711050382; Tue, 25
 Oct 2022 08:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221017094753.1564273-1-mtahhan@redhat.com> <20221017094753.1564273-2-mtahhan@redhat.com>
 <afc6d835-3988-0b4a-afd6-496f392324dd@redhat.com> <da45c2cb-72a0-066c-019e-c6f3f01c2093@redhat.com>
In-Reply-To: <da45c2cb-72a0-066c-019e-c6f3f01c2093@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Oct 2022 08:17:18 -0700
Message-ID: <CAADnVQKbURKUNPaTvCAq8hKprS7kmjU3=wUX4dTN4-THzrztug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] doc: DEVMAPs and XDP_REDIRECT
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Tue, Oct 25, 2022 at 2:06 AM Maryam Tahhan <mtahhan@redhat.com> wrote:
>
> On 24/10/2022 13:12, Jesper Dangaard Brouer wrote:
> >
> > First of all, I'm super happy that we are getting documentation added
> > for this.
> >
> > Comments inlined below.
> >
> > On 17/10/2022 11.47, mtahhan@redhat.com wrote:
> >> diff --git a/Documentation/bpf/redirect.rst
> >> b/Documentation/bpf/redirect.rst
> >> new file mode 100644
> >> index 000000000000..5a0377a67ff0
> >> --- /dev/null
> >> +++ b/Documentation/bpf/redirect.rst
> >
> > Naming the file 'redirect.rst' is that in anticipating that TC-BPF also
> > support invoking the bpf_redirect helper?
> >
> > IMHO we should remember to *also* promote TC-BPF redirect, and it would
> > likely be good to have this in same file with XDP-redirect so end-users
> > see this.
> >
>
> So I will leave the name as is...

Please fold it into xdp doc that describes all return codes.
It's weird to have a separate file just for one of the return values
and not for the others.
