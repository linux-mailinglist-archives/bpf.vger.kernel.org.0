Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41AD546D17
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 21:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbiFJTQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 15:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJTQM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 15:16:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12BBF7E
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:16:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 20so4762460lfz.8
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AwH7cWH8CRbU3S3asji2KJakuCBfz0S9BYpqSFK7hLk=;
        b=MSapt3v0gS/8z2itHc8B5fk31XYAW0+WoinaB0vGnZOf6bUv/DXAmUkqrPWuLt+ejY
         dINwAUaFUmTNCtx747bg7dA7hfKcBBBiJvQD6nyakk0kOw13MWojxsThuIhEZOy88WaW
         BleacvS+pqrDNOmohit6bBGVRbNcBAqP80F/ClGqJACkhv6HrL1n3UJCBki/Ordbz0fw
         ehA9ycLSIC6hSr2jUsQDpUOzvfLRN7JBqORiC3pbi7R3+IYTajzXX68Ir9UoIZZ2Z2LQ
         6jNJAy+BKHZ4Hlxmz3TLNO2ZoBvgwotORHF3TqasMnE/++/F4t7MygzYLoykOiq06VbY
         aHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AwH7cWH8CRbU3S3asji2KJakuCBfz0S9BYpqSFK7hLk=;
        b=iGmuYSTufOTW2GbxGarYRX+5sey4g8YxX4e/rI+xcRDehRnpP+/b1acbLqbcz6R1so
         LN8Cy8VMo2EWs0t74tONcsNZpzFg1X8KdLxYrLC8wdT4A2NyZPEt7nj6CalGdygxgjCg
         xFwT5h0t2B40fnJ5wDLfzPmVn2Z1E1LxTkSutHhE+Pb9JZeqMD+zlSJ6XyJUcly9VwOl
         FC7au8RW6gIL2lvveVZ2cq97eanmx9b/FLfW2dPt7/NVW7jlLzCdL2y4VrfJR7bcjjB9
         bzwBKlGIELPNEV6Tc9jGIwXH3MagoC6pzVg7gdacjUb1rwMXnK9t/PaC6HHbjYPrQ8G6
         qBUw==
X-Gm-Message-State: AOAM531ju8MjFnKJERYM7YaXjwHVlZ0tn8tgiU3OH+Or3Tj27r/SLVxG
        7Xae+uVdimd2tYrKJXDsmWk=
X-Google-Smtp-Source: ABdhPJxeWBM4sfQtAbnRF3/4kowTFh1SwFaF/AhWxejJ6VHrkuRC5Y9R/iIVG7fRlGgRkSVNQGn7zw==
X-Received: by 2002:a05:6512:a90:b0:478:f288:f1b5 with SMTP id m16-20020a0565120a9000b00478f288f1b5mr27648922lfu.614.1654888567817;
        Fri, 10 Jun 2022 12:16:07 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e8e2a000000b0024f3d1daee3sm28434ljk.107.2022.06.10.12.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:16:07 -0700 (PDT)
Message-ID: <d28e28eafdd3f62160aa01f21d75b5c6581aaac2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] selftests/bpf: allow BTF specs and func
 infos in test_verifier tests
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Date:   Fri, 10 Jun 2022 22:16:05 +0300
In-Reply-To: <CAPhsuW4+BVYjodLT2tH3emqXzZxv1D7c3Tu5YuYtpB-1Vwtn5w@mail.gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
         <20220608192630.3710333-3-eddyz87@gmail.com>
         <CAPhsuW4+BVYjodLT2tH3emqXzZxv1D7c3Tu5YuYtpB-1Vwtn5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Fri, 2022-06-10 at 11:09 -0700, Song Liu wrote:

> > +static int load_btf_for_test(struct bpf_test *test)
> > +{
> > +       int types_num = 0;
> > +
> > +       while (types_num < MAX_BTF_TYPES &&
> > +              test->btf_types[types_num] != BTF_END_RAW)
> > +               ++types_num;
> > +
> > +       int types_len = types_num * sizeof(test->btf_types[0]);
> > +
> > +       return load_btf_spec(test->btf_types, types_len,
> > +                            test->btf_strings, sizeof(test->btf_strings));
> 
> IIUC, strings_len is always 256. Is this expected?

Yes, as long as strings are zero terminated the actual buffer size
shouldn't matter. So I decided that it would be better to avoid
strings length specification in the test definition to keep things
simpler.

Thanks,
Eduard

