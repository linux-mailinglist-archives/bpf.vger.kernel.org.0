Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3894AE374
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357545AbiBHWWz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386375AbiBHURV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 15:17:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260EC0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 12:17:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ka4so888564ejc.11
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 12:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TtAytYXlXhoCerxANuo+bptVH42KGMVjXAnB1SfTXTQ=;
        b=ic0f4bcmI+JsSZ5CQFtmm6Rc8XqZSCAS4O3apzjn7g6Vijti2KAoDD4ymsPvXQip0a
         CxDV34HX72Xuae7i1CmEdRsHlv7s+dAiIRcD7pGdIvfZH90FFlXhxcRL4mN5uF9vijXg
         HoHH2QGxlE3QuRqSlfwed4T83YSw4wgrjn28J3rPFJ86xRIOp06PGrmvLo/mEZZt7YDj
         R5N4ahubymXWdp4MLtBMdj0ki2n0m9N7QbzHmuPM0Tn8ct7H8CeS6xNsUoXuzC9d2X7c
         j6oGoBNvFGfCYO/DKwITNHN4DUqFoHPS/y2hLnWSpEgwcZgUmyB4Ifa3vr/gCGSnF5oF
         PvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtAytYXlXhoCerxANuo+bptVH42KGMVjXAnB1SfTXTQ=;
        b=7rea/KRx4jkLbpX/UlnlbjXw9I4Z4kwDl1+h9vtVtFJb8N9WhNZZfAE+33Er1TTkPJ
         +iSS5mWJIdNuwGMtnsNTy/iIDAldctrDqhfG/xPxN+D6deS4sKTlg5Ej+8VsCV+fYvXJ
         qbcSSOwB4PRQDQAetV5AMjyvVUO/kps8V8CpdICjaeRnFHurXyoYgVlGkHn3oy2vFXxW
         TXmXkQaI3dmK/OC+Hm0OeR08mqmlu4CdWW8VXhky7wDux0hRopX7AnxaU9GClW/+QIVw
         HvRKprO8E6U1hqcnjgyvGR12dTL7xip0t6jdID3p5ZlIykNHcmqCrsKyaMHlPLfiPs8j
         4NvA==
X-Gm-Message-State: AOAM531RBIRBdD+57ZIj1yxbY90jEUZgjr4ZBZiuOIb5E+kMbJxqpAiO
        SnohKJz1CRbc8ScMlDzz5BQ=
X-Google-Smtp-Source: ABdhPJx250uW0PR8m9PO7ZFU7jZfmbY9C2FqMLDtX/wEOFZ0O+kgoafoWni7IA25e3X75LXdZ/N4FQ==
X-Received: by 2002:a17:906:478c:: with SMTP id cw12mr4957484ejc.214.1644351438920;
        Tue, 08 Feb 2022 12:17:18 -0800 (PST)
Received: from erthalion.local (dslb-178-012-046-224.178.012.pools.vodafone-ip.de. [178.12.46.224])
        by smtp.gmail.com with ESMTPSA id rp17sm3511023ejb.187.2022.02.08.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:17:18 -0800 (PST)
Date:   Tue, 8 Feb 2022 21:16:57 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
Message-ID: <20220208201657.esd2z7446ce5xj67@erthalion.local>
References: <20220204181146.8429-1-9erthalion6@gmail.com>
 <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
 <c81ddb7b-1eff-b5e8-a80b-ef0e8c3bc513@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81ddb7b-1eff-b5e8-a80b-ef0e8c3bc513@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Mon, Feb 07, 2022 at 09:46:36PM -0800, Yonghong Song wrote:
> > As an aside (and probably something more generally useful), it seems
> > like we have a bpf_iter__bpf_map iterator, but we don't have prog and
> > link iterators implemented. Would it be a good idea to add that to the
> > kernel? Yonghong, Alexei, any thoughts?
>
> We already have program iterator. We have discussed link iterators
> for sometime. As more and more usages for links, a link iterator
> should be good to improve performance compared to generic 'task/file'
> iterator.

Are those discussions about link iterators captured somewhere in the
mailing list, could you point me to them?
