Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE902620CDE
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiKHKIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 05:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiKHKIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 05:08:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF862BF9;
        Tue,  8 Nov 2022 02:08:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j15so20147268wrq.3;
        Tue, 08 Nov 2022 02:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2C6cKXTuh9PjHXXGu6GpQS6dNWhxcXl81NbxxvAbDTY=;
        b=JZ4YTkYYieN70wi7kRTlkDUD67fVAJGyGo9CutNyrgPKQ1lPcQNRvx4RT6Gd7JfLWN
         yHyy+LykKoezrLoy/gPdOQ9/Tc5saIB1nPF23ikrgqWiVeK52RzrpFhUxZUISvAReBVf
         Xr7jQW0QcKG2U7f6QqTq4aEp/n7DljWJtEsN9wXOUUJd1NK5A90Jzbyjreicy3+7k+ON
         8A4o7cWJI2ofW/pLPFq1/VJxRJcAyIcUlo+9F9nNgXiG3//o4corAIXUiCol2v9xbJAr
         m45CIrSrMRHwEVlitV/b1vY021caJnTFeY3K/akrHl0LJXvwvPc2SqrENorn0Ws3e9H0
         rzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C6cKXTuh9PjHXXGu6GpQS6dNWhxcXl81NbxxvAbDTY=;
        b=0O9ze3fbM408PbQBQ7ebGGePj3ItzZz9v4mYNdq4J/JEShqgKta+JVpZhMnCtImivt
         2ibZ9w2yj2WSCyrEZ2PgRHDpM60KTKHIYi6pJpInyMDOX/xyK5r0IDZJslsz31JGjINV
         6Gxb8uM/FtMIytHSA/fMYmhnrf5s61W59cuvBlze0bqZczrxhB+bVddZTj90awNvvr0/
         ToNzSwAuezwIm2rxuDBiHofEttBLm5/7EbCiXSto2FlTaHkNH3T7kxmtmQkPo6lum2id
         v/0mpncwgoxrFzs6ymygjE+v+Hv0GKUUDCyu3j/QxhM4rVrgLX2NT4pe3BBzlFOhMZ+M
         eTYg==
X-Gm-Message-State: ACrzQf0MUfbqrK4EDXQi5gDSetkC39Qlj8T430Ib2zfU/hCtXU+LnA6w
        RJD1WSv/S2tj48CLb+0x5DP6aRjkWuBgRw==
X-Google-Smtp-Source: AMsMyM69LAmvBj+4lYiWsMO1XctWn7rSmBiFG7vqIfAAh0RT+KiSgEjaB3Jp5Tfg9TC6F3tDhWq2Aw==
X-Received: by 2002:a05:6000:a11:b0:236:7685:e7 with SMTP id co17-20020a0560000a1100b00236768500e7mr36162245wrb.359.1667902114630;
        Tue, 08 Nov 2022 02:08:34 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:550:1196:18a3:8071])
        by smtp.gmail.com with ESMTPSA id k186-20020a1ca1c3000000b003cf4d99fd2asm10639611wme.6.2022.11.08.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 02:08:33 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v2] docs/bpf: Document BPF map types QUEUE and
 STACK
In-Reply-To: <976d046e-6b10-78bd-4c20-d23f81e5c907@meta.com> (Yonghong Song's
        message of "Mon, 7 Nov 2022 10:27:58 -0800")
Date:   Tue, 08 Nov 2022 09:20:36 +0000
Message-ID: <m2edudssyj.fsf@gmail.com>
References: <20221107150550.94855-1-donald.hunter@gmail.com>
        <976d046e-6b10-78bd-4c20-d23f81e5c907@meta.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@meta.com> writes:

> On 11/7/22 7:05 AM, Donald Hunter wrote:
[...]
>> +
>> +Userspace
>> +---------
>> +
>> +.. c:function::
>> +   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
>> +
>> +A userspace program can push ``value`` onto a queue or stack using libbpf's
>> +``bpf_map_update_elem`` function. The ``key`` parameter must be set to
>> +``NULL`` and ``flags`` must be set to ``BPF_ANY``. Returns ``0`` on
>> +success, or negative error in case of failure.
>
> Besides BPF_ANY, BPF_EXIST is allowed as well?

Good catch, thanks!
