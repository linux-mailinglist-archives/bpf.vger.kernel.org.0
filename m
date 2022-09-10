Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D115B4440
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 07:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIJFb0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 01:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIJFbY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 01:31:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9A82FB9
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 22:31:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a70so5373758edf.10
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZmlhUBdqtKyrmVgGlpyIP2HCYpzOnzldfUJgGRge7YU=;
        b=fNjeyaRmnPOVV4Wg3/mpbDOBJScrD2p0aLtN2Xfks4h0QgIRkW/nifzGLUPIYEW4JG
         V+DPNQLKkyY19c0IM2FfgAF6h7fSzqp205WNKG+OILGlJdSXkgWOeMw2VTTztKorVF+Q
         UwO2IVOFNyK8zo7UrSIDfqlX2Rw1tk17w1tR/gjhu17y5HTHp54VcD8hkDwpN1idRM+z
         YqbCTBsdMgwZAcJb+Nq1NrhtXqa/Nz8R9DnyhPEK1KNHLwNzFkBh8ILpC0zBNax/jQ4W
         LZCih2GEI3xqzrnyLjuAn6j0LNtCuDzb2Kv8Ij+izB5cvL5a+DUCOyFYezmiV8IXbfSh
         28IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZmlhUBdqtKyrmVgGlpyIP2HCYpzOnzldfUJgGRge7YU=;
        b=apHpBd9FT/pQQ1jYQN/tCDgXbLa3qERaYR8GSoEIq1yG1Bh6mQDQTjZmc5vgf/gqvJ
         QeBfwycnaFJtUxMkv9EIIpQ4tXyFs6nV9blkvnQpEWx5uJvCkxAGxgk0WsLyQSWkM6uY
         WBr77hC7dnVk/VqjsGbUp8HYKmPhllxI5xI8mBqboHNuSDSRONQGM6dkJF7UpYL6DpRy
         G5LRUHj4LfgGwy+w72X86lRbEWWR+wqbi3yHkCcWxgjqsqHCPphuWH2vNcJfFGTm0QrA
         Vt2VV6AedX3kgObUIV90Wnw0/rqe98FRysXbOvUfFimoRD0cumM5BEZaOT+urLJdkljv
         7b7g==
X-Gm-Message-State: ACgBeo0608JgJzlbQ5mRuwivzEbkSsBcz9WXb7nifXQ8XcOTxYgkwZCO
        9q3mWZ7O6uQRJcaBPQ/X7nk=
X-Google-Smtp-Source: AA6agR5e5DCfZO+Ab5hFbp0HRJ8HaIpYW59DKtTCUJIfxje3aiuKBDsiW+XCyVlk4Fw5Z70F9rGwKQ==
X-Received: by 2002:a05:6402:1e92:b0:451:dcf:641d with SMTP id f18-20020a0564021e9200b004510dcf641dmr5001575edf.335.1662787881381;
        Fri, 09 Sep 2022 22:31:21 -0700 (PDT)
Received: from blondie ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090676ca00b0072ed9efc9dfsm1248956ejn.48.2022.09.09.22.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 22:31:20 -0700 (PDT)
Date:   Sat, 10 Sep 2022 08:31:18 +0300
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com,
        Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf: Add bpf_dynptr_clone
Message-ID: <20220910083118.6591eca8@blondie>
In-Reply-To: <CAJnrk1a53F=LLaU+gdmXGcZBBeUR-anALT3iO6pyHKiZpD0cNw@mail.gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
        <20220908000254.3079129-6-joannelkoong@gmail.com>
        <20220909194138.46aea4cb@blondie>
        <CAJnrk1a53F=LLaU+gdmXGcZBBeUR-anALT3iO6pyHKiZpD0cNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 9 Sep 2022 15:18:57 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> I like the idea, where 'off' is an offset from ptr's offset and 'len'
> is the number of bytes to trim.

Actually parameters better be 'from' (inclusive) and 'to' (exclusive),
similar to slicing in most languages. Specifying a negative 'to' provides
the trimming functionality.

> Btw, I will be traveling for the next ~6 weeks and won't have access
> to a computer, so v2 will be sometime after that.

Enjoy
